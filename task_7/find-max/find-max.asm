; --- find-max ---
; Author Duzya Serhii
; Програма пошуку максимального числа в масиві
; nasm -f win64 find-max.asm -o find-max.obj
; gcc find-max.obj -o find-max.exe

section .data
    fmt_prompt db "Enter array size (1-20): ", 0
    fmt_input db "Enter element %d: ", 0
    fmt_scan db "%d", 0
    fmt_result db "Maximum value: %d", 10, 0
    fmt_position db "Position: %d", 10, 0
    
    array_size dd 0
    max_value dd 0
    max_pos dd 0
    current_num dd 0

section .bss
    array resd 20

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
    lea rdx, [rel array_size]
    xor eax, eax
    call scanf

    mov ecx, dword [rel array_size]
    test ecx, ecx
    jle end_program
    cmp ecx, 20
    jg end_program

    xor ebx, ebx
    
input_loop:
    lea rcx, [rel fmt_input]
    lea edx, [ebx + 1]
    xor eax, eax
    call printf

    lea rcx, [rel fmt_scan]
    lea rdx, [rel current_num]
    xor eax, eax
    call scanf

    mov eax, dword [rel current_num]
    lea rdi, [rel array]
    mov [rdi + rbx*4], eax

    inc ebx
    cmp ebx, dword [rel array_size]
    jl input_loop

    lea rsi, [rel array]
    mov eax, [rsi]
    mov dword [rel max_value], eax
    mov dword [rel max_pos], 0
    
    mov ecx, dword [rel array_size]
    dec ecx
    test ecx, ecx
    jle print_result
    
    xor ebx, ebx

find_max_loop:
    inc ebx
    mov eax, [rsi + rbx*4]
    cmp eax, dword [rel max_value]
    jle continue_loop
    
    mov dword [rel max_value], eax
    mov dword [rel max_pos], ebx

continue_loop:
    loop find_max_loop

print_result:
    lea rcx, [rel fmt_result]
    mov edx, dword [rel max_value]
    xor eax, eax
    call printf

    lea rcx, [rel fmt_position]
    mov edx, dword [rel max_pos]
    inc edx
    xor eax, eax
    call printf

end_program:
    add rsp, 40
    xor eax, eax
    ret