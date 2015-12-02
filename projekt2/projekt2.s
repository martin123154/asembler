	.intel_syntax noprefix
	.global _start

						//deklaracja zmiennych stałych
	.data
zmienna1:
	.ascii "podano za malo danych\n"
	.equ	dlugosc1, $-zmienna1
zmienna2:
	.ascii "podane liczby sa nieprawidlowe\n"
	.equ	dlugosc2, $-zmienna2
zmienna3:
	.ascii "podano nieprawidlowy element ciagu\n"
	.equ	dlugosc3, $-zmienna3
zmienna4:
	.ascii "podana liczba ciagu jest  wieksza niz 255\n"
	.equ	dlugosc4, $-zmienna4
zmienna5:
	.ascii "wynik: "
	.equ	dlugosc5, $-zmienna5

						//deklaracja zmiennych nieinicjalizowanych
	.bss
zmienna6: 
	.skip 300 ;// bedziemy wpisywac jakies wartosci, deklarowanie jakby tablicy tym skipem
zmienna7: 
	.skip 300 ;// 300 bajtow na przechowanie zmiennej
zmienna8:
	.skip 300
zmienna9:
	.skip 300

	.text
_start:


	jmp 	etykieta5
						//procedura sprawdzajaca czy uzytkownik wpisal poprawnie n
etykieta1:
	mov	bh, 48 ;// bh=48
etykieta2:
	cmp	[eax], bh  ;// spr czy n to liczba 
	jz	etykieta3
	inc	bh
	cmp	bh, 58 ;// spr czy kod ascii wprowadzonej liczby jest mniejszy od :
	jnz	etykieta2
etykieta3:
	cmp	bh, 58
	jnz	etykieta4
	inc 	bl
etykieta4:
	inc	eax
	cmp	[eax], byte ptr 0
	jnz 	etykieta1
	ret
etykieta5:

	jmp 	etykieta109
						//procedura sprawdzajaca czy uzytkownik wpisal poprawnie liczby
						//czy cyfra miesci sie w przedziale 0-7 i zliczamy ile ma cyfr
etykieta110:
	mov	bh, 48 ;//bh=48
etykieta111:
	cmp	[eax], bh ;// spr czy bh jest rowne pierwszemu el eax, czyli spr czy cyfra miesci sie w przedziale 0-7 i zliczamy ile ma cyfr
	jz	etykieta112 ;// jesli 0 to do etykiety
	inc	bh  ;// jesli nie to zwiekszamy bh czyli bd miec 1 chara
	cmp	bh, 56  ;//spr czy nie dojechalem do konca ciagu
	jnz	etykieta111
etykieta112:
	cmp	bh, 56 ;//spr czy sie zgadza 
	jnz	etykieta113 ;// jesli nie to zwiekszamy bl
	inc 	bl
etykieta113:
	inc	eax
	cmp	[eax], byte ptr 0 ;// spr czy to nie koniec
	jnz 	etykieta110
	ret
etykieta109:

	jmp 	etykieta10
						//procedura odwracajaca wynik i usuwajaca zera ktore moga pojawic sie na poczatku wyniku
odwracanie:
	xor 	ecx, ecx
etykieta6:
	inc 	ebx  ;// tu wskaznik na pocz , a tam na koncu
	inc 	ecx ;// liczymy dlugosc liczby
	cmp 	[ebx], byte ptr 0  ;// usuwam zera ktore moga pojawic sie na koncu
	jnz 	etykieta6
etykieta7:
	dec	ecx ;// odemuje siobie 1 i spr czy nie jest 0
	cmp	ecx, 0
	jz	etykieta8
	mov	[ebx], byte ptr 0
	dec 	ebx
	cmp	[ebx], byte ptr 48
	jz	etykieta7
	inc	ebx
etykieta8:
	inc 	ecx  ;// bo bd uzywam ecx do czegos innego
	push 	ecx
	xor 	ecx, ecx
etykieta9:
	add 	ecx, 2
	push 	ecx
	dec 	ebx
	mov 	cl, [eax]
	mov 	ch, [ebx]
	mov 	[eax], ch
	mov 	[ebx], cl
	inc 	eax
	pop 	ecx
	cmp 	ecx, [ebp-8] ;// spr czy jest wieksza od naszej dlugosci
	jb 	etykieta9
	pop 	ecx
	ret
etykieta10:

	jmp	etykieta18
						//procedura dodajaca do siebie dwie liczby
etykieta11:
	push	ecx ;// w niej wynik , liczba1
	mov	ch, [eax]
	cmp	ch, 0
	jz	etykieta12
	sub	ch, 48	 ;//zabezpieczenie przed tym ze eax bedzie krotsze od ebx
etykieta12:
	mov	dl, [ebx]
	sub	dl, 48
	add 	dl, dh ;// slupkowe dodawanie liczb do siebie
	xor	dh, dh
	add	dl, ch
	cmp	dl, 8 ;// system 8 , przenoszenie
	jb	etykieta13
etykieta107:  ;// jesli >7
	inc 	dh
	sub 	dl, 8
	cmp	dl, 8
	jnb	etykieta107
etykieta13:  ;// jesli jest <7
	add	dl, 48	 ;// na asci	
	pop    ecx
	mov 	[ecx], dl
	inc	ecx
	inc	eax
	inc	ebx
	cmp	[ebx], byte ptr 0
	jnz	etykieta11
etykieta14:
	cmp	[eax], byte ptr 0
	jz	etykieta16
	mov	dl, [eax] ;// to samo tyle ze dodajemy przeniesienie jesli jest i do ecx zapisujemy
	sub	dl, 48
	add	dl, dh
	xor	dh, dh
	cmp	dl, 8
	jb	etykieta15
etykieta108:
	inc 	dh
	sub 	dl, 8
	cmp	dl, 8
	jnb	etykieta108
etykieta15:
	add	dl, 48
	mov	[ecx], dl
	inc	eax
	inc	ecx
	jmp	etykieta14
etykieta16:
	cmp	dh, 0
	jz	etykieta17
	add	dh, 48
	mov	[ecx], dh
etykieta17:
	ret
etykieta18:

	jmp	etykieta22
etykieta19:           ;// mnozy f1
							//procedura mnozaca dwie liczby
	mov 	dl, [ecx]  ;//dodajemy pisemnie liczbe, w dl pierwsza liczba na ktora wskazuje wskaznik
	sub 	dl, 48   ;// zeby na liczbe przekonwertowac 
	push	ecx   ;// liczba na stos
	mov	cl, dl
	add	dl, cl			
	add	dl, cl			
	add	dl, cl		
	add	dl, dh ;// przenisenie pisemne przy mnozeniu
	xor	dh, dh ;// trzeba zerowac przenieisenie
	pop	ecx 
	cmp	dl, 8 ;// spr czy liczba nie jest <8
	jb	etykieta20
	//konwersja sumy na system 8
etykieta104: ;// jesli wieksza rowna 8 to:
	sub	dl, 8
	inc	dh
	cmp	dl, 8 ;//az bedzie <8
	jnb	etykieta104
etykieta20:	
	add 	dl, 48
	mov 	[ebx], dl  ;// do ebx przepisujemy przemnozona liczbe f1
	inc	ebx
	inc	ecx
	cmp	[ecx], byte ptr 0
	jnz 	etykieta19
	cmp	dh, 0  ;// spr czy jest 0 , jesli nie to musze wpisac jeszcze do ebx dh
	jz	etykieta21
	add	dh, 48 ;// dh na char
	mov	[ebx], dh
etykieta21:
	ret
etykieta22:

	jmp	etykieta105
procedura2:
							//procedura mnozaca dwie liczby f2 mnozyymy przez 10
	mov 	dl, [ecx]
	sub 	dl, 48
	push	ecx
	mov	cl, dl
	add	dl, cl			
	add	dl, cl		
	add	dl, cl			
	add	dl, cl			
	add	dl, cl			
	add	dl, cl			
	add	dl, cl		
	add	dl, dh
	xor	dh, dh
	pop	ecx
etykieta101:
	cmp	dl, 8
	jb	etykieta102
	sub	dl, 8
	inc	dh
	cmp	dl, 8
	jnb	etykieta101
etykieta102:	
	add 	dl, 48
	mov 	[ebx], dl
	inc	ebx
	inc	ecx
	cmp	[ecx], byte ptr 0
	jnz 	procedura2
	cmp	dh, 0
	jz	etykieta103
	add	dh, 48
	mov	[ebx], dh
etykieta103:
	ret
	// poczatek programu
etykieta105:

	mov 	ebp, esp
						//sprawdzamy czy uzytkownik podal odpowiednia ilosc liczb jezeli podal za malo wypisze komunikat o bledzie
	mov	eax, [ebp+8] ;// pierwszy parament 
	cmp	eax, 0     ;// sprawdzamy czy istnieje, czy jest wpisana pierwsza liczba
	jnz	etykieta23  ;// jesli uzytkownik podal liczbe to do etykiety skok
	mov 	eax, 4  ;// kod wypisujacy blad w przypadku nie podania liczby
	mov	ebx, 1
	mov	ecx, offset zmienna1
	mov 	edx, offset dlugosc1
	int 	0x80
	mov 	eax, 1
	mov	ebx, 0
	int 	0x80
etykieta23:
	mov	eax, [ebp+12]  ;// drugi parament
	cmp	eax, 0 ;// spr czy istnieje 2 liczba
	jnz	etykieta24  ;// jesli istnieje to do etykiety
	mov 	eax, 4  ;// jesli nie to ponizej kod wypisujacy blad
	mov	ebx, 1
	mov	ecx, offset zmienna1
	mov 	edx, offset dlugosc1
	int 	0x80
	mov 	eax, 1
	mov	ebx, 0
	int 	0x80
etykieta24:
	mov	eax, [ebp+16] ; //parametr n
	cmp	eax, 0 ;// spr czy istnieje n
	jnz	etykieta25 ;// jesli istnieje n  to do etykiety
	mov 	eax, 4  ;//kod wypisujaacy blad jesli nie ma wpisanego n
	mov	ebx, 1
	mov	ecx, offset zmienna1
	mov 	edx, offset dlugosc1
	int 	0x80
	mov 	eax, 1
	mov	ebx, 0
	int 	0x80
etykieta25:

						//sprawdzamy czy liczby sa podany poprawnie
	xor	bl, bl ;// zerowanie bl, bo jest potrzebna
	mov	eax, [ebp+8] ;//eax= f1
	call	etykieta110 ;// etykieta spr czy liczba f1 jest poprawnie podana
	mov	eax, [ebp+12] ;//eax=f2
	call	etykieta110 ;// analogiczne spr f2 poprawnosc
	cmp 	bl, 0 ;// to wypisanie komunikatu jesli bl>0
	jz	etykieta26 ;// jesli bl=0 to do etykiety
	mov 	eax, 4 ;// jesli bl >0 to komunikat o bledzie
	mov	ebx, 1
	mov	ecx, offset zmienna2
	mov 	edx, offset dlugosc2
	int 	0x80
	mov 	eax, 1
	mov	ebx, 0
	int 	0x80
etykieta26:

						//sprawdzamy czy elelemt ciagu do wyliczenia jest podany poprawnie
	mov	eax, [ebp+16] ;// eax=n
	call	etykieta1
	cmp 	bl, 0
	jz	etykieta27
	mov 	eax, 4 ;// jesli bl >0 to komunikat ze n jest niepopranwe
	mov	ebx, 1
	mov	ecx, offset zmienna3
	mov 	edx, offset dlugosc3
	int 	0x80
	mov 	eax, 1
	mov	ebx, 0
	int 	0x80
etykieta27:

						//konwersacja ciagu znakow w elemencie ciagu na liczbe
	xor 	ebx, ebx; // zerowanie ebx
	mov	eax, [ebp+16] ;// eax=n
	mov	ecx, [ebp+16] ;// ecx=n
						//pomijam zera ktore uzytkownik mogl wpisac na poczatku liczby, jezeli liczba jest zerem wypisze blad
etykieta28:
	cmp	[eax], byte ptr 0 ;// porownujemy z 0 pierwszy elem. n, czy to koniec liczby 
	jnz	etykieta29 ;// jesli nie jest 0 to do etyk.
	mov 	eax, 4 ;// komunikat o bledzie jesli np. same zera
	mov	ebx, 1
	mov	ecx, offset zmienna3
	mov 	edx, offset dlugosc3
	int 	0x80
	mov 	eax, 1
	mov	ebx, 0
	int 	0x80
etykieta29:
	cmp	[eax], byte ptr 48
	jnz	etykieta30
	inc	eax
	inc	ecx
	jmp 	etykieta28

						//jezeli ilosc cyfr jest wieksza niz 3 to to wypisze blad w przeciwnym razie dokona konwersacji na liczbe
etykieta30:
	inc	ecx
	cmp	[ecx], byte ptr 0  ;// jednocyfrowa
	jz	etykieta35
	inc	ecx
	cmp	[ecx], byte ptr 0 ;// dwucyfrowa
	jz	etykieta33
	inc	ecx
	cmp	[ecx], byte ptr 0 ;// trzycyfrowa, jesli wiekszan to komunikat
	jz	etykieta31
	mov 	eax, 4 ;// komunikat o bledzie , ze n>255 lub ma 4 cyfry
	mov	ebx, 1
	mov	ecx, offset zmienna4
	mov 	edx, offset dlugosc4
	int 	0x80
	mov 	eax, 1
	mov	ebx, 0
	int 	0x80

etykieta31: ; // poczatek przepisywania n z char na liczbe
	mov	cl, [eax]
	inc 	eax
	sub	cl, 48 ;//z ascii na liczbe cyfra setek
etykieta32: ;// konwersja od setek
	add	ebx, 100 ;// na liczbe ze stringu
	dec 	cl
	cmp 	cl, 0
	jnz 	etykieta32
etykieta33: ;//dziesiatki
	mov	cl, [eax] ;// n
	inc 	eax ;// na dziesiatki wskaznik
	sub	cl, 48 ;// z asci na liczbe
	cmp 	cl, 0 ;// gdyby np bylo 102
	jz	etykieta35
etykieta34:
	add	ebx, 10
	dec 	cl
	cmp 	cl, 0
	jnz 	etykieta34
etykieta35: ;// od jednosci, spr czy jednosci nie sa 0, jesli tak to skacze do etykiety37
	mov	cl, [eax] ;// cl=n
	sub	cl, 48 ;// z ascii na liczbe
	cmp 	cl, 0
	jz	etykieta37
etykieta36: ;// przepisywanie jednosci 
	inc	ebx
	dec 	cl
	cmp 	cl, 0
	jnz 	etykieta36
etykieta37: 
						//jezeli liczba jest wieksza niz 255 wyppisze blad
	cmp 	ebx, 256 ;// nie moze byc wieksza 
	jb 	etykieta38 ;// jesli jest ok to do etykiety 
	mov 	eax, 4 ;// jesli wieksza to komunikat
	mov	ebx, 1
	mov	ecx, offset zmienna4
	mov 	edx, offset dlugosc4
	int 	0x80
	mov 	eax, 1
	mov	ebx, 0
	int 	0x80
etykieta38:
						//liczba jest ok wiec przepisujemy ja do malego rejestru
	xor	dl, dl  ;// dl=0, nasza liczba teraz w dl=n
etykieta39:
	dec	ebx
	inc 	dl
	cmp	ebx,0
	jnz	etykieta39
						//przepisuje do zmiennych obie liczby od tylu
	mov	eax, [ebp+12] ;// eax=f2
	mov	ebx, offset zmienna7 ;// ebx=tablica ilus znakow
	xor	dh, dh 
etykieta40: ;// spr ile cyfrowa jest f2
	inc 	eax
	inc	dh
	cmp	[eax], byte ptr 0
	jnz	etykieta40
	xor	ch, ch
etykieta41: 
	dec	eax ;//przesuwamy wskaznik od konca liczby do przodu
	dec	dh
	mov	cl, [eax] ;// f2 w cl
	mov	[ebx], cl ;// zapisisujemy liczbe od tylu do ebx, mamy ta liczbe od jednosci do setek
	inc	ebx
	cmp	dh, 0
	jnz	etykieta41

	mov	eax, [ebp+8] ;// to samo dla f1 
	mov	ebx, offset zmienna6 ;// tablica ilus znakow
etykieta42: ;// spr ile cyfrowa jest f1
	inc 	eax
	inc	dh
	cmp	[eax], byte ptr 0
	jnz	etykieta42
etykieta43: ;//przesuwamy wskaznik od konca liczby do przodu
	dec	eax
	dec	dh
	mov	cl, [eax]
	mov	[ebx], cl ;// zapisujemy f1 od tylu w ebx
	inc	ebx
	cmp	dh, 0
	jnz	etykieta43

						//sprawdzam czy uzytkownik podal element 1 tak wypisuje peirwszya liczba
	cmp 	dl, 1 ;// to po prostu wypisuwanie, jesli n=1 to skok to etykieta46 i wypisanie liczby f1
	jnz	etykieta44 ;//jesli n>1 to etykieta44
	jmp	etykieta46
etykieta44:
						//sprawdzam czy uzytkownik podal elelment 2 jezeli tak wypisuje druga liczbe
	dec	dl
	cmp 	dl, 1 ;// spr czy nie jest 1 , czyli czy podal 2
	jnz	etykieta45 ;// idz dlaej bo n>2
	jmp	etykieta47 ;//wypisz f2, bo n=2

						//dokonuje dodawania	odpowiednia ilosc razy z odpowiednim mnoznikiemi wypisuje wynik (w odwrotnej kolejnosci)
etykieta45:
	dec 	dl
	
	cmp	dl, 0
	jz	etykieta47
	push	edx ;// zeby nie stracic dl
	xor	dh, dh
	mov 	ecx, offset zmienna6 ;// w ecx- odworocna liczba pierwsza w niej
	mov 	ebx, offset zmienna8 ;// nic na razie, wartosc przemnozona bedzie w niej
	call	etykieta19 ;// mnozy f1 przez a 
	xor	dh, dh	
	mov 	ecx, offset zmienna7
	mov 	ebx, offset zmienna9
	call	procedura2 ;//mnozy f2 
	mov 	eax, offset zmienna8
	mov 	ebx, offset zmienna9
	mov	ecx, offset zmienna6 ;// wynik w niej bedzie 
	xor	dh, dh	
	call	etykieta11 ;// dodanie liczb
		// mamy juz sume f1 i f2
	pop	edx ;// na stos n
	dec 	dl
	cmp	dl, 0
	jz	etykieta46  ;// jesli n=0 to etykieta i wypisanie wyniku
	push	edx
	xor	dh, dh
	mov 	ecx, offset zmienna7
	mov 	ebx, offset zmienna8
	call	etykieta19 ;// mnozenie f1
	xor	dh, dh	
	mov 	ecx, offset zmienna6
	mov 	ebx, offset zmienna9
	call	procedura2 ;// mnozenie f2
	mov 	eax, offset zmienna8
	mov 	ebx, offset zmienna9
	mov	ecx, offset zmienna7
	xor	dh, dh	
	call	etykieta11 ;// dodawanie ich
	pop	edx
	jmp 	etykieta45
						//odwraca wynik i wypisuje odpowiednia liczbe
etykieta46: ;// wypisanie liczby gdy n>2
	mov 	eax, 4
	mov	ebx, 1
	mov	ecx, offset zmienna5
	mov 	edx, offset dlugosc5
	int 	0x80
	mov 	eax, offset zmienna6
	mov 	ebx, offset zmienna6
	call 	odwracanie
	mov 	eax, 4
	mov	ebx, 1 ;// wypisanie wyniku
	mov 	edx, ecx
	mov	ecx, offset zmienna6
	int 	0x80
	mov 	eax, 4
	mov	ebx, 1
	mov	[ecx], byte ptr 10
	mov 	edx, 1
	int 	0x80
	mov 	eax, 1
	mov	ebx, 0
	int 	0x80

etykieta47: ;// wypisanie f1 i f2 w przypadku gdy n =1 lub n=2
	mov 	eax, 4
	mov	ebx, 1
	mov	ecx, offset zmienna5
	mov 	edx, offset dlugosc5
	int 	0x80
	mov 	eax, offset zmienna7
	mov 	ebx, offset zmienna7
	call 	odwracanie
	mov 	eax, 4
	mov	ebx, 1
	mov 	edx, ecx
	mov	ecx, offset zmienna7
	int 	0x80
	mov 	eax, 4
	mov	ebx, 1
	mov	[ecx], byte ptr 10
	mov 	edx, 1
	int 	0x80
	mov 	eax, 1
	mov	ebx, 0
	int 	0x80

