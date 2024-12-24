CALSEG SEGMENT
    ASSUME cs:CALSEG
    PUBLIC cls
    PUBLIC delay

MAIN PROC

;子程序“cls”
;功能：清屏
cls proc far
		mov ah, 06h  ; 功能号：滚动窗口
		mov al, 0    ; 行数：0 表示整个窗口
		mov bh, 07h  ; 属性：黑色背景，白色前景
		mov ch, 0    ; 起始行
		mov cl, 0    ; 起始列
		mov dh, 24   ; 结束行（假设屏幕有 25 行）
		mov dl, 79   ; 结束列（假设屏幕有 80 列）
		int 10h      ; 调用 BIOS 中断
		ret
cls endp
		
;子程序“delay”
;功能：延时
delay proc far
		push cx
		mov cx,0ffh
		run1:
		push cx
		mov cx,08ffh
		run2:
		loop run2
		pop cx
		loop run1
		pop cx
		ret
delay endp

MAIN ENDP
CALSEG ENDS
END MAIN