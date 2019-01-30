; Write and test a program which checks if a number sent in (via register AL) is prime. If the
; number is prime, AL should be left unchanged, otherwise AL should be set to FF. You may
; wish to use the MOD instruction. To test your program write the results for the numbers 2-32
; (0x02 to 0x20) into memory locations [0x72] to [0x90].

MOV AL,02			; start at 02
MOV CL,72			; first memory location
MOV DL,FF

loop:
	PUSH AL			; push to BL
	POP BL
	CMP BL,01		; check if BL == "1" (i.e. not prime)
	JZ notprime
	PUSH AL
	POP BL
	CMP BL,02		; check if BL == "2" (i.e. prime)
	JZ prime
	PUSH AL
	POP BL
	CMP BL,03		; check if BL == "3" (i.e. prime)
	JZ prime
	PUSH AL
	POP BL
	MOD BL,02
	CMP BL,00		; check if BL % 2 == 0 (i.e. not prime)
	JZ notprime
	PUSH AL
	POP BL
	MOD BL,03
	CMP BL,00		; check if BL % 3 == 0 (i.e. not prime)
	JZ notprime
	JMP prime		; otherwise number is prime
	
notprime:
	MOV [CL],DL		; move FF into memory
	INC CL			; advance to next location
	INC AL			; advance to next number
	CMP AL,21		; ensure number is not > 32
	JZ loopend		; if true exit loop
	JMP loop		; else continue

prime:
	MOV [CL],AL		; move prime number into memory
	INC CL			; advance to next location
	INC AL			; advance to next number
	CMP AL,21		; ensure number is not > 32
	JZ loopend		; if true exit loop
	JMP loop		; else continue

loopend:
	END
