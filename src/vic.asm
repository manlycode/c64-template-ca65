; register addresses
vic_xs0		= $d000
vic_ys0		= $d001
vic_xs1		= $d002
vic_ys1		= $d003
vic_xs2		= $d004
vic_ys2		= $d005
vic_xs3		= $d006
vic_ys3		= $d007
vic_xs4		= $d008
vic_ys4		= $d009
vic_xs5		= $d00a
vic_ys5		= $d00b
vic_xs6		= $d00c
vic_ys6		= $d00d
vic_xs7		= $d00e
vic_ys7		= $d00f
vic_msb_xs	= $d010
VIC_CTRL_V      = VIC_CTRL1
; vic_line	= $d012	; raster line
vic_xlp		= $d013	; light pen coordinates
vic_ylp		= $d014
vic_sactive	= $d015	; sprites: active
VIC_CTRL_H       = VIC_CTRL2
vic_sdy		= $d017	; sprites: double height
vic_ram		= $d018	; RAM pointer
vic_irq		= $d019
vic_irqmask	= $d01a
vic_sback	= $d01b	; sprites: background mode
vic_smc		= $d01c	; sprites: multi color mode
vic_sdx		= $d01d	; sprites: double width
vic_ss_collided	= $d01e	; sprite-sprite collision detect
vic_sd_collided	= $d01f	; sprite-data collision detect
; color registers
vic_cborder	= $d020	; border color
vic_cbg		= $d021	; general background color
vic_cbg0	= $d021
vic_cbg1	= $d022	; background color 1 (for EBC and MC text mode)
vic_cbg2	= $d023	; background color 2 (for EBC and MC text mode)
vic_cbg3	= $d024	; background color 3 (for EBC mode)
vic_sc01	= $d025	; sprite color for MC-bitpattern %01
vic_sc11	= $d026	; sprite color for MC-bitpattern %11
vic_cs0		= $d027	; sprite colors
vic_cs1		= $d028
vic_cs2		= $d029
vic_cs3		= $d02a
vic_cs4		= $d02b
vic_cs5		= $d02c
vic_cs6		= $d02d   
vic_cs7		= $d02e
COLOR_RAM	= $d800
vic_SCREEN_WIDTH = 40
vic_SCREEN_HEIGHT = 21
; See <cbm/c128/vica> for the C128's two additional registers at $d02f/$d030
; They are accessible even in C64 mode and $d030 can garble the video output,
; so be careful not to write to it accidentally in a C64 program!

;========================================================================
; vicSelectBank
;========================================================================
; 0 $0000-$3FFF (Default)
; 1 $4000-$7FFF (Charset not available)
; 2 $8000-$BFFF
; 3 $C000-$FFFF (Charset not available)
;========================================================================
.macro vic_SelectBank bankNum
  _selectBank bankNum, $dd02, $dd00
.endmacro

.macro _selectBank bankNum, cia_data_direction, cia_pra
  lda cia_data_direction
  ora #$03
  sta cia_data_direction
  lda cia_pra
  and %11111100
  ora #3-bankNum
  sta cia_pra
.endmacro

;========================================================================
; Screen Memory pg 102
;========================================================================
; Bank - 0         Bank - 1           Bank - 2           Bank - 3       
; -----------      -------------      -------------      -------------
; 1  -- $0000      ; 17 -- $4000      ; 33 -- $8000     ; 45 -- $c000
; 2  -- $0400      ; 18 -- $4400      ; 34 -- $8400     ; 46 -- $c400
; 3  -- $0800      ; 19 -- $4800      ; 35 -- $8800     ; 47 -- $c800
; 4  -- $0C00      ; 20 -- $4C00      ; 36 -- $8C00     ; 48 -- $cC00
; 5  -- $1000      ; 21 -- $5000      ; 37 -- $A000
; 6  -- $1400      ; 22 -- $5400      ; 38 -- $A400
; 7  -- $1800      ; 23 -- $5800      ; 39 -- $A800
; 8  -- $1C00      ; 24 -- $5C00      ; 40 -- $AC00
; 9  -- $2000      ; 25 -- $6000      ; 41 -- $B000
; 10 -- $2400      ; 26 -- $6400      ; 42 -- $B400
; 11 -- $2800      ; 27 -- $6800      ; 43 -- $B800
; 12 -- $2C00      ; 28 -- $6C00      ; 44 -- $BC00
; 13 -- $3000      ; 29 -- $7000      
; 14 -- $3400      ; 30 -- $7400      
; 15 -- $3800      ; 31 -- $7800      
; 16 -- $3C00      ; 32 -- $7C00      
.macro vic_SelectScreenMemory idx 
  pVicSelectScreenMemory idx, vic_ram
.endmacro

.macro pVicSelectScreenMemory idx, vic_ram_register
  lda vic_ram_register
  and #%00001111	; clear high bits
  ora #16*idx
  sta vic_ram_register
.endmacro

;========================================================================
; Character Memory pg 103 - 106
;========================================================================
.macro vic_SelectCharMemory idx
  _vicSelectCharMemory idx, vic_ram
.endmacro

.macro _vicSelectCharMemory idx, vic_ram_register
  lda vic_ram_register
  and #%11110001	; clear bits 3-1
  ora #2*idx
  sta vic_ram_register
.endmacro

;========================================================================
; Multi-color Mode pg 115
;========================================================================
.macro vic_SetMultiColorMode
  lda VIC_CTRL_H
  ora #%00010000
  sta VIC_CTRL_H
.endmacro

.macro vic_SetStandardCharacterMode
  lda VIC_CTRL_H
  and #%11101111
  sta VIC_CTRL_H
.endmacro

.macro vic_SetHiRezBitmap
  lda VIC_CTRL_H
  ora #32
  sta VIC_CTRL_H
.endmacro

.macro vic_set38ColumnMode
  lda VIC_CTRL_H
  clc
  clv
  and #247
  sta VIC_CTRL_H
.endmacro

.macro vic_set40ColumnMode
  lda VIC_CTRL_H
  ora #8
  sta VIC_CTRL_H
.endmacro

;========================================================================
; Color RAM
;========================================================================
.macro vic_CopyColors source
  ldx #0
copyColorsLoop:
  lda source,x
  .repeat 4, I
  sta COLOR_RAM+(I*$100),x
  .endrepeat
  inx
  bne copyColorsLoop
.endmacro

.macro vic_CopyChars source, dest, SIZE
  ldx #0

: lda source,x
  sta dest,x

  .repeat (SIZE/256),I
  lda source+(I*$100),x
  sta dest+(I*$100),x
  .endrepeat

  clc
  clv
  inx
  bne :-
.endmacro

.CODE
scrollVal:
        .byte $00

.macro vic_clearScreen target
        ldx #0
        lda #0
:       
        .repeat (1000/256)
        sta target,x
        .endrepeat
        inx
        bne :-
.endmacro

incScroll:
        clc
        clv
        lda scrollVal
        adc #1
        and #%00000111
        sta scrollVal
        rts

decScroll:
        dec scrollVal
        lda scrollVal
        and #%00000111
        sta scrollVal
        rts

updateScroll:
        lda VIC_CTRL_H
        and #248
        clc
        adc scrollVal
        sta VIC_CTRL_H
        rts