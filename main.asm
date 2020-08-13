; ===============================================================================
; Imports
.debuginfo +
.listbytes unlimited

.include "c64.inc"                      ; c64 constants
.include "cbm.mac"
.include "src/irq_macros.asm"
.include "src/vic.asm"
.include "src/pointer-macros.asm"
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

        lda #0
        sta vic_cborder
        jsr clearScreenRam
        jsr clearColorRam

copyScreenRam:
screenSizeX = 40
screenSizeY = 25

mapWidth = tempParam1
mapHeight = tempParam2
screenWidth = tempParam3
screenHeight = tempParam4
screenX = tempParam5
screenY = tempParam6
mapX = tempParam7
mapY = tempParam8


        lda #4
        sta mapWidth
        sta mapHeight

        lda #2
        sta screenWidth
        sta screenHeight

        lda #0
        sta screenX
        sta screenY
        sta mapX
        sta mapY

        ; mapData
        savePointer mapData, tempPtr1

        ldy #0
        ldx #0

@copyScreenRamLoop:
        lda (tempPtr1),y
        sta $3400, x

        inc mapX
        cmp mapWidth
        bne :+
        ; else reset to 0 and increase the mapY
        inc mapY
        cmp mapHeight
        beq @endCopyScreenRamLoop
        lda #0
        sta mapX

:       inc screenX
        cmp screenWidth
        bne :+
        ; else reset to 0 and increase the screenY
        inc screenY
        lda screenSizeX
        sbc screenX
        sta tempParam9
        txa
        adc tempParam9
        tax
        cmp screenHeight
        beq @endCopyScreenRamLoop
        lda #0
        sta screenX

:       iny
        inx
        jmp @copyScreenRamLoop

@endCopyScreenRamLoop:





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