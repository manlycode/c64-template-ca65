.macro setBits target, bits
        lda target
        ora #bits
        sta target
.endmacro