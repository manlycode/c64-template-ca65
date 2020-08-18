
.scope map_module
;------------------------------------------------------------------
; Variables
;------------------------------------------------------------------

mapIdx: .byte $00
screenIdx: .byte $00
mapPtr:    .addr $0000
screenPtr: .addr $0000

.export mapPtr, screenPtr


;------------------------------------------------------------------
; Subroutines
;------------------------------------------------------------------
.macro mapInitChars Chars
        chars_ADDR = Chars
.endmacro

.macro mapInitColors Colors
        colors_ADDR = Colors
.endmacro

.macro loadChar Idx
        ldx Idx
        lda chars_ADDR,x
.endmacro

.macro loadColor Idx
        ldx Idx
        lda colors_ADDR,x
.endmacro

.endscope