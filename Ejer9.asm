;Realizar un programa para registrar partes 
;de computadoras (al menos 10) y su marca,
;preguntar si se ordena por parte o marca, 
;mostrar en orden alfabetico el resultado.

pedirTexto macro cadena
    local ciclarPedir,finPT,ciclarPedir2,finPT2
    mov cl, 5
    mov si, offset cadena
ciclarPedir:
    cmp cl, 0
    je finPT    
    mov ah, 1
    int 21h
    cmp al, 13
    je finPT
    mov [si], al
    add si, 1
    sub cl, 1
    jmp ciclarPedir
finPT:
    mov si, offset cadena
    add si, 5
    mov [si], '-'
    add si, 1
    call saltoLinea
    call imprimirMarca
    mov cl, 5
ciclarPedir2:
    cmp cl, 0
    je finPT2
    mov ah, 1
    int 21h
    cmp al, 13
    je finPT2
    mov [si], al
    add si, 1
    sub cl, 1
    jmp ciclarPedir2
finPT2:
    pedirTexto endm

ordParte macro
    local cicloOP,volver1,volver2,volver3,volver4,cambio1,cambio2,cambio3,cambio4,finOP
    mov cl, 5
cicloOP:
    cmp cl, 1
    je finOP    
    mov si, offset parte1
    mov di, offset parte2
    mov dh, [di]
    cmp [si], dh
    ja cambio1
volver1:    
    mov si, offset parte2
    mov di, offset parte3
    mov dh, [di]
    cmp [si], dh
    ja cambio2
volver2:
    mov si, offset parte3
    mov di, offset parte4
    mov dh, [di]
    cmp [si], dh
    ja cambio3
volver3:
    mov si, offset parte4
    mov di, offset parte5
    mov dh, [di]
    cmp [si], dh
    ja cambio4
volver4:    
    sub cl, 1
    jmp cicloOP
cambio1:
    cambioMacro parte1, parte2
    jmp volver1
cambio2:
    cambioMacro parte2, parte3
    jmp volver2
cambio3:
    cambioMacro parte3, parte4
    jmp volver3
cambio4:
    cambioMacro parte4, parte5
    jmp volver4
    
finOP:
    ordParte endm

ordMarca macro
    local cicloM,volver1,volver2,volver3,volver4,cambio1,cambio2,cambio3,cambio4,finM
    mov cl, 5
cicloM:
    cmp cl, 1
    je finM    
    mov si, offset parte1
    add si, 6
    mov di, offset parte2
    add di, 6
    mov dh, [di]
    cmp [si], dh
    ja cambio1
volver1:    
    mov si, offset parte2
    add si, 6
    mov di, offset parte3
    add di, 6
    mov dh, [di]
    cmp [si], dh
    ja cambio2
volver2:
    mov si, offset parte3
    add si, 6
    mov di, offset parte4
    add di, 6
    mov dh, [di]
    cmp [si], dh
    ja cambio3
volver3:
    mov si, offset parte4
    add si, 6
    mov di, offset parte5
    add di, 6
    mov dh, [di]
    cmp [si], dh
    ja cambio4
volver4:    
    sub cl, 1
    jmp cicloM
cambio1:
    cambioMacro parte1, parte2
    jmp volver1
cambio2:
    cambioMacro parte2, parte3
    jmp volver2
cambio3:
    cambioMacro parte3, parte4
    jmp volver3
cambio4:
    cambioMacro parte4, parte5
    jmp volver4
    
finM:
    ordMarca endm ;;;;

cambioMacro macro cadena1, cadena2
    local cicloCM,salCM,cicloCM2,salCM2,cicloCM3,salCM3
    mov si, offset cadena1
    mov di, offset parteAux
    mov ch, 11
cicloCM:
    cmp ch, 0
    je salCM
    mov bh, [si]
    mov [di], bh
    add si, 1
    add di, 1
    sub ch, 1
    jmp cicloCM
salCM:
    mov si, offset cadena2
    mov di, offset cadena1
    mov ch, 11
cicloCM2:
    cmp ch, 0
    je salCM2
    mov bh, [si]
    mov [di], bh
    add si, 1
    add di, 1
    sub ch, 1
    jmp cicloCM2
salCM2:
    mov si, offset parteAux
    mov di, offset cadena2
    mov ch, 11
cicloCM3:
    cmp ch, 0
    je salCM3
    mov bh, [si]
    mov [di], bh
    add si, 1
    add di, 1
    sub ch, 1
    jmp cicloCM3
salCM3:
    cambioMacro endm

impTodo macro
    call saltoLinea
    mov si, offset parte1
    impParcial
    call saltoLinea
    mov si, offset parte2
    impParcial
    call saltoLinea
    mov si, offset parte3
    impParcial
    call saltoLinea
    mov si, offset parte4
    impParcial
    call saltoLinea
    mov si, offset parte5
    impParcial
    impTodo endm

impParcial macro
    local cicloImp, salIP
    mov ah, 2
    mov cl, 11
cicloImp:
    cmp cl, 0
    je salIP
    mov dl, [si]
    int 21h
    add si, 1
    sub cl, 1
    jmp cicloImp
salIP:
    impParcial endm

org 100h
inico:
    call imprimirParte
    pedirTexto parte1
    
    call saltoLinea
    call imprimirParte
    pedirTexto parte2
    
    call saltoLinea
    call imprimirParte
    pedirTexto parte3
    
    call saltoLinea
    call imprimirParte
    pedirTexto parte4
    
    call saltoLinea
    call imprimirParte
    pedirTexto parte5
    
    call saltoLinea
    mov ah, 9
    mov dx, offset impOrden
    int 21h
    mov ah, 1
    int 21h
    cmp al, 'P'
    je ordP
    cmp al, 'M'
    je ordM
ordP:
    ordParte
    impTodo
    jmp fin
ordM:
    ordMarca
    impTodo
    jmp fin

fin: int 20h

impParte db "Ingrese el nombre de la parte: $"
impMarca db "Ingrese la marca de la parte: $"
impOrden db "Ingrese como ordenar (P,M): $"

parte1 db 11 dup (0)
parte2 db 11 dup (0)
parte3 db 11 dup (0)
parte4 db 11 dup (0)
parte5 db 11 dup (0)
parteAux db 11 dup (0)

imprimirParte proc
    mov ah,9
    mov dx, offset impParte
    int 21h
    ret
    imprimirParte endp

imprimirMarca proc
    mov ah,9
    mov dx, offset impMarca
    int 21h
    ret
    imprimirMarca endp

saltoLinea proc
    mov ah, 2
    mov dl, 10
    int 21h
    mov dl, 13
    int 21h
    ret
    saltoLinea endp