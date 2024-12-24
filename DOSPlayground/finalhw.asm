ASSUME CS:Zixun, DS:DATASEG
STACKS SEGMENT STACK    
    DB      200 DUP(?) 
STACKS ENDS

DATASEG SEGMENT
	tree	dw 1 dup (80)
			dw 7 dup (156)
			dw 6 dup (4)
			dw 10 dup (156)
			dw 10 dup (4)
			dw 7 dup (160)
			dw 3 dup (4)
			dw 7 dup (-160)
			dw 10 dup (4)
			dw 10 dup (-164)
			dw 6 dup (4)
			dw 7 dup (-164)
DATASEG ENDS

MENUSEG SEGMENT
	greeting DB "Merry Christmas! Let's make a Christmas Tree~ $"
	MSG DB "Please input your lucky number(maximum 9 chars): $"
	respond DB "Your lucky number is: $"
    CRLF db 13,10,'$'                   
    input_buffer    db 10
                    db ?
                    db 10 dup('$')
	input_num dw 0
MENUSEG ENDS

Zixun SEGMENT
	extrn cls:far
    extrn delay:far
;程序开始
start:
		call menu

		call convertNum

	;将显存段地址填入es，以便在屏幕中指定位置打印字符
		mov ax,0b800h
		mov es,ax	;显存段地址
			
		mov ax,DATASEG
		mov ds,ax  	;点阵数据源 
		call draw
		
		call over
		
;程序结束
over:
		mov ax,4c00h
		int 21h


; 子程序“menu”
; 功能：打印菜单，获取幸运数字，并将数字字符串保存在si中
menu:
		MOV AX,MENUSEG				
		MOV DS,AX			                	
		MOV AH,9
		mov dx, offset greeting
		int 21H

		mov dx, offset CRLF
		int 21h 
			        
		MOV DX,OFFSET MSG
		INT 21H				

		mov dx, offset input_buffer
		mov ah, 0ah
		int 21H

		mov dx, offset CRLF
		mov ah, 9
		int 21h 	

		mov dx, offset respond
		int 21h

	; input_buffer: first byte(maximum length), second byte(string length), rest bytes(string)
		mov dx, offset input_buffer+2
		int 21h

	; 添加循环延时来展示幸运数字
		mov cx, 3
	l1:
		call delay
		loop l1

		call cls

		ret

; 子程序"convertNum"
; 功能：将输入的幸运数字字符串转化为数字，并储存在input_num中
convertNum:
        mov ax, MENUSEG              ; 将MENUSEG段的地址加载到AX中
        mov ds, ax                   ; 将AX的值（MENUSEG段地址）加载到DS中
		mov si, 0
		xor ax, ax
		mov cl, ds:[input_buffer + 1]  ; 获取输入的字符数
	convert_loop:
		mov al, ds:[input_buffer + 2 + si]
		sub al, '0'
		mov bl, 10
		mul bl
		add ds:[input_num], ax
		inc si
		loop convert_loop

		ret

;子程序"draw"
; 功能：绘画圣诞树，图案由随机数+幸运数字来决定
draw:
		mov si,0
		mov di,0
		mov cx,84
		mov bl,1
	
	s4:	mov ax,ds:[si]
		add di,ax	

		;产生从1到256之间的随机数
		MOV AX, 256  
		MOV DX, 41H ;用端口41H 
		OUT DX, AX
		IN AL, DX ;产生的随机数AL	
		add ax, input_num
		add al, 20

		mov bh,al
		mov es:[di],bx
		add si,2
		call delay		
		loop s4
	
		ret
		
Zixun ENDS
end start