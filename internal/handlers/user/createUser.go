package user

import (
	mongodb "main/database/mongo"
	"main/internal/validate"
	userModel "main/models/user"
	"time"

	"fmt"

	"github.com/go-playground/locales/en"
	enTranslations "github.com/go-playground/validator/v10/translations/en"
	"github.com/gofiber/fiber/v2"
	"github.com/google/uuid"
)

func HandlerCreateUser(c *fiber.Ctx) error {
	var err error
	var errStr string = fmt.Sprintf("✋ Errors!\n\n\n")
	c.Accepts("application/json")
	user := userModel.User{}
	c.BodyParser(&user)
	if err != nil {
		return c.SendStatus(fiber.StatusInternalServerError)
	}
	validator := validate.Builder()
	validator.
		Language(en.New()).
		Translator("en")

	enTranslations.RegisterDefaultTranslations(
		validator.GetValidator(),
		validator.GetTranslator(),
	)

	err = validator.GetValidator().Struct(user)
	if err != nil ||
		!validate.IsDate(user.Birth) ||
		!validate.IsDateValid(user.Birth) ||
		!validate.IsValidUsername(user.Name) {

		for _, e := range validator.TranslateError(err) {
			errStr += fmt.Sprintf("❌ Error: %s\n", e)
		}

    if !validate.IsValidUsername(user.Name) {
			errStr += fmt.Sprintf("❌ Error: Name cannot be: \"%s\" \n", user.Name)
    }

		if !validate.IsDateValid(user.Birth) {
			date, _ := time.Parse("2006-01-02", user.Birth)
			errStr += fmt.Sprintf("❌ Error: Birth cannot be: \"%s\" \n", date.Format("January 02, 2006"))
		}

		if !validate.IsDate(user.Birth) {
			errStr += fmt.Sprintf("❌ Error: Birth must be of type yyyy-mm-dd\n")
		}
		errStr += fmt.Sprintf("\n\n\n📥 Json: \n\n\n")
		errStr += fmt.Sprintf("🏷️ Atribute: %s, 📦  Value: %v\n", "user", user.Name)
		errStr += fmt.Sprintf("🏷️ Atribute: %s, 📦  Value: %v\n", "nickname", user.Nickname)
		errStr += fmt.Sprintf("🏷️ Atribute: %s, 📦  Value: %v\n", "birth", user.Birth)
		errStr += fmt.Sprintf("🏷️ Atribute: %s, 📦 Value: %v\n", "stack", user.Stack)
		c.WriteString(errStr)
		return c.SendStatus(fiber.StatusBadRequest)
	}

  mb := mongodb.Builder()
  mb.UseDatabase("backend").UseCollection("users")
	if mb.IsExists(user) || mb.IsExistsInBuffer(user) {
    errStr += fmt.Sprintf("❌ Error: This user is already registered\n")
    c.WriteString(errStr)
		return c.SendStatus(fiber.StatusUnprocessableEntity)
	}
	id := uuid.New()
	user.UUID = id.String()
  mb.CreateUserWithWorkers(user)
	c.Response().Header.Set("Location", fmt.Sprintf("/pessoas/%s", id))
	return c.SendStatus(fiber.StatusCreated)
}
