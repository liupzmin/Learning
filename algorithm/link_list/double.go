package list

type Element struct {
	prev,next *Element
	Value interface{}
}

func (e *Element) Next() *Element{
	return e.next
}

func (e *Element) Prev() *Element{
	return e.prev
}

type List struct {
	head,tail *Element
	len int
}

func New() *List {
	p := &Element{}
	return &List{
		head: p,
		tail: p,
		len:  0,
	}
}

func (l *List) Len() int{
	return l.len
}

func (l *List) insert(e, at *Element) *Element {
	e.prev = at
	e.next = at.next
	if at.next != nil {
		at.next.prev = e
	}
	at.next = e
	l.len++

	if e.next == nil {
		l.tail = e
	}
	return e
}

func (l *List) insertValue(v interface{}, at *Element) *Element {
	return l.insert(&Element{Value: v}, at)
}

func (l *List) PushFront(v interface{}) *Element {
	return l.insertValue(v, l.head)
}

func (l *List) PushBack(v interface{}) *Element{
	return l.insertValue(v, l.tail)
}

func (l *List) InsertBefore(v interface{}, at *Element) *Element{
	return l.insertValue(v, at.prev)
}

func (l *List) InsertAfter(v interface{}, at *Element) *Element{
	return l.insertValue(v, at)
}

func (l *List) Delete(e *Element) {
	e.prev.next = e.next
	if e != l.tail {
		e.next.prev = e.prev
	}
	l.len--
}

func (l *List) Front() *Element{
	if l.len == 0 {
		return nil
	}
	return l.head.next
}

func (l *List) Back() *Element{
	if l.len == 0 {
		return nil
	}
	return l.tail
}

func (l *List) Find(v interface{}) *Element {
	e := l.head.next
	for e != nil {
		if e.Value == v {
			return e
		}
		e = e.Next()
	}
	return nil
}