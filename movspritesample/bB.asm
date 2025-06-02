game
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

.L00 ;  dim _BitOp_01  =  y

.L01 ;  dim _Bit0_Reset_Restrainer  =  y

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

.L02 ;  const _P_Edge_Top  =  9

.L03 ;  const _P_Edge_Bottom  =  88

.L04 ;  const _P_Edge_Left  =  1

.L05 ;  const _P_Edge_Right  =  153

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

.L06 ;  const noscore  =  1

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

.__Start_Restart
 ; __Start_Restart

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

.L07 ;  AUDV0  =  0  :  AUDV1  =  0

	LDA #0
	STA AUDV0
	STA AUDV1
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

.L08 ;  a  =  0  :  b  =  0  :  c  =  0  :  d  =  0  :  e  =  0  :  f  =  0  :  g  =  0  :  h  =  0  :  i  =  0

	LDA #0
	STA a
	STA b
	STA c
	STA d
	STA e
	STA f
	STA g
	STA h
	STA i
.L09 ;  j  =  0  :  k  =  0  :  l  =  0  :  m  =  0  :  n  =  0  :  o  =  0  :  p  =  0  :  q  =  0  :  r  =  0

	LDA #0
	STA j
	STA k
	STA l
	STA m
	STA n
	STA o
	STA p
	STA q
	STA r
.L010 ;  s  =  0  :  t  =  0  :  u  =  0  :  v  =  0  :  w  =  0  :  x  =  0  :  y  =  0  :  z  =  0

	LDA #0
	STA s
	STA t
	STA u
	STA v
	STA w
	STA x
	STA y
	STA z
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

.L011 ;  player0x  =  77  :  player0y  =  53

	LDA #77
	STA player0x
	LDA #53
	STA player0y
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

.L012 ;  COLUPF  =  $2C

	LDA #$2C
	STA COLUPF
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

.L013 ;  COLUBK  =  0

	LDA #0
	STA COLUBK
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

.L014 ;  _Bit0_Reset_Restrainer{0}  =  1

	LDA _Bit0_Reset_Restrainer
	ORA #1
	STA _Bit0_Reset_Restrainer
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

.L015 ;  player0:

	LDX #<playerL015_0
	STX player0pointerlo
	LDA #>playerL015_0
	STA player0pointerhi
	LDA #7
	STA player0height
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

.L016 ;  playfield:

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
	.byte %00001111, %00111111
	if (pfwidth>2)
	.byte %00111111, %00001111
 endif
	.byte %00001000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00001000
 endif
	.byte %00001000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00001000
 endif
	.byte %00001000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00001000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00001111, %11110000
	if (pfwidth>2)
	.byte %11110000, %00001111
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
pflabel0
	lda PF_data0,x
	sta playfield,x
	dex
	bpl pflabel0
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

.__Main_Loop
 ; __Main_Loop

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

.L017 ;  COLUP0  =  $9C

	LDA #$9C
	STA COLUP0
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

.L018 ;  if joy0up  &&  player0y  >  _P_Edge_Top then player0y  =  player0y  -  1

 lda #$10
 bit SWCHA
	BNE .skipL018
.condpart0
	LDA #_P_Edge_Top
	CMP player0y
     BCS .skip0then
.condpart1
	DEC player0y
.skip0then
.skipL018
.
 ; 

.L019 ;  if joy0down  &&  player0y  <  _P_Edge_Bottom then player0y  =  player0y  +  1

 lda #$20
 bit SWCHA
	BNE .skipL019
.condpart2
	LDA player0y
	CMP #_P_Edge_Bottom
     BCS .skip2then
.condpart3
	INC player0y
.skip2then
.skipL019
.
 ; 

.L020 ;  if joy0left  &&  player0x  >  _P_Edge_Left then player0x  =  player0x  -  1

 bit SWCHA
	BVS .skipL020
.condpart4
	LDA #_P_Edge_Left
	CMP player0x
     BCS .skip4then
.condpart5
	DEC player0x
.skip4then
.skipL020
.
 ; 

.L021 ;  if joy0right  &&  player0x  <  _P_Edge_Right then player0x  =  player0x  +  1

 bit SWCHA
	BMI .skipL021
.condpart6
	LDA player0x
	CMP #_P_Edge_Right
     BCS .skip6then
.condpart7
	INC player0x
.skip6then
.skipL021
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

.L022 ;  drawscreen

 jsr drawscreen
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

.L023 ;  if !switchreset then _Bit0_Reset_Restrainer{0}  =  0  :  goto __Main_Loop

 lda #1
 bit SWCHB
	BEQ .skipL023
.condpart8
	LDA _Bit0_Reset_Restrainer
	AND #254
	STA _Bit0_Reset_Restrainer
 jmp .__Main_Loop

.skipL023
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

.L024 ;  if _Bit0_Reset_Restrainer{0} then goto __Main_Loop

	LDA _Bit0_Reset_Restrainer
	LSR
	BCC .skipL024
.condpart9
 jmp .__Main_Loop

.skipL024
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L025 ;  goto __Start_Restart
 jmp .__Start_Restart
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL015_0
	.byte    %00111100
	.byte    %01111110
	.byte    %11000011
	.byte    %10111101
	.byte    %11111111
	.byte    %11011011
	.byte    %01111110
	.byte    %00111100
 if ECHOFIRST
       echo "    ",[(scoretable - *)]d , "bytes of ROM space left")
 endif 
ECHOFIRST = 1
 
 
 
