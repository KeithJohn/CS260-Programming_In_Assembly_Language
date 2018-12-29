INCLUDE Irvine32.inc
; PA01.asm - takes a string from uppercase and changes it to lowercase and back again.
;----------------------------------------------------------
;
;----------------------------------------------------------

ExitProcess PROTO, dwExitCode:dword

;----------------------------------------------------------
;
;----------------------------------------------------------

.data


;---------------------------------------------------------
;
;---------------------------------------------------------

.code
main proc
call WriteString
	invoke ExitProcess,0

main endp
end main