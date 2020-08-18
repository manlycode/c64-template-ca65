; @access public
; @return void
testInitChars: .scope
        mapInitChars chars
        loadChar 1
        assertEqualToA #$bb, "loadChar"

        rts

chars:
        .byte $ff,$bb,$cc,$dd
chars2:
        .byte $fe,$be,$ce,$de
.endscope
