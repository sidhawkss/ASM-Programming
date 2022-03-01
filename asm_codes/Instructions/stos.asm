section .data
string1 db "sidhawks"

section .bss
string2 resb 20

section .text
global _start
_start:
	
	mov	rsi,string1
	mov	rdi,string2
	mov rcx,8

ITERATE:
	lodsb  ;Move RSI content to AL.
	stosb  ;Move AL content to RDI.

	loop ITERATE

	call exit

exit:
	mov	rax,60
	mov	rdi,0
	syscall
