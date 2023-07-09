all: final

final: calculadora.o soma.o subtracao.o
	ld -m elf_i386 -o calculadora calculadora.o soma.o subtracao.o

%.o : %.asm
	nasm -f elf $< -o $@

clean:
	rm calculadora calculadora.o soma.o subtracao.o