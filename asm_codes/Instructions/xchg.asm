section .data
section .text
global _start
_start:
	mov	rax,60
	mov	rsp,30
	
	xchg rax,rsp ; move RSP to RAX and RAX to RSP.
	ret
	
	mov	rax,60
	mov	rdi,0
	syscall
