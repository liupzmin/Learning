#include <stdio.h>

int main()
{

    char a[] = "abcd";
    printf("size of a %ld\n", sizeof a);

    printf("size of a %d\n", a[4]);

    char *s = "abcd";

    for (int i=0; i<5; i++)
    {
        printf("char of s %c\n", *s++);
    }
    
    printf("char of s %d\n", *s);
    printf("char of s %c\n", *s);

    return 0;
}