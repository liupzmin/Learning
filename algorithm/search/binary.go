package search

/*
凡是用二分查找能解决的，绝大部分我们更倾向于用散列表或者二叉查找树。即便是二分查找在内存使用上更节省，但是毕竟内存如此紧缺的情况并不多。
那二分查找真的没什么用处了吗？实际上，求“值等于给定值”的二分查找确实不怎么会被用到，二分查找更适合用在“近似”查找问题，
在这类问题上，二分查找的优势更加明显。比如后面实现的四种变体问题，用其他数据结构，比如散列表、二叉树，就比较难实现了。
变体的二分查找算法写起来非常烧脑，很容易因为细节处理不好而产生 Bug，这些容易出错的细节有：终止条件、区间上下界更新方法、返回值选择。
*/

// BinarySearch 二分等值查找
func BinarySearch(e []int, v int) int {
	length := len(e)
	left := 0
	right := length - 1

	for left <= right {
		// 防溢出
		// (left+right)/2 = (left+right+left-left)/2 = (2*left+right-left)/2 = left + (right-left)/2
		mid := left + (right-left)>>1
		if e[mid] == v {
			return mid
		}

		if e[mid] > v {
			right = mid - 1
		}

		if e[mid] < v {
			left = mid + 1
		}
	}
	return -1
}

// BinarySearchRecursive 递归版本
func BinarySearchRecursive(e []int, v, left, right int) int {
	if left > right || len(e) == 0 {
		return -1
	}

	mid := left + (right-left)>>1
	if e[mid] == v {
		return mid
	}

	if e[mid] > v {
		right = mid - 1
	}

	if e[mid] < v {
		left = mid + 1
	}
	return BinarySearchRecursive(e, v, left, right)
}

// BinarySearchFirstEqual 查找第一个等于给定值的元素
func BinarySearchFirstEqual(e []int, v int) int {
	length := len(e)
	left := 0
	right := length - 1

	for left <= right {
		mid := left + (right-left)>>1

		if e[mid] > v {
			right = mid - 1
		} else if e[mid] < v {
			left = mid + 1
		} else {
			if mid == 0 || e[mid-1] != v {
				return mid
			}
			right = mid - 1
		}
	}
	return -1
}

// BinarySearchFirstEqual2 符合 go 惯例的写法
func BinarySearchFirstEqual2(e []int, v int) int {
	length := len(e)
	left := 0
	right := length - 1

	for left <= right {
		mid := left + (right-left)>>1

		if e[mid] > v {
			right = mid - 1
			continue
		}

		if e[mid] < v {
			left = mid + 1
			continue
		}

		if mid == 0 || e[mid-1] != v {
			return mid
		}
		right = mid - 1
	}
	return -1
}

// BinarySearchLastEqual 查找最后一个等于给定值的元素
func BinarySearchLastEqual(e []int, v int) int {
	length := len(e)
	left := 0
	right := length - 1

	for left <= right {
		mid := left + (right-left)>>1

		if e[mid] > v {
			right = mid - 1
		} else if e[mid] < v {
			left = mid + 1
		} else {
			if mid == length-1 || e[mid+1] != v {
				return mid
			}
			left = mid + 1
		}
	}
	return -1
}

// BinarySearchFirstGreaterEqual 查找第一个大于等于给定值的元素
func BinarySearchFirstGreaterEqual(e []int, v int) int {
	length := len(e)
	left := 0
	right := length - 1

	for left <= right {
		mid := left + (right-left)>>1

		if e[mid] < v {
			left = mid + 1
			continue
		}

		if e[mid] >= v {
			if mid == 0 || e[mid-1] < v {
				return mid
			}
			right = mid - 1
		}
	}
	return -1
}

// BinarySearchLastLessEqual 查找最后一个小于等于给定值的元素
func BinarySearchLastLessEqual(e []int, v int) int {
	length := len(e)
	left := 0
	right := length - 1

	for left <= right {
		mid := left + (right-left)>>1

		if e[mid] > v {
			right = mid - 1
			continue
		}

		if e[mid] <= v {
			if mid == length-1 || e[mid+1] > v {
				return mid
			}
			left = mid + 1
		}
	}
	return -1
}
