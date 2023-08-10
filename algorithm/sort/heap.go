package sort

// heapSort 堆排序，节点从数组0下标开始
// 时间复杂度 O(nlogn)
// 空间复杂度 O(1) 原地排序
// 不稳定排序
//
// 在实际开发中，为什么快速排序要比堆排序性能好？
// 第一点，堆排序数据访问的方式没有快速排序友好。对于快速排序来说，数据是顺序访问的。而对于堆排序来说，数据是跳着访问的。CPU 缓存不友好
// 第二点，对于同样的数据，在排序过程中，堆排序算法的数据交换次数要多于快速排序。
func heapSort(s *[]int) {
	e := *s
	length := len(e)
	buildMaxHeap(s)

	for i := length - 1; i >= 1; i-- {
		// 将堆顶元素和末尾元素交换
		e[0], e[i] = e[i], e[0]
		// 用新的堆大小来继续堆化堆顶节点
		maxHeapify(s, i, 0)
	}
}

// buildMaxHeap 从最后一个父节点开始，沿每个节点而上，对每个节点进行下滤操作
// 因为每个叶子节点可以默认为符合堆特性，所以可以调用 maxHeapify
// maxHeapify 维护大顶堆的性质，函数的前提是假定根节点为left(i)和right(i) 的二叉树都是最大堆
func buildMaxHeap(s *[]int) {
	e := *s
	length := len(e)
	// 从 n / 2 到 n 都是叶子节点，因此可以从 (n / 2) - 1 处向着 0 下标开始堆化
	for i := (length / 2) - 1; i >= 0; i-- {
		maxHeapify(s, length, i)
	}
}

// maxHeapify 维护大顶堆的性质，函数的前提是假定根节点为left(i)和right(i) 的二叉树都是最大堆
// 也就是说，此函数是为删除堆顶元素并且在堆顶填充A[n-1]之后继续堆化的过程，或者称之为下滤
// 要将一个现成的数组堆化，可以使用自下而上的方式依次调用此函数，堆排序就是用这一点来建堆的，如本例中的 buildMaxHeap
// size 代表堆的大小 pos 是堆化的节点
func maxHeapify(s *[]int, size, pos int) {
	e := *s
	largest := pos

	left := leftChild(pos)   // 左孩子位置
	right := rightChild(pos) // 右孩子位置
	// 将 pos 处节点的值与两个孩子比较，目的是将大值放到子堆顶部
	if left <= size-1 && e[pos] < e[left] {
		largest = left
	}
	if right <= size-1 && e[largest] < e[right] {
		largest = right
	}

	if pos == largest {
		return
	}
	// 交换节点，并递归对交换的节点堆化
	e[pos], e[largest] = e[largest], e[pos]
	maxHeapify(s, size, largest)
}

func leftChild(p int) int {
	return 2*p + 1
}

func rightChild(p int) int {
	return 2 * (p + 1)
}
