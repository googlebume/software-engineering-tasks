; ---------------------------------------------------------
; Програма: Пошук символу в рядку за допомогою SCASB (x86-64)
; Компіляція:
; nasm -f win64 search.asm -o search.obj
; gcc search.obj -o search.exe
; ---------------------------------------------------------

section .data
    string      db "Hello, World!", 0      ; Рядок для пошуку
    target_char db 'o'                     ; Шуканий символ
    fmt_found   db "Character '%c' found at position: %d", 10, 0
    fmt_not     db "Character '%c' not found.", 10, 0

section .text
    global main
    extern printf

main:
    ;--------------------------------------------
    ; Ініціалізація
    ;--------------------------------------------
    lea rdi, [rel string]          ; RDI -> початок рядка
    lea rbx, [rel target_char]     ; RBX -> шуканий символ
    mov al, [rbx]                  ; AL = символ для пошуку

    xor rcx, rcx                   ; RCX = лічильник позиції
    ;--------------------------------------------
    ; Пошук символу за допомогою SCASB
    ;--------------------------------------------
.search_loop:
    mov dl, [rdi]                  ; DL = поточний байт
    cmp dl, 0                      ; Перевірка на кінець рядка
    je .not_found

    scasb                          ; Порівнює AL з [RDI], RDI++
    je .found                      ; Якщо збіг — вихід

    inc rcx                        ; Збільшуємо позицію
    jmp .search_loop

.found:
    ;--------------------------------------------
    ; Виводимо результат (позицію)
    ;--------------------------------------------
    sub rsp, 40                    ; Вирівнюємо стек для Win64 ABI
    movzx rdx, al                  ; %c (символ)
    mov r8, rcx                    ; %d (позиція)
    lea rcx, [rel fmt_found]       ; форматний рядок
    call printf
    add rsp, 40
    jmp .exit

.not_found:
    sub rsp, 40
    movzx rdx, al
    lea rcx, [rel fmt_not]
    call printf
    add rsp, 40

.exit:
    ret