#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void testPointer(char **);
void testPointerError(char *);
void testPointerArray(char *);

int main(void)
{
    char *test;
    char *test2;

    char test3[4];

    // test虽然是空指针，但是可以将test的指针传进去，在函数中设置test指向的地址为新构建的内存块地址
    testPointer(&test);
    // 这时test2只是个空指针，这样只是传了个空地址进去，因为 c 是传值，所以形参就和test2失去联系了
    testPointerError(test2);
    // 这样先分配好内存的情况下确实可以传入实际地址，但这时不能随意给形参赋值了，不然test3的内存块反映不出新的内容，还丢掉了形参的值
    // 只能使用形参的值去改变其指向的内存块的内容，而且这样事先分配内存大小的做法无法做到变长
    // 只是让我死心，void testPointerError(char *);是不行的
    testPointerArray(test3);
    
    printf("test: %s\n", test);
    printf("test2: %s\n", test2);
    printf("test3: %s\n", test3);

    return 0;

}


void testPointer(char **a)
{
    // *a = malloc(sizeof(char)*4);
    // strcpy(*a, "abc");

    if (a == NULL)
    {
        printf("testPointer null pointer!\n");
    }

    *a = "abc";
}


void testPointerError(char *a)
{
    if (a == NULL)
    {
        printf("testPointerError null pointer!\n");
    }
    a = malloc(sizeof(char)*4);
    strcpy(a, "123");
}

void testPointerArray(char *a)
{
    // a = "456";
    if (a == NULL)
    {
        printf("testPointerArray null pointer!\n");
    }
    strcpy(a, "456");
}