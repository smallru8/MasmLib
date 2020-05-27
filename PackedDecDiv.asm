TITLE      (.asm)
INCLUDE Irvine32.inc
INCLUDE Macros.inc

.data
NumA QWORD 0000002147483647h
PointA BYTE 6
NumB QWORD 0000000000000884h
PointB BYTE 1
.code
main PROC
	;TEST1
	mWrite "測試測資 : 2147.483647 / 88.4"
	call crlf
	mov edi,OFFSET NumA
	mov ah,PointA
	mov esi,OFFSET NumB
	mov al,PointB
	call QDAD
	call crlf
L1:
	mov eax,0;歸0
	mov DWORD PTR [edi],eax
	mov DWORD PTR [edi+4],eax
	mov DWORD PTR [esi],eax
	mov DWORD PTR [esi+4],eax
	mov PointA,al
	mov PointB,al
	mWrite "輸入下一筆測資 : "
	call crlf
	mWrite "Number A : "
	mov esi,OFFSET NumA
	mov edi,OFFSET PointA
	call RPD
	mWrite "Number B : "
	mov esi,OFFSET NumB
	mov edi,OFFSET PointB
	call RPD
	mov edi,OFFSET NumA
	mov ah,PointA
	mov esi,OFFSET NumB
	mov al,PointB
	call QDAD
	call crlf
	jmp L1
	exit
main ENDP

RPD PROC USES eax ebx ecx edx
	mov edx,0
L0:
	call ReadChar
	call WriteChar
	push eax
	inc edx
	cmp al,13
	JNE L0
	call crlf
	mov ecx,0
	mov bh,4
	mov bl,-4
L1:
	pop eax
	.IF(al == '.')
		mov cl,0
		dec edx
		jmp L1
	.ELSEIF(al == 13)
		dec edx
		jmp L1
	.ENDIF
	and al,0Fh
	add bh,bl
	neg bl
	inc cl;小數點計數
	inc ch
	xchg cl,bh
	shl al,cl
	xchg cl,bh
	or BYTE PTR [esi],al
	dec edx
	cmp edx,0
	jz L1END
	cmp bl,0
	jng CCH
	jmp L1
CCH:
	inc esi
	jmp L1
L1END:
	sub ch,cl
	mov [edi],ch
	ret
RPD ENDP

QDAD PROC USES ebx ecx edx
	LOCAL Quotient:DWORD
	LOCAL Remainder:QWORD
	mov ecx,0
	mov edx,0
	mov Quotient,edx
	mov DWORD PTR Remainder,edx;高位玩
	mov DWORD PTR Remainder+4,edx;低位元
	mov bl,ah
	.IF(ah > al);小數點對齊
		mov bl,ah
		mov dl,ah
		sub dl,al
		imul dx,4
		mov cl,dl
		call QSHL
	.ELSEIF(al > ah)
		mov bl,al
		mov dl,al
		sub dl,ah
		imul dx,4
		mov cl,dl
		xchg edi,esi
		call QSHL
		xchg edi,esi
	.ENDIF	
L1:	
	mov ecx,0
	mov bh,00h
	L2:
		mov dl,bh
		mov bh,00h
		mov al,BYTE PTR [edi+ecx]
		mov ah,BYTE PTR [esi+ecx]
		sub al,ah
		das
		jnc L2_1;
		mov bh,01h
	L2_1:
		sub al,dl;借位
		das
		jnc L2_2;
		mov bh,01h
	L2_2:
		mov BYTE PTR [edi+ecx],al
		inc ecx
		cmp ecx,8
		jne L2
	.IF(bh == 00h)
		mov ecx,1
		add Quotient,ecx
		mov ecx,DWORD PTR [edi]
		mov DWORD PTR Remainder,ecx
		mov ecx,DWORD PTR [edi+4]
		mov DWORD PTR Remainder+4,ecx
		jmp L1
	.ENDIF
	mWrite "Quotient = "
	mov eax,Quotient
	call WriteDec
	mWrite ".0"
	call crlf
	mov ecx,0
	mov bh,0
L3:
	mov eax,0
	mov al,BYTE PTR Remainder[ecx]
	and al,0Fh
	or al,30h
	push eax
	inc bh
	.IF(bh == bl)
		push '.'
	.ENDIF
	mov al,BYTE PTR Remainder[ecx]
	shr al,4
	or al,30h
	push eax
	inc bh
	.IF(bh == bl)
		push '.'
	.ENDIF
	inc ecx
	cmp ecx,8
	jne L3
	mWrite "Remainder = "
	mov ecx,17
	mov bl,0
L4:
	pop eax
	.IF(al == 30h && bl == 0)
		loop L4
	.ENDIF
	.IF(al == 2Eh)
		.IF(bl == 0)
			mWrite "0"
		.ENDIF
	.ENDIF
	mov bl,1
	call WriteChar
	loop L4
	and al,0F0h
	.IF(al > 30h || al < 30h )
		mWrite "0"
	.ENDIF
	call crlf
	ret
QDAD ENDP

QSHL PROC
L1:
	shl DWORD PTR [esi],1
	rcl DWORD PTR [esi+4],1
	loop L1
	ret
QSHL ENDP
END main
