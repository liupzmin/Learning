package main

import (
	"fmt"
)

type DuckBase struct{}

type Displayer interface {
	Display()
}

func (d DuckBase) Quack() {
	fmt.Println("quack quack!")
}

func (d DuckBase) Swim() {
	fmt.Println("I am swimming!")
}

type MallardDuck struct {
	DuckBase
}

func (m MallardDuck) Display() {
	fmt.Println("my head is green!")
}

type RedheadDuck struct {
	DuckBase
}

func (r RedheadDuck) Display() {
	fmt.Println("my head is red!")
}

type RubberDuck struct {
	DuckBase
}

func (r RubberDuck) Display() {
	fmt.Println("I am rubber duck!")
}

func (r RubberDuck) Quack() {
	fmt.Println("squeak squeak!")
}

func main() {
	mo := MallardDuck{}
	red := RedheadDuck{}
	rub := RubberDuck{}

	mo.Display()
	mo.Quack()
	mo.Swim()

	red.Display()
	red.Quack()
	red.Swim()

	rub.Display()
	rub.Quack()
	rub.Swim()
}
