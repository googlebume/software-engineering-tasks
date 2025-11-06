; --- calc-fun-on-interval ---
; f = 7x + 3y - 3
; x = 1..20 step 4
; y = 10..20 step 2
; stop if x*y > a
; nasm -f win64 calc-fun-on-interval.asm -o calc-fun-on-interval.obj
; gcc calc-fun-on-interval.obj -o calc-fun-on-interval.exe

default rel

section .data
    msg_a      db "Input a: ", 0
    fmt_in     db "%d", 0
    fmt_out    db "x=%d, y=%d, f=%d", 10, 0

section .bss
    a   resd 1
    x   resd 1
    y   resd 1
    f   resd 1

section .text
    extern printf, scanf
    global main

main:
    push rbp
    mov  rbp, rsp

    ; print "Input a: "
    lea  rcx, [msg_a]
    xor  eax, eax
    call printf

    ; read a
    lea  rcx, [fmt_in]
    lea  rdx, [a]
    xor  eax, eax
    call scanf

    mov  dword [x], 1          ; x = 1

outer_loop:
    mov  dword [y], 10         ; y = 10

    ; inner y-loop counter
    mov  ecx, 6                ; (10..20 step 2) → 6 ітерацій

inner_loop:
    mov  eax, 7
    imul eax, dword [x]        ; eax = 7 * x
    mov  ebx, 3
    imul ebx, dword [y]        ; ebx = 3 * y
    add  eax, ebx
    sub  eax, 3
    mov  [f], eax

    ; check condition x*y > a
    mov  eax, [x]
    imul eax, [y]
    cmp  eax, [a]
    jg   stop_calc

    ; next y += 2
    add  dword [y], 2
    loop inner_loop            ; <-- Використано LOOP

    ; next x += 4
    add  dword [x], 4
    cmp  dword [x], 20
    jle  outer_loop

stop_calc:
    ; print result
    lea  rcx, [fmt_out]
    mov  edx, [x]
    mov  r8d, [y]
    mov  r9d, [f]
    xor  eax, eax
    call printf

    xor  eax, eax
    leave
    ret