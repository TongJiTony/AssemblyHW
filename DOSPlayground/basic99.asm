DATASEG SEGMENT
        MSG DB "The 9x9 table is: $"
        res db 00H,'*',00H,'=',2 dup(0),' ','$' 
        CRLF db 13,10,'$'
DATASEG ENDS
 
STACKS SEGMENT STACK
        db 100 dup(0) ;代码段
STACKS ENDS
 
Zixun SEGMENT                           ; Code segment
        ASSUME CS:Zixun, DS:DATASEG, SS: STACKS         
MAIN PROC FAR   
        mov ax, DATASEG
        mov ds, ax

        mov ah, 9h
        mov dx, offset MSG
        int 21H

        mov ah, 9h 
        mov dx, offset CRLF
        int 21h
        
        ; loop 9 times, starting from 9*1, 9*2, ..., 9*9 
        mov cx, 9
print_line:
        call PrintMul
        mov ah, 9h 
        mov dx, offset CRLF
        int 21h
        loop print_line
        
	MOV AX,4C00H				;Set AX as 4C00, means return 0
	INT 21H				        ;DOS break, return
MAIN ENDP

PrintMul PROC
        push ax
        push bx
        push cx
        push dx

        mov bl, cl
        mov bh, 1

inner_loop:
        mov res[0], bl
        mov res[2], bh
        add res[0], 30h
        add res[2], 30h                         ; 整数和其ASCII码相差48

        ; 八位乘法， 结果储存在AX中（结果不超过255，所以在AL中）
        mov al, bl
        mul bh

        ; 保存好bl和bh，将AL中的两位数拆分成十位数和个位数，利用八位除法，分别储存在AL和AH
        push bx
        mov bl, 10
        div bl
        pop bx

        add ah, 30h
        add al, 30h
        mov res[4], al
        mov res[5], ah

        mov ah, 9h
        mov dx, offset res
        int 21h

        inc bh
        cmp bh, bl
        jle inner_loop

        pop dx
        pop cx
        pop bx
        pop ax
        RET
PrintMul ENDP

Zixun ENDS
        END MAIN                            ; End of program, main is the entry point