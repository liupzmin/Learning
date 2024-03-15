package backtracking

import "math"

var MaxWeight = math.MinInt

// Steal 通过递归地选择或不选择每个物品来找到所有可能的组合，并在遇到不可行的组合时回溯。
// 同时，通过剪枝操作（即当当前重量超过背包重量时不继续递归），减少了不必要的计算。
// 通过连续递归调用可以表达穷举所有可能的状态，这是回溯算法的核心思想。
func Steal(i int, cw int, w int, items []int) {
	if cw == w || i == len(items) { // cw==w表示装满了;i == len(items)表示已经考察完所有的物品
		if cw > MaxWeight {
			MaxWeight = cw
		}
		return
	}

	Steal(i+1, cw, w, items) // 不放入背包
	if cw+items[i] <= w {
		Steal(i+1, cw+items[i], w, items) // 重量未超时放入背包
	}
}
