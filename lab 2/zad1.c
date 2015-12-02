#include <stdio.h>
int main()
{
	char s[]="Abcdefg";  //char *s="Abcdefg";
	short int y;
	asm volatile(
	
	".intel_syntax noprefix;"
	
	"mov ebx,%1;"
	"xor cx,cx;"
	
	"petla:"
	
	"mov al,[ebx];" //do al ladujemy wartosc rejestru ebx->al= 'A'
	"sub al,0;"
	"jz koniec;" //jesli zero to konczymy
	"inc cx;" // zwiekszamy licznik
	"inc ebx;"  //bierzemy nastepny znak
	
	"jmp petla;"
	
	"koniec:"
	
	
	"mov %0,cx;"
	
	
	".att_syntax prefix;"
	:"=r"(y) //zmienna wyjsciowa
	:"r"(s) //zmienna wejsciowa
	:"ebx","cx","al"
	
	
	
	);
	printf ("s=%s, y=%hd", s,y);
}
