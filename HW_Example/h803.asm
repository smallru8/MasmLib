TITLE      (.asm)
INCLUDE Irvine32.inc
INCLUDE Macros.inc
.data
INTECX DWORD 0
INT180 DWORD 180
.code
main PROC
    FINIT
	fldpi ;pi
    fild INT180 ;180 pi
	fdiv ;pi/180
	mov ecx,0
L1:
	mov INTECX,ecx
	fild INTECX ;ecx pi/180
	fmul ST(0),ST(1) ;ecx*pi/180 pi/180
	fsin ;sin(ecx*pi/180) pi/180
	call WriteFloat
	call crlf
	fstp ST(0) ;pi/180
	add ecx,5
	cmp ecx,90
	jng L1

	exit
main ENDP
END main