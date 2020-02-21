#include <stdio.h>
// 指针数组作为形参，形式 **strs 和 *strs[]一样

void change(char **strs){
    // 指针可用作数组名
	strs[0] = "paaa";
	strs[1] = "pbbb";
	strs[2] = "cpcc";
	strs[3] = "ddxd";
 
}
int main()
{
	char *strs[4];
	int i;
 
	strs[0] = "aaa";
	strs[1] = "bbb";
	strs[2] = "ccc";
	strs[3] = "ddd";
 
	for(i=0;i<4;i++){
		printf("%s\n",strs[i]);
	}
 
	change(strs);
 
	for(i=0;i<4;i++){
		printf("%s\n",strs[i]);
	}
 
	return 0;
}