INCLUDE Irvine32.inc
;----------------------------------------------------
;	FILE:			PA04.asm
;
;	AUTHOR:			Keith Ecker
;
;	DESCRIPTION:	A program that reads two integers from the user
;					and prints the sum of the numbers in decimal
;					hex and binary
;
;	DATE:			11/10/16
;
;	COMMENT:		I did not know how to get rid of leading zeros
;					while using the irvine library
;----------------------------------------------------

ExitProcess proto,dwExitCode:dword

;----------------------------------------------------
;	DATA SEGMENT
;----------------------------------------------------

.data

	Sum DWORD ?
	DecimalString BYTE "     Decimal",0
	HexString BYTE "     Hexadecimal",0
	BinaryString BYTE "     Binary",0
	Spaces BYTE "     ",0
	SumString BYTE "Sum:     ",0
	GoodbyePrompt BYTE "Goodbye :)"

;----------------------------------------------------
;	CODE SEGMENT
;----------------------------------------------------

.code

;----------------------------------------------------
;	MAIN PROCEDURE
;
;		Description: Takes a Byte array of 4 hex numbers and reverses
;					 the order of the numbers.
;
;----------------------------------------------------

main proc

	mov ecx, 3
	L1:
		call GetIntegerFromUser
 
		 mov sum,eax
		push ecx
 
		call DisplayNumber
		pop ecx
	loop L1

	mov edx, OFFSET GoodbyePrompt					; Writes Goodbye to user
	call WriteString
	call Crlf

	;--- Exit Program ---
	
	invoke ExitProcess,0
main endp

;-----------------------------------------------------
;	GetIntegerFromUser
;
;		Receives: nothing
;
;		Returns: EAX is equal to the sum of two integers that the user enters
;
;		Requires: nothing
;
;-----------------------------------------------------

GetIntegerFromUser proc
		
		call ReadInt					
		mov ebx, eax
		call ReadInt
		add eax, ebx
	
	ret

GetIntegerFromUser endp

;-----------------------------------------------------
;	DisplayNumber
;
;		Description: Writes the value of eax in decimal hex and binary
;		
;		Receives: EAX for the value to be printed in decimal hex and binary
;	
;		Returns: none
;
;		Requires: EAX must be an integer
;
;-----------------------------------------------------

DisplayNumber proc

	mov ebx, '='								; Sets the char for DisplayEqualSigns

	mov eax, black+(yellow*16)					; Changes background color to yellow
	call SetTextColor							; and text color to black

	mov edx, OFFSET DecimalString				; Writes "     Decimal"
	call WriteString
	call Crlf
	
	mov ecx, SIZEOF DecimalString-6				; Puts '=' underneath the characters in the line above it
	call DisplayEqualSigns
	call Crlf
	
	mov eax, blue+(yellow*16)					; Changes text color to blue
	call SetTextColor
	
	mov edx, OFFSET SumString					
	call WriteString
	
	mov eax, sum								; Writes the sum in decimal
	call WriteInt
	call Crlf

	mov eax, black+(yellow*16)					; Sets text color to black
	call SetTextColor 

	mov edx, OFFSET HexString					
	call WriteString
	call Crlf

	mov ecx, SIZEOF HexString-6					
	call DisplayEqualSigns
	call Crlf

	mov edx, OFFSET Spaces						; Adds spaces to align lign
	call WriteString

	mov eax, green+(yellow*16)					
	call SetTextColor

	mov eax, sum								; Writes the sum in hex
	call WriteHex
	call Crlf

	mov eax, black+(yellow*16)					
	call SetTextColor
	
	mov edx, OFFSET BinaryString				
	call WriteString
	call Crlf

	mov ecx, SIZEOF BinaryString-6				
	call DisplayEqualSigns
	call Crlf
	
	mov eax, red+(yellow*16)					
	call SetTextColor
	
	mov edx, OFFSET Spaces
	call WriteString

	mov eax, sum								; Writes sum in binary
	call WriteBin
	call Crlf

	mov eax, white+(black*16)
	call SetTextColor

	ret

DisplayNumber endp

;-----------------------------------------------------
;	DisplayEqualSigns
;
;		Receives:EBX for the character that is printed
;				 and ECX for counter for writing loop
;
;		Returns: nothing
;
;		Requires: nothing
;
;-----------------------------------------------------

DisplayEqualSigns proc

	mov edx, OFFSET Spaces						; Adds spaces to align lign
	call WriteString
						
	mov eax, ebx								; Moves char to AL

	L1:											; Prints char until ECX is zero
		call WriteChar
	loop L1 

	ret

DisplayEqualSigns endp

end main