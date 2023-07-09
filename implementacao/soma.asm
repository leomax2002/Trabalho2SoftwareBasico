section .text

    global soma16
    global soma32
    
    extern read_num_32
    extern print_num

%define local1 dword [ebp+8]
%define local2 dword [ebp+12]

soma16:
    enter 0, 0
    ; lê um numero
    call read_num_32

    ; imprime um numero
    push eax
    call print_num

    leave
    ret

soma32:
    enter 0, 0
    ; lê um numero
    call read_num_32

    ; imprime um numero
    push eax
    call print_num

    leave
    ret