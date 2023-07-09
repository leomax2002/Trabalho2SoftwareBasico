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
    precisao resb 4 ; num + CR + LF + \0
    operacao resb 4

    numero_str resb 16 ; remove afterwards ?

section .text

    global _start
    global read_num
    
    extern soma16
    extern soma32

%define param1 dword [ebp+8]
%define param2 dword [ebp+12]

_start:
    ; imprime "Bem-vindo. Digite seu nome:"
    push msg1
    push msg1_sz
    call print_msg

    ; lê o nome
    push usuario
    push 16
    call read_msg

    ; imprime "Hola, <nome>, bem-vindo ao programa de CALC IA-32"
    push msg2
    push msg2_sz
    call print_msg

    push usuario
    push 16
    call print_msg

    push msg3
    push msg3_sz
    call print_msg

    ; imprime "Vai trabalhar com 16 ou 32 bits (digite 0 para 16, e 1 para 32):"
    push msg4
    push msg4_sz
    call print_msg

    ; lê precisao
    push precisao
    push 4
    call read_msg

    ; imprime o menu
    call print_menu

    ; lê a operação
    push operacao
    push 4
    call read_msg

    ; lê um numero
    call read_num

    ; imprime um numero
    push eax
    call print_num

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
    mov ecx, param2
    mov edx, param1
    int 80h

    leave
    ret 8

read_msg: 
    ; está lendo o \n no fim do input :-(
    ; utilizar o CTRL-D por enquanto
    enter 0, 0

    mov eax, 3
    mov ebx, 0
    mov ecx, param2
    mov edx, param1
    int 80h

    leave
    ret 8

; converte o str de numero_str em int em EAX (unsigned)
read_num:
    enter 0, 0

    mov eax, 3
    mov ebx, 0
    mov ecx, numero_str
    mov edx, 16
    int 80h

    mov esi, numero_str
    mov eax, 0

    .next_digit:
    movzx ebx, byte [esi]
    sub ebx, '0'
    cmp bl, 9
    ja .not_digit

    imul eax, 10
    add eax, ebx
    inc esi
    jmp .next_digit

    .not_digit:
    leave
    ret

; converte o int em str e imprime (unsigned)
print_num:
    enter 0, 0
    
    mov eax, param1 ; dividend and quotient
    sub esp, 16 ; allocate space 16B
    mov ecx, 10 ; divisor
    mov ebx, 16 ; string size 

    sub ebx, 1
    mov [esp+ebx], byte 0 ; '\0' null terminator
    sub ebx, 1
    mov [esp+ebx], byte 0ah ; LF
    sub ebx, 1
    mov [esp+ebx], byte 0dh ; CR

    .prev_digit:
    xor edx, edx ; edx stores the remainder of eax/ecx
    div ecx
    add dl, '0'
    sub ebx, 1
    mov [esp+ebx], dl
    test eax, eax 
    jnz .prev_digit

    mov eax, 4
    mov ebx, 1
    lea ecx, [esp+ebx]
    mov edx, 16
    int 80h

    add esp, 16 ; restore stack

    leave
    ret 4 ; 1 parameter