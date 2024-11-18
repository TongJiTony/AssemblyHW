CALSEG SEGMENT
    ASSUME cs:CALSEG
    EXTRN data:FAR
	EXTRN table:FAR
    PUBLIC fill_table

MAIN PROC
fill_table proc far:
    ; 将 `data` 中的数据填充到 `table`，包括计算每年的平均收入
    
fill_table ENDP

MAIN ENDP
CALSEG ENDS
END MAIN