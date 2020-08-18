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

        lda #1
        sta vic_cbg0
        lda #5
        sta vic_cbg1
        lda #7
        sta vic_cbg2

        ; vicSetStandardCharacterMode
        ;vicSetHiRezBitmap
        vicSetMultiColorMode
        vicSelectBank 0
        ; vicSelectScreenMemory 13        ; $3400
        vicSelectCharMemory 7          ; $3800
        
        lda #0
        sta vic_cborder
        jsr clearScreenRam
        jsr clearColorRam
        vicCopyChars charData, $3800
        vicCopyColors colorData

        ; copyMapInit mapData, $3400, 42, 28, vic_SCREEN_WIDTH, vic_SCREEN_HEIGHT, 0, 0, 0, 0
        ; jsr copyMap

        copyMap2x2Multicolor mapData, $0400, charData, colorData, MAP_COUNT, 10
        ; copyMapInit colorData, $D800, 42, 28, vic_SCREEN_WIDTH, vic_SCREEN_HEIGHT, 0, 0, 0, 0
        ; jsr copyMap

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

mapData:
        .include "assets/reset-map.s"
colorData:
        .include "assets/reset-colors.s"
charData:
        .include "assets/reset-charset.s"