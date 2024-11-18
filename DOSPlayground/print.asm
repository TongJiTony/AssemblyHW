PRINTSEG SEGMENT
    ASSUME cs:PRINTSEG
    EXTRN DATASEG:FAR
	EXTRN TABLESEG:FAR
    EXTRN CRLF:FAR
    PUBLIC print_table

MAIN PROC

print_table PROC FAR
    ; 输出 `table` 段的内容
    mov ax, DATASEG
    mov ds, ax

    mov ah, 9h
    mov dx, offset crlf
    int 21h
print_table ENDP

MAIN ENDP
PRINTSEG ENDS
END MAIN