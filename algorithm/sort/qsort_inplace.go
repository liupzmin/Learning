package sort

// median3InPlace 三数中值分割法，返回枢纽元
func median3InPlace(s *[]int, left, right int) int {
	center := (left + right) / 2

	e := *s

	if e[left] > e[center] {
		e[left], e[center] = e[center], e[left]
	}

	if e[left] > e[right] {
		e[left], e[right] = e[right], e[left]
	}

	if e[center] > e[right] {
		e[center], e[right] = e[right], e[center]
	}

	// 将枢纽元移动到 right - 1 处，因为right已经 > 枢纽元
	e[center], e[right-1] = e[right-1], e[center]

	// 返回枢纽元，准备分割{left+1, right - 2}
	return e[right-1]
}

// quickSortInPlace 快速排序
// 平均时间复杂度O(nlogn)，极端情况为 O(n²)
// 空间复杂度 O(1) 原地排序
// 不稳定排序
func quickSortInPlace(s *[]int, left, right int) {
	e := *s

	// 递归的终止条件
	if (right - left + 1) < 2 {
		return
	}

	pivot := median3InPlace(s, left, right)

	// 处理排序集合 2 个 或者 3 个 的情况
	switch right - left + 1 {
	case 3:
		return
	case 2:
		if e[left] > e[right] {
			e[left], e[right] = e[right], e[left]
		}
		return
	}

	// 将 {left+1, right - 2} 的数与枢纽元比较
	i := left + 1
	j := right - 2

	for {
		// 左边停止在>=枢纽元的位置
		for e[i] < pivot {
			i++
		}
		// 右边停止在<=枢纽元的位置
		for e[j] > pivot {
			j--
		}
		// 如果此时i和j交错，则退出
		if i >= j {
			break
		}
		// 否则交换两个数
		e[i], e[j] = e[j], e[i]
	}

	// 分割完了之后，将i和枢纽元的位置交换，也就完成以枢纽元为基准的分割，左边都是小于或等于枢纽元的数，右边都是大于或等于
	// 注意，我们在比较的时候在等于枢纽元的地方停止并做交换，相对均衡的将等于枢纽元的值分布于枢纽元的两侧
	e[i], e[right-1] = e[right-1], e[i]

	// 递归
	quickSortInPlace(s, left, i-1)
	quickSortInPlace(s, i+1, right)
}
