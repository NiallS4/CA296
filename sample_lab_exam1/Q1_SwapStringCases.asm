; Write a program to display a string (any string) with uppercase and lowercase letters on the
; VDU - you should do this using a combination of ORG/DB assembler directives. When your
; program starts up, it should convert all lowercase letters on the VDU to uppercase and all
; uppercase letters to lowercase (for example "HeLlO wOrLd" would be converted to "hElLo WoRlD".

	ORG C0 				; start putting code at C0
	DB 41
	DB 4C
	DB 61
	DB 42
	DB 41
	DB 6D
	DB 61				; String reads "ALaBAma"
	DB 00				; add 00 to mark end of string

	ORG 00 				; start putting code at 00
	MOV AL, C0 			; move C0 into AL

loop:
	MOV BL, [AL]			; move letter in AL (i.e. C0, C1, C2...) into BL
	CMP BL, 00 			; check if BL == 00
	JZ loopend 			; if true exit loop

	MOV CL, [AL]			; move letter into CL
	SUB BL, 5B			; subtract 5B ("["), first letter after Z  to check sign flag is set
	JS uppercase			; if sign flag is set jump to 'uppercase'
	JMP lowercase			; else jump to 'lowercase'

uppercase:
	ADD CL,20			; add 20 to hex value to convert uppercase to lowercase
	MOV [AL],CL			; move value to VDU
	INC AL				; advance to next position in VDU
	JMP loop			; jump back to main loop
lowercase:
	SUB CL,20			; subtract 20 from hex value to convert lowercase to uppercase
	MOV [AL],CL			; move value to VDU
	INC AL				; advance to next position in VDU
	JMP loop			; jump back to main loop
loopend:
	END