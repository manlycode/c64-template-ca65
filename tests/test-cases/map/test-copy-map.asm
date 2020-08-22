; @access public
; @return void
testCopyMap: .scope
        targetScreen := $5000
        clearScreen targetScreen
        
        lda #0
        sta vpX
                                                        ; vChar coords
        jsr doCopyMap                                   ; ----------
        assertEqual #204, targetScreen                  ; 0,0 
        assertEqual #204, targetScreen+39               ; 0,39
        assertEqual #206, targetScreen+40               ; 0,1
        assertEqual #207, targetScreen+40+39            ; 39,1
        assertEqual #48, targetScreen+(40*24)           ; 0, 24
        assertEqual #97, targetScreen+(40*21)+39        ; 39, 21
        rts

doCopyMap:
        copyMap map, 80, 200, 1, 1, charset,CHAR_COUNT, targetScreen
        rts


.endscope
