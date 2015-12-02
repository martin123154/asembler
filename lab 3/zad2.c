// ile 'a' w charze w tym przypadku y=5
#include <stdio.h>
int main()
{
	char *s = "Abcaaabaa"; // 0
	char t[]={0}; //1 
	short int y; //2
	asm volatile(
	
	".intel_syntax noprefix;" /*  składnia intel  */
	
	"mov ebx, %1;" // w rejestrze ebx mamy pierwsza litere stringu s
	"xor cx,cx;" // wyzerowanie rejestru cx
	"petla:"
		"mov al, [ebx];" // wrzucenie do al wartości spod adresu ebx (coś jak wskaźnik)
		"cmp al,0;"
			"jz koniec;"
		"cmp al,'a';" //albo "cmp al,97;"
		"jnz niea;"
		"inc cx;" // zwieksza wartość spod adresu cx o 1
		"niea:"
		"inc ebx;" // przesunięcie stringu o 1 miejsce w adresie ebx
	"jmp petla;"

    "koniec:"
    "mov %0,cx;"
   
	
	".att_syntax prefix;"
	:"=r" (y) // zmienna wyjściowa
    :"r" (s), "r"(t)
	:"cx","ebx","al"
	
	
	
	);
	  printf( "y=%d\n", y);
	return 0;
}


