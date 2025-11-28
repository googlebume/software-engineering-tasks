; --- hello-loop ---
; Author Duzya Serhii
; Програма виводу "HELLO" 5 разів з використанням безумовного переходу JMP
; nasm -f win64 hello-loop.asm -o hello-loop.obj
; gcc hello-loop.obj -o hello-loop.exe

section .data
    hello_msg db "HELLO", 0xD, 0xA, 0

section .bss
    counter resb 1

section .text
    global main
    extern printf

main:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    
    mov byte [rel counter], 0

loop_start:
    mov al, [rel counter]
    cmp al, 5
    je loop_end

    lea rcx, [rel hello_msg]
    call printf

    inc byte [rel counter]

    jmp loop_start

loop_end:
    xor rax, rax
    add rsp, 32
    pop rbp
    ret