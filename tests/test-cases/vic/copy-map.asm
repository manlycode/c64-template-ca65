; @access public
; @return void
testCopyMap: .scope

        copyMapInit mapData, copyScreenData, 5, 4, 3, 3, 1, 1, 0, 0
        jsr copyMap

        assertMemoryEqual expectedScreenData, copyScreenData, 9
        
        rts

expectedScreenData:
  .byte $06, $07, $08
  .byte $0b, $0c, $0d
  .byte $10, $11, $12

mapData:
  .byte $00, $01, $02, $03, $04
  .byte $05, $06, $07, $08, $09
  .byte $0a, $0b, $0c, $0d, $0e
  .byte $0f, $10, $11, $12, $13

copyScreenData:
  .byte $00, $00, $00
  .byte $00, $00, $00
  .byte $00, $00, $00

expectedScreenData2:
  .byte $06, $07, $08
  .byte $0b, $0c, $0d
  .byte $10, $11, $12

mapData2:
  .byte $00, $01, $02
  .byte $03, $04, $05
  .byte $06, $07, $08

copyScreenData2:
  .byte $00, $00, $00, $00, $00
  .byte $00, $00, $00, $00, $00
  .byte $00, $00, $00, $00, $00
  .byte $00, $00, $00, $00, $00
  .byte $00, $00, $00, $00, $00


.endscope