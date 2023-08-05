;Macros

saltoLinea macro
    mov ah, 2
    mov dl, 10
    int 21h
    mov dl, 13
    int 21h
saltoLinea endm

ingresarNum1 macro
    mov ah, 7
 salto1:   
    int 21h
    cmp al, '0'
    jb salto1
    cmp al, '9'
    ja salto1
    mov ah, 2
    mov dl, al
    int 21h
ingresarNum1 endm

ingresarLetram macro
    mov ah, 7
 salto2:    
    int 21h
    cmp al, 'a'
    jb salto2
    cmp al, 'z'
    ja salto2
    mov ah, 2
    mov dl, al
    int 21h
ingresarLetram macro

ingresarLetraM macro
    mov ah, 7
 salto3:    
    int 21h
    cmp al, 'A'
    jb salto3
    cmp al, 'Z'
    ja salto3
    mov ah, 2
    mov dl, al
    int 21h
ingresarLetram endm

ingresarLetramoM macro
    mov ah, 7
 salto4:    
    int 21h
    cmp al, 'A'
    jb salto2
    cmp al, 'Z'
    ja comprobar
 continuar:
    mov ah, 2
    mov dl, al
    int 21h
    jmp fin
 comprobar:
    cmp al, 'a'
    jb salto4:
    cmp al, 'z'
    ja salto4
    jmp continuar
 fin:
ingresarLetram endm

imprimirNum1 macro num
    mov ah, 2
    mov dl, num
    add dl, 30h
    int 21h
imprimirNum1 endm

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