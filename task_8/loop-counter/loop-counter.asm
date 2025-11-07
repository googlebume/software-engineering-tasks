; --- loop-counter ---
; Author Duzya Serhii
; Програма виведення чисел від 1 до 10 з використанням JMP
; nasm -f win64 loop-counter.asm -o loop-counter.obj
; gcc loop-counter.obj -o loop-counter.exe

section .data
    fmt_number db "Number: %d", 10, 0
    fmt_done db "Loop finished!", 10, 0
    
    counter dd 1

section .text
    global main
    extern printf

main:
    sub rsp, 40

loop_start:
    mov edx, dword [rel counter]
    lea rcx, [rel fmt_number]
    xor eax, eax
    call printf

    mov eax, dword [rel counter]
    inc eax
    mov dword [rel counter], eax

    cmp eax, 11
    jl loop_start

    lea rcx, [rel fmt_done]
    xor eax, eax
    call printf

    add rsp, 40
    xor eax, eax
    ret