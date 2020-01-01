#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

#define MAXOP 100
#define NUMBER '0'

int getop(char []);
void push(double);
double pop(void);

// 逆波兰计算器

int main()
{
    int type;
    double op2;
    char s[MAXOP];

    while ((type = getop(s)) != EOF){
        switch (type)
        {
        case NUMBER:
            /* code */
            push(atof(s));
            break;
        case '+':
            push( pop() + pop() );
            break;
        case '*':
            push(pop() * pop());
            break;
        case '-':
            op2 = pop();
            push(pop() - op2);
            break;
        case '/':
            op2 = pop();
            if (op2 != 0.0)
                push(pop() / op2);
            else
                printf("error: zero divisor\n");
            break;
        case '\n':
            printf("\t%.8g\n", pop());
            break;
        default:
            printf("error: unknown command %s\n", s);
            break;
        }
    }
    return 0;
}

#define MAXVAL 100

int sp = 0;
double val[MAXVAL];
// 入栈
void push(double f)
{
    if (sp < MAXVAL){
         val[sp++] = f;
    }   
    else
    {
        /* code */
        printf("error: stack full, can't push %g\n", f);
    }
}
// 出栈
double pop(void)
{
    if (sp >0)
        return val[--sp];
    else
    {
        /* code */
        printf("error: stack empty\n");
        return 0.0;
    }
    
}


int getch(void);
void ungetch(int);

/* 
getop 函数用于从键盘获取一个数或者操作符
数或者操作符必须以空格或制表符分隔
其中，s[] 是重复利用的，用于存储由输入获取的一个单元，单元可以是一个数或者一个操作符
 */
int getop(char s[])
{
    int i, c;
    // 过滤空字符，读取第一个非空的字符到 s[0] 中
    while ((s[0] = c = getch()) == ' ' || c == '\t')
        ;
    // 不太明白这一步意思是什么，结束了字符串 s， 但 s 又没有使用。
    s[1] = '\0';
    // 第一个字符，如果不是数字或者 '.' 则将其返回
    if (!isdigit(c) && c != '.')
        return c;
    // 设 i 为 0，保留 s[0] 后继续读去输入加入s，如果读取到非数字字符，则终止循环
    i = 0; 
    if (isdigit(c))
        while (isdigit(s[++i] = c = getch()))
            ;
    // 如果第一个字符或者终结上一个循环的字符是小数点，则继续读取输入加入s直到遇到一个非数字字符
    if (c == '.')
        while (isdigit(s[++i] = c = getch()))
            ;
    // 使用 '\0' 结束字符数组 s，覆盖最后一个非数字字符
    s[i] = '\0';
    // 如果未遇到文件末尾则将最后读入的字符放回缓冲数组
    if (c != EOF)
        ungetch(c);

    return NUMBER;
}

#define BUFSIZE 100
char buf[BUFSIZE];

int bufp = 0;

// 优先从buf读取
int getch(void)
{
    return (bufp > 0) ? buf[--bufp] : getchar();
}
// 放回buf
void ungetch(int c)
{
    if (bufp >= BUFSIZE)
        printf("error: too manay characters\n");
    else
    {
        buf[bufp++] = c;
    }
    
}