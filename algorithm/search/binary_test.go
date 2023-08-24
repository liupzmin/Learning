package search

import "testing"

func TestBinarySearch(t *testing.T) {
	type args struct {
		e []int
		v int
	}
	tests := []struct {
		name string
		args args
		want int
	}{
		// TODO: Add test cases.
		{
			"normal",
			args{
				[]int{1, 2, 3, 4, 5, 6},
				5,
			},
			4,
		},
		{
			"not_exist",
			args{
				[]int{1, 2, 3, 4, 5, 6},
				9,
			},
			-1,
		},
		{
			"first",
			args{
				[]int{1, 2, 3, 4, 5, 6},
				1,
			},
			0,
		},
		{
			"last",
			args{
				[]int{1, 2, 3, 4, 5, 6},
				6,
			},
			5,
		},
		{
			"empty",
			args{
				[]int{},
				9,
			},
			-1,
		},
		{
			"only_one",
			args{
				[]int{6},
				6,
			},
			0,
		},
		{
			"repeat",
			args{
				[]int{1, 2, 3, 4, 4, 5, 6, 6},
				4,
			},
			3,
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := BinarySearch(tt.args.e, tt.args.v); got != tt.want {
				t.Errorf("BinarySearch() = %v, want %v", got, tt.want)
			}
		})
	}
}

func TestBinarySearchRecursive(t *testing.T) {
	type args struct {
		e     []int
		v     int
		left  int
		right int
	}
	tests := []struct {
		name string
		args args
		want int
	}{
		// TODO: Add test cases.
		{
			"normal",
			args{
				[]int{1, 2, 3, 4, 5, 6},
				5,
				0,
				5,
			},
			4,
		},
		{
			"not_exist",
			args{
				[]int{1, 2, 3, 4, 5, 6},
				9,
				0,
				5,
			},
			-1,
		},
		{
			"first",
			args{
				[]int{1, 2, 3, 4, 5, 6},
				1,
				0,
				5,
			},
			0,
		},
		{
			"last",
			args{
				[]int{1, 2, 3, 4, 5, 6},
				6,
				0,
				5,
			},
			5,
		},
		{
			"empty",
			args{
				[]int{},
				9,
				0,
				0,
			},
			-1,
		},
		{
			"only_one",
			args{
				[]int{6},
				6,
				0,
				0,
			},
			0,
		},
		{
			"repeat",
			args{
				[]int{1, 2, 3, 4, 4, 5, 6, 6},
				4,
				0,
				7,
			},
			3,
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := BinarySearchRecursive(tt.args.e, tt.args.v, tt.args.left, tt.args.right); got != tt.want {
				t.Errorf("BinarySearchRecursive() = %v, want %v", got, tt.want)
			}
		})
	}
}

func TestBinarySearchFirstEqual(t *testing.T) {
	type args struct {
		e []int
		v int
	}
	tests := []struct {
		name string
		args args
		want int
	}{
		// TODO: Add test cases.
		{
			"normal",
			args{
				[]int{1, 2, 3, 4, 5, 6},
				5,
			},
			4,
		},
		{
			"not_exist",
			args{
				[]int{1, 2, 3, 4, 5, 6},
				9,
			},
			-1,
		},
		{
			"first",
			args{
				[]int{1, 2, 3, 4, 5, 6},
				1,
			},
			0,
		},
		{
			"last",
			args{
				[]int{1, 2, 3, 4, 5, 6},
				6,
			},
			5,
		},
		{
			"empty",
			args{
				[]int{},
				9,
			},
			-1,
		},
		{
			"only_one",
			args{
				[]int{6},
				6,
			},
			0,
		},
		{
			"repeat1",
			args{
				[]int{1, 2, 3, 4, 4, 5, 6, 6},
				4,
			},
			3,
		},
		{
			"repeat2",
			args{
				[]int{1, 2, 3, 4, 4, 5, 6, 6},
				6,
			},
			6,
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := BinarySearchFirstEqual(tt.args.e, tt.args.v); got != tt.want {
				t.Errorf("BinarySearchFirstEqual() = %v, want %v", got, tt.want)
			}
		})
	}
}

func TestBinarySearchLastEqual(t *testing.T) {
	type args struct {
		e []int
		v int
	}
	tests := []struct {
		name string
		args args
		want int
	}{
		// TODO: Add test cases.
		{
			"normal",
			args{
				[]int{1, 2, 3, 4, 5, 6},
				5,
			},
			4,
		},
		{
			"not_exist",
			args{
				[]int{1, 2, 3, 4, 5, 6},
				9,
			},
			-1,
		},
		{
			"first",
			args{
				[]int{1, 2, 3, 4, 5, 6},
				1,
			},
			0,
		},
		{
			"last",
			args{
				[]int{1, 2, 3, 4, 5, 6},
				6,
			},
			5,
		},
		{
			"empty",
			args{
				[]int{},
				9,
			},
			-1,
		},
		{
			"only_one",
			args{
				[]int{6},
				6,
			},
			0,
		},
		{
			"repeat1",
			args{
				[]int{1, 2, 3, 4, 4, 5, 6, 6},
				4,
			},
			4,
		},
		{
			"repeat2",
			args{
				[]int{1, 2, 3, 4, 4, 5, 6, 6},
				6,
			},
			7,
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := BinarySearchLastEqual(tt.args.e, tt.args.v); got != tt.want {
				t.Errorf("BinarySearchLastEqual() = %v, want %v", got, tt.want)
			}
		})
	}
}

func TestBinarySearchFirstGreaterEqual(t *testing.T) {
	type args struct {
		e []int
		v int
	}
	tests := []struct {
		name string
		args args
		want int
	}{
		// TODO: Add test cases.
		{
			"normal",
			args{
				[]int{1, 2, 3, 4, 5, 6},
				5,
			},
			4,
		},
		{
			"not_exist",
			args{
				[]int{1, 2, 3, 4, 5, 6},
				9,
			},
			-1,
		},
		{
			"first",
			args{
				[]int{1, 2, 3, 4, 5, 6},
				1,
			},
			0,
		},
		{
			"last",
			args{
				[]int{1, 2, 3, 4, 5, 6},
				6,
			},
			5,
		},
		{
			"empty",
			args{
				[]int{},
				9,
			},
			-1,
		},
		{
			"only_one",
			args{
				[]int{6},
				6,
			},
			0,
		},
		{
			"repeat1",
			args{
				[]int{1, 2, 3, 4, 4, 5, 6, 6},
				4,
			},
			3,
		},
		{
			"repeat2",
			args{
				[]int{1, 2, 3, 4, 4, 5, 6, 6},
				6,
			},
			6,
		},
		{
			"repeat3",
			args{
				[]int{1, 2, 3, 4, 4, 8, 15, 26},
				7,
			},
			5,
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := BinarySearchFirstGreaterEqual(tt.args.e, tt.args.v); got != tt.want {
				t.Errorf("BinarySearchFirstGreaterEqual() = %v, want %v", got, tt.want)
			}
		})
	}
}

func TestBinarySearchLastLessEqual(t *testing.T) {
	type args struct {
		e []int
		v int
	}
	tests := []struct {
		name string
		args args
		want int
	}{
		// TODO: Add test cases.
		{
			"normal",
			args{
				[]int{1, 2, 3, 4, 5, 6},
				5,
			},
			4,
		},
		{
			"not_exist",
			args{
				[]int{1, 2, 3, 4, 5, 6},
				0,
			},
			-1,
		},
		{
			"first",
			args{
				[]int{1, 2, 3, 4, 5, 6},
				1,
			},
			0,
		},
		{
			"last",
			args{
				[]int{1, 2, 3, 4, 5, 6},
				6,
			},
			5,
		},
		{
			"empty",
			args{
				[]int{},
				9,
			},
			-1,
		},
		{
			"only_one",
			args{
				[]int{6},
				6,
			},
			0,
		},
		{
			"repeat1",
			args{
				[]int{1, 2, 3, 4, 4, 5, 6, 6},
				4,
			},
			4,
		},
		{
			"repeat2",
			args{
				[]int{1, 2, 3, 4, 4, 5, 6, 6},
				6,
			},
			7,
		},
		{
			"repeat3",
			args{
				[]int{1, 2, 3, 4, 4, 8, 15, 26},
				7,
			},
			4,
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := BinarySearchLastLessEqual(tt.args.e, tt.args.v); got != tt.want {
				t.Errorf("BinarySearchLastLessEqual() = %v, want %v", got, tt.want)
			}
		})
	}
}
