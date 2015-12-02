#include <stdio.h>
 
int main() {
        char *s="ABCaaabcaa";   //0
        char t[]={0};                   //1
        short int y;                    //2
       
        asm volatile (
        ".intel_syntax noprefix;"  /*  składnia intel  */
       
        //"mov ebx,1;"  //do rejestru wprowadzamy dekskryptor wyjscia
        //"mov eax,4;"  //numer wołania systemowego
       
        "mov ebx, %1;" // w rejestrze ebx mamy pierwsza litere stringu s
        "xor cx,cx;"  // wyzerowanie rejestru cx
 
       
        "petla:"
        "mov al,[ebx];" // wrzucenie do al wartości spod adresu ebx (coś jak wskaźnik)
        "sub al,0;"
        "jz koniec;"
       
        "cmp al,'a';"  //albo "cmp al,97;"
        "jnz skok;"
        "inc cx;" // zwieksza wartość spod adresu cx o 1
        "skok:"
        "inc ebx;" // przesunięcie stringu o 1 miejsce w adresie ebx
        "jmp petla;"
        "koniec:"
        "mov %2,cx;"
 
 
 
//      "int 0x80;"
       
        ".att_syntax prefix;"
        :"=r" (y) // zmienna wyjściowa
        :"r" (s)
        :"ebx","cx","al"
        );     
 
        printf("s=%s, y=%hd\n", s,y);
return 0;
}
