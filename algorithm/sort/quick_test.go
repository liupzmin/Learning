package sort

import (
	"reflect"
	"testing"
)

func TestQuickSort(t *testing.T) {
	type args struct {
		s []int
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
				[]int{4, 2, 1, 3},
			},
			[]int{1, 2, 3, 4},
		},
		{
			"equal2",
			args{
				[]int{43, 22, 11, 3},
			},
			[]int{3, 11, 22, 43},
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := QuickSort(tt.args.s); !reflect.DeepEqual(got, tt.want) {
				t.Errorf("QuickSort() = %v, want %v", got, tt.want)
			}
		})
	}
}
