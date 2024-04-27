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
extern strstr
section .data
flagv: db 0
flagn: db 0
flagc: db 0
flagi: db 0
section .text
global main
main:
    mov rbp, rsp; for correct debugging 
    call readFlags  
    cmp rdi, 3
    jb .error
    mov rcx, rdi
    dec rcx 
    mov r14, rcx
    call getArgument
    mov rcx, r14
    mov r12, rax
    dec rcx
    call getArgument
    mov r13, rax ; строка которую ищем
         
    mov rdi, r12
    mov rsi, 0
    call openFile
    mov rdi, rax
    call writeInStr
    mov rdi, rax
    mov rsi, 10
    call strsplit
    mov r12, rax ; указатель на строки в которых мы ищем
    mov r14, rdx ; количество строк
    mov r15, 0   ; номер текущей строки
    mov rbx, 0   ; счётчик напечатанных строк
    
.while:
    cmp r15, r14
    je .endWhile
    mov rdi, [r12]
    mov rsi, r13
    call strstr
    add r12, 8
    inc r15
    
    movzx rcx, byte [flagv]
    cmp rcx, 0
    je .notFlagV
    cmp rax, 0
    jne .while
    inc rax
.notFlagV: 
    cmp rax, 0
    je .while 
    mov rcx, 1
    cmp byte [flagn], cl
    jne .notFlagN
    cmp ch, byte [flagc]
    jne .notFlagN
    mov rsi, rdi
    mov rdi, r15
    call printDecimal
    mov rdi, ':'
    call printChar
    mov rdi, rsi
.notFlagN:
    inc rbx
    mov rcx, 0
    cmp cl, byte [flagc]
    jne .while
    call printStr
    mov rdi, 10
    call printChar
    jmp .while
.endWhile:
    mov rcx, 0
    cmp cl, byte [flagc]
    je .end
    mov rdi, rbx
    call printDecimal
    mov rdi, 10
    call printChar
.end:
    mov rax, 60
    syscall
.error:
    mov rax, 60
    syscall
    
    
readFlags: ;input[int countArg, char* strs[]];
    push rdi
    push r12
    dec rdi
    mov rcx, 1
.while:
    cmp rcx, rdi
    je .end
    mov r12, rcx
    call getArgument
    mov rcx, r12
    inc rcx
    movzx r8, byte[rax + 1]
    cmp r8, 'v'
    jne .flagn
    mov [flagv], byte 1
.flagn:
    cmp r8, 'n'
    jne .flagc
    mov [flagn], byte 1
.flagc:
    cmp r8, 'c'
    jne .flagi
    mov [flagc], byte 1
.flagi:
    cmp r8, 'i'
    jne .while
    mov [flagi], byte 1
.end: 
    pop r12
    pop rdi
    ret

    