#include <stdio.h>
#include <stdlib.h>

// 通过函数初始化指针，要传入指针的指针
void test(int **);

int main()
{
    int i, *p;
    p = &i;
    *p = 1;
    printf("*p is %d\n", *p);

    int *n;

    test(&n);
    *n = 2;

    printf("*n is %d\n", *n);
}

void test(int **a)
{
    *a = malloc(sizeof(int));
}