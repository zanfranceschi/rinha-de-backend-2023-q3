package main

import (
	"bytes"
	"encoding/json"
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/stretchr/testify/suite"
)

type APITestSuite struct {
	suite.Suite
	handler *PeopleHandler
}

func (s *APITestSuite) SetupSuite() {
	store, err := NewSQLiteStore()
	s.Require().NoError(err)

	s.handler = &PeopleHandler{store: store}
}

func (s *APITestSuite) TestAddPerson() {
	request := AddPersonRequest{
		Name:      "John Doe",
		Nickname:  "johndoe",
		Birthdate: "1990-01-01",
		Stack:     []string{"Go", "Python"},
	}

	jsonRequest, _ := json.Marshal(request)

	req, err := http.NewRequest("POST", "/pessoas", bytes.NewReader(jsonRequest))

	if err != nil {
		s.Require().NoError(err)
	}

	recorder := httptest.NewRecorder()

	s.handler.ServeHTTP(recorder, req)

	s.Equal(http.StatusCreated, recorder.Code)
}

func (s *APITestSuite) TestAddPersonInvalidBirthdate() {
	request := AddPersonRequest{
		Name:      "John Doe",
		Nickname:  "johndoe",
		Birthdate: "1990-01-01 00:00:00",
		Stack:     []string{"Go", "Python"},
	}

	jsonRequest, _ := json.Marshal(request)

	req, err := http.NewRequest("POST", "/pessoas", bytes.NewReader(jsonRequest))

	if err != nil {
		s.Require().NoError(err)
	}

	recorder := httptest.NewRecorder()

	s.handler.ServeHTTP(recorder, req)

	s.Equal(http.StatusUnprocessableEntity, recorder.Code)
}

func (s *APITestSuite) TestAddPersonInvalidStack() {
	request := AddPersonRequest{
		Name:      "João Ninguém",
		Nickname:  "johndoe",
		Birthdate: "1990-01-01",
		Stack:     []string{"Go", "Python", "C++", "Java", "C#", "Javascript/TypeScript"},
	}

	jsonRequest, _ := json.Marshal(request)

	req, err := http.NewRequest("POST", "/pessoas", bytes.NewReader(jsonRequest))

	if err != nil {
		s.Require().NoError(err)
	}

	recorder := httptest.NewRecorder()

	s.handler.ServeHTTP(recorder, req)

	s.Equal(http.StatusUnprocessableEntity, recorder.Code)
}

func (s *APITestSuite) TestGetPerson() {
	request := AddPersonRequest{
		Name:      "John Doe",
		Nickname:  "johndoe",
		Birthdate: "1990-01-01",
		Stack:     []string{"Go", "Python"},
	}

	jsonRequest, _ := json.Marshal(request)

	req, err := http.NewRequest("POST", "/pessoas", bytes.NewReader(jsonRequest))

	if err != nil {
		s.Require().NoError(err)
	}

	recorder := httptest.NewRecorder()

	s.handler.ServeHTTP(recorder, req)

	s.Equal(http.StatusCreated, recorder.Code)

	req, err = http.NewRequest("GET", recorder.Header().Get("Location"), nil)

	if err != nil {
		s.Require().NoError(err)
	}

	recorder = httptest.NewRecorder()

	s.handler.ServeHTTP(recorder, req)

	s.Equal(http.StatusOK, recorder.Code)
}

func TestAPI(t *testing.T) {
	suite.Run(t, new(APITestSuite))
}
