package main

import (
	"context"
	"fmt"
	"time"

	"github.com/redis/go-redis/v9"
)

func main() {
	client := redis.NewClient(&redis.Options{
		Addr: "localhost:6379", // Replace with your Redis server address
	})

	pong, err := client.Ping(context.Background()).Result()
	if err != nil {
		fmt.Println("Failed to connect to Redis:", err)
		return
	}

	fmt.Println("Connected to Redis:", pong)

	// Set and get a key-value pair for a string value in redis
	err = client.Set(context.Background(), "key", "something", 0).Err()
	if err != nil {
		fmt.Println("Failed to set key-value pair:", err)
		return
	}

	// Get the key-value pair
	val, err := client.Get(context.Background(), "key").Result()
	if err != nil {
		fmt.Println("Failed to get key-value pair:", err)
		return

	}

	fmt.Println("key:", val)

	// Set an expiring key-value pair in Redis
	err = client.Set(context.Background(), "expiring_key", "something", 2*time.Second).Err()
	if err != nil {
		fmt.Println("Failed to set expiring key-value pair:", err)
		return
	}
	fmt.Println("Expiring key-value pair set successfully")

	// Wait for 5 seconds
	time.Sleep(3 * time.Second)

	// Check if the expiring key still exists
	exists, err := client.Exists(context.Background(), "expiring_key").Result()
	if err != nil {
		fmt.Println("Failed to check if expiring key exists:", err)
		return
	}

	if exists == 1 {
		fmt.Println("Expiring key still exists")
	} else {
		fmt.Println("Expiring key has expired")
	}

	// example for a list in redis
	err = client.RPush(context.Background(), "list", "item1", "item2", "item3").Err()
	if err != nil {
		fmt.Println("Failed to push items to list:", err)
		return
	}

	// get the list
	list, err := client.LRange(context.Background(), "list", 0, -1).Result()
	if err != nil {
		fmt.Println("Failed to get list:", err)
		return
	}
	fmt.Println("list:", list)

	// example for a hash in redis
	err = client.HSet(context.Background(), "hash", "field1", "value1", "field2", "value2").Err()
	if err != nil {
		fmt.Println("Failed to set hash:", err)
		return
	}

	hash, err := client.HGetAll(context.Background(), "hash").Result()
	if err != nil {
		fmt.Println("Failed to get hash:", err)
		return
	}

	fmt.Println("hash:", hash)
}
