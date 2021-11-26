section .data

SYS_exit	equ	60
EXITSUCCESS	equ	0

Snum1	dd	43.75
Snum2	dd	15.5
Sans	dd	0.0

Dnum1	dq	200.12
Dnum2	dq	73.2134
Dans	dq	0.0


section .text
global _start
_start:
	movss	xmm0, dword[Snum1]
	addss	xmm0, dword[Snum2]
	movss	dword[Sans], xmm0

	movsd	xmm1, qword[Dnum1]
	addsd	xmm1, qword[Dnum2]
	movsd	qword[Dans],xmm1

	mov	rax,SYS_exit
	mov	rdi,EXITSUCCESS
	syscall