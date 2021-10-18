package list

import "testing"

func TestNewRing(t *testing.T) {
	list := NewRing()
	if list.Len() != 0 {
		t.Errorf("wrong len")
	}
}

func TestRing_Front_Nil(t *testing.T) {
	list := NewRing()
	if list.Front() != nil {
		t.Errorf("nil front failed")
	}
}

func TestRing_Back_Nil(t *testing.T) {
	list := NewRing()
	if list.Back() != nil {
		t.Errorf("nil back failed")
	}
}

func TestRing_PushBack(t *testing.T) {
	l := NewRing()
	l.PushBack(1)
	e := l.Back()
	if e.Value.(int) != 1 {
		t.Errorf("push back wrong")
	}
	l.PushBack(2)
	if l.Back().Value.(int) != 2 {
		t.Errorf("push back wrong")
	}

	s := make([]int,0)
	for e := l.Front();e != l.Front().Prev();e = e.Next() {
		s = append(s, e.Value.(int))
	}

	t.Logf("list: %v", s)
}

func TestRing_PushFront(t *testing.T) {
	l := NewRing()
	l.PushFront(1)
	e := l.Front()
	if e.Value.(int) != 1 {
		t.Errorf("push front wrong")
	}
	l.PushFront(2)
	if l.Front().Value.(int) != 2 {
		t.Errorf("push front wrong")
	}

	l.PushFront(3)
	if l.Front().Value.(int) != 3 {
		t.Errorf("push front wrong")
	}

	s := make([]int,0)
	for e := l.Front();e != l.Front().Prev();e = e.Next() {
		s = append(s, e.Value.(int))
	}

	t.Logf("list: %v", s)
}

func TestRing_Delete(t *testing.T) {
	l := NewRing()
	l.PushBack(10)
	l.PushBack(11)
	l.PushBack(12)
	l.PushBack(13)
	l.PushBack(14)
	l.PushBack(15)

	if l.Len() != 6 {
		t.Errorf("wrong len")
	}

	e := l.Find(13)
	l.Delete(e)

	if l.Len() != 5 {
		t.Errorf("delete failed")
	}

	s := make([]int,0)
	for e := l.Front();e != l.Front().Prev();e = e.Next() {
		s = append(s, e.Value.(int))
	}

	t.Logf("list: %v", s)
}

func TestRing_InsertBefore(t *testing.T) {
	l := NewRing()
	l.PushBack(10)
	l.PushBack(11)
	l.PushBack(12)
	l.PushBack(13)
	l.PushBack(14)
	l.PushBack(15)

	l.InsertBefore(100, l.Front())

	if l.Front().Value != 100 {
		t.Errorf("insert before failed")
	}

	l.InsertBefore(101, l.Find(13))

	s := make([]int,0)
	for e := l.Front();e != l.Front().Prev();e = e.Next() {
		s = append(s, e.Value.(int))
	}

	t.Logf("list: %v", s)
}

func TestRing_InsertAfter(t *testing.T) {
	l := NewRing()
	l.PushBack(10)
	l.PushBack(11)
	l.PushBack(12)
	l.PushBack(13)
	l.PushBack(14)
	l.PushBack(15)

	l.InsertAfter(100, l.Front())

	if l.Front().Next().Value.(int) != 100 {
		t.Errorf("insert before failed")
	}

	s := make([]int,0)
	for e := l.Front();e != l.Front().Prev();e = e.Next() {
		s = append(s, e.Value.(int))
	}

	t.Logf("list: %v", s)
}