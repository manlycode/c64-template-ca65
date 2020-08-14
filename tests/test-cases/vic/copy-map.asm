; @access public
; @return void
testCopyMap: .scope

        copyMapInit mapData, screenData, 5, 5, 3, 2, 1, 1, 0, 0
        jsr copyMap

        assertMemoryEqual expectedScreenData, screenData, 9
        
        rts

expectedScreenData:
  .byte $06, $07, $08
  .byte $00, $00, $00
  .byte $00, $00, $00

mapData:
  .byte $00, $01, $02, $03, $04
  .byte $05, $06, $07, $08, $09
  .byte $0a, $0b, $0c, $0c, $0e
  .byte $0f, $10, $11, $12, $13

screenData:
  .byte $00, $00, $00
  .byte $00, $00, $00
  .byte $00, $00, $00

.endscope