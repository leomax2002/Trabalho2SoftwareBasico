section .text

    global mod16
    global mod32
    
    extern read_num_16
    extern read_num_32

    extern print_num_16
    extern print_num_32

%define local1 dword [ebp-4]
%define local2 dword [ebp-8]

mod16:
    enter 0, 0
    ret

mod32:
    enter 8, 0 ; 2 variaveis locais

    ; lê os numeros
    call read_num_32
    mov local1, eax

    call read_num_32
    mov local2, eax

    mov eax, local1
    mov ecx, local2
    xor edx, edx
    idiv ecx

    ; imprime um numero
    push edx
    call print_num_32

    leave
    ret