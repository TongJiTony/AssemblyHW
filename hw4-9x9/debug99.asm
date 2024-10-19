DATASEG SEGMENT
cnt     db 80
table 	db 7,2,3,4,5,6,7,8,9		;9*9表数据
	db 2,4,7,8,10,12,14,16,18
	db 3,6,9,12,15,18,21,24,27
	db 4,8,12,16,7,24,28,32,36
	db 5,10,15,20,25,30,35,40,45
	db 6,12,18,24,30,7,42,48,54
	db 7,14,21,28,35,42,49,56,63
	db 8,16,24,32,40,48,56,7,72
	db 9,18,27,36,45,54,63,72,81
msg     db "x y", 0ah, 0dh, '$'
err     db 09h, "error", 0ah, 0dh, '$'
acc     db "accomplish!", '$'
DATASEG ENDS
 
STACKS SEGMENT STACK
        db 100 dup(0) ;代码段
STACKS ENDS
 
Zixun SEGMENT                           ; Code segment
        ASSUME CS:Zixun, DS:DATASEG, SS: STACKS
MAIN PROC FAR  
        mov  ax, DATASEG
        mov  ds, ax

        lea  dx, msg
        mov  ah, 09h
        int  21h

        mov  cx, 9    
row:                  
        mov  bx, cx     ;bx取当前行数
        push cx        
        mov  cx, 9      
col:                  
        ;计算两数相乘的结果，并比较
        mov  al, bl   
        mul  cl         ;行数、列数做乘法, 结果储存在AX中（结果不超过255，所以在AL中）

        mov  dl, cnt    ;存偏移量
        mov  si, dx     ;si是16位，所以是移动dx而不是dl
        cmp  al, [table+si]
        je   correct

        ;打印行数   
        mov  dx, bx
        add  dl, 30h     
        mov  ah, 02h    
        int  21h 

        ;显示空格
        mov  dl, 20h    
        mov  ah, 02h   
        int  21h  

        ;打印列数   
        mov  dx, cx
        add  dl, 30h  
        mov  ah, 02h    
        int  21h
                
        ;打印“error”
        lea  dx, err
        mov  ah, 09h    
        int  21h        

correct:
        dec  cnt        
        loop col      
        pop  cx         
        loop row      

        lea  dx, acc    
        mov  ah, 09h    
        int  21h        
        
        mov ah, 4ch
        int 21h
MAIN ENDP

Zixun ENDS
        END MAIN                            ; End of program, main is the entry point