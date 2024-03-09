package tree

type AVLNode struct {
	value       int
	height      int
	left, right *AVLNode
}

func (an *AVLNode) Height() int {
	if an == nil {
		return -1
	}
	return an.height
}

type AVLTree struct {
	root *AVLNode
}

func NewAVLTree() *AVLTree {
	return &AVLTree{}
}

func (avl *AVLTree) Insert(v int) {
	avl.root = avl.insert(v, avl.root)
}

func (avl *AVLTree) insert(v int, t *AVLNode) *AVLNode {
	if t == nil {
		return &AVLNode{
			value:  v,
			height: 0,
		}
	}

	if v < t.value {
		t.left = avl.insert(v, t.left)
		diff := t.left.Height() - t.right.Height()
		if diff > 1 {
			if v < t.left.value {
				t = avl.singleRotateWithLeft(t)
			} else {
				t = avl.doubleRotateWithLeft(t)
			}

		}
		t.height = max(t.left.Height(), t.right.Height()) + 1

		return t
	}

	if v > t.value {
		t.right = avl.insert(v, t.right)
		diff := t.right.Height() - t.left.Height()
		if diff > 1 {
			if v > t.right.value {
				t = avl.singleRotateWithRight(t)
			} else {
				t = avl.doubleRotateWithRight(t)
			}

		}
		t.height = max(t.left.Height(), t.right.Height()) + 1

		return t
	}

	return t
}

func (avl *AVLTree) singleRotateWithLeft(t *AVLNode) *AVLNode {
	k1 := t.left
	t.left = k1.right
	k1.right = t

	t.height = max(t.left.Height(), t.right.Height()) + 1
	k1.height = max(k1.left.Height(), k1.right.Height()) + 1
	return k1
}

func (avl *AVLTree) singleRotateWithRight(t *AVLNode) *AVLNode {
	k2 := t.right
	t.right = k2.left
	k2.left = t

	t.height = max(t.left.Height(), t.right.Height()) + 1
	k2.height = max(k2.left.Height(), k2.right.Height()) + 1
	return k2
}

func (avl *AVLTree) doubleRotateWithLeft(t *AVLNode) *AVLNode {
	t.left = avl.singleRotateWithRight(t.left)
	return avl.singleRotateWithLeft(t)
}

func (avl *AVLTree) doubleRotateWithRight(t *AVLNode) *AVLNode {
	t.right = avl.singleRotateWithRight(t.right)
	return avl.singleRotateWithLeft(t)
}

func (avl *AVLTree) InOrderTraverse() []*AVLNode {
	return avl.inOrderTraverse(avl.root)
}

func (avl *AVLTree) inOrderTraverse(t *AVLNode) []*AVLNode {
	if t == nil {
		return nil
	}

	s := avl.inOrderTraverse(t.left)
	s = append(s, t)
	s = append(s, avl.inOrderTraverse(t.right)...)

	return s
}

func (avl *AVLTree) PreOrderTraverse() []*AVLNode {
	return avl.preOrderTraverse(avl.root)
}

func (avl *AVLTree) preOrderTraverse(t *AVLNode) []*AVLNode {
	if t == nil {
		return nil
	}

	s := append([]*AVLNode{t}, avl.preOrderTraverse(t.left)...)

	s = append(s, avl.preOrderTraverse(t.right)...)

	return s
}

func (avl *AVLTree) PostOrderTraverse() []*AVLNode {
	return avl.postOrderTraverse(avl.root)
}

func (avl *AVLTree) postOrderTraverse(t *AVLNode) []*AVLNode {
	if t == nil {
		return nil
	}

	s := avl.postOrderTraverse(t.left)

	s = append(s, avl.postOrderTraverse(t.right)...)

	s = append(s, t)

	return s
}
