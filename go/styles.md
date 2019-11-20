## [CodeReviewComments](https://github.com/golang/go/wiki/CodeReviewComments)

1. 注释应该为一个整句，且以描述对象名称开头

    ```go
    // Request represents a request to run a command.
    type Request struct { ...

    // Encode writes the JSON encoding of req to w.
    func Encode(w io.Writer, req *Request) { ...

    ```

2. 声明空的slice，使用 `var t []string` 语句

    nil的slice更得到我们的偏爱，比如在json转换时：

    **Note that there are limited circumstances where a non-nil but zero-length slice is preferred, such as when encoding JSON objects (a nil slice encodes to null, while []string{} encodes to the JSON array []).**

    **When designing interfaces, avoid making a distinction between a nil slice and a non-nil, zero-length slice, as this can lead to subtle programming errors.**

    > 当设计接口的时候，避免让 nil 的 slice 和 非 nil 的但长度为 0 的 slice 有所区别， 否则会导致细微的bug。
    

3. Error Strings 避免大写（某些特殊名字除外）和结尾句点，因为一般会格式化使用

4. Goroutine Lifetimes. 当你生出大量的goroutine的时候，你要清晰地知道它何时退出以及是否已退出。

5. 不要使用 `_` 丢弃 errors

6. 优先处理错误，缩进错误处理代码，不要缩进正常代码

    不要写成下面这样：
    ```go
    if err != nil {
	// error handling
    } else {
	// normal code
    }
    ```

    要写成这样：

    ```go
    if err != nil {
	    // error handling
	return // or continue, etc.
    }
        // normal code
    ```

    如果 `if` 里有初始化语句：

    ```go
    if x, err := f(); err != nil {
	    // error handling
	return
    } else {
	    // use x
    }
    ```
    将 段变量命名单独拿出来

    ```go
    x, err := f()
    if err != nil {
	    // error handling
	    return
    }
    // use x
    ```

7. 对于首字母缩写词（`initialisms`、`acronyms` ），大小写敏感要保持一致，不要混合

    **For example, "URL" should appear as "URL" or "url" (as in "urlPony", or "URLPony"), never as "Url". As an example: ServeHTTP not ServeHttp.**

8. Interfaces注意事项

    Interfaces 应该位于使用它的包，而不是实现它的包（`并不太好理解`），实现接口的包应该返回一个具体的类型（通常是 pointer 或者 struct ）。

    不要在实现的一方定义接口，也不要在使用前定义： `without a realistic example of usage, it is too difficult to see whether an interface is even necessary, let alone what methods it ought to contain.`

    **总之此处不甚理解，官方还给了例子：**

    ```go
        package consumer  // consumer.go

        type Thinger interface { Thing() bool }

        func Foo(t Thinger) string { … }


        package consumer // consumer_test.go

        type fakeThinger struct{ … }
        func (t fakeThinger) Thing() bool { … }
        …
        if Foo(fakeThinger{…}) == "x" { … }


        // DO NOT DO IT!!!
        package producer

        type Thinger interface { Thing() bool }

        type defaultThinger struct{ … }
        func (t defaultThinger) Thing() bool { … }

        func NewThinger() Thinger { return defaultThinger{ … } }
    ```
    `Instead return a concrete type and let the consumer mock the producer implementation.`

    ```go

        package producer

        type Thinger struct{ … }
        func (t Thinger) Thing() bool { … }

        func NewThinger() Thinger { return Thinger{ … } }
    ```

8. 确保你的代码行的长度， 使用合理的命名，合理的语句

9. 关于命名返回参数的问题

    通常来说，不命名在godoc里显示出来要美观一些，但也存在特殊情况：

    > if a function returns two or three parameters of the same type, or if the meaning of a result isn't clear from context, adding names may be useful in some contexts. Don't name result parameters just to avoid declaring a var inside the function; that trades off a minor implementation brevity at the cost of unnecessary API verbosity.

    应该命名的两种情况：（1）有两个或三个以上同类型的返回参数。（2) 返回的参数无法从上下文推断出意义。

    **总之，就是不要为了一点写法上的简洁（指函数体内不需要声明以及裸的 `return` ）而增加API的冗长**

    关于裸return：

    > Naked returns are okay if the function is a handful of lines. Once it's a medium sized function, be explicit with your return values. Corollary: it's not worth it to name result parameters just because it enables you to use naked returns. Clarity of docs is always more important than saving a line or two in your function.

    小函数可以裸，中型函数就需要清晰返回值了，推论：**不要仅仅为了裸 return 而去命名返回参数**，文档的清晰永远要比节省那么一两行要来的重要。

10. 包注释要紧贴包声明语句，中间不能有空行，且第一个字母大写，即使以二进制文件名开头，第一个字母也要大写

    > For "package main" comments, other styles of comment are fine after the binary name (and it may be capitalized if it comes first), For example, for a package main in the directory seedgen you could write:

    ```go
        // Binary seedgen ...
        package main
    ```
    or
    ```go
        // Command seedgen ...
        package main
    ```
    or
    ```go
        // Program seedgen ...
        package main
    ```
    or
    ```go
        // The seedgen command ...
        package main
    ```
    or
    ```go
        // The seedgen program ...
        package main
    ```
    or
    ```go
        // Seedgen ..
        package main
    ```

11. 关于传值

    > Don't pass pointers as function arguments just to save a few bytes. If a function refers to its argument x only as *x throughout, then the argument shouldn't be a pointer. Common instances of this include passing a pointer to a string (*string) or a pointer to an interface value (*io.Reader). In both cases the value itself is a fixed size and can be passed directly. This advice does not apply to large structs, or even small structs that might grow.

    **不要为了节省几个字节而将指针作为函数参数传递。如果一个函数始终只引用它的参数x作为\*x，那么这个参数不应该是指针。这种情况的常见实例包括传递一个指向字符串的指针(\*string)或一个指向接口值的指针(\*io.Reader)。在这两种情况下，值本身是固定大小，可以直接传递。这个建议不适用于大型结构，甚至可能增长的小型结构。**

12. 接收器的名字要简短，不要使用`me`，`this`，`self`这些泛型名称，不需要具有描述性，且每个方法名称一致