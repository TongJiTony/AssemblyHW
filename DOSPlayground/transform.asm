.model small
.stack 100h
.data
    msg1 db "Please enter a number between 1 and 100: $"
    msg2 db "The sum of 1 to $"
    msg3 db " is: $"
.code
main:
    mov ax, @data
    mov ds, ax
    
    ; 打印提示信息
    mov si, 0
print_msg1:
    mov al, [msg1 + si]
    cmp al, '$'
    je get_input
    mov ah, 02h
    int 21h
    inc si
    jmp print_msg1
    
    ; 获取用户输入
get_input:
    mov ah, 0Ah
    lea dx, [buffer]
    int 21h
    
    ; 将输入的字符转换为数字
    mov si, 0
    xor ax, ax
    mov cl, [buffer + 1]  ; 获取输入的字符数
convert_loop:
    mov al, [buffer + 2 + si]
    sub al, '0'
    mov bl, 10
    mul bl
    add [input_num], ax
    inc si
    loop convert_loop
    
    ; 初始化求和变量
    mov cx, [input_num]
    xor ax, ax
    
    ; 求和
sum_loop:
    add ax, cx
    loop sum_loop
    
    ; 打印提示信息
    mov si, 0
print_msg2:
    mov al, [msg2 + si]
    cmp al, '$'
    je print_input_num
    mov ah, 02h
    int 21h
    inc si
    jmp print_msg2
    
    ; 打印用户输入的数字
print_input_num:
    mov dx, [input_num]
    call print_num
    
    ; 打印提示信息
    mov si, 0
print_msg3:
    mov al, [msg3 + si]
    cmp al, '$'
    je print_result
    mov ah, 02h
    int 21h
    inc si
    jmp print_msg3
    
    ; 打印结果
print_result:
    mov dx, ax
    call print_num
    
    ; 退出程序
    mov ax, 4C00h
    int 21h
    
; 打印十进制数的子程序
print_num:
    push ax
    push bx
    push cx
    push dx
    
    mov ax, dx
    xor cx, cx
    mov bx, 10
div_loop:
    xor dx, dx
    div bx
    add dl, '0'
    push dx
    inc cx
    or ax, ax
    jnz div_loop
print_loop:
    pop dx
    mov ah, 02h
    int 21h
    loop print_loop
    
    pop dx
    pop cx
    pop bx
    pop ax
    ret
    
.data
    buffer db 6, 0, 6 dup(0)
    input_num dw 0
end main