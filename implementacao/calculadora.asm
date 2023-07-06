section .data

    msg1 db "Bem-vindo. Digite seu nome:", 0dh, 0ah
    msg1_sz equ $-msg1

    msg2 db "Hola, "
    msg2_sz equ $-msg2

    msg3 db ", bem-vindo ao programa de CALC IA-32", 0dh, 0ah
    msg3_sz equ $-msg3

    msg4 db "Vai trabalhar com 16 ou 32 bits (digite 0 para 16, e 1 para 32):", 0dh, 0ah
    msg4_sz equ $-msg4

    menu db "ESCOLHA UMA OPCAO:", 0dh, 0ah, "- 1: SOMA", 0dh, 0ah, "- 2: SUBTRACAO", 0dh, 0ah, "- 3: MULTIPLICACAO", 0dh, 0ah, "- 4: DIVISAO", 0dh, 0ah, "- 5: EXPONENCIACAO", 0dh, 0ah, "- 6: MOD", 0dh, 0ah, "- 7: SAIR", 0dh, 0ah
    menu_sz equ $-menu

section .bss

    usuario resb 16
    precisao resb 1
    operacao resb 1

section .text

    global _start

_start:
    push msg1
    push msg1_sz
    call print_msg

    push usuario
    push 16
    call read_msg

    push msg2
    push msg2_sz
    call print_msg

    push usuario
    push 16
    call print_msg

    push msg3
    push msg3_sz
    call print_msg

    push msg4
    push msg4_sz
    call print_msg

    push precisao
    push 1
    call read_msg

    push menu
    push menu_sz
    call print_msg

    push operacao
    push 1
    call read_msg

    mov eax, 1
    mov ebx, 0
    int 80h

print_msg:
    push ebp
    mov ebp, esp

    mov eax, 4
    mov ebx, 1
    mov ecx, [ebp+12]
    mov edx, [ebp+8]
    int 80h

    pop ebp
    ret 8

read_msg: 
    ; está lendo o \n no fim do input :-(
    ; utilizar o CTRL-D por enquanto
    push ebp
    mov ebp, esp

    mov eax, 3
    mov ebx, 0
    mov ecx, [ebp+12]
    mov edx, [ebp+8]
    int 80h

    pop ebp
    ret 8