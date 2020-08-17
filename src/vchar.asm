
copyMap2x2LookupTable:
        .byte 0,4,8,12,16,20,24,28,32,36,37,41

charIdx: .byte $00
sourceIdx: .byte $00
targetIdx: .byte $00

.macro copyMap2x2 Source, Target, Charset
Source2 = Source+120
Source3 = Source+120*2
Source4 = Source+120*3
Source5 = Source+120*4
Target2 = Target + 240
Target3 = Target + 240*2
Target4 = Target + 240*3
Target5 = Target + 240*4
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

        lda Source2,x
        tay
        lda copyMap2x2LookupTable,y
        ldy targetIdx
        sta Target2,y
        adc #1
        sta Target2+1,y
        adc #1
        sta Target2+40,y
        adc #1
        sta Target2+41,y

        lda Source3,x
        tay
        lda copyMap2x2LookupTable,y
        ldy targetIdx
        sta Target3,y
        adc #1
        sta Target3+1,y
        adc #1
        sta Target3+40,y
        adc #1
        sta Target3+41,y

        lda Source4,x
        tay
        lda copyMap2x2LookupTable,y
        ldy targetIdx
        sta Target4,y
        adc #1
        sta Target4+1,y
        adc #1
        sta Target4+40,y
        adc #1
        sta Target4+41,y

        lda sourceIdx
        cmp #20
        bpl :+
        lda Source5,x
        tay
        lda copyMap2x2LookupTable,y
        ldy targetIdx
        sta Target5,y
        adc #1
        sta Target5+1,y
:
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