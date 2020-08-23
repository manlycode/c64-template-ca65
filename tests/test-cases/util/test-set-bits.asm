; @access public
; @return void
testSetBits: .scope

        lda #%00100000
        sta data

        setBits data, %10000001
        assertEqual #%10100001, data
        rts

data:
        .byte $00
.endscope
