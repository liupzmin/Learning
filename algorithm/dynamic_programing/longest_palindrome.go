package dynamic_programing

/*
给你一个字符串 s，找到 s 中最长的回文子串。
如果字符串的反序与原始字符串相同，则该字符串称为回文字符串。

示例 1：
输入：s = "babad"
输出："bab"
解释："aba" 同样是符合题意的答案。

示例 2：
输入：s = "cbbd"
输出："bb"

提示：
1 <= s.length <= 1000
s 仅由数字和英文字母组成
*/

func LongestPalindrome(s string) string {
	n := len(s)
	if n <= 1 {
		return s
	}
	// 定义一个二维数组 dp，dp[i][j] 表示从索引 i 到索引 j 的子串是否为回文串
	dp := make([][]bool, n)
	for i := range dp {
		dp[i] = make([]bool, n)
	}
	start, end := 0, 0 // 记录最长回文子串的起始位置和结束位置
	// 边界情况：单个字符都是回文串
	for i := 0; i < n; i++ {
		dp[i][i] = true
	}
	// 动态规划，从长度为 2 的子串开始判断
	for l := 2; l <= n; l++ {
		for i := 0; i <= n-l; i++ {
			j := i + l - 1
			// 当前子串的两端字符相等且去掉两端字符后的子串也是回文串时，当前子串为回文串
			if s[i] == s[j] && (l == 2 || dp[i+1][j-1]) {
				dp[i][j] = true
				// 更新最长回文子串的起始位置和结束位置
				if l > end-start+1 {
					start = i
					end = j
				}
			}
		}
	}
	return s[start : end+1]
}
