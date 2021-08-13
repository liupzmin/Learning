package dbt

import (
	"database/sql"
	"log"

	gomap "gitee.com/xslasd/go-map"
)

type Device struct {
	GID     string
	Address string
}

var (
	deviceSql = "select GID, Address from c2matica_dev.dev_device where Address is not null or Address!=''"
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
		err = rows.Scan(&row.GID, &row.Address)
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

	for _, v := range data {
		res, err := gm.Geocoder(v.Address, "")
		if err != nil {
			log.Printf("parse code failed: %s, %s\n", v.Address, err.Error())
			continue
		}
		ad, err := gm.ReverseGeocoding(res.Lat, res.Lng)
		if err != nil {
			log.Printf("ReverseGeocoding failed: %s, %s\n", v.Address, err.Error())
			continue
		}
		log.Printf("parse code successfully: %s, %+v\n", v.Address, ad)
	}
	return nil
}
