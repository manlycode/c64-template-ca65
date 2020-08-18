
.scope map_module
;------------------------------------------------------------------
; Variables
;------------------------------------------------------------------

mapIdx: .byte $00
screenIdx: .byte $00
mapPtr:    .addr $0000
screenPtr: .addr $0000
colorsPtr: .addr $0000
charsPtr:  .addr $0000

.export mapPtr, screenPtr, charsPtr, colorsPtr


;------------------------------------------------------------------
; Subroutines
;------------------------------------------------------------------
.macro mapInitChars     Chars
chars_ADDR= Chars
.endmacro

.macro loadChar Idx
        ldx #Idx
        lda chars_ADDR,x
        
        ; lda charsPtr
        ; sta tempPtr1
        ; lda charsPtr+1
        ; sta tempPtr1+1
        ; ldy #Idx
        ; lda (tempPtr1),y
.endmacro


.macro mapInitColors
.endmacro

.endscope