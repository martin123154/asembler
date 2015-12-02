#include <stdio.h>
int main()
{
	char *s = "Abc";
	asm volatile(
	
	".intel_syntax noprefix;"
	
	"mov edx,2;" //do rejestru edx wprowadzamy 2 znaki
	"mov ebx,1;" //do rejestru ebx wprowadzamy deskryptor pliku
	"mov ecx, %0;" //w rejestrze ecx przechowywany jest adres łańcucha, w naszym wypadku 1
	"mov eax,4;"    //w eax znajduje sie numer wołania systemowego (4)
	"int 0x80;"
	".att_syntax prefix;"
	:
	:"r"(s) //zmienna wejsciowa
	:"eax","ebx","ecx","edx"
	
	
	
	);
	
	return 0;
}

