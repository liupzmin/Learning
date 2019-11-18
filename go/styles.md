## CodeReviewComments

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