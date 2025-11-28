global main
extern printf

section .data
    fmt db "AX=%04Xh BX=%04Xh CX=%04Xh DX=%04Xh", 10, 0

section .text
main:

    mov dx, 0A2D0h   ; Регістр 1
    mov cx, dx       ; Регістр 2
    mov ax, dx       ; Регістр 3
    mov bx, dx       ; Регістр 4

    ;
    mov rcx, fmt     ; перший параметр - рядок формату
    mov rdx, rax     ; AX -> RDX
    mov r8, rbx      ; BX -> R8
    mov r9, rcx      ; CX -> R9
    sub rsp, 32      ; вирівнювання стеку
    call printf
    add rsp, 32

    xor eax, eax
    ret
