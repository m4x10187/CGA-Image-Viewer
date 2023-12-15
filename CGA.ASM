;*
;* cga.asm
;* Created: 02 May 2022
;* Modified: 15 Dec 2023
;*
; -------------------------------------------------------------------------------------------
; |  Interrupt  |    System    |    Colors   |   Resolution  |     Video Buffer Address     |
; |-------------|--------------|-------------|---------------|------------------------------|
; | 04h         | CGA          | 4-colors    | 320x200       | B800                         |
; | 06h         | B&W (CGA)    | 4-gray      | 640x200       | B800                         |
; | 09h         | PCjr/TDY1000 | 16-color    | 320x200       | B800                         |
; |-------------|--------------|-------------|---------------|------------------------------|
; | 0Dh         | EGA/VGA      | 16-color    | 320x200       | A000                         |
; | OEh         | EGA/VGA      | 16-color    | 640x200       | A000                         |
; -------------------------------------------------------------------------------------------

code segment word
assume cs:code, ds:nothing

org 100h

start:
                mov     ch, 32          ; Hide blinking cursor
                mov     ah, 1
                int     10h

                jmp     init_screen

FileName        db      'IMAGE.RAW',0

init_screen:    mov     ah, 0           ; Initialize screen
                mov     ax, 04h         ; Set video mode to CGA (320x200).
                int     10h

load_pic:       lea     dx, FileName    ; Load filename path
                mov     ax, 3D00h
                int     21h

                jnb     draw_pic        ; Jump if file was found
                int     20h

draw_pic:       ;* Writing the image data to the video memory buffer *;
                push    ds
                push    ax
                push    ax
                mov     ax, 0B800h      ; Location of video buffer
                mov     ds, ax

                pop     bx
                mov     ah, 3Fh
                mov     cx, 3EA2h
                xor     dx, dx
                int     21h

                xor     ah, ah          ; Wait for a key to be pressed
                int     16h
                jmp     exit            ; Exit if it detected a key press

exit:           ;* Clear the entire screen *;
                mov     ax, 0600h
                mov     cx, 0000h
                mov     dx, 184Fh
                int     10h

                ;* Show the blinking cursor *;
                mov     ch, 6
                mov     cl, 7
                mov     ah, 1
                int     10h

                ;* Exit to the prompt *;
                mov     ah, 4Ch
                int     21h

code ends
end start
