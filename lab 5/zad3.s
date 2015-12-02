// Nazwa programu

.intel_syntax noprefix
.text 
.global main

main:
mov eax,offset msg
push eax
call puts
pop eax

	push ebp
	mov ebp,esp
	mov eax,[ebp+12]
	mov ebx,[eax]
	
	//pushad
	push ebx
	//popad
	call puts
	pop ebx
	pop ebp
	
	ret
	.data
	
	msg:
	.asciz "Nazwa programu:"
