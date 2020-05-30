TITLE      (.asm)
INCLUDE Irvine32.inc
INCLUDE Macros.inc

.data
INT9 DWORD 9
INT5 DWORD 5
INT32 DWORD 32
.code
main PROC
	mWrite "攝氏度 : "
	FINIT
	fild INT32 ;32
	call ReadFloat ;C
	fild INT9 ;9
	fild INT5 ;5
	fdiv ;/
	fmul ;*
	fadd ;+
	mWrite "華氏度 : "
	call WriteFloat
	call crlf
	exit
main ENDP
END main