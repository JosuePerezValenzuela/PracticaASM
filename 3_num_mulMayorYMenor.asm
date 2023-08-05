
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

    inicio:
    mov ah, 7
    int 21h
    mov bh, al
    int 21h
    mov bl, al
    int 21h
    mov ch, al
    proceso:
    cmp bh, bl
    jb cambio:
    cmp bh, ch
    jb cambio:
    jmp menor:
    cambio:
    xchg bh, bl
    xchg bh, ch
    jmp proceso:
    menor:
    cmp bl, ch
    jb multi:
    mov bl,ch
    multi:
    mov ax, 0
    sub bh, 30h
    sub bl, 30h
    mov al, bh
    mul bl
    add al, 30h
    mov ah, 2
    mov dl, al
    int 21h

fin: int 20h




