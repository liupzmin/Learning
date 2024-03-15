package backtracking

import "fmt"

var Result [8]int

func Call8Queen(row int) {
	if row == 8 {
		print8Queen()
		return
	}
	for i := 0; i < 8; i++ {
		if isOK(row, i) {
			Result[row] = i
			Call8Queen(row + 1)
		}
	}
}

func isOK(r, c int) bool {
	leftUp := c - 1
	rightUp := c + 1
	for i := r - 1; i >= 0; i-- {
		if Result[i] == c {
			return false
		}
		if leftUp >= 0 && Result[i] == leftUp {
			return false
		}
		if rightUp < 8 && Result[i] == rightUp {
			return false
		}
		leftUp--
		rightUp++
	}
	return true
}

func print8Queen() {
	for i := 0; i < 8; i++ {
		for j := 0; j < 8; j++ {
			if Result[i] != j {
				fmt.Print("*")
			} else {
				fmt.Print("Q")
			}
			fmt.Print(" ")
		}
		fmt.Println()
	}
	fmt.Println()
}
