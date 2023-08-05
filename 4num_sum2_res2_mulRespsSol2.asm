; 4 numeros, verificar que se metan numeros
; sumar los 2 primeros, restar los otros
; 2 y multiplicar resultados

org 100h

    inicio:
        mov ax, 0
        mov ah, 7
        mov dh, 1
        
        int 21h
        jmp verfNum:
primero:
        mov bh,al
        sub bh,30h
        add dh, 1        
        int 21h
        jmp verfNum:
segundo:
        mov bl,al
        sub bl, 30h
        add dh, 1
        int 21h
        jmp verfNum:
tercero: 
        mov ch,al
        sub ch, 30h
        add dh, 1       
        int 21h
        jmp verfNum:
cuarto:
        mov cl, al
        sub cl, 30h
        
        add bh, bl
        sub ch, cl
        mov ax, 0
        mov al, bh
        mul ch
        mov bh, al
        mov bl, 10
        cmp al, 9
        ja proceso:
        
        mov ah, 2
        mov dl, bl
        add dl, 30h
        int 21h
        jmp fin:
        
    proceso:
        div bl
        add ah, 30h
        add al, 30h
        mov ch, al
        mov cl, ah
        mov ah, 2
        mov dl, ch
        int 21h
        mov dl, cl
        int 21h
        jmp fin:
        
    verfNum:
        cmp al, 30h
        jb fin:
        cmp al, 39h
        ja fin:
        cmp dh, 1
        je primero:
        cmp dh, 2
        je segundo:
        cmp dh, 3
        je tercero:
        cmp dh, 4
        je cuarto:
        
   fin: int 20h   