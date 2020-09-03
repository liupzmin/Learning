package main

import (
	"encoding/json"
	"github.com/Shopify/sarama"
	"github.com/glory-cd/utils/log"
	"github.com/pkg/errors"
	"os"
	"sync"
	"time"
)

type position struct {
	sync.RWMutex
	StockLME int `json:"StockLME"`
}


func sendBatch(producer sarama.SyncProducer, batch []StockLME) error {
	msg, err := json.Marshal(batch)
	if err != nil {
		return errors.WithStack(err)
	}
	err = sendData(producer, "STOCK_LME", msg)
	if err != nil {
		return errors.WithStack(err)
	}
	return nil
}

// sendData 将消息发往kafka
func sendData(producer sarama.SyncProducer, topic string, message []byte) error {
	msg := &sarama.ProducerMessage{Topic: topic, Value: sarama.StringEncoder(message)}
	_, _, err := producer.SendMessage(msg)
	if err != nil {
		return errors.WithStack(err)
	}
	return nil
}

func writePosition() {
	ticker := time.NewTicker(3 * time.Second)

	defer ticker.Stop()

	for {
		select {
		case <-done:
			return
		case <-ticker.C:
			file, err := os.OpenFile(config.PositionFile, os.O_WRONLY|os.O_CREATE|os.O_TRUNC, 0666)
			if err != nil {
				log.Slogger.Errorf("position文件打开失败： %s", err.Error())
			}
			encoder := json.NewEncoder(file)
			checkPoint.RLock()
			err = encoder.Encode(&checkPoint)
			checkPoint.RUnlock()
			if err != nil {
				log.Slogger.Errorf("position文件写入失败： %s", err.Error())
			}
		}
	}
}
