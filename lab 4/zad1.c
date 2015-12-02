#include <stdio.h>
int main()
{
	char *s="Abc";
	
	asm volatile(
	
	".intel_syntax noprefix;" /*  składnia intel  */
	"mov eax,%0;"
	"push eax;"
	"call wypisz;"
	"jmp koniec;"
	
	"wypisz:"
	"push ebp;"
	"mov ebp,esp;"
	"push eax;"
	"push ebx;"
	"push ecx;"
	"push edx;"
	"mov eax,4;"
	"mov ebx,1;"
	"mov ecx,[ebp+8];"
	"mov edx,3;"
	"int 0x80;"
	"pop edx;"
	"pop ecx;"
	"pop ebx;"
	"pop eax;"
	"pop ebp;"
	"ret 4;"
	
	"koniec:"
	
	
	".att_syntax prefix;"
	:
    :"r"(s)
	:"eax"
	
	
	
	);
	
	return 0;
}
