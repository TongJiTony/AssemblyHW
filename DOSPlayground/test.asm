    cmp    a, b     
    jl     Less
    mov    x, 5
    mov    y, c + d 
    jmp    Both            
Less: 
    mov    x, c - d
Both:

    mov i, 0
    mov f, 0
L1:
    mov ax, c[i]
    mul ax, x[i]
    add f, ax
    inc i
    cmp i, N
    jge End
    loop L1
End:
