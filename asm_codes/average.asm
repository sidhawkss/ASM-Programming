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
	
	mov rax, r12
	mov rbx, r11
	div rbx
	add rax, "0"
	

	mov r13, save
	mov qword[r13], rax
	mov qword[r13+4], 10
	mov rax,1
	mov rdi,1 
	mov rsi,save
	mov rdx,10
	syscall
%endmacro

section .data

list: dq 1,2,3,4,5
sizeList: dq 5

section .bss

save: resb 1

section .text
global _start

_start:
	Average list, sizeList
	
	mov rax,60
	mov rdx,0
	syscall
