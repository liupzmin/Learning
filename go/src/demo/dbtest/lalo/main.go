package main

import (
	"database/sql"
	"log"

	gomap "gitee.com/xslasd/go-map"
	_ "github.com/go-sql-driver/mysql"
)

func main() {
	db2, err := sql.Open("mysql", "root:123456@tcp(127.0.0.1:3306)/c2matica_sys")
	if err != nil {
		log.Panic(err)
	}

	err = InsertAreaCode(db2)
	if err != nil {
		log.Fatalln(err)
	}
}

type Region struct {
	GID      string
	FullName string
}

var (
	regionSql = "select GID, FullName  from c2matica_sys.sys_region where Latitude = 0 OR Longitude = 0"
)

func Query(db *sql.DB) ([]Region, error) {
	stmt, err := db.Prepare(regionSql)
	if err != nil {
		return nil, err
	}
	rows, err := stmt.Query()
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	set := make([]Region, 0)
	for rows.Next() {
		var row Region
		err = rows.Scan(&row.GID, &row.FullName)
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

	usql := "update c2matica_sys.sys_region set Longitude =?, Latitude = ? where GID = ?"

	for _, v := range data {

		res, err := gm.Geocoder(v.FullName, "")
		if err != nil {
			log.Printf("parse FullName failed: %s, %s\n", v.FullName, err.Error())
			continue
		}

		/*
			ad, err := gm.ReverseGeocoding(v.Longitude, v.Latitude)
			if err != nil {
				log.Printf("ReverseGeocoding failed: %s, %s\n", v.Address, err.Error())
				continue
			}*/

		_, err = db.Exec(usql, res.Lng, res.Lat, v.GID)
		if err != nil {
			log.Printf("update failed: %s\n", err.Error())
		}
		log.Printf("update lat long successfully: %s, %f, %f\n", v.FullName, res.Lng, res.Lat)
		// time.Sleep(300 * time.Millisecond)
	}
	return nil
}
