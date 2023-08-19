package sort

import (
	"fmt"
	"math"
)

// RadixSort 基数排序
// 此例针对n个位数相同的整数进行排序、位数位d，每一个数位有k种可能（k不能太大）
// 先按最低有效位进行排序，直到最高位
// 为保证正确性，每位的排序算法必须稳定
// 时间复杂度o(n),稳定排序，非原地排序
func RadixSort(s []int, d int) ([]int, error) {
	var err error
	for i := 1; i <= d; i++ {
		// 使用计数排序
		s, err = CountingSortDigit(s, i)
		if err != nil {
			return nil, err
		}
	}
	return s, nil
}

func CountingSortDigit(e []int, d int) ([]int, error) {
	if len(e) == 0 {
		return e, nil
	}

	// 找出数组中的最大值
	maxValue := digitValue(e[0], d)
	for i := 0; i < len(e); i++ {
		if e[i] < 0 {
			return nil, fmt.Errorf("negative value")
		}
		if digitValue(e[i], d) > maxValue {
			maxValue = digitValue(e[i], d)
		}
	}

	maxValue++
	c := make([]int, maxValue)
	b := make([]int, len(e))

	for i := 0; i < len(e); i++ {
		c[digitValue(e[i], d)] = c[digitValue(e[i], d)] + 1
	}

	for i := 1; i < maxValue; i++ {
		c[i] = c[i-1] + c[i]
	}

	// 从后往前遍历，保证稳定性
	for i := len(e) - 1; i >= 0; i-- {
		b[c[digitValue(e[i], d)]-1] = e[i]
		c[digitValue(e[i], d)]--
	}
	return b, nil
}

func digitValue(v, d int) int {
	return (v / int(math.Pow10(d-1))) % 10
}
