//program wypsuje hello world

.intel_syntax noprefix
.text;  //segment kodu - text, segment danych - data, segment stosu - bss , żeby zrobić komentarz musi być albo nowa lini albo ; po komendzie
.global main ; //globalnym symbolem bedzie main, wyrzucamy to do outa

main:
	mov eax,offset msg ;//offset przesuniecie w ramach segmentu
	push eax
	call puts
	pop eax
	ret
	
	.data
msg:          ;//przesuniecie
	.asciz "Hello world"
