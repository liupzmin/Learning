#include <stdio.h>

int main(void)
{

    char c ;

    while ((c = getchar()) != EOF)
    {
        /* code */
        putchar(c);
        printf("\n-------------\n");

    }

    return 0;
}