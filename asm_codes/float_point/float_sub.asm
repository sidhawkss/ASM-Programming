section .data

SYS_exit	equ	60
EXITSUCCESS		equ	0

Snum1	dd	43.75
Snum2	dd	15.5
Sans	dd	0.0

Dnum1	dq	200.12
Dnum2	dq	73.2134
Dans	dq	0.0

section .text
global _start
_start:
	;Sans	=	Snum1	-	Snum2
	movss	xmm0,	dword[Snum1]
	subss	xmm0,	dword[Snum2]
	movss	dword[Sans], xmm0

	;Dans	=	Dnum1	-	Dnum2
	movsd	xmm0,	qword[Dnum1]
	subsd	xmm0,	qword[Dnum2]
	movsd	qword[Dans], xmm0

	mov	rax,SYS_exit
	mov	rdi,EXITSUCCESS
	syscall
	
