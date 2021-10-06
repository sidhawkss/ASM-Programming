section .data
bNumA db 10
bNumB db 10
wAns  dw 0
wAns1 dw 0

wNumA dw 10000
wNumB dw 10000
dAns2 dw 0

dNumA dd 42000
dNumB dd 73000
qAns3 dq 0

qNumA dq 420000
qNumB dq 730000
dqAns4	dq	0


section .text
global _start
_start:
	mov al, byte[bNumA]
	mul byte[bNumB]
	mov word[wAns1], ax

	mov ax, word[wNumA]
	mul word[wNumB]
	mov word[dAns2], ax
	mov word[dAns2+2], dx

	mov eax, dword[dNumA]
	mul	dword[dNumB]
	mov dword[qAns3], eax
	mov dword[qAns3+4], edx

	mov rax, qword [qNumA]
	mul qword[qNumB]
	mov qword[dqAns4], rax
	mov qword[dqAns4+8], rdx

	mov rax, 60
	mov rdi, 0
	syscall