global  main          ; точка входу
extern  printf        ; використання функції printf з C бібліотеки

section .data
msg db "Hello world!", 10, 0   ; рядок з новим рядком та нуль-термінатором

section .text
main:
    sub     rsp, 40           ; резерв стеку (Windows x64 ABI)
    lea     rcx, [rel msg]    ; RCX = перший аргумент (адреса рядка)
    call    printf            ; виклик printf
    add     rsp, 40
    ret                       ; повернення з main
