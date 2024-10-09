STKSEG SEGMENT STACK
    buffer DB 5 DUP(0)   ; 缓冲区，最多能存储 4 位数字 + 终止符
STKSEG ENDS

DATASEG SEGMENT                         ; Store string data
    MSG DB "The sum of 1 to 100: $"     ; Alphabet string without end-of-string marker
DATASEG ENDS

Zixun SEGMENT                           ; Code segment
    ASSUME CS:Zixun, DS:DATASEG         ; Declare cs and ds registers
MAIN PROC FAR                           ; Entry point of main function
	MOV AX,DATASEG				;Move data segment to ax(temp) and then pass to DS
	MOV DS,AX					;Grammar requirement
	MOV AH,9					;9 represents printing on screen in DOS function
	MOV DX,OFFSET MSG 			;Store the address offset of string data in DX
	INT 21H						;DOS break, print string

    MOV CX, 100
    MOV AX, 0
SUM_LOOP:
    ADD AX, CX
    LOOP SUM_LOOP

    CALL ConvertToAscii

    MOV AH, 9
    LEA DX, buffer
    INT 21H

	MOV AX,4C00H				;Set AX as 4C00, means return 0
	INT 21H						;DOS break, return
MAIN ENDP

ConvertToAscii PROC
    PUSH AX              ; 保存 AX 寄存器值
    PUSH BX              ; 保存 BX 寄存器
    PUSH CX              ; 保存 CX 寄存器
    PUSH DX              ; 保存 DX 寄存器

    LEA DI, buffer + 4      ; DI 指向缓冲区的末尾
    MOV BYTE PTR [DI], '$'  ; 在缓冲区末尾加上字符串结束符 '$'
    DEC DI                  ; DI 指向倒数第二个位置

    MOV CX, 0            ; 清零 CX（用于计数）

convert_loop:
    XOR DX, DX           ; DX = 0，为 DIV 做准备
    MOV BX, 10           ; 除以 10
    DIV BX               ; AX 除以 10，商存入 AX，余数存入 DX
    ADD DL, '0'          ; 将余数转换为 ASCII 字符
    MOV [DI], DL         ; 将字符存入缓冲区
    DEC DI               ; 指针 DI 前移
    INC CX               ; 增加字符长度计数
    TEST AX, AX          ; 检查商是否为 0
    JNZ convert_loop     ; 如果商不为 0，继续循环

    ; DI 现在指向第一个非零数字的位置
    ADD DI, 1            ; 将 DI 指向正确的字符串起始位置

    ; 将缓冲区剩余部分前移（因为数字是从右到左存储的）
    LEA SI, buffer+5     ; SI 指向缓冲区结束位置 '$'
    SUB SI, CX           ; 减去数字长度
    LEA DI, buffer       ; DI 指向缓冲区开始位置
    MOVSB                ; 将内容移动至缓冲区开始

    POP DX               ; 恢复 DX
    POP CX               ; 恢复 CX
    POP BX               ; 恢复 BX
    POP AX               ; 恢复 AX
    RET
ConvertToAscii ENDP

Zixun ENDS
    END MAIN                            ; End of program, main is the entry point