; File to compute the sum of a list and average
;
;	rdi = rdi pointer to list
;	rcx = size of 


section .text
global sumNumbers
sumNumbers:
	push rbp
	mov	 rbp,rsp

	add r12,rcx
sumIteration:

	mov	rdx,qword[rdi+rsi*8]
	add	rax,rdx
	inc	rsi
	loop sumIteration
	
	xor rbx,rbx
	add	rbx,rax
	cdq
	div r12

	pop	rbp
	ret
