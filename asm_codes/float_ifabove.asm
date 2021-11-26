section .data

NULL		equ	0
STDOUT		equ	0
SYS_exit 	equ 60
EXITSUCCESS equ	0
LF			equ	10


num1	dd	5.3
num2	dd	5.3
message	db	"Finished!",NULL,LF
size	equ	$-message

SYS_write	equ	1

section .text
global _start
_start:
	movss	xmm0,dword[num1]
	ucomiss xmm0,dword[num2]
	je	finish
	
	mov	RAX,SYS_exit
	mov	RDI,EXITSUCCESS
	syscall

finish:
	mov	RAX,SYS_write
	mov	RDI,STDOUT
	mov	RSI,message
	mov	RDX,size
	syscall

	mov	RAX,SYS_exit
	mov	RDI,EXITSUCCESS
	syscall
