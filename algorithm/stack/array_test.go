package stack

import "testing"

func TestNewArrayStack(t *testing.T) {
	s := NewArrayStack(3)
	if s.Len() != 0 {
		t.Errorf("wrong len")
	}

	if s.Cap() != 3 {
		t.Errorf("wrong cap")
	}
}

func TestArrayStack_Push(t *testing.T) {
	s := NewArrayStack(3)
	_ = s.Push(1)
	if s.Len() != 1 {
		t.Errorf("push wrong len")
	}
	_ = s.Push(2)
	_ = s.Push(4)
	if s.Len() != 3 {
		t.Errorf("push wrong len")
	}
	e := s.Push(2)
	if e == nil {
		t.Errorf("should be full")
	}
}

func TestArrayStack_Pop(t *testing.T) {
	s := NewArrayStack(2)
	_ = s.Push(1)
	v, _ := s.Pop()
	if v.(int) != 1 {
		t.Errorf("wrong pop")
	}

	if s.Len() != 0 {
		t.Errorf("should minus")
	}

	_, e := s.Pop()
	if e == nil {
		t.Errorf("should be empty")
	}
}