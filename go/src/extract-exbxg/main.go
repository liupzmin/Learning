package main

import (
	"database/sql"
	"github.com/Shopify/sarama"
	"log"
	"strings"
	"time"
)

var (
	db *sql.DB
	done = make(chan bool)
	producer sarama.SyncProducer
)

func main() {
	err := initConfig()

	if err != nil {
		log.Fatalf("init config error: %+v\n", err)
	}

	err = initPosition()

	if err != nil {
		log.Fatalf("init position file error: %+v\n", err)
	}

	db, err = connectDB()

	if err != nil {
		log.Fatalf("conn to db error: %+v\n", err)
	}

	defer db.Close()

	go writePosition()
	go gracefulHandle()

	producer, err = sarama.NewSyncProducer(strings.Split(config.Brokers, ","), nil)
	if err != nil {
		log.Fatalf("创建 kafka SyncProducer 失败， %s", err.Error())
	}

	defer func() {
		if err := producer.Close(); err != nil {
			log.Fatalf("关闭 kafka SyncProducer 失败， %s", err.Error())
		}
	}()

	ticker := time.NewTicker(config.Interval * time.Minute)

	defer ticker.Stop()

	for {
		select {
		case <-done:
			return
		case <-ticker.C:
			go extractWarehouseReceipt(producer, db)

		}
	}

}
