package dynamic_programing

func CutRod(p []int, n int) int {
	if n == 0 {
		return 0
	}

	var q int
	for i := range n {
		q = max(q, p[i]+CutRod(p, n-(i+1)))
	}
	return q
}

func MemorizedCutRod(p []int, r []int, n int) int {
	if n == 0 {
		return 0
	}

	if r[n-1] > 0 {
		return r[n-1]
	}

	var q int
	for i := range n {
		q = max(q, p[i]+MemorizedCutRod(p, r, n-(i+1)))
	}

	r[n-1] = q

	return q
}

func BottomUpCutRod(p []int, n int) (int, [][]int) {
	s := make([]int, n+1)    // 存放 s[n]最优结果
	rr := make([][]int, n+1) // 存放 n 时的最优切割方案
	// 求解规模为 j 的子问题，双层for循环实现自底向上先解决小问题
	for j := 1; j <= n; j++ {
		var (
			q int
			r []int
		)
		// 与 CutRod 方法相同，区别为从 s 拿子问题的解
		for i := 1; i <= j; i++ {
			// q = max(q, p[i-1]+s[j-i])
			if q < p[i-1]+s[j-i] {
				q = p[i-1] + s[j-i]
				r = nil
				r = append(r, i)
				r = append(r, rr[j-i]...)
			}
		}
		// 子问题的解放入 s，切割方案放入 rr
		s[j] = q
		rr[j] = r
	}
	return s[n], rr
}
