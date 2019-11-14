**There are many advantages to static linking. Easy deployment is one. No version problems is another (upgrades will probably never break your go binaries. This is not true for dynamically linked or interpreted languages, as dependencies could break). Faster startup times is yet another.**

**There are also good reasons to link dynamically, though. So, the actual reason is: Because the go authors have looked at the tradeoff of static vs. dynamic linking and decided that static linking fits their use cases better. And most people in the go community agree.**

go 使用静态是一种权衡，可以获得静态连接的好处：

1. 部署方便
2. 没有版本的困扰，比如在服务器部署程序经常遇到glibc版本问题，go静态编译完没有任何依赖，放到同样的平台上就可以运行，可见go为每个二进制文件都打包了运行时库
3. 启动更快，很显然嘛，静态连接，没有加载时的动态链接的过程，自然就快了嘛

**完全静态编译：**

```shell
CGO_ENABLED=0 go build -o xxx
```

详见[也谈Go的可移植性](https://tonybai.com/2017/06/27/an-intro-about-go-portability/)