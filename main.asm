; ===============================================================================
; Imports
.debuginfo +
.listbytes unlimited
.include "src/system.inc"
.include "src/irq_macros.asm"
.include "src/pointer-macros.asm"

.segment "CHAR"
.include "assets/commando-charset.s"
.segment "MAP"
.include "assets/commando-map.s"
;========================================================================
; Entry Point
;========================================================================

.CODE
jmp init
.include "src/cia.asm"
.include "src/vchar.asm"
.include "src/vic.asm"
.include "src/map.asm"

.CODE
counter: .byte $00

init:
        jsr disableRunStop        
        sei

        jsr clearScreenRam
        
        ; Disable CIA Timers
        cia_DisableTimers


        vicSelectBank 0
        vicSelectScreenMemory 1        ; $0400
        vicSelectCharMemory 14         ; $3000
        vicSetMultiColorMode
        set38ColumnMode

        lda #7
        sta scrollVal
        jsr updateScroll

        
        lda #9
        sta vic_cbg0
        lda #0
        sta vic_cbg1
        lda #15
        sta vic_cbg2

        
        lda #0
        sta vic_cborder
        sta scrollVal
        jsr clearScreenRam
        jsr clearColorRam
        lda #0
        sta vpX

        vicCopyChars charset, $3000, CHARSET_COUNT
        vicCopyColors colors
        jsr renderMap

        ; Clear CIA IRQs by reading the registers
        cia_EnableTimers

addRasterCall:
        addRasterInterrupt irq, 0
        cli                     ; clear interrupt disable flat
        jmp *                   ; infinite loop

irq:
    
        ; Begin Code ----------
        .repeat 32,I
        lda counter
        .endrepeat
        cmp #0
        bne :+
        jsr frame30
        dec $d019
:
        ; End Code ----------
        jmp $ea81


frame30:
        jsr decScroll
        jsr updateScroll
        clc
        clv
        lda scrollVal
        cmp #0
        bne :+
        ; reset the scroll
        clc
        clv
        lda #7
        sta scrollVal
        jsr updateScroll
        ; increment viewport
        inc vpX
        
        ; render map
        jsr renderMap
        
:
        rts

renderMap:
        copyMap map, MAP_WIDTH, MAP_HEIGHT, 1, 1, charset, CHARSET_COUNT, $0400
        rts

renderColL:
        copyColumn map, MAP_WIDTH, MAP_HEIGHT, 1, 1, charset, CHARSET_COUNT, $0400, 0
        rts

renderColR:
        copyColumn map, MAP_WIDTH, MAP_HEIGHT, 1, 1, charset, CHARSET_COUNT, $0400, 39
        rts

; renderMap:
;         copyMap map, MAP_WIDTH, MAP_HEIGHT, 1, 1, charset, CHARSET_COUNT, $0400
;         rts


.include "src/init.asm"
.include "src/hardware.asm"
.include "src/memory.asm"
.include "assets/commando-colors.s"
