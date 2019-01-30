; Write a procedure for getting the sum of all the odd numbers in a range of memory addresses. The
; procedure should accept the range in registers AL and BL (where AL <=BL). Your procedure should find
; the sum of the odd numbers in [AL], [AL+1]....[BL-1],[BL] (where [X] represents the contents of
; memory location X) and return the answer in CL.
; Test the procedure by using the assembler to put some (at least 10) numbers into a region of memory. Call
; the procedure and make sure it returns the correct answer in CL. You can treat numbers as unsigned
; hexadecimal. Hint: Remember that numbers ending in B,D and F are also odd.The MOD instruction may
; be useful. Also, it may or may not be helpful to remember: multiplying by 1 preserves a number.
; multiplying by 0 gives 0.

	ORG A0					; Test numbers at memory location A0
	DB 01
	DB 02
	DB 03
	DB 04
	DB 05
	DB 6A
	DB 6B
	DB 7C
	DB 7D

	ORG 00

	MOV AL, A0				; Start checking numbers from location A0
	MOV BL, A9				; Stop at location A9

loop:
	CALL 50					; Call procedure at memory location 50
	CMP AL, BL				; Check if AL == BL (i.e. A9 == A9)
	JZ end					; If true end program
	INC AL
	JMP loop				; Else move to next memory location
	HALT

	ORG 50
	PUSHF					; Save flags
	PUSH BL					; Backup BL to stack
	MOV BL, [AL]			; Move number in AL to BL
	MOD BL, 02				; Divide BL by 2
	CMP BL, 00				; Check if BL is now 0 (i.e. number is even)
	POP BL					; Restore BL to original number
	JZ exit					; If BL is 0 exit procedure
	JMP continue			; Else continue

continue:
	PUSH BL					; Backup BL to stack
	MOV BL, [AL]			; Move number in AL to BL
	ADD CL, BL				; Store sum of odd numbers in CL
	POP BL					; Restore BL to original number

exit:
	POPF					; Restore flags
	RET

end:
	END