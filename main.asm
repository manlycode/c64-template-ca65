; ===============================================================================
; Imports
.debuginfo +
.listbytes unlimited

.include "c64.inc"                      ; c64 constants
.include "cbm.mac"
.include "src/irq_macros.asm"
.include "src/pointer-macros.asm"

;========================================================================
; Entry Point
;========================================================================

.CODE
jmp init
.include "src/vchar.asm"
.include "src/vic.asm"
.include "src/map.asm"

init:
        jsr disableRunStop        
        sei

        jsr clearScreenRam
        
        ; lda #0
        ; sta vic_cborder
        ; Disable CIA Timers
        ldy #$7f                ; bit mask
                                ; 7 - Set or Clear the following bits in the mask.
                                ; in this case, we're clearing them
        sty cia1_icr               ; CIA1_ICR
        sty cia2_icr               ; CIA2_ICR

        vicSetMultiColorMode
        lda #9
        sta vic_cbg0
        lda #0
        sta vic_cbg1
        lda #15
        sta vic_cbg2

        vicSelectBank 0
        vicSelectScreenMemory 1        ; $0400
        vicSelectCharMemory 14         ; $3000
        
        lda #0
        sta vic_cborder
        jsr clearScreenRam
        jsr clearColorRam
        lda #0
        sta vpX
        vicCopyChars charset, $3000, CHARSET_COUNT
        vicCopyColors colors
        copyMap map, MAP_WIDTH, MAP_HEIGHT, 1, 1, charset, CHARSET_COUNT, $0400
        

        ; Clear CIA IRQs by reading the registers
        lda cia1_icr            ; CIA1_ICR
        lda cia2_icr            ; CIA2_ICR

addRasterCall:
        addRasterInterrupt irq, 0
        cli                     ; clear interrupt disable flat
        jmp *                   ; infinite loop

irq:
        dec $d019
        ; Begin Code ----------


        ; End Code ----------

        jmp $ea81

.include "src/init.asm"
.include "src/hardware.asm"
.include "src/cia.asm"
.include "src/memory.asm"

.include "assets/commando-colors.s"
.segment "CHAR"
.include "assets/commando-charset.s"
.segment "MAP"
.include "assets/commando-map.s"


        