package main

import (
	"database/sql"
	"log"

	gomap "gitee.com/xslasd/go-map"
	_ "github.com/go-sql-driver/mysql"
)

func main() {
	db2, err := sql.Open("mysql", "root:c2matica@tcp(192.168.1.232:4306)/c2matica_dev")
	if err != nil {
		log.Panic(err)
	}

	err = InsertAreaCode(db2)
	if err != nil {
		log.Fatalln(err)
	}
}

type Device struct {
	GID       string
	Address   string
	Longitude float64
	Latitude  float64
}

var (
	deviceSql = "select GID, Address, Longitude,Latitude  from c2matica_dev.dev_device where Province is not null and Province!='' and (areacode is null or areacode = '')"
)

func Query(db *sql.DB) ([]Device, error) {
	stmt, err := db.Prepare(deviceSql)
	if err != nil {
		return nil, err
	}
	rows, err := stmt.Query()
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	set := make([]Device, 0)
	for rows.Next() {
		var row Device
		err = rows.Scan(&row.GID, &row.Address, &row.Longitude, &row.Latitude)
		if err != nil {
			return nil, err
		}
		set = append(set, row)
	}
	return set, nil
}

func InsertAreaCode(db *sql.DB) error {
	gm, err := gomap.NewMapSDK("696f7dd5ec7d167446e620a7ad5e445c", 1)
	if err != nil {
		return err
	}

	data, err := Query(db)
	if err != nil {
		return err
	}

	usql := "update dev_device set AreaCode =? where GID = ?"

	for _, v := range data {
		/*
			res, err := gm.Geocoder(v.Address, "")
			if err != nil {
				log.Printf("parse code failed: %s, %s\n", v.Address, err.Error())
				continue
			}
		*/
		ad, err := gm.ReverseGeocoding(v.Longitude, v.Latitude)
		if err != nil {
			log.Printf("ReverseGeocoding failed: %s, %s\n", v.Address, err.Error())
			continue
		}

		_, err = db.Exec(usql, ad.AdCode, v.GID)
		if err != nil {
			log.Printf("update failed: %s\n", err.Error())
		}
		log.Printf("parse code successfully: %s, %s, %d\n", v.Address, ad.District, ad.AdCode)
		// time.Sleep(300 * time.Millisecond)
	}
	return nil
}
