disableRunStop:
          ; Disable run/stop + restore buttons
        lda #$FC        ; Low byte for pointer to  routine@ Result -> $F6FC
        sta $0328
	rts

clearColorRam:
	ldx #0
@clearColorRamLoop:
        sta $D800,x
        sta $D900,x
        sta $DA00,x
        sta $DB00,x
        inx
        bne @clearColorRamLoop
	rts
