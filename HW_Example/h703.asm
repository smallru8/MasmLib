TITLE      (.asm)
INCLUDE Irvine32.inc
INCLUDE Macros.inc

mac MACRO 
	mWrite "計算：2593+8888 = "
	mov eax,2593
	add eax,8888
	call WriteDec
ENDM

.data

.code
main PROC
	mac
	exit
main ENDP

END main