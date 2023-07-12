section .text

    global multiplicacao16
    global multiplicacao32
    
    extern read_num_16
    extern read_num_32

    extern print_num_16
    extern print_num_32

%define local1 dword [ebp-4]
%define local2 dword [ebp-8]

%define local1_16 word [ebp-4]
%define local2_16 word [ebp-6]

multiplicacao16:
    enter 4, 0 ; 2 variaveis locais

    ;le os numeros
    call read_num_16
    mov local1_16,ax

    call read_num_16
    mov local2_16,ax

    mov ax, local1_16
    imul local2_16
    ;verifica overflow
    cmp dx, 0x0000
    je .show_result16

    cmp dx, 0xFFFF
    je .show_result16

    mov word [ebp + 8], 1
    jmp .next_instr16

    ;imprime um numero
    .show_result16:
    push ax
    call print_num_16

    .next_instr16:
    leave
    ret

multiplicacao32:
    enter 8, 0 ; 2 variaveis locais

    ; lê os numeros
    call read_num_32
    mov local1, eax

    call read_num_32
    mov local2, eax
    ; multiplica o número
    mov eax, local1
    imul local2
    ; verifica Overflow
    cmp edx,0xFFFFFFFF
    je .show_result

    cmp edx, 0x00000000
    je .show_result

    mov dword [ebp+8], 1
    jmp .next_instr
    .show_result:
    ; imprime um numero
    push eax
    call print_num_32
    .next_instr:
    leave
    ret