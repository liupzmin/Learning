package sort

import (
	"reflect"
	"testing"
)

func TestBucketSort(t *testing.T) {
	type args struct {
		e []int
		n int
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
				2,
			},
			[]int{1, 2, 3, 4},
		},
		{
			"equal2",
			args{
				[]int{43, 22, 11, 3},
				2,
			},
			[]int{3, 11, 22, 43},
		},
		{
			"equal3",
			args{
				[]int{2},
				1,
			},
			[]int{2},
		},
		{
			"empty",
			args{
				[]int{},
				1,
			},
			[]int{},
		},
		{
			"equal4",
			args{
				[]int{43, 22},
				2,
			},
			[]int{22, 43},
		},
		{
			"equal5",
			args{
				[]int{43, 22, 11},
				2,
			},
			[]int{11, 22, 43},
		},
		{
			"equal6",
			args{
				[]int{100, 4, 5, 3, 2, 1},
				2,
			},
			[]int{1, 2, 3, 4, 5, 100},
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := BucketSort(tt.args.e, tt.args.n); !reflect.DeepEqual(got, tt.want) {
				t.Errorf("BucketSort() = %v, want %v", got, tt.want)
			}
		})
	}
}
