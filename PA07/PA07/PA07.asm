INCLUDE Irvine32.inc
;----------------------------------------------------
;	FILE:			PA07.asm
;
;	AUTHOR:			Keith Ecker
;
;	DESCRIPTION:	Fills a DWORD array with a random number(10-50) of integers between the numbers 0-1000
;					then sorts the array and prints it
;
;	DATE:			12/5/16
;
;	COMMENT:		None
;----------------------------------------------------

ExitProcess proto,dwExitCode:dword

;----------------------------------------------------
;	DATA SEGMENT
;----------------------------------------------------

.data
	array DWORD 50 DUP(0)
	space BYTE " ",0
	numOfInputs DWORD ?
;----------------------------------------------------
;	CODE SEGMENT
;----------------------------------------------------

.code

;----------------------------------------------------
;	MAIN PROCEDURE
;		Fills a DWORD array with a random number(10-50) of integers between the numbers 0-1000
;		then sorts the array and prints it
;
;----------------------------------------------------

main proc

	call Randomize											
	
	mov eax, 40													;Generates a random number up to 40
	call RandomRange											
	
	add eax, 10													;Changes the number so its between 10-50
	
	mov numOfInputs, eax										;saves number of inputs

	mov ecx, numOfInputs										;Fills array with random numbers
	mov esi, OFFSET array
	call fillArray

	mov esi, OFFSET array
	mov ecx, numOfInputs
	call printArray												;Prints Array

	mov esi, OFFSET array										;Sorts Array
	mov ecx, numOfInputs
	call sortArray

	call Crlf

	mov esi, OFFSET array
	mov ecx, numOfInputs
	call printArray												;Prints Array
	
	;--- Exit Program ---
	
	invoke ExitProcess,0
main endp

;-----------------------------------------------------
;	Print Array proc
;
;	Description: Prints an array with 10 numbers printed per line
;
;	Recieves: esi points to array, ECX = number of inputs
;
;	Returns:none
;
;	Requires:none
;
;-----------------------------------------------------
printArray proc

	mov edx, 0													;EDX keeps track of number of numbers printed on line
	
	printLoop:
	
		mov eax, [esi]											;Prints the nymber esi points to
		call WriteDec
	
		push edx												;Writes a space
		mov edx, OFFSET space
		call WriteString
		pop edx
	
		add esi, TYPE array										;Points esi to next number
	
		inc edx
	
		cmp edx, 10												;Checks to see if there are 10 numbers on the line
		jne lessThenTen	
		mov edx,0
		call Crlf												;If yes make a new line
	
		lessThenTen:											;If no then jump
	
		loop printLoop											;Loop until all are printed			
	
	call Crlf
	
	ret

printArray endp
;-----------------------------------------------------
;	Sort Array proc
;
;	Description: Uses selection sort to sort an array of DWORD integers
;
;	Receives: esi points to the beginning of the array. ECX&EBX= number of inputs
;
;	Returns: Sorted array
;
;	Requires:none
;
;-----------------------------------------------------

sortArray proc

mov edx, ecx													;EDX holds number of inputs						
mov eax, 0														;EAX = outer loop counter

OuterLoop:														;for(i=0;i<arraySize;i++)

	mov edi, esi												;edi points to the number after esi
	add edi, 4
	
	 mov ebx, eax												;ebx=innerloop counter
	 inc ebx
	 push ecx
	 mov ecx, edx

	 InnerLoop:													;for(j=i+1;j<arraySize;j++)
	
		cmp ebx, edx											;if j>arraySize
		jge EndInnerLoop										;end Loop
		
		push edx												
		mov edx, [edi]											;if array[j]<array[i] 
		cmp edx, [esi]											; switch values
	
		 jge NoSwitch											
	
		xchg edx, [esi]											;switches the values of esi and edi
		mov [edi], edx
	
		NoSwitch:

		pop edx
		add edi, 4												;edi points to next number
	
		inc ebx													;j++
	
		loop InnerLoop
	
		EndInnerLoop:
	
	inc eax														;i++
	
	add esi, 4													;esi points at next number
	pop ecx
 
  loop OuterLoop

  Done:

  ret
sortArray endp

;-----------------------------------------------------
;	Fill Array proc
;
;	Description: Fills an array with random integers from 1-1000
;
;	Receives: ECX = number of inputs, esi points to an array
;
;	Returns: Filled array with random numbers from 1-1000
;
;	Requires:none
;
;-----------------------------------------------------
fillArray proc

fillLoop:
	mov eax, 1000												;sets the range for the random numbers to 1000
	
	call RandomRange											;generates random number
	
	mov [esi], eax												;fills array with the random number
	
	add esi, 4													;esi points to next spot in the array
	loop fillLoop

	ret

fillArray endp

end main