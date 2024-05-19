package main

import (
	"fmt"
	"time"

	"github.com/go-redis/redis"
)

func main() {
	client := redis.NewClient(&redis.Options{
		Addr:     "localhost:6379",
		Password: "", // no password set
		DB:       0,  // use default DB
	})

	pubsub := client.Subscribe("mychannel")
	defer pubsub.Close()

	go func() {
		for {
			message, err := pubsub.ReceiveMessage()
			if err != nil {
				panic(err)
			}

			fmt.Println("Received: ", message.Payload)
		}
	}()

	for {
		err := client.Publish("mychannel", "hello").Err()
		if err != nil {
			panic(err)
		}

		time.Sleep(time.Second)
	}
}
