section .text
global alloc
alloc: ;input:[int size], output:[size_t addres]
    push rdi
.while:
    mov rcx,rdi
    and rcx, 15
    cmp rcx, 0
    je .general
    add rdi, 1
    jmp .while
.general:
    push rdi
    mov rax, 12
    xor rdi, rdi
    syscall
    pop rdi
    push rax
    add rdi, rax
    mov rax, 12
    syscall
    pop rax
    pop rdi
    ret