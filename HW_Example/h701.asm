TITLE      (.asm)
INCLUDE Irvine32.inc
INCLUDE Macros.inc

.data
MAX = 100
string1 BYTE MAX+1 DUP(0)
string2 BYTE MAX+1 DUP(0)
.code
main PROC
	LOCAL ediLen:DWORD
	mWrite "Destination string : "
	mov  edx,OFFSET string1
    mov  ecx,MAX  
	call ReadString
	mov edi,OFFSET string1
	mov esi,edi
	call strlen
	mov ediLen,eax
	mWrite "Search string : "
	mov  edx,OFFSET string2
    mov  ecx,MAX
	call ReadString
	mov esi,OFFSET string2
	call strstr
	mWrite "Search result : "
	.IF eax > ediLen
		mWrite "NO found."
	.ELSE
		mWrite "OK."
	.ENDIF
	call crlf

	mWrite "Append string : "
	mov  edx,OFFSET string2
    mov  ecx,MAX
	call ReadString
	mov edi,OFFSET string1
	mov esi,OFFSET string2
	call strcat
	mov edx,edi
	mWrite "After appending : "
	call WriteString
	call crlf
	
	exit
main ENDP

;====================
;在字串1中搜尋字串2
;輸入 edi : 字串1
;輸入 esi : 字串2
;輸出 eax : 在字串1的位置
;====================
strstr PROC USES ecx
	LOCAL esiPtr:DWORD
	LOCAL ediPtr:DWORD
	LOCAL esiLen:DWORD
	LOCAL ediLen:DWORD
	mov esiPtr,esi
	mov ediPtr,edi

	call strlen
	inc eax;加上null byte
	mov esiLen,eax
	xchg esi,edi
	call strlen
	inc eax;加上null byte
	mov ediLen,eax
	xchg esi,edi

	mov eax,0
L1:
	cmp eax,ediLen
	jg Return
	cld
	mov ecx,esiLen
	repe cmpsb
	cmp ecx,0
	je Return
	
	inc eax
	mov edi,ediPtr
	mov esi,esiPtr
	add edi,eax
	jmp L1

Return:
	mov edi,ediPtr
	mov esi,esiPtr
	ret
strstr ENDP

;====================
;取得字串長度
;輸入 esi : 字串
;輸出 eax : 字串長度
;====================
strlen PROC USES edi
	mov edi,esi
	mov eax,0
L1:
	cmp BYTE PTR [edi],0
	je Return
	inc edi
	inc eax
	jmp L1
Return:
	ret
strlen ENDP

;====================
;將字串2接在字串1後面
;輸入 edi : 字串1
;輸入 esi : 字串2
;====================
strcat PROC USES eax ecx
	push edi
	push esi
	xchg esi,edi
	call strlen
	xchg esi,edi
	add edi,eax
	call strlen
	mov ecx,eax
	inc ecx;加上null byte
	cld
	rep movsb
	pop esi
	pop edi
	ret
strcat ENDP

END main