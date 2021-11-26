section .data

SYS_exit	equ	60
EXITSUCCESS	equ	0

fSingleVar1	dd	3.14
fSingleVar2	dd	0.0
fDoubleVar1	dq	6.28
fDoubleVar2	dq	0.0

section .text
global _start:
_start:
	movss	xmm0, dword[fSingleVar1]
	movss	dword[fSingleVar2], xmm0	; floatSingle2 = floatSingle1

	movsd	xmm1, qword[fDoubleVar1]
	movsd	qword[fDoubleVar2], xmm1	; floatDouble2 = flotDouble1

	movss	xmm2,xmm0	;32bit
	movsd	xmm3,xmm1	;64bit

	mov	rax,SYS_exit
	mov	rdi,EXITSUCCESS
	syscall


	
