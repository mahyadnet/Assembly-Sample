S SEGMENT    ;Stack Segment

S ENDS

D SEGMENT    ;Data Segment
      MSAGE1 DB "Enter Character OR String To Reverse:", '$'
      MSAGE2 DB 35 DUP(?)
      MSAGE3 DB "Do Show Reverse? (Y/n):", '$'
      MSAGE4 DB "You Select No !", '$'
      MSAGE5 DB "Your Text Reverse Is:", '$'
D ENDS

C SEGMENT    ;Code Segment
    MAIN PROC FAR
        ASSUME SS:S, DS:D, CS:C
        MOV AX, d
        MOV DS, AX

        MOV AX, 0E00H ;Activating Console
        INT 10h

        MOV AX, 0002H
        MOV BX, 0000H
        MOV DX, 1010H
        INT 10H

        MOV AX, 0600H  ;Show Main Rectangular
        MOV BX, 4400H
        MOV CX, 0412H
        MOV DX, 133DH
        INT 10H

        MOV AX, 0600H  ;Show Up Rectangular
        MOV BX, 1700H
        MOV CX, 0513H
        MOV DX, 123CH
        INT 10H

        MOV AX, 0200H  ;Change CURSOR Position
        MOV BH, 0000H
        MOV DX, 0816H
        INT 10H

        MOV DX, OFFSET MSAGE1 ;PRINT FIRST MESSAGE
        MOV AX, 0900H
        INT 21H

        MOV AX, 0600H  ;Show A Line
        MOV BX, 2000H
        MOV CX, 0E13H
        MOV DX, 0E3CH
        INT 10H

        MOV AX, 0200H  ;Change CURSOR Position
        MOV BH, 0000H
        MOV DX, 0E18H
        INT 10H

        MOV CX, 0000H
        MOV SI, OFFSET MSAGE2

      LOOP1:              ;Get Array
        MOV AX, 0000H
        INT 16H
        CMP AL, 0DH
      JE LOOP2
        CMP AL, '$'
      JE LOOP1
        MOV [SI], AL
        MOV AH, 0EH
        INT 10H
        INC SI
        INC CX
        CMP CX, 20H
      JNE LOOP1

      LOOP2:          ;Change Array To String
        MOV CL, [SI]
        MOV CH, 0
        INC CX
        ADD SI, CX
        MOV DL, '$'
        MOV [SI], DL

        MOV AX, 0200H  ;Change CURSOR Position
        MOV BH, 0000H
        MOV DX, 0E18H
        INT 10H

        MOV AX, 0600H  ;Show Up Rectangular
        MOV BX, 1100H
        MOV CX, 0513H
        MOV DX, 123CH
        INT 10H

        MOV AX, 0600H  ;Show A Line
        MOV BX, 2000H
        MOV CX, 0B13H
        MOV DX, 0B3CH
        INT 10H

        MOV AX, 0200H  ;Change CURSOR Position
        MOV BH, 0000H
        MOV DX, 0B1CH
        INT 10H

        MOV AX, 0900H  ;Show String
        MOV DX, OFFSET MSAGE3
        INT 21H

      LOOP3:
        MOV AX, 0600H  ;Show A Line
        MOV BX, 2000H
        MOV CX, 0B2CH
        MOV DX, 0B2CH
        INT 10H

        MOV AX, 0200H  ;Change CURSOR Position
        MOV BH, 0000H
        MOV DX, 0B33H
        INT 10H

        MOV AX, 0000H   ;Get Select
        INT 16H
        CMP AL, 4EH     ;N
      JE LOOP4
        CMP AL, 6EH     ;n
      JE LOOP4
        CMP AL, 59H     ;Y
      JE LOOP5
        CMP AL, 79H     ;y
      JE LOOP5
      JMP LOOP3

      LOOP4:
        MOV AX, 0600H  ;Show A Line
        MOV BX, 2000H
        MOV CX, 0B13H
        MOV DX, 0B3CH
        INT 10H

        MOV AX, 0200H  ;Change CURSOR Position
        MOV BH, 0000H
        MOV DX, 0B20H
        INT 10H

        MOV AX, 0900H  ;Show String
        MOV DX, OFFSET MSAGE4
        INT 21H
      JMP LOOP6

       LOOP5:
        MOV AX, 0600H  ;Show A Line
        MOV BX, 2000H
        MOV CX, 0B13H
        MOV DX, 0B3CH
        INT 10H

        MOV AX, 0200H  ;Change CURSOR Position
        MOV BH, 0000H
        MOV DX, 0B1DH
        INT 10H

        MOV AX, 0900H  ;Show String
        MOV DX, OFFSET MSAGE5
        INT 21H

        MOV AX, 0600H  ;Show A Line
        MOV BX, 0E400H
        MOV CX, 0C13H
        MOV DX, 0C3CH
        INT 10H

        MOV AX, 0200H  ;Change CURSOR Position
        MOV BH, 0000H
        MOV DX, 0C18H
        INT 10H

        ;MOV AX, 0900H  ;Show String
        ;MOV DX, OFFSET MSAGE2
        ;INT 21H

        MOV AH, 0EH
        MOV CX, 0020H

      LOOP7:    ;Show Reverse
        DEC SI
        MOV AL, [SI]
        CMP AL, '$'
      JE LOOP6
        INT 10H
        LOOP LOOP7

       LOOP6:
         MOV AX, 4C00H    ;Give Back Control To OS
         INT 21H

    MAIN ENDP
C ENDS
    END MAIN
