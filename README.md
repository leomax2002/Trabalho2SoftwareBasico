# Trabalho2SoftwareBasico
Repositório para o Desenvolvimento do Trabalho 2 da Disciplina de Software Básico

Todo o código e executável está presente na pasta implementação.

## Montagem

Para cada arquivo .asm:

```bash
nasm -f elf -o <arquivo>.o <arquivo>.asm
```

## Ligação

Passar como argumento todos os arquivos objetos .o:
```bash
ld -m elf_i386 -o calculadora <arquivos>
```

## Makefile

```bash
make clean
make all
```
