INCLUDE Irvine32.inc
;----------------------------------------------------
;	FILE:			PA09.asm
;
;	AUTHOR:			Keith Ecker
;
;	DESCRIPTION:	Getst the absolute values of two numbers then finds the GCD of the numbers.
;
;	DATE:			12/21/16
;
;	COMMENT:		None
;----------------------------------------------------

ExitProcess proto,dwExitCode:dword

;----------------------------------------------------
;	DATA SEGMENT
;----------------------------------------------------

.data
	

;----------------------------------------------------
;	CODE SEGMENT
;----------------------------------------------------

.code

;----------------------------------------------------
;	MAIN PROCEDURE
;
;	Finds the GCD of 10 test cases with at least 3 prime numbers
;	
;----------------------------------------------------

main proc

;---test case 1---
mov eax, 20
mov ebx, 4
call ABS
call GCD
call WriteDec
Call Crlf

;---test case 2---
mov eax,25
mov ebx, -5
call ABS
call GCD
call WriteDec
Call Crlf

;---test case 3---
mov eax,60
mov ebx, 12
call ABS
call GCD
call WriteDec
Call Crlf

;---test case 4---
mov eax, -48
mov ebx, -56
call ABS
call GCD
call WriteDec
Call Crlf

;---test case 5---
mov eax,-9
mov ebx, 3
call ABS
call GCD
call WriteDec
Call Crlf

;---test case 6---
mov eax,35
mov ebx, 15
call ABS
call GCD
call WriteDec
Call Crlf

;---test case 7---
mov eax,46
mov ebx, 6
call ABS
call GCD
call WriteDec
Call Crlf

;---test case 8---
mov eax,52
mov ebx, -23
call ABS
call GCD
call WriteDec
Call Crlf

;---test case 9---
mov eax, -31
mov ebx, -19
call ABS
call GCD
call WriteDec
Call Crlf

;---test case 10---
mov eax,61
mov ebx, 9
call ABS
call GCD
call WriteDec
Call Crlf

	
	;--- Exit Program ---
	
	invoke ExitProcess,0
main endp

;-----------------------------------------------------
;	GCD Proc
;
;	Description: Uses the div instruction to simulate the Modulo instruction and returns the GCD of EAX and EBX
;
;	Recieves: EAX, EBX
;
;	Returns: EAX = GCD of EAX and EBX
;
;	Requires: None
;
;-----------------------------------------------------
GCD proc

	DoWhile:										;Do While EBX != 0
	
	mov edx, 0										;Clear remainder
	
	div ebx											;EDX = remainder
	
	mov eax, ebx									;EAX = last divisor
	
	mov ebx, edx									;EBX = remainder
	
	cmp ebx, 0										;If remainder is 0 then return 
	jne DoWhile

	ret

GCD endp

;-----------------------------------------------------
;	ABS Proc
;
;	Description: Finds and returns the absolute value of two numbers
;
;	Recieves: EAX, EBX
;
;	Returns: EAX = absolute value of EAX, EBX = absolute value of EBX
;
;	Requires: None
;
;-----------------------------------------------------
ABS proc

	push eax										;Absolute Value of EBX
	mov eax, ebx
	cdq
	xor eax, edx
	sub eax, edx
	mov ebx, eax

	pop eax											;Absolute value of EAX
	cdq
	xor eax, edx
	sub eax, edx
	
	ret

ABS endp
end main