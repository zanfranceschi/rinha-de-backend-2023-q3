package mongodb

import "time"
import "github.com/panjf2000/ants"
import "log"

var pool *ants.Pool

const defaultRuntimes = 1024

func InitGoroutines() {
	var err error
	pool, err = ants.NewPool(defaultRuntimes, ants.WithOptions(ants.Options{
		PreAlloc:       false,
		Nonblocking:    false, //bloqueando pra testar
		ExpiryDuration: time.Duration(7) * time.Second,
		PanicHandler: func(i interface{}) {
			log.Println("❌ PANIC: a panic occurred in the server manager:", i)
		},
	}))
	if err != nil {
    log.Fatalf("❌ Error: fail to alloc goroutines in database module: (%v)", err)
	}
}
