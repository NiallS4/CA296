; Extend the previous program. This time instead of just counting from 9 down to 0 - 
; ... you should use both digits and count down from 99 to 00. 

	ORG 00
	MOV AL, 00
	OUT 02				; Clear LHS of Seven Segment Display
	MOV AL, 01
	OUT 02				; Clear RHS of Seven Segment Display
	MOV BL, 90			; RHS table location
	MOV CL, A0			; LHS table location

	CALL 70				; Call procedure at 70 once to start LHS at 9
	INC CL				; Advance to next LHS table position
loop:
	CALL 50				; Execute procedure at memory location 50	
	INC BL				; Advance to next RHS table position
	CMP BL, 9A			; Check if BL < 9A (i.e. table not out of range)
	JS loop				; If true loop again
	MOV BL, 90			; Else return to start of table
	CMP CL, AA			; Check if CL < AA (i.e. table not out of range)
	JNS loopend			; If not exit loop
	CALl 70				; Procedure to change LHS digit will execute if BL out of range
	INC CL				; Advance to next LHS table position
	JMP loop
loopend:
	HALT

	ORG 50
	PUSHF				; Backup all affected registers
	MOV AL, [BL]
	OUT 02				; Output digit on Seven Segment Display
	POPF				; Restore all affected registers
	RET
	
	ORG 70
	PUSHF				; Backup all affected registers
	MOV AL, [CL]
	OUT 02				; Output digit on Seven Segment Display
	POPF				; Restore all affected registers
	RET

	ORG 90				; Table is at memory location 90
	DB DF				; Code for 9 on RHS
	DB FF
	DB 8B
	DB FD
	DB DD
	DB 4F
	DB 9F
	DB B7
	DB 0B
	DB FB				; Code for 0 on RHS
	
	ORG A0				; Table is at memory location A0
	DB DE				; Code for 9 on LHS
	DB FE
	DB 8A
	DB FC
	DB DC
	DB 4E
	DB 9E
	DB B6
	DB 0A
	DB FA				; Code for 0 on LHS

	END