package sort

import (
	"reflect"
	"testing"
)

func TestCountingSort(t *testing.T) {
	type args struct {
		e []int
	}
	tests := []struct {
		name    string
		args    args
		want    []int
		wantErr bool
	}{
		// TODO: Add test cases.
		{
			"empty",
			args{
				[]int{},
			},
			[]int{},
			false,
		},
		{
			"empty",
			args{
				[]int{-1},
			},
			nil,
			true,
		},
		{
			"single",
			args{
				[]int{3},
			},
			[]int{3},
			false,
		},
		{
			"reverse",
			args{
				[]int{5, 4, 3, 2, 1},
			},
			[]int{1, 2, 3, 4, 5},
			false,
		},
		{
			"equal1",
			args{
				[]int{0, 2, 3, 0, 5, 4, 5},
			},
			[]int{0, 0, 2, 3, 4, 5, 5},
			false,
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			got, err := CountingSort(tt.args.e)
			if (err != nil) != tt.wantErr {
				t.Errorf("CountingSort() error = %v, wantErr %v", err, tt.wantErr)
				return
			}
			if !reflect.DeepEqual(got, tt.want) {
				t.Errorf("CountingSort() got = %v, want %v", got, tt.want)
			}
		})
	}
}
