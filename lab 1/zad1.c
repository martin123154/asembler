#include <stdio.h>
 
int main()
{
short int x=1;
short int y=0;
 
 
asm volatile( //asm kod asemblerowy, volatile - ma nie optymalizować tego kodu
".intel_syntax noprefix;"
 //szablon programu
"mov ax,%1;"
//"mov %0,ax;"

 
".att_syntax prefix;"
:"=r" (y) //informacja o zmiennych wyjściowych (jakie wartosci zmiennych nasz kod zmieni(output))
:"r" (x) // informajca o zmiennych wejściowych (jakie wartosci zmiennych nasz kod będzie używał(input))
// informujemy kompilator jakie rejestry zostały zniszczone
:"ax"
 
);
 
printf("x = %hd, y = %hd \n",x,y);
return 0;
}
