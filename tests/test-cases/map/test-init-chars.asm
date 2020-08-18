; @access public
; @return void
testInitChars: .scope
        mapInitChars chars

        loadChar charIdx
        assertEqualToA #$ff, "loadChar1"

        inc charIdx
        loadChar charIdx
        assertEqualToA #$bb, "loadChar2"

        rts

charIdx: .byte $00
chars:
        .byte $ff,$bb,$cc,$dd
.endscope
