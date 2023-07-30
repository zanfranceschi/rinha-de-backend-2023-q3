package main

import (
	"errors"
)

type GetPeopleOptions struct {
	PaginationToken string
	SearchQuery     string
}

type Store interface {
	AddPerson(Person) (int64, error)
	GetPeople(options *GetPeopleOptions) (People, error)
	GetPerson(string) (*Person, error)
}

var (
	ErrPersonNotFound = errors.New("Person not found")
)
