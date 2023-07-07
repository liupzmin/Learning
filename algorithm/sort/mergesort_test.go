package sort

import (
	"reflect"
	"testing"
)

func TestMSort(t *testing.T) {
	type args struct {
		s     *[]int
		left  int
		right int
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
				0,
				3,
			},
			[]int{1, 2, 3, 4},
		},
		{
			"equal2",
			args{
				&[]int{43, 22, 11, 3},
				0,
				3,
			},
			[]int{3, 11, 22, 43},
		},
		{
			"equal3",
			args{
				&[]int{2},
				0,
				0,
			},
			[]int{2},
		},
		{
			"equal4",
			args{
				&[]int{43, 22},
				0,
				1,
			},
			[]int{22, 43},
		},
		{
			"equal5",
			args{
				&[]int{43, 22, 11},
				0,
				2,
			},
			[]int{11, 22, 43},
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			MSort(tt.args.s, tt.args.left, tt.args.right)
		})
		if !reflect.DeepEqual(*tt.args.s, tt.want) {
			t.Errorf("MSort() = %v, want %v", *tt.args.s, tt.want)
		}
	}
}
