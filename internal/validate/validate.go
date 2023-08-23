package validate

import (
	"github.com/go-playground/locales"
	// "github.com/go-playground/locales/en"
	"github.com/go-playground/validator/v10"

	"fmt"
	ut "github.com/go-playground/universal-translator"
	// enTranslations "github.com/go-playground/validator/v10/translations/en"
)

func (v *validateBuilder) Language(lang locales.Translator) *validateBuilder {
	v.language = lang
  v.ut = ut.New(lang, lang)
	return v
}

func (v *validateBuilder) Translator(lang string) *validateBuilder {
	v.translator, _ = v.ut.GetTranslator(lang)
	return v
}

func (v*validateBuilder) TranslateError(err error) (errs []error) {
	if err == nil {
		return nil
	}
	validatorErrs := err.(validator.ValidationErrors)
	for _, e := range validatorErrs {
		translatedErr := fmt.Errorf(e.Translate(v.translator))
		errs = append(errs, translatedErr)
	}
	return errs
}

func (v*validateBuilder) GetValidator() *validator.Validate{
  return v.validator
}



func (v*validateBuilder) GetTranslator() ut.Translator{
  return v.translator
}
