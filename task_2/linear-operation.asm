; linear-operation.asm
; f = (12*z - 5*y) / (3*x + 2) - 5*z

global main
extern printf, scanf

section .data
    fmt_in   db "Input x y z: ",0
    fmt_scan db "%d %d %d",0
    fmt_out  db "f = %d",10,0

    x dd 0
    y dd 0
    z dd 0
    f dd 0

section .text
main:
    sub rsp, 40              ; вирівнювання стеку (Win64 ABI)

    ; --- Вивести запит ---
    lea rcx, [rel fmt_in]
    call printf

    ; --- Зчитати x, y, z ---
    lea rcx, [rel fmt_scan]
    lea rdx, [rel x]
    lea r8,  [rel y]
    lea r9,  [rel z]
    call scanf

    ; --- num = 12*z - 5*y ---
    mov eax, [rel z]
    imul eax, 12
    mov ebx, eax

    mov eax, [rel y]
    imul eax, 5
    sub ebx, eax

    ; --- den = 3*x + 2 ---
    mov eax, [rel x]
    imul eax, 3
    add eax, 2
    mov ecx, eax

    ; --- quot = num / den ---
    mov eax, ebx
    cdq
    idiv ecx
    mov esi, eax

    ; --- f = quot - 5*z ---
    mov eax, [rel z]
    imul eax, 5
    sub esi, eax

    mov [rel f], esi

    ; --- Вивід результату ---
    lea rcx, [rel fmt_out]
    mov edx, esi
    call printf

    add rsp, 40
    xor eax, eax
    ret
