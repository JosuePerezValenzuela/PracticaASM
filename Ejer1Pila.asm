;Josue Perez Valenzuela
;Capturar N, hasta presionar 0 y mostrar
;cuantos numero, letras y caracteres
org 100h
  inicio:
        mov ax, 0
        mov bx, 0
        mov cx, 0
        mov dx, 0
capturar:
        mov ah, 7
        int 21h
        cmp al, 30h
        je mostrar
        ;para mostrar lo presionado
        mov ah, 2
        mov dl, al
        int 21h
        
        push ax
        inc cx
        jmp capturar
 mostrar:
        cmp cx, 0
        je fin
 ciclo: pop ax
        cmp al, 31h
        jb salto
        cmp al, 39h
        ja salto
        add bh, 1
        jmp saltoC
   salto:
        cmp al, 'a'
        jb salto2
        cmp al, 'z'
        ja salto2
        add bl, 1
        jmp saltoC
  salto2:
        add dh, 1
  saltoC:      
        loop ciclo
        mov ah, 2
        mov dl, 10
        int 21h
        mov dl, 13
        int 21h
        mov dl, 'n'
        int 21h
        mov dl, '='
        int 21h
        mov dl, bh
        add dl, 30h
        int 21h
        mov dl, 10
        int 21h
        mov dl, 13
        int 21h
        mov dl, 'l'
        int 21h
        mov dl, '='
        int 21h
        mov dl, bl
        add dl, 30h
        int 21h
        mov dl, 10
        int 21h
        mov dl, 13
        int 21h
        mov dl, 'c'
        int 21h
        mov dl, '='
        int 21h
        mov dl, dh
        add dl, 30h
        int 21h
    fin:int 20h