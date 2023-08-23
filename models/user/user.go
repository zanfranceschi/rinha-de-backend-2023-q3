package userModel

import "go.mongodb.org/mongo-driver/bson/primitive"

type User struct {
	objectID primitive.ObjectID `bson:"_id"`
  UUID     string             `bson:"uuid"`
	Name     string             `bson:"name" json:"name"     validate:"required,min=4,max=100"`
	Nickname string             `bson:"nickname" json:"nickname" validate:"required,alphanum,min=4,max=32"`
	Birth    string             `bson:"birth" json:"birth"    validate:"required"`
	Stack    []string           `bson:"stack,omitempty" json:"stack" validate:"dive,alphanum,max=32"`
}

func (u *User) SetObjectID(objID primitive.ObjectID) {
	u.objectID = objID
}

