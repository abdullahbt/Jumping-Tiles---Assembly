[org 0x0100]

jmp start

message2: db "Are you sure you want to exit?"
message3: db "Press Y (YES) to confirm"
message4: db "Press N (NO) to continue"
message5: db "                    "
message6: db "GAME IS PAUSED"
RowToMove4:dw 23
RowToMove1: dw 20
RowToMove2:dw 21
RowToMove3: dw 22
buffer: times 4000 dw 0
buffer1: dw 0
buffer2: dw 0
Score: dw 0
ScorePosition: dw 3192
Scorerow: dw 19
oldkb: dd 0
rabbit2: dw 3584
rabbitL1: dw 3588
rabbitL2: dw 3584
message1: db 'Game Over'
length1: dw 9
brickRow: dw 20
brickCol: dw 32
lowerbrickRow: dw 23
lowerbrickCol: dw 32
currentCoinLocation:dw 3104
yes: dw 0
no: dw 0
escape: dw 0
message7: db "Game Over$"
message8: db 'Score = '
nameBuffer: times 81 db 0
startmessage1: db "Welcome to Jumping Rabbit ",0
startmessage2: db "About the Game: ",0
startmessage3: db "There are moving tiles ",0
startmessage4: db "You have to jump on to the tiles",0
startmessage7: db "Tiles will start moving faster once your score is 5",0
startmessage6: db "A coin is placed at random locations, collect them = +1 score ",0
startmessage8: db "Press Any Key To Start ",0
startmessage9: db "22L-6917 Abdullah bin Tariq",0
message_1: db "Enter Your Name   :  $"


Delay:      push cx
			mov cx, 0xFFFF
loop2:		loop loop2
			; mov cx, 0xFFFF
loop3:		loop loop3
			mov cx,0xFFFF
			
loop4:		loop loop4
			mov cx,0xFFFF

loop5:		loop loop5
			mov cx,0xFFFF
			
; loop6:		loop loop6
			; mov cx,0xFFFF

; loop7:		loop loop7
			; mov cx,0xFFFF

; loop8:		loop loop8
			; mov cx,0xFFFF



; loop9:		loop loop9
			pop cx
			ret

Delay2:      push cx
			mov cx, 0xFFFF
loop21:		loop loop21
			; mov cx, 0xFFFF
loop31:		loop loop31
			mov cx,0xFFFF
			
; loop41:		loop loop41
			; mov cx,0xFFFF

; loop51:		loop loop51
			mov cx,0xFFFF
			
; loop6:		loop loop6
			; mov cx,0xFFFF

; loop7:		loop loop7
			; mov cx,0xFFFF

; loop8:		loop loop8
			; mov cx,0xFFFF



; loop9:		loop loop9
			pop cx
			ret



		
printnum: push bp
				mov bp, sp
				push es
				push ax
				push bx
				push cx
				push dx
				push di

				mov ax, 0xb800
				mov es, ax			; point es to video base

				mov ax, [bp+4]		; load number in ax= 4529
				mov bx, 10			; use base 10 for division
				mov cx, 0			; initialize count of digits

nextdigit:		mov dx, 0			; zero upper half of dividend
				div bx				; divide by 10 AX/BX --> Quotient --> AX, Remainder --> DX ..... 
				add dl, 0x30		; convert digit into ascii value
				push dx				; save ascii value on stack

				inc cx				; increment count of values
				cmp ax, 0			; is the quotient zero
				jnz nextdigit		; if no divide it again


				mov di, [bp+6]	 	; point di to top left column
nextpos:		pop dx				; remove a digit from the stack
				mov dh, 0x07		; use normal attribute
				mov [es:di], dx		; print char on screen
				add di, 2			; move to next screen location
				loop nextpos		; repeat for all digits on stack

				pop di
				pop dx
				pop cx
				pop bx
				pop ax
				pop es
				pop bp
				ret 4


printstr:	push bp
			mov bp, sp
			push es
			push ax
			push cx
			push si
			push di

			mov ax, 0xb800
			mov es, ax				; point es to video base
			mov di, 160				; point di to top left column
									; es:di --> b800:0000
			mov si, [bp+4]			; point si to string
			mov cx, 9			; load length of string in cx
			mov ah, 0x07			; normal attribute fixed in al
			
nextchar2:	mov al, [si]			; load next char of string
			mov [es:di], ax			; show this char on screen
			add di, 2				; move to next screen location
			add si, 1				; move to next char in string			
			loop nextchar2			; repeat the operation cx times
			
			pop di
			pop si
			pop cx
			pop ax
			pop es
			pop bp
			ret 4
strlen: push bp
		mov bp,sp
		push es
		push cx
		push di
		les di, [bp+4] ; point es:di to string
		mov cx, 0xffff ; load maximum number in cx
		xor al, al ; load a zero in al
		repne scasb ; find zero in the string
		mov ax, 0xffff ; load maximum number in ax
		sub ax, cx ; find change in cx
		dec ax ; exclude null from length
		pop di
		pop cx
		pop es
		pop bp
		ret 4
PrintStartScreen: 
					pusha  ;push all general purpose registers
                    push es
                    mov ax , 0xb800
                    mov es , ax
                    call PrintBlack

		            mov dx , message_1
		            mov ah,9  ;write string
		            int 0x21
                    mov ax , 1
                    mov cx , 0x0b
                    mul cx
                    add ax , 0x10
                    shl ax , 1
                    mov di , ax
                    mov bx , 20
                    mov si , ax

                    mov si , nameBuffer
nextcharr:
                    mov ah , 1 ;read character
                    int 0x21
                    cmp al, 13 ;is enter pressed 
                    je pauseexit1
                    mov [si], al
                    inc si
                    loop nextcharr
pauseexit1:         mov byte [si], 0  ;null terminated string 
                    mov ax , 0x7020

					call PrintGreen
	            	push ds
                    push nameBuffer
                    call strlen
                    cmp ax , 0
                    je pauseExit2
                    mov bl , 0x70 ;color
                    mov  bh , 0  ;print on page 0
                    push ds
                    pop es
                    mov cx , ax

                    mov ah , 13h
                    mov al , 1
                    mov bp , nameBuffer
                    mov dh , 0x05
					mov dl , 0x35
                    int 0x10
                    push ds
                    push startmessage1
                    call strlen
                    cmp ax , 0
                    je pauseExit2
                    mov bl , 0x70
                    mov bh , 0
                    push ds
                    pop es
                    mov cx,ax

                    mov ah , 13h
                    mov al , 1
                    mov bp , startmessage1
					mov dh, 5
					mov dl,25
                    int 0x10
                    push ds
                    push startmessage2
                    call strlen
                    cmp ax , 0
                    je pauseExit2
                    mov bl , 0x70
                    mov bh , 0
                    push ds
                    pop es
                    mov cx , ax

                    mov ah , 13h
                    mov al , 1
                    mov bp , startmessage2
                    mov dh, 8
					mov dl,30
                    int 0x10
                    push ds
                    push startmessage3
                    call strlen
                    cmp ax , 0
                    je pauseExit2
                    mov bl , 0x70
                    mov bh ,0
                    push ds
                    pop es
                    mov cx , ax

                    mov ah , 13h
                    mov al , 1
                    mov bp , startmessage3
                    mov dh, 10
					mov dl,30
                    int 0x10


                   push ds
                   push startmessage4
                   call strlen
                   cmp ax , 0
                   je pauseExit2
                   mov bl , 0x70
                   mov bh , 0
                   push ds
                   pop es
                   mov cx , ax

                   mov ah , 13h
                   mov al , 1
                   mov bp , startmessage4
                   mov dh,12
				   mov dl,30
                   int 0x10
				   
                  

				   
                   push ds
                   push startmessage6
                   call strlen
                   cmp ax , 0
                   je pauseExit2
                   mov bl , 0x70
                   mov bh , 0
                   push ds
                   pop es
                   mov cx , ax

                   mov ah , 13h
                   mov al , 1
                   mov bp , startmessage6
                   mov dh,15
				   mov dl,10
                   int 0x10
				   
                
					
                    push ds
                    push startmessage7
                    call strlen
                    cmp ax,0
                    je pauseExit2
                    mov bl,0x70
                    mov  bh,0
                    push ds
                    pop es
                    mov cx,ax

                    mov ah,13h
                    mov al,1
                    mov bp, startmessage7
                    mov dh, 18
					mov dl,20
                    int 0x10
					
                    push ds
                    push startmessage8
                    call strlen
                    cmp ax,0
                    je pauseExit2
                    mov bl,0xBf
                    mov  bh,0
                    push ds
                    pop es
                    mov cx,ax

                    mov ah,13h
                    mov al,1
                    mov bp,startmessage8
                    mov dh, 21
					mov dl,20
                    int 0x10
					
                    push ds
                    push startmessage9
                    call strlen
                    cmp ax,0
                    je pauseExit2
                    mov bl,0x3f
                    mov  bh,0
                    push ds
                    pop es
                    mov cx,ax

                    mov ah,13h
                    mov al,1
                    mov bp, startmessage9
                    mov dh, 2
					mov dl,27
                    int 0x10
                  

pauseExit2:              mov ah, 1 ;read character
                    int 0x21
                    pop es
                    popa
                    ret
			
RestoreBuffer:	push es
				push ds
				push ax
				push cx
				push di
				push si

				mov si , buffer
				push cs
				pop ds
				mov ax , 0xb800
				mov es , ax
				mov di , 0
				mov cx , 4000
				cld
				rep movsw

				pop si
				pop di
				pop cx
				pop ax
				pop ds
				pop es
				ret


StoreinBuffer:
				push es
				push ds
				push ax
				push cx
				push di
				push si

				mov di , buffer
				push cs
				pop es
				mov ax , 0xb800
				mov ds , ax
				mov si , 0
				mov cx , 4000
				cld
				rep movsw

				pop si
				pop di
				pop cx
				pop ax
				pop ds
				pop es
				ret
PrintBlack:				push es
						push ax
						push cx
						push di

						mov ax , 0xb800
						mov es , ax
						mov di , 0
						mov cx, 4000
						mov ah , 0x07
						mov al , ' '

						rep stosw

						pop cx
						pop di
						pop ax
						pop es
						ret

PrintGreen:				push es
						push ax
						push cx
						push di

						mov ax , 0xb800
						mov es , ax
						mov di , 0
						mov cx, 4000
						mov ah , 0x20
						mov al , ' '

						rep stosw

						pop cx
						pop di
						pop ax
						pop es
						ret						

PrintEndScreen:
                    pusha
                    push bp
                    push es

                    ;call PrintPauseScreen

					call PrintBlack
					
					mov al , 0
					mov bh , 0
					mov bl , 0x17
					mov cx , 9
					mov dl , 34
					mov dh , 11
					mov bp , message7
					push cs
					pop es
					mov ah , 0x13
					int 0x10
					
					mov bl , 0x30
					mov cx , 8
					mov dh , 13
					mov bp , message8
					int 0x10
					
					push 2166
					mov ax,[cs:Score]
					dec ax
					push ax
					call printnum
					pop es
                    pop bp
                    popa
					ret
						
PrintPauseScreen: 
					push ax
					push bx
					push cx
					push dx
					push bp
					push es

					call StoreinBuffer
					call PrintBlack

					mov al, 0  ;video service
					mov bh, 0
					mov bl , 0x6F  ;colors
					mov cx , 30 ;length of string
					mov dl , 30  ;column
					mov dh , 6  ;row
					mov bp , message2
					push cs
					pop es
					mov ah , 0x13 ;print string service
					int 0x10

					mov cx , 24
					mov dl , 30
					mov dh , 9
					mov bp , message3
					int 0x10

					mov cx , 24
					mov dl , 30
					mov dh,10
					mov bp , message4
					int 0x10

					mov cx , 14
					mov dh , 1
					mov dl , 30
					mov bp , message6
					int 0x10

userInput:			
					cmp word[cs:yes] , 1
					je mainexit

					cmp word [cs:no] , 1
					; call Delay
					jne userInput
			

					mov word [cs:no] , 0
					mov word [cs:escape] , 0
					call RestoreBuffer

					pop es
					pop bp
					pop dx
					pop cx
					pop bx
					pop ax
					ret

kbisr: 

		push ax
	   in al,0x60
	   cmp al,0x39
	   je swapRows
	   
	   cmp al,0x01 ;is esc pressed
	   jne nextt
	   mov word[cs:escape],1
	   ;jmp exit
	   ;if esc,label=1
nextt:  cmp al,0x15  ; is Y pressed 
	   jne checkN
	   mov word[cs:yes],1
	   ;jmp exit
	   
checkN: 
		cmp word [cs:escape] , 1
		jne nomatch
		cmp al,0x31 ;is N pressed 
		jne nomatch
	    mov word[cs:no],1
		;jmp exit
nomatch:
	pop ax
	jmp far[cs:oldkb]
	  
exit: mov al,0x20
	  out 0x20,al
	  pop ax
	  iret

start:
			; mov ah,0x00
			; mov al, 0x54
			; int 0x10

			call PrintStartScreen

	call PrintMainScreen
	xor ax, ax
	mov es, ax ; point es to IVT base

	mov ax, [es:9*4]
	mov [oldkb], ax ; save offset of old routined
	mov ax, [es:9*4+2]
	mov [oldkb+2], ax ; save segment of old routine

	cli ; disable interrupts
	mov word [es:9*4], kbisr ; store offset at n*4
	mov [es:9*4+2], cs ; store segment at n*4+2
	sti ; enable interrupt

infinite:
    
	call Animations
	jmp infinite
 
 

mainexit: 
call PrintEndScreen

		; xor ax, ax
		; int 0x16

		mov ah, 0
		mov al, 3
		int 0x10
 
mov dx,start
add dx,15
mov cl,4
shr dx,cl
	


mov ax,0x4c00
int 0x21
 
 
PrintGame:
	push es
	push ax
	push di
	push si
	push cx

mov ax,0xb800
mov es,ax

DisplayScore:

mov ax,0xb800
mov es,ax
mov di,3180
mov word[es:di],0x0753
add di,2
mov word[es:di],0x0763
add di,2
mov word[es:di],0x076f
add di,2
mov word[es:di],0x0772
add di,2
mov word[es:di],0x0765
add di,2
mov word[es:di],0x073A
add di,2
; mov word[es:di],0x0730
push di
push word [cs:Score]
call printnum

mov ax,0xb800
mov es,ax
mov di, 3264

brick:
mov word[es:di],0x4020
add di,2
cmp di,3290
jne brick


mov di, 3744

brick2:

mov word[es:di],0x1020
add di,2
cmp di,3770
jne brick2

rabbit:
mov di, [cs:rabbit2]
mov word[es:di],0x202F
add di,4
mov word[es:di],0x205C
sub di,162
mov word[es:di],0x7022
add di,2
mov word[es:di],0x202D
sub di,4
mov word[es:di],0x202D

pop cx
pop si
pop di
pop ax
pop es

ret

swapRows:
	                push bp
					push es
					push ds
					push ax
					push si
					push di
					push cx
					push dx
					push bx    
					
                mov ax,0xb800
				mov es,ax
				mov ds,ax
				mov ax,[cs:RowToMove1]
				mov bx,80
				mul bx
				shl ax,1
				mov si,ax
				mov ax,[cs:RowToMove4]
				mov bx,80
				mul bx
				shl ax,1
				mov di,ax
				mov cx,80
			loop1:
				
				mov ax,[es:si]
				mov bp,[es:di]
				mov [es:si],bp
				mov [es:di],ax
				add di,2
				add si,2
				loop loop1
			; mov di,[cs:currentCoinLocation]
			; mov ax,[es:di]
			; add di, 480
			; mov [es:di],ax
			; mov [cs:currentCoinLocation],di
			inc word[cs:Score]
				
			call delay
				
				mov ax,80
				; mov di,[RowToMove1]
				mul word[cs:RowToMove1]
				shl ax,1
				mov di,ax
				mov al,0x20
				mov cx,80
				; jmp loop212
				
		; jmpabove: add di,1
				
				; loop212:
				; cmp byte [es:di],al
				; jne jmpabove
				
				cld
				repne scasb 
				sub di,3200
				shr di,1
				mov word [cs:brickCol],di
				
				mov ax,80
				; mov di,[RowToMove1]
				mul word[cs:RowToMove4]
				shl ax,1
				mov di,ax
				mov al,0x20
				mov cx,80
				cld
				repne scasb 
				sub di,3680
				shr di,1
				sub di,1
				mov word [cs:lowerbrickCol],di

				
                  	pop bx
                    pop dx
                    pop cx
                    pop di
                    pop si
                    pop ax
                    pop ds
					pop es	
					pop bp
					
				
			jmp checkJump		
			
; Print_GameOver:
 ; call clrscr
	
		; mov ax,0xb800
		; mov es,ax
		; mov di,1670
		; mov ah,0x87
		; mov al,'G'
		; mov [es:di],ax
		; add di,2
		; mov al,'a'
		; mov [es:di],ax
		; add di,2
		; mov al,'m'
		; mov[es:di],ax
		; add di,2
		; mov al,'e'
		; mov[es:di],ax
		; add di,2
		; mov al,' '
		; mov[es:di],ax
		; add di,2
		; mov al,'O'
		; mov[es:di],ax
		; add di,2
		; mov al,'v'
		; mov[es:di],ax
		; add di,2
		; mov al,'e'
		; mov[es:di],ax
		; add di,2
		; mov al,'r'
		; mov[es:di],ax

; mov ax,0x4c00
; int 0x21
				

checkJump:
; push ax
; push es
; push di
; push si
; push bx
mov ax,0xb800
mov es,ax
mov bx,0x272D
mov di,[cs:rabbitL1]
mov si,[cs:rabbitL2]
add di,160
add si,160
cmp [es:di],bx
je mainexit

jmp exit




BrickMovement:
	push bp
	push ax
	push bx
	push cx
	push dx
	push si
	push di
    
	jmp l12
	
whichdelay: cmp word[cs:Score],5
			jb normalone
			call Delay2
			jmp l13
			
normalone: 
		  call Delay
		   jmp l13

		
		
	
l12:
cmp word[cs:brickCol],27
jbe shiftright

cmp word[cs:brickCol],40
jae shiftleft

; cmp word[cs:brickCol],32
; jb shiftleft

dec word[cs:lowerbrickCol]


shiftright: 
mov ax,[cs:brickRow]
push ax
mov ax,[cs:brickCol]
push ax
call slideright
mov ax,[cs:lowerbrickRow]
push ax
mov ax,[cs:lowerbrickCol]
push ax
call slideleft
jmp whichdelay
l13:
inc word[cs:brickCol]
dec word[cs:lowerbrickCol]
cmp word[cs:brickCol],40
jne shiftright

inc word[cs:lowerbrickCol]
dec word[cs:brickCol]

shiftleft:
mov ax,[cs:brickRow]
push ax
mov ax,[cs:brickCol]
; add ax,10
push ax
call slideleft
mov ax,[cs:lowerbrickRow]
push ax
mov ax,[cs:lowerbrickCol]
push ax
call slideright
call Delay
inc word[cs:lowerbrickCol]
dec word[cs:brickCol]
cmp word[cs:brickCol],26
jne shiftleft

inc word[cs:brickCol]
dec word[cs:lowerbrickCol]

	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	pop bp

    ret	


	
slideleft:
push bp
mov bp,sp
push ax
push ds
push es
push di
push si
push cx

mov ax,0xb800
mov es,ax
mov ds,ax

mov ax,80
mul word[bp+6]
add ax, word[bp+4]
add ax,13
shl ax,1
push ax
mov di,ax
mov si,ax
sub di,2

mov cx,13
std
rep movsw

pop di
mov word[es:di],0x272D

pop cx
pop si
pop di
pop es
pop ds
pop ax
pop bp
ret 4


slideright:
push bp
mov bp,sp
push ax
push ds
push es
push di
push si
push cx

mov ax,0xb800
mov es,ax
mov ds,ax

mov ax,80
mul word[bp+6]
add ax, word[bp+4]
shl ax,1
push ax
mov di,ax
mov si,ax
add di,2

mov cx,13
cld
rep movsw

pop di
mov word[es:di],0x272D

pop cx
pop si
pop di
pop es
pop ds
pop ax
pop bp
ret 4


RoadPrinting:
	push bp
	push di
	push si
	mov di,1280 ;starting point
	mov si,1438    ;ending point
	push si
	push di
	call road
			
	pop si 
	pop di					
	pop bp					 
	ret	
road:
	push bp
	mov bp, sp
	push es
	push ax
	push di
	
	mov di,[bp+4]
	mov si,[bp+6]
	mov ax,0xb800
	mov es,ax
	
edge1:
	mov word[es:di],0x0020
	mov word[es:si],0x0020
	add di,2
	sub si,2
	cmp di,si
	jna edge1
	
	mov di,[bp+4]
	mov si,[bp+6]
	add di,160
	add si,1440
	
mainRoad:
	
	mov word[es:di],0x7820
	mov word[es:si],0x7820
	add di,2
	sub si,2
	cmp di,si
	jna mainRoad
	sub di,80
	add si,80
stripes:
	mov word[es:di],0x765F
	mov word[es:si],0x765F
	add di,4
	sub si,4
	cmp di,si
	jna stripes
	
	
	mov di,[bp+4]
	mov si,[bp+6]
	add di,1600
	add si,1600
	
edge2:
	mov word[es:di],0x0020
	mov word[es:si],0x0020
	add di,2
	sub si,2
	cmp di,si
	jna edge2
	

	pop di
	pop ax
	pop es
	pop bp
	ret 4
	
CarsPrinting:       					   ;	
	push bp
	push di
	push si

				   ;					   ;	
	mov di, 2130				   ;	Ending Point
	push di					   ;
	mov si, 2104				   ;	Staring Point
	push si				  	   ;
	call Print_Cars		           ;
						   ;
	mov di, 2554				   ;	Ending Point
	push di					   ;
	mov si, 2530				   ;	Staring Point
	push si				  	   ;
	call Print_Cars		           ;
				
	mov di, 2670				   ;	Ending Point
	push di					   ;
	mov si, 2640				   ;	Staring Point
	push si				  	   ;
	call Print_Cars		           ;
							
				;
	pop si							;
	pop di					;
	pop bp					   ;
	ret					   ;
				
Print_Cars:
	push bp
	mov bp, sp
	push es
	push ax
	push si
	push di
	
	mov di, [bp+6]
	mov si, [bp+4]
	
mov ax,0xb800
mov es,ax

mov word[es:di], 0xE0db
mov word[es:di],0xE60b
mov word[es:si],0x04db
sub di,2
add si,2
layer_1:		
		
		mov word [es:di], 0x04DB
		mov word [es:si], 0x04DB
		add si, 2
		sub di, 2
		cmp si, di
		jna layer_1
	;--------------------------------------------------------------------	
		mov di, [bp+6]
		mov si, [bp+4]	
		sub di, 160
		sub si, 160 

		sub di, 4
		add si, 4
		mov word [es:di], 0x04DB
		mov word [es:si], 0x04DB
		
	; --------------------------------------------------------------------	
	layer_2:		
		mov word [es:di], 0x04DB
		mov word [es:si], 0x04DB
		add si, 2
		sub di, 2
		cmp si, di
		jna layer_2
	;--------------------------------------------------------------------	

		mov di, [bp+6]
		mov si, [bp+4]	
		sub di, 320
		sub si, 320 

		sub di, 8
		add si, 8
		mov word [es:di], 0x04DB
		mov word [es:si], 0x04DB
	
		sub di, 8
		add si, 8
		mov word [es:di], 0x04DB
		mov word [es:si], 0x04DB
		
		mov di, [bp+6]
		mov si, [bp+4]
				
		sub di, 320
		sub si, 320
		sub di, 8
		add si, 8

	; --------------------------------------------------------------------
	layer_3:		
		mov word [es:di], 0x00db
		mov word [es:si], 0x00db
		add si, 2
		sub di, 2
		cmp si, di
		jna layer_3
	
	tyres:
		add si,500
		add di,500
		sub si,26
		sub di,14
		mov word[es:di],0x704F
		mov word[es:si],0x704F

		pop di
		pop si
		pop ax
		pop es
		pop bp
		ret 4
		
Print_Greenry:	
	push es
	push ax
	push di
	push cx
		
	mov di,3040
	mov ax, 0xb800
	mov es, ax	
	l1:
	mov word[es:di],0x272D
	add di,2
	cmp di,4000
	jne l1
	
	pop cx
	pop di
	pop ax
	pop es
	ret

Print_Coins:	
	push es
	push ax
	push di
	push cx

    mov ax,0xb800
	mov es,ax
	mov di, [currentCoinLocation]
	mov word [es:di],0x264F
	
	pop cx
	pop di
	pop ax
	pop es
	ret


Cars_Movement:		
	
	push bp
	push ax
	push bx
	push cx
	push dx
	push si
	push di
    
	mov ax, 0xb800
    mov bx, 0
    mov es, ax
    mov ds, ax
    mov ax, 0
    mov dx, 1758	

    right_movement:
        
    	mov cx, 80     
    	mov di, dx
    	mov si, di
    	sub si, 2

    	mov bp, [es:di] 
	
    	std
    	rep movsw

    	add si, 4      
    	mov [es:si] , bp

    	    add dx, 160
    	    add bx, 1
    	    cmp bx, 8

    	jne right_movement
    
	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	pop bp

    ret	
	
Sky_Movements:		

	push bp
	push ax
	push bx
	push cx
	push dx
	push si
	push di

	mov dx, 160
	mov bx, 0
	mov ax, 0xb800
	mov es, ax
	mov ds, ax

	left_movement:

		mov di, dx
		mov si, di
		add si, 2
		mov cx, 80     

		mov bp, [es:di] 

		cld
		rep movsw
		sub si, 4         
		mov [es:si] , bp

		add dx, 160
	    inc bx
	    cmp bx, 9
		jne left_movement

	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	pop bp
    
    ret	

Animations:	
		call delay
 		call Cars_Movement
		call Sky_Movements
		call BrickMovement
		push word [cs: ScorePosition]
		push word[cs: Score]
		call printnum ;print the updated Score
		cmp word[cs:escape],1
		jne exita
		call PrintPauseScreen
exita:		
	ret
	
delay : 		
	push ax
	push cx
	mov ax, 0

	d2:
		loop d2

	d1:			
		add ax, 1
		mov cx, 0xffff
		cmp ax, 0xffff
		jne d1

		mov cx, 0xFFFF
	d4:
		loop d4
	
	pop cx
	pop ax
	ret
	
PrintMainScreen: 

call clrscr
push bp
mov bp,sp

push es
push ax 
push di
push si

mov ax, 0xb800
mov es, ax

mov di,0

Background:

bluesky:
mov word [es:di],0x0BDB
add di,2
cmp di,1280
jne bluesky

sub di,320

desert:
mov word [es:di],0x06DB
add di,2
cmp di,1280
jne desert

mov di,998
mov cx,3
lamp:
mov word [es:di],0x00DB
sub di,160
sub cx,1
cmp cx,0
jne lamp

sub di,2
add di,160
mov word [es:di],0x8EDB

mov di,1078
mov cx,3
lamp2:
mov word [es:di],0x00DB
sub di,160
sub cx,1
cmp cx,0
jne lamp2

sub di,2
add di,160
mov word [es:di],0x8EDB


mov di, 1122
mov si,1152
mov dx,512



building:
mov word[es:di],0xf020
add di,2
cmp di,si
jne building
cmp di,si
je moveup

moveup:
cmp si,dx
je nextbuilding
sub di,190
sub si,160
jmp building

nextbuilding:
add si,680
add di,650
add dx,40
cmp si,1280
jnae building

mov di,1127
mov dx,487

createdoors:
mov word [es:di],0x2006
add di,40
cmp di,1280
jnae createdoors

mov si,976
mov di,972
jmp createwindows


createwindows:

mov word [es:di],0x6F20
add di,2
cmp si,di
jne createwindows

sub si,320
sub di,324

upwindow:
mov word [es:di],0x6F20
add di,2
cmp si,di
jne upwindow

add si,10
add di,6

rightwindow:
mov word [es:di],0x6F20
add di,2
cmp si,di
jne rightwindow

add si,320
add di,316

downwindow:
mov word [es:di],0x6F20
add di,2
cmp si,di
jne downwindow

nextwindow:
add si, 30
add di, 26
cmp si,1120
jnae createwindows

mov di, 1122
mov si, 322

createoutline:
mov word [es:di],0x077C
sub di,160
cmp si,di
jne createoutline

add di,190
add si,990

downward:
mov word[es:di],0x077C
add di,160
cmp si,di
jne downward

nextb:
add si,10
add di,10
sub di,160
sub si,960
cmp si,460
jnae createoutline

call RoadPrinting
call CarsPrinting
call Print_Greenry
call Sky_Surroundings
call Print_Coins
call PrintGame

pop si
pop di
pop ax 
pop es
pop bp


ret


Print_Crow: 				
	push bp
	mov bp, sp
	push es
	push ax
	push si

	mov di, [bp+4]
	mov ax, 0xb800
	mov es, ax					
	
 	mov si, di
	add di, 2
	mov word [es:di], 0xb05c
	add di, 2
	mov word [es:di], 0xb02f
	
	pop si
	pop ax
	pop es
	pop bp
	
	ret 2
	

	
Print_Sun:		
	push bp
	mov bp, sp
	push es
	push ax
	push si

	mov di, [bp+4]
	mov ax, 0xb800
	mov es, ax				
	mov ax, di
	mov cx, 4
			
	sun: 			
		mov word [es:di], 0x0EDB
		add di, 2
		mov word [es:di], 0x0EDB
		sub di, 4
		mov word [es:di], 0x0EDB
		
		pop si
		pop ax
		pop es
		pop bp
		
	ret 2
	
Sky_Surroundings:

	push bp
	push di

	mov di, 150				   ;-
	push di				           ;-
	call Print_Sun                             ;-
						   ;-
	mov di, 166				   ;-
	push di				           ;-
	call Print_Crow	                           ;-
						   ;-
	mov di, 270				   ;-
	push di				           ;-
	call Print_Crow	                           ;-
						   ;-
	mov di, 220				   ;-
	push di				           ;-
	call Print_Crow	                           ;-
						   ;-	
	pop di
	pop bp

	ret					   ;-

	
	

clrscr:
	push ax
	push es
	push di
	
    mov ax, 0xb800 ; load video base in ax
    mov es, ax ; point es to video base
    mov di, 0 ; point di to top left column
nextchar: mov word [es:di], 0x0020 ; clear next char on screen
    add di, 2 ; move to next screen location
    cmp di, 4000 ; has the whole screen cleared
    jne nextchar
	
	pop di
	pop es
	pop ax
    ret

; ending:
	; mov ah,0x20
    ; int 0x20  ; Corrected to int 0x20 for program termination
    ; mov ax, 0x4c00
    ; int 0x21