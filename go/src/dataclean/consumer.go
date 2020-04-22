package main

import (
	"regexp"

	"github.com/Shopify/sarama"
)

// Consumer represents a Sarama consumer group consumer
type Consumer struct {
	ready chan bool
}

// Setup is run at the beginning of a new session, before ConsumeClaim
func (consumer *Consumer) Setup(sarama.ConsumerGroupSession) error {
	// Mark the consumer as ready
	close(consumer.ready)
	return nil
}

// Cleanup is run at the end of a session, once all ConsumeClaim goroutines have exited
func (consumer *Consumer) Cleanup(sarama.ConsumerGroupSession) error {
	return nil
}

// ConsumeClaim must start a consumer loop of ConsumerGroupClaim's Messages().
func (consumer *Consumer) ConsumeClaim(session sarama.ConsumerGroupSession, claim sarama.ConsumerGroupClaim) error {

	// NOTE:
	// Do not move the code below to a goroutine.
	// The `ConsumeClaim` itself is called within a goroutine, see:
	// https://github.com/Shopify/sarama/blob/master/consumer_group.go#L27-L29
	for message := range claim.Messages() {
		matched, _ := regexp.Match(".*(receive message from|send message to).*35=(2|4).*", message.Value)
		if matched {
			//fmt.Printf("Message claimed: value = %s, timestamp = %v, topic = %s \n", string(message.Value), message.Timestamp, message.Topic)
			dispatcherMessage(message.Value)
		}
		session.MarkMessage(message, "")
	}

	return nil
}
