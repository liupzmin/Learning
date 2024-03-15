package greedy

import (
	"slices"
	"sort"
)

/*
我们有 m 个糖果和 n 个孩子。我们现在要把糖果分给这些孩子吃，但是糖果少，孩子多（m<n），
所以糖果只能分配给一部分孩子。每个糖果的大小不等，这 m 个糖果的大小分别是 s1，s2，s3，……，sm。
除此之外，每个孩子对糖果大小的需求不同，只有糖果的大小大于等于孩子的对糖果大小的需求的时，孩子才得到满足。
假设这 n 个孩子对糖果大小的需求分别是 g1，g2，g3，……，gn。且每个孩子只分一个糖果，如何分配糖果，
能尽可能满足最多数量的孩子？
*/

type child struct {
	name   string
	demand int
	get    int
}

func HandOutDESC(s []*child, candy []int) int {
	slices.SortFunc(s, func(a, b *child) int {
		if a.demand < b.demand {
			return 1
		}
		if a.demand > b.demand {
			return -1
		}
		return 0
	})

	sort.Slice(candy, func(i, j int) bool {
		return sort.IntSlice(candy).Less(j, i)
	})
	var count int
	for _, g := range candy {
		for _, c := range s {
			if g >= c.demand {
				c.get = g
				count++
				break
			}
		}
	}

	return count
}

func HandOutASC(s []*child, candy []int) int {
	slices.SortFunc(s, func(a, b *child) int {
		if a.demand < b.demand {
			return -1
		}
		if a.demand > b.demand {
			return 1
		}
		return 0
	})

	slices.Sort(candy)
	var count int
	for _, g := range candy {
		for _, c := range s {
			if g >= c.demand {
				c.get = g
				count++
				break
			}
		}
	}

	return count
}
