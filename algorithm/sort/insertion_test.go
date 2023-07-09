package sort

import (
	"reflect"
	"testing"
)

func Test_insertionSort(t *testing.T) {
	type args struct {
		s *[]int
	}
	tests := []struct {
		name string
		args args
		want []int
	}{
		// TODO: Add test cases.
		{
			"equal1",
			args{
				&[]int{4, 2, 1, 3},
			},
			[]int{1, 2, 3, 4},
		},
		{
			"equal2",
			args{
				&[]int{43, 22, 11, 3},
			},
			[]int{3, 11, 22, 43},
		},
		{
			"equal3",
			args{
				&[]int{2},
			},
			[]int{2},
		},
		{
			"equal4",
			args{
				&[]int{43, 22},
			},
			[]int{22, 43},
		},
		{
			"equal5",
			args{
				&[]int{43, 22, 11},
			},
			[]int{11, 22, 43},
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			insertionSort(tt.args.s)
			if !reflect.DeepEqual(*tt.args.s, tt.want) {
				t.Errorf("insertionSort() = %v, want %v", *tt.args.s, tt.want)
			}
		})
	}
}
