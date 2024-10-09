.model small
.stack 100h
.data
    msg db "The sum of 1 to 100 is: $"
.code
main:
    mov ax, @data
    mov ds, ax
    
    ; 初始化求和变量
    mov cx, 100
    xor ax, ax
    
    ; 求和
sum_loop:
    add ax, cx
    loop sum_loop
    
    ; 打印提示信息
    mov si, 0
print_msg:
    mov al, [msg + si]
    cmp al, '$'
    je print_result
    mov ah, 02h
    int 21h
    inc si
    jmp print_msg
    
    ; 打印结果
print_result:
    mov dx, ax
    mov ah, 02h
    int 21h
    
    ; 退出程序
    mov ax, 4C00h
    int 21h
end main