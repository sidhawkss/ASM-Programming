section .data

SYS_exit	equ	60
EXITSUCCESS	equ	0
NULL		equ 0
LF			equ 10
store		dq	0
string		db	"HAHA I'M HERE", LF,NULL

list dq 1,2,3,4,5
size dq 5

extern sumNumbers
extern printString

section .text
global	_start
_start:
	mov	rcx,qword[size]
	mov	rdi,list
	mov	rdx,0
	call	sumNumbers

	add	rax,0x30
	add	qword[store],rax
	mov	qword[store+1], 0xa
	

	mov	rdi, store
	call printString

	mov	rax,SYS_exit
	mov	rdi,EXITSUCCESS
	syscall