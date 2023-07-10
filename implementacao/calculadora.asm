section .data

    msg1 db "Bem-vindo. Digite seu nome:", 0xd, 0xa
    msg1_sz equ $-msg1

    msg2 db "Hola, "
    msg2_sz equ $-msg2

    msg3 db ", bem-vindo ao programa de CALC IA-32", 0xd, 0xa
    msg3_sz equ $-msg3

    msg4 db "Vai trabalhar com 16 ou 32 bits (digite 0 para 16, e 1 para 32):", 0xd, 0xa
    msg4_sz equ $-msg4

    menu0 db "ESCOLHA UMA OPCAO:", 0xd, 0xa
    menu0_sz equ $-menu0

    menu1 db "- 1: SOMA", 0xd, 0xa
    menu1_sz equ $-menu1

    menu2 db "- 2: SUBTRACAO", 0xd, 0xa
    menu2_sz equ $-menu2

    menu3 db "- 3: MULTIPLICACAO", 0xd, 0xa
    menu3_sz equ $-menu3

    menu4 db "- 4: DIVISAO", 0xd, 0xa
    menu4_sz equ $-menu4

    menu5 db "- 5: EXPONENCIACAO", 0xd, 0xa
    menu5_sz equ $-menu5

    menu6 db "- 6: MOD", 0xd, 0xa
    menu6_sz equ $-menu6

    menu7 db "- 7: SAIR", 0xd, 0xa
    menu7_sz equ $-menu7

section .bss

    usuario resb 16
    precisao resb 4 ; num + CR + LF + \0
    operacao resb 4

section .text

    global _start

    global read_num_16
    global read_num_32

    global print_num_16
    global print_num_32

    extern soma16
    extern soma32

    extern subtracao16
    extern subtracao32

    extern multiplicacao16
    extern multiplicacao32

    extern divisao16
    extern divisao32

    extern exponenciacao16
    extern exponenciacao32

    extern mod16
    extern mod32

%define param1_16 word [ebp+8]
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
    new_operation:
    call print_menu

    ; lê a operação
    push operacao
    push 4
    call read_msg

    cmp byte [operacao], '1'
    je op_add
    cmp byte [operacao], '2'
    je op_sub
    cmp byte [operacao], '3'
    je op_mul
    cmp byte [operacao], '4'
    je op_div
    cmp byte [operacao], '5'
    je op_exp
    cmp byte [operacao], '6'
    je op_mod

    ; .op_exit: syscall exit, return 0
    mov eax, 1
    mov ebx, 0
    int 80h

    continue:
    push operacao
    push 4
    call read_msg ; waits for an ENTER '\n'
    jmp new_operation

    op_add:
        cmp byte [precisao], '1'
        je .32

        call soma16
        jmp continue

        .32:
        call soma32
        jmp continue

    op_sub:
        cmp byte [precisao], '1'
        je .32

        call subtracao16
        jmp continue

        .32:
        call subtracao32
        jmp continue

    op_mul:
        cmp byte [precisao], '1'
        je .32

        call multiplicacao16
        jmp continue

        .32:
        call multiplicacao32
        jmp continue

    op_div:
        cmp byte [precisao], '1'
        je .32

        call divisao16
        jmp continue

        .32:
        call divisao32
        jmp continue

    op_exp:
        cmp byte [precisao], '1'
        je .32

        call exponenciacao16
        jmp continue

        .32:
        call exponenciacao32
        jmp continue

    op_mod:
        cmp byte [precisao], '1'
        je .32

        call mod16
        jmp continue

        .32:
        call mod32
        jmp continue

print_menu:
    enter 0, 0

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
    
    leave
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

; lê uma string da entrada e o converte em int (signed),
; retornado esse valor em complemento de 2 pelo registrador EAX
read_num_32:
    enter 0, 0
    sub esp, 16 ; allocate space 16B

    mov eax, 3
    mov ebx, 0
    mov ecx, esp
    mov edx, 16
    int 80h

    mov ecx, 0 ; offset
    mov eax, 0 ; stored value
    movzx ebx, byte [esp]; first char (can be + or -)

    cmp ebx, 43 ; '+'
    je .skip_first

    cmp ebx, 45 ; '-'
    je .skip_first

    jmp .next_digit

    .skip_first:
    add ecx, 1

    .next_digit:
    movzx ebx, byte [esp+ecx]
    sub ebx, '0'
    cmp bl, 9
    ja .not_digit

    imul eax, 10
    add eax, ebx
    add ecx, 1
    jmp .next_digit

    .not_digit:
    movzx ebx, byte [esp]
    cmp ebx, 45 ; '-'
    jne .positive

    .negative:
    xor eax, 0xffffffff ; invert
    add eax, 1 ; get 2's complement

    .positive:
    add esp, 16 ; restore stack
    leave
    ret

; Versao 16
read_num_16:
    enter 0, 0
    sub esp, 16 ; allocate space 16B

    mov eax, 3
    mov ebx, 0
    mov ecx, esp
    mov edx, 16
    int 80h

    mov ecx, 0 ; offset
    mov ax, 0 ; stored value
    movzx bx, byte [esp]; first char (can be + or -)

    cmp bx, 43 ; '+'
    je .skip_first

    cmp bx, 45 ; '-'
    je .skip_first

    jmp .next_digit

    .skip_first:
    add ecx, 1

    .next_digit:
    movzx bx, byte [esp+ecx]
    sub bx, '0'
    cmp bl, 9
    ja .not_digit

    imul ax, 10
    add ax, bx
    add ecx, 1
    jmp .next_digit

    .not_digit:
    movzx bx, byte [esp]
    cmp bx, 45 ; '-'
    jne .positive

    .negative:
    xor ax, 0xffff ; invert
    add ax, 1 ; get 2's complement

    .positive:
    add esp, 16 ; restore stack
    leave
    ret

; converte o int armazenado no parâmetro passado para a função em str (signed) e imprime
print_num_32:
    enter 0, 0
    sub esp, 16 ; allocate space 16B
    
    mov eax, param1 ; dividend and quotient
    cmp param1, 0
    jge .positive1

    xor eax, 0xffffffff
    add eax, 1

    .positive1:
    mov ecx, 10 ; divisor
    
    mov [esp+15], byte 0 ; '\0' null terminator
    mov [esp+14], byte 0xa ; LF
    mov [esp+13], byte 0xd ; CR
    mov ebx, 13 ; string starting offset

    .prev_digit:
    xor edx, edx ; edx stores the remainder of eax/ecx
    div ecx
    add dl, '0'
    sub ebx, 1
    mov [esp+ebx], dl
    test eax, eax ; while( eax > 0)
    jnz .prev_digit

    cmp param1, 0
    jge .positive2

    sub ebx, 1
    mov [esp+ebx], byte 45

    .positive2:
    mov eax, 4
    lea ecx, [esp+ebx]
    mov edx, 16
    sub edx, ebx
    mov ebx, 1
    int 80h

    add esp, 16 ; restore stack
    leave
    ret 4 ; 1 parameter

; converte o int armazenado no parâmetro passado para a função em str (signed) e imprime
print_num_16:
    enter 0, 0
    sub esp, 16 ; allocate space 16B
    
    mov ax, param1_16 ; dividend and quotient
    cmp param1_16, 0
    jge .positive1

    xor ax, 0xffff
    add ax, 1

    .positive1:
    mov cx, 10 ; divisor
    
    mov [esp+15], byte 0 ; '\0' null terminator
    mov [esp+14], byte 0xa ; LF
    mov [esp+13], byte 0xd ; CR
    mov ebx, 13 ; string starting offset

    .prev_digit:
    xor dx, dx ; edx stores the remainder of eax/ecx
    div cx
    add dl, '0'
    sub ebx, 1
    mov [esp+ebx], dl
    test ax, ax ; while( eax > 0)
    jnz .prev_digit

    cmp param1_16, 0
    jge .positive2

    sub ebx, 1
    mov [esp+ebx], byte 45

    .positive2:
    mov eax, 4
    lea ecx, [esp+ebx]
    mov edx, 16
    sub edx, ebx
    mov ebx, 1
    int 80h

    add esp, 16 ; restore stack
    leave
    ret 4 ; 1 parameter