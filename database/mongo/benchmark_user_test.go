package mongodb

import (
	// mongodb "main/database/mongo"
	"main/models/user"
	"testing"
  "os"
)

func Benchmark_CreateUserBatch(b *testing.B) {
  // b.Skip()
  os.Setenv("MONGODB_URI", "mongodb://root:12341243@localhost")
	Connect()
	user := userModel.User{
		Name:     "benchmark",
		Nickname: "speedtest",
		Birth:    "2009-04-3",
		Stack: []string{
			"go", "go", "go", "go", "go", "go", "go", "go",
			"go", "go", "go", "go", "go", "go", "go", "go",
		},
	}
	for i := 0; i < b.N; i++ {
		Builder().
			UseDatabase("benchmark").
      UseCollection("users").CreateUser(user)
	}
}

func Benchmark_CreateUserOnly(b *testing.B) {
  os.Setenv("MONGODB_URI", "mongodb://root:12341243@localhost")
	Connect()
	user := userModel.User{
		Name:     "benchmark",
		Nickname: "speedtest",
		Birth:    "2009-04-3",
		Stack: []string{
			"go", "go", "go", "go", "go", "go", "go", "go",
			"go", "go", "go", "go", "go", "go", "go", "go",
		},
	}
	for i := 0; i < b.N; i++ {
		Builder().
			UseDatabase("benchmark").
      UseCollection("users").CreateUserNow(user)
	}
}


func Benchmark_CreateUserWithWorkers(b *testing.B) {
  os.Setenv("MONGODB_URI", "mongodb://root:12341243@localhost")
	Connect()
	user := userModel.User{
		Name:     "benchmark",
		Nickname: "speedtest",
		Birth:    "2009-04-3",
		Stack: []string{
			"go", "go", "go", "go", "go", "go", "go", "go",
			"go", "go", "go", "go", "go", "go", "go", "go",
		},
	}
	for i := 0; i < b.N; i++ {
		Builder().
			UseDatabase("benchmark").
      UseCollection("users").CreateUserWithWorkers(user)
	}
}
