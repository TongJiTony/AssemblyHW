STKSEG SEGMENT STACK
DW 32 DUP(0)
STKSEG ENDS

DATASEG SEGMENT 				;Store string data
	MSG DB "Hello World$"
DATASEG ENDS

Zixun SEGMENT 					;The segment name could change
	ASSUME CS:Zixun,DS:DATASEG	;Declare cs and ds register
MAIN PROC FAR					;Entry of main function
	MOV AX,DATASEG				;Move data segment to ax(temp) and then pass to DS
	MOV DS,AX					;Grammar requirement
	MOV AH,9					;9 represents printing on screen in DOS function
	MOV DX,OFFSET MSG 			;Store the address offset of string data in DX
	INT 21H						;DOS break, print string
	MOV AX,4C00H				;Set AX as 4C00, means return 0
	INT 21H						;DOS break, return
MAIN ENDP
Zixun ENDS
	END MAIN					;Declare main as program entry
