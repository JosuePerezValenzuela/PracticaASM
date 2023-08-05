;Realizar un programa que permita el ingreso 
;de una fecha, al concluir el ingreso debera
;guardarse en un registro, posteriormente 
;mostrar todo el registro y a continuacion 
;en lineas diferentes la fecha
;, el anio, el mes y el dia en binario
    
org 100h
    mov cx, 10
    mov ax, 0
    mov bx, 0
    call aux1
    shl bx, 9
    push bx
    mov ax, 0
    mov bx, 0
    call aux1
    shl bx, 5
    push bx
    mov ax, 0
    mov bx, 0
    call aux1
    push bx
    mov ax, 0
    mov bx, 0
    pop bx
    pop cx
    or bx, cx
    pop cx
    or bx, cx
    call saltoLinea
    
    mov ch, bh
    call decAbit
    mov dx, 8
    call voltea
    
    mov ah, 2
    mov dl, ' '
    int 21h
    
    call limpio
    mov ch, bl
    call decAbit
    mov dx, 8
    call voltea
    
    call saltoLinea
    call limpio
    
    mov ax, bx
    shr bx, 9
    mov ch, bl
    mov bx, ax
    call decAbit
    mov dx, 8
    call voltea
    
    call saltoLinea
    call limpio
    
    mov ax, bx
    shl bx, 7
    shr bx, 12
    mov ch, bl
    mov bx, ax
    call decAbit
    mov dx, 8
    call voltea
    
    call saltoLinea
    call limpio
    
    mov ax, bx
    shl bx, 11
    shr bx, 11
    mov ch, bl
    mov bx, ax
    call decAbit
    mov dx, 8
    call voltea
    
fin: int 20h

fecha1 db '00000000'
fecha2 db '00000000'
anio db '0000000'
mes db '0000'
dia db '00000'

decAbit proc
    
    mov si, offset fecha1
    mov cl, 2
    mov ax, 0
    mov al, ch
 ciclar:
    cmp al, 0
    je salto   
    div cl
    add ah, 30h
    mov [si], ah
    inc si
    mov ah, 0
    jmp ciclar
 salto:
    ret
    decAbit endp

voltea proc
    mov si, offset fecha1
    sub dx, 1
    add si, dx
    add dx, 1
    mov cx, dx
    mov ah, 2
 ciclo:
    mov dl, [si]
    int 21h
    dec si
    loop ciclo
    ret
    voltea endp

capN proc
    mov ah, 7
 cap:
    int 21h
    cmp al, 30h
    jb cap
    cmp al, 39h
    ja cap
    mov ah, 2
    mov dl, al
    int 21h
    ret
    capN endp

aux1 proc
    call capN
    sub al, 30h
    mov dh, 10
    mul dh
    mov bl, al
    call capN
    sub al, 30h
    add bl, al
    ret
    aux1 endp 

saltoLinea proc
    mov ah,2
    mov dl, 10
    int 21h
    mov dl, 13
    int 21h
    ret
    saltoLinea endp

limpio proc
    mov cx, 8
    mov si, offset fecha1
 cicloL:   
    mov [si], '0'
    inc si
    mov dl, [si]
    loop cicloL
    ret
    limpio endp