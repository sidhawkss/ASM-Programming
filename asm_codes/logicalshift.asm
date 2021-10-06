section .data

dNum1 db 6
dNum2 db 0

section .text
global _start

_start:
	mov	al, byte[dNum1]
	shr bl, 2

	mov rax, 60
	mov rdi,0
	syscall