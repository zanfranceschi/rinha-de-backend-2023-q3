package main

import (
	"github.com/gofiber/fiber/v2"
  "main/internal/handlers/user"
)

func Routers(app *fiber.App) {
	app.Post("/pessoas", user.HandlerCreateUser)
	app.Get("/pessoas/:id", user.HandlerGetUser)
	app.Get("/pessoas", user.HandlerFindUser)
  
	app.Get("/contagem-pessoas", user.HandlerCountUsers)


}
