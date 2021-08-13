package dbt

import (
	"database/sql"
	"testing"
)

var db2, _ = sql.Open("mysql", "root:c2matica@tcp(192.168.1.232:4306)/c2matica_dev")

func TestQuery(t *testing.T) {
	data, err := Query(db2)
	if err != nil {
		t.Errorf("query failed: %s\n", err.Error())
	}

	t.Logf("data: %+v", data)
}

func TestInsert(t *testing.T) {
	err := InsertAreaCode(db2)
	if err != nil {
		t.Errorf("InsertAreaCode failed: %s\n", err.Error())
	}
}
