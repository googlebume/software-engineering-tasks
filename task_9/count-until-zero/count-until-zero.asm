; --- count-until-zero ---
; Author Duzya Serhii
; Програма підрахунку кількості введених чисел до введення 0
; nasm -f win64 count-until-zero.asm -o count-until-zero.obj
; gcc count-until-zero.obj -o count-until-zero.exe

section .data
    prompt db "Enter number (0 to stop): ", 0
    result_msg db "Count: %d", 0xD, 0xA, 0
    format_in db "%d", 0

section .bss
    number resd 1
    count resd 1

section .text
    global main
    extern printf
    extern scanf

main:
    push rbp
    mov rbp, rsp
    sub rsp, 48

    mov dword [rel count], 0

input_loop:
    lea rcx, [rel prompt]
    call printf

    lea rcx, [rel format_in]
    lea rdx, [rel number]
    call scanf

    mov eax, [rel number]
    cmp eax, 0
    je end_loop

    inc dword [rel count]

    jmp input_loop

end_loop:
    lea rcx, [rel result_msg]
    mov edx, [rel count]
    call printf

    xor rax, rax
    add rsp, 48
    pop rbp
    ret