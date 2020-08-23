.macro setBits target, bits
        lda target
        ora #bits
        sta target
.endmacro

.macro incPtr PtrAddr
        clv
        inc PtrAddr
        bne :+
        inc PtrAddr+1
:
.endmacro

.macro decPtr Ptr
        clc
        dec Ptr
        bpl :+
        dec Ptr+1
:
.endmacro