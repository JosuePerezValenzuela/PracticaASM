;Realizar un programa que permita el ingreso 
;de N caracteres (solo caracteres) se debe
;contabilizar las repeticiones de cada 
;caracter, mostrar el caracter que mas se 
;repite y el caracter que menos se repita

capCarac macro
    local pedir,comp2,comp3,comp4,comp5,comp6,finCap,finCap2
pedir:    
    mov ah, 1    
    int 21h
    cmp al, 13
    je  finCap2
    cmp al, 30h
    ja comp2
    jmp comp3
comp2:
    cmp al, 40h
    jb pedir
comp3:
    cmp al, 41h
    ja comp4
    jmp comp5
comp4:
    cmp al, 5Bh
    jb pedir
comp5:
    cmp al, 61
    ja comp6
    jmp finCap
comp6:
    cmp al, 7Bh
    jb pedir
finCap:
    mov ah, 0
    mov si, offset aux
    add si, ax
    add [si], 1
    jmp pedir
finCap2:
    capCarac endm

buscarm macro
    mov cx, 0
    mov si, offset aux
ciclarBm:    
    cmp [si], 1
    je impm
    add si, 1
    add cl, 1
    jmp ciclarBm
impm:
    mov dl, cl
    mov ah, 2
    int 21h
    buscarm endm

buscarMa macro
    local ciclarBMa,aux,impMa
    mov bl, 9
    mov cl, 0
    mov si, offset aux
ciclarBMa:
    cmp [si], bl
    je impMa
    ;cmp cl, 255
    ;je aux
    add si, 1
    add cl, 1
    jmp ciclarBMa
;aux:
    ;sub bl, 1
    ;mov cx, 0
    ;mov si, offset aux

impMa:
    mov dl, cl
    mov ah, 2
    int 21h
    buscarMa endm

org 100h
inicio:
    
    capCarac

    call saltoLinea
    mov ah, 9
    mov dx, offset impMenos
    int 21h
    
    buscarm
    call saltoLinea
    mov ah, 9
    mov dx, offset impMas
    int 21h
    buscarMa
    
    mov si, offset aux
    add si, 43
    mov bh, [si]
    mov si, offset aux
    add si, 78
    mov ch, [si]

fin: int 20h

aux db 256 dup(0)
impMenos db "Caracter menos repetido: $"
impMas   db "Caracter mas repetido: $"

saltoLinea proc
    mov ah, 2
    mov dl, 10
    int 21h
    mov dl, 13
    int 21h
    ret
    saltoLinea endp