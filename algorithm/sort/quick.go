package sort

// QuickSort 快速排序，分治算法的典范，本例非原地排序
func QuickSort(s []int) []int {
	if len(s) < 2 {
		return s
	}

	pivot, left, right := partition(s)

	left = append(QuickSort(left), pivot)

	return append(left, QuickSort(right)...)
}

// partition 取中间数并返回分割部分
func partition(s []int) (int, []int, []int) {
	pivot, pos := median3(s)
	var left, right, news []int
	if pos == len(s)-1 {
		news = s[:pos]
	} else {
		news = append(s[:pos], s[(pos+1):]...)
	}

	for _, v := range news {
		if v <= pivot {
			left = append(left, v)
		} else {
			right = append(right, v)
		}
	}
	return pivot, left, right
}

// median3  取中间数并返回其位置
func median3(s []int) (int, int) {
	if len(s) == 0 {
		return 0, 0
	}

	if len(s) <= 2 {
		return s[0], 0
	}
	center := s[(len(s)-1)/2]
	new := []int{s[0], center, s[len(s)-1]}

	if new[0] > new[1] {
		new[0], new[1] = new[1], new[0]
	}

	if new[1] > new[2] {
		new[1], new[2] = new[2], new[1]
	}

	if new[0] > new[1] {
		new[0], new[1] = new[1], new[0]
	}

	var position int
	switch new[1] {
	case s[0]:
		position = 0
	case s[len(s)-1]:
		position = len(s) - 1
	default:
		position = (len(s) - 1) / 2
	}

	return new[1], position
}
