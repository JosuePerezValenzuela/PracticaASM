;Realizar un programa que solo permita el 
;ingreso de N numeros hexadecimales de dos
;digitos cada uno. Mostrar cada numero en 
;las demás bases (decimal, octal y binario) 
;si es que el numero es par o primo.

capNH macro
    local ciclarNH,pedir,preguntar,aux,auxA,auxB,auxC,auxD,auxE,auxF,procesoNH,salirNH
    mov si, offset numH
    mov cl, 2
    mov bl, 0
    mov bh, 16
ciclarNH:
pedir:
    cmp cl, 0
    je salirNH    
    mov ah, 7
    int 21h
    cmp al, 13
    je fin
    cmp al, 30h
    jb pedir
    cmp al, 39h
    ja preguntar
    jmp aux
preguntar:
    cmp al, 41h
    jb pedir
    cmp al, 46h
    ja pedir
aux:
    mov [si], al
    cmp al, 'A'
    je auxA
    cmp al, 'B'
    je auxB
    cmp al, 'C'
    je auxC
    cmp al, 'D'
    je auxD
    cmp al, 'E'
    je auxE
    cmp al, 'F'
    je auxF
    jmp procesoNH
auxA:
    mov al, 58d
    jmp procesoNH
auxB:
    mov al, 59d
    jmp procesoNH
auxC:
    mov al, 60d
    jmp procesoNH
auxD:
    mov al, 61d
    jmp procesoNH
auxE:
    mov al, 62d
    jmp procesoNH
auxF:
    mov al, 63d        
procesoNH:
    mov ah, 0
    sub al, 30h
    mul bh
    add bl, al
    mov bh, 1
    add si, 1
    sub cl, 1
    jmp ciclarNH
salirNH:
    capNH endm

esPar macro
    mov dh, 2
    mov al, bl
    mov ah, 0
    div dh
    cmp ah, 0
    jne vuelta
    esPar endm

esPrimo macro
    local ciclarP, auxP
    mov dh, 2
ciclarP:    
    mov ah, 0
    mov al, bl
    div dh
    cmp dh, bl
    je auxP
    cmp ah, 0
    je vuelta
    add dh, 1
auxP:
    esPrimo endm
    
    
org 100h
inicio:
vuelta:    
    capNH
    esPar
    esPrimo
    mov ah, 9
    mov dx, offset impH
    int 21h
    mov si, offset numH
    mov cl, 2
imprimirH:
    cmp cl, 0
    je salH
    mov ah, 2
    mov dl, [si]
    int 21h
    add si, 1
    sub cl, 1
    jmp imprimirH
salH:
;Imprimir en Decimal
    call saltoLinea
    mov ah, 9
    mov dx, offset impD
    int 21h
    mov bh, 100
    mov ah, 0
    mov al, bl
    div bh
    mov dl, al
    mov dh, ah
    mov ah, 2
    add dl, 30h
    int 21h
    mov al, dh
    mov ah, 0
    mov bh, 10
    div bh
    mov dl, al
    mov dh, ah
    mov ah, 2
    add dl, 30h
    int 21h
    mov dl, dh
    add dl, 30h
    int 21h
;Imprimir en Binario
    call saltoLinea
    mov ah, 9
    mov dx, offset impB
    int 21h
    mov si, offset numB
    mov bh, 2
    mov al, bl
ciclarBin:
    mov ah, 0    
    div bh
    mov [si], ah
    cmp al, 0
    je auxBin
    add si, 1
    jmp ciclarBin
auxBin:
    mov si, offset numB
    add si, 7
    mov cl, 8
    mov ah, 2
impBin:
    cmp cl, 0
    je salBin    
    mov dl, [si]
    mov [si], 0
    add dl, 30h
    int 21h
    sub cl, 1
    sub si, 1
    jmp impBin
salBin:
;Imprimir en octal
    call saltoLinea
    mov ah, 9
    mov dx, offset impO
    int 21h
    mov si, offset numO
    mov dh, 8
    mov al, bl
ciclarOctal:
    mov ah, 0    
    div dh
    mov [si], ah
    cmp al, 0
    je auxO
    add si, 1
    jmp ciclarOctal
auxO:
    mov si, offset numO
    add si, 2
    mov cl, 3
    mov ah, 2
impOc:
    cmp cl, 0
    je salOc
    mov dl, [si]
    mov [si], 0
    add dl, 30h
    int 21h
    sub cl, 1
    sub si, 1
    jmp impOc
salOc:
    call saltoLinea
    jmp vuelta
fin: int 20h

numH db 2 dup (0)
numB db 8 dup (0)
numO db 3 dup (0)

impH db "Numero en Hexadecimal: $"
impD db "Numero en Decimal: $"
impB db "Numero en Binario: $"
impO db "Numero en Octal: $"

saltoLinea proc
    mov ah, 2
    mov dl, 10
    int 21h
    mov dl, 13
    int 21h
    ret
    saltoLinea endp