; Based on Ed Jorgensen's book
section .data

; Define standard constats

LF				equ 10	;line feed
NULL			equ 0	;end of string
TRUE			equ 1
FALSE			equ 0	
EXIT_SUCCESS	equ 0	;success code
STDIN			equ 0	;standard input
STDOUT			equ 1	;standard output
STDERR			equ 2	;standard error

SYS_read		equ 0	;read
SYS_write		equ 1	;write
SYS_open		equ 2	;file open
SYS_close		equ	3	;file close
SYS_fork		equ 56	;fork
SYS_exit		equ 60	;terminate
SYS_creat		equ	85	;file open/create
SYS_time		equ 201 ;get time

O_CREAT			equ 0x40
O_TRUNC			equ 0x200
O_APPEND		equ 0x400

O_RDONLY		equ 0000000q ;read only
O_WRONLY		equ	0000001q ;write only
O_RDWR			equ	0000002q ;read and write

S_IRUSR			equ 00400q
S_IWUSR			equ	00200q
S_IXUSR			equ	00100q

;#######################################################
; VARIABLES

newLine	db	LF,NULL
header	db	LF,"File Write Example.",LF,LF,NULL
fileName	db	"url.txt",NULL
url			db	"http://www.google.com",LF,NULL
len			dq	$-url-1

writeDone	db	"Write Completed." , LF, NULL
fileDesc	dq	0	
errMsgOpen	db	"Error opening file;", LF, NULL
errMsgWrite	db	"Error writing to file", LF, NULL

;########################################################
; Code section

section .text
global printString
printString:
	push	rbp
	mov		rbp,rsp
	push	rbx
;########################################################

;########################################################
; Count characters in STRING

	mov	rbx, rdi
	mov	rdx, 0 
CountLoop:

	cmp	byte[rbx],NULL
	je	CountDone	
	inc	rdx
	inc	rbx
	jmp	CountLoop

CountDone:
	cmp	rdx,0
	je	prtDone
;########################################################
; Syscall output

	mov	rax,SYS_write ; syscall to write
	mov	rsi,rdi	      ; addr string
	mov rdi,STDOUT	  ; file descriptor func to do
	
	syscall
;########################################################
; Return to calling routine

prtDone:
	pop	rbx	
	pop	rbp
	ret

;########################################################
global _start
_start:

; Header line
	mov		rdi,header
	call	printString

; Open file
; SYS_Open/Create
; RAX = SYS_creat 
; RDI = address of the file name
; RSI = attributes (read only, write only...)
; If error: rax < 0

openInputFile:
	mov	rax,SYS_creat	      ;file open/create
	mov	rdi,fileName		  ;file name string
	mov	rsi,S_IRUSR | S_IWUSR ; allow read/write
	syscall

	cmp	rax,0				  ; check for success
	jl  errorOnOpen

	mov	qword[fileDesc],rax   ;save descriptor
	
; Write to file.
; In this example, the characters to write are in a
; predefined string containing a URL

; System service - write
; rax = SYS_write
; rdi = file descriptor
; rsi = address of characters to write
; rdx = count of characters to write
; Returns:
; if error rax < 0
;


	mov	rax,SYS_write
	mov	rdi,qword[fileDesc]
	mov	rsi,url
	mov	rdx,qword[len]
	syscall

	cmp	rax,0
	jl	errorOnWrite
	
	mov	rdi,writeDone
	call	printString

; Close the file
; System service - close
; rax = SYS_close
; rdi = file descriptor

	mov	rax, SYS_close
	mov	rdi, qword[fileDesc]
	syscall

	jmp exampleDone

; #################################################
; Error on Open
; note, rax contains an error code with is not used
; for this example
;
; #################################################

errorOnOpen:
	mov		rdi, errMsgOpen
	call	printString

	jmp exampleDone

;##################################################
; Error on write
; 
;#################################################

errorOnWrite:
	mov	rdi, errMsgWrite
	call	printString

	jmp exampleDone


exampleDone:
	mov	rax,SYS_exit
	mov	rdi,EXIT_SUCCESS
	syscall
