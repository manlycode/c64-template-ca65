.include "system.inc"
; ---------------------------------------------------------------------------
; I/O: Complex Interface Adapters


.macro cia_DisableTimers
        ldy #$7f                ; bit mask
                                ; 7 - Set or Clear the following bits in the mask.
                                ; in this case, we're clearing them
        sty CIA1_ICR            ; CIA1_ICR
        sty CIA2_ICR            ; CIA2_ICR
.endmacro

.macro cia_EnableTimers
        lda CIA1_ICR
        lda CIA2_ICR
.endmacro