INCLUDE Irvine32.inc
;----------------------------------------------------
;	FILE:			PA03.asm
;
;	AUTHOR:			Keith Ecker
;
;	DESCRIPTION:	Sums the gaps between array values
;
;	DATE:			11/7/16
;
;	COMMENT:		None
;----------------------------------------------------

ExitProcess proto,dwExitCode:dword

;----------------------------------------------------
;	DATA SEGMENT
;----------------------------------------------------

.data

	array DWORD 0, 2, 5, 9, 10				; Array to sum gaps

	sum DWORD 0								; Sum=0

;----------------------------------------------------
;	CODE SEGMENT
;----------------------------------------------------

.code

;----------------------------------------------------
;	MAIN PROCEDURE
;		This procedure uses a loop to subtract the nth element
;		from the nth + 1 element and then adds the difference 
;		to the sum.
;----------------------------------------------------

main proc

	mov eax, 0

	mov esi, offset array
	
	mov ecx, lengthof array-1				; loop counter is 1 less than length
	
	L1:
			add eax, [esi+4]

			sub eax, [esi]

			add esi, type array				; moves index to next value
			
			add sum, eax
	loop L1

	call WriteInt							; writes the sum of the gaps
	
	;--- Exit Program ---
	
	invoke ExitProcess,0
main endp


end main