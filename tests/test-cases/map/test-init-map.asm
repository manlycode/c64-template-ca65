; @access public
; @return void
testInitMap: .scope
        copyMap map, MAP_WIDTH, MAP_HEIGHT, 1, 1, charset, CHARSET_COUNT, colors, COLORS_COUNT, targetScreen
        rts

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
