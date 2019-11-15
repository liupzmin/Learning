## 基础知识

CPU要和外部器件进行3类信息交互：

1. 存储单元的地址（`地址信息`）
2. 器件的选择，读或写的命令（`控制信息`）
3. 读或写的数据（`数据信息`）

计算机中专门连接CPU和其他器件的导线成为`总线`，总线根据传输的信息不同，逻辑上分为3类，`地址总线`、`控制总线`和`数据总线`

CPU 从 3 号单元中读取数据的过程：

![CPU从内存读取数据的过程](http://qiniu.liupzmin.com/cpu-read-data-from-memory.png)

1. CPU通过地址线将地址信息3发出

2. CPU通过控制线发出内存读命令，选中存储器芯片。

3. 存储芯片将3号单元重的数据8通过数据线送入CPU

写操作类似。如向 3 号单元写入数据 26

1. CPU通过地址线将地址信息 3 发出

2. CPU通过控制线发出内存写命令，选中存储器芯片。并通知它要向其中写入数据。

3. CPU通过数据总线将数据 26 送入内存 3 号单元

通过指令命令CPU进行读写

比如 8086CPU 从 3 号内存单元读取数据的指令机器码为：

`101000010000001100000000`

太难记了，所以用汇编指令表示：

`mov AX, [3]`

地址总线：影响计算机寻址，如果一个CPU地址总线宽度为N,这样的CPU最多可以寻找2的N次方的内存单元
数据总线：影响数据的传输速度，如果数据总线宽度为8，那么我们传输一个16进制数据（89D8）则需要两次。如下图：

![](http://qiniu.liupzmin.com/data-bus.png)

控制总线：控制总线的宽度决定了CPU对系统中其他器件的控制能力。

关于物理地址空间：

![](http://qiniu.liupzmin.com/physical-address-space.png)

**系统中所有存储器中的存储单元都处于一个统一的逻辑存储器中，它的容量受CPU寻址能力的限制。如果说寻址为4G，那么4G的内存条是无法全部用上的**

有篇博客论述了此事：[显存占用地址空间的问题](https://blog.csdn.net/vigour_lu/article/details/1966672)