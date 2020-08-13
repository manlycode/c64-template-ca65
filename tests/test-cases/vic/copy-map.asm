; @access public
; @return void
testCopyMapInit: .scope

        pcopyMapInit mapData, screenData, 5, 5, 3, 2, 0, 0, 0, 0

        assertEqual #<mapData, mapPtr
        assertEqual #>mapData, mapPtr+1
        assertEqual #<screenData, screenPtr
        assertEqual #>screenData, screenPtr+1

        assertEqual #5, mapWidth
        assertEqual #5, mapHeight

        assertEqual #3, screenWidth
        assertEqual #2, screenHeight

        assertEqual #0, mapIdx
        assertEqual #0, screenIdx
        

        pcopyMapInit mapData, screenData, 5, 5, 3, 2, 2, 0, 1, 0

        assertEqual #2, mapIdx
        assertEqual #1, screenIdx

        pcopyMapInit mapData, screenData, 5, 5, 3, 2, 2, 1, 1, 1

        assertEqual #7, mapIdx
        assertEqual #4, screenIdx
        
        rts
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