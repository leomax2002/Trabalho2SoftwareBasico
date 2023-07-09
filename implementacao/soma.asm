section .text

    global soma16
    global soma32
    
    extern read_num
    extern print_num
    extern next_operation

soma16:
    ; lê um numero
    call read_num

    ; imprime um numero
    push eax
    call print_num

    jmp next_operation

soma32:
    ; lê um numero
    call read_num

    ; imprime um numero
    push eax
    call print_num

    jmp next_operation