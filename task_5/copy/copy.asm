; --------------------------------------------
; Програма: Копіювання рядків з регістра в регістр
; x86-64 версія: копіювання "Hello, World"
; Компіляція:
; nasm -f win64 copy.asm -o copy.obj
; gcc copy.obj -o copy.exe
; --------------------------------------------

section .data
    srcString db "Hello, World", 0
    destString times 15 db 0

section .text
    global main
main:
    lea rsi, [rel srcString]     ; джерело
    lea rdi, [rel destString]    ; призначення
    mov rcx, 13
    rep movsb

    ; Використаємо printf, щоб показати результат
    sub rsp, 40                  ; вирівнювання стека для Win64 ABI
    mov rcx, destString
    extern printf
    call printf
    add rsp, 40
    ret
