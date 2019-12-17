msg: db "Hello World", 0x0a

global _main

_main:
    mov rax, 0x2000004
    mov rdi, 1
    mov rsi, msg
    mov rdx, 12
    syscall
    ret

    mov rax, 0x2000001
    mov rdi, 0
    syscall
    ret