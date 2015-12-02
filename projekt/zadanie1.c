     #include <stdio.h>
    int main() {
    char *x = "aaa b ab cccc c";
    char bufor[4];
     
    asm volatile(
    ".intel_syntax noprefix;"
    "mov eax,%0;"
    "push eax;"
    "mov eax,%1;"
    "push eax;"
    "xor eax,eax;" // wyzerowanie rejestru eax
    "call zadanie1;"
    "jmp wyjscie;"
    "zadanie1:"
     
    "push ebp;"
    "mov ebp, esp;"
    "push eax;"
    "push ebx;"
    "push ecx;"
    "push edx;"
    "push edi;" //destination index
    "push esi;" //source index
    "mov esi, [ebp+12];" // zapis x
    "mov edi, [ebp+8];" //zapis adresu bufora
    "mov ecx,0;" // 'i" z C
    "mov edx,0;" // liczba wyrazow
    "mov ebx,0;" //czy wykryto spacje (c)
     
    "glownapetla:"
    "mov al, [esi+ecx];"
    "cmp ecx,0;"
    "jne dalej;"
    "cmp al, ' ';"
    "je dalej;"
    // pierwszy if z programu w c
    "add edx,1;"
    "jmp koniecpetli;"
     
     
     
    "dalej:"
    "cmp al, ' ';"
    "jne dalej2;"
    "mov ebx,1;"
    "jmp koniecpetli;"
     
     
    "dalej2:"
    "cmp ebx,0;"
    "je koniecpetli;"
    "cmp al, ' ';"
    "je koniecpetli;"
    "add edx,1;"
    "mov ebx,0;"
     
    "koniecpetli:"
    "add ecx,1;"
    "mov al,[esi+ecx];"
    "cmp al,0;" //porownujemy czy nie jest koncem lanucha
    "jne glownapetla;"
    //w edx jest liczba slow
     
    "mov eax,edx;"
    "mov ebx,10;"
    "mov ecx,2;"
     
    "zamianaascii:"
    "mov edx,0;"
    "div ebx;"//dzielenie przez ebx, reszta w edx(9), wynik w eax
    "add dl, 0x30;" //tworzenie ASCII
    "mov [edi+ecx], dl;"
    "dec ecx;"
    "cmp ecx,-1;"
    "jne zamianaascii;"
     
    "mov eax,4;"
    "mov ebx,1;"
    "mov ecx,edi;"
    "mov edx,3;"
    "int 0x80;"
     
    "pop esi;"
    "pop edi;"
    "pop edx;"
    "pop ecx;"
    "pop ebx;"
    "pop eax;"
    "pop ebp;"
    "ret 8;"
     
     
     
    "wyjscie:"
    ".att_syntax prefix;"
    : 
    : "r" (x), "r" (bufor) 
    : "eax"
     
    );
    return 0;
    }
     
/*

bool wykryto_spacje = false; 
for (i=0; x[i]!='\0';i++)
{ 	if (i == 0 && x[i]!= ' ')
		{ 
		 liczba wyrazow++
		}
	
	
	if (x[i] == ' ')
	{
		wykryto_spacje = true;
	}
	else 
	
	{
		if (wykryto_spacje)
		{
			if (x[i] != ' ')
			{
				wykryto_spacje = false
				liczba wyrazow++;
			}
		}
	}
}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
