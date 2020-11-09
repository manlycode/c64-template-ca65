; ===============================================================================
; Imports
.debuginfo +
.listbytes unlimited
.include "src/system.inc"
.include "src/irq_macros.asm"
.include "src/pointer-macros.asm"
.include "src/util.asm"

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
counter2: .byte $00
nextRasterLine: .word $0000
scrollCounter:
        .byte $00
        .byte $00
init:
        jsr disableRunStop        
        sei

        ; Disable CIA Timers
        cia_DisableTimers

        jsr initJoystick
        vic_SelectBank 0
        vic_SelectScreenMemory 1        ; $0400
        vic_SelectCharMemory 14         ; $3000
        vic_SetMultiColorMode
        vic_set38ColumnMode

        vic_clearScreen $0400

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
        vic_clearScreen $0400
        jsr clearColorRam
        lda #0
        sta vpX

        vic_CopyChars charset, $3000, CHARSET_COUNT
        vic_CopyColors colors


        inc vpXbuffer
        jsr renderMap1
        jsr renderBuffer1

        ; Clear CIA IRQs by reading the registers
        cia_EnableTimers

addRasterCall:
        addRasterInterrupt irqTop, 0
        cli                     ; clear interrupt disable flat
        jmp *                   ; infinite loop

irqTop:
        ; addRasterInterrupt d, $33
        
        ; Begin Code ----------
        ; jsr updateScroll

        jsr checkJoystick
        ; End Code ----------
        irq_endISR
        rts
        
renderMap1:
        copyMap map, MAP_WIDTH, MAP_HEIGHT, 1, 1, charset, CHARSET_COUNT, $0400
        rts

renderBuffer1:
        copyBuffer map, MAP_WIDTH, MAP_HEIGHT, 1, 1, charset, CHARSET_COUNT, $2000
        rts

renderMap2:
        copyMap map, MAP_WIDTH, MAP_HEIGHT, 1, 1, charset, CHARSET_COUNT, $2000
        rts

renderBuffer2:
        copyBuffer map, MAP_WIDTH, MAP_HEIGHT, 1, 1, charset, CHARSET_COUNT, $0400
        rts



SCREEN1 := $0400
SCREEN2 := $0400

renderColL:
        copyColumn map, MAP_WIDTH, MAP_HEIGHT, 1, 1, charset, CHARSET_COUNT, $0400, 0
        rts

renderColR:
        copyColumn map, MAP_WIDTH, MAP_HEIGHT, 1, 1, charset, CHARSET_COUNT, $0400, 39
        rts

; renderMap:
;         copyMap map, MAP_WIDTH, MAP_HEIGHT, 1, 1, charset, CHARSET_COUNT, $0400
;         rts
bufferIdx:
        .byte $00
bufferTable:
        .repeat 128,I
                .byte $04
                .byte $20
        .endrepeat


.include "src/init.asm"
.include "src/hardware.asm"
.include "src/memory.asm"
.include "src/joystick.asm"
.include "assets/commando-colors.s"
