ARQUIVOS = calculadora.o soma.o subtracao.o multiplicacao.o divisao.o mod.o expoenciacao.o

all: final

final: $(ARQUIVOS)
	ld -m elf_i386 -o calculadora $(ARQUIVOS)

%.o : %.asm
	nasm -f elf $< -o $@

clean:
	rm calculadora $(ARQUIVOS)