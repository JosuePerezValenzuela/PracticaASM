;Realizar un programa que solo permita el 
;ingreso de 3 numeros de hasta 3 digitos cada
;uno.Sumar el medio y el menor y mostrar la 
;tabla de suma de cada digito del resultado. 
;Restar el mayor y menor y mostrar la tabla 
;de multiplicacion del primer y ultimo digito de del resultado.

capN3 macro contenedor
    mov dh, 100   
    call capN1
    mov contenedor, al
    mov dh, 10
    call capN1
    add contenedor, al
    mov dh, 1
    call capN1
    add contenedor, al
    capN3 endm

tablaCadaDig macro num
    mov dl, 100
    mov ah, 0
    mov al, num
    div dl
    mov bl, al
    push ax
    imp dh
    call saltoLinea
    call saltoLinea
    pop ax
    mov al, ah
    mov ah, 0
    mov dl, 10
    div dl
    mov bl, al
    push ax
    imp dh
    call saltoLinea
    call saltoLinea
    pop ax
    mov bl, ah
    imp dh
    call saltoLinea
    call saltoLinea
    tablaCadaDig endm

imp macro num
    local ciclo, volver, imp2N, finaux
    mov cl, 0
ciclo:    
    mov ah, 2
    cmp cl, 9
    ja finaux
    mov dl, bl
    add dl, 30h
    int 21h
    mov dl, '+'
    int 21h
    mov dl, cl
    add dl, 30h
    int 21h
    mov dl, '='
    int 21h
    mov dl, bl
    add dl, cl
    cmp dl, 9
    ja imp2N
    add dl, 30h
    int 21h
volver:
    call saltoLinea
    add cl, 1
    jmp ciclo
imp2N:
    mov al, dl
    mov dl, 10
    mov ah, 0
    div dl
    mov dl, al
    mov dh, ah
    mov ah, 2
    add dl, 30h
    int 21h
    mov dl, dh
    add dl, 30h
    int 21h
    jmp volver        
finaux:    
    imp endm

tablaMul macro
    mov dh, 100
    mov al, bh
    mov ah, 0
    div dh
    push ax
    impMul
    call saltoLinea
    call saltoLinea
    pop ax
    mov al, ah
    mov ah, 0
    mov dh, 10
    div dh
    xchg al, ah
    impMul
    tablaMul endm
    
impMul macro
    local cicloM,volverM,impN2M,finauxM
    mov cl, 0
    mov bl, al
cicloM:    
    cmp cl, 9
    ja finauxM
    mov ah, 2
    mov dl, bl
    add dl, 30h
    int 21h
    mov dl, '*'
    int 21h
    mov dl, cl
    add dl, 30h
    int 21h
    mov dl, '='
    int 21h
    mov al, bl
    mov ah, 0
    mul cl
    cmp al, 9
    ja impN2M
    mov ah, 2
    mov dl, al
    add dl, 30h
    int 21h
volverM:
    add cl, 1
    call saltoLinea
    jmp cicloM    
impN2M:
    mov dh, 10
    mov ah, 0
    div dh
    mov dh, ah
    mov dl, al
    add dl, 30h
    mov ah, 2
    int 21h
    mov dl, dh
    add dl, 30h
    int 21h
    jmp volverM
finauxM:    
    impM endm

org 100h
  inicio:
     mov bx, 0
     mov cx, 0
     capN3 bh
     call saltoLinea
     capN3 bl
     call saltoLinea
     capN3 ch
     call saltoLinea
     
     cmp bh, bl
     ja comp2
     xchg bh, bl
  comp2:   
     cmp bh, ch
     ja proce
     xchg bh, ch
  proce:
     cmp bl, ch
     ja aux
     xchg bl, ch
  aux:
     
     mov dh, 0
     mov dh, bl
     add dh, ch
     
     tablaCadaDig dh
     
     sub bh, ch
     
     tablaMul
     
fin: int 20h

capN1 proc
     mov ah, 1
     int 21h
     sub al, 30h
     mul dh
     ret
     capN1 endp

saltoLinea proc
     mov ah, 2
     mov dl, 10
     int 21h
     mov dl, 13
     int 21h
     ret
     saltoLinea endp