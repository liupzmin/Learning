package sort

import (
	"reflect"
	"testing"
)

func TestRadixSort(t *testing.T) {
	type args struct {
		s []int
		d int
	}
	tests := []struct {
		name    string
		args    args
		want    []int
		wantErr bool
	}{
		// TODO: Add test cases.
		{
			"first",
			args{
				s: []int{15716187013, 15051130729},
				d: 11,
			},
			[]int{15051130729, 15716187013},
			false,
		},
		{
			"two",
			args{
				s: []int{321, 123},
				d: 3,
			},
			[]int{123, 321},
			false,
		},
		{
			"empty",
			args{
				s: []int{},
				d: 0,
			},
			[]int{},
			false,
		},
		{
			"one",
			args{
				s: []int{321},
				d: 3,
			},
			[]int{321},
			false,
		},
		{
			"nag",
			args{
				s: []int{-321},
				d: 3,
			},
			nil,
			true,
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			got, err := RadixSort(tt.args.s, tt.args.d)
			if (err != nil) != tt.wantErr {
				t.Errorf("RadixSort() error = %v, wantErr %v", err, tt.wantErr)
				return
			}
			if !reflect.DeepEqual(got, tt.want) {
				t.Errorf("RadixSort() got = %v, want %v", got, tt.want)
			}
		})
	}
}
