package main

import (
	"database/sql"
	"github.com/Shopify/sarama"
	"github.com/glory-cd/utils/log"
)

type StockSHFE struct {
	ID         int    `json:"id"`
	Exchange   string `json:"exchange"`
	Goods      string `json:"goods"`
	Weight     int64  `json:"weight"`
	IncDec     int64  `json:"inc_dec"`
	Unit       string `json:"unit"`
	CreateTime string `json:"create_time"`
	Date       string `json:"date"`
}

var stockSHFESQL = `select id, exchange, goods, weight,
					inc_dec, unit, create_time, date 
					from T_D_STOCK_SHFE where id > ? `

func extractStockSHFE(producer sarama.SyncProducer, db *sql.DB) {

	topic := config.Topics.SHFE

	checkPoint.RLock()
	rows, err := db.Query(stockSHFESQL, checkPoint.StockSHFE)
	checkPoint.RUnlock()

	if err != nil {
		log.Slogger.Errorf("query error: %+v", err)
		return
	}
	defer rows.Close()

	var (
		result []StockSHFE
		count  int
		max    int
	)
	for rows.Next() {
		var r StockSHFE
		err = rows.Scan(&r.ID, &r.Exchange, &r.Goods, &r.Weight, &r.IncDec, &r.Unit, &r.CreateTime, &r.Date)
		if err != nil {
			log.Slogger.Errorf("row scan error: %+v", err)
			return
		}

		if r.ID > max {
			max = r.ID
		}

		result = append(result, r)
		count++

		if count % config.BatchSize == 0 {

			err := sendBatch(producer, result, topic)
			if err != nil {
				log.Slogger.Errorf("批量发送失败，本次中止，等待下次发送！error: %s", err.Error())
				return
			}
			count = 0
			result = nil
			syncIntPosition(&checkPoint.StockSHFE, &max)
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
			syncIntPosition(&checkPoint.StockSHFE, &max)
		}

		log.Slogger.Infof("批量发送成功，  数量为：%d, max为：%d", count % config.BatchSize, max)
	}

	if err := rows.Err(); err != nil {
		log.Slogger.Errorf("check rows error: %+v", err)
	}
}


