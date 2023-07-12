section .text

    global exponenciacao16
    global exponenciacao32
    
    extern read_num_16
    extern read_num_32

    extern print_num_16
    extern print_num_32

    extern msgOverflow
    extern msgOverflow_sz

    extern print_msg

%define local1 dword [ebp-4]
%define local2 dword [ebp-8]

%define param1 dword [ebp+8]
%define param2 dword [ebp+12]

%define local1_16 word [ebp-4]
%define local2_16 word [ebp-6]

%define param1_16 word [ebp+8]
%define param2_16 word [ebp+10]

exponenciacao16:
    enter 4, 0 ; 2 variaveis locais

    ; lê os numeros
    call read_num_32
    mov local1_16,ax

    call read_num_16
    mov local2_16,ax

    mov ax, 1
    mov cx, local2_16
    cmp cx, 0
    je .end
    .lp:
        imul local1_16
        ;Verifica Overflow
        cmp dx, 0x0000
        je .continue_loop

        cmp dx, 0xFFFF
        je .continue_loop

        mov word [ebp + 8], 1
        jmp .next_instr16

        .continue_loop:
        loop .lp


    ;push local2_16
    ;push local1_16
    ;call fexp16

    ; imprime um numero
    .end:
    push ax
    call print_num_16
    .next_instr16:
    leave
    ret

;fexp16: ;param1_16 = a, param2_16 = i
;    enter 4,0
;
;    cmp param2_16, 0
;    je .zero16
;
;    cmp param2_16, 1
;    je .one16

;    mov ax, param2_16
;    mov cx, 2
;    xor dx, dx
;    idiv cx
;    mov local2_16,dx
;
;    push ax
;    push param1_16
;    call fexp16
;
;    mov local1_16, ax
;    mov ax, 1
;
;    cmp local2_16, 0
;    je .even16
;
;    .odd16:
;    imul ax, param1_16
;
;    .even16:
;    imul ax, local1_16
;    imul ax, local1_16
;
;    jmp .end16
;
;    .zero16:
;    mov ax, 1
;    jmp .end16
;
;    .one16:
;    mov ax, param1_16
;
;    .end16:
;    leave
;    ret 4

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
    div ecx
    mov local2, edx

    push eax
    push param1
    call fexp32

    mov local1, eax
    mov eax, 1

    cmp local2, 0
    je .even
    
    .odd:
    imul param1
    cmp edx, 0x00000000
    je .even
    cmp edx, 0xFFFFFFFF
    je .even
    jmp .end_overflow
    
    .even:
    imul local1
    imul local1
    cmp edx, 0x00000000
    je .continue_fexp32
    cmp edx, 0xFFFFFFFF
    je .continue_fexp32
    jmp .end_overflow
    .continue_fexp32:
    jmp .end

    .zero:
    mov eax, 1
    jmp .end

    .one:
    mov eax, param1

    .end:
    leave
    ret 8

    .end_overflow:
    push msgOverflow
    push msgOverflow_sz
    call print_msg
    mov eax,1
    mov ebx,0
    int 0x80