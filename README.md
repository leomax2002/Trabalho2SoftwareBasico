# Trabalho2SoftwareBasico
Repositório para o Desenvolvimento do Trabalho 2 da Disciplina de Software Básico

## Montagem

```bash
nasm -f elf -o calculadora.o calculadora.asm
```

## Ligação

```bash
ld -m elf_i386 -o calculadora calculadora.o 
```
