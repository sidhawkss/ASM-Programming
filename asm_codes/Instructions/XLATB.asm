section .data
table db "scallopito"

section .text
global _start
_start:
	mov	ebx,table ;Table
	mov al,9      ;Index number
	xlatb

	mov	rax,60
	mov	rdi,0
	syscall
