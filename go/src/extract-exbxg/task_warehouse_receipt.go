package main

import (
	"database/sql"
	"github.com/Shopify/sarama"
	"github.com/glory-cd/utils/log"
)

type WarehouseReceipt struct {
	ID         int    `json:"id"`
	BreedName  string `json:"breed_name"`
	StockQTY   int64  `json:"stock_qty"`
	Unit       string `json:"unit"`
	CreateTime string `json:"create_time"`
	Date       string `json:"date"`
}

var stockLMESQL = `select a.id, b.breed_name, a.stock_qty,
					a.unit, a.create_time, a.date 
					from t_d_warehousereceipt a, t_d_breed b
					where a.breed_id = b.id and a.id > ? `

func extractWarehouseReceipt(producer sarama.SyncProducer, db *sql.DB) {

	topic := config.Topics.WarehouseReceipt
	checkPoint.RLock()
	rows, err := db.Query(stockLMESQL, checkPoint.WarehouseReceipt)
	checkPoint.RUnlock()

	if err != nil {
		log.Slogger.Errorf("query error: %+v", err)
		return
	}
	defer rows.Close()

	var (
		result []WarehouseReceipt
		count  int
		max    int
	)
	for rows.Next() {
		var r WarehouseReceipt
		err = rows.Scan(&r.ID, &r.BreedName, &r.StockQTY, &r.Unit, &r.CreateTime, &r.Date)
		if err != nil {
			log.Slogger.Errorf("row scan error: %+v", err)
			return
		}

		if r.ID > max {
			max = r.ID
		}

		result = append(result, r)
		count++

		if count%config.BatchSize == 0 {

			err := sendBatch(producer, result, topic)
			if err != nil {
				log.Slogger.Errorf("批量发送失败，本次中止，等待下次发送！error: %s", err.Error())
				return
			}
			count = 0
			result = nil
			syncIntPosition(&checkPoint.WarehouseReceipt, &max)
			log.Slogger.Infof("批量发送成功，数量为：%d, max:%d", config.BatchSize, max)
		}
	}

	if len(result) != 0 {
		err = sendBatch(producer, result, topic)
		if err != nil {
			log.Slogger.Errorf("批量发送失败，本次中止，等待下次发送！error: %s", err.Error())
			return
		}
		if max != 0 {
			syncIntPosition(&checkPoint.WarehouseReceipt, &max)
		}

		log.Slogger.Infof("批量发送成功，  数量为：%d, max为：%d", count%config.BatchSize, max)
	}

	if err := rows.Err(); err != nil {
		log.Slogger.Errorf("check rows error: %+v", err)
	}
}
