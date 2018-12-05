; Write a program to read a character from the keyboard. Split the character into two hexadecimal digits
; and display each digit separately on the seven segment display (the first digit on the left, the second on
; the right). Only the numbers 0-9, should be accepted as valid input. Hint: work out 0-F digit codes for the
; seven segment display first. Then put them into a table. The program should continue to allow the user
; to input characters until a lowercase Q is entered.

loop:
	IN 00				; 1st digit on RHS in AL
	CMP AL, 71			; The Zero flag is set if AL == 'q' (cleared otherwise)
	JZ end				; If true end program
	CMP AL, 30			; Check if input >= '0'
	JS loop
	CMP AL, 3A			; Check if input <= '9'
	JNS loop
	CALL 50				; Call procedure at memory location 50
	JMP loop

end:
	HALT

	ORG 50
	PUSHF				; Save flags

	PUSH AL				; Backup character
	AND AL, 0F			; 2nd digit now on RHS in AL
	PUSH AL
	POP CL				; Move to CL
	POP AL				; Restore original number in AL
	AND AL, F0			; 1st digit now on LHS in AL
	DIV AL, 10			; Move digit to RHS in AL

	ADD AL, A0			; Get address of 1st character
	MOV BL, [AL]			; Get ASCII code from table
	PUSH BL
	POP AL
	OUT 02				; Display on Seven Segment Display
	ADD CL, 90			; Get address of 2nd character
	MOV BL, [CL]			; Get ASCII code from table
	PUSH BL
	POP AL
	OUT 02				; Display on Seven Segment Display

	POPF				; Restore flags
	RET

	; RHS Table
	ORG 90
	DB FB				; Code for 0 on RHS
	DB 0B
	DB B7
	DB 9F
	DB 4F
	DB DD
	DB FD
	DB 8B
	DB FF
	DB DF				; Code for 9 on RHS
	DB EF				; Code for A on RHS
	DB 7D
	DB F1
	DB 3F
	DB F5
	DB E5				; Code for F on RHS

	; LHS Table
	ORG A0
	DB FA				; Code for 0 on LHS
	DB 0A
	DB B6
	DB 9E
	DB 4E
	DB DC
	DB FC
	DB 8A
	DB FE
	DB DE				; Code for 9 on LHS
	DB EE				; Code for A on LHS
	DB 7C
	DB F0
	DB 3E
	DB F4
	DB E4				; Code for F on LHS

	END
