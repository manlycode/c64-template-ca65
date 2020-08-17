
copyMap2x2LookupTable:
        .byte 0,4,8,12,16,20,24,28,32,36,37,41

charIdx: .byte $00
sourceIdx: .byte $00
targetIdx: .byte $00

.macro copyMap2x2 Source, Target, Charset
        ; find the index if the char ind
        lda #0
        sta sourceIdx
        sta targetIdx
@copyMap2x2Loop:
        ldx sourceIdx
        lda Source,x
        tay
        lda copyMap2x2LookupTable,y
        ldy targetIdx
        sta Target,y
        adc #1
        sta Target+1,y
        adc #1
        sta Target+40,y
        adc #1
        sta Target+41,y
        inx
        stx sourceIdx
        inc targetIdx
        inc targetIdx
        cpx #20
        bne @copyMap2x2Loop

.endmacro