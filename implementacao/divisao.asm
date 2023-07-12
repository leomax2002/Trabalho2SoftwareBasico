section .text

    global divisao16
    global divisao32
    
    extern read_num_16
    extern read_num_32

    extern print_num_16
    extern print_num_32

%define local1 dword [ebp-4]
%define local2 dword [ebp-8]

%define local1_16 word [ebp-4]
%define local2_16 word [ebp-8]

divisao16:
    enter 4, 0 ; 2 variaveis locais
    sub eax,eax
    ;lê os números
    call read_num_16
    mov local1_16, ax
    
    call read_num_16
    mov local2_16, ax

    mov ax, local1_16
    mov cx, local2_16
    cwd
    idiv cx

    ;imprime um numero
    push eax
    call print_num_16
    
    leave
    ret

divisao32:
    enter 8, 0 ; 2 variaveis locais

    ; lê os numeros
    call read_num_32
    mov local1, eax

    call read_num_32
    mov local2, eax

    mov eax, local1
    mov ecx, local2
    cdq
    idiv ecx

    ; imprime um numero
    push eax
    call print_num_32

    leave
    ret