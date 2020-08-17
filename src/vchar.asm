
copyMap2x2LookupTable:
        .byte 0,4,8,12,16,20,24,28,32,36,37,41

charIdx: .byte $00
sourceIdx: .byte $00
targetIdx: .byte $00

.macro copyMap2x2 Source, Target, Charset, mapSize
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

        lda Source+180,x
        tay
        lda copyMap2x2LookupTable,y
        ldy targetIdx
        sta Target+256,y
        adc #1
        sta Target+1+256,y
        adc #1
        sta Target+40+256,y
        adc #1
        sta Target+41+256,y

        lda Source+180*2,x
        tay
        lda copyMap2x2LookupTable,y
        ldy targetIdx
        sta Target+256*2,y
        adc #1
        sta Target+1+256*2,y
        adc #1
        sta Target+40+256*2,y
        adc #1
        sta Target+41+256*2,y

        inc targetIdx
        inc targetIdx
        clc
        clv
        inc sourceIdx
        bne @copyMap2x2Loop

.endmacro