DATASEG SEGMENT
    years db '1975', '1976', '1977', '1978', '1979', '1980', '1981', '1982', '1983', 
          '1984', '1985', '1986', '1987', '1988', '1989', '1990', '1991', '1992', 
          '1993', '1994', '1995'
    revenue dd 16, 22, 382, 1356, 2390, 8000, 16000, 24486, 50065, 97479, 
            140417, 197514, 345980, 590827, 803530, 1183000, 1843000, 
            2759000, 3753000, 4649000, 5937000
    employees dw 3, 7, 9, 13, 28, 38, 130, 220, 476, 778, 1001, 1442, 
              2258, 2793, 4037, 5635, 8226, 11542, 14430, 15257, 17800

    crlf db 0ah, 0dh, '$'   ;回车换行
DATASEG ENDS

TABLESEG SEGMENT
    table db 21 dup('year summ ne ?? '); 分配用于存储结果的表空间
TABLESEG ENDS

ZIXUNSEG SEGMENT    ;code segment
    ASSUME CS:ZIXUNSEG, DS:DATASEG, SS: STACKS
    extrn fill_table:far
    extrn print_table:far

MAIN PROC FAR
    mov ax, DATASEG
    mov ds, ax
    mov ax, TABLESEG
    mov es, ax
    call fill_table

    mov ax, TABLESEG
    mov ds, ax
    call print_table

    mov ax,4c00h
    int 21h
MAIN ENDP

ZIXUNSEG ENDS
END MAIN