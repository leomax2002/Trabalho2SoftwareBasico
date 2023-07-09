section .text

    global exponenciacao16
    global exponenciacao32
    
    extern read_num_16
    extern read_num_32

    extern print_num_16
    extern print_num_32

%define local1 dword [ebp-4]
%define local2 dword [ebp-8]

%define param1 dword [ebp+8]
%define param2 dword [ebp+12]

exponenciacao16:
    enter 0, 0
    ret

; Não suporta expoente negativo!!!
exponenciacao32:
    enter 8, 0 ; 2 variaveis locais

    ; lê os numeros
    call read_num_32
    mov local1, eax

    call read_num_32
    mov local2, eax

    push local2
    push local1
    call fexp32

    ; imprime um numero
    push eax
    call print_num_32

    leave
    ret

fexp32: ; param1 = a, param2 = i
    enter 8, 0

    cmp param2, 0
    je .zero

    cmp param2, 1
    je .one

    mov eax, param2
    mov ecx, 2
    xor edx, edx
    idiv ecx
    mov local2, edx

    push eax
    push param1
    call fexp32

    mov local1, eax
    mov eax, 1

    cmp local2, 0
    je .even
    
    .odd:
    imul eax, param1
    
    .even:
    imul eax, local1
    imul eax, local1

    jmp .end

    .zero:
    mov eax, 1
    jmp .end

    .one:
    mov eax, param1

    .end:
    leave
    ret 8