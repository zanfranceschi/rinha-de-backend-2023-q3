package main

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"strings"
	"time"
)

type PeopleHandler struct {
	store Store
}

func (h *PeopleHandler) AddPerson(w http.ResponseWriter, r *http.Request) {
	var request AddPersonRequest

	err := json.NewDecoder(r.Body).Decode(&request)

	if err != nil {
		w.WriteHeader(http.StatusUnprocessableEntity)
		log.Println(err)
		errorResponse := ErrorResponse{Error: err.Error()}
		_ = json.NewEncoder(w).Encode(errorResponse)

		return
	}

	birthdate, err := time.Parse("2006-01-02", request.Birthdate)

	if err != nil {
		w.WriteHeader(http.StatusUnprocessableEntity)
		log.Println(err)
		errorResponse := ErrorResponse{Error: ErrInvalidBirthdate.Error()}
		_ = json.NewEncoder(w).Encode(errorResponse)
		return
	}

	err = request.Validate()

	if err != nil {
		w.WriteHeader(http.StatusUnprocessableEntity)
		log.Println(err)
		errorResponse := ErrorResponse{Error: err.Error()}
		_ = json.NewEncoder(w).Encode(errorResponse)
		return
	}

	person := Person{
		Name:      request.Name,
		Nickname:  request.Nickname,
		Birthdate: birthdate,
		Stack:     request.Stack,
	}

	personID, err := h.store.AddPerson(person)

	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		log.Println(err)
		return
	}

	w.Header().Set("Location", fmt.Sprintf("/pessoas/%v", personID))

	w.WriteHeader(http.StatusCreated)
	_, _ = w.Write([]byte(fmt.Sprintf(`{"id":%v}`, personID)))
}

func (h *PeopleHandler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	if r.Method == http.MethodPost {
		h.AddPerson(w, r)
	} else if r.Method == http.MethodGet {
		// if path contains id, get person
		pathChunks := strings.Split(r.URL.Path, "/")
		if len(pathChunks) > 2 && pathChunks[2] != "" {
			personID := pathChunks[2]
			h.GetPerson(w, r, personID)
			return
		}
		h.GetPeople(w, r)
	} else {
		w.WriteHeader(http.StatusMethodNotAllowed)
	}

}

func generate_pagination_token(people People) string {
	if len(people) == 0 {
		return ""
	}

	lastPerson := people[len(people)-1]

	return fmt.Sprintf("%v-%v", lastPerson.ID, lastPerson.CreatedAt.Unix())
}

func (h *PeopleHandler) GetPeople(w http.ResponseWriter, r *http.Request) {

	options := &GetPeopleOptions{
		PaginationToken: r.URL.Query().Get("pagina"),
		SearchQuery:     r.URL.Query().Get("q"),
	}

	people, err := h.store.GetPeople(options)

	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		log.Println(err)
		return
	}

	response := GetPeopleResponse{Resultados: people}

	if r.URL.Query().Get("pagina") != "" {
    prevUrl := *r.URL
    queryValues := prevUrl.Query()
    
    paginationStack := queryValues.Get("paginationStack")

    if paginationStack != "" {
      previousPaginationToken := strings.Split(paginationStack, ",")
      queryValues.Set("pagina", previousPaginationToken[len(previousPaginationToken)-1])
      queryValues.Set("paginationStack", strings.Join(previousPaginationToken[:len(previousPaginationToken)-1],","))
      if len(previousPaginationToken)-1 == 0 {
        queryValues.Del("paginationStack")
      }
    } else {
      queryValues.Del("pagina")
    }

    prevUrl.RawQuery = queryValues.Encode()

		anterior := "http://" + r.Host +prevUrl.String()
		response.Anterior = &anterior
	}

	if len(people) == 5 {
    nextUrl := *r.URL
		queryValues := nextUrl.Query()

		if r.URL.Query().Get("pagina") != "" {
      if queryValues.Get("paginationStack") == "" {
			  queryValues.Set("paginationStack", r.URL.Query().Get("pagina"))
      } else {
			  queryValues.Add("paginationStack", r.URL.Query().Get("pagina"))
		  }
    }

		queryValues.Set("pagina", generate_pagination_token(people))
		nextUrl.RawQuery = queryValues.Encode()
		proxima := "http://" + r.Host + nextUrl.String()
		response.Proxima = &proxima
	}

	err = json.NewEncoder(w).Encode(response)

	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		log.Println(err)
		return
	}

}

func (h *PeopleHandler) GetPerson(w http.ResponseWriter, r *http.Request, id string) {
	person, err := h.store.GetPerson(id)

	if err != nil {
		if err == ErrPersonNotFound {
			w.WriteHeader(http.StatusNotFound)
			return
		}
		w.WriteHeader(http.StatusInternalServerError)
		log.Println(err)
		return
	}

	err = json.NewEncoder(w).Encode(person)

	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		log.Println(err)
		return
	}

}
