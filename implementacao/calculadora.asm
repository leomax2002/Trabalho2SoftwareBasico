section .data

    msg1 db "Bem-vindo. Digite seu nome:", 0dh, 0ah
    msg1_sz equ $-msg1

    msg2 db "Hola, "
    msg2_sz equ $-msg2

    msg3 db ", bem-vindo ao programa de CALC IA-32", 0dh, 0ah
    msg3_sz equ $-msg3

    msg4 db "Vai trabalhar com 16 ou 32 bits (digite 0 para 16, e 1 para 32):", 0dh, 0ah
    msg4_sz equ $-msg4

    menu0 db "ESCOLHA UMA OPCAO:", 0dh, 0ah
    menu0_sz equ $-menu0

    menu1 db "- 1: SOMA", 0dh, 0ah
    menu1_sz equ $-menu1

    menu2 db "- 2: SUBTRACAO", 0dh, 0ah
    menu2_sz equ $-menu2

    menu3 db "- 3: MULTIPLICACAO", 0dh, 0ah
    menu3_sz equ $-menu3

    menu4 db "- 4: DIVISAO", 0dh, 0ah
    menu4_sz equ $-menu4

    menu5 db "- 5: EXPONENCIACAO", 0dh, 0ah
    menu5_sz equ $-menu5

    menu6 db "- 6: MOD", 0dh, 0ah
    menu6_sz equ $-menu6

    menu7 db "- 7: SAIR", 0dh, 0ah
    menu7_sz equ $-menu7

section .bss

    usuario resb 16
    precisao resb 1
    operacao resb 1

section .text

    global _start
    global read_num
    
    extern soma16
    extern soma32


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

    call print_menu

    push operacao
    push 1
    call read_msg

    mov eax, 1
    mov ebx, 0
    int 80h

print_menu:
    push menu0
    push menu0_sz
    call print_msg

    push menu1
    push menu1_sz
    call print_msg

    push menu2
    push menu2_sz
    call print_msg

    push menu3
    push menu3_sz
    call print_msg

    push menu4
    push menu4_sz
    call print_msg

    push menu5
    push menu5_sz
    call print_msg

    push menu6
    push menu6_sz
    call print_msg

    push menu7
    push menu7_sz
    call print_msg

    ret

print_msg:
    enter 0, 0

    mov eax, 4
    mov ebx, 1
    mov ecx, [ebp+12]
    mov edx, [ebp+8]
    int 80h

    leave
    ret 8

read_msg: 
    ; está lendo o \n no fim do input :-(
    ; utilizar o CTRL-D por enquanto
    enter 0, 0

    mov eax, 3
    mov ebx, 0
    mov ecx, [ebp+12]
    mov edx, [ebp+8]
    int 80h

    leave
    ret 8

read_num:
    enter 0, 0

    mov eax, 3
    mov ebx, 0
    mov ecx, [ebp+12]
    mov edx, [ebp+8]
    int 80h

    leave
    ret 8
