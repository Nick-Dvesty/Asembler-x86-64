section .text
extern openFile
extern lentghFile
extern printChar
extern printStr
extern printDecimal
extern writeInStr
section .text
global main
main:
    mov rbp, rsp; for correct debugging
    mov r12, rsi
    mov rax, rsi
    mov rdi, [rax + 8]
    mov rsi, 0
    call openFile
    mov rdi, rax
    mov rbx, rax
    call lentghFile
    mov rsi, rax
    push rax
    mov rdi, r12
    mov rdi, [rdi + 8]
    call printStr
    mov rdi, ' '
    call printChar
    mov rdi, rsi
    call printDecimal
    mov rdi, 10
    call printChar
    mov rdi, rbx
    call writeInStr
    mov rdi, rax
    mov rax, 60
    syscall
        pop rsi 
    
; %include '../Files/io.asm'
 ;%include '../Files/ioConsole.asm'