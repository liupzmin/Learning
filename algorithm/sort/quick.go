package sort

// QuickSort 快速排序，分治算法的典范
func QuickSort(s []int) []int {
	if len(s) < 2 {
		return s
	}

	pivot := s[0]
	var left, right []int

	for _, v := range s[1:] {
		if v <= pivot {
			left = append(left, v)
		} else {
			right = append(right, v)
		}
	}

	left = append(QuickSort(left), pivot)

	return append(left, QuickSort(right)...)
}
