; ----------------------------------------------------------
; Програма: Обчислення F(x,y,z,b)
; Автор: Сергій Дузя (виправлено для x86-64 Windows ABI)
; Розрядність: тільки х64
; Компіляція:
; nasm -f win64 calc2.asm -o calc2.obj
; gcc calc2.obj -o calc2.exe
; ----------------------------------------------------------

extern printf, scanf

section .data
    fmt_in    db "Input x, y, z, b: ",0
    fmt_scan  db "%d %d %d %d",0
    fmt_out   db "F = %d",10,0

section .bss
    x resd 1
    y resd 1
    z resd 1
    b resd 1
    f resd 1

section .text
global main

main:
    ; printf("Input x, y, z, b: ");
    ; Для Win64: резервуємо 32 байти "shadow space" + 8 байт вирівнювання = 40
    sub rsp, 40
    lea rcx, [rel fmt_in]
    call printf
    add rsp, 40

    ; scanf("%d %d %d %d", &x, &y, &z, &b)
    lea rcx, [rel fmt_scan]
    lea rdx, [rel x]
    lea r8,  [rel y]
    lea r9,  [rel z]
    ; Якщо більше ніж 4 аргументи, решта йде через стек — тут їх 4, тож shadow space достатньо.
    sub rsp, 40
    ; перед викликом scanf стек вирівняний (16 байт)
    call scanf
    add rsp, 40

    ; ==========================================================
    ; Умова 1: (z <> 3) і (b > 0)
    ; F = (3*x*x + 9*y)/2 + 3*b
    ; ==========================================================
    mov eax, [rel z]
    cmp eax, 3
    je  check_second            ; якщо z = 3 → друга умова
    mov eax, [rel b]
    cmp eax, 0
    jle check_second            ; якщо b <= 0 → друга умова

    mov eax, [rel x]
    imul eax, [rel x]           ; eax = x * x
    imul eax, 3                 ; eax = 3 * x*x
    mov ebx, [rel y]
    imul ebx, 9                 ; ebx = 9*y
    add eax, ebx                ; eax = 3x^2 + 9y
    cdq                         ; sign-extend eax -> edx for idiv
    mov ebx, 2
    idiv ebx                    ; eax = (3x^2 + 9y) / 2
    mov ebx, [rel b]
    imul ebx, 3                 ; ebx = 3*b
    add eax, ebx                ; eax += 3*b
    mov [rel f], eax
    jmp print_result

; ==========================================================
; Умова 2: (z > 1) або (x < 5)
; F = 7*y + 5*x - 6*z
; ==========================================================
check_second:
    mov eax, [rel z]
    cmp eax, 1
    jg cond2_true
    mov eax, [rel x]
    cmp eax, 5
    jl cond2_true
    jmp cond3

cond2_true:
    mov eax, [rel y]
    imul eax, 7                 ; 7*y
    mov ebx, [rel x]
    imul ebx, 5                 ; 5*x
    add eax, ebx                ; 7*y + 5*x
    mov ebx, [rel z]
    imul ebx, 6                 ; 6*z
    sub eax, ebx                ; 7*y + 5*x - 6*z
    mov [rel f], eax
    jmp print_result

; ==========================================================
; Умова 3: (інакше) → F = z*z - 5*x
; ==========================================================
cond3:
    mov eax, [rel z]
    imul eax, [rel z]           ; eax = z*z
    mov ebx, [rel x]
    imul ebx, 5                 ; ebx = 5*x
    sub eax, ebx                ; eax = z*z - 5*x
    mov [rel f], eax

; ==========================================================
; printf("F = %d", f)
; ==========================================================
print_result:
    mov eax, [rel f]
    lea rcx, [rel fmt_out]      ; перший аргумент (fmt)
    mov edx, eax                ; другий аргумент (%d) — edx достатній (zero-extended)
    sub rsp, 40
    call printf
    add rsp, 40

    xor eax, eax
    ret
