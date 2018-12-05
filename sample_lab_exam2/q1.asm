; Using the timer interrupt, fill the VDU from the top-left to the bottom-right alternatively with zeros
; (ASCII code 0x30) and ones (ASCII code 0x31)...i.e filling the VDU with 01010101...etc. The VDU
; should be filled at the rate of one character per second.The program should stop when the last slot on the
; VDU (FF) has been filled with a character. Hint: You may want a main program with an infinite loop that
; does nothing. You will also need a Timer ISR.
	
	JMP initialise
	DB 50					; Interrupt at address 50

initialise:
	STI						; Enable hardware interrupts
	MOV BL, C0				; Set BL to start at position C0
	MOV CL, C1				; Set CL to start at position C1

mainCode:
	JMP mainCode			; Infinite loop

	ORG 50
	PUSHF					; Save flags
	CMP CL, 00				; Check if CL < 00
	JNS end					; If false end program
	CMP AL, 30				; Check if last displayed character on VDU is '0'
	JZ one					; If true jump to 'one' loop
	JS zero					; Else jump to 'zero' loop

zero:
	MOV AL, 30				; Move ASCII code for 0 into AL
	MOV [BL], AL			; Display on VDU
	ADD BL, 02				; Increment BL by 2
	POPF					; Restore flags
	IRET

one:
	MOV AL, 31				; Move ASCII code for 1 into AL
	MOV [CL], Al			; Display on VDU
	ADD CL, 02				; Increment CL by 2
	POPF					; Restore flags
	IRET

end:
	END