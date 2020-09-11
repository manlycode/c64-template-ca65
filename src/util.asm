.FEATURE addrsize

.macro setBits target, bits
        .if .const(bits)
                lda target
                ora #bits
                sta target
        .else
                lda target
                ora bits
                sta target
        .endif
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
        clv
        adc #amount
        bcc :+
        inc Word+1
:       sta Word
.endmacro