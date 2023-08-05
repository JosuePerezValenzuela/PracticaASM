; Josue Perez Valenzuela
; Tabla de sumas

org 100h
    inicio:
        mov ax, 0
        mov ah, 7
        int 21h
        cmp al, 30h
        jb inicio:
        cmp al, 39h
        ja inicio:
        mov cx, 0
        mov cl, 10
        mov bl, al
        sub bl, 30h
    ciclo:
        mov bh, bl
        mov ah, 2
        mov ch, 11
        sub ch, cl
        mov dl, bh
        add dl, 30h
        int 21h
        mov dl, '+'
        int 21h
        cmp ch, 9
        ja proceso
        mov dl, ch
        add dl, 30h
        int 21h
      point:
        mov dl, '='
        int 21h
        add bh, ch
        cmp bh, 9
        ja proceso2
        mov dl, bh
        add dl, 30h
        int 21h
    saltos:
        mov dl, 10
        int 21h
        mov dl, 13
        int 21h
        mov ch, 0  
        loop ciclo
        jmp fin
    proceso2:
        mov dh, 10
        mov ah, 0
        mov al, bh
        div dh
        mov dl, al
        mov dh, ah
        mov ah, 2
        add dl, 30h
        int 21h
        mov dl, dh
        add dl, 30h
        int 21h
        jmp saltos
    proceso:
        mov dh, 10
        mov ah, 0
        mov al, ch
        div dh
        mov dl, al
        mov dh, ah
        mov ah, 2
        add dl, 30h
        int 21h
        mov dl, dh
        add dl, 30h
        int 21h
        jmp point
fin: int 20h        