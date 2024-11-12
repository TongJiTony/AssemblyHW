# HW5-report

## 1. 创建好四个汇编代码文件

我将这个作业逻辑拆分成四部分，分别储存工资数据，创建table空间，计算工资并填入table，最后通过print.asm打印table内容。

其中，用extern关键字（和C++）一样，声明使用的其他模块。

## 2. 分别编译并用link连接到一起

```
nasm -f elf64 salary.asm -o salary.o
nasm -f elf64 table.asm -o table.o
nasm -f elf64 calculate.asm -o calculate.o
nasm -f elf64 print.asm -o print.o

link -o program salary.o table.o calculate.o print.o
```
