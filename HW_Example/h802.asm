TITLE      (.asm)
INCLUDE Irvine32.inc
INCLUDE Macros.inc
.data
INT4 DWORD 4
INT2 DWORD 2
.code
main PROC
    FINIT
    mWrite "Find root : ax^2+bx+c"
    call crlf
    mWrite "a = "
    call ReadFloat
    mWrite "b = "
    call ReadFloat
    mWrite "c = "
    call ReadFloat
    fld ST(1)
	fchs
	fld ST(0)
    fmul ST(0),ST(0)
    fild INT4
    fld ST(5)
    fld ST(4)
    fmul
    fmul
    fsub
    fldz
    fcomip ST(0),ST(1)
    ja IMAG_ROOT
    fsqrt
	fld ST(1)
	fld ST(1)
	fsub
	fild INT2
	fmul ST(6),ST(0)
	fstp ST(0)
	fdiv ST(0),ST(5)
	mWrite "First root : "
	call WriteFloat
    call crlf
	fstp ST(0)
	fadd
	fdiv ST(0),ST(3)
	mWrite "Second root : "
	call WriteFloat
    call crlf
    jmp PROCEND
IMAG_ROOT:
    mWrite "虛根"
    call crlf
PROCEND:
    exit
main ENDP
END main