section .data

LF			    equ	10
NULL		    equ	0
EXITSUCCESS	equ	0

SYS_exit	equ	60
SYS_write	equ	1
STDOUT		equ	0
NULL		  equ	0


section .text
global _start:
_start:
	pop		rbx
	pop		rbx
	pop		rdi
	call	printString

	xor		rdi,rdi
	pop		rdi
	call	printString

	mov	rax,SYS_exit
	mov	rdi,EXITSUCCESS
	syscall


global printString
printString:
	push	rbp
	mov	rbp,rsp
	
	xor	rbx,rbx
	mov	rbx,rdi

strCount:
	cmp	byte[rbx],NULL
	je	strDone
	inc	rdx
	inc	rbx
	jmp	strCount

strDone:
	cmp	rdx,NULL
	je	exit

sysPrint:
	mov	rax,SYS_write
	mov	rsi,rdi
	mov	rdi,STDOUT
	syscall

exit:
	pop	rbp
	ret
