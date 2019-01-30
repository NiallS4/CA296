; Write a program to get a digit (0-9) from the simple keyboard.
; If the character entered is not a digit, the character should be read again,
; until a digit is entered. A second digit should then be read into your program in the same way.
; When both digits have been read in, the two numbers should be multiplied and 
; the result left in AL when the program halts.

	MOV BL, 39		; put "9" in BL
	MOV DL, 30		; put "0" in DL

loop1:
	IN 00
	CMP BL, AL		; compare AL to "9"
	PUSH AL
	POP CL			; save for multiplication
	JNS digit1		; check if sign flag set (i.e. is digit)
	JS loop1		; else loop again (i.e. is not digit)

digit1:
	CMP DL, AL		; verify input is between "0" and "9"
	JZ loop2		; if input is "0", read next digit
	JS loop2		; if sign flag set, read next digit
	JNS loop1		; otherwise read input again

loop2:
	IN 00
	CMP BL, AL		; compare AL to "9"
	JNS digit2		; check if sign flag set (i.e. is digit)
	JS loop2		; else loop again (i.e. is not digit)

digit2:
	CMP DL, AL		; verify input is between "0" and "9"
	JZ mult			; if input is "0", advance to 'mult' loop
	JS mult			; if sign flag set, advance to 'mult' loop
	JNS loop2		; try reading input again

mult:
	SUB AL, 30		; convert to decimal
	SUB CL, 30		; convert to decimal
	MUL AL, CL		; Al * CL
	END
	
