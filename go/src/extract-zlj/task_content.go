package main

import (
	"database/sql"
	"github.com/Shopify/sarama"
	"github.com/glory-cd/utils/log"
)

type Content struct {
	ContentID   int    `json:"content_id"`
	Title       string `json:"title"`
	Txt         string `json:"txt"`
	ReleaseDate string `json:"release_date"`
	ChannelName string `json:"channel_name"`
}

var contentSQL = `SELECT 
    jc_content.content_id,
    jc_content_ext.title,
    jc_content_ext.release_date,
    jc_content_txt.txt,
    jc_channel_ext.channel_name
FROM
    jc_content,
    jc_content_ext,
    jc_content_txt,
    jc_channel,
    jc_channel_ext
WHERE
    jc_content.content_id = jc_content_ext.content_id
        AND jc_content.content_id = jc_content_txt.content_id
        AND jc_content.channel_id = jc_channel.channel_id
        AND jc_channel.channel_id = jc_channel_ext.channel_id
        AND jc_channel_ext.channel_name IN ('宏观新闻' , '采购价格', '动态', '国际')
		AND jc_content.content_id > ?
`

func extractContent(producer sarama.SyncProducer, db *sql.DB) {

	topic := config.Topics.Content

	checkPoint.RLock()
	rows, err := db.Query(contentSQL, checkPoint.Content)
	checkPoint.RUnlock()

	if err != nil {
		log.Slogger.Errorf("query error: %+v", err)
		return
	}
	defer rows.Close()

	var (
		result []Content
		count  int
		max    int
	)
	for rows.Next() {
		var r Content
		err = rows.Scan(&r.ContentID, &r.Title, &r.ReleaseDate, &r.Txt, &r.ChannelName)
		if err != nil {
			log.Slogger.Errorf("row scan error: %+v", err)
			return
		}

		if r.ContentID > max {
			max = r.ContentID
		}

		result = append(result, r)
		count++

		if count%config.ContentBatchSize == 0 {

			err := sendBatch(producer, result, topic)
			if err != nil {
				log.Slogger.Errorf("批量发送失败，本次中止，等待下次发送！error: %s", err.Error())
				return
			}
			count = 0
			result = nil
			syncIntPosition(&checkPoint.Content, &max)
			log.Slogger.Infof("批量发送成功，数量为：%d, max:%d", config.ContentBatchSize, max)
		}
	}

	if len(result) != 0 {
		err = sendBatch(producer, result, topic)
		if err != nil {
			log.Slogger.Errorf("批量发送失败，本次中止，等待下次发送！error: %s", err.Error())
			return
		}
		if max != 0 {
			syncIntPosition(&checkPoint.Content, &max)
		}

		log.Slogger.Infof("批量发送成功，  数量为：%d, max为：%d", count%config.ContentBatchSize, max)
	}

	if err := rows.Err(); err != nil {
		log.Slogger.Errorf("check rows error: %+v", err)
	}
}
