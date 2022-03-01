section .data
table db "pintinho"

section .text
global _start
_start:
	mov	rcx,table
	mov	rdx,6144
	bextr rbx,rcx,rdx
	
	mov rax,60
	mov rdi,0
	syscall

