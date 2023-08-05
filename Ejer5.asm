;Realizar un programa que muestre un menu
;1) Ingreso de numeros, 
;2) ingreso de Operacion,
;3) Seleccion de Sistema numerico (b, d, o, h)
;4) Mostrar resultado en el sistema numerico
;seleccionado.

capN2 macro
    mov ah, 1
    int 21h
    mov dh, 10
    sub al, 30h
    mov ah, 0
    mul dh
    mov dh, al
    mov ah, 1
    int 21h
    sub al, 30h
    add dh, al
    capN2 endm

capOp macro
    mov ah, 1
    int 21h
    capOp endm

org 100h
  inicio:
    mov ah, 9
    mov dx, offset inNum
    int 21h
    capN2
    mov bh, dh
    mov ah, 2
    mov dl, ' '
    int 21h
    capN2
    mov bl, dh
    call saltoLinea
    
    mov ah, 9
    mov dx, offset inOp
    int 21h
    capOp
    mov ch, al
    call saltoLinea
    
    mov ah, 9
    mov dx, offset inSisNum
    int 21h
    mov ah, 1
    int 21h
    mov dh, al
    call saltoLinea
    
    cmp ch, '+'
    je sumo
    cmp ch, '-'
    je resto
    cmp ch, '*'
    je multi
    cmp ch, '/'
    je divi
    
sumo:
    add bh, bl
    jmp aux
resto:
    sub bh, bl
    jmp aux
multi:
    mov ah, 0
    mov al, bh
    mul bl
    mov bh, al
    jmp aux
divi:
    mov ah, 0
    mov al, bh
    div bl
    mov bh, al
    jmp aux
aux:
    mov bl, dh
    mov dx, offset resp
    mov ah, 9
    int 21h
    cmp bl, 'b'
    je convB
    cmp bl, 'd'
    je impD
    cmp bl, 'o'
    je convO
    cmp bl, 'h'
    je convH
    
convB:    
    mov ch, 2
    mov si, offset respB
    mov ah, 0
    mov al, bh
ciclarB:    
    div ch
    add ah, 30h
    mov [si], ah
    mov ah, 0
    inc si
    cmp al, 0
    je auxB
    jmp ciclarB
auxB:
    mov cl, 8
    mov si, offset respB
    add si, 7
ciclar2B:    
    mov ah, 2
    mov dl, [si]
    int 21h
    dec si
    sub cl, 1
    cmp cl, 0
    je fin
    jmp ciclar2B
    
impD:
    mov dh, 10
    mov ax, 0
    mov al, bh
    div dh
    mov dl, al
    mov dh, ah
    add dl, 30h
    mov ah, 2
    int 21h
    mov dl, dh
    add dl, 30h
    int 21h
    jmp fin
    
convO:
    mov ch, 8
    mov si, offset respO
    mov ah, 0
    mov al, bh
ciclarO:    
    div ch
    add ah, 30h
    mov [si], ah
    mov ah, 0
    inc si
    cmp al, 0
    je auxO
    jmp ciclarO
auxO:
    mov cl, 3
    mov si, offset respO
    add si, 2
ciclar2O:    
    mov ah, 2
    mov dl, [si]
    int 21h
    dec si
    sub cl, 1
    cmp cl, 0
    je fin
    jmp ciclar2O
    
convH:
    mov al, bh
    mov ah, 0
    mov ch, 16
    mov si, offset respH
cicloH:    
    div ch
    cmp ah, 9
    ja aniadir
    add ah, 30h
    mov [si], ah
    jmp auxH
aniadir:
    cmp ah, 10
    jne salto1H
    mov [si], 'A'
    jmp auxH
salto1H:    
    cmp ah, 11
    jne salto2H
    mov [si], 'B'
    jmp auxH
salto2H:    
    cmp ah, 12
    jne salto3H
    mov [si], 'C'
    jmp auxH
salto3H:    
    cmp ah, 13
    jne salto4H
    mov [si], 'D'
    jmp auxH
salto4H:    
    cmp ah, 14
    jne salto5H
    mov [si], 'E'
    jmp auxH
salto5H:
    mov [si], 'F'
    jmp auxH
auxH:
    mov ah, 0
    inc si
    cmp al, 15
    ja cicloH
    add al, 30h
    mov [si], al
    
    mov cl, 2
    mov si, offset respH
    add si, 1
ciclar2H:    
    mov ah, 2
    mov dl, [si]
    int 21h
    dec si
    sub cl, 1
    cmp cl, 0
    je fin
    jmp ciclar2H                        
       
fin: int 20h

inNum db "Ingreso de 2 numeros de 2 digitos: $"
inOp db "Ingrese una operacion (+,-,*,/): $"
inSisNum db "Ingrese un sistema numerico (b, d, o, h): $"
resp db "El resultado es: $"
respB db "00000000$"
respO db "000$"
respH db "00$"

saltoLinea proc
    mov ah, 2
    mov dl, 10
    int 21h
    mov dl, 13
    int 21h
    ret
    saltoLinea endp