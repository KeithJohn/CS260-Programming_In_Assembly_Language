INCLUDE Irvine32.inc
;----------------------------------------------------
;	FILE:			PA05.asm
;
;	AUTHOR:			Keith Ecker
;
;	DESCRIPTION:	Boolean Calculator for 32-bit integers
;
;	DATE:			11/19/16
;
;	COMMENT:		None
;----------------------------------------------------

ExitProcess proto,dwExitCode:dword

;----------------------------------------------------
;	DATA SEGMENT
;----------------------------------------------------

.data
	hexNumPrompt1 BYTE "Enter a hexadecimal integer ",0
	hexNumPrompt2 BYTE "Enter two hexadecimal integers ",0
	menuPrompt BYTE "Please enter a number to select a menu option:",13,10
		   BYTE "1. x AND y",13,10
		   BYTE "2. x OR y",13,10
		   BYTE "3. NOT x",13,10
		   BYTE "4. x XOR y",13,10
		   BYTE "5. Exit Program",13,10,0
	exitPrompt BYTE "Exiting program",0
	incorrectInputPrompt BYTE "Incorrect input please try again.",0
	AND_opPrompt BYTE " AND ",0
	OR_opPrompt BYTE " OR ",0
	NOT_opPrompt BYTE " NOT ",0
	XOR_opPrompt BYTE " XOR ",0
	EqualsPrompt BYTE " = ",0
	

;----------------------------------------------------
;	CODE SEGMENT
;----------------------------------------------------

.code

;----------------------------------------------------
;	MAIN PROCEDURE
;
;		Takes user input and calculates one of multiple boolean instructions and prints the result
;
;----------------------------------------------------

main proc
	
	Beginning:
		
		call Crlf
		
		call displayMenu								;Displays menu
		
		mov ebx, 1										;Gets 1 hex int from user
		call getUserInput
		
		cmp eax,1										;If Input=1
		JE input1
		
		cmp eax,2										;If Input=2
		JE input2
		
		cmp eax,3										;If Input=3
		JE input3
		
		cmp eax,4										;If Input=4
		JE input4
		
		cmp eax,5										;If Input=5
		JE input5
		
		call Clrscr										;If Input is not 1-5 tell user to enter another number and jump
		mov edx, OFFSET incorrectInputPrompt			;back to beginning
		call WriteString

	jmp Beginning										
		
		Input1:											;If Input=1 
			call AND_op
		jmp Beginning
		
		Input2:											;If Input=2
			call OR_op
		jmp Beginning
		
		Input3:											;If Input=3
			call NOT_op
		jmp Beginning
		
		Input4:											;If Input=4
			call XOR_op
		jmp Beginning
		
		Input5:											;If Input=5
			call EXIT_op
main endp

;-----------------------------------------------------
;	DISPLAY MENU PROCEDURE
;		Displays menu for boolean calculator
;
;		Receives: None 
;	
;		Returns: None
;
;		Requires: menuPrpmpt is a byte that contains the menu string that is to be printed 
;	
;-----------------------------------------------------
displayMenu proc

	mov edx, OFFSET menuPrompt							;Writes menuPrompt
	call WriteString
	
	ret													;Return

displayMenu endp

;-----------------------------------------------------
;	AND OP PROCEDURE
;
;		Gets two hex integers from user, ANDs them, and then prints the result as 'input1 AND input2 = end value' 
;
;		Receives: None
;
;		Returns: EAX = input1 AND input2, EBX= input2, ECX = input1
;
;		Requires: AND_opPrompt is a byte string that contains'AND', EqualsPrompt is a byte string that contains '='
;
;-----------------------------------------------------
AND_op proc
	
	call Clrscr											;Clears screen
	
	mov ebx, 2											;Gets two hex integers from user stored in eax, ebx
	call getUserInput	
	
	mov ecx, eax										;ECX = input1
	
	AND eax, ebx										;EAX= input1 AND input2
		
	mov edx, eax										;Uses EDX to store End value while EAX is used for WriteHex
	
	call Clrscr

	mov eax, ecx										;Writes input1
	call WriteHex
	
	mov eax, edx

	mov edx, OFFSET AND_opPrompt						;Writes 'AND'
	call WriteString
	
	mov edx, eax

	mov eax, ebx										;Writes input2
	call WriteHex
	
	mov eax, edx

	mov edx, OFFSET EqualsPrompt						;Writes '='
	call WriteString
	
	call WriteHex										;Writes input1 AND input2
	
	ret													;Return
	
AND_op endp

;-----------------------------------------------------
;	OR OP PROCEDURE
;
;		Gets two hex integers from user, ORs them, and then prints the result as 'input1 OR input2 = end value'	
;
;		Receives: None
;
;		Returns: EAX = input1 AND input2, EBX= input2, ECX = input1
;
;		Requires: OR_opPrompt is a byte string that contains 'OR', EqualsPrompt is a byte string that contains '='
;	
;-----------------------------------------------------
OR_op proc
	
	call Clrscr											;Clears screen
	
	mov ebx, 2											;Gets 2 hex integers from user and stored in eax, ebx
	call getUserInput
	
	mov ecx,eax											;ECX = input1
	
	OR eax, ebx											;EAX = input1 OR input2
	
	mov edx, eax										;Uses EDX to store End value while EAX is used for WriteHex
	
	call Clrscr
	
	mov eax, ecx										;Writes input1									
	call WriteHex
	
	mov eax, edx

	mov edx, OFFSET OR_opPrompt							;Writes 'OR'
	call WriteString
		
	mov edx,eax

	mov eax, ebx										;Writes input2
	call WriteHex
	
	mov eax,edx
	
	mov edx, OFFSET EqualsPrompt						;Writes '='
	call WriteString
	
	call WriteHex										;Writes input1 OR input2
	
	ret													;Return

OR_op endp
;-----------------------------------------------------
;	NOT OP PROCEDURE
;
;	Gets a hex integer from user, Nots it, and then prints the result as 'NOT input1 = end value'
;
;	Receives: None
;
;	Returns: EAX = NOT input1, EBX= input1
;
;	Requires: NOT_opPrompt is a byte string that contains 'NOT', EqualsPrompt is a byte string that contains '='
;
;-----------------------------------------------------
NOT_op proc
	
	call Clrscr											;Clears screen
	
	mov ebx, 1											;Gets 1 hex integer from user and stored in ebx
	call getUserInput
	
	mov ebx, eax										;EBX = input1

	NOT eax												;EAX = NOT input1
	
	mov ecx, eax										;Uses ECX to store end value while eax is used for WriteHex
	
	call Clrscr	
	
	mov edx, OFFSET NOT_opPrompt						;Writes 'NOT'
	call WriteString
	
	mov eax, ebx										;Writes input1									
	call WriteHex
	
	mov edx, OFFSET EqualsPrompt						;Writes '='
	call WriteString
	
	mov eax, ecx										;Writes NOT input1
	call WriteHex	
	
	ret													;Return

NOT_op endp
;-----------------------------------------------------
;	XOR OP PROCEDURE
;
;	Gets two hex integers from user, XORs them, and then prints the result as 'input1 XOR input2 = end value'
;	
;	Recieves: None
;
;	Returns: EAX = input1 AND input2, EBX= input2, ECX = input1
;
;	Requires: XOR_opPrompt is a byte string that contains 'XOR', EqualsPrompt is a byte string that contains '='
;
;-----------------------------------------------------
XOR_op proc
	
	call Clrscr											;Clears screen
	
	mov ebx, 2											;Gets 2 hex integers from user and stores in EAX, EBX
	call getUserInput
	
	mov ecx, eax										;ECX = input1
	
	XOR eax, ebx										;EAX = input1 XOR input2
	
	mov edx, eax										;Uses EDX to store End value while EAX is used for WriteHex
	
	call Clrscr
	
	mov eax, ecx										;Writes input1
	call WriteHex
	
	mov eax, edx

	mov edx, OFFSET XOR_opPrompt						;Writes 'XOR'
	call WriteString
	
	mov edx, eax
	
	mov eax, ebx										;Writes input2
	call WriteHex
	
	mov eax, edx

	mov edx, OFFSET EqualsPrompt						;Writes '='
	call WriteString
										
	call WriteHex										;Writes input1 XOR input2
	
	ret													;Return

XOR_op endp

;-----------------------------------------------------
;	EXIT OP PROCEDURE
;
;	Prints a prompt then exits program
;
;	Receives: None
;
;	Returns: None
;
;	Requires: exitPrompt is a byte string that contains the message to be printed before exiting program
;
;-----------------------------------------------------
EXIT_op proc

	call Clrscr											;Clears screen
	
	mov edx, OFFSET exitPrompt							;Writes Exit Prompt
	call WriteString
	
	call Crlf

	;--- Exit Program ---
	invoke ExitProcess,0								;Exits program

EXIT_op endp

;-----------------------------------------------------
;	GET USER INPUT PROCEDURE
;
;	Gets 2 or 1 hex integers from user then stores them in eax, ebx
;
;	Recives: EBX for number of inputs, if EBX = 1 get 1 input otherwise get 2 inputs
;
;	Returns: EAX = input1, EBX = input2, ECX = input1
;
;	Requires: hexNumPrompt2 is a byte string that contains the message to be printed before user inputs 2 hex integers
;			  hexNumPrompt1 is a byte string that contains the message to be printed before user inputs 1 hex integer
;
;-----------------------------------------------------
getUserInput proc
	
	cmp ebx,1											;If EBX = 1	
	JE oneInput
	
		;--- If EBX != 1 ---

		mov edx, OFFSET hexNumPrompt2					;Writes Prompt for user to enter two hex integers
		call WriteString

		call ReadHex									;Reads hex integer from user
		
		mov ecx, eax									;Stores input1 in ECX while EAX is used for ReadHex
		
		call ReadHex

		mov ebx, eax									;EBX = input2
		
		mov eax, ecx									;EAX = input1
		
		ret												;Return
	
		;--- If EBX = 1 ---
	
	oneInput:											

		mov edx, OFFSET hexNumPrompt1					;Writes prompt for user to enter one hex integer
		call WriteString

		call ReadHex									;EAX = input1
	
		ret												;Return

getUserInput endp

end main