package sort

import "fmt"

// CountingSort 计数排序
// 基本思想：对每一个输入元素x，确定小于x的元素个数。利用这一信息，就可以直接把x放到它在输出数组中的位置了
// 时间复杂度 O(n) 属于线性排序、稳定排序、非原地排序
func CountingSort(e []int) ([]int, error) {
	if len(e) == 0 {
		return e, nil
	}

	// 找出数组中的最大值
	maxValue := e[0]
	for i := 0; i < len(e); i++ {
		if e[i] < 0 {
			return nil, fmt.Errorf("negative value")
		}
		if e[i] > maxValue {
			maxValue = e[i]
		}
	}

	maxValue++
	c := make([]int, maxValue)
	b := make([]int, len(e))

	for i := 0; i < len(e); i++ {
		c[e[i]] = c[e[i]] + 1
	}

	for i := 1; i < maxValue; i++ {
		c[i] = c[i-1] + c[i]
	}

	// 从后往前遍历，保证稳定性
	for i := len(e) - 1; i >= 0; i-- {
		b[c[e[i]]-1] = e[i]
		c[e[i]]--
	}
	return b, nil
}
