; @access public
; @return void
testDecPtr: .scope
        lda #$01
        sta ptr
        lda #$00
        sta ptr+1

        decPtr ptr

        assertEqual #$00, ptr
        assertEqual #$00, ptr+1

        lda #$00
        sta ptr
        lda #$01
        sta ptr+1

        decPtr ptr
        assertEqual #$ff, ptr
        assertEqual #$00, ptr+1
        rts

ptr:
        .word $0000
.endscope
