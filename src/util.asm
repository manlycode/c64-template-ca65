.macro setBits target, bits
        lda target
        ora #bits
        sta target
.endmacro

.macro incPtr PtrAddr
        incWord PtrAddr
.endmacro

.macro decPtr Ptr
        decWord Ptr
.endmacro

.macro incWord Word
        clv
        inc Word
        bne :+
        inc Word+1
:
.endmacro

.macro decWord Word
        clc
        dec Word
        bpl :+
        dec Word+1
:
.endmacro

.macro addWord Word, amount
        lda Word
        clc
        adc #amount
        bcc :+
        inc Word+1
:       sta Word
.endmacro