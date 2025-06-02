game
.
 ; 

.L00 ;  set romsize 16kSC

.
 ; 

.L01 ;  rem ** Demo of the Cosmic Ark starfield effect in bB

.
 ; 

.L02 ;  rem ** no_blank_lines takes away missile0, so we'll create our starfield

.L03 ;  rem ** using it.

.L04 ;  set kernel_options no_blank_lines

.
 ; 

.L05 ;  scorecolor = $0f

	LDA #$0f
	STA scorecolor
.
 ; 

.L06 ;  dim frame = a

.L07 ;  dim effect = b

.
 ; 

.L08 ;  CTRLPF = 5

	LDA #5
	STA CTRLPF
.L09 ;  playfield:

  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel0
PF_data0
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000011, %11111111
	if (pfwidth>2)
	.byte %11111111, %00000011
 endif
	.byte %00011111, %11111111
	if (pfwidth>2)
	.byte %11111111, %00011111
 endif
	.byte %11111111, %11111111
	if (pfwidth>2)
	.byte %11111111, %11111111
 endif
pflabel0
	lda PF_data0,x
	sta playfield-128,x
	dex
	bpl pflabel0
.
 ; 

.L010 ;  player0:

	LDX #<playerL010_0
	STX player0pointerlo
	LDA #>playerL010_0
	STA player0pointerhi
	LDA #4
	STA player0height
.
 ; 

.L011 ;  player1:

	LDX #<playerL011_1
	STX player1pointerlo
	LDA #>playerL011_1
	STA player1pointerhi
	LDA #4
	STA player1height
.
 ; 

.
 ; 

.L012 ;  rem ** position the other objects, to prove we still can

.L013 ;  player0x = 50 : player0y = 40

	LDA #50
	STA player0x
	LDA #40
	STA player0y
.L014 ;  player1x = 120 : player1y = 40

	LDA #120
	STA player1x
	LDA #40
	STA player1y
.L015 ;  ballx = 70 : bally = 40 : ballheight = 6

	LDA #70
	STA ballx
	LDA #40
	STA bally
	LDA #6
	STA ballheight
.L016 ;  missile1x = 100 : missile1y = 40 : missile1height = 6

	LDA #100
	STA missile1x
	LDA #40
	STA missile1y
	LDA #6
	STA missile1height
.
 ; 

.
 ; 

.mainloop
 ; mainloop

.L017 ;  COLUP0 = $0A

	LDA #$0A
	STA COLUP0
.L018 ;  COLUP1 = $44

	LDA #$44
	STA COLUP1
.L019 ;  COLUBK = $80

	LDA #$80
	STA COLUBK
.L020 ;  COLUPF = $B4

	LDA #$B4
	STA COLUPF
.
 ; 

.L021 ;  player0x = player0x - 1

	DEC player0x
.
 ; 

.L022 ;  frame = frame + 1

	INC frame
.L023 ;  if frame = 0 then effect = effect + 1

	LDA frame
	CMP #0
     BNE .skipL023
.condpart0
	INC effect
.skipL023
.L024 ;  if effect > 6 then effect = 0

	LDA #6
	CMP effect
     BCS .skipL024
.condpart1
	LDA #0
	STA effect
.skipL024
.
 ; 

.L025 ;  ENAM0 = 2  :  rem ** set ENAM0=0 when you want the stars to be gone

	LDA #2
	STA ENAM0
.
 ; 

.L026 ;  rem ** no adjustment leaves the stars in place

.L027 ;  if effect = 0 then score = 0

	LDA effect
	CMP #0
     BNE .skipL027
.condpart2
	LDA #$00
	STA score+2
	LDA #$00
	STA score+1
	LDA #$00
	STA score
.skipL027
.
 ; 

.L028 ;  rem ** Adjusting missile0x by +1 or -1 moves the stars right or left

.L029 ;  if effect = 1 then missile0x = missile0x - 1 : score = 1

	LDA effect
	CMP #1
     BNE .skipL029
.condpart3
	DEC missile0x
	LDA #$01
	STA score+2
	LDA #$00
	STA score+1
	LDA #$00
	STA score
.skipL029
.
 ; 

.L030 ;  rem ** +8 or -8 moves the stars diagonally, and displays them closer together

.L031 ;  if effect = 2 then missile0x = missile0x - 8 : score = 8

	LDA effect
	CMP #2
     BNE .skipL031
.condpart4
	LDA missile0x
	SEC
	SBC #8
	STA missile0x
	LDA #$08
	STA score+2
	LDA #$00
	STA score+1
	LDA #$00
	STA score
.skipL031
.
 ; 

.L032 ;  rem ** +16 or -16 moves them diagonally, and displays them farther apart 

.L033 ;  if effect = 3 then missile0x = missile0x + 16 : score = 16

	LDA effect
	CMP #3
     BNE .skipL033
.condpart5
	LDA missile0x
	CLC
	ADC #16
	STA missile0x
	LDA #$16
	STA score+2
	LDA #$00
	STA score+1
	LDA #$00
	STA score
.skipL033
.
 ; 

.L034 ;  rem ** +12 or -12 is quick and nearly vertical

.L035 ;  if effect = 4 then missile0x = missile0x - 12 : score = 12

	LDA effect
	CMP #4
     BNE .skipL035
.condpart6
	LDA missile0x
	SEC
	SBC #12
	STA missile0x
	LDA #$12
	STA score+2
	LDA #$00
	STA score+1
	LDA #$00
	STA score
.skipL035
.
 ; 

.L036 ;  rem ** +48 or -48 is a slow diagonal effect

.L037 ;  if effect = 5 then missile0x = missile0x - 48 : score = 48

	LDA effect
	CMP #5
     BNE .skipL037
.condpart7
	LDA missile0x
	SEC
	SBC #48
	STA missile0x
	LDA #$48
	STA score+2
	LDA #$00
	STA score+1
	LDA #$00
	STA score
.skipL037
.
 ; 

.L038 ;  rem ** +48 or -48 is a slow diagonal effect

.L039 ;  if effect = 6 then missile0x = missile0x + 32 : score = 32

	LDA effect
	CMP #6
     BNE .skipL039
.condpart8
	LDA missile0x
	CLC
	ADC #32
	STA missile0x
	LDA #$32
	STA score+2
	LDA #$00
	STA score+1
	LDA #$00
	STA score
.skipL039
.
 ; 

.L040 ;  rem ** You need to ensure the missile0x position ranges from 0-159. 

.L041 ;  rem ** If missile0x is 0 and decreases, then set it to 159. 

.L042 ;  rem ** If missile0x is 159 and increases, set it to 0.

.L043 ;  if missile0x > 200 then missile0x = missile0x + 160

	LDA #200
	CMP missile0x
     BCS .skipL043
.condpart9
	LDA missile0x
	CLC
	ADC #160
	STA missile0x
.skipL043
.L044 ;  if missile0x > 159 then missile0x = missile0x - 160

	LDA #159
	CMP missile0x
     BCS .skipL044
.condpart10
	LDA missile0x
	SEC
	SBC #160
	STA missile0x
.skipL044
.
 ; 

.L045 ;  drawscreen

 sta temp7
 lda #>(ret_point1-1)
 pha
 lda #<(ret_point1-1)
 pha
 lda #>(drawscreen-1)
 pha
 lda #<(drawscreen-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point1
.L046 ;  goto mainloop

 jmp .mainloop

.
 ; 

.L047 ;  bank 2

 if ECHO1
 echo "    ",[(start_bank1 - *)]d , "bytes of ROM space left in bank 1")
 endif
ECHO1 = 1
 ORG $1FF4-bscode_length
 RORG $9FF4-bscode_length
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
 RORG $9FFC
 .word (start_bank1 & $ffff)
 .word (start_bank1 & $ffff)
 ORG $2000
 RORG $B000
 repeat 256
 .byte $ff
 repend
.L048 ;  bank 3

 if ECHO2
 echo "    ",[(start_bank2 - *)]d , "bytes of ROM space left in bank 2")
 endif
ECHO2 = 1
 ORG $2FF4-bscode_length
 RORG $BFF4-bscode_length
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
 RORG $BFFC
 .word (start_bank2 & $ffff)
 .word (start_bank2 & $ffff)
 ORG $3000
 RORG $D000
 repeat 256
 .byte $ff
 repend
.L049 ;  bank 4

 if ECHO3
 echo "    ",[(start_bank3 - *)]d , "bytes of ROM space left in bank 3")
 endif
ECHO3 = 1
 ORG $3FF4-bscode_length
 RORG $DFF4-bscode_length
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
 RORG $DFFC
 .word (start_bank3 & $ffff)
 .word (start_bank3 & $ffff)
 ORG $4000
 RORG $F000
 repeat 256
 .byte $ff
 repend
; bB.asm file is split here
.
 ; 

.L050 ;  vblank

vblank_bB_code
.L051 ;  rem ** Enable the TIA bug that causes missile0 to be repeated

.L052 ;  asm

 sta HMCLR

 sta WSYNC

 lda #$ff

 sta HMM0

 lda #$c0

 sta WSYNC

 sta HMOVE

 sleep 5

 sta HMM0

.L053 ;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
 if (<*) > (<(*+4))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL010_0
	.byte  %10000001
	.byte  %11000011
	.byte  %11111111
	.byte  %01011010
	.byte  %00111100
 if (<*) > (<(*+4))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL011_1
	.byte  %00111100
	.byte  %01011010
	.byte  %11111111
	.byte  %11000011
	.byte  %10000001
 if ECHOFIRST
       echo "    ",[(scoretable - *)]d , "bytes of ROM space left in bank 4")
 endif 
ECHOFIRST = 1
 
 
 
