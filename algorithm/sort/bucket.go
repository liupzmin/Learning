package sort

// BucketSort 桶排序
// 基本思想：将数值按取值区间分布到不同的桶内，再对每个桶排序，排序方法随意，再依次组合桶中的数
// 时间复杂度 o(n)，稳定与否取决于桶内排序是否稳定
// 空间复杂度o(n)
func BucketSort(e []int, n int) []int {
	if len(e) <= 1 {
		return e
	}
	buckets := make([][]int, n)

	var minV, maxV = e[0], e[0]
	for _, v := range e {
		if v < minV {
			minV = v
		}
		if v > maxV {
			maxV = v
		}
	}
	// 按照值分到不同的桶内
	scope := (maxV - minV + n - 1) / n // 每个桶的数值范围，向上取整
	for i := 0; i < len(e); i++ {
		bucketIndex := (e[i] - minV) / scope
		// 处理边界条件，最大值放到最后一个桶内
		if e[i] == maxV {
			bucketIndex = n - 1
		}
		buckets[bucketIndex] = append(buckets[bucketIndex], e[i])
	}

	r := make([]int, 0)
	for _, bucket := range buckets {
		insertionSort(&bucket)
		r = append(r, bucket...)
	}

	return r
}
