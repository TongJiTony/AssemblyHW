.model small
.stack 100h
.data
    msg db "abcdefghijklmnopqrstuvwxyz"  ; 字母表字符串，不包含终止符
.code
main:
    mov ax, @data
    mov ds, ax
    
    ; 初始化
    mov si, 0        ; 字符串指针，指向第一个字符
    mov cx, 26       ; 循环次数，字母表中有26个字符
    
print_loop:
    ; 加载当前字符到AL寄存器
    mov al, msg[si]  ; 使用方括号直接访问内存中的字符
    
    ; 打印当前字符
    mov ah, 02h      ; DOS中断功能号，表示打印字符
    int 21h          ; 调用DOS中断，打印AL寄存器中的字符
    
    ; 更新字符串指针，指向下一个字符
    inc si
    
    ; 手动减少cx，检查是否继续循环
    dec cx
    jnz print_loop   ; 如果cx不为0，跳回print_loop继续打印
    
    ; 打印换行符，使输出更整洁
    mov al, 0Dh      ; 回车符
    mov ah, 02h
    int 21h
    mov al, 0Ah      ; 换行符
    mov ah, 02h
    int 21h
    
    ; 退出程序
    mov ax, 4C00h    ; DOS中断功能号，表示程序结束
    int 21h          ; 调用DOS中断，结束程序
end main
