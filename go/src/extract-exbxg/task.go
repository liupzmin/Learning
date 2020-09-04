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
	WarehouseReceipt int `json:"warehouse_receipt"`
}


func sendBatch(producer sarama.SyncProducer, batch interface{}, topic string) error {
	msg, err := json.Marshal(batch)
	if err != nil {
		return errors.WithStack(err)
	}
	err = sendData(producer, topic, msg)
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
	file, err := os.OpenFile(config.PositionFile, os.O_WRONLY|os.O_CREATE, 0666)
	if err != nil {
		log.Slogger.Fatalf("position 文件打开失败：%+v", err)
	}
	defer file.Close()

	ticker := time.NewTicker(3 * time.Second)

	defer ticker.Stop()

	for {
		select {
		case <-done:
			return
		case <-ticker.C:
			err := writeJSONToFile(file)
			if err != nil {
				log.Slogger.Errorf("writePosition error: %+v", err)
			}
		}
	}
}

func writeJSONToFile(file *os.File) error {
	// 清空文件内容
	err := file.Truncate(0)
	if err != nil {
		return errors.WithStack(err)
	}

	_, err = file.Seek(0, 0)
	if err != nil {
		return errors.WithStack(err)
	}

	encoder := json.NewEncoder(file)
	checkPoint.RLock()
	err = encoder.Encode(&checkPoint)
	checkPoint.RUnlock()
	if err != nil {
		return errors.WithStack(err)
	}
	return nil
}

func syncIntPosition (k , v *int) {
	checkPoint.Lock()
	*k = *v
	checkPoint.Unlock()
}