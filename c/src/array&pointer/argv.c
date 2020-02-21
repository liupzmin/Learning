# include<stdio.h>

// 形参时 *a 和 a[] 一样，所以 **a 和 *a[] 一样，所以main 中 **argv 也是合法的 
// 指针数组作为形参，形式 **argv 和 *argv[]一样
int main(int argc, char *argv[])
{
    int i;
    for (i = 0; i<=argc;i++)
    {
        // %s 出现时，后面参数一定是 char * 指针
        printf("%s\n", argv[i]);
    }
    // 这里是用指针运算代替数组取下标运算，因为数组的内容是个 char * 指针，所以要声明指针的指针
    char **p;
    for (p = &argv[1]; *p != NULL; p++){
        printf("%s\n", *p);
    }
    return 0;
}

/*

另一种main

int main(int argc, char ** argv)
{
    int i;
    for (i=0; i < argc; i++)
        printf("Argument %d is %s.\n", i, argv[i]);
        // argv 指针作为数组名
    return 0;
}
*/