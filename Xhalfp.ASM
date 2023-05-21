.model small
.stack
.code
main 	proc
	mov cx, 5
x:	mov bx,cx
z:	mov dl,'X'
	mov ah,2
	int 21h
	loop z
	mov dl,0ah
	mov ah,2
	int 21h
	mov dl,0dh
	mov ah,2
	int 21h
	mov cx, bx
	loop x
	mov ah, 4ch
	int 21h
main 	endp
end main