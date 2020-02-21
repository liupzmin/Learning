#include <stdio.h>
#include <stdlib.h>

int main()
{
    char *a = "abd";

    printf("the string is %s\n", a);

    int *int_p;

    int_p = malloc(sizeof(int));

    *int_p = 12345;

    free(int_p);

    printf("*int_p..%d\n",*int_p);

    //*a = 'f';

    return 0;
}