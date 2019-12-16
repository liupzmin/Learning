## 1. 概要
```
vmstat [-a] [-n] [-t] [-S unit] [delay [ count]]
vmstat [-s] [-n] [-S unit]
vmstat [-m] [-n] [delay [ count]]
vmstat [-d] [-n] [delay [ count]]
vmstat [-p disk partition] [-n] [delay [ count]]
vmstat [-f]
vmstat [-V]
```

## 2. 选项解释

Options

The -a switch displays active/inactive memory, given a 2.5.41 kernel or better.
The -f switch displays the number of forks since boot. This includes the fork, vfork, and clone system calls, and is equivalent to the total number of tasks created. Each process is represented by one or more tasks, depending on thread usage. This display does not repeat.

The -t switch adds timestamp to the output.

The -m switch displays slabinfo.

The -n switch causes the header to be displayed only once rather than periodically.

The -s switch displays a table of various event counters and memory statistics. This display does not repeat.

delay is the delay between updates in seconds. If no delay is specified, only one report is printed with the average values since boot.

count is the number of updates. If no count is specified and delay is defined, count defaults to infinity.

The -d reports disk statistics (2.5.70 or above required)

The -w enlarges field width for big memory sizes

The -p followed by some partition name for detailed statistics (2.5.70 or above required)

The -S followed by k or K or m or M switches outputs between 1000, 1024, 1000000, or 1048576 bytes

The -V switch results in displaying version information.

## 3. 结果释义

**Field Description For Vm Mode**

`Procs`

    r: The number of runnable processes (running or waiting for run time).
    b: The number of processes in uninterruptible sleep.

`Memory`
       
    swpd: the amount of virtual memory used.
    free: the amount of idle memory.
    buff: the amount of memory used as buffers.
    cache: the amount of memory used as cache.
    inact: the amount of inactive memory.  (-a option)
    active: the amount of active memory.  (-a option)

`Swap`
      
    si: Amount of memory swapped in from disk (/s).
    so: Amount of memory swapped to disk (/s).

`IO`
      
    bi: Blocks received from a block device (blocks/s).
    bo: Blocks sent to a block device (blocks/s).

`System`
       
    in: The number of interrupts per second, including the clock.
    cs: The number of context switches per second.

`CPU`
       
    These are percentages of total CPU time.
    us: Time spent running non-kernel code.  (user time, includingnice time)
    sy: Time spent running kernel code.  (system time)
    id: Time spent idle.  Prior to Linux 2.5.41, this includesIO-wait time.
    wa: Time spent waiting for IO.  Prior to Linux 2.5.41, includedin idle.
    st: Time stolen from a virtual machine.  Prior to Linux 2.6.11,unknown.

**FIELD DESCRIPTION FOR DISK MODE**

`Reads`

    total: Total reads completed successfully
    merged: grouped reads (resulting in one I/O)
    sectors: Sectors read successfully
    ms: milliseconds spent reading

`Writes`

    total: Total writes completed successfully
    merged: grouped writes (resulting in one I/O)
    sectors: Sectors written successfully
    ms: milliseconds spent writing

`IO`

    cur: I/O in progress
    s: seconds spent for I/O

**FIELD DESCRIPTION FOR DISK PARTITION MODE**

    reads: Total number of reads issued to this partition
    read sectors: Total read sectors for partition
    writes : Total number of writes issued to this partition
    requested writes: Total number of write requests made forpartition

**FIELD DESCRIPTION FOR SLAB MODE**

    cache: Cache name
    num: Number of currently active objects
    total: Total number of available objects
    size: Size of each object
    pages: Number of pages with at least oneactive object

## 4. 使用例子

1. VM Mode

    `vmstat -wt   1`
    `vmstat -wt -S M  1`

2. disk Mode

    `vmstat -wd 1`

3. partition Mode

    `vmstat -p /dev/sdb1 1`

4. 事件计数与内存统计信息表

    `vmstat -s`