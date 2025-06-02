game
.
 ; 

.L00 ;  rem *** any romsize should work

.L01 ;  set romsize 16k

.
 ; 

.L02 ;  dim frame = a

.L03 ;  dim addvalue = b

.
 ; 

.L04 ;  rem ** we define this because player 0 has multiple frames...

.L05 ;  dim bmp_player0_index = c

.
 ; 

.L06 ;  scorecolor = $8a

	LDA #$8a
	STA scorecolor
.
 ; 

.resettitlepage
 ; resettitlepage

.L07 ;  frame = 0

	LDA #0
	STA frame
.L08 ;  player0x = 0

	LDA #0
	STA player0x
.L09 ;  player0y = 11

	LDA #11
	STA player0y
.L010 ;  player1x = 159

	LDA #159
	STA player1x
.L011 ;  player1y = 25

	LDA #25
	STA player1y
.L012 ;  addvalue = 1

	LDA #1
	STA addvalue
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
.L014 ;  frame = frame + 1

	INC frame
.L015 ;  temp1 = frame & 3

	LDA frame
	AND #3
	STA temp1
.L016 ;  if temp1 > 0 then skipplayeranim

	LDA #0
	CMP temp1
	bcc .skipplayeranim
 if ( (((((#>*)&$1f)*256)|(#<.skipplayeranim))>=bankswitch_hotspot) && (((((#>*)&$1f)*256)|(#<.skipplayeranim))<=(bankswitch_hotspot+bs_mask)) )
   echo "WARNING: branch near the end of bank 1 may accidentally trigger a bankswitch. Reposition code there if bad things happen."
 endif
.L017 ;  bmp_player0_index = bmp_player0_index + 10

	LDA bmp_player0_index
	CLC
	ADC #10
	STA bmp_player0_index
.L018 ;  player0x = player0x + 1

	INC player0x
.L019 ;  player1x = player1x - 1

	DEC player1x
.L020 ;  player0y = player0y + addvalue

	LDA player0y
	CLC
	ADC addvalue
	STA player0y
.L021 ;  if player0x > 159 then player0x = 0

	LDA #159
	CMP player0x
     BCS .skipL021
.condpart0
	LDA #0
	STA player0x
.skipL021
.L022 ;  if player1x > 200 then player1x = 159

	LDA #200
	CMP player1x
     BCS .skipL022
.condpart1
	LDA #159
	STA player1x
.skipL022
.L023 ;  if player0y = 40  ||  player0y = 10 then addvalue = addvalue ^ 254

	LDA player0y
	CMP #40
     BNE .skipL023
.condpart2
 jmp .condpart3
.skipL023
	LDA player0y
	CMP #10
     BNE .skip0OR
.condpart3
	LDA addvalue
	EOR #254
	STA addvalue
.skip0OR
.L024 ;  if bmp_player0_index > 30 then bmp_player0_index = 0

	LDA #30
	CMP bmp_player0_index
     BCS .skipL024
.condpart4
	LDA #0
	STA bmp_player0_index
.skipL024
.skipplayeranim
 ; skipplayeranim

.
 ; 

.L025 ;  if joy0fire  ||  switchreset then player0y = 200 : player1y = 200 : goto gamestart

 bit INPT4
	BMI .skipL025
.condpart5
 jmp .condpart6
.skipL025
 lda #1
 bit SWCHB
	BNE .skip1OR
.condpart6
	LDA #200
	STA player0y
	STA player1y
 jmp .gamestart

.skip1OR
.L026 ;  goto titlepage

 jmp .titlepage

.
 ; 

.L027 ;  rem *** Our fake game start. If you move the joystick it goes back to the

.L028 ;  rem *** title screen.

.gamestart
 ; gamestart

.
 ; 

.L029 ;  rem *** if you used the player kernel, you'll need to hide the players or 

.L030 ;  rem *** redefine them, or else you'll see garbage on the screen.

.L031 ;  player0:

	LDX #<playerL031_0
	STX player0pointerlo
	LDA #>playerL031_0
	STA player0pointerhi
	LDA #0
	STA player0height
.L032 ;  player1:

	LDX #<playerL032_1
	STX player1pointerlo
	LDA #>playerL032_1
	STA player1pointerhi
	LDA #0
	STA player1height
.L033 ;  missile0height = 1

	LDA #1
	STA missile0height
.L034 ;  missile1height = 1

	LDA #1
	STA missile1height
.
 ; 

.gameloop
 ; gameloop

.L035 ;  drawscreen

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
.L036 ;  if joy0left  ||  joy0right then goto resettitlepage

 bit SWCHA
	BVS .skipL036
.condpart7
 jmp .condpart8
.skipL036
 bit SWCHA
	BMI .skip2OR
.condpart8
 jmp .resettitlepage

.skip2OR
.L037 ;  if joy0up  ||  joy0down then goto resettitlepage

 lda #$10
 bit SWCHA
	BNE .skipL037
.condpart9
 jmp .condpart10
.skipL037
 lda #$20
 bit SWCHA
	BNE .skip3OR
.condpart10
 jmp .resettitlepage

.skip3OR
.L038 ;  goto gameloop

 jmp .gameloop

.
 ; 

.L039 ;  bank 2

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
.L040 ;  rem *** We're putting the title kernel here, but it can go in any bank you

.L041 ;  rem *** like. Just don't let your program flow accidentally fall into the

.L042 ;  rem *** line below.

.L043 ;  asm

 include "titlescreen/asm/titlescreen.asm"

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
 if (<*) > (<(*+0))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL031_0
	.byte  0
 if (<*) > (<(*+0))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL032_1
	.byte  0
 if ECHOFIRST
       echo "    ",[(scoretable - *)]d , "bytes of ROM space left in bank 4")
 endif 
ECHOFIRST = 1
 
 
 
