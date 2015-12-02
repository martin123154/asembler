//to samo co zad2 tylko wyprowadzenie ręcznie

#include <stdio.h>
int main()
{
	char *s = "Abcaaabaa"; // 0
	char t[]={0}; //1 
	short int y; //2
	asm volatile(
	
	".intel_syntax noprefix;" /*  składnia intel  */
	"mov ebx, %0;" 
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
    
    
"mov ebx,%1;"
"add cl,'0';"
"mov [ebx],cl;"
"mov edx,1;"
"mov ebx,1;"
"mov ecx,%1;"
"mov eax,4;"
"int 0x80;"
	
	".att_syntax prefix;"
	:
    :"r" (s), "r"(t)
	:"ecx","edx","eax","cx","ebx","al"
	
	
	
	);
	
	return 0;
}
