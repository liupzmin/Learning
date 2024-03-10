package dynamic_programing

import "testing"

func TestCutRod(t *testing.T) {
	p := []int{1, 5, 8, 9, 10, 17, 17, 20, 24, 30}
	type args struct {
		p []int
		n int
	}
	tests := []struct {
		name string
		args args
		want int
	}{
		// TODO: Add test cases.
		{
			"1",
			args{
				p: p,
				n: 1,
			},
			1,
		},
		{
			"2",
			args{
				p: p,
				n: 2,
			},
			5,
		},
		{
			"3",
			args{
				p: p,
				n: 3,
			},
			8,
		},
		{
			"4",
			args{
				p: p,
				n: 4,
			},
			10,
		},
		{
			"5",
			args{
				p: p,
				n: 5,
			},
			13,
		},
		{
			"6",
			args{
				p: p,
				n: 6,
			},
			17,
		},
		{
			"7",
			args{
				p: p,
				n: 7,
			},
			18,
		},
		{
			"8",
			args{
				p: p,
				n: 8,
			},
			22,
		},
		{
			"9",
			args{
				p: p,
				n: 9,
			},
			25,
		},
		{
			"10",
			args{
				p: p,
				n: 10,
			},
			30,
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := CutRod(tt.args.p, tt.args.n); got != tt.want {
				t.Errorf("CutRod() = %v, want %v", got, tt.want)
			}
		})
	}
}

func TestCutRod1(t *testing.T) {
	p := []int{1, 5, 8, 9, 10, 17, 17, 20, 24, 30, 34, 38, 42, 46, 50, 54, 58, 62, 64, 66, 68, 70, 74, 78, 82, 86, 90, 94, 96, 100, 102, 105}
	t.Logf("n=30, v=%d\n", CutRod(p, 32))
}

func TestMemorizedCutRod(t *testing.T) {
	p := []int{1, 5, 8, 9, 10, 17, 17, 20, 24, 30, 34, 38, 42, 46, 50, 54, 58, 62, 64, 66, 68, 70, 74, 78, 82, 86, 90, 94, 96, 100, 102, 105}
	s := make([]int, 32)
	t.Logf("n=30, v=%d\n", MemorizedCutRod(p, s, 32))
}

func TestBottomUpCutRod(t *testing.T) {
	p := []int{1, 5, 8, 9, 10, 17, 17, 20, 24, 30, 34, 38, 42, 46, 50, 54, 58, 62, 64, 66, 68, 70, 74, 78, 82, 86, 90, 94, 96, 100, 102, 105}
	v, lengths := BottomUpCutRod(p, 32)
	t.Logf("n=30, v=%d, lengths:%+v\n", v, lengths)
}
