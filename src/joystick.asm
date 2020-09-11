
initJoystick:
        lda CIA1_PRB
        jmp saveJoyState

checkJoystick:
        clc
        clv
        lda CIA1_PRB
        sta joy_currentState
        cmp joy_prevState
        beq saveJoyState        ; The state didn't change no need for other checks
        
        cmp #$f5                ; Right
        bne :+
        jsr doRight
        jmp saveJoyState

:       cmp #$fb                ; Left
        bne :+
        jsr doLeft
        jmp saveJoyState

:       cmp #$ff                ;released
        ldx #3
        stx vic_cborder

saveJoyState:
        lda joy_currentState
        sta joy_prevState
        rts

doRight:
        ldx #1
        stx vic_cborder
        jsr decScroll
        jsr updateScroll
        rts

doLeft:
        ldx #2
        stx vic_cborder
        jsr incScroll
        jsr updateScroll
        rts

joy_currentState:
        .byte $00
joy_prevState:
        .byte $00