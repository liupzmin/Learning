#include <stdio.h>

struct Demo{
    int a;
    int b;
    char c;
}Demo;

void test()
{
    int a = 9527;
    int b = 1024;
    int d = a + b;
    char c = 'c';

    struct Demo s;

    s.a = a;
    s.b = b;
    s.c = c;

    printf("let's see a is:%d, b:%d d:%d c:%c, s.a: %d\n", a,b,d,c, s.a) ;
}

int main()
{
   test();
}

