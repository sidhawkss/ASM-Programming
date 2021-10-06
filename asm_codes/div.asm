section .data

bNumA db 63
bNumB db 17
bNumC db 5
bAns1 db 0
bAns2 db 0 
bRem2 db 0
bAns3 db 0

wNumA dw 4321
wNumB dw 1234
wNumC dw 167
wAns1 dw 0
wAns2 dw 0
wRem2 dw 0
wAns3 dw 0
 
dNumA dd 42000
dNumB dd -3157
dNumC dd -293
dAns1 dd 0
dAns2 dd 0
dRem2 dd 0 
dAns3 dd 0 

qNumA dq 730000
qNumB dq -13456
qNumC dq -1279
qAns1 dq 0
qAns2 dq 0
qRem2 dq 0
qAns3 dq 0
 
;bAns1 = bNumA / 3
;bAns2 = bNumA / bNumB
;bRem2 = bNumA % bNumB
;bAns3 = (bNumA * bNumC) / bNumB
;
;wAns1 = wNumA / 5
;wAns2 = wNumA / wNumB
;wRem2 = wNumA % wNumB
;wAns3 = (wNumA * wNumC) / wNumB
;
;dAns  = dNUmA / 7
;dAns3 = dNumA * dNumB
;dRem1 = dNumA % dNumB
;dAns3 = (dNumA * dNumC) /dNumB
;
;qAns  = qNumA / 9
;qAns4 = qNumA * qNumB
;qRem1 = qNumA % qNumB
;qAns3 = (qNumA * qNumC) / qNumB
;
;

section .text
global _start

_start:
	;mov al, byte[bNumA]
	;mov ah, 0 
	;mov bl, 3
	;div bl
	;mov byte[bAns1], al
	;mov byte[bAns1+2], al

	;mov ax,0 
	;mov al,byte[bNumA]
	;div byte[bNumB]
	;mov byte[bAns2],al ;al = ax / bNumB
	;mov byte[bRem2],ah ;ah = ax % bNumB

	; bAns3 = (bNumA * bNumC) / bNumB
	;mov	al, byte[bNumA]
	;mul	byte[bNumC]     ; result in ax
	;div	byte[bNumB]     ; al = ax / bNumB
	;mov byte[bAns3], al

	; --------------- double-word operations, signed
	; dAns1 = dNumA / 7 (signed)
	; 
	;mov 	eax, dword[dNumA]
	;cdq                   		; eax -> edx:eax
	;mov		ebx,7	
	;idiv	ebx					; eax = edx:eax / 7
	;mov		dword[dAns1], eax
	

	;mov eax, dword[dNumA]
	;cdq                        ; eax -> edx:eax
	;idiv dword[dNumB]		   ; eax = edx:eax / dNumb
	;mov dword[dAns2], eax
	;mov dword[dRanm2], edx     ; edx = edx:eax % dNumB

	; qAns3 = (dnumA * dNumC) / dNumB(signed)
	;mov 	eax, dword[dNumA]
	;imul	dword[dNumC]
	;idiv	dword[dNumB]
	;mov 	dword[qAns3], eax
;-------------------------------------------------------
; Example quadword operations signed.

;qAns1 = qNumA / 9 (signed)

	;mov		rax, qword[qNumA]
	;cqo
	;mov 	rbx, 9
	;idiv	rbx
	;mov		qword[qAns1], rax
	
;qAns2 = qNumA / qNumB (signed)
	;mov	rax, qword[qNumA]
	;cqo
	;idiv qword[qNumB]
	;mov qword[qAns2], rax
	;mov qword[qRem2], rdx
;qAns3 = (qNumA * qNumC) / qNumB (signed)

	mov		rax,qword[qNumA]
	imul	qword[qNumC]
	idiv	qword[qNumB]
	mov		qword[qAns3],rax 
	


	

