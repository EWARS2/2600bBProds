game
.L00 ;  set kernel DPC + 

.
 ; 

.L01 ;  dim _frame  =  a

.
 ; 

.
 ; 

.
 ; 

.L02 ;  goto __Bank_2 bank2

 sta temp7
 lda #>(.__Bank_2-1)
 pha
 lda #<(.__Bank_2-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #2
 jmp BS_jsr
.
 ; 

.
 ; 

.
 ; 

.L03 ;  bank 2

 if ECHO1
 echo "    ",[(start_bank1 - *)]d , "bytes of ROM space left in bank 1")
 endif
ECHO1 = 1
 ORG $1FF4-bscode_length
 RORG $1FF4-bscode_length
start_bank1 ldx #$ff
 ifconst FASTFETCH ; using DPC+
 stx FASTFETCH
 endif 
 txs
 if bankswitch == 64
   lda #(((>(start-1)) & $0F) | $F0)
 else
   lda #>(start-1)
 endif
 pha
 lda #<(start-1)
 pha
 pha
 txa
 pha
 tsx
 if bankswitch != 64
   lda 4,x ; get high byte of return address
   rol
   rol
   rol
   rol
   and #bs_mask ;1 3 or 7 for F8/F6/F4
   tax
   inx
 else
   lda 4,x ; get high byte of return address
   tay
   ora #$10 ; change our bank nibble into a valid rom mirror
   sta 4,x
   tya
   lsr 
   lsr 
   lsr 
   lsr 
   tax
   inx
 endif
 lda bankswitch_hotspot-1,x
 pla
 tax
 pla
 rts
 if ((* & $1FFF) > ((bankswitch_hotspot & $1FFF) - 1))
   echo "WARNING: size parameter in banksw.asm too small - the program probably will not work."
   echo "Change to",[(*-begin_bscode+1)&$FF]d,"and try again."
 endif
 ORG $1FFC
 RORG $1FFC
 .word (start_bank1 & $ffff)
 .word (start_bank1 & $ffff)
 ORG $2000
 RORG $3000
HMdiv
  .byte 0, 0, 0, 0, 0, 0, 0
  .byte 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2
  .byte 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3
  .byte 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4
  .byte 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5
  .byte 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6
  .byte 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7
  .byte 7, 7, 7, 7, 7, 7, 7, 7, 7, 8, 8, 8, 8, 8, 8, 8
  .byte 8, 8, 8, 8, 8, 8, 8, 8, 9, 9, 9, 9, 9, 9, 9, 9
  .byte 9, 9, 9, 9, 9, 9, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10
  .byte 10,10,10,10,10,10,0,0,0
.L04 ;  temp1 = temp1

	LDA temp1
	STA temp1
.
 ; 

.__Bank_2
 ; __Bank_2

.
 ; 

.L05 ;  playfield:

 ldy #147
	LDA #<PF_data1
	LDX #((>PF_data1) & $0f) | (((>PF_data1) / 2) & $70)
 sta temp7
 lda #>(ret_point1-1)
 pha
 lda #<(ret_point1-1)
 pha
 lda #>(pfsetup-1)
 pha
 lda #<(pfsetup-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
ret_point1
.
 ; 

.L06 ;  pfcolors:

	LDA #<PFCOLS
	STA DF0LOW
	LDA #(>PFCOLS) & $0F
	STA DF0HI
	LDA #<playfieldcolorL06
	STA PARAMETER
	LDA #((>playfieldcolorL06) & $0f) | (((>playfieldcolorL06) / 2) & $70)
	STA PARAMETER
	LDA #0
	STA PARAMETER
	LDA #88
	STA PARAMETER
	LDA #1
	STA CALLFUNCTION
.
 ; 

.L07 ;  bkcolors:

	LDA #<BKCOLS
	STA DF0LOW
	LDA #(>BKCOLS) & $0F
	STA DF0HI
	LDA #<backgroundcolorL07
	STA PARAMETER
	LDA #((>backgroundcolorL07) & $0f) | (((>backgroundcolorL07) / 2) & $70)
	STA PARAMETER
	LDA #0
	STA PARAMETER
	LDA #88
	STA PARAMETER
	LDA #1
	STA CALLFUNCTION
.
 ; 

.L08 ;  DF0FRACINC  =  255

	LDA #255
	STA DF0FRACINC
.L09 ;  DF1FRACINC  =  255

	LDA #255
	STA DF1FRACINC
.L010 ;  DF2FRACINC  =  255

	LDA #255
	STA DF2FRACINC
.L011 ;  DF3FRACINC  =  255

	LDA #255
	STA DF3FRACINC
.L012 ;  DF4FRACINC  =  255

	LDA #255
	STA DF4FRACINC
.L013 ;  DF6FRACINC  =  255

	LDA #255
	STA DF6FRACINC
.
 ; 

.L014 ;  CTRLPF  =  $05

	LDA #$05
	STA CTRLPF
.
 ; 

.L015 ;  player2x = 23  :  player2y = 20  :  NUSIZ2  =  $37

	LDA #23
	STA player2x
	LDA #20
	STA player2y
	LDA #$37
	STA NUSIZ2
.L016 ;  missile1x = 23 - 4  :  missile1y = 10  :  missile1height  =  8

	LDA #23
	SEC
	SBC #4
	STA missile1x
	LDA #10
	STA missile1y
	LDA #8
	STA missile1height
.L017 ;  NUSIZ0  =  NUSIZ0  |  $30

	LDA NUSIZ0
	ORA #$30
	STA NUSIZ0
.L018 ;  player2:

	lda #<(playerpointers+2)
	sta DF0LOW
	lda #(>(playerpointers+2)) & $0F
	sta DF0HI
	LDX #<playerL018_2
	STX DF0WRITE
	LDA #((>playerL018_2) & $0f) | (((>playerL018_2) / 2) & $70)
	STA DF0WRITE
	LDA #18
	STA player2height
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__main
 ; __main

.
 ; 

.L019 ;  if joy0down then player2y = player2y + 1

 lda #$20
 bit SWCHA
	BNE .skipL019
.condpart0
	INC player2y
.skipL019
.L020 ;  if joy0up then player2y = player2y - 1

 lda #$10
 bit SWCHA
	BNE .skipL020
.condpart1
	DEC player2y
.skipL020
.L021 ;  if joy0left then player2x = player2x - 1

 bit SWCHA
	BVS .skipL021
.condpart2
	DEC player2x
.skipL021
.L022 ;  if joy0right then player2x = player2x + 1

 bit SWCHA
	BMI .skipL022
.condpart3
	INC player2x
.skipL022
.
 ; 

.L023 ;  drawscreen

 sta temp7
 lda #>(ret_point2-1)
 pha
 lda #<(ret_point2-1)
 pha
 lda #>(drawscreen-1)
 pha
 lda #<(drawscreen-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
ret_point2
.L024 ;  goto __main

 jmp .__main

.
 ; 

.L025 ;  bank 3

 if ECHO2
 echo "    ",[(start_bank2 - *)]d , "bytes of ROM space left in bank 2")
 endif
ECHO2 = 1
 ORG $2FF4-bscode_length
 RORG $3FF4-bscode_length
start_bank2 ldx #$ff
 ifconst FASTFETCH ; using DPC+
 stx FASTFETCH
 endif 
 txs
 if bankswitch == 64
   lda #(((>(start-1)) & $0F) | $F0)
 else
   lda #>(start-1)
 endif
 pha
 lda #<(start-1)
 pha
 pha
 txa
 pha
 tsx
 if bankswitch != 64
   lda 4,x ; get high byte of return address
   rol
   rol
   rol
   rol
   and #bs_mask ;1 3 or 7 for F8/F6/F4
   tax
   inx
 else
   lda 4,x ; get high byte of return address
   tay
   ora #$10 ; change our bank nibble into a valid rom mirror
   sta 4,x
   tya
   lsr 
   lsr 
   lsr 
   lsr 
   tax
   inx
 endif
 lda bankswitch_hotspot-1,x
 pla
 tax
 pla
 rts
 if ((* & $1FFF) > ((bankswitch_hotspot & $1FFF) - 1))
   echo "WARNING: size parameter in banksw.asm too small - the program probably will not work."
   echo "Change to",[(*-begin_bscode+1)&$FF]d,"and try again."
 endif
 ORG $2FFC
 RORG $3FFC
 .word (start_bank2 & $ffff)
 .word (start_bank2 & $ffff)
 ORG $3000
 RORG $5000
 repeat 129
 .byte 0
 repend
.L026 ;  temp1 = temp1

	LDA temp1
	STA temp1
.
 ; 

.L027 ;  bank 4

 if ECHO3
 echo "    ",[(start_bank3 - *)]d , "bytes of ROM space left in bank 3")
 endif
ECHO3 = 1
 ORG $3FF4-bscode_length
 RORG $5FF4-bscode_length
start_bank3 ldx #$ff
 ifconst FASTFETCH ; using DPC+
 stx FASTFETCH
 endif 
 txs
 if bankswitch == 64
   lda #(((>(start-1)) & $0F) | $F0)
 else
   lda #>(start-1)
 endif
 pha
 lda #<(start-1)
 pha
 pha
 txa
 pha
 tsx
 if bankswitch != 64
   lda 4,x ; get high byte of return address
   rol
   rol
   rol
   rol
   and #bs_mask ;1 3 or 7 for F8/F6/F4
   tax
   inx
 else
   lda 4,x ; get high byte of return address
   tay
   ora #$10 ; change our bank nibble into a valid rom mirror
   sta 4,x
   tya
   lsr 
   lsr 
   lsr 
   lsr 
   tax
   inx
 endif
 lda bankswitch_hotspot-1,x
 pla
 tax
 pla
 rts
 if ((* & $1FFF) > ((bankswitch_hotspot & $1FFF) - 1))
   echo "WARNING: size parameter in banksw.asm too small - the program probably will not work."
   echo "Change to",[(*-begin_bscode+1)&$FF]d,"and try again."
 endif
 ORG $3FFC
 RORG $5FFC
 .word (start_bank3 & $ffff)
 .word (start_bank3 & $ffff)
 ORG $4000
 RORG $7000
 repeat 129
 .byte 0
 repend
.L028 ;  temp1 = temp1

	LDA temp1
	STA temp1
.
 ; 

.L029 ;  bank 5

 if ECHO4
 echo "    ",[(start_bank4 - *)]d , "bytes of ROM space left in bank 4")
 endif
ECHO4 = 1
 ORG $4FF4-bscode_length
 RORG $7FF4-bscode_length
start_bank4 ldx #$ff
 ifconst FASTFETCH ; using DPC+
 stx FASTFETCH
 endif 
 txs
 if bankswitch == 64
   lda #(((>(start-1)) & $0F) | $F0)
 else
   lda #>(start-1)
 endif
 pha
 lda #<(start-1)
 pha
 pha
 txa
 pha
 tsx
 if bankswitch != 64
   lda 4,x ; get high byte of return address
   rol
   rol
   rol
   rol
   and #bs_mask ;1 3 or 7 for F8/F6/F4
   tax
   inx
 else
   lda 4,x ; get high byte of return address
   tay
   ora #$10 ; change our bank nibble into a valid rom mirror
   sta 4,x
   tya
   lsr 
   lsr 
   lsr 
   lsr 
   tax
   inx
 endif
 lda bankswitch_hotspot-1,x
 pla
 tax
 pla
 rts
 if ((* & $1FFF) > ((bankswitch_hotspot & $1FFF) - 1))
   echo "WARNING: size parameter in banksw.asm too small - the program probably will not work."
   echo "Change to",[(*-begin_bscode+1)&$FF]d,"and try again."
 endif
 ORG $4FFC
 RORG $7FFC
 .word (start_bank4 & $ffff)
 .word (start_bank4 & $ffff)
 ORG $5000
 RORG $9000
 repeat 129
 .byte 0
 repend
.L030 ;  temp1 = temp1

	LDA temp1
	STA temp1
.
 ; 

.L031 ;  bank 6

 if ECHO5
 echo "    ",[(start_bank5 - *)]d , "bytes of ROM space left in bank 5")
 endif
ECHO5 = 1
 ORG $5FF4-bscode_length
 RORG $9FF4-bscode_length
start_bank5 ldx #$ff
 ifconst FASTFETCH ; using DPC+
 stx FASTFETCH
 endif 
 txs
 if bankswitch == 64
   lda #(((>(start-1)) & $0F) | $F0)
 else
   lda #>(start-1)
 endif
 pha
 lda #<(start-1)
 pha
 pha
 txa
 pha
 tsx
 if bankswitch != 64
   lda 4,x ; get high byte of return address
   rol
   rol
   rol
   rol
   and #bs_mask ;1 3 or 7 for F8/F6/F4
   tax
   inx
 else
   lda 4,x ; get high byte of return address
   tay
   ora #$10 ; change our bank nibble into a valid rom mirror
   sta 4,x
   tya
   lsr 
   lsr 
   lsr 
   lsr 
   tax
   inx
 endif
 lda bankswitch_hotspot-1,x
 pla
 tax
 pla
 rts
 if ((* & $1FFF) > ((bankswitch_hotspot & $1FFF) - 1))
   echo "WARNING: size parameter in banksw.asm too small - the program probably will not work."
   echo "Change to",[(*-begin_bscode+1)&$FF]d,"and try again."
 endif
 ORG $5FFC
 RORG $9FFC
 .word (start_bank5 & $ffff)
 .word (start_bank5 & $ffff)
 ORG $6000
 RORG $B000
 repeat 129
 .byte 0
 repend
.L032 ;  temp1 = temp1
	LDA temp1
	STA temp1
 if ECHO6
 echo "    ",[(start_bank6 - *)]d , "bytes of ROM space left in bank 6")
 endif
ECHO6 = 1
 ORG $6FF4-bscode_length
 RORG $BFF4-bscode_length
start_bank6 ldx #$ff
 ifconst FASTFETCH ; using DPC+
 stx FASTFETCH
 endif 
 txs
 if bankswitch == 64
   lda #(((>(start-1)) & $0F) | $F0)
 else
   lda #>(start-1)
 endif
 pha
 lda #<(start-1)
 pha
 pha
 txa
 pha
 tsx
 if bankswitch != 64
   lda 4,x ; get high byte of return address
   rol
   rol
   rol
   rol
   and #bs_mask ;1 3 or 7 for F8/F6/F4
   tax
   inx
 else
   lda 4,x ; get high byte of return address
   tay
   ora #$10 ; change our bank nibble into a valid rom mirror
   sta 4,x
   tya
   lsr 
   lsr 
   lsr 
   lsr 
   tax
   inx
 endif
 lda bankswitch_hotspot-1,x
 pla
 tax
 pla
 rts
 if ((* & $1FFF) > ((bankswitch_hotspot & $1FFF) - 1))
   echo "WARNING: size parameter in banksw.asm too small - the program probably will not work."
   echo "Change to",[(*-begin_bscode+1)&$FF]d,"and try again."
 endif
 ORG $6FFC
 RORG $BFFC
 .word (start_bank6 & $ffff)
 .word (start_bank6 & $ffff)
 ORG $7000
 RORG $D000
 repeat 129
 .byte 0
 repend
; bB.asm file is split here
PF_data1
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00111100
	.byte %01111110
	.byte %00111100
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %00111100
	.byte %01111110
	.byte %00111100
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00111100
	.byte %01111110
	.byte %00111100
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %00111100
	.byte %01111110
	.byte %00111100
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00111100
	.byte %01111110
	.byte %00111100
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %00111100
	.byte %01111110
	.byte %00111100
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00001111
	.byte %00000111
	.byte %00001000
	.byte %00001000
	.byte %00000100
	.byte %00000100
	.byte %00000100
	.byte %00000010
	.byte %00000010
	.byte %00000010
	.byte %00000010
	.byte %00000001
	.byte %00000001
	.byte %00000001
	.byte %00000001
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00111100
	.byte %01111110
	.byte %00111100
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %00111100
	.byte %01111110
	.byte %00111100
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00111100
	.byte %01111110
	.byte %00111100
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %00111100
	.byte %01111110
	.byte %00111100
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00111100
	.byte %01111110
	.byte %00111100
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %00111100
	.byte %01111110
	.byte %00111100
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %11111111
	.byte %11111111
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000001
	.byte %00000001
	.byte %00000001
	.byte %00000010
	.byte %00000110
	.byte %11111100
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00111100
	.byte %01111110
	.byte %00111100
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %00111100
	.byte %01111110
	.byte %00111100
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00111100
	.byte %01111110
	.byte %00111100
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %00111100
	.byte %01111110
	.byte %00111100
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00111100
	.byte %01111110
	.byte %00111100
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %00111100
	.byte %01111110
	.byte %00111100
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %11111111
	.byte %11111111
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000001
	.byte %00000001
	.byte %00000001
	.byte %00000010
	.byte %00000110
	.byte %11111100
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00111100
	.byte %01111110
	.byte %00111100
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %00111100
	.byte %01111110
	.byte %00111100
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00111100
	.byte %01111110
	.byte %00111100
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %00111100
	.byte %01111110
	.byte %00111100
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00111100
	.byte %01111110
	.byte %00111100
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %01111110
	.byte %00111100
	.byte %01111110
	.byte %00111100
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00001111
	.byte %00000111
	.byte %00001000
	.byte %00001000
	.byte %00000100
	.byte %00000100
	.byte %00000100
	.byte %00000010
	.byte %00000010
	.byte %00000010
	.byte %00000010
	.byte %00000001
	.byte %00000001
	.byte %00000001
	.byte %00000001
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
playfieldcolorL06
	.byte  $0A
	.byte  $08
	.byte  $0A
	.byte  $08
	.byte  $0A
	.byte  $08
	.byte  $0A
	.byte  $08
	.byte  $0A
	.byte  $08
	.byte  $0A
	.byte  $08
	.byte  $0A
	.byte  $08
	.byte  $0A
	.byte  $08
	.byte  $0A
	.byte  $08
	.byte  $0A
	.byte  $08
	.byte  $0A
	.byte  $08
	.byte  $0A
	.byte  $08
	.byte  $0A
	.byte  $08
	.byte  $0A
	.byte  $08
	.byte  $0A
	.byte  $08
	.byte  $0A
	.byte  $08
	.byte  $0A
	.byte  $08
	.byte  $0A
	.byte  $08
	.byte  $0A
	.byte  $08
	.byte  $0A
	.byte  $08
	.byte  $0A
	.byte  $08
	.byte  $0A
	.byte  $08
	.byte  $0A
	.byte  $08
	.byte  $0A
	.byte  $08
	.byte  $0A
	.byte  $08
	.byte  $0A
	.byte  $08
	.byte  $0A
	.byte  $08
	.byte  $0A
	.byte  $08
	.byte  $0A
	.byte  $08
	.byte  $0A
	.byte  $08
	.byte  $0A
	.byte  $08
	.byte  $0A
	.byte  $0C
	.byte  $9E
	.byte  $9E
	.byte  $9E
	.byte  $9E
	.byte  $9E
	.byte  $9E
	.byte  $9E
	.byte  $9E
	.byte  $9E
	.byte  $08
	.byte  $0A
	.byte  $08
	.byte  $0A
	.byte  $08
	.byte  $0A
	.byte  $08
	.byte  $0A
	.byte  $08
	.byte  $0A
	.byte  $08
	.byte  $0A
	.byte  $08
	.byte  $0A
	.byte  $08
backgroundcolorL07
	.byte  $0E
	.byte  $0C
	.byte  $0E
	.byte  $0C
	.byte  $0E
	.byte  $0C
	.byte  $0E
	.byte  $0C
	.byte  $0E
	.byte  $0C
	.byte  $0E
	.byte  $0C
	.byte  $0E
	.byte  $0C
	.byte  $0E
	.byte  $0C
	.byte  $0E
	.byte  $0C
	.byte  $0E
	.byte  $0C
	.byte  $0E
	.byte  $0C
	.byte  $0E
	.byte  $0C
	.byte  $0E
	.byte  $0C
	.byte  $0E
	.byte  $0C
	.byte  $0E
	.byte  $0C
	.byte  $0E
	.byte  $0C
	.byte  $0E
	.byte  $0C
	.byte  $0E
	.byte  $0C
	.byte  $0E
	.byte  $0C
	.byte  $0E
	.byte  $0C
	.byte  $0E
	.byte  $0C
	.byte  $0E
	.byte  $0C
	.byte  $0E
	.byte  $0C
	.byte  $0E
	.byte  $0C
	.byte  $0E
	.byte  $0C
	.byte  $0E
	.byte  $0C
	.byte  $0E
	.byte  $0C
	.byte  $0E
	.byte  $0C
	.byte  $0E
	.byte  $0C
	.byte  $0E
	.byte  $0C
	.byte  $0E
	.byte  $0C
	.byte  $0E
	.byte  $9E
	.byte  $0E
	.byte  $0C
	.byte  $0E
	.byte  $0C
	.byte  $0E
	.byte  $0C
	.byte  $0E
	.byte  $0C
	.byte  $0E
	.byte  $0C
	.byte  $0C
	.byte  $0C
	.byte  $0C
	.byte  $0C
	.byte  $0C
	.byte  $0C
	.byte  $0C
	.byte  $0C
	.byte  $0C
	.byte  $0C
	.byte  $0C
	.byte  $0C
	.byte  $0C
	.byte  $0C
playerL018_2
	.byte  %11000000
	.byte  %11000000
	.byte  %11100000
	.byte  %11100000
	.byte  %11100000
	.byte  %11110000
	.byte  %11110000
	.byte  %11110000
	.byte  %11110000
	.byte  %11111000
	.byte  %11111000
	.byte  %11111000
	.byte  %11111000
	.byte  %11111100
	.byte  %11111100
	.byte  %11111110
	.byte  %11111110
	.byte  %11111111
 if ECHOFIRST
       echo "    ",[(DPC_graphics_end - *)]d , "bytes of ROM space left in graphics bank")
 endif 
ECHOFIRST = 1
 
 
 
