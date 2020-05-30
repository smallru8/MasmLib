TITLE      (.asm)
INCLUDE Irvine32.inc
INCLUDE Macros.inc

.data

.code
main PROC
	mWrite "Input n : "
	call ReadDec
	call WriteDec
	mWrite "! = "
	mov ecx,eax
	mov edx,0
	mov eax,1
	.IF ecx == 0
		jmp DONE
	.ENDIF
L1:
	mul ecx
	jo L1overflow
	loop L1
	jmp DONE
L1overflow:
	mWrite "Overflow"
	call crlf
DONE:
	call WriteDec
	call crlf
	exit
main ENDP

END main