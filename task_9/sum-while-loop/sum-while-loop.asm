; --- sum-while-loop ---
; Author Duzya Serhii
; Програма обчислення суми чисел від 1 до N з умовою (сума <= 100)
; nasm -f win64 sum-while-loop.asm -o sum-while-loop.obj
; gcc sum-while-loop.obj -o sum-while-loop.exe

section .data
    prompt db "Enter N: ", 0
    result_msg db "Sum: %d", 0xD, 0xA, 0
    format_in db "%d", 0

section .bss
    n resd 1
    sum resd 1
    current resd 1

section .text
    global main
    extern printf
    extern scanf

main:
    push rbp
    mov rbp, rsp
    sub rsp, 48

    lea rcx, [rel prompt]
    call printf

    lea rcx, [rel format_in]
    lea rdx, [rel n]
    call scanf

    mov dword [rel sum], 0
    mov dword [rel current], 1

while_loop:
    mov eax, [rel sum]
    cmp eax, 100
    jg end_loop

    mov ebx, [rel current]
    cmp ebx, [rel n]
    jg end_loop

    add eax, ebx
    mov [rel sum], eax

    inc dword [rel current]

    jmp while_loop

end_loop:
    lea rcx, [rel result_msg]
    mov edx, [rel sum]
    call printf

    xor rax, rax
    add rsp, 48
    pop rbp
    ret