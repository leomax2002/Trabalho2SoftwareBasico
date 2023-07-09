section .text

    global soma16
    global soma32
    
    extern read_num_16
    extern read_num_32

    extern print_num_16
    extern print_num_32

%define local1 dword [ebp-4]
%define local2 dword [ebp-8]

soma16:
    enter 0, 0
    ; lê um numero
    call read_num_16

    ; imprime um numero
    push ax
    call print_num_16

    leave
    ret

soma32:
    enter 8, 0 ; 2 variaveis locais

    ; lê os numeros
    call read_num_32
    mov local1, eax

    call read_num_32
    mov local2, eax

    mov eax, local1
    add eax, local2

    ; imprime um numero
    push eax
    call print_num_32

    leave
    ret