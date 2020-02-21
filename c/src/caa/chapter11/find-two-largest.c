#include <stdio.h>

void find_two_largest(int *a, int n, int *largest, int *second_largest);

int main()
{
    int largest, second_largest, a[] = {2,45,6,87,23,23,47,88,95,100,99};

    find_two_largest(a, sizeof(a)/sizeof(a[0]), &largest, &second_largest);

    printf("largest: %d, second_largest: %d\n", largest, second_largest);
    return 0;
}

void find_two_largest(int a[], int n, int *largest, int *second_largest)
{
    *largest = *second_largest = 0;

    int *p = a;

    while(p < a + n)
    {
        if (*largest < *p)
        {
            *second_largest = *largest;
            *largest = *p++;
        }else if(*second_largest < *p)
            *second_largest = *p++;
        else
            p++;
    }
}