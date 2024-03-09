package tree

import (
	"fmt"
	"testing"
)

func TestAVLTree_MidTraverse(t *testing.T) {
	avl := NewAVLTree()

	avl.Insert(4)
	avl.Insert(2)
	avl.Insert(1)
	avl.Insert(3)
	avl.Insert(6)
	avl.Insert(5)
	avl.Insert(7)
	avl.Insert(16)

	s := avl.InOrderTraverse()

	for _, v := range s {
		t.Logf("%d\n", v.value)
	}
	fmt.Println()

	s = avl.PreOrderTraverse()

	for _, v := range s {
		t.Logf("%d\n", v.value)
	}
	fmt.Println()
	s = avl.PostOrderTraverse()

	for _, v := range s {
		t.Logf("%d\n", v.value)
	}

}
