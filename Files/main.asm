section .text
extern openFile
extern strprint
extern writeInStr
section .data
file: db '/home/modnick/Documents/ProgramProjects/Nasm/EVM/DebugAndTrash/test'
section .text
global main
main:
    mov rbp, rsp; for correct debugging
    push rsi
    ;
    mov rax, rsi
    mov rdi, [rax + 8];
    ;
    mov rsi, 0
    call openFile
    mov r12, rax
    mov rdi, rax
    call writeInStr
    mov rdi, rax
    call strprint
    mov rax, 60
    pop rsi 
    syscall
    
    
