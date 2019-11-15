## 新建标签

1. 命令`git tag <tagname>`用于新建一个标签，默认为`HEAD`，也可以指定一个`commit id`， 如：`git tag v0.9 f52c633`；

2. 命令`git tag -a <tagname> -m "blablabla..."`可以指定标签信息；

3. 命`令git tag`可以查看所有标签。

## 操作标签

1. 命令`git push origin <tagname>`可以推送一个本地标签；

2. 命令`git push origin --tags`可以推送全部未推送过的本地标签；

3. 命令`git tag -d <tagname>`可以删除一个本地标签；

4. 命令`git push origin :refs/tags/<tagname>`可以删除一个远程标签。