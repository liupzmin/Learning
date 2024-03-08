package tree

import (
	"testing"
)

func TestBinarySearchTree_MidTraverse(t *testing.T) {
	tr := NewBinarySearchTree()

	tr.Insert(20)
	tr.Insert(7)
	tr.Insert(8)
	tr.Insert(11)
	tr.Insert(22)
	tr.Insert(6)
	tr.Insert(30)

	s := tr.MidTraverse()

	for _, v := range s {
		t.Logf("%d\n", v.value)
	}

}
