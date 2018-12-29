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
	String BYTE 50 DUP (0)
	userChar BYTE ?
	numOfLetters DWORD ?
	stringPrompt BYTE " Enter a String: ",0
	charPrompt BYTE " Enter a character that is to be removed from the string: ",0
	endPrompt BYTE " The new string is: "
	randBack DWORD ?
	randFore DWORD ?
;----------------------------------------------------
;	CODE SEGMENT
;----------------------------------------------------

.code

;----------------------------------------------------
;	MAIN PROCEDURE
;
;		Desription: Takes a string and char from user and removes 
;		all instances of the char in the string
;
;----------------------------------------------------

main proc

	Begin:

	mov edx, OFFSET stringPrompt									;Writes prompt for user to enter string
	call WriteString
	
	mov edx, OFFSET string											;Reads a string from the user
	mov ecx, SIZEOF string
	call ReadString

	mov numOfLetters,eax											;Saves the number of letters entered by the user
	call Crlf

	push edx														;pushes the string

	mov edx, OFFSET charPrompt										;Writes prompt for user to enter a char
	call WriteString

	Call ReadChar													;Reads and saves char entered by user
	mov userChar, al
	

	mov ecx, numOfLetters
	call compressString												;Removes char and compresses string
	
	
	call Crlf

	mov edx, OFFSET endPrompt										;Writes prompt telling the user what the final string is
	call WriteString

	mov edx, OFFSET string											;Writes final string
	call WriteString
	call Crlf

	jmp Begin

	;--- Exit Program ---
	
	invoke ExitProcess,0
main endp

;-----------------------------------------------------
;	compressString Proc
;
;		Description: Receives a string and char and removes all instances of char from string
;					 and compresses the string back to normal
;
;		Receives: ECX = number of letters in string, EDX = points to string
;
;		Returns:	EDX = points to new string
;
;		Requires:none
;
;-----------------------------------------------------

compressString proc

mov eax, 0
L1:
	movzx edx, string[ecx]											;compare each letter with char
	cmp dl, userChar
	jz EqualsChar
	push edx														;if its not equal to char then push letter 
	inc eax															;else skip to L2

EqualsChar:																	
	mov string[ecx],0												
	loop L1

	movzx edx, string[ecx]
	cmp dl, userChar
	jz L3
	push edx
	inc edx

L3:
	mov ecx, eax
	mov eax, 0

L4:		
	pop edx															;pop edx until eax =0
	mov byte ptr string[eax],dl
	inc eax
	loop L4

	ret

compressString endp

;-----------------------------------------------------
;	changeColor Proc
;	
;		Description: Changes the background and foreground color 5 times
;
;		Receives: none
;	
;		Returns: none
;
;		Requires: none
;
;-----------------------------------------------------
changeColor proc

	mov ecx, 5
	call Randomize
	L1:
	call Random32
	call SetTextColor
	loop L1
	ret
	


changeColor endp

end main