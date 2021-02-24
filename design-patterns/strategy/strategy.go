package main

import (
	"fmt"
)

type Displaier interface {
	Display()
}

type Quacker interface {
	Quack()
}

type Flier interface {
	Fly()
}

type FlyWithWings struct{}

func (f FlyWithWings) Fly() {
	fmt.Println("I am flying with my  wings!")
}

type FlyNoWay struct{}

func (f FlyNoWay) Fly() {
	fmt.Println("I can not fly!")
}

type FlyWithRocket struct{}

func (f FlyWithRocket) Fly() {
	fmt.Println("I am flying with a rocket!")
}

type QuackNormal struct{}

func (q QuackNormal) Quack() {
	fmt.Println("Quack Quack!")
}

type Squeak struct{}

func (s Squeak) Quack() {
	fmt.Println("Squeak Squeak!")
}

type QuackMute struct{}

func (q QuackMute) Quack() {
	fmt.Println("I can not Quack!")
}

type DuckBase struct {
	Flier
	Quacker
}

func (d DuckBase) Swim() {
	fmt.Println("I am swimming!")
}

func (d *DuckBase) SetFlyBehaviro(f Flier) {
	d.Flier = f
}

func (d *DuckBase) SetQuackBehaviro(q Quacker) {
	d.Quacker = q
}

type MallardDuck struct {
	*DuckBase
}

func (m MallardDuck) Display() {
	fmt.Println("my head is green!")
}

type RedheadDuck struct {
	*DuckBase
}

func (r RedheadDuck) Display() {
	fmt.Println("my head is red!")
}

type RubberDuck struct {
	*DuckBase
}

func (r RubberDuck) Display() {
	fmt.Println("I am rubber duck!")
}

// ------------------

type Duck interface {
	Flier
	Quacker
	Displaier
	Swim()
	SetFlyBehaviro(Flier)
	SetQuackBehaviro(Quacker)
}

func main() {
	mo := MallardDuck{&DuckBase{Flier: FlyWithWings{}, Quacker: QuackNormal{}}}

	mo.Display()
	mo.Fly()
	mo.Quack()
	mo.Swim()

	mo.SetFlyBehaviro(FlyWithRocket{})
	mo.Fly()
}
