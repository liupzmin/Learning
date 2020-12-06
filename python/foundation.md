1.  作用域

- 无声明的情况下，赋值即私有，若外部有相同名称的变量则被遮挡
- 想修改外部变量，需声明（global、nonlocal），或者通过可变对象的内置函数
- python2中没有nonlocal关键字，只能用可变对象来临时解决中间层变量修改的问题

*注意：Python与C有着很大的区别，在Python中并不是所有的语句块中都会产生作用域。只有当变量在Module(模块)、Class(类)、def(函数)中定义的时候，才会有作用域的概念。如下边语句在python中是不报错的，而在C++等中则报错。*

```python
>>>for i in range(3):
...    a = i
>>>print(a)
2
```

一个易错的例子：

```python
name = "lbj"
  def f1():
      print(name)
  def f2():
      name = "coldplay"
      f1()
  f2()
  输出lbj
  #在调用f1时，name在局部没有，会去搜索全局而f2的name只是局部的，与全局无关，因此输出lbj
```