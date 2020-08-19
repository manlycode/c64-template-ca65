; @access public
; @return void
testInitMap: .scope
        ; screen = $3400
        ; charsTarget = $3800 
        ; copyChars charset, charsTarget, #CHARSET_COUNT

        rts
.segment "MAP"
        .include "tests/assets/commando-map.s"
.segment "HIRAM"
        .include "tests/assets/commando-charset.s"
        .include "tests/assets/commando-colors.s"
.endscope
