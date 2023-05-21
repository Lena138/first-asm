.model small
.stack
.data
	gro	db	'Group 4$'
	Na   	db  	'Enter name: $'
	Me   	db  	'Welcome, $'
	Rr   	db  	'Error, press any key to reboot the program$'
	Bo   	db  	'Rebooting failed. Please exit the program$'
	newline db 	0ah,0dh,'$'
	buff 	db	20,?,20 dup(?) 
	temp 	db	20 dup(?)
	grow	db	5
	gcol	db	10
	dash	db	57 dup ('-'), '$'
	row	db	0
	col	db	0
.code
main	proc
	mov ax,@data	
	mov ds,ax		
	mov es,ax		

	call cls		;clears whole screen

	call move		;animates title (group) / box bg

	mov row,10		;cursor position
	mov col,32
	call cursor
	
	call input		;enter name prompt

	call time		;wait for crash (timer)

	mov row,10		;cursor position
	mov col,20
	call cursor

	call glitch		;glitch Error message

	mov row,15		;cursor position
	mov col,40
	call cursor

	call mess		;message / character input

	mov row,10		;cursor position
	mov col,20
	call cursor

	call boot		;reboot message

	mov row,22		;cursor position
	mov col,20
	call cursor

	call down		;to make the input prompt at the end at the bottom


	mov ah,4ch		;exit
	int 21h
main	endp

;;;;;Clears Whole Screen;;;;;

cls	proc
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
cls	endp

;;;;;Cursor Position;;;;;

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

;;;;;Title;;;;;

move	proc
	push ax
	push bx
	push cx
	mov cx,1		;Counter per cycle

cycle:	push cx			;holds cycle counter
	mov cx,27		;Counter to move

line:	push cx			;holds line counter

	push ax			;Box Bg
	push bx
	push cx
	mov ah,6
	mov al,0
	mov bh,01110000b
	mov ch,3
	mov cl,10
	mov dh,21
	mov dl,70
	int 10h
	pop cx
	pop bx
	pop ax

	mov ah,2		;Set cursor position
	mov bh,0
	mov dh,grow		
	mov dl,gcol		
	int 10h

	mov ah,9		;Print string
	mov dx,offset gro	
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

	push ax			;cursor for dashes
	push bx
	push cx
	mov ah,2
	mov bh,0
	mov dh,8
	mov dl,12
	int 10h
	pop cx
	pop bx
	pop ax

	mov ah,9		;print dashes
	mov dx,offset dash
	int 21h

	pop cx
	pop bx
	pop ax
	ret
move	endp

;;;;;Input;;;;;

input	proc
	push ax
	push bx
	push cx
	mov ah,9		; display 'Enter name'
	mov dx,offset Na
	int 21h

	mov ah,0ah		; get string input
	mov dx,offset buff  	; input string will be stored in 'buff'
	int 21h
	
	mov si,offset buff	
	mov di,offset temp	

	inc si			
	lodsb    			
	mov ch,0
	mov cl,al		
again:	movsb			
	loop again

	mov al,'$'		;appends the $ at the end of the string
	stosb

	mov ah,2		;cursor
	mov bh,0
	mov dh,13
	mov dl,32
	int 10h

	mov ah,9		;display 'Hello'
	mov dx,offset Me
	int 21h
	mov dx,offset temp 	;display the string in 'temp'
	int 21h	 

	pop cx
	pop bx
	pop ax
	ret
input	endp

;;;;;Time;;;;;

time	proc
	mov cx,50		;speed
yy:	push cx			;holds y counter
	mov cx,0ffffh		
xx:	loop xx
	pop cx			;gets y counter
	loop yy
	ret
time	endp

;;;;;Glitch;;;;;

glitch	proc
	push ax			
	push bx
	push cx

	push ax			;Box Bg
	push bx
	push cx
	mov ah,6
	mov al,0
	mov bh,11110000b
	mov ch,3
	mov cl,10
	mov dh,21
	mov dl,70
	int 10h
	pop cx
	pop bx
	pop ax

	mov ah,9		; display 'Error, ..."
	mov dx,offset Rr
	int 21h

	pop cx
	pop bx
	pop ax
	ret
glitch	endp

;;;;;Message Input;;;;;

mess	proc
	push ax
	push bx
	push cx

	mov ah,1
	int 21h			;key pressed

	push ax
	mov ah,9
	mov dx,offset newline
	int 21h
	pop dx

	pop cx
	pop bx
	pop ax
	ret
mess	endp

;;;;;Reboot Message;;;;;

boot	proc
	push ax
	push bx
	push cx

	push ax			;Box Bg
	push bx
	push cx
	mov ah,6
	mov al,0
	mov bh,11110000b
	mov ch,3
	mov cl,10
	mov dh,21
	mov dl,70
	int 10h
	pop cx
	pop bx
	pop ax

	mov ah,9		;display 'Rebooting, ..."
	mov dx,offset Bo
	int 21h

	pop cx
	pop bx
	pop ax
	ret
boot	endp

;;;;;Place Prompt at The Bottom;;;;;

down	proc
	push ax
	push bx
	push cx

	MOV ah,11110000b
	MOV al,56 		;random letter
	STOSW
	int 20

	pop cx
	pop bx
	pop ax
	ret
down	endp                                 

end	main