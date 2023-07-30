package main

type ErrorResponse struct {
	Error string `json:"error"`
}

type GetPeopleResponse struct {
	Qtd        int     `json:"qtd"`
	Pagina     int     `json:"pagina"`
	Anterior   *string `json:"anterior"`
	Proxima    *string `json:"proxima"`
	Resultados People  `json:"resultados"`
}
