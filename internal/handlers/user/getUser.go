package user

import (
	"fmt"
	"main/database/mongo"

	"github.com/gofiber/fiber/v2"
	"go.mongodb.org/mongo-driver/mongo"
)

type response struct {
	Id       string   `json:"id"`
	Name     string   `json:"name"`
	Nickname string   `json:"nickname"`
	Birth    string   `json:"birth"`
	Stack    []string `json:"stack"`
}

func HandlerFindUser(c *fiber.Ctx) error {
	t := c.Query("t")
	if t == "" {
		msg := fmt.Sprintf("❌ undefined search term")
		c.SendString(msg)
		return c.SendStatus(fiber.StatusBadRequest)
	}
	db := mongodb.Builder().
		UseDatabase("backend").
		UseCollection("users")
	searchUsers, _ := db.SearchUsersByTerm(t)
	responseBody := []response{}
	for _, u := range searchUsers {
		userBody := response{
			u.UUID,
			u.Name,
			u.Nickname,
			u.Birth, u.Stack,
		}
		responseBody = append(responseBody, userBody)
	}
	return c.JSON(responseBody)

}

func HandlerGetUser(c *fiber.Ctx) error {
	id := c.Params("id")
	db := mongodb.Builder().
		UseDatabase("backend").
		UseCollection("users")
	user, err := db.GetUserByUUID(id)
	if err != nil {
		if err == mongo.ErrNoDocuments {
			c.SendString("🔎 ❌ not found")
			return c.SendStatus(fiber.StatusNotFound)
		}
		c.SendString("💥 internal error")
		return c.SendStatus(fiber.StatusInternalServerError)
	}
	responseBody := response{
		user.UUID,
		user.Name,
		user.Nickname,
		user.Birth,
		user.Stack,
	}
	return c.JSON(responseBody)
}
