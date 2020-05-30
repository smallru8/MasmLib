TITLE      (.asm)
INCLUDE Irvine32.inc
INCLUDE Macros.inc

.data

.code
main PROC
	mWrite "GCD(5,20) = "
	mov eax,5
	mov ebx,20
	call GCD
	call WriteDec
	call crlf
	mWrite "GCD(24,18) = "
	mov eax,24
	mov ebx,18
	call GCD
	call WriteDec
	call crlf
	mWrite "GCD(11,7) = "
	mov eax,11
	mov ebx,7
	call GCD
	call WriteDec
	call crlf
	mWrite "GCD(432,226) = "
	mov eax,432
	mov ebx,226
	call GCD
	call WriteDec
	call crlf
	mWrite "GCD(26,13) = "
	mov eax,26
	mov ebx,13
	call GCD
	call WriteDec
	call crlf
	exit
main ENDP

;GCD(x,y)
;eax : x
;ebx : y
GCD PROC USES edx
	mov edx,0
	div ebx
	mov eax,ebx ;x=y
	mov ebx,edx ;y=n
	cmp ebx,0
	jng return
	call GCD
return:
	ret
GCD ENDP

END main