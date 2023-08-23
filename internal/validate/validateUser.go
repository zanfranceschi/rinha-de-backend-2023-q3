package validate

import "regexp"

func IsValidUsername(username string) bool {
	regexUsername := `^[A-Z][a-zA-ZÀ-ÖØ-öø-ÿ\s'-]+$`
	regex := regexp.MustCompile(regexUsername)
	return regex.MatchString(username)
}
