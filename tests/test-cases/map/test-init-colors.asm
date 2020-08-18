; @access public
; @return void
testInitColors: .scope
        mapInitColors colors
        loadColor colorIdx
        assertEqualToA #$ff, "loadColor"

        inc colorIdx
        loadColor colorIdx
        assertEqualToA #$bb, "loadColor2"

        inc colorIdx
        loadColor colorIdx
        assertEqualToA #$cc, "loadColor3"

        rts
colorIdx: .byte $00

colors:
        .byte $ff,$bb,$cc,$dd
        rts
.endscope
