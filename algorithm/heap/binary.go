package heap

import "fmt"

//堆是一颗被完全填满的二叉树，底层是一个例外，底层元素从左到右填入
//根据父节点大于或者小于孩子节点可分为最大堆和最小堆
//完全二叉树的高是 logN，显然它是O(logN)的

// Sort 使用堆排序
// 建堆过程的时间复杂度是 O(n)，排序过程的时间复杂度是 O(nlogn)，
// 所以，堆排序整体的时间复杂度是 O(nlogn)
// 不稳定排序
func Sort(s *[]int) {
	m := NewMaxHeapWithSlice(s)

	for m.size > 1 {
		m.size--
		m.elements[0], m.elements[m.size] = m.elements[m.size], m.elements[0]
		m.heapify(0, m.elements[0])
	}
}

// MaxHeap 实现了大顶堆
type MaxHeap struct {
	cap      int
	size     int
	elements []int
}

func NewMaxHeap(cap int) *MaxHeap {
	if cap <= 0 {
		return nil
	}

	e := make([]int, cap)

	return &MaxHeap{
		cap:      cap,
		size:     0,
		elements: e,
	}
}

// NewMaxHeapWithSlice 建堆的时间复杂度为 O(n)
func NewMaxHeapWithSlice(s *[]int) *MaxHeap {
	size, ca := len(*s), cap(*s)
	m := &MaxHeap{
		cap:      ca,
		size:     size,
		elements: *s,
	}
	// 从 n / 2 到 n 都是叶子节点，因此可以从 (n / 2) - 1 处向着 0 下标开始堆化(n为元素个数,n/2~n-1为叶子节点下标)
	for i := (size / 2) - 1; i >= 0; i-- {
		m.heapify(i, (*s)[i])
	}
	return m
}

func (m *MaxHeap) Insert(e int) error {
	if m.IsFull() {
		return fmt.Errorf("the Heap is full")
	}
	var i int
	// 从空洞向父节点上溯，如果父节点比插入的节点小，就将父节点下移，此时出现新洞，继续比较
	// 当父节点比新插入值大时，停止上溯
	// 这里并没有使用交换操作，而是直接让不符合的父节点下移，执行效率更高
	for i = m.size; i > 0 && m.elements[(i-1)/2] < e; i = (i - 1) / 2 {
		m.elements[i] = m.elements[(i-1)/2]
	}
	// 将新值插入当前空洞
	m.elements[i] = e
	m.size++
	return nil
}

// DeleteMax 删除堆顶元素
func (m *MaxHeap) DeleteMax() (int, error) {
	if m.IsEmpty() {
		return 0, fmt.Errorf("delete an empty heap")
	}
	m.size--
	max := m.elements[0]
	e := m.elements[m.size]
	var (
		i     int
		child int
	)
	// 从根节点一直遍历到叶子结点，最后一个叶子的值为插入值，每个节点要用插入值和左右两个孩子中的最大者比较
	// 如果插入值小于最大孩子，则把最大孩子值放入当前节点，再接着遍历那个最大孩子节点
	// 如果插入值大于最大孩子，终止循环
	for i = 0; m.leftChild(i) <= m.size; i = child {
		child = m.leftChild(i)
		if child != m.size && m.elements[child+1] > m.elements[child] {
			child++
		}

		if e > m.elements[child] {
			break
		}
		m.elements[i] = m.elements[child]
	}
	// 当循环终止时，将插入值放入当前节点
	m.elements[i] = e
	m.elements = m.elements[:m.size]
	return max, nil
}

// DeleteMaxRecur 删除堆顶元素，并使用递归方式堆化剩余元素
func (m *MaxHeap) DeleteMaxRecur() (int, error) {
	if m.IsEmpty() {
		return 0, fmt.Errorf("delete an empty heap")
	}
	m.size--
	max := m.elements[0]
	e := m.elements[m.size]
	m.heapify(0, e)
	m.elements = m.elements[:m.size]
	return max, nil
}

// heapify 持有值 e，对节点 p 堆化
func (m *MaxHeap) heapify(p, e int) {
	// 找出孩子和e的最大值
	// 如果e最大，则停止递归返回
	// 如果孩子大，则将孩子的值放到堆化节点，接着递归调用堆化孩子节点
	var (
		last, max = p, e
		left      = m.leftChild(p)
		right     = m.rightChild(p)
	)
	if left <= m.size-1 && m.elements[left] > max {
		last = left
		max = m.elements[left]
	}

	if right <= m.size-1 && m.elements[right] > max {
		last = right
		max = m.elements[right]
	}

	if last == p {
		m.elements[p] = e
		return
	}

	m.elements[p] = max
	m.heapify(last, e)
}

func (m *MaxHeap) Heap() []int {
	return m.elements
}

func (m *MaxHeap) IsFull() bool {
	return m.cap == m.size
}

func (m *MaxHeap) IsEmpty() bool {
	return m.size == 0
}

func (m *MaxHeap) leftChild(p int) int {
	return 2*p + 1
}

func (m *MaxHeap) rightChild(p int) int {
	return 2 * (p + 1)
}
