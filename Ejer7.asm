;Realizar un programa que permita el ingreso 
;de N caracteres, deberan ser guardadas en
;4 cadenas finales donde se guarden numeros, 
;mayusculas, minusculas y caracteres 
;especiales. Se debe mostrar las 4 cadenas 
;resultantes en columnas de la misma forma 
;que se almaceno.

aniadirFin macro lista
    local ciclarAF,auxAF
    mov cx, 0
    mov si, offset lista
ciclarAF:    
    cmp [si], 0
    je auxAF
    add si, 1
    add cl, 1
    jmp ciclarAF
auxAF:
    mov si, offset lista
    add si, cx
    mov [si], al
    aniadirFin endm

esNum macro
    local auxNum
    cmp al, 30h
    jb auxNum
    cmp al, 39h
    ja auxNum
    aniadirFin cadNum
    jmp salidaParcial
auxNum:
    esNun endm

esMin macro
    local auxMin
    cmp al, 97
    jb auxMin
    cmp al, 122
    ja auxMin
    aniadirFin cadMin
    jmp salidaParcial
auxMin:
    esMin endm

esMay macro
    local auxMay
    cmp al, 65
    jb auxMay
    cmp al, 90
    ja auxMay
    aniadirFin cadMay
    jmp salidaParcial
auxMay:
    esMay endm
    
esEsp macro
    aniadirFin cadEsp
    esEsp endm    

org 100h
inicio:

pedir:    
    mov ah, 1
    int 21h
    cmp al, 13
    je salir
    esNum
    esMin
    esMay
    esEsp
salidaParcial:
    jmp pedir
salir:
    mov ah, 2
    mov cx, 0
ciclar:    
    mov si, offset cadNum
    add si, cx
    mov dl, [si]
    int 21h
    call salto3
    mov si, offset cadMin
    add si, cx
    mov dl, [si]
    int 21h
    call salto3
    mov si, offset cadMay
    add si, cx
    mov dl, [si]
    int 21h
    call salto3
    mov si, offset cadEsp
    add si, cx
    mov dl, [si]
    int 21h
    call saltoLinea
    cmp cl, 9
    je fin:
    add cl, 1
    jmp ciclar    
    
fin: int 20h

cadNum db 10 dup(0)
cadMin db 10 dup(0)
cadMay db 10 dup(0)
cadEsp db 10 dup(0)

salto3 proc
    mov ah, 2
    mov dl, ' '
    int 21h
    int 21h
    int 21h
    ret
    salto3 endp

saltoLinea proc
    mov ah, 2
    mov dl, 10
    int 21h
    mov dl, 13
    int 21h
    ret
    saltoLinea endp