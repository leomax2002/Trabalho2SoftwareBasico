section .text

    global subtracao16
    global subtracao32
    
    extern read_num_16
    extern read_num_32

    extern print_num_16
    extern print_num_32

subtracao16:
    enter 0, 0
    ; lê um numero
    call read_num_16

    ; imprime um numero
    push ax
    call print_num_16

    leave
    ret

subtracao32:
    enter 0, 0
    ; lê um numero
    call read_num_32

    ; imprime um numero
    push eax
    call print_num_32

    leave
    ret