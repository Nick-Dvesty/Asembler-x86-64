section .text
extern openFile
extern printChar
extern printDecimal
extern writeInStr
extern strcount
extern getArgument
section .text
global main
main:
    mov rbp, rsp; for correct debugging
    mov r12, rsi
    mov rcx, 1
    call getArgument
    ;mov rax, rsi
    ;mov rdi, [rax + 8]
    mov rdi, rax
    mov rsi, 0
    call openFile
    mov rdi, rax
    call writeInStr
    mov rdi, rax
    mov rsi, 10
    call strcount
    mov rdi, rax
    call printDecimal
    mov rdi, 10
    call printChar
    mov rax, 60
    syscall
    pop rsi 