; --- compare-numbers ---
; Author Duzya Serhii
; Програма порівняння двох чисел
; nasm -f win64 compare-numbers.asm -o compare-numbers.obj
; gcc compare-numbers.obj -o compare-numbers.exe

section .data
    fmt_prompt1 db "Enter first number: ", 0
    fmt_prompt2 db "Enter second number: ", 0
    fmt_scan db "%d", 0
    fmt_equal db "Numbers are equal", 10, 0
    fmt_not_equal db "Numbers are not equal", 10, 0
    
    num1 dd 0
    num2 dd 0

section .text
    global main
    extern printf
    extern scanf

main:
    sub rsp, 40

    lea rcx, [rel fmt_prompt1]
    xor eax, eax
    call printf

    lea rcx, [rel fmt_scan]
    lea rdx, [rel num1]
    xor eax, eax
    call scanf

    lea rcx, [rel fmt_prompt2]
    xor eax, eax
    call printf

    lea rcx, [rel fmt_scan]
    lea rdx, [rel num2]
    xor eax, eax
    call scanf

    mov eax, dword [rel num1]
    mov ebx, dword [rel num2]
    cmp eax, ebx
    je equal

not_equal:
    lea rcx, [rel fmt_not_equal]
    xor eax, eax
    call printf
    jmp end_program

equal:
    lea rcx, [rel fmt_equal]
    xor eax, eax
    call printf

end_program:
    add rsp, 40
    xor eax, eax
    ret