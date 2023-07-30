package main

import (
	"time"
)

type Person struct {
	ID        int       `json:"id"`
	Name      string    `json:"name"`
	Nickname  string    `json:"nickname"`
	Birthdate time.Time `json:"birthdate"`
	Stack     []string  `json:"stack"`
	CreatedAt time.Time `json:"-"`
}

type People []*Person
