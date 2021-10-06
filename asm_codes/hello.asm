section .text align=0

global _start

mensagem db 'Hello world', 0x0a

len equ $ - mensagem

_start:
    mov eax, 4 ;SYS_write
    mov ebx, 1 ;stdout
    mov ecx, mensagem ;Pointer
    mov edx, len ; size
    int 0x80

    mov eax, 1
    int 0x8

	mov rax, 60
	mov rdi, 0
	syscall