proby: skaner.c
	gcc -o skaner skaner.c

proby.c: proby.l
	flex -t skaner.l > skaner.c

clear:
	rm -f skaner.c