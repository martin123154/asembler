// zad y <- 100*x ; tworzymy pętle


#include <stdio.h>
int main()
{
short int x=1;
short int y=0;
 
 
asm volatile( //asm kod asemblerowy, volatile - ma nie optymalizować tego kodu
".intel_syntax noprefix;"

"mov ax,%1;"  // ax<-x
"mov bx,0;"
"mov cx,100;" // przy zakomentowaniu wychodzą rózne wartości
//pętla
"petla:"
"add bx,ax;"
"sub cx,1;"
"jnz petla;" // skocz, jeżeli wynik nie był zerowy
 
"mov %0,bx;"
".att_syntax prefix;"
:"=r" (y) //informacja o zmiennych wyjściowych (jakie wartosci zmiennych nasz kod zmieni(output))
:"r" (x) // informacja o zmiennych wejściowych (jakie wartosci zmiennych nasz kod będzie używał(input))
// informujemy kompilator jakie rejestry zostały zniszczone
:"ax","bx","cx"
 
);
 
printf("x = %hd, y = %hd \n",x,y);
return 0;
}
