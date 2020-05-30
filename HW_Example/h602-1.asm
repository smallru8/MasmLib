TITLE      (.asm)
INCLUDE Irvine32.inc
INCLUDE Macros.inc

.data
array DWORD 10 DUP(?)
.code
main PROC
	mov ecx,10
	mov esi,OFFSET array
	mWrite "Random array : "
	call Randomize
L1:
	call Random32
	call WriteInt
	mWrite " "
	mov [esi],eax
	add esi,4
	loop L1
	call crlf

	mov ecx,9
	mov esi,OFFSET array
L2:
	mov eax,[esi]
	mov ebx,[esi+4]
	cmp eax,ebx
	jng Continue
	mov edi,esi
	add edi,4
	call Swap
Continue:
	add esi,4
	loop L2

	mov ecx,10
	mov esi,OFFSET array
	mWrite "After swap : "
L3:
	mov eax,[esi]
	call WriteInt
	mWrite " "
	add esi,4
	loop L3
	call crlf
	exit
main ENDP

;swap esi edi
Swap PROC USES eax
	mov eax,[esi]
	xchg eax,[edi]
	mov [esi],eax
	ret
Swap ENDP

END main