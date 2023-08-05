;Realizar un programa que permita el 
;ingreso de una fecha, la fecha debe 
;tratarse en un registro. Tambien solicitar un
;numero de dias, ese numero debe sumarse a 
;la fecha y mostrar la nueva fecha 
;(el mes en literal)

imprimirNum2 macro num
    mov dh, 10
    mov ax, num
    div dh
    mov dh, ah
    mov dl, al
    mov ah, 2
    add dl, 30h
    int 21h
    mov dl, dh
    add dl, 30h
    int 21h
imprimirNum2 endm

org 100h
    inicio:
        call capN
        sub al, 30h
        mov dh, 10
        mul dh
        mov bl, 0
        mov bl, al
        call capN
        sub al, 30h
        add bl, al
        shl bx, 9
        
        call capN
        sub al, 30h
        mov dh, 10
        mul dh
        mov cx, 0
        mov cl, al
        call capN
        sub al, 30h
        add cl, al
        shl cx, 5
        or bx, cx
        
        call capN
        sub al, 30h
        mov dh, 10
        mul dh
        mov cx, 0
        mov cl, al
        call capN
        sub al, 30h
        add cl, al
        or bx, cx
        
        call saltoLinea
        call capN
        sub al, 30h
        mov dh, 10
        mul dh
        mov dh, al
        call capN
        sub al, 30h
        add dh, al
        
        mov cx, bx
        shl cx, 11
        shr cx, 11
        add cl, dh
        mov ch, 0
        cmp cl, 30
        ja proceso
        shr bx, 5
        shl bx, 5
        or bx, cx
  proceso:
        add ch, 1
        sub cl, 30
        cmp cl, 30
        ja proceso
        mov dx, bx
        shl dx, 7
        shr dx, 12
        add dl, ch
        cmp dl, 12
        ja proceso2
        shl dx, 5
        mov ch, 0
        or cx, dx
        shr bx, 9
        shl bx, 9
        or bx, cx
        jmp imprimir
  proceso2:
        sub dl, 12
        mov al, dl
        shl dx, 5
        mov ch, 0
        or cx, dx
        shr bx, 9
        add bl, al
        shl bx, 9
        or bx, cx
  imprimir:
        call saltoLinea
        mov cx, bx
        shr cx, 9
        imprimirNum2 cx
        mov ah, 2
        mov dl, '/'
        int 21h
        mov cx, bx
        shl cx, 7
        shr cx, 12
        call impMes
        mov ah, 2
        mov dl, '/'
        int 21h
        mov cx, bx
        shl cx, 11
        shr cx, 11
        imprimirNum2 cx
        

fin: int 20h

m1 db 'Enero$'
m2 db 'Febrero$'
m3 db 'Marzo$'
m4 db 'Abril$'
m5 db 'Mayo$'
m6 db 'Junio$'
m7 db 'Julio$'
m8 db 'Agosto$'
m9 db 'Septiembre$'
m10 db 'Octubre$'
m11 db 'Noviembre$'
m12 db 'Diciembre$'

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

saltoLinea proc
    mov ah, 2
    mov dl, 10
    int 21h
    mov dl, 13
    int 21h
    ret
    saltoLinea endp

impMes proc
    mov ah, 9
    cmp cl, 1
    je imp1
    cmp cl, 2
    je imp2
    cmp cl, 3
    je imp3
    cmp cl, 4
    je imp4
    cmp cl, 5
    je imp5
    cmp cl, 6
    je imp6
    cmp cl, 7
    je imp7
    cmp cl, 8
    je imp8
    cmp cl, 9
    je imp9
    cmp cl, 10
    je imp10
    cmp cl, 11
    je imp11
    jmp imp12
 imp1: mov dx, offset m1 
       int 21h 
       jmp aux
 imp2: mov dx, offset m2 
       int 21h 
       jmp aux  
 imp3: mov dx, offset m3 
       int 21h 
       jmp aux
 imp4: mov dx, offset m4 
       int 21h 
       jmp aux
 imp5: mov dx, offset m5 
       int 21h 
       jmp aux
 imp6: mov dx, offset m6 
       int 21h 
       jmp aux
 imp7: mov dx, offset m7 
       int 21h 
       jmp aux
 imp8: mov dx, offset m8 
       int 21h 
       jmp aux
 imp9: mov dx, offset m9 
       int 21h 
       jmp aux
 imp10: mov dx, offset m10 
        int 21h 
        jmp aux
 imp11: mov dx, offset m11 
        int 21h 
        jmp aux
 imp12: mov dx, offset m12 
        int 21h 
        jmp aux 
aux:
    ret
    impMes endp  