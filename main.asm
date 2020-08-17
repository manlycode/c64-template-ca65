; ===============================================================================
; Imports
.debuginfo +
.listbytes unlimited

.include "c64.inc"                      ; c64 constants
.include "cbm.mac"
.include "src/irq_macros.asm"
.include "src/vic.asm"
.include "src/vchar.asm"
.include "src/pointer-macros.asm"
.include "src/memory.asm"

;========================================================================
; Entry Point
;========================================================================
jmp init
.CODE
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

        vicSelectScreenMemory 13
        vicSelectCharMemory 7          ; $3800
        ; +vicSetMultiColorMode

        lda #0
        sta vic_cborder
        jsr clearScreenRam
        jsr clearColorRam

        copyMap2x2 testMap, $0400, testCharset, MAP_COUNT

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
.DATA
testMap:
        .include "assets/tiles-map.s"
testCharset:
        .include "assets/tiles-charset.s"
testColors:
        .include "assets/tiles-colors.s"