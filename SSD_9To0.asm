; Write a program to count from 9 down to 0 on the 7-segment display. Use the right hand digit.
; Once it is working, modify your code so that it now uses the left-hand digit.

	ORG 00
	MOV AL, 00
	OUT 02				; Clear LHS of Seven Segment Display
	MOV AL, 01
	OUT 02				; Clear RHS of Seven Segment Display
	MOV BL, 90			; Lookup digit in table
loop:
	CALL 50				; Execute procedure at memory location 50
	INC BL				; Advance to next table position
	CMP BL, 9A			; Check if BL < 9A (i.e. table not out of range)
	JS loop				; If true loop again
	MOV BL, 90			; Else return to start of table
	HALT

	ORG 50
	PUSHF				; Backup all affected registers
	MOV AL, [BL]
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

	END