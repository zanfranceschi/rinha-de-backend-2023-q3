package mongodb

import (
	"context"
	"github.com/joho/godotenv"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
	"log"
	"os"
	"time"
)

var conn *mongo.Client
var insertsQueue map[string][]interface{}

func Connect() {
	var err error

	if err = godotenv.Load(".env"); err != nil {
		// log.Printf("❌ Error: no .env file found")
	}
	uri := os.Getenv("MONGODB_URI")
	if uri == "" {
		log.Fatalf("❌ Error: MONGODB_URI don't set!")
	}


	conn, err = mongo.Connect(context.TODO(), options.Client().ApplyURI(uri))
	if err != nil {
		log.Fatalf("❌ Error: fail to connect mongodb: (%v)", err)
	}
	// defer func() {
	// 	err := conn.Disconnect(context.TODO())
	// 	if err != nil {
	// 		panic(err)
	// 	}
	// }()

	insertsQueue = make(map[string][]interface{})
}

func (mb *MongoBase) tickerInsert() {
	ticker := time.NewTicker(time.Second)
	for {
		<-ticker.C
		mb.tickerUser()
	}
}

func GetConn() *mongo.Client {
	return conn
}
