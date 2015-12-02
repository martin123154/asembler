// zad y <- 100*x ; tworzymy pêtle


#include <stdio.h>
int main()
{
short int x=1;
short int y=0;


asm volatile( //asm kod asemblerowy, volatile - ma nie optymalizowaæ tego kodu
".intel_syntax noprefix;"

"mov ax,%1;"  // ax<-x
"mov bx,0;"
"mov cx,100;" // przy zakomentowaniu wychodz¹ rózne wartoœci
//pêtla
"petla:"
"add bx,ax;"
"sub cx,1;"
"jnz petla;" // skocz, je¿eli wynik nie by³ zerowy

"mov %0,bx;"
".att_syntax prefix;"
:"=r" (y) //informacja o zmiennych wyjœciowych (jakie wartosci zmiennych nasz kod zmieni(output))
:"r" (x) // informacja o zmiennych wejœciowych (jakie wartosci zmiennych nasz kod bêdzie u¿ywa³(input))
// informujemy kompilator jakie rejestry zosta³y zniszczone
:"ax","bx","cx"

);

printf("x = %hd, y = %hd \n",x,y);
return 0;
}
