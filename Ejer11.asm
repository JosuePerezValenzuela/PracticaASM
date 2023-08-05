org 100h
inicio:
mov ah,9
mov dx,offset ingresoNom
int 21h
mov si,offset panada
call ingresoLit
call saltoLin
mov ah,9
mov dx,offset ingresoApe
int 21h
mov si,offset panada
call ingresoLit
call saltoLin
mov ah,9
mov dx,offset ingresoCi
int 21h
mov si,offset panada
call ingresoNum
call saltoLin
mov ah,9
mov dx,offset ingresoTelef
int 21h
mov cx,0
mov si,offset telefIng
call ingresoNum
call saltoLin
mov ah,9
mov dx,offset ingresoBar
int 21h
mov si,offset barrioIng
call ingresoLit
mov si,offset telefIng
cicloTelef:
cmp [si],'4'
je verBarrio
jmp noFac
verBarrio:
cmp ch,8
jb noFac
mov di,offset barrio1
call verifBarrio
cmp dh,1
je esFac
mov di,offset barrio2
call verifBarrio
cmp dh,1
je esFac
mov di,offset barrio3
call verifBarrio
cmp dh,0
je noFac
esFac:
mov ah,9
mov dx,offset sies
int 21h
jmp fin
noFac:
mov ah,9
mov dx,offset noes
int 21h
fin: int 20h
ingresoNom db "Ingrese su nombre",10,13,'$'
ingresoApe db "Ingrese sus apellidos",10,13,'$'
ingresoCi db "Ingrese su numero de CI",13,10,'$'
ingresoTelef db "Ingrese su telefono",10,13,'$'
ingresoBar db "Ingrese su barrio",10,13,'$'
sies db 13,10,"Factible",'$'
noes db 13,10,"No factible",'$'
panada db 40 dup(' ')
telefIng db 8 dup('$')
barrioIng db 15 dup('$')
barrio1 db "Cala cala$"
barrio2 db "Petrolero$"
barrio3 db "Profesional$"
proc verifBarrio
mov si,offset barrioIng
cicloBarrio:
cmp [di],'$'
je todoBien
mov bh,[di]
cmp [si],bh
jne otro
inc si
inc di
jmp cicloBarrio
todoBien:
mov dh,1
jmp finVerif
otro:
mov dh,0
finVerif:
ret
verifBarrio endp
proc saltoLin
mov ah,2
mov dl,13
int 21h
mov dl,10
int 21h
ret
saltoLin endp
proc ingresoLit
cicloLetras:
mov ah,7
int 21h
cmp al,13
je finIng1
cmp al,' '
je imprimir
cmp al,'A'
jb cicloLetras
cmp al,'['
jb imprimir
cmp al,'a'
jb cicloLetras
cmp al,'z'
ja cicloLetras
imprimir:
mov [si],al
inc ch
inc si
mov dl,al
mov ah,2
int 21h
jmp cicloLetras
finIng1:
ret
ingresoLit endp
proc ingresoNum
ciclo:
mov ah,7
int 21h
cmp al,13
je finIng
cmp al,'0'
jb ciclo
cmp al,'9'
ja ciclo
mov ah,2
mov [si],al
inc si
inc cl
mov dl,al
int 21h
jmp ciclo
finIng:
ret
ingresoNum endp