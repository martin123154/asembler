// zad y <- 100*x ; tworzymy p�tle


#include <stdio.h>
int main()
{
short int x=1;
short int y=0;


asm volatile( //asm kod asemblerowy, volatile - ma nie optymalizowa� tego kodu
".intel_syntax noprefix;"

"mov ax,%1;"  // ax<-x
"mov bx,0;"
"mov cx,100;" // przy zakomentowaniu wychodz� r�zne warto�ci
//p�tla
"petla:"
"add bx,ax;"
"sub cx,1;"
"jnz petla;" // skocz, je�eli wynik nie by� zerowy

"mov %0,bx;"
".att_syntax prefix;"
:"=r" (y) //informacja o zmiennych wyj�ciowych (jakie wartosci zmiennych nasz kod zmieni(output))
:"r" (x) // informacja o zmiennych wej�ciowych (jakie wartosci zmiennych nasz kod b�dzie u�ywa�(input))
// informujemy kompilator jakie rejestry zosta�y zniszczone
:"ax","bx","cx"

);

printf("x = %hd, y = %hd \n",x,y);
return 0;
}
