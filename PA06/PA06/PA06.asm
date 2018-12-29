INCLUDE Irvine32.inc
;----------------------------------------------------
;	FILE:			PA06.asm
;
;	AUTHOR:			Keith Ecker
;
;	DESCRIPTION:	Enter description here
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
	stringPrompt BYTE " Enter a String: "
	charPrompt BYTE " Enter a character that is to be removed from the string: "

;----------------------------------------------------
;	CODE SEGMENT
;----------------------------------------------------

.code

;----------------------------------------------------
;	MAIN PROCEDURE
;		Takes a Byte array of 4 hex numbers and reverses
;		the order of the numbers.
;----------------------------------------------------

main proc
	
	
	mov edx, OFFSET stringPrompt
	call WriteString

	mov ecx, 50
	call ReadString

	call WriteString
	;--- Exit Program ---
	
	invoke ExitProcess,0
main endp

;-----------------------------------------------------
;	NEXT PROCEDURE- if applicable
;-----------------------------------------------------

end main