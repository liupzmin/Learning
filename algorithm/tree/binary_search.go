package tree

type Element struct {
	value       int
	left, right *Element
}

type BinarySearchTree struct {
	root *Element
}

func NewBinarySearchTree() *BinarySearchTree {
	return &BinarySearchTree{}
}

func (b *BinarySearchTree) Insert(v int) {
	b.root = b.insert(v, b.root)
}

func (b *BinarySearchTree) insert(v int, t *Element) *Element {
	if t == nil {
		return &Element{value: v}
	}

	if v < t.value {
		t.left = b.insert(v, t.left)
	}

	if v > t.value {
		t.right = b.insert(v, t.right)
	}
	return t
}

func (b *BinarySearchTree) Find(v int) *Element {
	return b.find(v, b.root)
}

func (b *BinarySearchTree) find(v int, t *Element) *Element {
	if t == nil {
		return nil
	}

	if v < t.value {
		return b.find(v, t.left)
	}

	if v > t.value {
		return b.find(v, t.right)
	}

	return t
}

func (b *BinarySearchTree) findMin(t *Element) *Element {
	if t == nil {
		return nil
	}

	if t.left == nil {
		return t
	}

	return b.findMin(t.left)
}

func (b *BinarySearchTree) Delete(v int) {
	b.root = b.delete(v, b.root)
}
func (b *BinarySearchTree) delete(v int, t *Element) *Element {
	if t == nil {
		return nil
	}

	if v < t.value {
		t.left = b.delete(v, t.left)
	}

	if v > t.value {
		t.right = b.delete(v, t.right)
	}

	if t.left == nil && t.right == nil {
		return nil
	}

	if t.left != nil && t.right != nil {
		tmp := b.findMin(t.right)
		t.right = b.delete(tmp.value, t.right)
	}

	if t.left == nil {
		return t.right
	}

	if t.right == nil {
		return t.left
	}

	return t
}

func (b *BinarySearchTree) MidTraverse() []*Element {
	return b.midTraverse(b.root)
}

func (b *BinarySearchTree) midTraverse(t *Element) []*Element {
	if t == nil {
		return nil
	}

	s := b.midTraverse(t.left)
	s = append(s, t)
	s = append(s, b.midTraverse(t.right)...)

	return s
}
