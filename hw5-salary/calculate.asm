extern years, revenue, employees
extern table

CALSEG SEGMENT
global fill_table
fill_table:
    ; 将 `data` 中的数据填充到 `table`，包括计算每年的平均收入
CALSEG ENDS