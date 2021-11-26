; Floating-Point Example program
; ***************************************

section .data

; ---------------------------------------
; Define Constants

NULL	equ	0	;end of string
TRUE	equ	1
FALSE	equ	0

EXIT_SUCCESS	equ	0	; Successful operation
SYS_exit		equ	60	; System call code for terminate

; ---------------------------------------

fltLst	dq	21.34,  6.15,  9.12,  10.5, 7.75
		dq	1.44 , 14.50,  3.32, 75.71, 11.87
		dq	17.23, 18.25, 13.65, 24.24, 8.88
length	dd	15
lstSum	dq	0.0
lstAve	dq	0.0

section .text

global _start
_start:
; *****************************************
; Loop to find floating-point sum.
	
	mov		ecx, [length]
	mov		rbx, fltLst
	mov		rsi, 0 
	movsd	xmm1, qword[lstSum]
sumLp:
	movsd	xmm0,qword[rbx+rsi*8] ; get fltLst[i]
	addsd	xmm1,xmm0
	inc		rsi
	loop	sumLp	

	movsd	qword[lstSum], xmm1	  ; save sum

; Compute average of entire  list.

	cvtsi2sd	xmm0, dword[length]
;	cvtsd2si	dword[length], xmm0
	divsd		xmm1, xmm0
	movsd		qword[lstAve], xmm1

; Done, terminate program.

last:
	mov		rax, SYS_exit
	mov		rbx, EXIT_SUCCESS
	syscall