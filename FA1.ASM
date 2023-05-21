.model small
.stack
.code
main 		proc
		mov cx,3
		mov ah,2
		mov dl,"A"
outer:	int 21h
		push cx
		push dx
		mov cx,1
		mov dl,"1"
		int 21h
		inc dl
inner:	int 21h
		add dl,1
		loop inner
		int 21h
		mov dl,"*"
		int 21h
		pop dx
		pop cx
		add dl,1
		loop outer
		mov ah, 4ch
		int 21h
main 		endp
end main
		