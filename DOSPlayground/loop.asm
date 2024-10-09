STKSEG SEGMENT STACK
DW 32 DUP(0)
STKSEG ENDS

DATASEG SEGMENT                        ; Store string data
    MSG DB "abcdefghijklmnopqrstuvwxyz"  ; Alphabet string without end-of-string marker
DATASEG ENDS

Zixun SEGMENT                           ; Code segment
    ASSUME CS:Zixun, DS:DATASEG         ; Declare cs and ds registers
MAIN PROC FAR                           ; Entry point of main function
    MOV AX, DATASEG                     ; Move data segment offset to AX
    MOV DS, AX                          ; Initialize DS to point to DATASEG

    MOV SI, OFFSET MSG                  ; SI points to the beginning of MSG
    MOV CX, 2                           ; Number of lines to print (2 lines of 13 characters each)

OUTER_LOOP:
    PUSH CX                             ; Save outer loop's CX (number of lines)

    MOV CX, 13                          ; Set CX to 13 for inner loop (13 characters per line)

INNER_LOOP:
    MOV AL, [SI]                        ; Load the character at [SI] into AL
    MOV AH, 02H                         ; DOS interrupt function 2 (print character)
    INT 21H                             ; Call DOS interrupt to print AL

    INC SI                              ; Move to the next character in MSG
    LOOP INNER_LOOP                     ; Decrement CX and loop until CX = 0

    ; Print a newline character
    MOV AH, 02H                         ; DOS interrupt function 2 (print character)
    MOV DL, 0DH                         ; Carriage return character
    INT 21H                             ; Call DOS interrupt to print DL
    MOV DL, 0AH                         ; Line feed character
    INT 21H                             ; Call DOS interrupt to print DL

    POP CX                              ; Restore CX for outer loop
    LOOP OUTER_LOOP                     ; Decrement outer loop's CX and loop until CX = 0

    MOV AX, 4C00H                       ; DOS function to terminate the program
    INT 21H                             ; Call interrupt to terminate
MAIN ENDP
Zixun ENDS
    END MAIN                            ; End of program, main is the entry point
