package main

import (
	"context"
	"log"
	"net/http"
	_ "net/http/pprof"
	"os"
	"os/signal"
	"strings"
	"sync"
	"syscall"

	"github.com/Shopify/sarama"
)

var (
	loginInfoChan  = make(chan []byte, 1024)
	verifyInfoChan = make(chan []byte, 1024)
	brokers        = "10.158.61.170:9092,10.158.61.171:9092,10.158.61.90:9092,10.158.61.95:9092"
	topics         = "auth"
	group          = "go-consumer"
)

func main() {

	go func() {
		http.ListenAndServe("0.0.0.0:8899", nil)
	}()

	config := sarama.NewConfig()
	config.Version = sarama.V2_2_0_0
	config.Consumer.Group.Rebalance.Strategy = sarama.BalanceStrategyRoundRobin
	config.Consumer.Offsets.Initial = sarama.OffsetOldest

	consumer := Consumer{
		ready: make(chan bool),
	}

	ctx, cancel := context.WithCancel(context.Background())
	client, err := sarama.NewConsumerGroup(strings.Split(brokers, ","), group, config)
	if err != nil {
		log.Panicf("Error creating consumer group client: %v", err)
	}

	wg := &sync.WaitGroup{}
	wg.Add(1)
	go func() {
		defer wg.Done()
		for {
			if err := client.Consume(ctx, strings.Split(topics, ","), &consumer); err != nil {
				log.Panicf("Error from consumer: %v", err)
			}

			if ctx.Err() != nil {
				return
			}
			consumer.ready = make(chan bool)
		}
	}()

	<-consumer.ready // Await till the consumer has been set up
	log.Println("Sarama consumer up and running!...")

	go handleLogin()

	go handleVerify()

	sigterm := make(chan os.Signal, 1)
	signal.Notify(sigterm, syscall.SIGINT, syscall.SIGTERM)
	select {
	case <-ctx.Done():
		log.Println("terminating: context cancelled")
	case <-sigterm:
		log.Println("terminating: via signal")
	}

	cancel()
	wg.Wait()

	close(loginInfoChan)
	close(verifyInfoChan)

	if err = client.Close(); err != nil {
		log.Panicf("Error closing client: %v", err)
	}

}
