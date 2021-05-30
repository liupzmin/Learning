#include "dynamic_lib.h"
#include "static_lib.h"

void foobar(int i)
{
    printf("Printing from Lib.so %d\n", i);
    static_hello(2);
}