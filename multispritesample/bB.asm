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

.L00 ;  includesfile multisprite_bankswitch.inc

.L01 ;  set kernel multisprite

.L02 ;  set romsize 16k

.
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

.L03 ;  dim _Current_Object  =  a

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L04 ;  dim _Sprite_Size0  =  b

.L05 ;  dim _Sprite_Size1  =  c

.L06 ;  dim _Sprite_Size2  =  d

.L07 ;  dim _Sprite_Size3  =  e

.L08 ;  dim _Sprite_Size4  =  f

.L09 ;  dim _Sprite_Size5  =  g

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L010 ;  dim _Missile0_Width  =  l

.L011 ;  dim _Missile1_Width  =  m

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L012 ;  dim _Ball_Width  =  n

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L013 ;  dim _Jiggle_Counter  =  o

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L014 ;  dim _P0_NUSIZ  =  p

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L015 ;  dim _Bit0_Reset_Restrainer  =  t

.L016 ;  dim _Bit1_Joy0_Restrainer  =  t

.L017 ;  dim _Bit2_Activate_Jiggle  =  t

.L018 ;  dim _Bit3_Flip_p0  =  t

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L019 ;  dim _Memx  =  x

.L020 ;  dim _Memy  =  y

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L021 ;  dim rand16  =  z

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L022 ;  dim _sc1  =  score

.L023 ;  dim _sc2  =  score + 1

.L024 ;  dim _sc3  =  score + 2

.
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

.L025 ;  const _Sprite0  =  0

.L026 ;  const _Sprite1  =  1

.L027 ;  const _Sprite2  =  2

.L028 ;  const _Sprite3  =  3

.L029 ;  const _Sprite4  =  4

.L030 ;  const _Sprite5  =  5

.L031 ;  const _Missile0  =  6

.L032 ;  const _Missile1  =  7

.L033 ;  const _Ball  =  8

.
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

.L034 ;  drawscreen

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
.
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

.L035 ;  player0:

	LDX #<playerL035_0
	STX player0pointerlo
	LDA #>playerL035_0
	STA player0pointerhi
	LDA #9
	STA player0height
.
 ; 

.
 ; 

.L036 ;    player1:

	LDX #<playerL036_1
	STX player1pointerlo
	LDA #>playerL036_1
	STA player1pointerhi
	LDA #8
	STA player1height
.
 ; 

.
 ; 

.L037 ;  player2:

	LDX #<playerL037_2
	STX player2pointerlo
	LDA #>playerL037_2
	STA player2pointerhi
	LDA #8
	STA player2height
.
 ; 

.
 ; 

.L038 ;  player3:

	LDX #<playerL038_3
	STX player3pointerlo
	LDA #>playerL038_3
	STA player3pointerhi
	LDA #8
	STA player3height
.
 ; 

.
 ; 

.L039 ;  player4:

	LDX #<playerL039_4
	STX player4pointerlo
	LDA #>playerL039_4
	STA player4pointerhi
	LDA #8
	STA player4height
.
 ; 

.
 ; 

.L040 ;  player5:

	LDX #<playerL040_5
	STX player5pointerlo
	LDA #>playerL040_5
	STA player5pointerhi
	LDA #8
	STA player5height
.
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

.L041 ;  player0x  =  77  :  player0y  =  88

	LDA #77
	STA player0x
	LDA #88
	STA player0y
.L042 ;  player1x  =  85  :  player1y  =  player0y  -  18

	LDA #85
	STA player1x
	LDA player0y
	SEC
	SBC #18
	STA player1y
.L043 ;  player2x  =  85  :  player2y  =  player1y  -  15

	LDA #85
	STA player2x
	LDA player1y
	SEC
	SBC #15
	STA player2y
.L044 ;  player3x  =  85  :  player3y  =  player2y  -  15

	LDA #85
	STA player3x
	LDA player2y
	SEC
	SBC #15
	STA player3y
.L045 ;  player4x  =  85  :  player4y  =  player3y  -  15

	LDA #85
	STA player4x
	LDA player3y
	SEC
	SBC #15
	STA player4y
.L046 ;  player5x  =  85  :  player5y  =  player4y  -  15

	LDA #85
	STA player5x
	LDA player4y
	SEC
	SBC #15
	STA player5y
.L047 ;  missile0x  =  98  :  missile0y  =  78

	LDA #98
	STA missile0x
	LDA #78
	STA missile0y
.L048 ;  missile1x  =  98  :  missile1y  =  missile0y  -  15

	LDA #98
	STA missile1x
	LDA missile0y
	SEC
	SBC #15
	STA missile1y
.L049 ;  ballx  =  98  :  bally  =  missile1y  -  15

	LDA #98
	STA ballx
	LDA missile1y
	SEC
	SBC #15
	STA bally
.
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

.L050 ;  _NUSIZ1{3}  =  0  :  NUSIZ2{3}  =  0  :  NUSIZ3{3}  =  0

	LDA _NUSIZ1
	AND #247
	STA _NUSIZ1
	LDA NUSIZ2
	AND #247
	STA NUSIZ2
	LDA NUSIZ3
	AND #247
	STA NUSIZ3
.L051 ;  NUSIZ4{3}  =  0  :  NUSIZ5{3}  =  0

	LDA NUSIZ4
	AND #247
	STA NUSIZ4
	LDA NUSIZ5
	AND #247
	STA NUSIZ5
.
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

.L052 ;  AUDV0  =  0  :  AUDV1  =  0

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

.L053 ;  a  =  0  :  b  =  0  :  c  =  0  :  d  =  0  :  e  =  0  :  f  =  0  :  g  =  0  :  h  =  0  :  i  =  0

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
.L054 ;  j  =  0  :  k  =  0  :  l  =  0  :  m  =  0  :  n  =  0  :  o  =  0  :  p  =  0  :  q  =  0  :  r  =  0

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
.L055 ;  s  =  0  :  t  =  0  :  u  =  0  :  v  =  0  :  w  =  0  :  x  =  0  :  y  =  0

	LDA #0
	STA s
	STA t
	STA u
	STA v
	STA w
	STA x
	STA y
.
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

.L056 ;  _Bit0_Reset_Restrainer{0}  =  1

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

.L057 ;  _Missile0_Width  =  0  :  _Missile1_Width  =  0  :  _Ball_Width  =  0

	LDA #0
	STA _Missile0_Width
	STA _Missile1_Width
	STA _Ball_Width
.
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

.L058 ;  COLUP0  =  $08  :  COLUP1  =  $BA  :  _COLUP1  =  $1A  :  COLUP2  =  $3A  :  COLUP3  =  $6A

	LDA #$08
	STA COLUP0
	LDA #$BA
	STA COLUP1
	LDA #$1A
	STA _COLUP1
	LDA #$3A
	STA COLUP2
	LDA #$6A
	STA COLUP3
.
 ; 

.L059 ;  COLUP4  =  $8A  :  COLUP5  =  $CA  :  COLUBK =  0  :  COLUPF  =  $4A

	LDA #$8A
	STA COLUP4
	LDA #$CA
	STA COLUP5
	LDA #0
	STA COLUBK
	LDA #$4A
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

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L060 ;  if !joy0fire then _Bit1_Joy0_Restrainer{1}  =  0  :  goto __Skip_Fire_Button

 bit INPT4
	BPL .skipL060
.condpart0
	LDA _Bit1_Joy0_Restrainer
	AND #253
	STA _Bit1_Joy0_Restrainer
 jmp .__Skip_Fire_Button

.skipL060
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L061 ;  if !joy0up  &&  !joy0down  &&  !joy0left  &&  !joy0right then _Bit1_Joy0_Restrainer{1}  =  0

 lda #$10
 bit SWCHA
	BEQ .skipL061
.condpart1
 lda #$20
 bit SWCHA
	BEQ .skip1then
.condpart2
 bit SWCHA
	BVC .skip2then
.condpart3
 bit SWCHA
	BPL .skip3then
.condpart4
	LDA _Bit1_Joy0_Restrainer
	AND #253
	STA _Bit1_Joy0_Restrainer
.skip3then
.skip2then
.skip1then
.skipL061
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L062 ;  if _Bit1_Joy0_Restrainer{1} then goto __Skip_Movement

	LDA _Bit1_Joy0_Restrainer
	AND #2
	BEQ .skipL062
.condpart5
 jmp .__Skip_Movement

.skipL062
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L063 ;  if joy0up then _Bit1_Joy0_Restrainer{1}  =  1  :  _Bit2_Activate_Jiggle{2}  =  1  :  _Jiggle_Counter  =  0  :  _Current_Object  =  _Current_Object  -  1  :  if _Current_Object  >=  250 then _Current_Object  =  8

 lda #$10
 bit SWCHA
	BNE .skipL063
.condpart6
	LDA _Bit1_Joy0_Restrainer
	ORA #2
	STA _Bit1_Joy0_Restrainer
	LDA _Bit2_Activate_Jiggle
	ORA #4
	STA _Bit2_Activate_Jiggle
	LDA #0
	STA _Jiggle_Counter
	DEC _Current_Object
	LDA _Current_Object
	CMP #250
     BCC .skip6then
.condpart7
	LDA #8
	STA _Current_Object
.skip6then
.skipL063
.
 ; 

.L064 ;  if joy0down then _Bit1_Joy0_Restrainer{1}  =  1  :  _Bit2_Activate_Jiggle{2}  =  1  :  _Jiggle_Counter  =  0  :  _Current_Object  =  _Current_Object  +  1  :  if _Current_Object  >=  9 then _Current_Object  =  0

 lda #$20
 bit SWCHA
	BNE .skipL064
.condpart8
	LDA _Bit1_Joy0_Restrainer
	ORA #2
	STA _Bit1_Joy0_Restrainer
	LDA _Bit2_Activate_Jiggle
	ORA #4
	STA _Bit2_Activate_Jiggle
	LDA #0
	STA _Jiggle_Counter
	INC _Current_Object
	LDA _Current_Object
	CMP #9
     BCC .skip8then
.condpart9
	LDA #0
	STA _Current_Object
.skip8then
.skipL064
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L065 ;  if !joy0left then goto __Skip_Size_Decrease

 bit SWCHA
	BVC .skipL065
.condpart10
 jmp .__Skip_Size_Decrease

.skipL065
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L066 ;  _Bit1_Joy0_Restrainer{1}  =  1

	LDA _Bit1_Joy0_Restrainer
	ORA #2
	STA _Bit1_Joy0_Restrainer
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L067 ;  if _Current_Object  =  _Sprite0 then _Sprite_Size0  =  _Sprite_Size0  -  1  :  if _Sprite_Size0  >=  250 then _Sprite_Size0  =  2

	LDA _Current_Object
	CMP #_Sprite0
     BNE .skipL067
.condpart11
	DEC _Sprite_Size0
	LDA _Sprite_Size0
	CMP #250
     BCC .skip11then
.condpart12
	LDA #2
	STA _Sprite_Size0
.skip11then
.skipL067
.L068 ;  if _Current_Object  =  _Sprite1 then _Sprite_Size1  =  _Sprite_Size1  -  1  :  if _Sprite_Size1  >=  250 then _Sprite_Size1  =  2

	LDA _Current_Object
	CMP #_Sprite1
     BNE .skipL068
.condpart13
	DEC _Sprite_Size1
	LDA _Sprite_Size1
	CMP #250
     BCC .skip13then
.condpart14
	LDA #2
	STA _Sprite_Size1
.skip13then
.skipL068
.L069 ;  if _Current_Object  =  _Sprite2 then _Sprite_Size2  =  _Sprite_Size2  -  1  :  if _Sprite_Size2  >=  250 then _Sprite_Size2  =  2

	LDA _Current_Object
	CMP #_Sprite2
     BNE .skipL069
.condpart15
	DEC _Sprite_Size2
	LDA _Sprite_Size2
	CMP #250
     BCC .skip15then
.condpart16
	LDA #2
	STA _Sprite_Size2
.skip15then
.skipL069
.L070 ;  if _Current_Object  =  _Sprite3 then _Sprite_Size3  =  _Sprite_Size3  -  1  :  if _Sprite_Size3  >=  250 then _Sprite_Size3  =  2

	LDA _Current_Object
	CMP #_Sprite3
     BNE .skipL070
.condpart17
	DEC _Sprite_Size3
	LDA _Sprite_Size3
	CMP #250
     BCC .skip17then
.condpart18
	LDA #2
	STA _Sprite_Size3
.skip17then
.skipL070
.L071 ;  if _Current_Object  =  _Sprite4 then _Sprite_Size4  =  _Sprite_Size4  -  1  :  if _Sprite_Size4  >=  250 then _Sprite_Size4  =  2

	LDA _Current_Object
	CMP #_Sprite4
     BNE .skipL071
.condpart19
	DEC _Sprite_Size4
	LDA _Sprite_Size4
	CMP #250
     BCC .skip19then
.condpart20
	LDA #2
	STA _Sprite_Size4
.skip19then
.skipL071
.L072 ;  if _Current_Object  =  _Sprite5 then _Sprite_Size5  =  _Sprite_Size5  -  1  :  if _Sprite_Size5  >=  250 then _Sprite_Size5  =  2

	LDA _Current_Object
	CMP #_Sprite5
     BNE .skipL072
.condpart21
	DEC _Sprite_Size5
	LDA _Sprite_Size5
	CMP #250
     BCC .skip21then
.condpart22
	LDA #2
	STA _Sprite_Size5
.skip21then
.skipL072
.L073 ;  if _Current_Object  =  _Missile0 then _Missile0_Width  =  _Missile0_Width  -  1  :  if _Missile0_Width  =  255 then _Missile0_Width  =  3

	LDA _Current_Object
	CMP #_Missile0
     BNE .skipL073
.condpart23
	DEC _Missile0_Width
	LDA _Missile0_Width
	CMP #255
     BNE .skip23then
.condpart24
	LDA #3
	STA _Missile0_Width
.skip23then
.skipL073
.L074 ;  if _Current_Object  =  _Missile1 then _Missile1_Width  =  _Missile1_Width  -  1  :  if _Missile1_Width  =  255 then _Missile1_Width  =  3

	LDA _Current_Object
	CMP #_Missile1
     BNE .skipL074
.condpart25
	DEC _Missile1_Width
	LDA _Missile1_Width
	CMP #255
     BNE .skip25then
.condpart26
	LDA #3
	STA _Missile1_Width
.skip25then
.skipL074
.L075 ;  if _Current_Object  =  _Ball then _Ball_Width  =  _Ball_Width  -  1  :  if _Ball_Width  =  255 then _Ball_Width  =  3

	LDA _Current_Object
	CMP #_Ball
     BNE .skipL075
.condpart27
	DEC _Ball_Width
	LDA _Ball_Width
	CMP #255
     BNE .skip27then
.condpart28
	LDA #3
	STA _Ball_Width
.skip27then
.skipL075
.
 ; 

.L076 ;  goto __Skip_Size_Increase

 jmp .__Skip_Size_Increase

.
 ; 

.__Skip_Size_Decrease
 ; __Skip_Size_Decrease

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L077 ;  if !joy0right then goto __Skip_Size_Increase

 bit SWCHA
	BPL .skipL077
.condpart29
 jmp .__Skip_Size_Increase

.skipL077
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L078 ;  _Bit1_Joy0_Restrainer{1}  =  1

	LDA _Bit1_Joy0_Restrainer
	ORA #2
	STA _Bit1_Joy0_Restrainer
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L079 ;  if _Current_Object  =  _Sprite0 then _Sprite_Size0  =  _Sprite_Size0  +  1  :  if _Sprite_Size0  >=  3 then _Sprite_Size0  =  0

	LDA _Current_Object
	CMP #_Sprite0
     BNE .skipL079
.condpart30
	INC _Sprite_Size0
	LDA _Sprite_Size0
	CMP #3
     BCC .skip30then
.condpart31
	LDA #0
	STA _Sprite_Size0
.skip30then
.skipL079
.L080 ;  if _Current_Object  =  _Sprite1 then _Sprite_Size1  =  _Sprite_Size1  +  1  :  if _Sprite_Size1  >=  3 then _Sprite_Size1  =  0

	LDA _Current_Object
	CMP #_Sprite1
     BNE .skipL080
.condpart32
	INC _Sprite_Size1
	LDA _Sprite_Size1
	CMP #3
     BCC .skip32then
.condpart33
	LDA #0
	STA _Sprite_Size1
.skip32then
.skipL080
.L081 ;  if _Current_Object  =  _Sprite2 then _Sprite_Size2  =  _Sprite_Size2  +  1  :  if _Sprite_Size2  >=  3 then _Sprite_Size2  =  0

	LDA _Current_Object
	CMP #_Sprite2
     BNE .skipL081
.condpart34
	INC _Sprite_Size2
	LDA _Sprite_Size2
	CMP #3
     BCC .skip34then
.condpart35
	LDA #0
	STA _Sprite_Size2
.skip34then
.skipL081
.L082 ;  if _Current_Object  =  _Sprite3 then _Sprite_Size3  =  _Sprite_Size3  +  1  :  if _Sprite_Size3  >=  3 then _Sprite_Size3  =  0

	LDA _Current_Object
	CMP #_Sprite3
     BNE .skipL082
.condpart36
	INC _Sprite_Size3
	LDA _Sprite_Size3
	CMP #3
     BCC .skip36then
.condpart37
	LDA #0
	STA _Sprite_Size3
.skip36then
.skipL082
.L083 ;  if _Current_Object  =  _Sprite4 then _Sprite_Size4  =  _Sprite_Size4  +  1  :  if _Sprite_Size4  >=  3 then _Sprite_Size4  =  0

	LDA _Current_Object
	CMP #_Sprite4
     BNE .skipL083
.condpart38
	INC _Sprite_Size4
	LDA _Sprite_Size4
	CMP #3
     BCC .skip38then
.condpart39
	LDA #0
	STA _Sprite_Size4
.skip38then
.skipL083
.L084 ;  if _Current_Object  =  _Sprite5 then _Sprite_Size5  =  _Sprite_Size5  +  1  :  if _Sprite_Size5  >=  3 then _Sprite_Size5  =  0

	LDA _Current_Object
	CMP #_Sprite5
     BNE .skipL084
.condpart40
	INC _Sprite_Size5
	LDA _Sprite_Size5
	CMP #3
     BCC .skip40then
.condpart41
	LDA #0
	STA _Sprite_Size5
.skip40then
.skipL084
.L085 ;  if _Current_Object  =  _Missile0 then _Missile0_Width  =  _Missile0_Width  +  1  :  if _Missile0_Width  >=  4 then _Missile0_Width  =  0

	LDA _Current_Object
	CMP #_Missile0
     BNE .skipL085
.condpart42
	INC _Missile0_Width
	LDA _Missile0_Width
	CMP #4
     BCC .skip42then
.condpart43
	LDA #0
	STA _Missile0_Width
.skip42then
.skipL085
.L086 ;  if _Current_Object  =  _Missile1 then _Missile1_Width  =  _Missile1_Width  +  1  :  if _Missile1_Width  >=  4 then _Missile1_Width  =  0

	LDA _Current_Object
	CMP #_Missile1
     BNE .skipL086
.condpart44
	INC _Missile1_Width
	LDA _Missile1_Width
	CMP #4
     BCC .skip44then
.condpart45
	LDA #0
	STA _Missile1_Width
.skip44then
.skipL086
.L087 ;  if _Current_Object  =  _Ball then _Ball_Width  =  _Ball_Width  +  1  :  if _Ball_Width  >=  4 then _Ball_Width  =  0

	LDA _Current_Object
	CMP #_Ball
     BNE .skipL087
.condpart46
	INC _Ball_Width
	LDA _Ball_Width
	CMP #4
     BCC .skip46then
.condpart47
	LDA #0
	STA _Ball_Width
.skip46then
.skipL087
.
 ; 

.__Skip_Size_Increase
 ; __Skip_Size_Increase

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L088 ;  goto __Skip_Movement

 jmp .__Skip_Movement

.
 ; 

.__Skip_Fire_Button
 ; __Skip_Fire_Button

.
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

.L089 ;  if _Current_Object  >  _Sprite0 then goto __Skip_Sprite0_Movement

	LDA #_Sprite0
	CMP _Current_Object
     BCS .skipL089
.condpart48
 jmp .__Skip_Sprite0_Movement

.skipL089
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L090 ;  if joy0up then if player0y  <=  89 then player0y  =  player0y  +  1

 lda #$10
 bit SWCHA
	BNE .skipL090
.condpart49
	LDA #89
	CMP player0y
     BCC .skip49then
.condpart50
	INC player0y
.skip49then
.skipL090
.
 ; 

.L091 ;  if joy0down then if player0y  >=  2  +  player0height then player0y  =  player0y  -  1

 lda #$20
 bit SWCHA
	BNE .skipL091
.condpart51
; complex condition detected
	LDA #2
	CLC
	ADC player0height
  PHA
  TSX
  PLA
	LDA player0y
	CMP  1,x
     BCC .skip51then
.condpart52
	DEC player0y
.skip51then
.skipL091
.
 ; 

.L092 ;  if joy0left then if player0x  >=  1 then player0x  =  player0x  -  1  :  _Bit3_Flip_p0{3}  =  0

 bit SWCHA
	BVS .skipL092
.condpart53
	LDA player0x
	CMP #1
     BCC .skip53then
.condpart54
	DEC player0x
	LDA _Bit3_Flip_p0
	AND #247
	STA _Bit3_Flip_p0
.skip53then
.skipL092
.
 ; 

.L093 ;  if joy0right then temp5  =  _Data_Sprite0_Width[_Sprite_Size0]  :  if player0x  <=  temp5 then player0x  =  player0x  +  1  :  _Bit3_Flip_p0{3}  =  1

 bit SWCHA
	BMI .skipL093
.condpart55
	LDX _Sprite_Size0
	LDA _Data_Sprite0_Width,x
	STA temp5
	LDA temp5
	CMP player0x
     BCC .skip55then
.condpart56
	INC player0x
	LDA _Bit3_Flip_p0
	ORA #8
	STA _Bit3_Flip_p0
.skip55then
.skipL093
.
 ; 

.L094 ;  goto __Skip_Movement

 jmp .__Skip_Movement

.
 ; 

.__Skip_Sprite0_Movement
 ; __Skip_Sprite0_Movement

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L095 ;  if _Current_Object  >  _Sprite1 then goto __Skip_Sprite1_Movement

	LDA #_Sprite1
	CMP _Current_Object
     BCS .skipL095
.condpart57
 jmp .__Skip_Sprite1_Movement

.skipL095
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L096 ;  if joy0up then if player1y  <=  83 then player1y  =  player1y  +  1

 lda #$10
 bit SWCHA
	BNE .skipL096
.condpart58
	LDA #83
	CMP player1y
     BCC .skip58then
.condpart59
	INC player1y
.skip58then
.skipL096
.
 ; 

.L097 ;  if joy0down then if player1y  >=  player1height then player1y  =  player1y  -  1

 lda #$20
 bit SWCHA
	BNE .skipL097
.condpart60
	LDA player1y
	CMP player1height
     BCC .skip60then
.condpart61
	DEC player1y
.skip60then
.skipL097
.
 ; 

.L098 ;  if joy0left then if player1x  >=  9 then player1x  =  player1x  -  1  :  _NUSIZ1{3}  =  0  :  _NUSIZ1{6}  =  0

 bit SWCHA
	BVS .skipL098
.condpart62
	LDA player1x
	CMP #9
     BCC .skip62then
.condpart63
	DEC player1x
	LDA _NUSIZ1
	AND #247
	STA _NUSIZ1
	LDA _NUSIZ1
	AND #191
	STA _NUSIZ1
.skip62then
.skipL098
.
 ; 

.L099 ;  if joy0right then temp5  =  _Data_1to5_Width[_Sprite_Size1]  :  if player1x  <=  temp5 then player1x  =  player1x  +  1  :  _NUSIZ1{3}  =  1  :  _NUSIZ1{6}  =  1

 bit SWCHA
	BMI .skipL099
.condpart64
	LDX _Sprite_Size1
	LDA _Data_1to5_Width,x
	STA temp5
	LDA temp5
	CMP player1x
     BCC .skip64then
.condpart65
	INC player1x
	LDA _NUSIZ1
	ORA #8
	STA _NUSIZ1
	LDA _NUSIZ1
	ORA #64
	STA _NUSIZ1
.skip64then
.skipL099
.
 ; 

.L0100 ;  goto __Skip_Movement

 jmp .__Skip_Movement

.
 ; 

.__Skip_Sprite1_Movement
 ; __Skip_Sprite1_Movement

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0101 ;  if _Current_Object  >  _Sprite2 then goto __Skip_Sprite2_Movement

	LDA #_Sprite2
	CMP _Current_Object
     BCS .skipL0101
.condpart66
 jmp .__Skip_Sprite2_Movement

.skipL0101
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0102 ;  if joy0up then if player2y  <=  83 then player2y  =  player2y  +  1

 lda #$10
 bit SWCHA
	BNE .skipL0102
.condpart67
	LDA #83
	CMP player2y
     BCC .skip67then
.condpart68
	INC player2y
.skip67then
.skipL0102
.
 ; 

.L0103 ;  if joy0down then if player2y  >=  player2height then player2y  =  player2y  -  1

 lda #$20
 bit SWCHA
	BNE .skipL0103
.condpart69
	LDA player2y
	CMP player2height
     BCC .skip69then
.condpart70
	DEC player2y
.skip69then
.skipL0103
.
 ; 

.L0104 ;  if joy0left then if player2x  >=  9 then player2x  =  player2x  -  1  :  NUSIZ2{3}  =  0  :  NUSIZ2{6}  =  0

 bit SWCHA
	BVS .skipL0104
.condpart71
	LDA player2x
	CMP #9
     BCC .skip71then
.condpart72
	DEC player2x
	LDA NUSIZ2
	AND #247
	STA NUSIZ2
	LDA NUSIZ2
	AND #191
	STA NUSIZ2
.skip71then
.skipL0104
.
 ; 

.L0105 ;  if joy0right then temp5  =  _Data_1to5_Width[_Sprite_Size2]  :  if player2x  <=  temp5 then player2x  =  player2x  +  1  :  NUSIZ2{3}  =  1  :  NUSIZ2{6}  =  1

 bit SWCHA
	BMI .skipL0105
.condpart73
	LDX _Sprite_Size2
	LDA _Data_1to5_Width,x
	STA temp5
	LDA temp5
	CMP player2x
     BCC .skip73then
.condpart74
	INC player2x
	LDA NUSIZ2
	ORA #8
	STA NUSIZ2
	LDA NUSIZ2
	ORA #64
	STA NUSIZ2
.skip73then
.skipL0105
.
 ; 

.L0106 ;  goto __Skip_Movement

 jmp .__Skip_Movement

.
 ; 

.__Skip_Sprite2_Movement
 ; __Skip_Sprite2_Movement

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0107 ;  if _Current_Object  >  _Sprite3 then goto __Skip_Sprite3_Movement

	LDA #_Sprite3
	CMP _Current_Object
     BCS .skipL0107
.condpart75
 jmp .__Skip_Sprite3_Movement

.skipL0107
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0108 ;  if joy0up then if player3y  <=  83 then player3y  =  player3y  +  1

 lda #$10
 bit SWCHA
	BNE .skipL0108
.condpart76
	LDA #83
	CMP player3y
     BCC .skip76then
.condpart77
	INC player3y
.skip76then
.skipL0108
.
 ; 

.L0109 ;  if joy0down then if player3y  >=  player3height then player3y  =  player3y  -  1

 lda #$20
 bit SWCHA
	BNE .skipL0109
.condpart78
	LDA player3y
	CMP player3height
     BCC .skip78then
.condpart79
	DEC player3y
.skip78then
.skipL0109
.
 ; 

.L0110 ;  if joy0left then if player3x  >=  9 then player3x  =  player3x  -  1  :  NUSIZ3{3}  =  0  :  NUSIZ3{6}  =  0

 bit SWCHA
	BVS .skipL0110
.condpart80
	LDA player3x
	CMP #9
     BCC .skip80then
.condpart81
	DEC player3x
	LDA NUSIZ3
	AND #247
	STA NUSIZ3
	LDA NUSIZ3
	AND #191
	STA NUSIZ3
.skip80then
.skipL0110
.
 ; 

.L0111 ;  if joy0right then temp5  =  _Data_1to5_Width[_Sprite_Size3]  :  if player3x  <=  temp5 then player3x  =  player3x  +  1  :  NUSIZ3{3}  =  1  :  NUSIZ3{6}  =  1

 bit SWCHA
	BMI .skipL0111
.condpart82
	LDX _Sprite_Size3
	LDA _Data_1to5_Width,x
	STA temp5
	LDA temp5
	CMP player3x
     BCC .skip82then
.condpart83
	INC player3x
	LDA NUSIZ3
	ORA #8
	STA NUSIZ3
	LDA NUSIZ3
	ORA #64
	STA NUSIZ3
.skip82then
.skipL0111
.
 ; 

.L0112 ;  goto __Skip_Movement

 jmp .__Skip_Movement

.
 ; 

.__Skip_Sprite3_Movement
 ; __Skip_Sprite3_Movement

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0113 ;  if _Current_Object  >  _Sprite4 then goto __Skip_Sprite4_Movement

	LDA #_Sprite4
	CMP _Current_Object
     BCS .skipL0113
.condpart84
 jmp .__Skip_Sprite4_Movement

.skipL0113
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0114 ;  if joy0up then if player4y  <=  83 then player4y  =  player4y  +  1

 lda #$10
 bit SWCHA
	BNE .skipL0114
.condpart85
	LDA #83
	CMP player4y
     BCC .skip85then
.condpart86
	INC player4y
.skip85then
.skipL0114
.
 ; 

.L0115 ;  if joy0down then if player4y  >=  player4height then player4y  =  player4y  -  1

 lda #$20
 bit SWCHA
	BNE .skipL0115
.condpart87
	LDA player4y
	CMP player4height
     BCC .skip87then
.condpart88
	DEC player4y
.skip87then
.skipL0115
.
 ; 

.L0116 ;  if joy0left then if player4x  >=  9 then player4x  =  player4x  -  1  :  NUSIZ4{3}  =  0  :  NUSIZ4{6}  =  0

 bit SWCHA
	BVS .skipL0116
.condpart89
	LDA player4x
	CMP #9
     BCC .skip89then
.condpart90
	DEC player4x
	LDA NUSIZ4
	AND #247
	STA NUSIZ4
	LDA NUSIZ4
	AND #191
	STA NUSIZ4
.skip89then
.skipL0116
.
 ; 

.L0117 ;  if joy0right then temp5  =  _Data_1to5_Width[_Sprite_Size4]  :  if player4x  <=  temp5 then player4x  =  player4x  +  1  :  NUSIZ4{3}  =  1  :  NUSIZ4{6}  =  1

 bit SWCHA
	BMI .skipL0117
.condpart91
	LDX _Sprite_Size4
	LDA _Data_1to5_Width,x
	STA temp5
	LDA temp5
	CMP player4x
     BCC .skip91then
.condpart92
	INC player4x
	LDA NUSIZ4
	ORA #8
	STA NUSIZ4
	LDA NUSIZ4
	ORA #64
	STA NUSIZ4
.skip91then
.skipL0117
.
 ; 

.L0118 ;  goto __Skip_Movement

 jmp .__Skip_Movement

.
 ; 

.__Skip_Sprite4_Movement
 ; __Skip_Sprite4_Movement

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0119 ;  if _Current_Object  >  _Sprite5 then goto __Skip_Sprite5_Movement

	LDA #_Sprite5
	CMP _Current_Object
     BCS .skipL0119
.condpart93
 jmp .__Skip_Sprite5_Movement

.skipL0119
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0120 ;  if joy0up then if player5y  <=  83 then player5y  =  player5y  +  1

 lda #$10
 bit SWCHA
	BNE .skipL0120
.condpart94
	LDA #83
	CMP player5y
     BCC .skip94then
.condpart95
	INC player5y
.skip94then
.skipL0120
.
 ; 

.L0121 ;  if joy0down then if player5y  >=  player5height then player5y  =  player5y  -  1

 lda #$20
 bit SWCHA
	BNE .skipL0121
.condpart96
	LDA player5y
	CMP player5height
     BCC .skip96then
.condpart97
	DEC player5y
.skip96then
.skipL0121
.
 ; 

.L0122 ;  if joy0left then if player5x  >=  9 then player5x  =  player5x  -  1  :  NUSIZ5{3}  =  0  :  NUSIZ5{6}  =  0

 bit SWCHA
	BVS .skipL0122
.condpart98
	LDA player5x
	CMP #9
     BCC .skip98then
.condpart99
	DEC player5x
	LDA NUSIZ5
	AND #247
	STA NUSIZ5
	LDA NUSIZ5
	AND #191
	STA NUSIZ5
.skip98then
.skipL0122
.
 ; 

.L0123 ;  if joy0right then temp5  =  _Data_1to5_Width[_Sprite_Size5]  :  if player5x  <=  temp5 then player5x  =  player5x  +  1  :  NUSIZ5{3}  =  1  :  NUSIZ5{6}  =  1

 bit SWCHA
	BMI .skipL0123
.condpart100
	LDX _Sprite_Size5
	LDA _Data_1to5_Width,x
	STA temp5
	LDA temp5
	CMP player5x
     BCC .skip100then
.condpart101
	INC player5x
	LDA NUSIZ5
	ORA #8
	STA NUSIZ5
	LDA NUSIZ5
	ORA #64
	STA NUSIZ5
.skip100then
.skipL0123
.
 ; 

.L0124 ;  goto __Skip_Movement

 jmp .__Skip_Movement

.
 ; 

.__Skip_Sprite5_Movement
 ; __Skip_Sprite5_Movement

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0125 ;  if _Current_Object  <>  _Missile0 then goto __Skip_Missile0_Movement

	LDA _Current_Object
	CMP #_Missile0
     BEQ .skipL0125
.condpart102
 jmp .__Skip_Missile0_Movement

.skipL0125
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0126 ;  if joy0up then if missile0y  <=  87 then missile0y  =  missile0y  +  1

 lda #$10
 bit SWCHA
	BNE .skipL0126
.condpart103
	LDA #87
	CMP missile0y
     BCC .skip103then
.condpart104
	INC missile0y
.skip103then
.skipL0126
.
 ; 

.L0127 ;  if joy0down then if missile0y  >=  3 then missile0y  =  missile0y  -  1

 lda #$20
 bit SWCHA
	BNE .skipL0127
.condpart105
	LDA missile0y
	CMP #3
     BCC .skip105then
.condpart106
	DEC missile0y
.skip105then
.skipL0127
.
 ; 

.L0128 ;  if joy0left then if missile0x  >=  2 then missile0x  =  missile0x  -  1

 bit SWCHA
	BVS .skipL0128
.condpart107
	LDA missile0x
	CMP #2
     BCC .skip107then
.condpart108
	DEC missile0x
.skip107then
.skipL0128
.
 ; 

.L0129 ;  if joy0right then temp5  =  _Data_M_B_x_Size[_Missile0_Width]  :  if missile0x  <=  temp5 then missile0x  =  missile0x  +  1

 bit SWCHA
	BMI .skipL0129
.condpart109
	LDX _Missile0_Width
	LDA _Data_M_B_x_Size,x
	STA temp5
	LDA temp5
	CMP missile0x
     BCC .skip109then
.condpart110
	INC missile0x
.skip109then
.skipL0129
.
 ; 

.L0130 ;  goto __Skip_Movement

 jmp .__Skip_Movement

.
 ; 

.__Skip_Missile0_Movement
 ; __Skip_Missile0_Movement

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0131 ;  if _Current_Object  <>  _Missile1 then goto __Skip_Missile1_Movement

	LDA _Current_Object
	CMP #_Missile1
     BEQ .skipL0131
.condpart111
 jmp .__Skip_Missile1_Movement

.skipL0131
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0132 ;  if joy0up then if missile1y  <=  87 then missile1y  =  missile1y  +  1

 lda #$10
 bit SWCHA
	BNE .skipL0132
.condpart112
	LDA #87
	CMP missile1y
     BCC .skip112then
.condpart113
	INC missile1y
.skip112then
.skipL0132
.
 ; 

.L0133 ;  if joy0down then if missile1y  >=  3 then missile1y  =  missile1y  -  1

 lda #$20
 bit SWCHA
	BNE .skipL0133
.condpart114
	LDA missile1y
	CMP #3
     BCC .skip114then
.condpart115
	DEC missile1y
.skip114then
.skipL0133
.
 ; 

.L0134 ;  if joy0left then if missile1x  >=  2 then missile1x  =  missile1x  -  1

 bit SWCHA
	BVS .skipL0134
.condpart116
	LDA missile1x
	CMP #2
     BCC .skip116then
.condpart117
	DEC missile1x
.skip116then
.skipL0134
.
 ; 

.L0135 ;  if joy0right then temp5  =  _Data_M_B_x_Size[_Missile1_Width]  :  if missile1x  <=  temp5 then missile1x  =  missile1x  +  1

 bit SWCHA
	BMI .skipL0135
.condpart118
	LDX _Missile1_Width
	LDA _Data_M_B_x_Size,x
	STA temp5
	LDA temp5
	CMP missile1x
     BCC .skip118then
.condpart119
	INC missile1x
.skip118then
.skipL0135
.
 ; 

.L0136 ;  goto __Skip_Movement

 jmp .__Skip_Movement

.
 ; 

.__Skip_Missile1_Movement
 ; __Skip_Missile1_Movement

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0137 ;  if _Current_Object  <>  _Ball then goto __Skip_Movement

	LDA _Current_Object
	CMP #_Ball
     BEQ .skipL0137
.condpart120
 jmp .__Skip_Movement

.skipL0137
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0138 ;  if joy0up then if bally  <=  87 then bally  =  bally  +  1

 lda #$10
 bit SWCHA
	BNE .skipL0138
.condpart121
	LDA #87
	CMP bally
     BCC .skip121then
.condpart122
	INC bally
.skip121then
.skipL0138
.
 ; 

.L0139 ;  if joy0down then if bally  >=  3 then bally  =  bally  -  1

 lda #$20
 bit SWCHA
	BNE .skipL0139
.condpart123
	LDA bally
	CMP #3
     BCC .skip123then
.condpart124
	DEC bally
.skip123then
.skipL0139
.
 ; 

.L0140 ;  if joy0left then if ballx  >=  2 then ballx  =  ballx  -  1

 bit SWCHA
	BVS .skipL0140
.condpart125
	LDA ballx
	CMP #2
     BCC .skip125then
.condpart126
	DEC ballx
.skip125then
.skipL0140
.
 ; 

.L0141 ;  if joy0right then temp5  =  _Data_M_B_x_Size[_Ball_Width] :  if ballx  <=  temp5 then ballx  =  ballx  +  1

 bit SWCHA
	BMI .skipL0141
.condpart127
	LDX _Ball_Width
	LDA _Data_M_B_x_Size,x
	STA temp5
	LDA temp5
	CMP ballx
     BCC .skip127then
.condpart128
	INC ballx
.skip127then
.skipL0141
.
 ; 

.__Skip_Movement
 ; __Skip_Movement

.
 ; 

.
 ; 

.
 ; 

.L0142 ;  goto __Bank_2 bank2

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

.
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

.L0143 ;  data _Data_M_B_x_Size

	JMP .skipL0143
_Data_M_B_x_Size
	.byte    158, 157, 155, 151

.skipL0143
.
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

.L0144 ;  data _Data_Sprite0_Width

	JMP .skipL0144
_Data_Sprite0_Width
	.byte    150, 141, 125

.skipL0144
.
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

.L0145 ;  data _Data_1to5_Width

	JMP .skipL0145
_Data_1to5_Width
	.byte    158, 150, 134

.skipL0145
.
 ; 

.
 ; 

.
 ; 

.L0146 ;  bank 2

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
.
 ; 

.
 ; 

.
 ; 

.__Bank_2
 ; __Bank_2

.
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

.L0147 ;  if _Bit3_Flip_p0{3} then REFP0  =  8

	LDA _Bit3_Flip_p0
	AND #8
	BEQ .skipL0147
.condpart129
	LDA #8
	STA REFP0
.skipL0147
.
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

.L0148 ;  _P0_NUSIZ  =  _P0_NUSIZ  &  %11111000

	LDA _P0_NUSIZ
	AND #%11111000
	STA _P0_NUSIZ
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0149 ;  _P0_NUSIZ  =  _P0_NUSIZ  |  _Data_Sprite_Size[_Sprite_Size0]

	LDA _P0_NUSIZ
	LDX _Sprite_Size0
	ORA _Data_Sprite_Size,x
	STA _P0_NUSIZ
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0150 ;  NUSIZ0  =  _P0_NUSIZ

	LDA _P0_NUSIZ
	STA NUSIZ0
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0151 ;  _NUSIZ1  =  _NUSIZ1  &  %11111000  :  _NUSIZ1  =  _NUSIZ1  |  _Data_Sprite_Size[_Sprite_Size1]

	LDA _NUSIZ1
	AND #%11111000
	STA _NUSIZ1
	LDA _NUSIZ1
	LDX _Sprite_Size1
	ORA _Data_Sprite_Size,x
	STA _NUSIZ1
.L0152 ;  NUSIZ2  =  NUSIZ2  &  %11111000  :  NUSIZ2  =  NUSIZ2  |  _Data_Sprite_Size[_Sprite_Size2]

	LDA NUSIZ2
	AND #%11111000
	STA NUSIZ2
	LDA NUSIZ2
	LDX _Sprite_Size2
	ORA _Data_Sprite_Size,x
	STA NUSIZ2
.L0153 ;  NUSIZ3  =  NUSIZ3  &  %11111000  :  NUSIZ3  =  NUSIZ3  |  _Data_Sprite_Size[_Sprite_Size3]

	LDA NUSIZ3
	AND #%11111000
	STA NUSIZ3
	LDA NUSIZ3
	LDX _Sprite_Size3
	ORA _Data_Sprite_Size,x
	STA NUSIZ3
.L0154 ;  NUSIZ4  =  NUSIZ4  &  %11111000  :  NUSIZ4  =  NUSIZ4  |  _Data_Sprite_Size[_Sprite_Size4]

	LDA NUSIZ4
	AND #%11111000
	STA NUSIZ4
	LDA NUSIZ4
	LDX _Sprite_Size4
	ORA _Data_Sprite_Size,x
	STA NUSIZ4
.L0155 ;  NUSIZ5  =  NUSIZ5  &  %11111000  :  NUSIZ5  =  NUSIZ5  |  _Data_Sprite_Size[_Sprite_Size5]

	LDA NUSIZ5
	AND #%11111000
	STA NUSIZ5
	LDA NUSIZ5
	LDX _Sprite_Size5
	ORA _Data_Sprite_Size,x
	STA NUSIZ5
.
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

.L0156 ;  _P0_NUSIZ  =  _P0_NUSIZ  &  %11001111

	LDA _P0_NUSIZ
	AND #%11001111
	STA _P0_NUSIZ
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0157 ;  _P0_NUSIZ  =  _P0_NUSIZ  |  _Data_MB_Width[_Missile0_Width]

	LDA _P0_NUSIZ
	LDX _Missile0_Width
	ORA _Data_MB_Width,x
	STA _P0_NUSIZ
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0158 ;  NUSIZ0  =  _P0_NUSIZ

	LDA _P0_NUSIZ
	STA NUSIZ0
.
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

.L0159 ;  temp5  =  _Data_MB_Width[_Missile1_Width]

	LDX _Missile1_Width
	LDA _Data_MB_Width,x
	STA temp5
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0160 ;  NUSIZ1  =  NUSIZ1  &  %11001111  :  NUSIZ1  =  NUSIZ1  |  temp5

	LDA NUSIZ1
	AND #%11001111
	STA NUSIZ1
	LDA NUSIZ1
	ORA temp5
	STA NUSIZ1
.L0161 ;  _NUSIZ1  =  _NUSIZ1  &  %11001111  :  _NUSIZ1  =  _NUSIZ1  |  temp5

	LDA _NUSIZ1
	AND #%11001111
	STA _NUSIZ1
	LDA _NUSIZ1
	ORA temp5
	STA _NUSIZ1
.L0162 ;  NUSIZ2  =  NUSIZ2  &  %11001111  :  NUSIZ2  =  NUSIZ2  |  temp5

	LDA NUSIZ2
	AND #%11001111
	STA NUSIZ2
	LDA NUSIZ2
	ORA temp5
	STA NUSIZ2
.L0163 ;  NUSIZ3  =  NUSIZ3  &  %11001111  :  NUSIZ3  =  NUSIZ3  |  temp5

	LDA NUSIZ3
	AND #%11001111
	STA NUSIZ3
	LDA NUSIZ3
	ORA temp5
	STA NUSIZ3
.L0164 ;  NUSIZ4  =  NUSIZ4  &  %11001111  :  NUSIZ4  =  NUSIZ4  |  temp5

	LDA NUSIZ4
	AND #%11001111
	STA NUSIZ4
	LDA NUSIZ4
	ORA temp5
	STA NUSIZ4
.L0165 ;  NUSIZ5  =  NUSIZ5  &  %11001111  :  NUSIZ5  =  NUSIZ5  |  temp5

	LDA NUSIZ5
	AND #%11001111
	STA NUSIZ5
	LDA NUSIZ5
	ORA temp5
	STA NUSIZ5
.
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

.L0166 ;  CTRLPF  =  _Data_MB_Width[_Ball_Width]  +  1

	LDX _Ball_Width
	LDA _Data_MB_Width,x
	CLC
	ADC #1
	STA CTRLPF
.
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

.L0167 ;  if !_Bit2_Activate_Jiggle{2} then goto __Skip_Object_Jiggle

	LDA _Bit2_Activate_Jiggle
	AND #4
	BNE .skipL0167
.condpart130
 jmp .__Skip_Object_Jiggle

.skipL0167
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0168 ;  if _Jiggle_Counter  >=  1 then goto __Skip_Memory

	LDA _Jiggle_Counter
	CMP #1
     BCC .skipL0168
.condpart131
 jmp .__Skip_Memory

.skipL0168
.L0169 ;  if _Current_Object  =  _Sprite0 then _Memx  =  player0x  :  _Memy  =  player0y

	LDA _Current_Object
	CMP #_Sprite0
     BNE .skipL0169
.condpart132
	LDA player0x
	STA _Memx
	LDA player0y
	STA _Memy
.skipL0169
.L0170 ;  if _Current_Object  =  _Sprite1 then _Memx  =  player1x  :  _Memy  =  player1y

	LDA _Current_Object
	CMP #_Sprite1
     BNE .skipL0170
.condpart133
	LDA player1x
	STA _Memx
	LDA player1y
	STA _Memy
.skipL0170
.L0171 ;  if _Current_Object  =  _Sprite2 then _Memx  =  player2x  :  _Memy  =  player2y

	LDA _Current_Object
	CMP #_Sprite2
     BNE .skipL0171
.condpart134
	LDA player2x
	STA _Memx
	LDA player2y
	STA _Memy
.skipL0171
.L0172 ;  if _Current_Object  =  _Sprite3 then _Memx  =  player3x  :  _Memy  =  player3y

	LDA _Current_Object
	CMP #_Sprite3
     BNE .skipL0172
.condpart135
	LDA player3x
	STA _Memx
	LDA player3y
	STA _Memy
.skipL0172
.L0173 ;  if _Current_Object  =  _Sprite4 then _Memx  =  player4x  :  _Memy  =  player4y

	LDA _Current_Object
	CMP #_Sprite4
     BNE .skipL0173
.condpart136
	LDA player4x
	STA _Memx
	LDA player4y
	STA _Memy
.skipL0173
.L0174 ;  if _Current_Object  =  _Sprite5 then _Memx  =  player5x  :  _Memy  =  player5y

	LDA _Current_Object
	CMP #_Sprite5
     BNE .skipL0174
.condpart137
	LDA player5x
	STA _Memx
	LDA player5y
	STA _Memy
.skipL0174
.L0175 ;  if _Current_Object  =  _Missile0 then _Memx  =  missile0x  :  _Memy  =  missile0y

	LDA _Current_Object
	CMP #_Missile0
     BNE .skipL0175
.condpart138
	LDA missile0x
	STA _Memx
	LDA missile0y
	STA _Memy
.skipL0175
.L0176 ;  if _Current_Object  =  _Missile1 then _Memx  =  missile1x  :  _Memy  =  missile1y

	LDA _Current_Object
	CMP #_Missile1
     BNE .skipL0176
.condpart139
	LDA missile1x
	STA _Memx
	LDA missile1y
	STA _Memy
.skipL0176
.L0177 ;  if _Current_Object  =  _Ball then _Memx  =  ballx  :  _Memy  =  bally

	LDA _Current_Object
	CMP #_Ball
     BNE .skipL0177
.condpart140
	LDA ballx
	STA _Memx
	LDA bally
	STA _Memy
.skipL0177
.
 ; 

.__Skip_Memory
 ; __Skip_Memory

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0178 ;  _Jiggle_Counter  =  _Jiggle_Counter  +  1

	INC _Jiggle_Counter
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0179 ;  if _Current_Object  =  _Sprite0 then temp5  =  255  +   ( rand & 3 )   :  player0x  =  player0x  +  temp5 :  temp5  =  255  +   ( rand & 3 )   :  player0y  =  player0y  +  temp5

	LDA _Current_Object
	CMP #_Sprite0
     BNE .skipL0179
.condpart141
; complex statement detected
	LDA #255
	PHA
 sta temp7
 lda #>(ret_point2-1)
 pha
 lda #<(ret_point2-1)
 pha
 lda #>(randomize-1)
 pha
 lda #<(randomize-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point2
	AND #3
	TSX
	INX
	TXS
	CLC
	ADC $00,x
	STA temp5
	LDA player0x
	CLC
	ADC temp5
	STA player0x
; complex statement detected
	LDA #255
	PHA
 sta temp7
 lda #>(ret_point3-1)
 pha
 lda #<(ret_point3-1)
 pha
 lda #>(randomize-1)
 pha
 lda #<(randomize-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point3
	AND #3
	TSX
	INX
	TXS
	CLC
	ADC $00,x
	STA temp5
	LDA player0y
	CLC
	ADC temp5
	STA player0y
.skipL0179
.L0180 ;  if _Current_Object  =  _Sprite1 then temp5  =  255  +   ( rand & 3 )   :  player1x  =  player1x  +  temp5 :  temp5  =  255  +   ( rand & 3 )   :  player1y  =  player1y  +  temp5

	LDA _Current_Object
	CMP #_Sprite1
     BNE .skipL0180
.condpart142
; complex statement detected
	LDA #255
	PHA
 sta temp7
 lda #>(ret_point4-1)
 pha
 lda #<(ret_point4-1)
 pha
 lda #>(randomize-1)
 pha
 lda #<(randomize-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point4
	AND #3
	TSX
	INX
	TXS
	CLC
	ADC $00,x
	STA temp5
	LDA player1x
	CLC
	ADC temp5
	STA player1x
; complex statement detected
	LDA #255
	PHA
 sta temp7
 lda #>(ret_point5-1)
 pha
 lda #<(ret_point5-1)
 pha
 lda #>(randomize-1)
 pha
 lda #<(randomize-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point5
	AND #3
	TSX
	INX
	TXS
	CLC
	ADC $00,x
	STA temp5
	LDA player1y
	CLC
	ADC temp5
	STA player1y
.skipL0180
.L0181 ;  if _Current_Object  =  _Sprite2 then temp5  =  255  +   ( rand & 3 )   :  player2x  =  player2x  +  temp5 :  temp5  =  255  +   ( rand & 3 )   :  player2y  =  player2y  +  temp5

	LDA _Current_Object
	CMP #_Sprite2
     BNE .skipL0181
.condpart143
; complex statement detected
	LDA #255
	PHA
 sta temp7
 lda #>(ret_point6-1)
 pha
 lda #<(ret_point6-1)
 pha
 lda #>(randomize-1)
 pha
 lda #<(randomize-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point6
	AND #3
	TSX
	INX
	TXS
	CLC
	ADC $00,x
	STA temp5
	LDA player2x
	CLC
	ADC temp5
	STA player2x
; complex statement detected
	LDA #255
	PHA
 sta temp7
 lda #>(ret_point7-1)
 pha
 lda #<(ret_point7-1)
 pha
 lda #>(randomize-1)
 pha
 lda #<(randomize-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point7
	AND #3
	TSX
	INX
	TXS
	CLC
	ADC $00,x
	STA temp5
	LDA player2y
	CLC
	ADC temp5
	STA player2y
.skipL0181
.L0182 ;  if _Current_Object  =  _Sprite3 then temp5  =  255  +   ( rand & 3 )   :  player3x  =  player3x  +  temp5 :  temp5  =  255  +   ( rand & 3 )   :  player3y  =  player3y  +  temp5

	LDA _Current_Object
	CMP #_Sprite3
     BNE .skipL0182
.condpart144
; complex statement detected
	LDA #255
	PHA
 sta temp7
 lda #>(ret_point8-1)
 pha
 lda #<(ret_point8-1)
 pha
 lda #>(randomize-1)
 pha
 lda #<(randomize-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point8
	AND #3
	TSX
	INX
	TXS
	CLC
	ADC $00,x
	STA temp5
	LDA player3x
	CLC
	ADC temp5
	STA player3x
; complex statement detected
	LDA #255
	PHA
 sta temp7
 lda #>(ret_point9-1)
 pha
 lda #<(ret_point9-1)
 pha
 lda #>(randomize-1)
 pha
 lda #<(randomize-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point9
	AND #3
	TSX
	INX
	TXS
	CLC
	ADC $00,x
	STA temp5
	LDA player3y
	CLC
	ADC temp5
	STA player3y
.skipL0182
.L0183 ;  if _Current_Object  =  _Sprite4 then temp5  =  255  +   ( rand & 3 )   :  player4x  =  player4x  +  temp5 :  temp5  =  255  +   ( rand & 3 )   :  player4y  =  player4y  +  temp5

	LDA _Current_Object
	CMP #_Sprite4
     BNE .skipL0183
.condpart145
; complex statement detected
	LDA #255
	PHA
 sta temp7
 lda #>(ret_point10-1)
 pha
 lda #<(ret_point10-1)
 pha
 lda #>(randomize-1)
 pha
 lda #<(randomize-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point10
	AND #3
	TSX
	INX
	TXS
	CLC
	ADC $00,x
	STA temp5
	LDA player4x
	CLC
	ADC temp5
	STA player4x
; complex statement detected
	LDA #255
	PHA
 sta temp7
 lda #>(ret_point11-1)
 pha
 lda #<(ret_point11-1)
 pha
 lda #>(randomize-1)
 pha
 lda #<(randomize-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point11
	AND #3
	TSX
	INX
	TXS
	CLC
	ADC $00,x
	STA temp5
	LDA player4y
	CLC
	ADC temp5
	STA player4y
.skipL0183
.L0184 ;  if _Current_Object  =  _Sprite5 then temp5  =  255  +   ( rand & 3 )   :  player5x  =  player5x  +  temp5 :  temp5  =  255  +   ( rand & 3 )   :  player5y  =  player5y  +  temp5

	LDA _Current_Object
	CMP #_Sprite5
     BNE .skipL0184
.condpart146
; complex statement detected
	LDA #255
	PHA
 sta temp7
 lda #>(ret_point12-1)
 pha
 lda #<(ret_point12-1)
 pha
 lda #>(randomize-1)
 pha
 lda #<(randomize-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point12
	AND #3
	TSX
	INX
	TXS
	CLC
	ADC $00,x
	STA temp5
	LDA player5x
	CLC
	ADC temp5
	STA player5x
; complex statement detected
	LDA #255
	PHA
 sta temp7
 lda #>(ret_point13-1)
 pha
 lda #<(ret_point13-1)
 pha
 lda #>(randomize-1)
 pha
 lda #<(randomize-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point13
	AND #3
	TSX
	INX
	TXS
	CLC
	ADC $00,x
	STA temp5
	LDA player5y
	CLC
	ADC temp5
	STA player5y
.skipL0184
.L0185 ;  if _Current_Object  =  _Missile0 then temp5  =  255  +   ( rand & 3 )   :  missile0x  =  missile0x  +  temp5 :  temp5  =  255  +   ( rand & 3 )   :  missile0y  =  missile0y  +  temp5

	LDA _Current_Object
	CMP #_Missile0
     BNE .skipL0185
.condpart147
; complex statement detected
	LDA #255
	PHA
 sta temp7
 lda #>(ret_point14-1)
 pha
 lda #<(ret_point14-1)
 pha
 lda #>(randomize-1)
 pha
 lda #<(randomize-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point14
	AND #3
	TSX
	INX
	TXS
	CLC
	ADC $00,x
	STA temp5
	LDA missile0x
	CLC
	ADC temp5
	STA missile0x
; complex statement detected
	LDA #255
	PHA
 sta temp7
 lda #>(ret_point15-1)
 pha
 lda #<(ret_point15-1)
 pha
 lda #>(randomize-1)
 pha
 lda #<(randomize-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point15
	AND #3
	TSX
	INX
	TXS
	CLC
	ADC $00,x
	STA temp5
	LDA missile0y
	CLC
	ADC temp5
	STA missile0y
.skipL0185
.L0186 ;  if _Current_Object  =  _Missile1 then temp5  =  255  +   ( rand & 3 )   :  missile1x  =  missile1x  +  temp5 :  temp5  =  255  +   ( rand & 3 )   :  missile1y  =  missile1y  +  temp5

	LDA _Current_Object
	CMP #_Missile1
     BNE .skipL0186
.condpart148
; complex statement detected
	LDA #255
	PHA
 sta temp7
 lda #>(ret_point16-1)
 pha
 lda #<(ret_point16-1)
 pha
 lda #>(randomize-1)
 pha
 lda #<(randomize-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point16
	AND #3
	TSX
	INX
	TXS
	CLC
	ADC $00,x
	STA temp5
	LDA missile1x
	CLC
	ADC temp5
	STA missile1x
; complex statement detected
	LDA #255
	PHA
 sta temp7
 lda #>(ret_point17-1)
 pha
 lda #<(ret_point17-1)
 pha
 lda #>(randomize-1)
 pha
 lda #<(randomize-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point17
	AND #3
	TSX
	INX
	TXS
	CLC
	ADC $00,x
	STA temp5
	LDA missile1y
	CLC
	ADC temp5
	STA missile1y
.skipL0186
.L0187 ;  if _Current_Object  =  _Ball then temp5  =  255  +   ( rand & 3 )   :  ballx  =  ballx  +  temp5 :  temp5  =  255  +   ( rand & 3 )   :  bally  =  bally  +  temp5

	LDA _Current_Object
	CMP #_Ball
     BNE .skipL0187
.condpart149
; complex statement detected
	LDA #255
	PHA
 sta temp7
 lda #>(ret_point18-1)
 pha
 lda #<(ret_point18-1)
 pha
 lda #>(randomize-1)
 pha
 lda #<(randomize-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point18
	AND #3
	TSX
	INX
	TXS
	CLC
	ADC $00,x
	STA temp5
	LDA ballx
	CLC
	ADC temp5
	STA ballx
; complex statement detected
	LDA #255
	PHA
 sta temp7
 lda #>(ret_point19-1)
 pha
 lda #<(ret_point19-1)
 pha
 lda #>(randomize-1)
 pha
 lda #<(randomize-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point19
	AND #3
	TSX
	INX
	TXS
	CLC
	ADC $00,x
	STA temp5
	LDA bally
	CLC
	ADC temp5
	STA bally
.skipL0187
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0188 ;  if _Jiggle_Counter  <=  4 then goto __Skip_Object_Jiggle

	LDA #4
	CMP _Jiggle_Counter
     BCC .skipL0188
.condpart150
 jmp .__Skip_Object_Jiggle

.skipL0188
.
 ; 

.L0189 ;  _Bit2_Activate_Jiggle{2}  =  0  :  _Jiggle_Counter  =  0

	LDA _Bit2_Activate_Jiggle
	AND #251
	STA _Bit2_Activate_Jiggle
	LDA #0
	STA _Jiggle_Counter
.
 ; 

.L0190 ;  if _Current_Object  =  _Sprite0 then player0x  =  _Memx  :  player0y  =  _Memy

	LDA _Current_Object
	CMP #_Sprite0
     BNE .skipL0190
.condpart151
	LDA _Memx
	STA player0x
	LDA _Memy
	STA player0y
.skipL0190
.L0191 ;  if _Current_Object  =  _Sprite1 then player1x  =  _Memx  :  player1y  =  _Memy

	LDA _Current_Object
	CMP #_Sprite1
     BNE .skipL0191
.condpart152
	LDA _Memx
	STA player1x
	LDA _Memy
	STA player1y
.skipL0191
.L0192 ;  if _Current_Object  =  _Sprite2 then player2x  =  _Memx  :  player2y  =  _Memy

	LDA _Current_Object
	CMP #_Sprite2
     BNE .skipL0192
.condpart153
	LDA _Memx
	STA player2x
	LDA _Memy
	STA player2y
.skipL0192
.L0193 ;  if _Current_Object  =  _Sprite3 then player3x  =  _Memx  :  player3y  =  _Memy

	LDA _Current_Object
	CMP #_Sprite3
     BNE .skipL0193
.condpart154
	LDA _Memx
	STA player3x
	LDA _Memy
	STA player3y
.skipL0193
.L0194 ;  if _Current_Object  =  _Sprite4 then player4x  =  _Memx  :  player4y  =  _Memy

	LDA _Current_Object
	CMP #_Sprite4
     BNE .skipL0194
.condpart155
	LDA _Memx
	STA player4x
	LDA _Memy
	STA player4y
.skipL0194
.L0195 ;  if _Current_Object  =  _Sprite5 then player5x  =  _Memx  :  player5y  =  _Memy

	LDA _Current_Object
	CMP #_Sprite5
     BNE .skipL0195
.condpart156
	LDA _Memx
	STA player5x
	LDA _Memy
	STA player5y
.skipL0195
.L0196 ;  if _Current_Object  =  _Missile0 then missile0x  =  _Memx  :  missile0y  =  _Memy

	LDA _Current_Object
	CMP #_Missile0
     BNE .skipL0196
.condpart157
	LDA _Memx
	STA missile0x
	LDA _Memy
	STA missile0y
.skipL0196
.L0197 ;  if _Current_Object  =  _Missile1 then missile1x  =  _Memx  :  missile1y  =  _Memy

	LDA _Current_Object
	CMP #_Missile1
     BNE .skipL0197
.condpart158
	LDA _Memx
	STA missile1x
	LDA _Memy
	STA missile1y
.skipL0197
.L0198 ;  if _Current_Object  =  _Ball then ballx  =  _Memx  :  bally  =  _Memy

	LDA _Current_Object
	CMP #_Ball
     BNE .skipL0198
.condpart159
	LDA _Memx
	STA ballx
	LDA _Memy
	STA bally
.skipL0198
.
 ; 

.__Skip_Object_Jiggle
 ; __Skip_Object_Jiggle

.
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

.L0199 ;  if _Current_Object  =  _Sprite0 then scorecolor  =  $08  :  temp4  =  player0x

	LDA _Current_Object
	CMP #_Sprite0
     BNE .skipL0199
.condpart160
	LDA #$08
	STA scorecolor
	LDA player0x
	STA temp4
.skipL0199
.L0200 ;  if _Current_Object  =  _Sprite1 then scorecolor  =  $1A  :  temp4  =  player1x

	LDA _Current_Object
	CMP #_Sprite1
     BNE .skipL0200
.condpart161
	LDA #$1A
	STA scorecolor
	LDA player1x
	STA temp4
.skipL0200
.L0201 ;  if _Current_Object  =  _Sprite2 then scorecolor  =  $3A  :  temp4  =  player2x

	LDA _Current_Object
	CMP #_Sprite2
     BNE .skipL0201
.condpart162
	LDA #$3A
	STA scorecolor
	LDA player2x
	STA temp4
.skipL0201
.L0202 ;  if _Current_Object  =  _Sprite3 then scorecolor  =  $6A  :  temp4  =  player3x

	LDA _Current_Object
	CMP #_Sprite3
     BNE .skipL0202
.condpart163
	LDA #$6A
	STA scorecolor
	LDA player3x
	STA temp4
.skipL0202
.L0203 ;  if _Current_Object  =  _Sprite4 then scorecolor  =  $8A  :  temp4  =  player4x

	LDA _Current_Object
	CMP #_Sprite4
     BNE .skipL0203
.condpart164
	LDA #$8A
	STA scorecolor
	LDA player4x
	STA temp4
.skipL0203
.L0204 ;  if _Current_Object  =  _Sprite5 then scorecolor  =  $CA  :  temp4  =  player5x

	LDA _Current_Object
	CMP #_Sprite5
     BNE .skipL0204
.condpart165
	LDA #$CA
	STA scorecolor
	LDA player5x
	STA temp4
.skipL0204
.L0205 ;  if _Current_Object  =  _Missile0 then scorecolor  =  $5A  :  temp4  =  missile0x

	LDA _Current_Object
	CMP #_Missile0
     BNE .skipL0205
.condpart166
	LDA #$5A
	STA scorecolor
	LDA missile0x
	STA temp4
.skipL0205
.L0206 ;  if _Current_Object  =  _Missile1 then scorecolor  =  $BA  :  temp4  =  missile1x

	LDA _Current_Object
	CMP #_Missile1
     BNE .skipL0206
.condpart167
	LDA #$BA
	STA scorecolor
	LDA missile1x
	STA temp4
.skipL0206
.L0207 ;  if _Current_Object  =  _Ball then scorecolor  =  $4A  :  temp4  =  ballx

	LDA _Current_Object
	CMP #_Ball
     BNE .skipL0207
.condpart168
	LDA #$4A
	STA scorecolor
	LDA ballx
	STA temp4
.skipL0207
.
 ; 

.L0208 ;  _sc1  =  0  :  _sc2  =  _sc2  &  15

	LDA #0
	STA _sc1
	LDA _sc2
	AND #15
	STA _sc2
.L0209 ;  if temp4  >=  100 then _sc1  =  _sc1  +  16  :  temp4  =  temp4  -  100

	LDA temp4
	CMP #100
     BCC .skipL0209
.condpart169
	LDA _sc1
	CLC
	ADC #16
	STA _sc1
	LDA temp4
	SEC
	SBC #100
	STA temp4
.skipL0209
.L0210 ;  if temp4  >=  100 then _sc1  =  _sc1  +  16  :  temp4  =  temp4  -  100

	LDA temp4
	CMP #100
     BCC .skipL0210
.condpart170
	LDA _sc1
	CLC
	ADC #16
	STA _sc1
	LDA temp4
	SEC
	SBC #100
	STA temp4
.skipL0210
.L0211 ;  if temp4  >=  50 then _sc1  =  _sc1  +  5  :  temp4  =  temp4  -  50

	LDA temp4
	CMP #50
     BCC .skipL0211
.condpart171
	LDA _sc1
	CLC
	ADC #5
	STA _sc1
	LDA temp4
	SEC
	SBC #50
	STA temp4
.skipL0211
.L0212 ;  if temp4  >=  30 then _sc1  =  _sc1  +  3  :  temp4  =  temp4  -  30

	LDA temp4
	CMP #30
     BCC .skipL0212
.condpart172
	LDA _sc1
	CLC
	ADC #3
	STA _sc1
	LDA temp4
	SEC
	SBC #30
	STA temp4
.skipL0212
.L0213 ;  if temp4  >=  20 then _sc1  =  _sc1  +  2  :  temp4  =  temp4  -  20

	LDA temp4
	CMP #20
     BCC .skipL0213
.condpart173
	LDA _sc1
	CLC
	ADC #2
	STA _sc1
	LDA temp4
	SEC
	SBC #20
	STA temp4
.skipL0213
.L0214 ;  if temp4  >=  10 then _sc1  =  _sc1  +  1  :  temp4  =  temp4  -  10

	LDA temp4
	CMP #10
     BCC .skipL0214
.condpart174
	INC _sc1
	LDA temp4
	SEC
	SBC #10
	STA temp4
.skipL0214
.L0215 ;  _sc2  =   ( temp4  *  4  *  4 )   |  _sc2

; complex statement detected
	LDA temp4
	asl
	asl
	asl
	asl
	ORA _sc2
	STA _sc2
.
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

.L0216 ;  if _Current_Object  =  _Sprite0 then temp4  =  player0y

	LDA _Current_Object
	CMP #_Sprite0
     BNE .skipL0216
.condpart175
	LDA player0y
	STA temp4
.skipL0216
.L0217 ;  if _Current_Object  =  _Sprite1 then temp4  =  player1y

	LDA _Current_Object
	CMP #_Sprite1
     BNE .skipL0217
.condpart176
	LDA player1y
	STA temp4
.skipL0217
.L0218 ;  if _Current_Object  =  _Sprite2 then temp4  =  player2y

	LDA _Current_Object
	CMP #_Sprite2
     BNE .skipL0218
.condpart177
	LDA player2y
	STA temp4
.skipL0218
.L0219 ;  if _Current_Object  =  _Sprite3 then temp4  =  player3y

	LDA _Current_Object
	CMP #_Sprite3
     BNE .skipL0219
.condpart178
	LDA player3y
	STA temp4
.skipL0219
.L0220 ;  if _Current_Object  =  _Sprite4 then temp4  =  player4y

	LDA _Current_Object
	CMP #_Sprite4
     BNE .skipL0220
.condpart179
	LDA player4y
	STA temp4
.skipL0220
.L0221 ;  if _Current_Object  =  _Sprite5 then temp4  =  player5y

	LDA _Current_Object
	CMP #_Sprite5
     BNE .skipL0221
.condpart180
	LDA player5y
	STA temp4
.skipL0221
.L0222 ;  if _Current_Object  =  _Missile0 then temp4  =  missile0y

	LDA _Current_Object
	CMP #_Missile0
     BNE .skipL0222
.condpart181
	LDA missile0y
	STA temp4
.skipL0222
.L0223 ;  if _Current_Object  =  _Missile1 then temp4  =  missile1y

	LDA _Current_Object
	CMP #_Missile1
     BNE .skipL0223
.condpart182
	LDA missile1y
	STA temp4
.skipL0223
.L0224 ;  if _Current_Object  =  _Ball then temp4  =  bally

	LDA _Current_Object
	CMP #_Ball
     BNE .skipL0224
.condpart183
	LDA bally
	STA temp4
.skipL0224
.
 ; 

.L0225 ;  _sc2  =  _sc2  &  240  :  _sc3  =  0

	LDA _sc2
	AND #240
	STA _sc2
	LDA #0
	STA _sc3
.L0226 ;  if temp4  >=  100 then _sc2  =  _sc2  +  1  :  temp4  =  temp4  -  100

	LDA temp4
	CMP #100
     BCC .skipL0226
.condpart184
	INC _sc2
	LDA temp4
	SEC
	SBC #100
	STA temp4
.skipL0226
.L0227 ;  if temp4  >=  100 then _sc2  =  _sc2  +  1  :  temp4  =  temp4  -  100

	LDA temp4
	CMP #100
     BCC .skipL0227
.condpart185
	INC _sc2
	LDA temp4
	SEC
	SBC #100
	STA temp4
.skipL0227
.L0228 ;  if temp4  >=  50 then _sc3  =  _sc3  +  80  :  temp4  =  temp4  -  50

	LDA temp4
	CMP #50
     BCC .skipL0228
.condpart186
	LDA _sc3
	CLC
	ADC #80
	STA _sc3
	LDA temp4
	SEC
	SBC #50
	STA temp4
.skipL0228
.L0229 ;  if temp4  >=  30 then _sc3  =  _sc3  +  48  :  temp4  =  temp4  -  30

	LDA temp4
	CMP #30
     BCC .skipL0229
.condpart187
	LDA _sc3
	CLC
	ADC #48
	STA _sc3
	LDA temp4
	SEC
	SBC #30
	STA temp4
.skipL0229
.L0230 ;  if temp4  >=  20 then _sc3  =  _sc3  +  32  :  temp4  =  temp4  -  20

	LDA temp4
	CMP #20
     BCC .skipL0230
.condpart188
	LDA _sc3
	CLC
	ADC #32
	STA _sc3
	LDA temp4
	SEC
	SBC #20
	STA temp4
.skipL0230
.L0231 ;  if temp4  >=  10 then _sc3  =  _sc3  +  16  :  temp4  =  temp4  -  10

	LDA temp4
	CMP #10
     BCC .skipL0231
.condpart189
	LDA _sc3
	CLC
	ADC #16
	STA _sc3
	LDA temp4
	SEC
	SBC #10
	STA temp4
.skipL0231
.L0232 ;  _sc3  =  _sc3  |  temp4

	LDA _sc3
	ORA temp4
	STA _sc3
.
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

.L0233 ;  drawscreen

 sta temp7
 lda #>(ret_point20-1)
 pha
 lda #<(ret_point20-1)
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
ret_point20
.
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

.L0234 ;  if !switchreset then _Bit0_Reset_Restrainer{0}  =  0  :  goto __Main_Loop bank1

 lda #1
 bit SWCHB
	BEQ .skipL0234
.condpart190
	LDA _Bit0_Reset_Restrainer
	AND #254
	STA _Bit0_Reset_Restrainer
 sta temp7
 lda #>(.__Main_Loop-1)
 pha
 lda #<(.__Main_Loop-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
.skipL0234
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0235 ;  if _Bit0_Reset_Restrainer{0} then goto __Main_Loop bank1

	LDA _Bit0_Reset_Restrainer
	LSR
	BCC .skipL0235
.condpart191
 sta temp7
 lda #>(.__Main_Loop-1)
 pha
 lda #<(.__Main_Loop-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
.skipL0235
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0236 ;  goto __Start_Restart bank1

 sta temp7
 lda #>(.__Start_Restart-1)
 pha
 lda #<(.__Start_Restart-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
.
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

.L0237 ;  data _Data_Sprite_Size

	JMP .skipL0237
_Data_Sprite_Size
	.byte    0, 5, 7

.skipL0237
.
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

.L0238 ;  data _Data_MB_Width

	JMP .skipL0238
_Data_MB_Width
	.byte    $00, $10, $20, $30

.skipL0238
.
 ; 

.
 ; 

.
 ; 

.L0239 ;  bank 3

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
.
 ; 

.
 ; 

.
 ; 

.L0240 ;  bank 4
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
 if (<*) > (<(*+8))
	repeat ($100-<*)
	.byte 0
	repend
	endif
 if (<*) < 90
	repeat (90-<*)
	.byte 0
	repend
	endif
playerL035_0
	.byte 0
	.byte    %00001111
	.byte    %00000110
	.byte    %11111111
	.byte    %00111110
	.byte    %11111111
	.byte    %00000110
	.byte    %00001111
	.byte 
 if (<*) > (<(*+6))
	repeat ($100-<*)
	.byte 0
	repend
	endif
 if (<*) < 90
	repeat (90-<*)
	.byte 0
	repend
	endif
playerL036_1
	.byte    %00000011
	.byte    %00000110
	.byte    %00011111
	.byte    %11111110
	.byte    %00011111
	.byte    %00000110
	.byte    %00000011
 if (<*) > (<(*+6))
	repeat ($100-<*)
	.byte 0
	repend
	endif
 if (<*) < 90
	repeat (90-<*)
	.byte 0
	repend
	endif
playerL037_2
	.byte    %00001111
	.byte    %00000110
	.byte    %11111110
	.byte    %00001111
	.byte    %11111110
	.byte    %00000110
	.byte    %00001111
 if (<*) > (<(*+6))
	repeat ($100-<*)
	.byte 0
	repend
	endif
 if (<*) < 90
	repeat (90-<*)
	.byte 0
	repend
	endif
playerL038_3
	.byte    %00111110
	.byte    %00000111
	.byte    %00011110
	.byte    %11111110
	.byte    %00011110
	.byte    %00000111
	.byte    %00111110
 if (<*) > (<(*+6))
	repeat ($100-<*)
	.byte 0
	repend
	endif
 if (<*) < 90
	repeat (90-<*)
	.byte 0
	repend
	endif
playerL039_4
	.byte    %00001111
	.byte    %00000110
	.byte    %00011110
	.byte    %11111111
	.byte    %00011110
	.byte    %00000110
	.byte    %00001111
 if (<*) > (<(*+6))
	repeat ($100-<*)
	.byte 0
	repend
	endif
 if (<*) < 90
	repeat (90-<*)
	.byte 0
	repend
	endif
playerL040_5
	.byte    %00011111
	.byte    %00000100
	.byte    %11111110
	.byte    %00111110
	.byte    %11111110
	.byte    %00000100
	.byte    %00011111
 if ECHOFIRST
       echo "    ",[(scoretable - *)]d , "bytes of ROM space left in bank 4")
 endif 
ECHOFIRST = 1
 
 
 
