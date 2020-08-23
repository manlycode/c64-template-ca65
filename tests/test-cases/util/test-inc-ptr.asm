; @access public
; @return void
testIncPtr: .scope

        lda #$fd
        sta ptr
        incPtr ptr
        assertEqual #$fe, ptr
        assertEqual #$00, ptr+1

        incPtr ptr
        assertEqual #$ff, ptr
        assertEqual #$00, ptr+1

        incPtr ptr
        assertEqual #$00, ptr
        assertEqual #$01, ptr+1

        rts

ptr:
        .word $0000
.endscope
