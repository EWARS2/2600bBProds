game
.
 ; 

.L00 ;  rem *** any romsize should work

.L01 ;  set romsize 16k

.
 ; 

.L02 ;  rem *** The selected game number. The game selection minikernel displays 

.L03 ;  rem *** this variable

.L04 ;  dim gamenumber = a

.
 ; 

.L05 ;  rem *** this debounce variable is used to slow down the game number selection

.L06 ;  dim swdebounce = b

.
 ; 

.L07 ;  rem *** this turns on the score fading effect. it looks especially pretty

.L08 ;  rem *** if you do a "scorecolor=scorecolor+1" every 2nd or 4th frame.

.L09 ;  const scorefade = 1

.
 ; 

.L010 ;  scorecolor = $1a

	LDA #$1a
	STA scorecolor
.
 ; 

.L011 ;  swdebounce = 0

	LDA #0
	STA swdebounce
.L012 ;  gamenumber = 1

	LDA #1
	STA gamenumber
.
 ; 

.titlepage
 ; titlepage

.L013 ;  gosub titledrawscreen bank2

 sta temp7
 lda #>(ret_point1-1)
 pha
 lda #<(ret_point1-1)
 pha
 lda #>(.titledrawscreen-1)
 pha
 lda #<(.titledrawscreen-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #2
 jmp BS_jsr
ret_point1
.L014 ;  if joy0fire  ||  switchreset then goto gamestart

 bit INPT4
	BMI .skipL014
.condpart0
 jmp .condpart1
.skipL014
 lda #1
 bit SWCHB
	BNE .skip0OR
.condpart1
 jmp .gamestart

.skip0OR
.L015 ;  if !switchselect then swdebounce = 0

 lda #2
 bit SWCHB
	BEQ .skipL015
.condpart2
	LDA #0
	STA swdebounce
.skipL015
.L016 ;  if swdebounce > 0 then swdebounce = swdebounce - 1 :  goto titlepage

	LDA #0
	CMP swdebounce
     BCS .skipL016
.condpart3
	DEC swdebounce
 jmp .titlepage

.skipL016
.L017 ;  if switchselect then swdebounce = 30 :  gamenumber = gamenumber + 1 : if gamenumber = 21 then gamenumber = 1

 lda #2
 bit SWCHB
	BNE .skipL017
.condpart4
	LDA #30
	STA swdebounce
	INC gamenumber
	LDA gamenumber
	CMP #21
     BNE .skip4then
.condpart5
	LDA #1
	STA gamenumber
.skip4then
.skipL017
.L018 ;  goto titlepage

 jmp .titlepage

.
 ; 

.L019 ;  rem *** Our fake game start. If you move the joystick it goes back to the

.L020 ;  rem *** title screen.

.gamestart
 ; gamestart

.L021 ;  drawscreen

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
 ldx #4
 jmp BS_jsr
ret_point2
.L022 ;  if joy0left  ||  joy0right then goto titlepage

 bit SWCHA
	BVS .skipL022
.condpart6
 jmp .condpart7
.skipL022
 bit SWCHA
	BMI .skip1OR
.condpart7
 jmp .titlepage

.skip1OR
.L023 ;  if joy0up  ||  joy0down then goto titlepage

 lda #$10
 bit SWCHA
	BNE .skipL023
.condpart8
 jmp .condpart9
.skipL023
 lda #$20
 bit SWCHA
	BNE .skip2OR
.condpart9
 jmp .titlepage

.skip2OR
.L024 ;  goto gamestart

 jmp .gamestart

.
 ; 

.L025 ;  bank 2

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
.L026 ;  rem *** We're putting the title kernel here, but it can go in any bank you

.L027 ;  rem *** like. Just don't let your program flow accidentally fall into the

.L028 ;  rem *** line below.

.L029 ;  asm

 include "titlescreen/asm/titlescreen.asm"

.
 ; 

.L030 ;  bank 3

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
; bB.asm file is split here
 if ECHOFIRST
       echo "    ",[(scoretable - *)]d , "bytes of ROM space left in bank 4")
 endif 
ECHOFIRST = 1
 
 
 
