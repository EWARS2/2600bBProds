game
.
 ; 

.L00 ;  rem *** any romsize should work

.L01 ;  set romsize 16k

.
 ; 

.L02 ;  rem *** a variable to switch frames of the yoshi picture

.L03 ;  dim bmp_48x1_1_index  =  a

.
 ; 

.L04 ;  rem *** a variable to color each frame of the yoshi picture

.L05 ;  dim bmp_48x1_1_color  =  b

.
 ; 

.L06 ;  rem *** a variable to color cycle the "press fire" text

.L07 ;  dim bmp_48x1_2_color  =  c

.
 ; 

.L08 ;  rem *** a frame counter

.L09 ;  dim frame  =  d

.
 ; 

.L010 ;  scorecolor = $0a

	LDA #$0a
	STA scorecolor
.
 ; 

.titlepage
 ; titlepage

.L011 ;  frame = frame + 1

	INC frame
.L012 ;  bmp_48x1_1_color = $4b  : bmp_48x1_1_index = 0

	LDA #$4b
	STA bmp_48x1_1_color
	LDA #0
	STA bmp_48x1_1_index
.L013 ;  if frame{0} then bmp_48x1_1_color = $ac  :  bmp_48x1_1_index = 87

	LDA frame
	LSR
	BCC .skipL013
.condpart0
	LDA #$ac
	STA bmp_48x1_1_color
	LDA #87
	STA bmp_48x1_1_index
.skipL013
.L014 ;  gosub titledrawscreen bank2

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
.
 ; 

.L015 ;  rem *** make the "press fire to start" color-cycle

.L016 ;  bmp_48x1_2_color = bmp_48x1_2_color + 1

	INC bmp_48x1_2_color
.L017 ;  if joy0fire then goto gamestart

 bit INPT4
	BMI .skipL017
.condpart1
 jmp .gamestart

.skipL017
.
 ; 

.L018 ;  goto titlepage

 jmp .titlepage

.
 ; 

.L019 ;  rem *** Our fake game start. If you move the joystick it goes back to the

.L020 ;  rem *** title screen.

.gamestart
 ; gamestart

.L021 ;  bmp_48x1_1_index = 0

	LDA #0
	STA bmp_48x1_1_index
.L022 ;  drawscreen

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
.L023 ;  if joy0left  ||  joy0right then goto titlepage

 bit SWCHA
	BVS .skipL023
.condpart2
 jmp .condpart3
.skipL023
 bit SWCHA
	BMI .skip0OR
.condpart3
 jmp .titlepage

.skip0OR
.L024 ;  if joy0up  ||  joy0down then goto titlepage

 lda #$10
 bit SWCHA
	BNE .skipL024
.condpart4
 jmp .condpart5
.skipL024
 lda #$20
 bit SWCHA
	BNE .skip1OR
.condpart5
 jmp .titlepage

.skip1OR
.L025 ;  goto gamestart

 jmp .gamestart

.
 ; 

.L026 ;  bank 2

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
.L027 ;  rem *** We're putting the title kernel here, but it can go in any bank you

.L028 ;  rem *** like. Just don't let your program flow accidentally fall into the

.L029 ;  rem *** line below.

.L030 ;  asm

 include "titlescreen/asm/titlescreen.asm"

.
 ; 

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
 
 
 
