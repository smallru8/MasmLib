TITLE      (.asm)

INCLUDE Irvine32.inc
INCLUDE Macros.inc

.data

.code
main PROC
L1:
	mWrite "First number : "
	call ReadInt
	mov ebx,eax
	mWrite "Second number : "
	call ReadInt
	mWrite "GCD result : "
	call GCD
	call WriteDec
	call crlf
	call crlf
	jmp L1
	exit
main ENDP

;
;GCD
;eax = x
;ebx = y
;
;ret 
;eax = result
;ebx = 0
;

GCD PROC
	LOCAL x:DWORD
	push edx
	cmp eax,0
	je RE
	jg xabs
	neg eax
xabs:
	cmp ebx,0
	je RE
	jg yabs
	neg ebx
yabs:
	mov x,eax

L1:
	mov edx,0
	mov eax,x
	div ebx
	mov x,ebx
	mov ebx,edx
	cmp ebx,0
	jg L1

	mov eax,x
RE:
	pop edx
	ret
GCD ENDP

END main