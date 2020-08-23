; @access public
; @return void
testAddWord: .scope
        lda #$00
        sta ptr
        lda #$00
        sta ptr+1

        addWord ptr, 8

        assertEqual #$08, ptr
        assertEqual #$00, ptr+1

        lda #$ff
        sta ptr
        lda #$00
        sta ptr+1

        addWord ptr, 8
        assertEqual #$00, ptr
        assertEqual #$01, ptr+1
        rts

ptr:
        .word $0000
.endscope
