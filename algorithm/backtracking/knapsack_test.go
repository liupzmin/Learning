package backtracking

import "testing"

func TestSteal(t *testing.T) {
	type args struct {
		i     int
		cw    int
		w     int
		items []int
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
				i:     0,
				cw:    0,
				w:     10,
				items: []int{2, 3, 5, 7},
			},
			10,
		},
		{
			"2",
			args{
				i:     0,
				cw:    0,
				w:     10,
				items: []int{4, 3, 5, 9},
			},
			9,
		},
		{
			"3",
			args{
				i:     0,
				cw:    0,
				w:     10,
				items: []int{1, 3, 5, 7},
			},
			10,
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			MaxWeight = 0
			Steal(tt.args.i, tt.args.cw, tt.args.w, tt.args.items)
			if MaxWeight != tt.want {
				t.Errorf("faild, MaxWeight:%d,except:%d", MaxWeight, tt.want)
			}
		})
	}
}
