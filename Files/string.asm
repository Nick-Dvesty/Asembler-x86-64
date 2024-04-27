section .text
global strlen
global strchr
global strcount
global strint
global strsplit
global strstr
extern printDecimal
extern printChar
extern printStr
extern alloc

;section .data
;file: db "hello World!!!"
;section .text
;global main
;main:
    mov rbp, rsp; for correct debugging
;    mov rbp, rsp; for correct debugging
;    mov rdi, file
;    mov rsi, 'o'
;    call strchr
;    ret
strlen: ;input[char* str], output[int size]
    push rdi
    mov rax, 0
    mov rcx, -1
    repne scasb
    jz .found            
    mov rdi, -1        
    jmp .exit
.found:          
    pop rdx    
    sub rdi, rdx   
    mov rax, rdi
    mov rdi, rdx
    ret          
.exit:
    mov rax, 60
    syscall

strchr: ;input[char* str, char fchar], output[size_t position]
    push r12
    push rsi
    push rdi
    call strlen
    mov r12, rax
    mov rcx, rax
    mov rax, rsi
    repne scasb 
    pop rdi
    mov rax, rcx
    test rax, rax
    jz .exit
    sub r12, rax
    sub r12, 1
    mov rax, r12
    add rax, rdi
.exit:
    pop rsi
    pop r12
    ret  

strcount: ;input[char* str, char fchar], output[int count]
    push rbx
    push rdi
    mov rbx, 0
.while:
    cmp rdi, 1
    je .end
    call strchr
    mov rdi, rax
    inc rdi
    inc rbx
    jmp .while
.end:
    sub rbx, 1
    mov rax, rbx
    pop rdi
    pop rbx
    ret
    
strint:;input[char* str], output[int number]
    push r15
    push rdi
    push rsi
    xor r15, r15
    movzx rdx, byte [rdi]
    cmp rdx , '-'
    jne .positive
    mov r15, 1
    add rdi, 1
.positive:
    mov rcx, 0
    mov rax, 0
    mov rsi, 10
.while:
    movzx rcx, byte [rdi]
    cmp rcx, 0
    je .general
    cmp rcx, '0'
    jb .error
    cmp rcx, '9'
    ja .error
    sub rcx, 48
    mul rsi
    jo .error
    add rax, rcx
    jo .error     
    inc rdi
    jmp .while
.general:
    cmp r15, 1
    jne .end
    xor r15, -1
    add r15, 1
.end:
    pop rsi
    pop rdi
    pop r15
    ret 
.error:
    mov rax, 60
    xor rdi, rdi
    syscall

strsplit: ;input[char* str, char spltchar]; output[char* strings[], size_t lenght]
    push rdi
    push rsi
    push rbx
    mov rbx, 0
    push rdi
.while:
    call strchr
    cmp rax, 0
    je .end
    mov byte [rax], 0
    inc rax
    push rax
    mov rdi, rax
    inc rbx
    jmp .while
.end:
    inc rbx
    mov rdi, rbx
    call alloc 
    mov rcx, rbx
    mov r8, rax
    mov rax, 8
    mul rcx
    add rax, r8
    mov rdi, rbx
    add rax, 8
.while2:
    pop rdx
    mov [rax], rdx
    sub rax, 8
    loop .while2
    add rax, 8
.end2:
    mov rdx, rdi
    pop rbx
    pop rsi
    pop rdi
    ret
        
strstr:;input[char* str, char* fstr, flag ignoreRegistr]
    push rdi
    push rsi
    push r12
    push r13
    mov r12, rdi ;храним ссылку на искомое слово
    mov rdi, rsi
    call strlen
    dec rax
    mov rdi, r12
    mov r12, rsi
    mov r13, rax  ;храним количество символов в искомом слове
    movzx rsi, byte [rsi]
.while:
    call strchr
    test rax, rax
    jz .end
    mov rdi, rax
    inc rdi
    mov rcx, r13
    mov rdx, r12
.for:
    movzx r8, byte[rdx]
    movzx r9, byte[rax]
    cmp rbx, 0
    jne notFlag
notFlag:    
    cmp r8, r9
    jne .while
    inc rdx
    inc rax
    loop .for
    dec rdi
    mov rax, rdi
.end:
    pop r13
    pop r12
    pop rsi
    pop rdi
    ret
    
upRegistr: ;input[char* chr]; output[]
    cmp rdi, 'a'
    jb .end
    cmp rdi, 'z'
    ja .end
    add rdi, 32
.end:
    ret
    
DownRegistr: ;input[char* chr]; output[]
    cmp rdi, 'A'
    jb .end
    cmp rdi, 'Z'
    ja .end
    sub rdi, 32
.end:
    ret