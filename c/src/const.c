#include <stdio.h>

const int a = 2;

int main(int argc, char **argv)
{
    const int b = 2;
    int *p = &b;
    int *q = &a;
    *p = 3;
    *q = 3;
    printf("b : %d, a: \n", b, a);

    return 0;
}