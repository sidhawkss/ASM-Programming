; sum of a list
section .data
EXIT_SUCCESS equ 0  ; successful operation
SYS_exit     equ 60 ; termination call code

section .data

lst dd 1002, 1004, 1006, 1008, 10010
len dd 5
sum dd 0 

section .text
global _start
_start:
;Summation loop
	mov ecx, dword[len]
	mov rsi, 0
sumLoop:
	mov eax, dword[lst+(rsi*4)]
	add dword[sum], eax
	inc rsi
	loop sumLoop
last:
	mov rax, SYS_exit
	mov rdi, EXIT_SUCCESS
	syscall
