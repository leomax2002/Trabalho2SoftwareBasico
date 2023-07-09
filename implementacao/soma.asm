section .text

    global soma16
    global soma32
    
    extern read_num_16
    extern read_num_32

    extern print_num_16
    extern print_num_32

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
    enter 0, 0
    ; lê um numero
    call read_num_32

    ; imprime um numero
    push eax
    call print_num_32

    leave
    ret