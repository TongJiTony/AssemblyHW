CALSEG SEGMENT
    ASSUME cs:CALSEG
    PUBLIC fill_table

MAIN PROC

fill_table proc far
	mov bp,0 		; 用于table表寻址，每一行十六字节，每次循环自增16
	mov si,0 		; 用于数据中summ寻址，即收入double word，每次循环自增4
	mov di,0 		; 用于数据中ne寻址，即人数word，每次循环自增2
	mov cx,21		; 循环21次

fill_line:
	push cx
	mov bx, si  		; year寻址
	push si
	mov si,0
	mov cx,4

fill_byte:
	mov al,ds:[bx+si]	; get year data from DATASEG
	mov es:[bp+si],al	; fill TABLESEG
	inc si
	loop fill_byte
	pop si

	mov ax,ds:[di+168]	; 雇员数量 
	mov es:[bp+0ah],ax	

	mov ax,ds:[si+84]	; 双字型数据的低16位
	mov dx,ds:[si+86]	; 双字型数据的高16位
	mov es:[bp+5],ax
	mov es:[bp+7],dx	; table表存入收入

	div word ptr es:[bp+0ah] 	; 除数为员工数量
	mov es:[bp+0dh],ax	; 除法计算，table表存入ave

	add bp,16
	add si,4
	add di,2
	pop cx
	loop fill_line
	ret
fill_table endp

MAIN ENDP
CALSEG ENDS
END MAIN