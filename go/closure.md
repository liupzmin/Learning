
Function literals are closures: they may refer to variables defined in a surrounding function. Those variables are then shared between the surrounding function and the function literal, and they survive as long as they are accessible.

A closure is a function value that references variables from outside its body. The function may access and assign to the referenced variables;

Go语言中闭包是引用了自由变量的函数，被引用的自由变量和函数一同存在，即使已经离开了自由变量的环境也不会被释放或者删除，在闭包中可以继续使用这个自由变量，因此，简单的说：
函数 + 引用环境 = 闭包

被捕获到闭包中的变量让闭包本身拥有了记忆效应，闭包中的逻辑可以修改闭包捕获的变量，变量会跟随闭包生命期一直存在，闭包本身就如同变量一样拥有了记忆效应。

## 闭包是引用

Go语言其实也是有传引用的地方的, 但是不是函数的参数, 而是闭包对外部环境是通过引用访问的.

查看以下的代码:

```go
for i := 0; i < 5; i++ {
    defer fmt.Printf("%d ", i)
    // Output: 4 3 2 1 0
}

fmt.Printf("\n")
    for i := 0; i < 5; i++ {
    defer func(){ fmt.Printf("%d ", i) } ()
    // Output: 5 5 5 5 5
}

fmt.Printf("\n")
    for i := 0; i < 5; i++ {
    go func(){ fmt.Printf("%d ", i) } ()
    // Output: 5 5 5 5 5
}
```

更有说明性的一个例子：

```go
package main

import "fmt"

func main() {
  var functions []func()

  for i := 0; i < 10; i++ {
    functions = append(functions, func() {
      fmt.Printf("closure : %d - %p\n", i, &i)
    })
  }

  for _, f := range functions {
    f()
  }
}
```

output:
```
closure : 10 - 0xc0000a23a0
closure : 10 - 0xc0000a23a0
closure : 10 - 0xc0000a23a0
closure : 10 - 0xc0000a23a0
closure : 10 - 0xc0000a23a0
closure : 10 - 0xc0000a23a0
closure : 10 - 0xc0000a23a0
closure : 10 - 0xc0000a23a0
closure : 10 - 0xc0000a23a0
closure : 10 - 0xc0000a23a0
```

解决方法：

```go
// 方法1: 每次循环构造一个临时变量 i
for i := 0; i < 5; i++ {
    i := i
    defer func(){ fmt.Printf("%d ", i) } ()
    // Output: 4 3 2 1 0
}
// 方法2: 通过函数参数传参
for i := 0; i < 5; i++ {
    defer func(i int){ fmt.Printf("%d ", i) } (i)
    // Output: 4 3 2 1 0
}
```
官方解释：[What happens with closures running as goroutines? ](https://golang.org/doc/faq#closures_and_goroutines)