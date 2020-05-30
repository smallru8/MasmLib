TITLE      (.asm)

INCLUDE Irvine32.inc
INCLUDE Macros.inc

.data
s BYTE "365.25",0

.code
main PROC
	mov edx,OFFSET s
	mov edi,OFFSET s
	mov ecx,LENGTHOF s
	mov al,'.'
	cld
	repnz scasb
	jnz NotFound
	dec edi
	
	mov al,0
	mov [edi],al
	inc edi

	mWrite "s1 = "
	call WriteString
	call crlf
	mov edx,edi
	mWrite "s2 = "
	call WriteString
	call crlf

NotFound:

	exit
main ENDP
END main