package dbt

import (
	"database/sql"

	_ "github.com/go-sql-driver/mysql"
)

var (
	joinSql = `
SELECT 
    a.GID,a.DeviceLink,a.WaterLevel,a.Clean,b.DeviceNo, b.VendorLink, b.MAC
FROM
    c2matica_dev.dev_h6info a,
    c2matica_dev.dev_device b
WHERE
    a.DeviceLink = b.GID
LIMIT ?, ?
`

	singleSql = `
SELECT 
    a.GID,a.DeviceLink,a.WaterLevel,a.Clean
FROM
    c2matica_dev.dev_h6info a
LIMIT ?, ?
`

	dev = `
SELECT 
    b.DeviceNo, b.VendorLink, b.MAC
FROM
    c2matica_dev.dev_device b
WHERE
    b.GID = ?
`
)

type H6 struct {
	GID        string
	DeviceLink string
	WaterLevel sql.NullInt64
	Clean      sql.NullInt64
}

type Dev struct {
	DeviceNo   string
	VendorLink string
	MAC        string
}

type Result struct {
	H6
	Dev
}

func QueryWithJoin(db *sql.DB, index, pagesize int) ([]Result, error) {
	stmt, err := db.Prepare(joinSql)
	if err != nil {
		return nil, err
	}
	rows, err := stmt.Query(index, pagesize)
	defer rows.Close()
	set := make([]Result, 0)
	for rows.Next() {
		var row Result
		err = rows.Scan(&row.GID, &row.DeviceLink, &row.WaterLevel, &row.Clean, &row.DeviceNo, &row.VendorLink, &row.MAC)
		if err != nil {
			return nil, err
		}
		if !row.WaterLevel.Valid {
			row.WaterLevel.Int64 = 0
		}
		if !row.Clean.Valid {
			row.Clean.Int64 = 0
		}

		set = append(set, row)
	}
	return set, nil
}

func QueryWithoutJoin(db *sql.DB, index, pagesize int) ([]Result, error) {
	stmt, err := db.Prepare(singleSql)
	if err != nil {
		return nil, err
	}
	rows, err := stmt.Query(index, pagesize)
	defer rows.Close()
	set := make([]Result, 0)
	for rows.Next() {
		var (
			h6 H6
			d  Dev
		)
		err = rows.Scan(&h6.GID, &h6.DeviceLink, &h6.WaterLevel, &h6.Clean)
		stmt, err := db.Prepare(dev)
		err = stmt.QueryRow(h6.DeviceLink).Scan(&d.DeviceNo, &d.VendorLink, &d.MAC)
		if err != nil {
			return nil, err
		}
		set = append(set, Result{h6, d})
	}
	return set, nil
}
