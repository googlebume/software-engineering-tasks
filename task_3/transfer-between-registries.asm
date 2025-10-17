global main
extern printf

section .data
    fmt db "AX=%04Xh BX=%04Xh CX=%04Xh DX=%04Xh", 10, 0

section .text
main:
    mov ax, 0
    mov bx, ax
    mov cx, ax
    mov dx, ax

    mov ah, 0AFh
    mov bh, ah
    mov bl, bh
    mov ch, bl

    ; виклик printf(fmt, AX, BX, CX, DX)
    mov rcx, fmt
    mov rdx, rax    ; AX -> RDX
    mov r8, rbx     ; BX -> R8
    mov r9, rcx     ; CX -> R9
    sub rsp, 32     ; вирівнювання стеку для Windows x64 ABI
    call printf
    add rsp, 32

    xor eax, eax
    ret