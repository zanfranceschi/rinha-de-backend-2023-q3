package main

import (
	"context"
	"log"
	"net/http"
)

type Server struct {
	Port       string `json:"port"`
	httpServer *http.Server
	mux        *http.ServeMux
	store      Store
}

func (s *Server) Stop() error {
	return s.httpServer.Shutdown(context.Background())
}

func (s *Server) Start() error {
	mux := http.NewServeMux()

	s.mux = mux

	mux.Handle("/pessoas", &PeopleHandler{store: s.store})
	mux.Handle("/pessoas/", &PeopleHandler{store: s.store})

	s.httpServer = &http.Server{
		Addr:    ":" + s.Port,
		Handler: mux,
	}

	log.Println("Server listening on port", s.Port)

	return s.httpServer.ListenAndServe()
}

func New(store Store, port string) *Server {
	return &Server{
		Port:  port,
		store: store,
	}
}
