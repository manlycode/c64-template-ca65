
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

        lda Source+120,x
        tay
        lda copyMap2x2LookupTable,y
        ldy targetIdx
        sta Target+240,y
        adc #1
        sta Target+1+240,y
        adc #1
        sta Target+40+240,y
        adc #1
        sta Target+41+240,y

        lda Source+120*2,x
        tay
        lda copyMap2x2LookupTable,y
        ldy targetIdx
        sta Target+240*2,y
        adc #1
        sta Target+1+240*2,y
        adc #1
        sta Target+40+240*2,y
        adc #1
        sta Target+41+240*2,y

        lda Source+120*3,x
        tay
        lda copyMap2x2LookupTable,y
        ldy targetIdx
        sta Target+240*3,y
        adc #1
        sta Target+1+240*3,y
        adc #1
        sta Target+40+240*3,y
        adc #1
        sta Target+41+240*3,y

        lda #120
        tax
        lda #240
        tay
        lda Source+120*3,x
        tay
        lda copyMap2x2LookupTable,y
        ldy targetIdx
        sta Target+240*3,y
        adc #1
        sta Target+1+240*3,y
        adc #1
        sta Target+40+240*3,y
        adc #1
        sta Target+41+240*3,y

        clc
        clv
        inc sourceIdx
        inc targetIdx
        inc targetIdx
        lda sourceIdx
        cmp #20
        beq @nextRow
        cmp #40
        beq @nextRow
        cmp #60
        beq @endMapCopy
        jmp @copyMap2x2Loop
@nextRow:
        lda targetIdx
        clc    
        clv
        adc #40
        sta targetIdx
        jmp @copyMap2x2Loop
@endMapCopy:
.endmacro