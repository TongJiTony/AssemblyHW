#include <stdio.h>

int main()
{
    char msg[] = "abcdefghijklmnopqrstuvwxyz";
    int i, j;

    for (i = 0; i < 26; i++)
    {
        for (j = 0; j < 13; j++)
        {
            printf("%c", msg[i * 13 + j]);
        }
        printf("\n");
    }

    return 0;
}