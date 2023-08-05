;Realizar un programa que solo permita 
;el ingreso de numeros (N) de hasta dos 
;digitos cada uno.Mostrar todos los primos
;y el promedio de todos.
;Para dejar de insertar numeros presiona
;enter

capN2 macro
  pedir:
     mov ah, 7
     int 21h 
     cmp al, 13
     je aux
     mov dh, 10
     sub al, 30h
     mul dh
     mov dh, al
     mov ah, 7
     int 21h
     sub al, 30h
     add dh, al
     add bh, dh
     add cl, 1
     push dx
     jmp pedir
  aux:     
     capN2 endm

primo macro num
    local prueba, imp,finaux
    mov ax, 0  
    mov al, num 
    mov dh, 2
prueba:    
    div dh
    cmp ah, 0
    je finaux
    add dh, 1
    cmp dh, num
    je imp
    mov ax, 0
    mov al, num
    jmp prueba 
  imp:
    mov ax, 0
    mov dh, 10
    mov al, num
    div dh
    mov dh, ah
    mov dl, al
    add dl, 30h
    mov ah, 2
    int 21h
    mov dl, dh
    add dl, 30h
    int 21h
 finaux:
    primo endm

org 100h
     mov bx, 0
     mov cx, 0
     capN2
     
     mov ah, 9
     mov dx, offset prom
     int 21h
     
     mov ax, 0
     mov al, bh    
     div cl
     cmp al, 9
     jb proce
     mov dh, 10
     mov ah, 0
     div dh
     
proce:     
     mov dh, ah
     mov dl, al
     add dl, 30h
     mov ah, 2
     int 21h
     mov dl, dh
     add dl, 30h
     int 21h
     
     call saltoLinea
     
  aux2:      
     pop bx
     sub cl, 1
     primo bh
     call saltoLinea
     cmp cl, 0
     jne aux2
     
     
fin: int 20h

prom db 'Promedio: $'

saltoLinea proc
    mov ah, 2
    mov dl, 10
    int 21h
    mov dl, 13
    int 21h
    ret
    saltoLinea endp