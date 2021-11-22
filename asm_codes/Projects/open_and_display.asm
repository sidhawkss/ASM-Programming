;
; System argument vectors are given from the stack.
; Steps:
; 	The file is opened from the argumentV
; 	The file is written on the console
; b-sidhawks

section .data

NULL	equ	0
LF		equ	10

errReadMessage	db	"Error reading the file",LF,NULL
errOpenMessage	db	"Error opening the file",LF,NULL

BUFF_SIZE	equ	255

SYS_read	equ	0
SYS_write	equ	1
SYS_open	equ	2
SYS_close	equ	3
SYS_exit	equ	60

O_RDONLY	equ	0000000q ; Read Only
O_WONLY		equ	0000001q ; Write Only
O_RDWR		equ	0000002q ; Read & Write

FD_stdin	equ	0
FD_stdout	equ	1
FD_stderr	equ	2

EXITSUCCESS	equ	0
fileDesc	dq	0

;---------------------------------------------------------------------------

section .bss
readBuffer resb BUFF_SIZE

;---------------------------------------------------------------------------

section .text
global _start
_start:
	call	GetArgumentv

;FileOpen
FileOpen:
	mov	rax, SYS_open		;Organization to syscall open file
	mov	rdi, rsi
	mov	rsi, O_RDONLY
	syscall

	cmp	rax,0				;Check erros
	jl	errorOnOpen

	mov	qword[fileDesc], rax

	mov	rax,SYS_read		;Organization to syscall read
	mov	rdi,qword[fileDesc]
	mov	rsi,readBuffer
	mov	rdx,BUFF_SIZE
	syscall

	cmp	rax,0
	jl	errorOnRead

	mov	rsi,readBuffer
	mov	byte[rsi+rax],NULL

	mov	rdi,readBuffer
	call	printString

	jmp	exit


errorOnOpen:
	mov		rdi,errOpenMessage
	call	printString

errorOnRead:
	mov		rdi, errReadMessage
	call	printString

exit:
	mov	rax,SYS_exit
	mov	rdi,EXITSUCCESS
	syscall



;-----------------------------------------------------------------
;						|Global Functions|
;-----------------------------------------------------------------



global GetArgumentv
GetArgumentv:
	push	rbp
	mov		rbp,rsp
	mov		rsi,qword[rbp+32]
	pop		rbp
	ret

global	printString
printString:
	push	rbp
	mov		rbp,rsp
	mov		rbx,rdi	
	mov		rdx,0

CountString:
	cmp	byte[rbx],NULL
	je	CountDone

	inc	rbx
	inc	rdx
	jmp	CountString


CountDone:
	cmp	rdx,0
	je	Done

	mov	rax,SYS_write	;syscall write
	mov	rsi,rdi
	mov	rdi,FD_stdout
	syscall

	cmp	rax,0
	jl	Done

	mov	qword[fileDesc],rax

Done:
	pop	rbp
	ret
