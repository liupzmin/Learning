package greedy

import (
	"testing"
)

func TestHandOut(t *testing.T) {
	type args struct {
		s     []*child
		candy []int
	}
	tests := []struct {
		name string
		args args
		want int
	}{
		// TODO: Add test cases.
		{
			name: "first",
			args: args{
				s: []*child{
					{
						name:   "alan",
						demand: 1,
					},
					{
						name:   "bob",
						demand: 10,
					},
					{
						name:   "can",
						demand: 6,
					},
					{
						name:   "dick",
						demand: 4,
					},
					{
						name:   "ellen",
						demand: 2,
					},
					{
						name:   "frank",
						demand: 5,
					},
				},
				candy: []int{6, 3, 4, 1},
			},
			want: 4,
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := HandOutDESC(tt.args.s, tt.args.candy); got != tt.want {
				t.Errorf("HandOutASC() = %v, want %v", got, tt.want)
			}
		})
	}
}

func TestHandOutASC(t *testing.T) {
	type args struct {
		s     []*child
		candy []int
	}
	tests := []struct {
		name string
		args args
		want int
	}{
		// TODO: Add test cases.
		{
			name: "first",
			args: args{
				s: []*child{
					{
						name:   "alan",
						demand: 1,
					},
					{
						name:   "bob",
						demand: 10,
					},
					{
						name:   "can",
						demand: 6,
					},
					{
						name:   "dick",
						demand: 4,
					},
					{
						name:   "ellen",
						demand: 2,
					},
					{
						name:   "frank",
						demand: 5,
					},
				},
				candy: []int{6, 3, 4, 1},
			},
			want: 4,
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := HandOutASC(tt.args.s, tt.args.candy); got != tt.want {
				t.Errorf("HandOutASC() = %v, want %v", got, tt.want)
			}
		})
	}
}
