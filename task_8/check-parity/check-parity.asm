; --- check-parity ---
; Author Duzya Serhii
; Програма перевірки парності числа
; nasm -f win64 check-parity.asm -o check-parity.obj
; gcc check-parity.obj -o check-parity.exe

section .data
    fmt_prompt db "Enter a number: ", 0
    fmt_scan db "%d", 0
    fmt_even db "The number is even", 10, 0
    fmt_odd db "The number is odd", 10, 0
    
    number dd 0

section .text
    global main
    extern printf
    extern scanf

main:
    sub rsp, 40

    lea rcx, [rel fmt_prompt]
    xor eax, eax
    call printf

    lea rcx, [rel fmt_scan]
    lea rdx, [rel number]
    xor eax, eax
    call scanf

    mov eax, dword [rel number]
    test eax, 1
    jnz odd_number

even_number:
    lea rcx, [rel fmt_even]
    xor eax, eax
    call printf
    jmp end_program

odd_number:
    lea rcx, [rel fmt_odd]
    xor eax, eax
    call printf

end_program:
    add rsp, 40
    xor eax, eax
    ret