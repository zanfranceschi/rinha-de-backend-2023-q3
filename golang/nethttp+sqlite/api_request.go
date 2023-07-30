package main

import (
	"errors"
	"strings"
)

type AddPersonRequest struct {
	Name      string   `json:"nome"`
	Nickname  string   `json:"apelido"`
	Birthdate string   `json:"data_nascimento"`
	Stack     []string `json:"stack"`
}

var (
	ErrInvalidName      = errors.New("Nome inválido")
	ErrInvalidNickname  = errors.New("Apelido inválido")
	ErrInvalidBirthdate = errors.New("Data de nascimento inválida")
	ErrInvalidStack     = errors.New("Stack inválida")
)

func (r *AddPersonRequest) Validate() error {
	if r.Name == "" || len(r.Name) > 32 {
		return ErrInvalidName
	}

	// nickname must contain only letters and spaces
	if r.Nickname == "" || len(r.Nickname) > 75 || strings.ContainsAny(r.Nickname, "0123456789!@#$%¨&*()_+{}^~:<>?/|\\") {
		return ErrInvalidNickname
	}

	// birthdate must be in the format YYYY-MM-DD
	if r.Birthdate == "" {
		return ErrInvalidBirthdate
	}

	if r.Stack != nil {
		for _, stack := range r.Stack {
			if len(stack) > 10 {
				return ErrInvalidStack
			}
		}
	}

	return nil

}
