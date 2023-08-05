
;10- Realizar un programa que capture la información de una factura, nit, nro factura, nro autorización, 
;nombre cliente, monto y fecha. Se debe generar el código de control de factura que tendrá 3 
;componentes. El primer componente será el promedio de las letras del nombre del cliente, el segundo 
;componente será la sumatoria de los dígitos de la fecha, y el tercer componente los dos primeros dígitos
;del nit

mostrarPantalla macro etiqueta
    push dx    
    mov dx, offset etiqueta
    mov ah,9
    int 21h
    pop dx    
endm

compararYcapturar macro minimo maximo nombreCadena
Local comparar guardar capturar continuarSiguiente
    mov si, offset nombreCadena
    mov ax,0
    mov cx,0
    mov ah,1    
capturar:
    int 21h
    cmp al,13
    je continuarSiguiente       
    cmp al,minimo
    jg comparar
    jmp capturar
comparar:
    cmp al,maximo    
    jng guardar
    jmp capturar
guardar:
    mov [si],al
    inc si   
    jmp capturar
continuarSiguiente:    
endm


CaptuararCadena macro nombreCadena
Local capturar continuarSiguiente        
    mov si, offset nombreCadena
    mov ax,0
    mov cx,0
    mov ah,1
capturar:
    int 21h
    cmp al,13
    je continuarSiguiente 
    mov [si],al
    inc si
    inc cl
    jmp capturar
continuarSiguiente:    
endm

mostrarEnSistemaAx macro sistema
Local ciclo mostrar
      
    mov cx,0
    mov dx,0      
    mov bx,sistema
ciclo:
    mov dx,0    
    div bx
    mov si,ax    
    add dl,30h
    inc cx
    push dx
    cmp ax,0
    je mostrar
    
    mov ax,si
    jmp ciclo
mostrar:
    pop dx
    mov ah,2
    int 21h
    loop mostrar
        
endm


org 100h
    mov cx,0
    mostrarPantalla etiquetaNIT    
    CaptuararCadena NIT   
    call salto
    
    mostrarPantalla etiquetaNF    
    CaptuararCadena numeroFactura   
    call salto 
    
    mostrarPantalla etiquetaNautorizacion    
    CaptuararCadena numeroAutorizacion   
    call salto
    
    mostrarPantalla etiquetanombre          
    compararYcapturar 96 122 nombre
    call salto
    
    
    mostrarPantalla etiquetamonto     
    CaptuararCadena monto   
    call salto
    
    mostrarPantalla etiquetafecha    
    compararYcapturar 47 57 fecha   
    call salto
    
    mostrarPantalla etiquetacodigo
    
    mov ax,0
    mov cx,1
    mov si,offset nombre
    mov al,[si]
    sub al,60h
cicloCadenaNombre:    
    inc si
    mov bl,[si]
    cmp bl,'$'
    je  siguienteComponente
    sub bl,60h
    add al,bl
    inc cl    
    jmp cicloCadenaNombre
    
siguienteComponente:    
    div cl
    mov ah,0
    mostrarEnSistemaAx 10
    
    mov dx,0
    mov ax,0
    mov cx,0
    mov bx,10
    mov si,offset fecha
sumarDigitosFecha:    
    mov al,[si]
    cmp al,'$'
    je  siguienteComponente2 
    sub al,30h
    inc si       
    mul bl
    mov cl,[si]
    sub cl,30h
    inc si
    add al,cl
    add al,dl
    mov dl,al
    jmp sumarDigitosFecha 
siguienteComponente2:
    mov ah,0
    mov al,dl
    mov dx,0
    mostrarEnSistemaAx 10
    
    mov ax,0
    mov dx,0
    mov si,offset NIT
    mov ah,2
    mov dl,[si]
    int 21h
    inc si     
    mov dl,[si]
    int 21h
    
    
    
    

fin: int 20h

NIT db 20 dup('$')
numeroFactura db 20 dup('$')
numeroAutorizacion db 20 dup('$')
nombre db 20 dup('$')
monto db 20 dup('$')
fecha db 20 dup('$')
codigoControl db 20 dup('$')



etiquetaNIT db 'NIT: $'
etiquetaNF db 'numero factura: $'
etiquetaNautorizacion db 'numero autorizacion: $'
etiquetanombre db 'nombre Cliente: $'
etiquetamonto db 'monto: $'
etiquetafecha db 'fecha: $'
etiquetacodigo db 'codigo control: $' 


salto proc
    mov ax,0
    mov dx,13
    mov ah,2
    int 21h  
    mov dx,10    
    int 21h
    ret
salto endp




