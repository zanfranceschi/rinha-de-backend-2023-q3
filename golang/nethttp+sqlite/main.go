package main

import (
	"context"
	"log"
	"os"
	"os/signal"
	"syscall"

	"golang.org/x/sync/errgroup"
)

func main() {
	store, err := NewSQLiteStore()

	if err != nil {
		log.Fatal(err)
	}

	server := New(store, "8080")

	interrupt := make(chan os.Signal, 1)
	signal.Notify(interrupt, os.Interrupt, syscall.SIGTERM)
	defer signal.Stop(interrupt)

	g, ctx := errgroup.WithContext(context.Background())

	log.Println("Starting server")
	g.Go(server.Start)

	select {
	case <-ctx.Done():
		err = server.Stop()
		if err != nil {
			log.Println("Error:", err)
			os.Exit(1)
		}
	case sig := <-interrupt:
		log.Println("Received signal:", sig)
		err = server.Stop()
		if err != nil {
			log.Println("Error:", err)
			os.Exit(1)
		}
	}

	log.Println("Shutting down")

	if err := g.Wait(); err != nil {
		log.Println("Error:", err)
		os.Exit(1)
	}

}
