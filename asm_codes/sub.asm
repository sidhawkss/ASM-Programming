section .data
	bNum1 db 42
	bNum2 db 1
	bAns  db 0

section .text
global _start
_start:
	mov	al, byte[bNum1]
	sub	al, byte[bNum2]
	mov	byte[bAns], al
	push rax


