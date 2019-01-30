; Modify the previous program so that it counts up from 00 to 99.

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
	JS loop				; If within range loop again
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
	DB FB
	DB 0B
	DB B7
	DB 9F
	DB 4F
	DB DD
	DB FD
	DB 8B
	DB FF
	DB DF

	ORG A0				; Table is at memory location A0
	DB FA
	DB 0A
	DB B6
	DB 9E
	DB 4E
	DB DC
	DB FC
	DB 8A
	DB FE
	DB DE

	END