package user

import (
	"fmt"
	"main/database/mongo"

	"github.com/gofiber/fiber/v2"
	"go.mongodb.org/mongo-driver/mongo"
)

func HandlerCountUsers(c *fiber.Ctx) error {
	db := mongodb.Builder().UseDatabase("backend")
	db.UseCollection("users")
	users, _, err := db.CountUsers()
	if err != nil {
		if err == mongo.ErrNoDocuments {
			c.SendString("❌ no registers")
      return c.SendStatus(fiber.StatusNotFound)
		}
		c.SendString("❌ internal error")
		return c.SendStatus(fiber.StatusInternalServerError)
	}

	return c.SendString(fmt.Sprintf("👌 Total users: %v\n", users))

}
