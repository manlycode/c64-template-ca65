
; @access public
; @return void
testCopyMap2x2: .scope
        ; test the mapdef struct offsets
        copyMap2x2 testMap, $3400, testCharset, MAP_COUNT

        assertMemoryEqual expectedMap, $3400, 80
        ; assertMemoryEqual expectedMap2, $3400+256, 80
        ; 255+18
        rts

testMap:
        .include "assets/tiles-map.s"
testCharset:
        .include "assets/tiles-charset.s"
testColors:
        .include "assets/tiles-colors.s"
expectedMap:
        .byte $04,$05,$08,$09,$04,$05,$08,$09,$04,$05,$08,$09,$04,$05,$08,$09,$04,$05,$08,$09,$04,$05,$08,$09,$04,$05,$08,$09,$04,$05,$08,$09,$04,$05,$08,$09,$04,$05,$08,$09
        .byte $06,$07,$0A,$0B,$06,$07,$0A,$0B,$06,$07,$0A,$0B,$06,$07,$0A,$0B,$06,$07,$0A,$0B,$06,$07,$0A,$0B,$06,$07,$0A,$0B,$06,$07,$0A,$0B,$06,$07,$0A,$0B,$06,$07,$0A,$0B

expectedMap2:
        .byte $0A,$0B,$06,$07,$0A,$0B,$06,$07,$0A,$0B,$06,$07,$0A,$0B,$06,$07,$0A,$0B,$06,$07,$0A,$0B,$06,$07,$0A,$0B,$06,$07,$0A,$0B,$06,$07,$0A,$0B,$06,$07,$0A,$0B,$06,$07
        .byte $04,$05,$08,$09,$04,$05,$08,$09,$04,$05,$08,$09,$04,$05,$08,$09,$04,$05,$08,$09,$04,$05,$08,$09,$04,$05,$08,$09,$04,$05,$08,$09,$04,$05,$08,$09,$04,$05,$08,$09



.endscope
