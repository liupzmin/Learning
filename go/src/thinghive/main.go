package main

import (
	"plugin"
)

func main() {
	p, err := plugin.Open("plugin/default.so")

	if err != nil {
		panic(err)
	}

	recv, err := p.Lookup("Recvfrom")

	if err != nil {
		panic(err)
	}

	send, err := p.Lookup("Sendto")

	if err != nil {
		panic(err)
	}

	recv.(func())()

	send.(func())()

}
