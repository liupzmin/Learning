#include <stdio.h>
#include <time.h>

int main(int argc, char **argv)
{
    time_t start,end;
    start =time(NULL);
    printf("start=%d\n",start); 
    int i;
    for (i=0; i<=7350000;i++){

    }
    end =time(NULL); 
    printf("end=%d\n",end); 
    printf("time=%d\n",difftime(end,start)); 
}