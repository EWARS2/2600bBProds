game
.
 ; 

.L00 ;  rem *** any romsize should work

.L01 ;  set romsize 16k

.
 ; 

.L02 ;  dim bmp_48x1_2_index = a

.L03 ;  dim frame = b

.
 ; 

.L04 ;  scorecolor = $1a

	LDA #$1a
	STA scorecolor
.
 ; 

.resettitlepage
 ; resettitlepage

.L05 ;  frame = 0

	LDA #0
	STA frame
.L06 ;  bmp_48x1_2_index = 0

	LDA #0
	STA bmp_48x1_2_index
.
 ; 

.titlepage
 ; titlepage

.L07 ;  gosub titledrawscreen bank2

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
.L08 ;  frame = frame + 1

	INC frame
.L09 ;  temp1 = frame & %00000111

	LDA frame
	AND #%00000111
	STA temp1
.L010 ;  if temp1 = 0  &&  bmp_48x1_2_index < 190 then bmp_48x1_2_index = bmp_48x1_2_index + 1

	LDA temp1
	CMP #0
     BNE .skipL010
.condpart0
	LDA bmp_48x1_2_index
	CMP #190
     BCS .skip0then
.condpart1
	INC bmp_48x1_2_index
.skip0then
.skipL010
.L011 ;  if joy0fire  ||  switchreset then goto gamestart

 bit INPT4
	BMI .skipL011
.condpart2
 jmp .condpart3
.skipL011
 lda #1
 bit SWCHB
	BNE .skip1OR
.condpart3
 jmp .gamestart

.skip1OR
.L012 ;  goto titlepage

 jmp .titlepage

.
 ; 

.L013 ;  rem *** Our fake game start. If you move the joystick it goes back to the

.L014 ;  rem *** title screen.

.gamestart
 ; gamestart

.L015 ;  drawscreen

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
.L016 ;  if joy0left  ||  joy0right then goto resettitlepage

 bit SWCHA
	BVS .skipL016
.condpart4
 jmp .condpart5
.skipL016
 bit SWCHA
	BMI .skip2OR
.condpart5
 jmp .resettitlepage

.skip2OR
.L017 ;  if joy0up  ||  joy0down then goto resettitlepage

 lda #$10
 bit SWCHA
	BNE .skipL017
.condpart6
 jmp .condpart7
.skipL017
 lda #$20
 bit SWCHA
	BNE .skip3OR
.condpart7
 jmp .resettitlepage

.skip3OR
.L018 ;  goto gamestart

 jmp .gamestart

.
 ; 

.L019 ;  bank 2

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
.L020 ;  rem *** We're putting the title kernel here, but it can go in any bank you

.L021 ;  rem *** like. Just don't let your program flow accidentally fall into the

.L022 ;  rem *** line below.

.L023 ;  asm

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
 if ECHOFIRST
       echo "    ",[(scoretable - *)]d , "bytes of ROM space left in bank 4")
 endif 
ECHOFIRST = 1
 
 
 
