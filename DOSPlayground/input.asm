DATASEG SEGMENT                         
    MSG DB "Please input a number from 1 to 100(maximum 9 chars): $"
    CRLF db 13,10,'$'                   
    input_buffer    db 10
                    db ?
                    db 10 dup(0)
DATASEG ENDS

STACKS SEGMENT STACK    
    DB      200 DUP(?) 
STACKS ENDS

Zixun SEGMENT                           ; Code segment
    ASSUME CS:Zixun, DS:DATASEG, SS: STACKS         
MAIN PROC FAR                           
	MOV AX,DATASEG				
	MOV DS,AX			                	
	MOV AH,9					        
	MOV DX,OFFSET MSG
	INT 21H				

    mov dx, offset input_buffer
    mov ah, 0ah
    int 21H

    mov dx, offset CRLF
    mov ah, 9
    int 21h 	

    ; input_buffer: first byte(maximum length), second byte(string length), rest bytes(string)
    mov cl, input_buffer+1              ; get string length
    mov si, offset input_buffer+2       ; get string

print:
    mov dl, [si]
    mov ah, 2
    int 21H
    inc si
    dec cl
    jnz print
    
	MOV AX,4C00H				;Set AX as 4C00, means return 0
	INT 21H						;DOS break, return
MAIN ENDP

Zixun ENDS
    END MAIN                            ; End of program, main is the entry point