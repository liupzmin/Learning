package stack

import (
	"errors"
)

type ArrayStack struct {
	container []interface{}
	cap, len  int
}

func NewArrayStack(cap int) *ArrayStack {
	s := new(ArrayStack)
	c := make([]interface{}, cap)
	s.container = c
	s.cap = cap
	return s
}

func (as *ArrayStack) Len() int {
	return as.len
}

func (as *ArrayStack) Cap() int {
	return as.cap
}

func (as *ArrayStack) Push(v interface{}) error {
	if as.len == as.cap {
		return errors.New("out of space")
	}
	as.container[as.len] = v
	as.len++
	return nil
}

func (as *ArrayStack) Pop() (interface{}, error) {
	if as.len == 0 {
		return nil, errors.New("empty")
	}
	v := as.container[as.len-1]
	as.len--
	return v, nil
}
