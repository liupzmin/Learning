package sort

// selectionSort 选择排序，每次从剩余选项中选择最小元素与最左侧的元素交换
// 时间复杂度 O(n²)，选择排序的最好情况时间复杂度、最坏情况和平均情况时间复杂度都为 O(n2)
// 空间复杂度 O(1) 原地排序
// 不稳定排序
func selectionSort(s *[]int) {
	e := *s
	num := len(e)

	for i := 0; i < num; i++ {
		min := i
		for j := num - 1; j >= i; j-- {
			if e[j] < e[min] {
				min = j
			}
		}
		e[i], e[min] = e[min], e[i]
	}
}
