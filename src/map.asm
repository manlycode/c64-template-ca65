;------------------------------------------------------------------
; Constants
;------------------------------------------------------------------
SCREEN_W = 40
SCREEN_H = 25
;------------------------------------------------------------------
; Variables
;------------------------------------------------------------------
mapIdx: .byte $00
screenIdx: .byte $00
vpX: .byte $00
vpY: .byte $00
;------------------------------------------------------------------
; Macros
;------------------------------------------------------------------
.macro copyChars source,target,size
        ldx #0
:       
        .repeat 8
        lda source,x
        sta target,x
        .endrepeat
        inx
        bne :-
.endmacro

.macro copyMap Map, mapW, mapH, tileW, tileH, Charset, charCOUNT, Screen
        lda vpX
        sta mapIdx
        lda #0
        sta screenIdx

:       ldy screenIdx
        ldx mapIdx

        .repeat (25 / tileH), I
        lda Map+(mapW*tileH*I),x
        sta Screen+((SCREEN_W*tileH)*I),y
        .endrepeat

        inc mapIdx
        clc
        inc screenIdx
        lda screenIdx
        cmp #40
        beq :+
        ; Not a screen bounds, normal map index inc
        jmp :-
        
        clc
        lda mapIdx
        adc #(SCREEN_W .mod mapW)
        sta mapIdx
        jmp :-
:
.endmacro

.macro copyColumn Map, mapW, mapH, tileW, tileH, Charset, charCOUNT, Screen, ScreenCol
        lda vpX
        adc #ScreenCol
        tax

        lda #ScreenCol
        tay


        .repeat (25 / tileH), I
        lda Map+(mapW*tileH*I),x
        sta Screen+((SCREEN_W*tileH)*I),y
        .endrepeat
.endmacro
;------------------------------------------------------------------
; Subroutines
;------------------------------------------------------------------
