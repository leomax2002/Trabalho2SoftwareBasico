section.data
msg_init db "Bem-vindo. Digite seu nome:"
section.code
.STARTUP
    push msg_init
    call showStr
    mov eax,1 
    mov ebx, 0
    int 80h

showStr:
        mov eax,4
        mov ebx,1
        mov ecx, msg_init
        int 80h
        ret 4