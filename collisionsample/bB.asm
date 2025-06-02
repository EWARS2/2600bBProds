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

.
 ; 

.
 ; 

.
 ; 

.L00 ;  dim _BitOp_01  =  y

.L01 ;  dim _Bit0_Reset_Restrainer  =  y

.L02 ;  dim _Bit4_Toggle_Screen  =  y

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L03 ;  dim rand16  =  z

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

.L04 ;  const _P_Edge_Top  =  9

.L05 ;  const _P_Edge_Bottom  =  88

.L06 ;  const _P_Edge_Left  =  1

.L07 ;  const _P_Edge_Right  =  153

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

.L08 ;  const noscore  =  1

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

.L09 ;  AUDV0  =  0  :  AUDV1  =  0

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

.
 ; 

.
 ; 

.
 ; 

.L010 ;  a  =  0  :  b  =  0  :  c  =  0  :  d  =  0  :  e  =  0  :  f  =  0  :  g  =  0  :  h  =  0  :  i  =  0

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
.L011 ;  j  =  0  :  k  =  0  :  l  =  0  :  m  =  0  :  n  =  0  :  o  =  0  :  p  =  0  :  q  =  0  :  r  =  0

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
.L012 ;  s  =  0  :  t  =  0  :  u  =  0  :  v  =  0  :  w  =  0  :  x  =  0

	LDA #0
	STA s
	STA t
	STA u
	STA v
	STA w
	STA x
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

.L013 ;  _BitOp_01  =  _BitOp_01  &  %00010000

	LDA _BitOp_01
	AND #%00010000
	STA _BitOp_01
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

.L014 ;  player0x  =  77  :  player0y  =  48

	LDA #77
	STA player0x
	LDA #48
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

.L015 ;  COLUPF  =  $2C

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

.L016 ;  COLUBK  =  0

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

.L017 ;  _Bit0_Reset_Restrainer{0}  =  1

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

.L018 ;  player0:

	LDX #<playerL018_0
	STX player0pointerlo
	LDA #>playerL018_0
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

.L019 ;  _Bit4_Toggle_Screen  =  _Bit4_Toggle_Screen  ^  %00010000

	LDA _Bit4_Toggle_Screen
	EOR #%00010000
	STA _Bit4_Toggle_Screen
.
 ; 

.L020 ;  if _Bit4_Toggle_Screen{4} then goto __Skip_Playfield_01

	LDA _Bit4_Toggle_Screen
	AND #16
	BEQ .skipL020
.condpart0
 jmp .__Skip_Playfield_01

.skipL020
.
 ; 

.L021 ;  playfield:

  ifconst pfres
	  ldx #(12>pfres)*(pfres*pfwidth-1)+(12<=pfres)*47
  else
	  ldx #((12*pfwidth-1)*((12*pfwidth-1)<47))+(47*((12*pfwidth-1)>=47))
  endif
	jmp pflabel0
PF_data0
	.byte %11111111, %11111111
	if (pfwidth>2)
	.byte %11111111, %11111111
 endif
	.byte %10000000, %10000000
	if (pfwidth>2)
	.byte %10000000, %10000000
 endif
	.byte %10011100, %10011111
	if (pfwidth>2)
	.byte %10011111, %10011100
 endif
	.byte %10000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %10000000
 endif
	.byte %10011100, %01111111
	if (pfwidth>2)
	.byte %01111111, %10011100
 endif
	.byte %10000100, %00000000
	if (pfwidth>2)
	.byte %00000000, %10000100
 endif
	.byte %11100100, %11111001
	if (pfwidth>2)
	.byte %11111001, %11100100
 endif
	.byte %10000000, %10000001
	if (pfwidth>2)
	.byte %10000001, %10000000
 endif
	.byte %10011111, %10011111
	if (pfwidth>2)
	.byte %10011111, %10011111
 endif
	.byte %10000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %10000000
 endif
	.byte %11111111, %11111111
	if (pfwidth>2)
	.byte %11111111, %11111111
 endif
	.byte %11111111, %11111111
	if (pfwidth>2)
	.byte %11111111, %11111111
 endif
pflabel0
	lda PF_data0,x
	sta playfield,x
	dex
	bpl pflabel0
.
 ; 

.L022 ;  goto __Skip_Playfield_02

 jmp .__Skip_Playfield_02

.
 ; 

.
 ; 

.__Skip_Playfield_01
 ; __Skip_Playfield_01

.
 ; 

.
 ; 

.L023 ;  playfield:

  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel1
PF_data1
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
	.byte %00001111, %01110000
	if (pfwidth>2)
	.byte %01110000, %00001111
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
pflabel1
	lda PF_data1,x
	sta playfield,x
	dex
	bpl pflabel1
.
 ; 

.__Skip_Playfield_02
 ; __Skip_Playfield_02

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

.L024 ;  COLUP0  =  $9C

	LDA #$9C
	STA COLUP0
.
 ; 

.L025 ;  if joy0fire then pfscroll up

 bit INPT4
	BMI .skipL025
.condpart1
	LDA #2
 jsr pfscroll
.skipL025
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

.L026 ;  if !joy0up then goto __Skip_Joy0_Up

 lda #$10
 bit SWCHA
	BEQ .skipL026
.condpart2
 jmp .__Skip_Joy0_Up

.skipL026
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L027 ;  if player0y  <=  _P_Edge_Top then goto __Skip_Joy0_Up

	LDA #_P_Edge_Top
	CMP player0y
     BCC .skipL027
.condpart3
 jmp .__Skip_Joy0_Up

.skipL027
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L028 ;  temp5  =   ( player0x - 10 )  / 4

; complex statement detected
	LDA player0x
	SEC
	SBC #10
	lsr
	lsr
	STA temp5
.
 ; 

.L029 ;  temp6  =   ( player0y - 9 )  / 8

; complex statement detected
	LDA player0y
	SEC
	SBC #9
	lsr
	lsr
	lsr
	STA temp6
.
 ; 

.L030 ;  if temp5  <  34 then if pfread ( temp5 , temp6 )  then goto __Skip_Joy0_Up

	LDA temp5
	CMP #34
     BCS .skipL030
.condpart4
	LDA temp5
	LDY temp6
 jsr pfread
	BNE .skip4then
.condpart5
 jmp .__Skip_Joy0_Up

.skip4then
.skipL030
.
 ; 

.L031 ;  temp4  =   ( player0x - 17 )  / 4

; complex statement detected
	LDA player0x
	SEC
	SBC #17
	lsr
	lsr
	STA temp4
.
 ; 

.L032 ;  if temp4  <  34 then if pfread ( temp4 , temp6 )  then goto __Skip_Joy0_Up

	LDA temp4
	CMP #34
     BCS .skipL032
.condpart6
	LDA temp4
	LDY temp6
 jsr pfread
	BNE .skip6then
.condpart7
 jmp .__Skip_Joy0_Up

.skip6then
.skipL032
.
 ; 

.L033 ;  temp3  =  temp5  -  1

	LDA temp5
	SEC
	SBC #1
	STA temp3
.
 ; 

.L034 ;  if temp3  <  34 then if pfread ( temp3 , temp6 )  then goto __Skip_Joy0_Up

	LDA temp3
	CMP #34
     BCS .skipL034
.condpart8
	LDA temp3
	LDY temp6
 jsr pfread
	BNE .skip8then
.condpart9
 jmp .__Skip_Joy0_Up

.skip8then
.skipL034
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L035 ;  player0y  =  player0y  -  1

	DEC player0y
.
 ; 

.__Skip_Joy0_Up
 ; __Skip_Joy0_Up

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

.L036 ;  if !joy0down then goto __Skip_Joy0_Down

 lda #$20
 bit SWCHA
	BEQ .skipL036
.condpart10
 jmp .__Skip_Joy0_Down

.skipL036
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L037 ;  if player0y  >=  _P_Edge_Bottom then goto __Skip_Joy0_Down

	LDA player0y
	CMP #_P_Edge_Bottom
     BCC .skipL037
.condpart11
 jmp .__Skip_Joy0_Down

.skipL037
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L038 ;  temp5  =   ( player0x - 10 )  / 4

; complex statement detected
	LDA player0x
	SEC
	SBC #10
	lsr
	lsr
	STA temp5
.
 ; 

.L039 ;  temp6  =   ( player0y )  / 8

; complex statement detected
	LDA player0y
	lsr
	lsr
	lsr
	STA temp6
.
 ; 

.L040 ;  if temp5  <  34 then if pfread ( temp5 , temp6 )  then goto __Skip_Joy0_Down

	LDA temp5
	CMP #34
     BCS .skipL040
.condpart12
	LDA temp5
	LDY temp6
 jsr pfread
	BNE .skip12then
.condpart13
 jmp .__Skip_Joy0_Down

.skip12then
.skipL040
.
 ; 

.L041 ;  temp4  =   ( player0x - 17 )  / 4

; complex statement detected
	LDA player0x
	SEC
	SBC #17
	lsr
	lsr
	STA temp4
.
 ; 

.L042 ;  if temp4  <  34 then if pfread ( temp4 , temp6 )  then goto __Skip_Joy0_Down

	LDA temp4
	CMP #34
     BCS .skipL042
.condpart14
	LDA temp4
	LDY temp6
 jsr pfread
	BNE .skip14then
.condpart15
 jmp .__Skip_Joy0_Down

.skip14then
.skipL042
.
 ; 

.L043 ;  temp3  =  temp5  -  1

	LDA temp5
	SEC
	SBC #1
	STA temp3
.
 ; 

.L044 ;  if temp3  <  34 then if pfread ( temp3 , temp6 )  then goto __Skip_Joy0_Down

	LDA temp3
	CMP #34
     BCS .skipL044
.condpart16
	LDA temp3
	LDY temp6
 jsr pfread
	BNE .skip16then
.condpart17
 jmp .__Skip_Joy0_Down

.skip16then
.skipL044
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L045 ;  player0y  =  player0y  +  1

	INC player0y
.
 ; 

.__Skip_Joy0_Down
 ; __Skip_Joy0_Down

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

.L046 ;  if !joy0left then goto __Skip_Joy0_Left

 bit SWCHA
	BVC .skipL046
.condpart18
 jmp .__Skip_Joy0_Left

.skipL046
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L047 ;  if player0x  <=  _P_Edge_Left then goto __Skip_Joy0_Left

	LDA #_P_Edge_Left
	CMP player0x
     BCC .skipL047
.condpart19
 jmp .__Skip_Joy0_Left

.skipL047
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L048 ;  temp5  =   ( player0y - 1 )  / 8

; complex statement detected
	LDA player0y
	SEC
	SBC #1
	lsr
	lsr
	lsr
	STA temp5
.
 ; 

.L049 ;  temp6  =   ( player0x - 18 )  / 4

; complex statement detected
	LDA player0x
	SEC
	SBC #18
	lsr
	lsr
	STA temp6
.
 ; 

.L050 ;  if temp6  <  34 then if pfread ( temp6 , temp5 )  then goto __Skip_Joy0_Left

	LDA temp6
	CMP #34
     BCS .skipL050
.condpart20
	LDA temp6
	LDY temp5
 jsr pfread
	BNE .skip20then
.condpart21
 jmp .__Skip_Joy0_Left

.skip20then
.skipL050
.
 ; 

.L051 ;  temp3  =   ( player0y - 8 )  / 8

; complex statement detected
	LDA player0y
	SEC
	SBC #8
	lsr
	lsr
	lsr
	STA temp3
.
 ; 

.L052 ;  if temp6  <  34 then if pfread ( temp6 , temp3 )  then goto __Skip_Joy0_Left

	LDA temp6
	CMP #34
     BCS .skipL052
.condpart22
	LDA temp6
	LDY temp3
 jsr pfread
	BNE .skip22then
.condpart23
 jmp .__Skip_Joy0_Left

.skip22then
.skipL052
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L053 ;  player0x  =  player0x  -  1

	DEC player0x
.
 ; 

.__Skip_Joy0_Left
 ; __Skip_Joy0_Left

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

.L054 ;  if !joy0right then goto __Skip_Joy0_Right

 bit SWCHA
	BPL .skipL054
.condpart24
 jmp .__Skip_Joy0_Right

.skipL054
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L055 ;  if player0x  >=  _P_Edge_Right then goto __Skip_Joy0_Right

	LDA player0x
	CMP #_P_Edge_Right
     BCC .skipL055
.condpart25
 jmp .__Skip_Joy0_Right

.skipL055
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L056 ;  temp5  =   ( player0y - 1 )  / 8

; complex statement detected
	LDA player0y
	SEC
	SBC #1
	lsr
	lsr
	lsr
	STA temp5
.
 ; 

.L057 ;  temp6  =   ( player0x - 9 )  / 4

; complex statement detected
	LDA player0x
	SEC
	SBC #9
	lsr
	lsr
	STA temp6
.
 ; 

.L058 ;  if temp6  <  34 then if pfread ( temp6 , temp5 )  then goto __Skip_Joy0_Right

	LDA temp6
	CMP #34
     BCS .skipL058
.condpart26
	LDA temp6
	LDY temp5
 jsr pfread
	BNE .skip26then
.condpart27
 jmp .__Skip_Joy0_Right

.skip26then
.skipL058
.
 ; 

.L059 ;  temp3  =   ( player0y - 8 )  / 8

; complex statement detected
	LDA player0y
	SEC
	SBC #8
	lsr
	lsr
	lsr
	STA temp3
.
 ; 

.L060 ;  if temp6  <  34 then if pfread ( temp6 , temp3 )  then goto __Skip_Joy0_Right

	LDA temp6
	CMP #34
     BCS .skipL060
.condpart28
	LDA temp6
	LDY temp3
 jsr pfread
	BNE .skip28then
.condpart29
 jmp .__Skip_Joy0_Right

.skip28then
.skipL060
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L061 ;  player0x  =  player0x  +  1

	INC player0x
.
 ; 

.__Skip_Joy0_Right
 ; __Skip_Joy0_Right

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

.L062 ;  drawscreen

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

.L063 ;  if !switchreset then _Bit0_Reset_Restrainer{0}  =  0  :  goto __Main_Loop

 lda #1
 bit SWCHB
	BEQ .skipL063
.condpart30
	LDA _Bit0_Reset_Restrainer
	AND #254
	STA _Bit0_Reset_Restrainer
 jmp .__Main_Loop

.skipL063
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

.L064 ;  if _Bit0_Reset_Restrainer{0} then goto __Main_Loop

	LDA _Bit0_Reset_Restrainer
	LSR
	BCC .skipL064
.condpart31
 jmp .__Main_Loop

.skipL064
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L065 ;  goto __Start_Restart
 jmp .__Start_Restart
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL018_0
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
 
 
 
