# HW5-report

## 1. 创建好四个汇编代码文件

![1731467361959](image/hw5-report/1731467361959.png)

我将这个作业逻辑拆分成三部分，分别是main.asm存放工资数据段，创建table空间并调用其他模块，calculate.asm计算工资并填入table，print.asm打印table内容。

其中，用extern关键字（和C++）一样，声明使用的其他模块。

## 2. 分别编译并用link连接到一起

```
nasm -f elf64 main.asm -o main.o
nasm -f elf64 calculate.asm -o calculate.o
nasm -f elf64 print.asm -o print.o

link -o program main.o calculate.o print.o
```
