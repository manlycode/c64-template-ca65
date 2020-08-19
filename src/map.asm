screenW = 40
screenH = 25

mapIdx: .byte $00
screenIdx: .byte $00
vpX: .byte $00
vpY: .byte $00

.scope map_module
;------------------------------------------------------------------
; Variables
;------------------------------------------------------------------


;------------------------------------------------------------------
; Subroutines
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

.macro loadChar Idx
        ldx Idx
        lda chars_ADDR,x
.endmacro

.macro loadColor Idx
        ldx Idx
        lda colors_ADDR,x
.endmacro

.macro copyMap Map, mapW, mapH, tileW, tileH, Charset, charCOUNT, Colors, colorCOUNT, Screen
        lda #0
        sta mapIdx
        sta screenIdx

@loop:
        ldy screenIdx
        ldx mapIdx

        .repeat (25 / tileH), I
        lda Map+((mapW*tileH)*I),x
        sta Screen+((screenW*tileH)*I),y
        .endrepeat

        inc mapIdx
        clc
        inc screenIdx
        lda screenIdx
        cmp #40
        beq @end
        beq :+
        cmp #80
        beq :+
        cmp #120
        beq :+
        cmp #160
        beq :+
        cmp #200
        beq :+
        cmp #240
        beq :+
        ; Not a screen bounds, normal map index inc
        jmp @loop
        
:       ; forward the map index
        clc
        lda mapIdx
        adc #(screenW .mod mapW)
        sta mapIdx
        jmp @loop

@end:



.endmacro


.endscope