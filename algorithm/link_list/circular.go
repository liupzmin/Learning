package list

type Ring struct {
	head *Element
	len int
}

func NewRing() *Ring {
	p := &Element{}
	p.next = p
	p.prev = p
	return &Ring{
		head: p,
		len:  0,
	}
}

func (r *Ring) Len() int{
	return r.len
}

func (r *Ring) PushBack(v interface{}) *Element {
	return r.insertValue(v, r.head.prev)
}

func (r *Ring) PushFront(v interface{}) *Element {
	return r.insertValue(v, r.head)
}

func (r *Ring) InsertBefore(v interface{}, at *Element) *Element{
	return r.insertValue(v, at.prev)
}

func (r *Ring) InsertAfter(v interface{},at *Element) *Element {
	return r.insertValue(v, at)
}

func (r *Ring) Delete(e *Element){
	e.prev.next = e.next
	e.next.prev = e.prev
	r.len--
}

func (r *Ring) insertValue(v interface{}, at *Element) *Element {
	return r.insert(&Element{Value: v}, at)
}

func (r *Ring) insert(e, at *Element) *Element {
	e.prev = at
	e.next = at.next
	e.prev.next = e
	e.next.prev = e
	r.len++
	return e
}

func (r *Ring) Front() *Element{
	if r.len == 0 {
		return nil
	}
	return r.head.next
}

func (r *Ring) Back() *Element{
	if r.len == 0 {
		return nil
	}
	return r.head.prev
}

func (r *Ring) Find(v interface{}) *Element {
	e := r.head.next
	for e != nil {
		if e.Value == v {
			return e
		}
		e = e.next
	}
	return nil
}
