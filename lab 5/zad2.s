//na ekranie zostaje wyswietlona nazwa programu
.intel_syntax noprefix
.text 
.global main

main:
	push ebp
	mov ebp,esp
	mov eax,[ebp+12]
	mov ebx,[eax]
	push ebx
	call puts
	pop ebx
	pop ebp
	
	ret
