INCLUDE Irvine32.inc
;----------------------------------------------------
;	FILE:			PA08.asm
;
;	AUTHOR:			Keith Ecker
;
;	DESCRIPTION:	Checks the digits of a PIN number and compares the digit with the minimum and maximum
;					value that is allowed for that digit.  
;
;	DATE:			12/10/16
;
;	COMMENT:		None
;----------------------------------------------------

ExitProcess proto,dwExitCode:dword

;----------------------------------------------------
;	DATA SEGMENT
;----------------------------------------------------

.data
	minValues BYTE 5, 2, 4, 1, 3
	maxValues BYTE 9, 5, 8, 4, 6
	testPIN1 BYTE 4, 6, 3, 5, 1
	invalidMsg BYTE "PIN is invalid. ",0
	validMsg BYTE "PIN is valid. ",0
	invalidDigitMsg BYTE "Digit ",0 
	invalidDigitMsg2 BYTE " is invalid",0
	space BYTE " ",0

;----------------------------------------------------
;	CODE SEGMENT
;----------------------------------------------------

.code

;----------------------------------------------------
;	MAIN PROCEDURE
;	
;	Description: Prints the PIN and then checks if it is valid 
;	and then prints the result and the first digit that is invalid if there is one.	
;
;----------------------------------------------------

main proc
	
	mov esi, OFFSET testPIN1													;Prints Pin
	mov edx, OFFSET space														
	call Print_PIN																

	mov esi, OFFSET testPIN1													;Checks if Pin is valid
	mov edi, OFFSET minValues
	mov ebp, OFFSET maxValues
	call Validate_PIN
	
	cmp eax, 0																	;If EAX=0 then Pin is valid
	je Valid
									
																				;Else Pin is invalid
	mov edx, OFFSET invalidMsg													;Writes Invalid Msg
	call WriteString
	call Crlf

	mov edx, OFFSET invalidDigitMsg												;Writes the index of invalid digit
	call WriteString

	call WriteDec
	
	mov edx, OFFSET invalidDigitMsg2
	call WriteString
	call Crlf

	jmp NotValid																;Jumps over valid msg

	Valid:																		;Writes valid msg if Pin is valid
	mov edx, OFFSET validMsg
	call WriteString
	call Crlf
	
	NotValid:

	;--- Exit Program ---
	
	invoke ExitProcess,0
main endp

;-----------------------------------------------------
;	Validate Pin Proc
;
;	Description: Compares each digit of a PIN number and compares it to the min and max values allowed for each digit
;				 and returns the index and value of the first invalid digit. 
;
;	Recieves: ESI points to the Pin Array, EDI points to the min value array, EBP points to max value array.
;
;	Returns: EAX = index of first invalid digit or 0 if valid, BL = value of invalid digit or 0 if valid.
;
;	Requires: Pin is 5 digits.
;
;-----------------------------------------------------
Validate_PIN proc
	
	mov ecx, 5
	mov eax, 1																	;EAX holds the index being checked

	PinLoop:																	;for(i=0;i<5;i++)
		
		mov bl, [esi]
		cmp bl, [edi]															;if digit < minValue 
		jb Invalid																;Pin is invalid
		
		cmp bl, [ebp]															;if digit > maxValue 
		ja Invalid																;Pin is invalid
		
		add esi, 1																;else check next digit
		add edi, 1
		add ebp, 1
		inc eax																	
		
		loop PinLoop
		
		mov eax, 0																;if no digit is invalid
		mov bl, 0																;Pin is valid
		ret
		
		Invalid:
		ret

Validate_PIN endp
;-----------------------------------------------------
;	Print PIN Proc
;	
;	Description: Prints the Pin Number
;
;	Recieves: ESI points to the Pin Array, EDX points to a space string i.e " "
;
;	Returns: None
;
;	Requires: Pin Number is 5 digits
;
;-----------------------------------------------------
Print_PIN proc

	mov eax, 0																	;Clear EAX
	mov ecx, 5																	

	PrintPinLoop:																;for (i=0;i<5;i++)

		mov al, [esi]															;Writes digit at index i
		call WriteDec
		call WriteString
	
		add esi, 1																;Next digit
	
	loop PrintPinLoop

	call Crlf																	;New Line

	ret

Print_PIN endp

end main