%macro Average 2
	mov rbx, %1
	mov rcx, qword[%2]
	mov r11, qword[%2]
	mov rax, 0
	mov rsi, 0 
%%counter:
	mov rax, qword[rbx+rsi*8]
	inc rsi
	cdq
	add r12, rax
	loop %%counter

	xor rax,rax	
	mov rax, r12
	mov rbx, r11
	div rbx
%endmacro

section .data

list: dq 1,2,3,4,5
sizeList: dq 5

section .text
global _start

_start:
	Average list, sizeList
	
	mov rax,60
	mov rdx,0
	int 0x80
