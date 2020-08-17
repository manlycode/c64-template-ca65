
; @access public
; @return void
testCopyMap2x2: .scope
        ; test the mapdef struct offsets
        copyMap2x2 testMap, testMapTarget, testCharset

        assertMemoryEqual expectedMap, testMapTarget, 80
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
        .byte $08,$09,$04,$05,$08,$09,$04,$05,$08,$09,$04,$05,$08,$09,$04,$05,$08,$09,$04,$05,$08,$09,$04,$05,$08,$09,$04,$05,$08,$09,$04,$05,$08,$09,$04,$05,$08,$09,$04,$05,$08,$09,$04,$05
        .byte $0A,$0B,$06,$07,$0A,$0B,$06,$07,$0A,$0B,$06,$07,$0A,$0B,$06,$07,$0A,$0B,$06,$07,$0A,$0B,$06,$07,$0A,$0B,$06,$07,$0A,$0B,$06,$07,$0A,$0B,$06,$07,$0A,$0B,$06,$07,$0A,$0B,$06,$07

testMapTarget:
        .res 1000, $00


.endscope
