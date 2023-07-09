section .text

    global subtracao16
    global subtracao32
    
    extern read_num_32
    extern print_num

%define local1 dword [ebp+8]
%define local2 dword [ebp+12]

subtracao16:
    enter 0, 0
    ; lê um numero
    call read_num_32

    ; imprime um numero
    push eax
    call print_num

    leave
    ret

subtracao32:
    enter 0, 0
    ; lê um numero
    call read_num_32

    ; imprime um numero
    push eax
    call print_num

    leave
    ret