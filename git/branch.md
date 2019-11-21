## 分支操作

1. 查看本地分支：`git branch`

2. 查看远程分支：`git branch -r`

3. 创建本地分支：`git branch [name]` 

4. 切换分支：`git checkout [name]`

5. 创建新分支并立即切换到新分支：`git checkout -b [name]`

6. 删除分支：`git branch -d [name]`

    > **-d 选项只能删除已经参与了合并的分支，对于未有合并的分支是无法删除的。如果想强制删除一个分支，可以使用 -D 选项**

7. 合并分支：`git merge [name]` 

    > **将名称为[name]的分支与当前分支合并**
8. 创建远程分支(本地分支push到远程)：`git push origin [name]`

9. 删除远程分支：`git push origin :heads/[name]`