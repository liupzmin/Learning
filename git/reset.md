## git add 撤销
这样的错误是由于， 有的时候 可能

git add . （空格+ 点） 表示当前目录所有文件，不小心就会提交其他文件

git add 如果添加了错误的文件的话

撤销操作

1. git status 先看一下add 中的文件
2. `git reset HEAD` 如果后面什么都不跟的话 就是上一次add 里面的全部撤销了
3. `git reset HEAD XXX/XXX/XXX.java` 就是对某个文件进行撤销了


## 撤销最近一个commit（还没push）

**Undo a commit and redo**

1. $ git commit ...
2. $ `git reset --soft HEAD^`      (1)
3. $ edit                        (2)
4. $ git commit -a -c ORIG_HEAD  (3)

HEAD^的意思是上一个版本，也可以写成HEAD~1

如果你进行了2次commit，想都撤回，可以使用HEAD~2

## reset 的几个参数

--mixed 

`Resets the index but not the working tree (i.e., the changed files are preserved but not marked for commit) and reports what has not been updated. This is the default action.`

意思是：不删除工作空间改动代码，撤销commit，并且撤销git add . 操作
这个为默认参数,git reset --mixed HEAD^ 和 git reset HEAD^ 效果是一样的。


--soft
`Does not touch the index file or the working tree at all (but resets the head to <commit>, just like all modes do). This leaves all your changed files "Changes to be committed", as git status would put it.`  

不删除工作空间改动代码，撤销commit，不撤销git add . 

--hard

`Resets the index and working tree. Any changes to tracked files in the working tree since <commit> are discarded.`

删除工作空间改动代码，撤销commit，撤销git add . 

注意完成这个操作后，就恢复到了上一次的commit状态。
