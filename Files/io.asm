section .text
global openFile
global closeFile
global lentghFile
global writeInStr
global main
extern alloc
;global writeInStr
;section .data
;file: db'/home/modnick/Documents/ProgramProjects/Nasm/EVM/Lab11/main.asm'
;section .text
;main:
;    mov rbp, rsp; for correct debugging
;    mov rdi, file
;    mov rsi, 0
;    call openFile
;    mov rdi, rax
;    call lentghFile
;ret
openFile: ; input:[char* fileName, int flags], output: [int fd]
    push rdi
    push rsi
    mov rax, 2
    syscall
    test rax, rax
    js .error
    pop rsi
    pop rdi
    ret
.error: 
    mov rax, 60
    xor rdi, rdi
    syscall
    
lentghFile: ;input: [int fd], output: [int length]
    push rdi
    push rsi
    mov rax, 8
    xor rsi, rsi
    mov rdx, 2
    syscall
    push rax
    mov rax, 8
    xor rdx, rdx
    syscall
    pop rax
    pop rsi
    pop rdi
    ret
    
closeFile: ;input[int fd], output:[]
    mov rax, 3
    syscall
    
writeInStr:; input[int fd], output[size_t address]
section .bss
.bufer: resb 1
section .text
    push rdi
    push rsi
    push r12
    push r15
    mov r12, rdi
    call lentghFile
    mov r15, rax
    mov rdi, rax
    call alloc
    mov rdi, r12
    mov r12, rax
    push r12
    mov rsi, .bufer
.while:
    test r15, r15
    jz .end
    xor rax, rax
    mov rdx, 1
    syscall
    mov rax, [.bufer]
    mov [r12], rax
    inc r12
    dec r15
    jmp .while
.end:
    pop rax
    pop r15
    pop r12
    pop rsi
    pop rdi
    ret
    
;%include 'allocate.asm'
    
  
     
 