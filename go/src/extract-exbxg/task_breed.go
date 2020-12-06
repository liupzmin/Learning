package main

import (
	"database/sql"
	"github.com/Shopify/sarama"
	"github.com/glory-cd/utils/log"
)

type Breed struct {
	ID           int    `json:"id"`
	BreedName    string `json:"breed_name"`
	OrderBy      int64  `json:"orderby"`
	Status       string `json:"status"`
	CreateTime   string `json:"create_time"`
	QuoteUnit    string `json:"quote_unit"`
	DeliveryUnit string `json:"delivery_unit"`
	BreedCode    string `json:"breed_code"`
}

var breedSQL = `select a.id,a.breed_name,a.orderby,a.status,a.create_time,
				a.quote_unit,a.delivery_unit, a.breed_code 
				from t_d_breed a where a.id > ? `

func extractBreed(producer sarama.SyncProducer, db *sql.DB) {

	topic := config.Topics.Breed
	checkPoint.RLock()
	rows, err := db.Query(breedSQL, checkPoint.Breed)
	checkPoint.RUnlock()

	if err != nil {
		log.Slogger.Errorf("query error: %+v", err)
		return
	}
	defer rows.Close()

	var (
		result []Breed
		count  int
		max    int
	)
	for rows.Next() {
		var r Breed
		err = rows.Scan(&r.ID, &r.BreedName, &r.OrderBy, &r.Status, &r.CreateTime, &r.QuoteUnit,
			&r.DeliveryUnit, &r.BreedCode)
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
			syncIntPosition(&checkPoint.Breed, &max)
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
			syncIntPosition(&checkPoint.Breed, &max)
		}

		log.Slogger.Infof("批量发送成功，  数量为：%d, max为：%d", count%config.BatchSize, max)
	}

	if err := rows.Err(); err != nil {
		log.Slogger.Errorf("check rows error: %+v", err)
	}
}
