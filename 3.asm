org 0x7c00
[bits 16]

xor ax, ax ; eax = 0
; 初始化段寄存器, 段地址全部设为0
mov ds, ax
mov ss, ax
mov es, ax
mov fs, ax
mov gs, ax

; 初始化栈指针
mov sp, 0x7c00
mov ax, 0xb800
mov gs, ax

get_cursor:
    mov ah, 3
    mov bh, 0
    int 10h

set_cursor:
    mov ah, 2
    mov bh, 0
    mov dh, 8 ; row
    mov dl, 8 ; column
    int 10h

read_keyboard:
    mov ah, 0
    int 16h

print_word:
    mov ah, 9
    mov bl, 0x20
    mov cx, 1
    int 10h

forward_cursor:
    mov ah, 2
    mov bh, 0
    add dl, 1
    int 10h
    jmp read_keyboard

jmp $ ; 死循环

times 510 - ($ - $$) db 0
db 0x55, 0xaa