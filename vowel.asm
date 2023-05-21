.model small
.stack 100h
.data
	map	db	'MAPUA$'
	grow	db	5
	gcol	db	10
	row 	db 	0
	col 	db	0

.code
main proc
	mov ax,@data	
	mov ds,ax		
	mov es,ax	

	call screen

	call what
	

	mov row,0		;cursor position
	mov col,0
	call cursor

	mov ah,4ch		;exit
	int 21h
main	endp

;;;;SCREEN;;;;
screen  proc
	push ax
	mov ah,6
	mov al,0
	mov bh,7		
	mov ch,0
	mov cl,0
	mov dh,24
	mov dl,79
	int 10h
	pop ax
	ret
screen endp

;;;;PLACE;;;;
cursor	proc
	push ax
	push bx
	push dx
	mov ah,2
	mov bh,0
	mov dh,row
	mov dl,col
	int 10h
	pop dx
	pop bx
	pop ax
	ret
cursor	endp

;;;;STRING;;;;

what	proc
	push ax
	push bx
	push cx
	mov cx,1		;Counter per cycle

cycle:	push cx			;holds cycle counter
	mov cx,5		;Counter to move

line:	push cx			;holds line counter

mov ah,2		;Set cursor position
	mov bh,0
	mov dh,grow		
	mov dl,gcol		
	int 10h

	mov ah,9		;Print string
	mov dx,offset map
	int 21h	

	inc gcol

	mov cx,7 		;speed
y:	push cx			;holds y counter
	mov cx,0ffffh		
x:	loop x
	pop cx			;gets y counter
	loop y

	pop cx			;gets line counter
	loop line

	mov col,0		;reinitialize
	pop cx			;gets cycle counter
	loop cycle

	
	int 10h
	

	pop cx
	pop bx
	pop ax
	ret
what	endp

end main

  