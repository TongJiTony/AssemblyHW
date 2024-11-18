CALSEG SEGMENT
    ASSUME cs:CALSEG
    PUBLIC fill_table

MAIN PROC

fill_table proc far
	mov bp,0 		;用于table表寻址，每次循环自增16
	mov si,0 		;用于数据中summ寻址，每次循环自增4
	mov di,0 		;用于数据中ne寻址，每次循环自增2
	mov cx,21
transmit_s0:
	push cx
	mov bx,si  		;year寻址
	push si
	mov si,0
	mov cx,4
transmit_s1:
	mov al,ds:[bx+si]
	mov es:[bp+si],al
	inc si
	loop transmit_s1
	pop si

	mov ax,ds:[di+168]
	mov es:[bp+0ah],ax	

	mov ax,ds:[si+84]	;双字型数据的低16位
	mov dx,ds:[si+86]	;双字型数据的高16位
	mov es:[bp+5],ax
	mov es:[bp+7],dx	;table表存入summ

	div word ptr es:[bp+0ah]
	mov es:[bp+0dh],ax	;除法计算，table表存入ave

	add bp,16
	add si,4
	add di,2
	pop cx
	loop transmit_s0
	ret
fill_table endp

MAIN ENDP
CALSEG ENDS
END MAIN