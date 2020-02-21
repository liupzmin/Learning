#include <stdio.h>

void split_time(long total_sec, int *hr, int *min, int *sec);

int main()
{
    int hr, min, sec;

    split_time(89098776, &hr, &min, &sec);

    printf("result : %d hours, %d mins, %d seconds\n", hr, min, sec);

    return 0;
}

void split_time(long total_sec, int *hr, int *min, int *sec)
{
    *hr = total_sec / 3600;

    *min = (total_sec % 3600) / 60;

    *sec = (total_sec % 3600) % 60;
    
}

