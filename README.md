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
Está disponível também um Makefile que permite, respectivamente, limpar os arquivos e compilar e ligá-los a partir dos seguintes comandos:
```bash
make clean
make all
```
## Sistema Operacional Utilizado

O Programa foi desenvolvido e testado utilizando o Sistema Operacional Ubuntu 22.04 via WSL (Windows Subsystem for Linux) em Windows 10 e também em instalação própria no Computador Pessoal.
## Autores

200022172 - Leonardo Maximo Silva

200028880 - Wallace Ben Teng Lin Wu
