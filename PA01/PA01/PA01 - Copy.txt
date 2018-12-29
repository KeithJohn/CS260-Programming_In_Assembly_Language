; PA01.asm - takes a string from uppercase and changes it to lowercase and back again.


.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:dword
INCLUDE Irvine32.inc
.data
startUppercaseString BYTE "HELLO",0
lowercaseString BYTE SIZEOF startUppercaseString DUP(0)
uppercaseString BYTE SIZEOF lowercaseString DUP(0)

.code
main proc
mov al, startUppercaseString[0]
add al,20h
mov lowercaseString, al

mov al, startUppercaseString[1]
add al,20h
mov lowercaseString, al

mov al, startUppercaseString[2]
add al,20h
mov lowercaseString, al

mov al, startUppercaseString[3]
add al,20h
mov lowercaseString, al

mov al, startUppercaseString[4]
add al,20h
mov lowercaseString, al

mov edx, OFFSET lowercaseString
call WriteString
	
	mov al, lowercaseString[0]
sub al,20h
mov uppercaseString, al

mov al,  lowercaseString[1]
sub al,20h
mov uppercaseString, al

mov al,  lowercaseString[2]
sub al,20h
mov uppercaseString, al

mov al,  lowercaseString[3]
sub al,20h
mov uppercaseString, al

mov al,  lowercaseString[4]
sub al,20h
mov uppercaseString, al

mov edx, OFFSET uppercaseString
call WriteString
	invoke ExitProcess,0
main endp
end main