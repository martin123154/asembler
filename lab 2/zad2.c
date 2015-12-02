#include <stdio.h>
int main()
{
	char s[]="Abcdefg";  //char *s="Abcdefg";
	short int y;
	asm volatile(
	
	".intel_syntax noprefix;"
	
	"mov ebx,%1;"
	"call liczznaki;"
	"mov %0,cx;"
	"jmp wyjscie;"
	//wejście : ebx-adres łańcucha
	// wyjście: cx - długość łancucha
	//efekty uboczne - przesuniecie ebx na koniec łańcucha/ zmiana wartosci w al
	"liczznaki:"
	"push ax;"
	"xor cx,cx;"
	
	"petla:"
	"mov al,[ebx];"
	"cmp al,0;"
	"jz koniec;" //jesli zero to konczymy
	"inc cx;" // zwiekszamy licznik
	"inc ebx;"  //bierzemy nastepny znak
	"jmp petla;" //zaczynamy po raz kolejny obrót petli
	
	"koniec:" // w przypadku spełnienia warunku petli przeskakujemy tutaj
	"pop ax;"
	"ret;" //zdejmowanie czegoś ze stosu
	"wyjscie:"
	
	
	
		".att_syntax prefix;"
	:"=r"(y) //zmienna wyjsciowa
	:"r"(s) //zmienna wejsciowa
	:"ebx","cx","al"
	
	
	
	);
	printf ("s=%s, y=%hd", s,y);
}
