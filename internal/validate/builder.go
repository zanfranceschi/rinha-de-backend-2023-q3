package validate

import (
	// "github.com/dustin/go-humanize/english"
	"github.com/go-playground/locales"
	ut "github.com/go-playground/universal-translator"
	// "github.com/go-playground/validator"
	"github.com/go-playground/validator/v10"
	// "golang.org/x/text/internal/language"
)

type validateBuilder struct {
	validator *validator.Validate
  language locales.Translator
  ut *ut.UniversalTranslator
  translator ut.Translator
}

func Builder() *validateBuilder {
  v := new(validateBuilder)
  v.validator = validator.New()
  return v
}

