; Count
; syscall to print
; rdi = string to print


section .data

SYS_write	equ	1
STDOUT		equ 1
NULL		equ	0
LF			equ 10

section .text
global printString:
printString:
	push	rbp
	mov		rbp,rsp

	mov	rbx,rdi
	mov	rdx,0

counter:
	cmp byte[rbx],NULL
	je	sysPrint
	inc	rbx
	inc	rdx
	loop counter

sysPrint:
	mov	rax, SYS_write
	mov	rsi, rdi
	mov	rdi, STDOUT
	syscall

	mov	rax,60
	mov	rdi,0
	syscall
