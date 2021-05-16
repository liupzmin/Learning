package main

import "fmt"

type Demo struct {
	A int
	B int
	C string
}

func main() {
	test()
}

func test() {
	a := 1
	b := 2
	c := "richard"

	d := Demo{
		A: a,
		B: b,
		C: c,
	}

	fmt.Printf("let's see a: %d, b: %d, c: %s, d: %v, d.c: %s\n", a, b, c, d, d.C)
}
