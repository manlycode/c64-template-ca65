; @access public
; @return void
testCopyColumn: .scope
        targetScreen := $5000
        
        clearScreen targetScreen
        
        lda #0
        sta vpX

        jsr doCopyColLeft
        assertEqual #$CC, targetScreen                  
        assertEqual #$CE, targetScreen+40               
        assertEqual #$CF, targetScreen+(40*2)           
        assertEqual #$D2, targetScreen+(40*3)
        assertEqual #$D1, targetScreen+(40*4)
        assertEqual #$D5, targetScreen+(40*5)
        assertEqual #$DB, targetScreen+(40*6)
        assertEqual #$30, targetScreen+(40*7)
        assertEqual #$30, targetScreen+(40*8)
        assertEqual #$30, targetScreen+(40*9)
        assertEqual #$30, targetScreen+(40*10)
        assertEqual #$30, targetScreen+(40*11)
        assertEqual #$30, targetScreen+(40*12)
        assertEqual #$30, targetScreen+(40*13)
        assertEqual #$30, targetScreen+(40*14)
        assertEqual #$30, targetScreen+(40*15)
        assertEqual #$30, targetScreen+(40*16)
        assertEqual #$30, targetScreen+(40*17)
        assertEqual #$30, targetScreen+(40*18)
        assertEqual #$30, targetScreen+(40*19)
        assertEqual #$30, targetScreen+(40*20)
        assertEqual #$30, targetScreen+(40*21)
        assertEqual #$33, targetScreen+(40*22)
        assertEqual #$30, targetScreen+(40*23)
        assertEqual #$30, targetScreen+(40*24)

        inc vpX
        jsr doCopyColLeft

        assertEqual #$CC, targetScreen                  
        assertEqual #$CF, targetScreen+40               
        assertEqual #$CE, targetScreen+(40*2)           
        assertEqual #$D1, targetScreen+(40*3)
        assertEqual #$D2, targetScreen+(40*4)
        assertEqual #$D6, targetScreen+(40*5)
        assertEqual #$DC, targetScreen+(40*6)
        assertEqual #$30, targetScreen+(40*7)
        assertEqual #$32, targetScreen+(40*8)
        assertEqual #$30, targetScreen+(40*9)
        assertEqual #$30, targetScreen+(40*10)
        assertEqual #$30, targetScreen+(40*11)
        assertEqual #$30, targetScreen+(40*12)
        assertEqual #$30, targetScreen+(40*13)
        assertEqual #$30, targetScreen+(40*14)
        assertEqual #$30, targetScreen+(40*15)
        assertEqual #$30, targetScreen+(40*16)
        assertEqual #$30, targetScreen+(40*17)
        assertEqual #$30, targetScreen+(40*18)
        assertEqual #$30, targetScreen+(40*19)
        assertEqual #$30, targetScreen+(40*20)
        assertEqual #$30, targetScreen+(40*21)
        assertEqual #$30, targetScreen+(40*22)
        assertEqual #$30, targetScreen+(40*23)
        assertEqual #$30, targetScreen+(40*24)

        lda #0
        sta vpX
        jsr doCopyColRight

        assertEqual #$CC, targetScreen+39                  
        assertEqual #$CF, targetScreen+40+39               
        assertEqual #$CE, targetScreen+(40*2)+39           
        assertEqual #$D1, targetScreen+(40*3)+39
        assertEqual #$D2, targetScreen+(40*4)+39
        assertEqual #$D6, targetScreen+(40*5)+39
        assertEqual #$DC, targetScreen+(40*6)+39
        assertEqual #$1E, targetScreen+(40*7)+39
        assertEqual #$1F, targetScreen+(40*8)+39
        assertEqual #$30, targetScreen+(40*9)+39
        assertEqual #$30, targetScreen+(40*10)+39
        assertEqual #$30, targetScreen+(40*11)+39
        assertEqual #$30, targetScreen+(40*12)+39
        assertEqual #$30, targetScreen+(40*13)+39
        assertEqual #$30, targetScreen+(40*14)+39
        assertEqual #$30, targetScreen+(40*15)+39
        assertEqual #$30, targetScreen+(40*16)+39
        assertEqual #$30, targetScreen+(40*17)+39
        assertEqual #$30, targetScreen+(40*18)+39
        assertEqual #$30, targetScreen+(40*19)+39
        assertEqual #$5B, targetScreen+(40*20)+39
        assertEqual #$61, targetScreen+(40*21)+39
        assertEqual #$65, targetScreen+(40*22)+39
        assertEqual #$30, targetScreen+(40*23)+39
        assertEqual #$30, targetScreen+(40*24)+39

        rts

doCopyColLeft:
        copyColumn map, 80, 200, 1, 1, charset,CHAR_COUNT, targetScreen, 0
        rts

doCopyColRight:
        copyColumn map, 80, 200, 1, 1, charset,CHAR_COUNT, targetScreen, 39
        rts


.endscope
