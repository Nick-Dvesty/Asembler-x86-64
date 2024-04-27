section .text
extern openFile
extern printChar
extern printStr
extern printDecimal
extern writeInStr
extern strcount
extern getArgument
extern strsplit
extern strint
extern printRepChars
section .text
global main
main:
    mov rbp, rsp; for correct debugging
    mov r12, rsi
    mov rcx, 1
    call getArgument
    mov r12, rax 
    mov rcx, 2
    call getArgument
    push rax
    mov rdi, r12
    mov rsi, 0
    call openFile
    mov rdi, rax
    call writeInStr
    mov rdi, rax
    mov rsi, 10
    call strsplit
    mov r14, rax ; указатель на строку
    mov rbx, rdx ; количество строк
    inc rbx
    mov rdi, rbx
    
    call sizeInt
    mov r15, 1 ; номер строки
    mov r12, rax ;количество отступов
    mov r13, 10 ; число с которым будем сравнивать для уменьшения отступа
   
    pop rdi
    cmp rdi, 0
    je .while 
    call strint
    cmp rax, rbx
    jge .end
    mov r15, rbx
    sub r15, rax
    mov r8, rax
    mov rcx, 8
    mov r9, rbx
    sub r9, rax
    sub r9, 1
    mov rax, r9
    mul rcx
    add r14, rax
    mov rdi, r8
    call sizeInt
    sub r12, rax
    mov rcx, 10
    mul rcx
    mov r13, rax
.while:  
    cmp r15, rbx
    je .end
    cmp r15, r13
    jne .general
    dec r12
    mov rax, 10
    mul r13
    mov r13, rax
.general:
    mov rdi, ' '
    mov rsi, r12
    call printRepChars
    mov rdi, r15
    call printDecimal
    mov rdi, ' '
    mov rsi, 2
    call printRepChars
    mov rdi, r14
    mov rdi, [rdi]
    call printStr
    add r14, 8 
    mov rdi, 10
    call printChar
    inc r15
    jmp .while
.end:
   
    mov rax, 60
    syscall
    
sizeInt: ;input[int number]; output[int digit]
    push rdi
    mov rax, rdi
    mov rcx, 0
    mov r8, 10
.while:
    cmp rax, 0
    je .end
    mov rdx, 0
    div r8
    inc rcx
    jmp .while
.end:
    mov rax, rcx    
    pop rdi
    ret

    