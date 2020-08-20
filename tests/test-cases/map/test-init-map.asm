; @access public
; @return void
testInitMap: .scope
        set38ColumnMode
        lda #0
        sta vpX
        jmp @doit
@testLoop:
        updateScroll
        clc
        clv
        inc c1
        clc
        clv
        lda c1
        cmp #0
:       bne @testLoop
        jmp @doit
        inc vpX
@doit:
        copyMap map, MAP_WIDTH, MAP_HEIGHT, 1, 1, charset, CHARSET_COUNT, colors, COLORS_COUNT, targetScreen
        jmp @testLoop
        rts

c1:
        .byte $00
c2:
        .byte $00
c3:
        .byte $00


viewPort:
        .byte $01
        .byte $02

.segment "SCREEN"
targetScreen:
        .repeat 1000,I
                .byte $00
        .endrepeat 
.segment "MAP"
        .include "tests/assets/commando-map.s"
.segment "CHAR"
        .include "tests/assets/commando-charset.s"
.segment "HIRAM"
        .include "tests/assets/commando-colors.s"
.endscope
