package mongodb

import (
	"go.mongodb.org/mongo-driver/mongo"
)

type MongoBase struct {
	database   *mongo.Database
	collection *mongo.Collection
	connection *mongo.Client
}

func Builder() *MongoBase {
	mb := new(MongoBase)
	mb.connection = GetConn()
  InitGoroutines()
	go mb.tickerInsert()
	return mb
}

func (mb *MongoBase) UseDatabase(db string) *MongoBase {
	mb.database = mb.connection.Database(db)
	return mb
}

func (mb *MongoBase) UseCollection(collection string) *MongoBase {
	mb.collection = mb.database.Collection(collection)
	return mb
}
