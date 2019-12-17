## 关于类型断言

对于一个接口类型 `x` 和 类型 `T`，表达式 `x.(T)` 断言 `“x is not nil”` 并且 `“x 存储的值的类型为 T” `。

`x.(T)` 标记符被称为类型断言。

> More precisely, if T is not an interface type, x.(T) asserts that the dynamic type of x is identical to the type T. In this case, T must implement the (interface) type of x; otherwise the type assertion is invalid since it is not possible for x to store a value of type T. If T is an interface type, x.(T) asserts that the dynamic type of x implements the interface T.

> If the type assertion holds, the value of the expression is the value stored in x and its type is T. If the type assertion is false, a run-time panic occurs. In other words, even though the dynamic type of x is known only at run time, the type of x.(T) is known to be T in a correct program.

上面是官方对于`断言`的解释，概括为

1. 当 `T` 不是接口类型时，`x.(T)` 断言 x 的动态类型为 `T`。此时，T 必须实现了 接口 `x`。
2. 当 `T` 是接口类型时， `x.(T)` 断言 x 的动态类型实现了接口 `T`。
3. 如果断言成功， 表达式的值就是存储在 x 中的值，且类型为 `T`（T为接口时，检查结果的接口值的动态类型和动态值不变，但是该接口值的类型被转换为接口类型T）。

for example，

```go
var x interface{} = 7          // x has dynamic type int and value 7
i := x.(int)                   // i has type int and value 7

type I interface { m() }

func f(y I) {
	s := y.(string)        // illegal: string does not implement I (missing method m)
	r := y.(io.Reader)     // r has type io.Reader and the dynamic type of y must implement both I and io.Reader
	…
}
```

在赋值和初始化中使用类型断言：

```go
v, ok = x.(T)
v, ok := x.(T)
var v, ok = x.(T)
var v, ok T1 = x.(T)
```

*注：我不理解最后一种*

yields an additional untyped boolean value. The value of ok is true if the assertion holds. Otherwise it is false and the value of v is the zero value for type T. No run-time panic occurs in this case.