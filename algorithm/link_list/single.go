package list

type Node struct {
	value int
	next  *Node
}

func (n *Node) Value() int {
	return n.value
}

func (n *Node) Next() *Node {
	return n.next
}

type SingleList struct {
	head *Node
	tail *Node
	len  int64
}

func NewSingle() *SingleList {
	p := &Node{0, nil}
	return &SingleList{
		head: p,
		tail: p,
		len:  0,
	}
}

func (s *SingleList) Len() int64 {
	return s.len
}

func (s *SingleList) Previous(e *Node) *Node {
	p := s.head
	for p != nil && p.next.value != e.value {
		p = p.next
	}
	return p
}

func (s *SingleList) InsertBefore(v int, e *Node) {
	s.insertValue(v, s.Previous(e))
}

func (s *SingleList) InsertAfter(v int, e *Node) {
	s.insertValue(v, e)
}

func (s *SingleList) PushBack(v int) {
	s.tail = s.insertValue(v, s.tail)
}

func (s *SingleList) PushFront(v int) {
	s.insertValue(v, s.head)
}

func (s *SingleList) insertValue(v int, at *Node) *Node{
	return s.insert(&Node{value: v}, at)
}

func (s *SingleList) insert(e, at *Node) *Node {
	e.next = at.next
	at.next = e
	s.len++
	return e
}

func (s *SingleList) Delete(e *Node) {
	pre := s.Previous(e)
	pre.next = e.next
	s.len--
}

func (s *SingleList) Front() *Node {
	if s.len == 0 {
		return nil
	}
	return s.head.next
}

func (s *SingleList) Back() *Node {
	if s.len == 0 {
		return nil
	}
	return s.tail
}

func (s *SingleList) Find(v int) *Node {
	e := s.head.next
	for e != nil {
		if e.Value() == v {
			return e
		}
		e = e.Next()
	}
	return nil
}

