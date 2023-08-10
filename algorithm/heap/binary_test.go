package heap

import (
	"reflect"
	"testing"
)

func TestMaxHeap_Insert(t *testing.T) {
	type args struct {
		e []int
	}
	tests := []struct {
		name string
		args args
		want []int
	}{
		// TODO: Add test cases.
		{
			"1",
			args{
				[]int{1},
			},
			[]int{1},
		},
		{
			"2",
			args{
				[]int{1, 2},
			},
			[]int{2, 1},
		},
		{
			"3",
			args{
				[]int{1, 2, 3},
			},
			[]int{3, 1, 2},
		},
		{
			"4",
			args{
				[]int{1, 2, 3, 4},
			},
			[]int{4, 3, 2, 1},
		},
		{
			"5",
			args{
				[]int{1, 2, 3, 4, 5},
			},
			[]int{5, 4, 2, 1, 3},
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			m := NewMaxHeap(len(tt.args.e))
			for _, v := range tt.args.e {
				if err := m.Insert(v); err != nil {
					t.Errorf("Insert() error = %v", err)
				}
			}
			if !reflect.DeepEqual(m.Heap(), tt.want) {
				t.Errorf("Insert() real = %v, want %v", m.Heap(), tt.want)
			}
		})
	}
}

func TestMaxHeap_DeleteMax(t *testing.T) {
	m := NewMaxHeap(5)
	a := []int{1, 2, 3, 4, 5}
	for _, v := range a {
		if err := m.Insert(v); err != nil {
			t.Errorf("Insert() error = %v", err)
		}
	}
	tests := []struct {
		name string
		want []int
	}{
		// TODO: Add test cases.
		{
			"1",
			[]int{4, 3, 2, 1},
		},
		{
			"2",
			[]int{3, 1, 2},
		},
		{
			"3",
			[]int{2, 1},
		},
		{
			"4",
			[]int{1},
		},
		{
			"5",
			[]int{},
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {

			_, err := m.DeleteMax()
			if err != nil {
				t.Errorf("DeleteMax() error = %v", err)
				return
			}
			if !reflect.DeepEqual(m.Heap(), tt.want) {
				t.Errorf("DeleteMax() got = %v, want %v", m.Heap(), tt.want)
			}
		})
	}
}

func TestMaxHeap_DeleteMaxRecur(t *testing.T) {
	m := NewMaxHeap(5)
	a := []int{1, 2, 3, 4, 5}
	for _, v := range a {
		if err := m.Insert(v); err != nil {
			t.Errorf("Insert() error = %v", err)
		}
	}
	tests := []struct {
		name string
		want []int
	}{
		// TODO: Add test cases.
		{
			"1",
			[]int{4, 3, 2, 1},
		},
		{
			"2",
			[]int{3, 1, 2},
		},
		{
			"3",
			[]int{2, 1},
		},
		{
			"4",
			[]int{1},
		},
		{
			"5",
			[]int{},
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {

			_, err := m.DeleteMaxRecur()
			if err != nil {
				t.Errorf("DeleteMax() error = %v", err)
				return
			}
			if !reflect.DeepEqual(m.Heap(), tt.want) {
				t.Errorf("DeleteMax() got = %v, want %v", m.Heap(), tt.want)
			}
		})
	}
}

func TestNewMaxHeapWithSlice(t *testing.T) {
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
			"1",
			args{
				&[]int{2, 6, 9, 12, 56},
			},
			[]int{56, 12, 9, 2, 6},
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := NewMaxHeapWithSlice(tt.args.s); !reflect.DeepEqual(got.Heap(), tt.want) {
				t.Errorf("NewMaxHeapWithSlice() = %v, want %v", got.Heap(), tt.want)
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
			Sort(tt.args.s)
			if !reflect.DeepEqual(*tt.args.s, tt.want) {
				t.Errorf("heapSort() = %v, want %v", *tt.args.s, tt.want)
			}
		})
	}
}
