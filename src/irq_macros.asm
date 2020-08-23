; Args:
;       @param irq - address of subroutine for interrupt
;       @param row - row at which to trigger subroutine
.macro addRasterInterrupt IRQ, row
        ; Set Interrupt Request Mask
        .local HI_BIT, LO_BYTE
        .if row > $ff
        HI_BIT = %10000000
        LO_BYTE = row .mod 256
        .else
        HI_BIT = 0
        LO_BYTE = row
        .endif

        lda #$01                ; set mask to enable by raster beam
        sta vic_irqmask         ; VIC_IRQEN
        lda #<IRQ               ; Point the system routine to our new irq
        ldx #>IRQ
        sta BASIC_ISR_ADDR
        stx BASIC_ISR_ADDR+1

        lda #LO_BYTE          ; trigger first interrupt at row 0
        sta VIC_HLINE          ; VIC_RSTCMP
        setBits VIC_CTRL_V, HI_BIT

.endmacro

.macro irq_endISR
        dec $d019
        jmp $ea81
.endmacro