INCLUDE Irvine32.inc
;----------------------------------------------------
;	FILE:			PA02.asm
;
;	AUTHOR:			Keith Ecker
;
;	DESCRIPTION:	Reverses the order of a Byte array 
;					from Big endian order to little 
;					and saves it to a variable
;
;	DATE:			11/2/16
;
;	COMMENT:		None
;----------------------------------------------------

ExitProcess proto,dwExitCode:dword

;----------------------------------------------------
;	DATA SEGMENT
;----------------------------------------------------

.data

	bigEndian BYTE 12h, 34h, 56h, 78h		;	Original Byte array
	littleEndian DWORD ?					;	destination variable

;----------------------------------------------------
;	CODE SEGMENT
;----------------------------------------------------

.code

;----------------------------------------------------
;	MAIN PROCEDURE
;
;		Takes a Byte array of 4 hex numbers and reverses
;		the order of the numbers and saves it to the 
;		littleEndian variable
;----------------------------------------------------

main proc

	mov al, bigEndian+0						
	mov ah, bigEndian+1
	mov bl, bigEndian+2
	mov bh, bigEndian+3

	mov BYTE PTR littleEndian[0], bh  
	mov BYTE PTR littleEndian[1], bl
	mov BYTE PTR littleEndian[2], ah
	mov BYTE PTR littleEndian[3], al

	mov eax, littleEndian
	call WriteHex

	;--- Exit Program ---
	
	invoke ExitProcess,0
main endp

end main