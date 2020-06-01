.code
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

;====================
;反轉String
;輸入 edi : String
;輸入 eax : length
;====================
strrev PROC USES ecx edx
	LOCAL ediPtr:DWORD
	mov ediPtr,edi
	mov ecx,eax
	mov edx,0
L1:
	mov dl,BYTE PTR [edi]
	push edx
	inc edi
	loop L1
	mov edi,ediPtr
	mov ecx,eax
L2:
	pop edx
	mov BYTE PTR [edi],dl
	inc edi
	loop L2
	mov edi,ediPtr
	ret
reverse ENDP

END
