section .text
global printStr
global printDecimal
global printChar
global getArgument
global printRepChars
global main
;section .text 
;main:
;    mov rbp, rsp; for correct debugging
;    mov rax, rsi
;    mov rdi, 127
;    call printDecimal
;    ret
    
printStr: ;input[char* str], output[]
section .bss
.bufer: resb 1
section .text
    push r12
    push rdi
    push rsi
    mov r12, rdi
    mov rdi, 1
    mov rsi, .bufer
.while:
    mov rax, 1
    movzx r8, byte [r12]
    mov [.bufer], r8 
    cmp r8, 0
    je .end
    mov rdx, 1
    syscall
    inc r12
    jmp .while
.end:
    pop rsi
    pop rdi
    pop r12
    ret

printDecimal: ;input[int number]
    push rdi
    push rsi
    cmp rdi, 0
    jge .positive
    mov rsi, rdi       
    mov rdi, '-'
    call printChar
    mov rdi, rsi
    xor rdi, -1
    inc rdi 
.positive:
    mov rax, 1
    mov rcx, 0
.while:
    mov rax, rdi
    xor rdx, rdx
    mov r8, 10
    div r8
    mov rdi, rax
    add rdx, 0x30
    push rdx
    mov rdi, rax
    inc rcx
    cmp rdi, 0
    jne .while
.end:
    
.while2:
    pop rdi
    mov rsi, rcx
    call printChar
    mov rcx, rsi
    loop .while2
    pop rsi
    pop rdi
    ret

printChar: ;input[char pchar], output[]
section .bss
    .bufer: resb 1
section .text
    push rdi
    push rsi
    mov rax, 1
    mov [.bufer], rdi
    mov rdi, 1
    mov rsi, .bufer
    mov rdx, 1
    syscall
    pop rsi
    pop rdi
    ret
    
printRepChars: ;inpur[char char, int count]
    push rsi
    cmp rsi, 0
    je .end
.while:
    call printChar
    cmp rsi, 0
    dec rsi
    jne .while  
.end:
    pop rsi
    ret
    
getArgument:;input[int args, size_t* argv[], int nimberArg]; output:[char* argument]
    push rdi
    push rsi
    mov rax, 0
    cmp rcx, rdi
    jae .end
    mov rax, rcx
    mov rcx, 8
    mul rcx 
    add rsi, rax
    mov rax, [rsi]
.end:
    pop rsi
    pop rdi
    ret