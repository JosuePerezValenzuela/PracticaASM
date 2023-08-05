;Realizar un programa para introducir los 
;datos de una persona para su registro en 
;Android,correo electronico y contrasenia, 
;Celular y Pais. Verificar el correo 
;ingresado sea valido, la contrasenia no debe
;ser visible y en su lugar mostrar "*", 
;la contrasenia debe contener al menos una 
;letra en Mayuscula y al menos un Numero. 
;Debe verificarse que el celular sea de 
;Bolivia.

capCorreo macro
    local cicloCC,verfCC,finCC,borrarCC,cicloAuxCC,salirAuxCC,salirCC
    mov bh, 0
    mov si, offset correo
cicloCC:    
    mov ah, 1
    int 21h
    cmp al, 13
    je finCC
    mov [si], al
    add si, 1
    cmp al, 64
    je verfCC
    jmp cicloCC
verfCC:
    mov bh, 1
    jmp cicloCC
finCC:
    cmp bh, 0
    je borrarCC
    jmp salirCC
borrarCC:
    mov cl, 20
    mov si, offset correo
cicloAuxCC:
    mov [si], 0
    sub cl, 1
    cmp cl, 0
    je salirAuxCC
    jmp cicloAuxCC
salirAuxCC:
    mov ah, 9
    mov dx, offset limpioLinea
    int 21h
    mov dx, offset impCorreo
    int 21h
    jmp cicloCC
salirCC:
    capCorreo endm

capContra macro
    local cicloContra,salContra,borrarContra,cicloAuxContra,AuxContra,finCContra
    mov bh, 0
    mov bl, 0
    mov si, offset contra
cicloContra:
    mov ah, 7
    int 21h
    cmp al, 13
    je salContra
    esMayuscula
    esNumero
    mov [si], al
    add si, 1
    impAUX
    jmp cicloContra
salContra:
    cmp bh, 0
    je borrarContra
    cmp bl, 0
    je borrarContra
    jmp finCContra
borrarContra:
    mov bh, 0
    mov bl, 0
    mov cl, 20
    mov si, offset contra
cicloAuxContra:
    mov [si], 0
    sub cl, 1
    cmp cl, 0
    je AuxContra
    jmp cicloAuxContra 
 AuxContra:
    mov ah, 2
    mov dl, 13
    int 21h
    mov ah, 9
    mov dx, offset limpioLinea
    int 21h
    mov ah, 9
    mov dx, offset impContra
    int 21h
    jmp cicloContra
finCContra:
    capContra endm
impAux macro
    mov ah, 2
    mov dl, '*'
    int 21h
    impAux endm
esMayuscula macro
    local salIA
    cmp al, 'A'
    jb salIA
    cmp al, 'Z'
    ja salIA
    mov bh, 1
salIA:
    esMayuscula endm
esNumero macro
    local salMA
    cmp al, '0'
    jb salMA
    cmp al, '9'
    ja salMA
    mov bl, 1
salMA:
    esNumero endm

capCelular macro
    local cicloCelu,salCicloCelu,borrar,cicloBorrar,AuxCelu,finCelu
    mov cl, 0
    mov si, offset telf
cicloCelu:
    mov ah, 1
    int 21h
    cmp al, 13
    je salCicloCelu
    mov [si], al
    add cl, 1
    add si, 1
    jmp cicloCelu
salCicloCelu:
    cmp cl, 8
    je finCelu
    jmp borrar
borrar:
    mov si, offset telf
    mov ch, 20
    mov cl, 0
cicloBorrar:
    mov [si], 0
    sub ch, 1
    add si, 1
    cmp ch, 0
    je AuxCelu
    jmp cicloBorrar
AuxCelu:
    mov ah, 2
    mov dl, 13
    int 21h
    mov ah, 9
    mov dx, offset limpioLinea
    int 21h
    mov ah, 9
    mov dx, offset impCelular
    int 21h
    jmp cicloCelu
finCelu:
    capCelular endm
    
org 100h
inicio: 
    mov ah, 9
    mov dx, offset impCorreo
    int 21h
    capCorreo
    call saltoLinea
    mov ah, 9
    mov dx, offset impContra
    int 21h
    capContra
    call saltoLinea
    mov ah, 9
    mov dx, offset impCelular
    int 21h
    capCelular
    call saltoLinea
    mov ah, 9
    mov dx, offset impPais
    int 21h
    mov ah, 1
ciclo:
    int 21h
    cmp al, 13
    je salir
    jmp ciclo    
salir:
    call saltoLinea
    mov ah, 9
    mov dx, offset impConfirmacion
    int 21h

fin: int 20h

limpioLinea db "                                                                                $"
impCorreo db "Ingrese su correo electronico: $"
impContra db "Ingrese una contrasenia valida: $"
impCelular db "Ingrese su telefono: +591 $"
impPais db "Ingrese su pais: $"
impConfirmacion db "Sus datos son correctos y se guardaron exitosamente$"

correo db 20 dup (0)
contra db 20 dup (0)
telf db 20 dup (0)

saltoLinea proc
    mov ah, 2
    mov dl, 10
    int 21h
    mov dl, 13
    int 21h
    ret
    saltoLinea endp