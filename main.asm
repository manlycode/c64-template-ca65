; ===============================================================================
; Imports
.debuginfo +

.include "c64.inc"                      ; c64 constants
.include "cbm.mac"

.include "src/hardware.asm"
.include "src/irq_macros.asm"
.include "src/vic.asm"
.include "src/cia.asm"
.include "src/memory.asm"

;========================================================================
; Entry Point
;========================================================================
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
        lda #3
        sta vic_cbg


        lda #0
        sta vic_cborder
        jsr clearScreenRam
        jsr clearColorRam

        ; Clear CIA IRQs by reading the registers
        lda cia1_icr            ; CIA1_ICR
        lda cia2_icr            ; CIA2_ICR

addRasterCall:
        addRasterInterrupt irq, 0
        cli                     ; clear interrupt disable flat
        jmp *                   ; infinite loop

irq:
        dec $d019
        vicCopyColors colorData
        ; vicCopyMap mapData, 21*2, 14*2
        ; Set up Color Ram

        jmp $ea81

.include "src/init.asm"