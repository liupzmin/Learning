> 随记，待整理， 从程序计数器、指令运行角度思考这些以前模糊的知识点，现在格外清晰，当然也有越来越多的疑问，慢慢整理。本周末大概搞懂了如何进入内核代码，如何运行调度代码，内核不是一个进程或线程，以及确定了每个核上都会运行scheduler，往自己核上调度线程，轮廓越来越清晰了。

深入linux内核架构第一章知识点：

1. 系统中每个用户进程自身的虚拟地址范围为0到TASK_SIZE，用户空间之上的区域保留给内核专用，用户进程不能访问。csapp580页图9-26描述了具体的内核虚拟内存，有对每个进程都一样的，有对每个进程都不相同的，但没写明具体区域

2. 64位的机器寻址一般都小于64位，如42位或47位。好处是cpu节省工作量，坏处是虚拟地址空间会包含一些不可寻址的`洞`

3. 用户态切换到内核态的方式，（1）系统调用 （2）异步硬件中断。（暂不确定是否还有其它方式），与进程上下文中进入内核代码不同的是，中断上下文无权访问地址空间，因为中断发生时cpu上的进程可能与中断无关

4. 内核代码的执行方式（1）上一条所说的sysytem call、中断、进程切换（三种都是上下文切换） （2） 一些特殊的`内核线程`,跟普通线程一样，可被调度，可睡眠，可以有各种用途，比如帮调度器在CPU上分配进程。内核线程不与任何用户空间线程相关联，也无权访问用户空间，ps 那些带方括号的就是

**以下是查阅记录：**

- 


- [OS: does the process scheduler runs in separate process](https://stackoverflow.com/a/11769982/9337614)
- [How does the kernel scheduler know how to pre-empt a process?](https://unix.stackexchange.com/a/457586)
- [where does Kernel reside on a multi-core system](https://superuser.com/questions/564660/where-does-kernel-reside-on-a-multi-core-system)
- [Where does scheduler run on multicore system ?](https://www.linuxquestions.org/questions/programming-9/where-does-scheduler-run-on-multicore-system-946804/)

    每个CPU的scheduler仅仅往自己的CPU上调度么？

    probably yes

- [论进程表和内核栈](https://www.cs.umb.edu/~eoneil/cs444_f06/class10.html)


- [For a kernel level process, should the variables be stored in a stack or a heap?](https://www.quora.com/For-a-kernel-level-process-should-the-variables-be-stored-in-a-stack-or-a-heap)

   重点是回答中提到的两个函数` kmalloc` `vmalloc` 
-[where is PCB stored in memory](https://stackoverflow.com/questions/48619363/where-is-pcb-stored-in-memory)
    
    这个回答说龙书写的烂

- [What is Process Control Block (PCB)?](https://www.tutorialspoint.com/what-is-process-control-block-pcb)
    
    这个人说pcb放在内核栈的开始

- [Where is page table stored in Linux?](https://unix.stackexchange.com/questions/487052/where-is-page-table-stored-in-linux)

    这个人问页表存在哪

- [Where is task_struct stored?](https://stackoverflow.com/questions/10604632/where-is-task-struct-stored)

    这个人问进程的数据结构存在哪？页表、task_struct、pcb都暂时没搞明白放在内核空间的什么区域