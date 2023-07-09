package sort

// bubbleSort 冒泡排序，每次冒泡相邻两个数比较，共比较n-1次，共需冒泡 n 次
// 平均时间复杂度 O(n²)，最好的情况是O(n)，最坏的情况是O(n²)
// 空间复杂度 O(1) 原地排序
// 稳定排序
func bubbleSort(s *[]int) {
	e := *s
	num := len(*s)

	for i := num - 1; i >= 0; i-- {
		// 如果某次冒泡没有产生数据交换，说明所有数据已排序
		var flag bool
		for j := 0; j < i; j++ {
			if e[j+1] < e[j] {
				e[j+1], e[j] = e[j], e[j+1]
				flag = true
			}
		}
		if !flag {
			break
		}
	}
}
