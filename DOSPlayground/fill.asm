CALSEG SEGMENT
    ASSUME cs:CALSEG
    PUBLIC fill_table
    EXTRN DATASEG:FAR
	EXTRN TABLESEG:FAR


MAIN PROC

fill_table proc far
    ; 将 `data` 中的数据填充到 `table`，包括计算每年的平均收入
    
fill_table ENDP

MAIN ENDP
CALSEG ENDS
END MAIN