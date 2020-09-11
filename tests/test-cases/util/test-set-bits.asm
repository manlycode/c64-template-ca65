; @access public
; @return void
testSetBits: .scope

        lda #%00100000
        sta data

        setBits data, %10000001
        assertEqual #%10100001, data

        lda #%00100000
        sta data

        lda #%10000001
        sta source

        setBits data, source
        assertEqual #%10100001, data
        rts

source:
        .byte $00
data:
        .byte $00
.endscope
