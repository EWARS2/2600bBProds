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

.L00 ;  set kernel_options player1colors

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01 ;  dim _P1_Left_Right  =  player1x.a

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L02 ;  dim _Jump_Gravity_Counter  =  b

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L03 ;  dim _Fall_Gravity_Counter  =  c

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L04 ;  dim _Master_Counter  =  d

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L05 ;  dim _Frame_Counter  =  e

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L06 ;  dim _Ch0_Sound  =  f

.L07 ;  dim _Ch0_Duration  =  g

.L08 ;  dim _Ch0_Counter  =  h

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L09 ;  dim _BitOp_01  =  y

.L010 ;  dim _Bit2_Fall_in_Progress  =  y

.L011 ;  dim _Bit3_FireB_Restrainer  =  y

.L012 ;  dim _Bit4_Flip_P1  =  y

.L013 ;  dim _Bit5_LR_Joy_Movement  =  y

.L014 ;  dim _Bit6_Duck_in_Progress  =  y

.L015 ;  dim _Bit7_Reset_Restrainer  =  y

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L016 ;  const _c_Jump_Sound  =  1

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L017 ;  const _00  =  $00

.L018 ;  const _02  =  $02

.L019 ;  const _04  =  $04

.L020 ;  const _06  =  $06

.L021 ;  const _08  =  $08

.L022 ;  const _0A  =  $0A

.L023 ;  const _0C  =  $0C

.L024 ;  const _0E  =  $0E

.L025 ;  const _10  =  $10

.L026 ;  const _12  =  $12

.L027 ;  const _14  =  $14

.L028 ;  const _16  =  $16

.L029 ;  const _18  =  $18

.L030 ;  const _1A  =  $1A

.L031 ;  const _1C  =  $1C

.L032 ;  const _1E  =  $1E

.L033 ;  const _20  =  $20

.L034 ;  const _22  =  $22

.L035 ;  const _24  =  $24

.L036 ;  const _26  =  $26

.L037 ;  const _28  =  $28

.L038 ;  const _2A  =  $2A

.L039 ;  const _2C  =  $2C

.L040 ;  const _2E  =  $2E

.L041 ;  const _30  =  $30

.L042 ;  const _32  =  $32

.L043 ;  const _34  =  $34

.L044 ;  const _36  =  $36

.L045 ;  const _38  =  $38

.L046 ;  const _3A  =  $3A

.L047 ;  const _3C  =  $3C

.L048 ;  const _3E  =  $3E

.L049 ;  const _40  =  $40

.L050 ;  const _42  =  $42

.L051 ;  const _44  =  $44

.L052 ;  const _46  =  $46

.L053 ;  const _48  =  $48

.L054 ;  const _4A  =  $4A

.L055 ;  const _4C  =  $4C

.L056 ;  const _4E  =  $4E

.L057 ;  const _50  =  $50

.L058 ;  const _52  =  $52

.L059 ;  const _54  =  $54

.L060 ;  const _56  =  $56

.L061 ;  const _58  =  $58

.L062 ;  const _5A  =  $5A

.L063 ;  const _5C  =  $5C

.L064 ;  const _5E  =  $5E

.L065 ;  const _60  =  $60

.L066 ;  const _62  =  $62

.L067 ;  const _64  =  $64

.L068 ;  const _66  =  $66

.L069 ;  const _68  =  $68

.L070 ;  const _6A  =  $6A

.L071 ;  const _6C  =  $6C

.L072 ;  const _6E  =  $6E

.L073 ;  const _70  =  $70

.L074 ;  const _72  =  $72

.L075 ;  const _74  =  $74

.L076 ;  const _76  =  $76

.L077 ;  const _78  =  $78

.L078 ;  const _7A  =  $7A

.L079 ;  const _7C  =  $7C

.L080 ;  const _7E  =  $7E

.L081 ;  const _80  =  $80

.L082 ;  const _82  =  $82

.L083 ;  const _84  =  $84

.L084 ;  const _86  =  $86

.L085 ;  const _88  =  $88

.L086 ;  const _8A  =  $8A

.L087 ;  const _8C  =  $8C

.L088 ;  const _8E  =  $8E

.L089 ;  const _90  =  $90

.L090 ;  const _92  =  $92

.L091 ;  const _94  =  $94

.L092 ;  const _96  =  $96

.L093 ;  const _98  =  $98

.L094 ;  const _9A  =  $9A

.L095 ;  const _9C  =  $9C

.L096 ;  const _9E  =  $9E

.L097 ;  const _A0  =  $A0

.L098 ;  const _A2  =  $A2

.L099 ;  const _A4  =  $A4

.L0100 ;  const _A6  =  $A6

.L0101 ;  const _A8  =  $A8

.L0102 ;  const _AA  =  $AA

.L0103 ;  const _AC  =  $AC

.L0104 ;  const _AE  =  $AE

.L0105 ;  const _B0  =  $B0

.L0106 ;  const _B2  =  $B2

.L0107 ;  const _B4  =  $B4

.L0108 ;  const _B6  =  $B6

.L0109 ;  const _B8  =  $B8

.L0110 ;  const _BA  =  $BA

.L0111 ;  const _BC  =  $BC

.L0112 ;  const _BE  =  $BE

.L0113 ;  const _C0  =  $C0

.L0114 ;  const _C2  =  $C2

.L0115 ;  const _C4  =  $C4

.L0116 ;  const _C6  =  $C6

.L0117 ;  const _C8  =  $C8

.L0118 ;  const _CA  =  $CA

.L0119 ;  const _CC  =  $CC

.L0120 ;  const _CE  =  $CE

.L0121 ;  const _D0  =  $D0

.L0122 ;  const _D2  =  $D2

.L0123 ;  const _D4  =  $D4

.L0124 ;  const _D6  =  $D6

.L0125 ;  const _D8  =  $D8

.L0126 ;  const _DA  =  $DA

.L0127 ;  const _DC  =  $DC

.L0128 ;  const _DE  =  $DE

.L0129 ;  const _E0  =  $E0

.L0130 ;  const _E2  =  $E2

.L0131 ;  const _E4  =  $E4

.L0132 ;  const _E6  =  $E6

.L0133 ;  const _E8  =  $E8

.L0134 ;  const _EA  =  $EA

.L0135 ;  const _EC  =  $EC

.L0136 ;  const _EE  =  $EE

.L0137 ;  const _F0  =  $F0

.L0138 ;  const _F2  =  $F2

.L0139 ;  const _F4  =  $F4

.L0140 ;  const _F6  =  $F6

.L0141 ;  const _F8  =  $F8

.L0142 ;  const _FA  =  $FA

.L0143 ;  const _FC  =  $FC

.L0144 ;  const _FE  =  $FE

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
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

.L0145 ;  AUDV0  =  0  :  AUDV1  =  0

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

.L0146 ;  a  =  0  :  b  =  0  :  c  =  0  :  d  =  0  :  e  =  0  :  f  =  0  :  g  =  0  :  h  =  0  :  i  =  0

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
.L0147 ;  j  =  0  :  k  =  0  :  l  =  0  :  m  =  0  :  n  =  0  :  o  =  0  :  p  =  0  :  q  =  0  :  r  =  0

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
.L0148 ;  s  =  0  :  t  =  0  :  u  =  0  :  v  =  0  :  w  =  0  :  x  =  0  :  y  =  0  :  z  =  0

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

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Main_Loop_Setup
 ; __Main_Loop_Setup

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0149 ;  player1x  =  79  :  player1y  =  79

	LDA #79
	STA player1x
	STA player1y
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0150 ;  _Bit7_Reset_Restrainer{7}  =  1

	LDA _Bit7_Reset_Restrainer
	ORA #128
	STA _Bit7_Reset_Restrainer
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0151 ;  playfield:

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
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
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

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
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

.L0152 ;  COLUPF  =  _C4  :  COLUBK  =  _00

	LDA #_C4
	STA COLUPF
	LDA #_00
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

.L0153 ;  _Master_Counter  =  _Master_Counter  +  1

	INC _Master_Counter
.
 ; 

.L0154 ;  if _Master_Counter  <  4 then goto __Skip_Frame_Counter

	LDA _Master_Counter
	CMP #4
     BCS .skipL0154
.condpart0
 jmp .__Skip_Frame_Counter

.skipL0154
.
 ; 

.L0155 ;  _Frame_Counter  =  _Frame_Counter  +  1  :  _Master_Counter  =  0

	INC _Frame_Counter
	LDA #0
	STA _Master_Counter
.
 ; 

.L0156 ;  if _Frame_Counter  =  4 then _Frame_Counter  =  0

	LDA _Frame_Counter
	CMP #4
     BNE .skipL0156
.condpart1
	LDA #0
	STA _Frame_Counter
.skipL0156
.
 ; 

.__Skip_Frame_Counter
 ; __Skip_Frame_Counter

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0157 ;  player1color:

	LDX #<playercolorL0157_1
	STX player1color
	LDA #>playercolorL0157_1
	STA player1color+1
.
 ; 

.L0158 ;  player1:

	LDX #<playerL0158_1
	STX player1pointerlo
	LDA #>playerL0158_1
	STA player1pointerhi
	LDA #9
	STA player1height
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0159 ;  if !joy0fire then _Jump_Gravity_Counter  =  0  :  _Bit3_FireB_Restrainer{3}  =  0  :  goto __Skip_Jump

 bit INPT4
	BPL .skipL0159
.condpart2
	LDA #0
	STA _Jump_Gravity_Counter
	LDA _Bit3_FireB_Restrainer
	AND #247
	STA _Bit3_FireB_Restrainer
 jmp .__Skip_Jump

.skipL0159
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0160 ;  if !_Bit3_FireB_Restrainer{3} then player1:

	LDA _Bit3_FireB_Restrainer
	AND #8
	BNE .skipL0160
.condpart3
	LDX #<player3then_1
	STX player1pointerlo
	LDA #>player3then_1
	STA player1pointerhi
	LDA #9
	STA player1height
.skipL0160
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0161 ;  if !joy0left  &&  !joy0right  &&  !_Bit3_FireB_Restrainer{3} then player1:

 bit SWCHA
	BVC .skipL0161
.condpart4
 bit SWCHA
	BPL .skip4then
.condpart5
	LDA _Bit3_FireB_Restrainer
	AND #8
	BNE .skip5then
.condpart6
	LDX #<player6then_1
	STX player1pointerlo
	LDA #>player6then_1
	STA player1pointerhi
	LDA #9
	STA player1height
.skip5then
.skip4then
.skipL0161
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0162 ;  if _Bit2_Fall_in_Progress{2} then goto __Skip_Jump

	LDA _Bit2_Fall_in_Progress
	AND #4
	BEQ .skipL0162
.condpart7
 jmp .__Skip_Jump

.skipL0162
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0163 ;  if _Bit3_FireB_Restrainer{3}  &&  !_Bit2_Fall_in_Progress{2}  &&  !_Jump_Gravity_Counter then goto __Skip_Jump

	LDA _Bit3_FireB_Restrainer
	AND #8
	BEQ .skipL0163
.condpart8
	LDA _Bit2_Fall_in_Progress
	AND #4
	BNE .skip8then
.condpart9
	LDA _Jump_Gravity_Counter
	BNE .skip9then
.condpart10
 jmp .__Skip_Jump

.skip9then
.skip8then
.skipL0163
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0164 ;  if !_Jump_Gravity_Counter then _Ch0_Sound  =  _c_Jump_Sound  :  _Ch0_Duration  =  1  :  _Ch0_Counter  =  0

	LDA _Jump_Gravity_Counter
	BNE .skipL0164
.condpart11
	LDA #_c_Jump_Sound
	STA _Ch0_Sound
	LDA #1
	STA _Ch0_Duration
	LDA #0
	STA _Ch0_Counter
.skipL0164
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0165 ;  _Bit3_FireB_Restrainer{3}  =  1

	LDA _Bit3_FireB_Restrainer
	ORA #8
	STA _Bit3_FireB_Restrainer
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0166 ;  _Jump_Gravity_Counter  =  _Jump_Gravity_Counter  +  1

	INC _Jump_Gravity_Counter
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0167 ;  if _Jump_Gravity_Counter  >  12 then _Jump_Gravity_Counter  =  0  :  _Bit2_Fall_in_Progress{2}  =  1  :  goto __Skip_Jump

	LDA #12
	CMP _Jump_Gravity_Counter
     BCS .skipL0167
.condpart12
	LDA #0
	STA _Jump_Gravity_Counter
	LDA _Bit2_Fall_in_Progress
	ORA #4
	STA _Bit2_Fall_in_Progress
 jmp .__Skip_Jump

.skipL0167
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0168 ;  if player1y  <  13 then goto __Skip_Jump

	LDA player1y
	CMP #13
     BCS .skipL0168
.condpart13
 jmp .__Skip_Jump

.skipL0168
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0169 ;  if _Jump_Gravity_Counter  <=  7 then temp6  =  3

	LDA #7
	CMP _Jump_Gravity_Counter
     BCC .skipL0169
.condpart14
	LDA #3
	STA temp6
.skipL0169
.L0170 ;  if _Jump_Gravity_Counter  >  7  &&  _Jump_Gravity_Counter  <=  10 then temp6  =  2

	LDA #7
	CMP _Jump_Gravity_Counter
     BCS .skipL0170
.condpart15
	LDA #10
	CMP _Jump_Gravity_Counter
     BCC .skip15then
.condpart16
	LDA #2
	STA temp6
.skip15then
.skipL0170
.L0171 ;  if _Jump_Gravity_Counter  >  10 then temp6  =  1

	LDA #10
	CMP _Jump_Gravity_Counter
     BCS .skipL0171
.condpart17
	LDA #1
	STA temp6
.skipL0171
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0172 ;  player1y  =  player1y  -  temp6

	LDA player1y
	SEC
	SBC temp6
	STA player1y
.
 ; 

.__Skip_Jump
 ; __Skip_Jump

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0173 ;  if _Jump_Gravity_Counter then goto __Skip_Fall_01

	LDA _Jump_Gravity_Counter
	BEQ .skipL0173
.condpart18
 jmp .__Skip_Fall_01

.skipL0173
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0174 ;  if player1y  >=  79 then player1y  =  80  :  goto __Skip_Fall_01

	LDA player1y
	CMP #79
     BCC .skipL0174
.condpart19
	LDA #80
	STA player1y
 jmp .__Skip_Fall_01

.skipL0174
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0175 ;  player1:

	LDX #<playerL0175_1
	STX player1pointerlo
	LDA #>playerL0175_1
	STA player1pointerhi
	LDA #9
	STA player1height
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0176 ;  if !joy0left  &&  !joy0right then player1:

 bit SWCHA
	BVC .skipL0176
.condpart20
 bit SWCHA
	BPL .skip20then
.condpart21
	LDX #<player21then_1
	STX player1pointerlo
	LDA #>player21then_1
	STA player1pointerhi
	LDA #9
	STA player1height
.skip20then
.skipL0176
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0177 ;  _Fall_Gravity_Counter  =  _Fall_Gravity_Counter  +  1

	INC _Fall_Gravity_Counter
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0178 ;  temp6  =  0

	LDA #0
	STA temp6
.L0179 ;  if _Fall_Gravity_Counter  >  8  &&  _Jump_Gravity_Counter  <=  16 then temp6  =  1

	LDA #8
	CMP _Fall_Gravity_Counter
     BCS .skipL0179
.condpart22
	LDA #16
	CMP _Jump_Gravity_Counter
     BCC .skip22then
.condpart23
	LDA #1
	STA temp6
.skip22then
.skipL0179
.L0180 ;  if _Fall_Gravity_Counter  >  16  &&  _Jump_Gravity_Counter  <=  24 then temp6  =  2

	LDA #16
	CMP _Fall_Gravity_Counter
     BCS .skipL0180
.condpart24
	LDA #24
	CMP _Jump_Gravity_Counter
     BCC .skip24then
.condpart25
	LDA #2
	STA temp6
.skip24then
.skipL0180
.L0181 ;  if _Fall_Gravity_Counter  >  24  &&  _Jump_Gravity_Counter  <=  32 then temp6  =  3

	LDA #24
	CMP _Fall_Gravity_Counter
     BCS .skipL0181
.condpart26
	LDA #32
	CMP _Jump_Gravity_Counter
     BCC .skip26then
.condpart27
	LDA #3
	STA temp6
.skip26then
.skipL0181
.L0182 ;  if _Fall_Gravity_Counter  >  32 then temp6  =  4

	LDA #32
	CMP _Fall_Gravity_Counter
     BCS .skipL0182
.condpart28
	LDA #4
	STA temp6
.skipL0182
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0183 ;  player1y  =  player1y  +  temp6

	LDA player1y
	CLC
	ADC temp6
	STA player1y
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0184 ;  _Bit2_Fall_in_Progress{2}  =  1

	LDA _Bit2_Fall_in_Progress
	ORA #4
	STA _Bit2_Fall_in_Progress
.
 ; 

.L0185 ;  goto __Skip_Fall_02

 jmp .__Skip_Fall_02

.
 ; 

.__Skip_Fall_01
 ; __Skip_Fall_01

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0186 ;  _Bit2_Fall_in_Progress{2}  =  0  :  _Fall_Gravity_Counter  =  0

	LDA _Bit2_Fall_in_Progress
	AND #251
	STA _Bit2_Fall_in_Progress
	LDA #0
	STA _Fall_Gravity_Counter
.
 ; 

.__Skip_Fall_02
 ; __Skip_Fall_02

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0187 ;  _Bit5_LR_Joy_Movement{5}  =  0

	LDA _Bit5_LR_Joy_Movement
	AND #223
	STA _Bit5_LR_Joy_Movement
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0188 ;  if !joy0left then goto __Skip_Joy0Left

 bit SWCHA
	BVC .skipL0188
.condpart29
 jmp .__Skip_Joy0Left

.skipL0188
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0189 ;  _Bit5_LR_Joy_Movement{5}  =  1

	LDA _Bit5_LR_Joy_Movement
	ORA #32
	STA _Bit5_LR_Joy_Movement
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0190 ;  if player1x  >  17 then _P1_Left_Right  =  _P1_Left_Right  -  1.38

	LDA #17
	CMP player1x
     BCS .skipL0190
.condpart30
	LDA a
	SEC 
	SBC #97
	STA a
	LDA _P1_Left_Right
	SBC #1
	STA _P1_Left_Right
.skipL0190
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0191 ;  _Bit4_Flip_P1{4}  =  0

	LDA _Bit4_Flip_P1
	AND #239
	STA _Bit4_Flip_P1
.
 ; 

.__Skip_Joy0Left
 ; __Skip_Joy0Left

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0192 ;  if !joy0right then goto __Skip_Joy0Right

 bit SWCHA
	BPL .skipL0192
.condpart31
 jmp .__Skip_Joy0Right

.skipL0192
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0193 ;  _Bit5_LR_Joy_Movement{5}  =  1

	LDA _Bit5_LR_Joy_Movement
	ORA #32
	STA _Bit5_LR_Joy_Movement
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0194 ;  if player1x  <  137 then _P1_Left_Right  =  _P1_Left_Right  +  1.38

	LDA player1x
	CMP #137
     BCS .skipL0194
.condpart32
	LDA a
	CLC 
	ADC #97
	STA a
	LDA _P1_Left_Right
	ADC #1
	STA _P1_Left_Right
.skipL0194
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0195 ;  _Bit4_Flip_P1{4}  =  1

	LDA _Bit4_Flip_P1
	ORA #16
	STA _Bit4_Flip_P1
.
 ; 

.__Skip_Joy0Right
 ; __Skip_Joy0Right

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0196 ;  if !_Bit5_LR_Joy_Movement{5} then goto __Done_Anim_jump

	LDA _Bit5_LR_Joy_Movement
	AND #32
	BNE .skipL0196
.condpart33
 jmp .__Done_Anim_jump

.skipL0196
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0197 ;  if _Jump_Gravity_Counter  ||  _Bit2_Fall_in_Progress{2} then goto __Done_Anim_jump

	LDA _Jump_Gravity_Counter
	BEQ .skipL0197
.condpart34
 jmp .condpart35
.skipL0197
	LDA _Bit2_Fall_in_Progress
	AND #4
	BEQ .skip9OR
.condpart35
 jmp .__Done_Anim_jump

.skip9OR
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0198 ;  if player1x  <  18  ||  player1x  >  136 then goto __Done_Anim_jump

	LDA player1x
	CMP #18
     BCS .skipL0198
.condpart36
 jmp .condpart37
.skipL0198
	LDA #136
	CMP player1x
     BCS .skip10OR
.condpart37
 jmp .__Done_Anim_jump

.skip10OR
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0199 ;  player1color:

	LDX #<playercolorL0199_1
	STX player1color
	LDA #>playercolorL0199_1
	STA player1color+1
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0200 ;  on _Frame_Counter goto __Frame0 __Frame1 __Frame0 __Frame2

	LDX _Frame_Counter
	LDA .L0200jumptablehi,x
	PHA
	LDA .L0200jumptablelo,x
	PHA
	RTS
.L0200jumptablehi
	.byte >(.__Frame0-1)
	.byte >(.__Frame1-1)
	.byte >(.__Frame0-1)
	.byte >(.__Frame2-1)
.L0200jumptablelo
	.byte <(.__Frame0-1)
	.byte <(.__Frame1-1)
	.byte <(.__Frame0-1)
	.byte <(.__Frame2-1)
.
 ; 

.__Done_Anim_jump
 ; __Done_Anim_jump

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0201 ;  if _Bit4_Flip_P1{4} then REFP1  =  8

	LDA _Bit4_Flip_P1
	AND #16
	BEQ .skipL0201
.condpart38
	LDA #8
	STA REFP1
.skipL0201
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0202 ;  if !_Ch0_Sound then goto __Skip_Ch_0

	LDA _Ch0_Sound
	BNE .skipL0202
.condpart39
 jmp .__Skip_Ch_0

.skipL0202
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0203 ;  _Ch0_Duration  =  _Ch0_Duration  -  1

	DEC _Ch0_Duration
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0204 ;  if _Ch0_Duration then goto __Skip_Ch_0

	LDA _Ch0_Duration
	BEQ .skipL0204
.condpart40
 jmp .__Skip_Ch_0

.skipL0204
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0205 ;  if _Ch0_Sound  <>  _c_Jump_Sound then goto __Skip_Ch0_Sound_001

	LDA _Ch0_Sound
	CMP #_c_Jump_Sound
     BEQ .skipL0205
.condpart41
 jmp .__Skip_Ch0_Sound_001

.skipL0205
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0206 ;  temp4  =  _SD_Jump[_Ch0_Counter]

	LDX _Ch0_Counter
	LDA _SD_Jump,x
	STA temp4
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0207 ;  if temp4  =  255 then goto __Clear_Ch_0

	LDA temp4
	CMP #255
     BNE .skipL0207
.condpart42
 jmp .__Clear_Ch_0

.skipL0207
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0208 ;  _Ch0_Counter  =  _Ch0_Counter  +  1

	INC _Ch0_Counter
.L0209 ;  temp5  =  _SD_Jump[_Ch0_Counter]  :  _Ch0_Counter  =  _Ch0_Counter  +  1

	LDX _Ch0_Counter
	LDA _SD_Jump,x
	STA temp5
	INC _Ch0_Counter
.L0210 ;  temp6  =  _SD_Jump[_Ch0_Counter]  :  _Ch0_Counter  =  _Ch0_Counter  +  1

	LDX _Ch0_Counter
	LDA _SD_Jump,x
	STA temp6
	INC _Ch0_Counter
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0211 ;  AUDV0  =  temp4

	LDA temp4
	STA AUDV0
.L0212 ;  AUDC0  =  temp5

	LDA temp5
	STA AUDC0
.L0213 ;  AUDF0  =  temp6

	LDA temp6
	STA AUDF0
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0214 ;  _Ch0_Duration  =  _SD_Jump[_Ch0_Counter]  :  _Ch0_Counter  =  _Ch0_Counter  +  1

	LDX _Ch0_Counter
	LDA _SD_Jump,x
	STA _Ch0_Duration
	INC _Ch0_Counter
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0215 ;  goto __Skip_Ch_0

 jmp .__Skip_Ch_0

.
 ; 

.__Skip_Ch0_Sound_001
 ; __Skip_Ch0_Sound_001

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0216 ;  goto __Skip_Ch_0

 jmp .__Skip_Ch_0

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Clear_Ch_0
 ; __Clear_Ch_0

.
 ; 

.L0217 ;  _Ch0_Sound  =  0  :  AUDV0  =  0

	LDA #0
	STA _Ch0_Sound
	STA AUDV0
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Skip_Ch_0
 ; __Skip_Ch_0

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0218 ;  drawscreen

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

.L0219 ;  if !switchreset then _Bit7_Reset_Restrainer{7}  =  0  :  goto __Main_Loop

 lda #1
 bit SWCHB
	BEQ .skipL0219
.condpart43
	LDA _Bit7_Reset_Restrainer
	AND #127
	STA _Bit7_Reset_Restrainer
 jmp .__Main_Loop

.skipL0219
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0220 ;  if _Bit7_Reset_Restrainer{7} then goto __Main_Loop

	BIT _Bit7_Reset_Restrainer
	BPL .skipL0220
.condpart44
 jmp .__Main_Loop

.skipL0220
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0221 ;  goto __Start_Restart

 jmp .__Start_Restart

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0222 ;  data _SD_Jump

	JMP .skipL0222
_SD_Jump
	.byte    1,12,31

	.byte    1

	.byte    8,12,31

	.byte    1

	.byte    6,12,31

	.byte    1

	.byte    8,12,31

	.byte    1

	.byte    8,12,30

	.byte    1

	.byte    8,12,29

	.byte    1

	.byte    8,12,28

	.byte    1

	.byte    8,12,27

	.byte    1

	.byte    8,12,26

	.byte    1

	.byte    8,12,25

	.byte    1

	.byte    8,12,24

	.byte    1

	.byte    8,12,23

	.byte    1

	.byte    8,12,22

	.byte    1

	.byte    8,12,21

	.byte    1

	.byte    8,12,20

	.byte    1

	.byte    8,12,19

	.byte    1

	.byte    6,12,18

	.byte    1

	.byte    4,12,17

	.byte    1

	.byte    2,12,16

	.byte    2

	.byte    0,0,0

	.byte    8

	.byte    255

.skipL0222
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Frame0
 ; __Frame0

.L0223 ;  player1:

	LDX #<playerL0223_1
	STX player1pointerlo
	LDA #>playerL0223_1
	STA player1pointerhi
	LDA #9
	STA player1height
.
 ; 

.L0224 ;  goto __Done_Anim_jump

 jmp .__Done_Anim_jump

.
 ; 

.
 ; 

.__Frame1
 ; __Frame1

.L0225 ;  player1:

	LDX #<playerL0225_1
	STX player1pointerlo
	LDA #>playerL0225_1
	STA player1pointerhi
	LDA #9
	STA player1height
.
 ; 

.L0226 ;  goto __Done_Anim_jump

 jmp .__Done_Anim_jump

.
 ; 

.
 ; 

.__Frame2
 ; __Frame2

.L0227 ;  player1:

	LDX #<playerL0227_1
	STX player1pointerlo
	LDA #>playerL0227_1
	STA player1pointerhi
	LDA #9
	STA player1height
.
 ; 

.L0228 ;  goto __Done_Anim_jump
 jmp .__Done_Anim_jump
 if (<*) > (<(*+9))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playercolorL0157_1
	.byte    _26
	.byte    _9C
	.byte    _9C
	.byte    _9C
	.byte    _DA
	.byte    _DA
	.byte    _3C
	.byte    _3C
	.byte    _3C
	.byte    _26
 if (<*) > (<(*+9))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0158_1
	.byte    %01100110
	.byte    %00100100
	.byte    %00111100
	.byte    %00011000
	.byte    %01011010
	.byte    %00111100
	.byte    %00011000
	.byte    %00111100
	.byte    %00111100
	.byte    %00011000
 if (<*) > (<(*+9))
	repeat ($100-<*)
	.byte 0
	repend
	endif
player3then_1
	.byte    %11000011
	.byte    %01100011
	.byte    %00111110
	.byte    %00011100
	.byte    %00111101
	.byte    %01011110
	.byte    %00011000
	.byte    %00111100
	.byte    %00111100
	.byte    %00011000
 if (<*) > (<(*+9))
	repeat ($100-<*)
	.byte 0
	repend
	endif
player6then_1
	.byte    %01100110
	.byte    %00100100
	.byte    %00111100
	.byte    %00011000
	.byte    %00011000
	.byte    %01111110
	.byte    %10011001
	.byte    %00111100
	.byte    %00111100
	.byte    %00011000
 if (<*) > (<(*+9))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0175_1
	.byte    %11000011
	.byte    %01100011
	.byte    %00111110
	.byte    %00011100
	.byte    %00111101
	.byte    %01011110
	.byte    %00011000
	.byte    %00111100
	.byte    %00111100
	.byte    %00011000
 if (<*) > (<(*+9))
	repeat ($100-<*)
	.byte 0
	repend
	endif
player21then_1
	.byte    %01100110
	.byte    %00100100
	.byte    %00111100
	.byte    %00011000
	.byte    %00011000
	.byte    %01111110
	.byte    %10011001
	.byte    %00111100
	.byte    %00111100
	.byte    %00011000
 if (<*) > (<(*+9))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playercolorL0199_1
	.byte    _26
	.byte    _9C
	.byte    _9C
	.byte    _9C
	.byte    _DA
	.byte    _DA
	.byte    _3C
	.byte    _3C
	.byte    _3C
	.byte    _26
 if (<*) > (<(*+9))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0223_1
	.byte    %01100110
	.byte    %00100110
	.byte    %00111100
	.byte    %00011100
	.byte    %00111100
	.byte    %00011100
	.byte    %00011000
	.byte    %00111100
	.byte    %00111100
	.byte    %00011000
 if (<*) > (<(*+9))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0225_1
	.byte    %11000011
	.byte    %01100011
	.byte    %00111110
	.byte    %00011100
	.byte    %00111100
	.byte    %01011110
	.byte    %00011000
	.byte    %00111100
	.byte    %00111100
	.byte    %00011000
 if (<*) > (<(*+9))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0227_1
	.byte    %00111100
	.byte    %00011100
	.byte    %00011100
	.byte    %00011100
	.byte    %00011100
	.byte    %00011100
	.byte    %00011000
	.byte    %00111100
	.byte    %00111100
	.byte    %00011000
 if ECHOFIRST
       echo "    ",[(scoretable - *)]d , "bytes of ROM space left")
 endif 
ECHOFIRST = 1
 
 
 
