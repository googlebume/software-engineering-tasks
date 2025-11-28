; --- calc-sum ---
; Author Duzya Serhii
; nasm -f win64 calc-sum.asm -o calc-sum.obj
; gcc calc-sum.obj -o calc-sum.exe

section .data
    fmt_prompt db "Enter n: ", 0
    fmt_in db "%d", 0
    fmt_out db "Sum = %d", 10, 0
    n dd 0
    sum dd 0

section .text
    global main
    extern printf
    extern scanf

main:
    sub rsp, 40

    lea rcx, [rel fmt_prompt]
    xor eax, eax
    call printf

    lea rcx, [rel fmt_in]
    lea rdx, [rel n]
    xor eax, eax
    call scanf

    ; Обчислити суму
    mov ecx, dword [rel n]
    test ecx, ecx
    jle skip_sum
    
    xor eax, eax
    xor ebx, ebx

sum_loop:
    inc ebx
    add eax, ebx
    loop sum_loop

skip_sum:
    mov [rel sum], eax

    lea rcx, [rel fmt_out]
    mov edx, eax
    xor eax, eax
    call printf

    add rsp, 40  ;
    xor eax, eax ;
    ret