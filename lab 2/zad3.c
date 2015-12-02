#include <stdio.h>
int main()
{
	char s[]="Abcdefg";  //char *s="Abcdefg";
	char t[]={0,0,0,0,0,0,0,0}; 
	
	short int y;

	asm volatile(
	
	".intel_syntax noprefix;"
	
	"mov ebx, %0;"
	"mov ecx, %1;"
	"inc ebx;"

"	mov al,bl;"
"	mov eax,ebx;"
"	mov eax, dword ptr [ebx];"
	"call przeniesznak;"
	
	"jmp wyjscie;"
	//argumenty : ebx - adres źródłowy, ecx - adres docelowy
	"przeniesznak:"
	"push ax;"
	"mov al,[ebx];"
	"mov [ecx],al;"
	"pop ax;"
	"ret;"
	"wyjscie:"

	".att_syntax prefix;"
	
	:      	//brak zmiennych wyjściowych
	:"r"(s),"r"(t) //zmienna wejsciowa
	:
	
	
	
	);
	printf ("s=%s, t=%s\n", s,t);
}
