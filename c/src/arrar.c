#include <stdio.h>

int main(){
    int testArray[10] = {0xabcdef11,0xffee,3,4,5,6,7,8,9,10};

    for (int i=0; i <= sizeof(testArray)/sizeof(int); i++){
        printf("number:%c\n", i);
    }
}