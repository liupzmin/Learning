#include <stdio.h>
#include <stdlib.h>
#include <locale.h>
#include <string.h>

int main(){

    setlocale(LC_ALL, "en_US.utf8");
    unsigned int testArray[] = {0xabcdef11,0xffee,3,4,5,6,7,8,9,10};

    unsigned int arrayCopy[sizeof(testArray)/sizeof(testArray[0])];
    //　使用　memcpy 拷贝数组，ｃ语言不能直接复制数组
    memcpy(arrayCopy, testArray, sizeof(testArray));

    arrayCopy[1] = 2;

    printf("testArray: ");

    for (int i=0; i < sizeof(testArray)/sizeof(testArray[0]); i++)
    {
        printf("%d ", testArray[i]);
    }

    printf("\n");

    printf("arrayCopy: ");

    for (int i=0; i < sizeof(arrayCopy)/sizeof(arrayCopy[0]); i++)
    {
        printf("%d ", arrayCopy[i]);
    }

    printf("\n");


    char s[] = "敏abcdef";

    char *p = "敏";

    // char *t[] = {"敏","abc"};

    wchar_t ch[] = L"a敏";//宽字符

    wchar_t wc = L'\u5218';

    char mbStr[MB_CUR_MAX];

    int len = wctomb(mbStr, wc);

    printf("the len: %d\n", len);


    for (int i=0; i <= sizeof(testArray)/sizeof(int); i++){
        printf("number:%d\n", i);
    }
}