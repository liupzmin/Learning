package sort

import (
	"reflect"
	"testing"
)

func Test_maxHeapify(t *testing.T) {
	type args struct {
		s    *[]int
		size int
		i    int
	}
	tests := []struct {
		name string
		args args
		want []int
	}{
		// TODO: Add test cases.
		{
			"first",
			args{
				&[]int{4, 9, 7, 10, 3, 6},
				6,
				1,
			},
			[]int{4, 10, 7, 9, 3, 6},
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			maxHeapify(tt.args.s, tt.args.size, tt.args.i)
			if !reflect.DeepEqual(*tt.args.s, tt.want) {
				t.Errorf("maxHeapify() = %v, want %v", *tt.args.s, tt.want)
			}
		})
	}
}

func Test_buildMaxHeap(t *testing.T) {
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
			"first",
			args{
				&[]int{4, 9, 7, 10, 3, 6},
			},
			[]int{10, 9, 7, 4, 3, 6},
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			buildMaxHeap(tt.args.s)
			if !reflect.DeepEqual(*tt.args.s, tt.want) {
				t.Errorf("buildMaxHeap() = %v, want %v", *tt.args.s, tt.want)
			}
		})
	}
}

func Test_heapSort(t *testing.T) {
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
			heapSort(tt.args.s)
			if !reflect.DeepEqual(*tt.args.s, tt.want) {
				t.Errorf("heapSort() = %v, want %v", *tt.args.s, tt.want)
			}
		})
	}
}
