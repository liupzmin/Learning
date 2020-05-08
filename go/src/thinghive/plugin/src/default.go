// default plugin
package main

import (
	"fmt"
)

func init() {
	fmt.Printf("init default plugin\n")
}

// Recvfrom recive data from device
func Recvfrom() {
	fmt.Printf("read data......\n")
}

// Sendto send data to thinghive
func Sendto() {
	fmt.Printf("send data....\n")
}

func main() {

}
