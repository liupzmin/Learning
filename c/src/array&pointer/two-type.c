/*
1. []的优先级高于*，（*p[] 理解为指向一个数组，*(p[])存放指针的数组

2. char (*p)[SIZE]：指向一维数组的指针，一维数组只能有SIZE个元素

    char *p[SIZE]：指针数组，数组有SIZE个元素

3. char *a[]: declare a as array of pointer to char (指针数组)
   char (*a)[]: declare a as pointer to array of char （数组的指针）

   首先，需要注意的是：数组名可以用作指针，但此指针和数组的指针不同，即便首地址相同，但指针的类型是不同的，比如：
   int a[10] 和 int (*p)[10] 如果 a 作为指针，它的类型是 int *, 而 p 的类型是 int (*)[10]，类型不同会导致
   指针运算的方式不同，比如 p + 1，假定 int 是 4 个字节，前者为 p + 4 * 1，后者为 p + sizeof(int (*)[10]) * 1

   见 C 语言现代方法 12.4.3：对于二维数组 int a[NUM_ROWS][NUM_COLS]  来说，声明一个数组的指针 int (*p)[NUM_COLS]
   将 a[0] 的地址给 p，p = &a[0] 那么 *p 就代表一整行，p++ 会把 p 移动到下一行开始处。

   注意的是：a 不是 a[0][0] 的指针，而是指向 a[0] 的指针，C 语言认为 a 不是二维数组而是一维数组，且这个一维数组的
   每个元素又是一维数组，其实用作指针时是将 a 的类型看做是 int (*)[NUM_COLS]，而 a[0] 的类型是 int * 。
*/

#include <stdio.h>  
#define TESTSIZE 20  
int main(void)  
{  
    char szTest[][TESTSIZE] = {"hello", "world"};  
    char (*p)[TESTSIZE];  
    // 这个 p 是数组的指针，p + i 会移动 i 个行
    p = szTest;  
    for(int i = 0; i < sizeof(szTest)/TESTSIZE; i++)  
    {  
        printf("%s\n", p + i);  
    }
    // 这个 t 是指针数组，里面放的是字符数组的指针，所以 t[i] 就是数组的指针，指向t[i][0]
    char *t[] = {"hello", "world!"};                //t[]，数组  
     for(int i = 0; i < 2; i++)  
         printf("%s\n", t[i]);  
}