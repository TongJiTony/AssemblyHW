str segment			;四字节数字转十进制的中间栈
	db ' ' dup (15)
str ends

PRINTSEG SEGMENT
    ASSUME cs:PRINTSEG
    PUBLIC print_table

MAIN PROC

print_table PROC FAR
    mov dx,0
	mov bp,0		;bp确定table中的位置信息（行）
	mov cx,21		;循环21次
print_line:
	push cx			;循环次数
	push dx			
	push ax		

	call str_ini		;中间栈初始化

	mov ax,str
	mov es,ax		;str字符串的段地址

	mov cx,4
	mov si,0
Years:
	mov al,ds:[bp+si]
	mov es:[si],al
	inc si
	loop Years			;将年份信息复制到str中

	pop cx			
	pop dx				
	call show_str		;显示年份

	call str_ini
	add dl,8		;列数+8
	mov ax,ds:[bp+5]
	mov dx,ds:[bp+7]
	call Dtoc			;将收入数值转成字符串存放在str中
	call show_str		;显示收入

	call str_ini
	add dl,8
	mov dx,0
	mov ax,ds:[bp+0ah]
	call Dtoc
	call show_str		;显示人数

	call str_ini
	add dl,8
	mov dx,0
	mov ax,ds:[bp+0dh]
	call Dtoc
	call show_str	    ;显示平均值

	;一行所有信息显示完后打印回车
    MOV AH, 02H                         ; DOS interrupt function 2 (print character)
    MOV DL, 0DH                         ; Carriage return character
    INT 21H                             ; Call DOS interrupt to print DL
    MOV DL, 0AH                         ; Line feed character
    INT 21H                             ; Call DOS interrupt to print DL

	add bp,16
	mov ax,cx		
	inc dh			;行数+1
	mov dl,0		;列数设为0
	pop cx			;循环次数出栈
	loop print_line
	ret
print_table ENDP

;进行不会产生溢出的除法运算
Divdw proc
    push ax			;将低16位入栈保存
    mov ax,dx
	sub dx,dx
	div cx			;计算H/N以及H%N, 得到的H/N(ax)就是最终结果的高16位
	pop bx			;取出L
	push ax			;最终结果的高16位入栈
	mov ax,bx
	div cx			;计算结果的低16位商放在ax
	mov cx,dx		;将结果的余数放在cx
	pop dx			;将结果的高16位放在dx
	ret
Divdw endp
        
;将16进制数转成10进制数的字符形式, 存放在str段中
Dtoc proc
	push cx
	push dx

    push ds
	mov bx,str
	mov ds,bx

	mov si,0
Dtoc_s0:
	mov cx,10		;除数设为10
	call Divdw
	push cx			;余数入栈
	inc si
	mov cx,ax
	add cx,dx		;cx判断商是否为0
jcxz ok_
	jmp short Dtoc_s0
ok_:			        ;处理完最高位数字后
	mov cx,si
	sub si,si
Dtoc_s1:
	pop bx
	add bx,'0'
	mov ds:[si],bl
	inc si
	loop Dtoc_s1
	pop ds

	pop dx
	pop cx
	ret
Dtoc endp
        
;显示str段的内容在屏幕上
show_str proc
	push dx
	push cx
	push ds			;table表的ds入栈

	mov ax,str
	mov ds,ax
    mov si,0        ;从头开始打印str
	mov cx,15

INNER_LOOP:
    MOV AL, [SI]                        ; Load the character at [SI] into AL
    MOV DL, AL                          ; Move the character from AL to DL
    MOV AH, 02H                         ; DOS interrupt function 2 (print character)
    INT 21H                             ; Call DOS interrupt to print DL

    INC SI                              ; Move to the next character in MSG
    LOOP INNER_LOOP                     ; Decrement CX and loop until CX = 0

show_str_ok:
	pop ds
	pop cx
	pop dx
	ret
show_str endp

;将str段字符串初始化
str_ini proc
	push ax
	push bx
	push cx
	push es
	mov ax,str
	mov es,ax
	mov bx,0
	mov cx,15
ini:mov byte ptr es:[bx],' '
	inc bx
	loop ini		;将str数据全部设为' '(空格)
	pop es
	pop cx
	pop bx
	pop ax
	ret
str_ini endp

MAIN ENDP
PRINTSEG ENDS
END MAIN