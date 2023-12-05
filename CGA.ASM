;*
;* cga.asm
;* Created: 02 May 2022
;*
; ----------------------------------------------------------------------------
; | Interrupt |     System     | Colours   | Resolution | Video Buffer Addr. |
; |-----------|----------------|-----------|------------|--------------------|    
; |    04h    |       CGA      | 4-color   |  320x200   |       B800         | <--|
; |    06h    |     B&W CGA    | 4-gray    |  640x200   |       B800         | <--|  Supported
; |    09h    | PCjr/Tandy 1000| 16-color  |  320x200   |       B800         | <--|
; |-----------|----------------|-----------|------------|--------------------|
; |    0Dh    |     EGA/VGA    | 16-color  |  320x200   |       A000         |
; |    0Eh    |     EGA/VGA    | 16-color  |  640x200   |       A000         |
; ----------------------------------------------------------------------------

code segment word
assume cs:code,ds:nothing

org 100h

start:				mov		ch, 32			; hide blinking cursor
					mov		ah, 1
					int		10h
					jmp		init_screen

FileName			db		'IMAGE.RAW',0

init_screen:		mov		ah, 0			; Init screen
					mov		ax, 04h			; Set CGA (320x200) mode (04h = CGA, 06h = B&W CGA, 09h = PCjr/T100)
					int 	10h
					
					;mov 	ah, 0Bh			; Set colour palette
					;mov	bx, 0105h		; (cyan, magenta, white) (use 0105h for B&W)
					;int 	10h
					
load_pic:			lea		dx, FileName	; Load image filename
					mov 	ax, 3D00h
					int 	21h
					
					jnb		draw_pic
					int		20h

draw_pic:			;* Write image data to video memory *;
					push	ds
					push	ax
					push	ax
					push	ax
					mov		ax, 0B800h		;B800 = video buffer
					mov		ds,ax
				
					pop		bx
					mov		ah, 3Fh
					mov		cx, 3EA2h
					xor		dx,dx
					int		21h
				
					pop		bx
					mov		ah, 3Eh
					int		21h

					;* Wait for a key to be pressed *;
					xor 	ah,ah
					int 	16h
					jmp		exit

exit:				;* Clear the entire screen *;
					mov		ax, 0600h
					mov		cx, 0000h
					mov		dx, 184fh
					int		10h
					
					;* Show the blinking cursor *;
					mov		ch, 6
					mov		cl, 7
					mov		ah, 1
					int		10h
					
					;* Exit to the DOS prompt *;
					mov		ah, 4Ch
					int		21h

code ends
end start
