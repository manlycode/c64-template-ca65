
; @access public
; @return void
testCopyTile: .scope
        ; test the mapdef struct offsets
        initMap testMapDef
        assertEqual #4, partitionSize

        assertMemoryEqual expectedLookupTable, tileLookup, 4
        rts

expectedLookupTable:
        .byte $00, $04, $08, $0C

testMapDef: 
        .byte $01
        .byte $02
        .byte $02
        .byte $02

testMap:
        .include "assets/tiles-map.s"
testCharset:
        .include "assets/tiles-charset.s"
testColors:
        .include "assets/tiles-colors.s"
.endscope
