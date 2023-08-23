package mongodb

import (
	"context"
	"log"
	"main/models/user"
	"runtime"

	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
)

func (mb *MongoBase) CountUsers() (int64, int, error) {
	registedUsers, err := mb.collection.CountDocuments(context.TODO(), bson.D{})
	bufferUsers := len(insertsQueue["users"])
	return registedUsers, bufferUsers, err
}

func (mb *MongoBase) SearchUsersByTerm(term string) ([]userModel.User, error) {
	filter := bson.D{
		{
			Key: "$or",
			Value: bson.A{
				bson.D{{Key: "nickname", Value: primitive.Regex{Pattern: term, Options: "i"}}},
				bson.D{{Key: "name", Value: primitive.Regex{Pattern: term, Options: "i"}}},
				bson.D{{Key: "stack", Value: primitive.Regex{Pattern: term, Options: "i"}}},
			},
		},
	}

	findOptions := options.Find().SetLimit(50)
	cur, err := mb.collection.Find(context.TODO(), filter, findOptions)
	if err != nil {
		return nil, err
	}
	defer cur.Close(context.TODO())

	var users []userModel.User
	for cur.Next(context.TODO()) {
		var user userModel.User
		if err := cur.Decode(&user); err != nil {
			return nil, err
		}
		users = append(users, user)
	}

	if err := cur.Err(); err != nil {
		return nil, err
	}

	return users, nil
}

func (mb *MongoBase) GetUserByUUID(uuid string) (userModel.User, error) {
	var err error
	searchUser := new(userModel.User)
	*searchUser, err = mb.GetUserByUUIDInBuffer(uuid)
	if searchUser.UUID != "" {
		return *searchUser, err
	}

	filter := bson.D{{Key: "uuid", Value: uuid}}
	err = mb.collection.FindOne(context.TODO(), filter).Decode(searchUser)
	return *searchUser, err
}

func (mb *MongoBase) GetUserByUUIDInBuffer(uuid string) (userModel.User, error) {
	for _, u := range insertsQueue["users"] {
		if u.(userModel.User).UUID == uuid {
			return u.(userModel.User), nil
		}
	}
	return userModel.User{}, mongo.ErrNoDocuments
}

func (mb *MongoBase) IsExistsInBuffer(user userModel.User) bool {
	for _, u := range insertsQueue["users"] {
		if u.(userModel.User).Nickname == user.Nickname {
			return true
		}
	}
	return false
}

func (mb *MongoBase) IsExists(user userModel.User) bool {
	filter := bson.D{{Key: "nickname", Value: user.Nickname}}
	searchUser := new(userModel.User)
	err := mb.collection.FindOne(context.TODO(), filter).Decode(searchUser)
	if err != nil {
		if err == mongo.ErrNoDocuments {
			return false
		}
	}
	if searchUser.Nickname == user.Nickname {
		return true
	}
	return false
}

func (mb *MongoBase) CreateUser(user userModel.User) {
	user.SetObjectID(primitive.NewObjectID())
	insertsQueue["users"] = append(insertsQueue["users"], user)
}

func (mb *MongoBase) CreateUserNow(user userModel.User) {
	mb.collection.InsertOne(context.TODO(), user)
}

func (mb *MongoBase) CreateUserWithWorkers(user userModel.User) {
	pool.Submit(func() {
		runtime.Gosched()
		mb.collection.InsertOne(context.TODO(), user)
	})
}

func (mb *MongoBase) tickerUser() {
	if mb.collection == nil {
		return
	}
	if len(insertsQueue["users"]) > 0 {
		_, err := mb.collection.InsertMany(context.TODO(), insertsQueue["users"])
		if err != nil {
			log.Printf("❌ Error: fail register user: (%v), len(%v)", err, len(insertsQueue["users"]))
			return
		}
		insertsQueue["users"] = insertsQueue["users"][:len(insertsQueue["users"])-1]
	}
}
