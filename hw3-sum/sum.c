#include <stdio.h>

int main()
{
    int sum = 0;
    int i;

    // 求和
    for (i = 1; i <= 100; i++)
    {
        sum += i;
    }

    // 打印提示信息和结果
    printf("The sum of 1 to 100 is: %d\n", sum);

    return 0;
}