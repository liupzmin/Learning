package dbt

import (
	"database/sql"
	"testing"
)

var db, _ = sql.Open("mysql", "root:123456@/c2matica_dev")

func BenchmarkQueryWithJoin(b *testing.B) {
	for n := 0; n < b.N; n++ {
		QueryWithJoin(db, 0, 100)
	}

}

func BenchmarkQueryWithoutJoin(b *testing.B) {
	for n := 0; n < b.N; n++ {
		QueryWithoutJoin(db, 0, 100)
	}
}
