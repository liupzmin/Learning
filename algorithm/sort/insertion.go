package sort

// insertionSort 就像摸扑克牌，手中的牌是已排序的，新牌将与手中的牌逐个比较
// 平均时间复杂度 O(n²)，最好的情况是O(n)，最坏的情况是O(n²)
// 空间复杂度 O(1) 原地排序
// 稳定排序
func insertionSort(s *[]int) {
	e := *s
	num := len(e)
	if num < 2 {
		return
	}

	// 从第二张牌开始
	for p := 1; p <= num-1; p++ {
		i := p - 1  // 手中的牌最右侧一张
		key := e[p] // 将待排序的牌取出
		for i >= 0 && e[i] > key {
			// 如果比待排序的牌大，则向右移动位置
			e[i+1] = e[i]
			i--
		}
		// 终止时 i 所在位置比待排序的牌小或者已达到左端
		// 此时将待排序的牌放在 i+1 的位置
		e[i+1] = key
	}
}
