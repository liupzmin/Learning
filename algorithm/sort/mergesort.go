package sort

// MSort 归并排序，分成两部分，然后将排序后的两个集合合并，其实排序动作是靠合并来完成的，MSort只负责分集合，分到最小后交给merge排序
// 分治思想
// 平均时间复杂度 ，最好，最坏的情况都是O(nlogn)
// 空间复杂度 O(n) 非原地排序
// 稳定排序
func MSort(s *[]int, left, right int) {
	if left >= right {
		return
	}

	center := (left + right) / 2

	MSort(s, left, center)
	MSort(s, center+1, right)
	Merge(s, left, center+1, right)
}

func Merge(s *[]int, lPos, rPos, rightEnd int) {
	length := rightEnd - lPos + 1
	leftEnd := rPos - 1

	var (
		ns []int
		e  = *s
	)
	for lPos <= leftEnd && rPos <= rightEnd {
		if e[lPos] <= e[rPos] {
			ns = append(ns, e[lPos])
			lPos++
		} else {
			ns = append(ns, e[rPos])
			rPos++
		}
	}

	for lPos <= leftEnd {
		ns = append(ns, e[lPos])
		lPos++
	}

	for rPos <= rightEnd {
		ns = append(ns, e[rPos])
		rPos++
	}

	// 这里是将临时数组中排序好的值拷贝到对应的原数组区间
	nsEnd := len(ns) - 1
	for i := 0; i < length; i++ {
		e[rightEnd] = ns[nsEnd]
		rightEnd--
		nsEnd--
	}
}
