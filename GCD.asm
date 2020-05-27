;==================
;GCD(x,y)
;eax : x
;ebx : y
;
;ret : eax
;==================
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
