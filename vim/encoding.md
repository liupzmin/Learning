### vim 编码的几个配置
- encoding: vim 软件本身的编码方式，通常不用修改；
- fileencoding: 设置vim 保存文件的编码方式；
- fileencodings: vimrc 配置中候选的编码方式，当开打一个文件时，会从中选择合适的编码方式打开文件（将字节解码成unicode 呈现再我们眼前）
> 通常配置成这个 set fileencodings=ucs-bom,utf-8,utf-16,gbk,big5,gb18030,latin1
### 如何用特定的编码打开文件
当文件的编码不在fileencodings中，就会出现乱码
如果我们知道文件的编码，可以用 `edit ++enc=gb2312` 这种方式修改文件打开的编码；

