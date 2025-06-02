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

.L01 ;  set romsize 16k

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L02 ;  set optimization inlinerand

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L03 ;  dim _XRoom  =  a

.L04 ;  dim _YRoom  =  b

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L05 ;  dim _CurrentScene  =  c

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L06 ;  dim _TS_Slowdown  =  c

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L07 ;  dim _VisitedRooms  =  d

.L08 ;  dim _Row1Visited  =  e

.L09 ;  dim _Row2Visited  =  f

.L010 ;  dim _Row3Visited  =  g

.L011 ;  dim _Row4Visited  =  h

.L012 ;  dim _Row5Visited  =  i

.L013 ;  dim _Row6Visited  =  j

.L014 ;  dim _Row7Visited  =  k

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L015 ;  dim _Temp  =  l

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L016 ;  dim _Master_Counter  =  m

.L017 ;  dim _Frame_Counter  =  n

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L018 ;  dim _BitOp_01  =  o

.L019 ;  dim _Bit0_Reset_Restrainer  =  o

.L020 ;  dim _Bit1_Next_Room_Up  =  o

.L021 ;  dim _Bit2_Next_Room_Down  =  o

.L022 ;  dim _Bit3_Next_Room_Left  =  o

.L023 ;  dim _Bit4_Next_Room_Right  =  o

.L024 ;  dim _Bit5_UD_Joy_Movement  =  o

.L025 ;  dim _Bit6_LR_Joy_Movement  =  o

.L026 ;  dim _Bit7_Over_Under  =  o

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L027 ;  dim _P1_Left_Right  =  player1x.p

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L028 ;  dim _P1_Up_Down  =  player1y.q

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L029 ;  dim _RoomRand  =  y

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L030 ;  dim rand16  =  z

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L031 ;  dim _sc1  =  score

.L032 ;  dim _sc2  =  score + 1

.L033 ;  dim _sc3  =  score + 2

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L034 ;  const _c_Edge_Top  =  10

.L035 ;  const _c_Edge_Bottom  =  88

.L036 ;  const _c_Edge_Left  =  2

.L037 ;  const _c_Edge_Right  =  153

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L038 ;  const _c_World_Limit_Top  =  0

.L039 ;  const _c_World_Limit_Bottom  =  7

.L040 ;  const _c_World_Limit_Left  =  0

.L041 ;  const _c_World_Limit_Right  =  7

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L042 ;  const _00  =  $00

.L043 ;  const _02  =  $02

.L044 ;  const _04  =  $04

.L045 ;  const _06  =  $06

.L046 ;  const _08  =  $08

.L047 ;  const _0A  =  $0A

.L048 ;  const _0C  =  $0C

.L049 ;  const _0E  =  $0E

.L050 ;  const _10  =  $10

.L051 ;  const _12  =  $12

.L052 ;  const _14  =  $14

.L053 ;  const _16  =  $16

.L054 ;  const _18  =  $18

.L055 ;  const _1A  =  $1A

.L056 ;  const _1C  =  $1C

.L057 ;  const _1E  =  $1E

.L058 ;  const _20  =  $20

.L059 ;  const _22  =  $22

.L060 ;  const _24  =  $24

.L061 ;  const _26  =  $26

.L062 ;  const _28  =  $28

.L063 ;  const _2A  =  $2A

.L064 ;  const _2C  =  $2C

.L065 ;  const _2E  =  $2E

.L066 ;  const _30  =  $30

.L067 ;  const _32  =  $32

.L068 ;  const _34  =  $34

.L069 ;  const _36  =  $36

.L070 ;  const _38  =  $38

.L071 ;  const _3A  =  $3A

.L072 ;  const _3C  =  $3C

.L073 ;  const _3E  =  $3E

.L074 ;  const _40  =  $40

.L075 ;  const _42  =  $42

.L076 ;  const _44  =  $44

.L077 ;  const _46  =  $46

.L078 ;  const _48  =  $48

.L079 ;  const _4A  =  $4A

.L080 ;  const _4C  =  $4C

.L081 ;  const _4E  =  $4E

.L082 ;  const _50  =  $50

.L083 ;  const _52  =  $52

.L084 ;  const _54  =  $54

.L085 ;  const _56  =  $56

.L086 ;  const _58  =  $58

.L087 ;  const _5A  =  $5A

.L088 ;  const _5C  =  $5C

.L089 ;  const _5E  =  $5E

.L090 ;  const _60  =  $60

.L091 ;  const _62  =  $62

.L092 ;  const _64  =  $64

.L093 ;  const _66  =  $66

.L094 ;  const _68  =  $68

.L095 ;  const _6A  =  $6A

.L096 ;  const _6C  =  $6C

.L097 ;  const _6E  =  $6E

.L098 ;  const _70  =  $70

.L099 ;  const _72  =  $72

.L0100 ;  const _74  =  $74

.L0101 ;  const _76  =  $76

.L0102 ;  const _78  =  $78

.L0103 ;  const _7A  =  $7A

.L0104 ;  const _7C  =  $7C

.L0105 ;  const _7E  =  $7E

.L0106 ;  const _80  =  $80

.L0107 ;  const _82  =  $82

.L0108 ;  const _84  =  $84

.L0109 ;  const _86  =  $86

.L0110 ;  const _88  =  $88

.L0111 ;  const _8A  =  $8A

.L0112 ;  const _8C  =  $8C

.L0113 ;  const _8E  =  $8E

.L0114 ;  const _90  =  $90

.L0115 ;  const _92  =  $92

.L0116 ;  const _94  =  $94

.L0117 ;  const _96  =  $96

.L0118 ;  const _98  =  $98

.L0119 ;  const _9A  =  $9A

.L0120 ;  const _9C  =  $9C

.L0121 ;  const _9E  =  $9E

.L0122 ;  const _A0  =  $A0

.L0123 ;  const _A2  =  $A2

.L0124 ;  const _A4  =  $A4

.L0125 ;  const _A6  =  $A6

.L0126 ;  const _A8  =  $A8

.L0127 ;  const _AA  =  $AA

.L0128 ;  const _AC  =  $AC

.L0129 ;  const _AE  =  $AE

.L0130 ;  const _B0  =  $B0

.L0131 ;  const _B2  =  $B2

.L0132 ;  const _B4  =  $B4

.L0133 ;  const _B6  =  $B6

.L0134 ;  const _B8  =  $B8

.L0135 ;  const _BA  =  $BA

.L0136 ;  const _BC  =  $BC

.L0137 ;  const _BE  =  $BE

.L0138 ;  const _C0  =  $C0

.L0139 ;  const _C2  =  $C2

.L0140 ;  const _C4  =  $C4

.L0141 ;  const _C6  =  $C6

.L0142 ;  const _C8  =  $C8

.L0143 ;  const _CA  =  $CA

.L0144 ;  const _CC  =  $CC

.L0145 ;  const _CE  =  $CE

.L0146 ;  const _D0  =  $D0

.L0147 ;  const _D2  =  $D2

.L0148 ;  const _D4  =  $D4

.L0149 ;  const _D6  =  $D6

.L0150 ;  const _D8  =  $D8

.L0151 ;  const _DA  =  $DA

.L0152 ;  const _DC  =  $DC

.L0153 ;  const _DE  =  $DE

.L0154 ;  const _E0  =  $E0

.L0155 ;  const _E2  =  $E2

.L0156 ;  const _E4  =  $E4

.L0157 ;  const _E6  =  $E6

.L0158 ;  const _E8  =  $E8

.L0159 ;  const _EA  =  $EA

.L0160 ;  const _EC  =  $EC

.L0161 ;  const _EE  =  $EE

.L0162 ;  const _F0  =  $F0

.L0163 ;  const _F2  =  $F2

.L0164 ;  const _F4  =  $F4

.L0165 ;  const _F6  =  $F6

.L0166 ;  const _F8  =  $F8

.L0167 ;  const _FA  =  $FA

.L0168 ;  const _FC  =  $FC

.L0169 ;  const _FE  =  $FE

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
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

.L0170 ;  AUDV0  =  0  :  AUDV1  =  0

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

.L0171 ;  player1y  =  150  :  player0y  =  150

	LDA #150
	STA player1y
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

.L0172 ;  lifecolor  =  _8A  :  lives  =  0

	LDA #_8A
	STA lifecolor
	LDA #0
	STA lives
.
 ; 

.L0173 ;  lives:

	LDA #<lives__L0173
	STA lifepointer
	LDA lifepointer+1
	AND #$E0
	ORA #(>lives__L0173)&($1F)
	STA lifepointer+1
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0174 ;  a  =  0  :  b  =  0  :  c  =  0  :  d  =  0  :  e  =  0  :  f  =  0  :  g  =  0  :  h  =  0  :  i  =  0

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
.L0175 ;  j  =  0  :  k  =  0  :  l  =  0  :  m  =  0  :  n  =  0  :  o  =  0  :  p  =  0  :  q  =  0  :  r  =  0

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
.L0176 ;  s  =  0  :  t  =  0  :  u  =  0  :  v  =  0  :  w  =  0  :  x  =  0

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

.
 ; 

.
 ; 

.
 ; 

.__Title_Screen_Setup
 ; __Title_Screen_Setup

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0177 ;  scorecolor  =  _1C

	LDA #_1C
	STA scorecolor
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0178 ;  score  =  0  :  _RoomRand  =  0

	LDA #$00
	STA score+2
	LDA #$00
	STA score+1
	LDA #$00
	STA score
	LDA #0
	STA _RoomRand
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0179 ;  COLUBK  =  _00

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

.L0180 ;  COLUPF  =  _08

	LDA #_08
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

.L0181 ;  _Bit0_Reset_Restrainer{0}  =  1

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

.L0182 ;  playfield:

  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel0
PF_data0
	.byte %01111101, %00110111
	if (pfwidth>2)
	.byte %01111011, %01111011
 endif
	.byte %01100001, %00110001
	if (pfwidth>2)
	.byte %01100011, %00110000
 endif
	.byte %01111101, %00110111
	if (pfwidth>2)
	.byte %01111011, %00110000
 endif
	.byte %00001101, %00110001
	if (pfwidth>2)
	.byte %01100011, %00110000
 endif
	.byte %01111101, %11110111
	if (pfwidth>2)
	.byte %01111011, %00110011
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %11111011, %01111011
	if (pfwidth>2)
	.byte %11111000, %00110110
 endif
	.byte %11000011, %00011000
	if (pfwidth>2)
	.byte %11001100, %01111111
 endif
	.byte %11111011, %01111011
	if (pfwidth>2)
	.byte %11001100, %00110110
 endif
	.byte %00011011, %00011000
	if (pfwidth>2)
	.byte %11001100, %01111111
 endif
	.byte %11111011, %01111011
	if (pfwidth>2)
	.byte %11111000, %00110110
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

.__Title_Screen_Loop
 ; __Title_Screen_Loop

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0183 ;  _Master_Counter  =  _Master_Counter  +  1

	INC _Master_Counter
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0184 ;  if _Master_Counter  <  _TS_Slowdown then goto __Skip_TS_Counter

	LDA _Master_Counter
	CMP _TS_Slowdown
     BCS .skipL0184
.condpart0
 jmp .__Skip_TS_Counter

.skipL0184
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0185 ;  if joy0right  &&  _RoomRand  <  255 then score  =  score  +  1  :  _RoomRand  =  _RoomRand  +  1  :  _TS_Slowdown  =  11

 bit SWCHA
	BMI .skipL0185
.condpart1
	LDA _RoomRand
	CMP #255
     BCS .skip1then
.condpart2
	SED
	CLC
	LDA score+2
	ADC #$01
	STA score+2
	LDA score+1
	ADC #$00
	STA score+1
	LDA score
	ADC #$00
	STA score
	CLD
	INC _RoomRand
	LDA #11
	STA _TS_Slowdown
.skip1then
.skipL0185
.L0186 ;  if joy0left  &&  _RoomRand  >  0 then score  =  score  -  1  :  _RoomRand  =  _RoomRand  -  1  :  _TS_Slowdown  =  11

 bit SWCHA
	BVS .skipL0186
.condpart3
	LDA #0
	CMP _RoomRand
     BCS .skip3then
.condpart4
	SED
	SEC
	LDA score+2
	SBC #$01
	STA score+2
	LDA score+1
	SBC #$00
	STA score+1
	LDA score
	SBC #$00
	STA score
	CLD
	DEC _RoomRand
	LDA #11
	STA _TS_Slowdown
.skip3then
.skipL0186
.L0187 ;  if joy0up  &&  _RoomRand  <  255 then score  =  score  +  1  :  _RoomRand  =  _RoomRand  +  1  :  _TS_Slowdown  =  2

 lda #$10
 bit SWCHA
	BNE .skipL0187
.condpart5
	LDA _RoomRand
	CMP #255
     BCS .skip5then
.condpart6
	SED
	CLC
	LDA score+2
	ADC #$01
	STA score+2
	LDA score+1
	ADC #$00
	STA score+1
	LDA score
	ADC #$00
	STA score
	CLD
	INC _RoomRand
	LDA #2
	STA _TS_Slowdown
.skip5then
.skipL0187
.L0188 ;  if joy0down  &&  _RoomRand  >  0 then score  =  score  -  1  :  _RoomRand  =  _RoomRand  -  1  :  _TS_Slowdown  =  2

 lda #$20
 bit SWCHA
	BNE .skipL0188
.condpart7
	LDA #0
	CMP _RoomRand
     BCS .skip7then
.condpart8
	SED
	SEC
	LDA score+2
	SBC #$01
	STA score+2
	LDA score+1
	SBC #$00
	STA score+1
	LDA score
	SBC #$00
	STA score
	CLD
	DEC _RoomRand
	LDA #2
	STA _TS_Slowdown
.skip7then
.skipL0188
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0189 ;  _Master_Counter  =  0

	LDA #0
	STA _Master_Counter
.
 ; 

.__Skip_TS_Counter
 ; __Skip_TS_Counter

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0190 ;  drawscreen

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

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0191 ;  if !switchreset  &&  !joy0fire then _Bit0_Reset_Restrainer{0}  =  0  :  goto __Title_Screen_Loop

 lda #1
 bit SWCHB
	BEQ .skipL0191
.condpart9
 bit INPT4
	BPL .skip9then
.condpart10
	LDA _Bit0_Reset_Restrainer
	AND #254
	STA _Bit0_Reset_Restrainer
 jmp .__Title_Screen_Loop

.skip9then
.skipL0191
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0192 ;  if _Bit0_Reset_Restrainer{0} then goto __Title_Screen_Loop

	LDA _Bit0_Reset_Restrainer
	LSR
	BCC .skipL0192
.condpart11
 jmp .__Title_Screen_Loop

.skipL0192
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0193 ;  goto __Main_Loop_Setup

 jmp .__Main_Loop_Setup

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
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

.L0194 ;  player1x  =  17  :  player1y  =  15

	LDA #17
	STA player1x
	LDA #15
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

.L0195 ;  _Bit0_Reset_Restrainer{0}  =  1

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

.
 ; 

.
 ; 

.
 ; 

.L0196 ;  if _RoomRand then goto __Skip_Rand_World

	LDA _RoomRand
	BEQ .skipL0196
.condpart12
 jmp .__Skip_Rand_World

.skipL0196
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0197 ;  _RoomRand  =  rand  :  if !_RoomRand then _RoomRand  =  1

        lda rand
        lsr
 ifconst rand16
        rol rand16
 endif
        bcc *+4
        eor #$B4
        sta rand
 ifconst rand16
        eor rand16
 endif
	STA _RoomRand
	LDA _RoomRand
	BNE .skipL0197
.condpart13
	LDA #1
	STA _RoomRand
.skipL0197
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0198 ;  temp4  =  _RoomRand

	LDA _RoomRand
	STA temp4
.
 ; 

.L0199 ;  _sc2  =  _sc2  &  240  :  _sc3  =  0

	LDA _sc2
	AND #240
	STA _sc2
	LDA #0
	STA _sc3
.L0200 ;  if temp4  >=  100 then _sc2  =  _sc2  +  1  :  temp4  =  temp4  -  100

	LDA temp4
	CMP #100
     BCC .skipL0200
.condpart14
	INC _sc2
	LDA temp4
	SEC
	SBC #100
	STA temp4
.skipL0200
.L0201 ;  if temp4  >=  100 then _sc2  =  _sc2  +  1  :  temp4  =  temp4  -  100

	LDA temp4
	CMP #100
     BCC .skipL0201
.condpart15
	INC _sc2
	LDA temp4
	SEC
	SBC #100
	STA temp4
.skipL0201
.L0202 ;  if temp4  >=  50 then _sc3  =  _sc3  +  80  :  temp4  =  temp4  -  50

	LDA temp4
	CMP #50
     BCC .skipL0202
.condpart16
	LDA _sc3
	CLC
	ADC #80
	STA _sc3
	LDA temp4
	SEC
	SBC #50
	STA temp4
.skipL0202
.L0203 ;  if temp4  >=  30 then _sc3  =  _sc3  +  48  :  temp4  =  temp4  -  30

	LDA temp4
	CMP #30
     BCC .skipL0203
.condpart17
	LDA _sc3
	CLC
	ADC #48
	STA _sc3
	LDA temp4
	SEC
	SBC #30
	STA temp4
.skipL0203
.L0204 ;  if temp4  >=  20 then _sc3  =  _sc3  +  32  :  temp4  =  temp4  -  20

	LDA temp4
	CMP #20
     BCC .skipL0204
.condpart18
	LDA _sc3
	CLC
	ADC #32
	STA _sc3
	LDA temp4
	SEC
	SBC #20
	STA temp4
.skipL0204
.L0205 ;  if temp4  >=  10 then _sc3  =  _sc3  +  16  :  temp4  =  temp4  -  10

	LDA temp4
	CMP #10
     BCC .skipL0205
.condpart19
	LDA _sc3
	CLC
	ADC #16
	STA _sc3
	LDA temp4
	SEC
	SBC #10
	STA temp4
.skipL0205
.L0206 ;  _sc3  =  _sc3  |  temp4

	LDA _sc3
	ORA temp4
	STA _sc3
.
 ; 

.__Skip_Rand_World
 ; __Skip_Rand_World

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0207 ;  goto __Special_Rand bank2

 sta temp7
 lda #>(.__Special_Rand-1)
 pha
 lda #<(.__Special_Rand-1)
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

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0208 ;  _Master_Counter  =  _Master_Counter  +  1

	INC _Master_Counter
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0209 ;  if _Master_Counter  <  5 then goto __Skip_Frame_Counter

	LDA _Master_Counter
	CMP #5
     BCS .skipL0209
.condpart20
 jmp .__Skip_Frame_Counter

.skipL0209
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0210 ;  _Frame_Counter  =  _Frame_Counter  +  1

	INC _Frame_Counter
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0211 ;  _Master_Counter  =  0

	LDA #0
	STA _Master_Counter
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0212 ;  if _Frame_Counter  =  4 then _Frame_Counter  =  0

	LDA _Frame_Counter
	CMP #4
     BNE .skipL0212
.condpart21
	LDA #0
	STA _Frame_Counter
.skipL0212
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

.L0213 ;  _Bit5_UD_Joy_Movement{5}  =  0  :  _Bit6_LR_Joy_Movement{6}  =  0  :  _Bit1_Next_Room_Up{1}  =  0  :  _Bit2_Next_Room_Down{2}  =  0  :  _Bit3_Next_Room_Left{3}  =  0  :  _Bit4_Next_Room_Right{4}  =  0

	LDA _Bit5_UD_Joy_Movement
	AND #223
	STA _Bit5_UD_Joy_Movement
	LDA _Bit6_LR_Joy_Movement
	AND #191
	STA _Bit6_LR_Joy_Movement
	LDA _Bit1_Next_Room_Up
	AND #253
	STA _Bit1_Next_Room_Up
	LDA _Bit2_Next_Room_Down
	AND #251
	STA _Bit2_Next_Room_Down
	LDA _Bit3_Next_Room_Left
	AND #247
	STA _Bit3_Next_Room_Left
	LDA _Bit4_Next_Room_Right
	AND #239
	STA _Bit4_Next_Room_Right
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0214 ;  player1color:

	LDX #<playercolorL0214_1
	STX player1color
	LDA #>playercolorL0214_1
	STA player1color+1
.
 ; 

.L0215 ;  player1:

	LDX #<playerL0215_1
	STX player1pointerlo
	LDA #>playerL0215_1
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

.L0216 ;  if !joy0up then goto __Skip_Joy0_Up

 lda #$10
 bit SWCHA
	BEQ .skipL0216
.condpart22
 jmp .__Skip_Joy0_Up

.skipL0216
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0217 ;  temp5  =   ( player1x - 11 )  / 4

; complex statement detected
	LDA player1x
	SEC
	SBC #11
	lsr
	lsr
	STA temp5
.
 ; 

.L0218 ;  temp6  =   ( player1y - 11 )  / 8

; complex statement detected
	LDA player1y
	SEC
	SBC #11
	lsr
	lsr
	lsr
	STA temp6
.
 ; 

.L0219 ;  if temp5  <  32 then if pfread ( temp5 , temp6 )  then goto __Skip_Joy0_Up

	LDA temp5
	CMP #32
     BCS .skipL0219
.condpart23
	LDA temp5
	LDY temp6
 sta temp7
 lda #>(ret_point2-1)
 pha
 lda #<(ret_point2-1)
 pha
 lda #>(pfread-1)
 pha
 lda #<(pfread-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point2
	BNE .skip23then
.condpart24
 jmp .__Skip_Joy0_Up

.skip23then
.skipL0219
.
 ; 

.L0220 ;  temp4  =   ( player1x - 16 )  / 4

; complex statement detected
	LDA player1x
	SEC
	SBC #16
	lsr
	lsr
	STA temp4
.
 ; 

.L0221 ;  if temp4  <  32 then if pfread ( temp4 , temp6 )  then goto __Skip_Joy0_Up

	LDA temp4
	CMP #32
     BCS .skipL0221
.condpart25
	LDA temp4
	LDY temp6
 sta temp7
 lda #>(ret_point3-1)
 pha
 lda #<(ret_point3-1)
 pha
 lda #>(pfread-1)
 pha
 lda #<(pfread-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point3
	BNE .skip25then
.condpart26
 jmp .__Skip_Joy0_Up

.skip25then
.skipL0221
.
 ; 

.L0222 ;  temp3  =  temp5  -  1

	LDA temp5
	SEC
	SBC #1
	STA temp3
.
 ; 

.L0223 ;  if temp3  <  32 then if pfread ( temp3 , temp6 )  then goto __Skip_Joy0_Up

	LDA temp3
	CMP #32
     BCS .skipL0223
.condpart27
	LDA temp3
	LDY temp6
 sta temp7
 lda #>(ret_point4-1)
 pha
 lda #<(ret_point4-1)
 pha
 lda #>(pfread-1)
 pha
 lda #<(pfread-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point4
	BNE .skip27then
.condpart28
 jmp .__Skip_Joy0_Up

.skip27then
.skipL0223
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0224 ;  _Bit5_UD_Joy_Movement{5}  =  1

	LDA _Bit5_UD_Joy_Movement
	ORA #32
	STA _Bit5_UD_Joy_Movement
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0225 ;  _P1_Up_Down  =  _P1_Up_Down  -  1.18

	LDA q
	SEC 
	SBC #46
	STA q
	LDA _P1_Up_Down
	SBC #1
	STA _P1_Up_Down
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0226 ;  player1color:

	LDX #<playercolorL0226_1
	STX player1color
	LDA #>playercolorL0226_1
	STA player1color+1
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0227 ;  if player1y  >=  _c_Edge_Top then goto __Skip_Joy0_Up

	LDA player1y
	CMP #_c_Edge_Top
     BCC .skipL0227
.condpart29
 jmp .__Skip_Joy0_Up

.skipL0227
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0228 ;  if _YRoom  =  _c_World_Limit_Top then player1y  =  _c_Edge_Top  :  goto __Skip_Joy0_Up

	LDA _YRoom
	CMP #_c_World_Limit_Top
     BNE .skipL0228
.condpart30
	LDA #_c_Edge_Top
	STA player1y
 jmp .__Skip_Joy0_Up

.skipL0228
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0229 ;  player1y  =  _c_Edge_Bottom

	LDA #_c_Edge_Bottom
	STA player1y
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0230 ;  _YRoom  =  _YRoom  -  1

	DEC _YRoom
.
 ; 

.L0231 ;  _Bit1_Next_Room_Up{1}  =  1

	LDA _Bit1_Next_Room_Up
	ORA #2
	STA _Bit1_Next_Room_Up
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

.L0232 ;  if !joy0down then goto __Skip_Joy0_Down

 lda #$20
 bit SWCHA
	BEQ .skipL0232
.condpart31
 jmp .__Skip_Joy0_Down

.skipL0232
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0233 ;  temp5  =   ( player1x - 11 )  / 4

; complex statement detected
	LDA player1x
	SEC
	SBC #11
	lsr
	lsr
	STA temp5
.
 ; 

.L0234 ;  temp6  =   ( player1y + 1 )  / 8

; complex statement detected
	LDA player1y
	CLC
	ADC #1
	lsr
	lsr
	lsr
	STA temp6
.
 ; 

.L0235 ;  if temp5  <  32 then if pfread ( temp5 , temp6 )  then goto __Skip_Joy0_Down

	LDA temp5
	CMP #32
     BCS .skipL0235
.condpart32
	LDA temp5
	LDY temp6
 sta temp7
 lda #>(ret_point5-1)
 pha
 lda #<(ret_point5-1)
 pha
 lda #>(pfread-1)
 pha
 lda #<(pfread-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point5
	BNE .skip32then
.condpart33
 jmp .__Skip_Joy0_Down

.skip32then
.skipL0235
.
 ; 

.L0236 ;  temp4  =   ( player1x - 16 )  / 4

; complex statement detected
	LDA player1x
	SEC
	SBC #16
	lsr
	lsr
	STA temp4
.
 ; 

.L0237 ;  if temp4  <  32 then if pfread ( temp4 , temp6 )  then goto __Skip_Joy0_Down

	LDA temp4
	CMP #32
     BCS .skipL0237
.condpart34
	LDA temp4
	LDY temp6
 sta temp7
 lda #>(ret_point6-1)
 pha
 lda #<(ret_point6-1)
 pha
 lda #>(pfread-1)
 pha
 lda #<(pfread-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point6
	BNE .skip34then
.condpart35
 jmp .__Skip_Joy0_Down

.skip34then
.skipL0237
.
 ; 

.L0238 ;  temp3  =  temp5  -  1

	LDA temp5
	SEC
	SBC #1
	STA temp3
.
 ; 

.L0239 ;  if temp3  <  32 then if pfread ( temp3 , temp6 )  then goto __Skip_Joy0_Down

	LDA temp3
	CMP #32
     BCS .skipL0239
.condpart36
	LDA temp3
	LDY temp6
 sta temp7
 lda #>(ret_point7-1)
 pha
 lda #<(ret_point7-1)
 pha
 lda #>(pfread-1)
 pha
 lda #<(pfread-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point7
	BNE .skip36then
.condpart37
 jmp .__Skip_Joy0_Down

.skip36then
.skipL0239
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0240 ;  _Bit5_UD_Joy_Movement{5}  =  1

	LDA _Bit5_UD_Joy_Movement
	ORA #32
	STA _Bit5_UD_Joy_Movement
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0241 ;  _P1_Up_Down  =  _P1_Up_Down  +  1.18

	LDA q
	CLC 
	ADC #46
	STA q
	LDA _P1_Up_Down
	ADC #1
	STA _P1_Up_Down
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0242 ;  if player1y  <=  _c_Edge_Bottom then goto __Skip_Joy0_Down

	LDA #_c_Edge_Bottom
	CMP player1y
     BCC .skipL0242
.condpart38
 jmp .__Skip_Joy0_Down

.skipL0242
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0243 ;  if _YRoom  =  _c_World_Limit_Bottom then player1y  =  _c_Edge_Bottom  :  goto __Skip_Joy0_Down

	LDA _YRoom
	CMP #_c_World_Limit_Bottom
     BNE .skipL0243
.condpart39
	LDA #_c_Edge_Bottom
	STA player1y
 jmp .__Skip_Joy0_Down

.skipL0243
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0244 ;  player1y  =  _c_Edge_Top

	LDA #_c_Edge_Top
	STA player1y
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0245 ;  _YRoom  =  _YRoom  +  1

	INC _YRoom
.
 ; 

.L0246 ;  _Bit2_Next_Room_Down{2}  =  1

	LDA _Bit2_Next_Room_Down
	ORA #4
	STA _Bit2_Next_Room_Down
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

.L0247 ;  if !joy0left then goto __Skip_Joy0_Left

 bit SWCHA
	BVC .skipL0247
.condpart40
 jmp .__Skip_Joy0_Left

.skipL0247
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0248 ;  temp5  =   ( player1y - 1 )  / 8

; complex statement detected
	LDA player1y
	SEC
	SBC #1
	lsr
	lsr
	lsr
	STA temp5
.
 ; 

.L0249 ;  temp6  =   ( player1x - 18 )  / 4

; complex statement detected
	LDA player1x
	SEC
	SBC #18
	lsr
	lsr
	STA temp6
.
 ; 

.L0250 ;  if temp6  <  32 then if pfread ( temp6 , temp5 )  then goto __Skip_Joy0_Left

	LDA temp6
	CMP #32
     BCS .skipL0250
.condpart41
	LDA temp6
	LDY temp5
 sta temp7
 lda #>(ret_point8-1)
 pha
 lda #<(ret_point8-1)
 pha
 lda #>(pfread-1)
 pha
 lda #<(pfread-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point8
	BNE .skip41then
.condpart42
 jmp .__Skip_Joy0_Left

.skip41then
.skipL0250
.
 ; 

.L0251 ;  temp3  =   ( player1y - 9 )  / 8

; complex statement detected
	LDA player1y
	SEC
	SBC #9
	lsr
	lsr
	lsr
	STA temp3
.
 ; 

.L0252 ;  if temp6  <  32 then if pfread ( temp6 , temp3 )  then goto __Skip_Joy0_Left

	LDA temp6
	CMP #32
     BCS .skipL0252
.condpart43
	LDA temp6
	LDY temp3
 sta temp7
 lda #>(ret_point9-1)
 pha
 lda #<(ret_point9-1)
 pha
 lda #>(pfread-1)
 pha
 lda #<(pfread-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point9
	BNE .skip43then
.condpart44
 jmp .__Skip_Joy0_Left

.skip43then
.skipL0252
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0253 ;  _Bit6_LR_Joy_Movement{6}  =  1

	LDA _Bit6_LR_Joy_Movement
	ORA #64
	STA _Bit6_LR_Joy_Movement
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0254 ;  _P1_Left_Right  =  _P1_Left_Right  -  1.48

	LDA p
	SEC 
	SBC #122
	STA p
	LDA _P1_Left_Right
	SBC #1
	STA _P1_Left_Right
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0255 ;  REFP1  =  0

	LDA #0
	STA REFP1
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0256 ;  if player1x  >=  _c_Edge_Left then goto __Skip_Joy0_Left

	LDA player1x
	CMP #_c_Edge_Left
     BCC .skipL0256
.condpart45
 jmp .__Skip_Joy0_Left

.skipL0256
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0257 ;  if _XRoom  =  _c_World_Limit_Left then player1x  =  _c_Edge_Left  :  goto __Skip_Joy0_Left

	LDA _XRoom
	CMP #_c_World_Limit_Left
     BNE .skipL0257
.condpart46
	LDA #_c_Edge_Left
	STA player1x
 jmp .__Skip_Joy0_Left

.skipL0257
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0258 ;  if _Bit1_Next_Room_Up{1} then goto __Skip_Joy0_Left

	LDA _Bit1_Next_Room_Up
	AND #2
	BEQ .skipL0258
.condpart47
 jmp .__Skip_Joy0_Left

.skipL0258
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0259 ;  player1x  =  _c_Edge_Right

	LDA #_c_Edge_Right
	STA player1x
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0260 ;  _XRoom  =  _XRoom  -  1

	DEC _XRoom
.
 ; 

.L0261 ;  _Bit3_Next_Room_Left{3}  =  1

	LDA _Bit3_Next_Room_Left
	ORA #8
	STA _Bit3_Next_Room_Left
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

.L0262 ;  if !joy0right then goto __Skip_Joy0_Right

 bit SWCHA
	BPL .skipL0262
.condpart48
 jmp .__Skip_Joy0_Right

.skipL0262
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0263 ;  temp5  =   ( player1y - 1 )  / 8

; complex statement detected
	LDA player1y
	SEC
	SBC #1
	lsr
	lsr
	lsr
	STA temp5
.
 ; 

.L0264 ;  temp6  =   ( player1x - 9 )  / 4

; complex statement detected
	LDA player1x
	SEC
	SBC #9
	lsr
	lsr
	STA temp6
.
 ; 

.L0265 ;  if temp6  <  32 then if pfread ( temp6 , temp5 )  then goto __Skip_Joy0_Right

	LDA temp6
	CMP #32
     BCS .skipL0265
.condpart49
	LDA temp6
	LDY temp5
 sta temp7
 lda #>(ret_point10-1)
 pha
 lda #<(ret_point10-1)
 pha
 lda #>(pfread-1)
 pha
 lda #<(pfread-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point10
	BNE .skip49then
.condpart50
 jmp .__Skip_Joy0_Right

.skip49then
.skipL0265
.
 ; 

.L0266 ;  temp3  =   ( player1y - 9 )  / 8

; complex statement detected
	LDA player1y
	SEC
	SBC #9
	lsr
	lsr
	lsr
	STA temp3
.
 ; 

.L0267 ;  if temp6  <  32 then if pfread ( temp6 , temp3 )  then goto __Skip_Joy0_Right

	LDA temp6
	CMP #32
     BCS .skipL0267
.condpart51
	LDA temp6
	LDY temp3
 sta temp7
 lda #>(ret_point11-1)
 pha
 lda #<(ret_point11-1)
 pha
 lda #>(pfread-1)
 pha
 lda #<(pfread-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point11
	BNE .skip51then
.condpart52
 jmp .__Skip_Joy0_Right

.skip51then
.skipL0267
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0268 ;  _Bit6_LR_Joy_Movement{6}  =  1

	LDA _Bit6_LR_Joy_Movement
	ORA #64
	STA _Bit6_LR_Joy_Movement
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0269 ;  _P1_Left_Right  =  _P1_Left_Right  +  1.48

	LDA p
	CLC 
	ADC #122
	STA p
	LDA _P1_Left_Right
	ADC #1
	STA _P1_Left_Right
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0270 ;  REFP1  =  8

	LDA #8
	STA REFP1
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0271 ;  if player1x  <=  _c_Edge_Right then goto __Skip_Joy0_Right

	LDA #_c_Edge_Right
	CMP player1x
     BCC .skipL0271
.condpart53
 jmp .__Skip_Joy0_Right

.skipL0271
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0272 ;  if _XRoom  =  _c_World_Limit_Right then player1x  =  _c_Edge_Right  :  goto __Skip_Joy0_Right

	LDA _XRoom
	CMP #_c_World_Limit_Right
     BNE .skipL0272
.condpart54
	LDA #_c_Edge_Right
	STA player1x
 jmp .__Skip_Joy0_Right

.skipL0272
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0273 ;  if _Bit2_Next_Room_Down{2} then goto __Skip_Joy0_Right

	LDA _Bit2_Next_Room_Down
	AND #4
	BEQ .skipL0273
.condpart55
 jmp .__Skip_Joy0_Right

.skipL0273
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0274 ;  player1x  =  _c_Edge_Left

	LDA #_c_Edge_Left
	STA player1x
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0275 ;  _XRoom  =  _XRoom  +  1

	INC _XRoom
.
 ; 

.L0276 ;  _Bit4_Next_Room_Right{4}  =  1

	LDA _Bit4_Next_Room_Right
	ORA #16
	STA _Bit4_Next_Room_Right
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

.
 ; 

.
 ; 

.
 ; 

.L0277 ;  if !_Bit5_UD_Joy_Movement{5} then goto __Done_UD_Anim

	LDA _Bit5_UD_Joy_Movement
	AND #32
	BNE .skipL0277
.condpart56
 jmp .__Done_UD_Anim

.skipL0277
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0278 ;  on _Frame_Counter goto __FrameD0 __FrameD1 __FrameD2 __FrameD3

	LDX _Frame_Counter
	LDA .L0278jumptablehi,x
	PHA
	LDA .L0278jumptablelo,x
	PHA
	RTS
.L0278jumptablehi
	.byte >(.__FrameD0-1)
	.byte >(.__FrameD1-1)
	.byte >(.__FrameD2-1)
	.byte >(.__FrameD3-1)
.L0278jumptablelo
	.byte <(.__FrameD0-1)
	.byte <(.__FrameD1-1)
	.byte <(.__FrameD2-1)
	.byte <(.__FrameD3-1)
.
 ; 

.__Done_UD_Anim
 ; __Done_UD_Anim

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0279 ;  if !_Bit6_LR_Joy_Movement{6} then goto __Done_LR_Anim

	BIT _Bit6_LR_Joy_Movement
	BVS .skipL0279
.condpart57
 jmp .__Done_LR_Anim

.skipL0279
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0280 ;  player1color:

	LDX #<playercolorL0280_1
	STX player1color
	LDA #>playercolorL0280_1
	STA player1color+1
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0281 ;  on _Frame_Counter goto __FrameLR0 __FrameLR1 __FrameLR2 __FrameLR3

	LDX _Frame_Counter
	LDA .L0281jumptablehi,x
	PHA
	LDA .L0281jumptablelo,x
	PHA
	RTS
.L0281jumptablehi
	.byte >(.__FrameLR0-1)
	.byte >(.__FrameLR1-1)
	.byte >(.__FrameLR2-1)
	.byte >(.__FrameLR3-1)
.L0281jumptablelo
	.byte <(.__FrameLR0-1)
	.byte <(.__FrameLR1-1)
	.byte <(.__FrameLR2-1)
	.byte <(.__FrameLR3-1)
.
 ; 

.__Done_LR_Anim
 ; __Done_LR_Anim

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0282 ;  goto __Continue_in_Bank_2 bank2

 sta temp7
 lda #>(.__Continue_in_Bank_2-1)
 pha
 lda #<(.__Continue_in_Bank_2-1)
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

.
 ; 

.__FrameLR0
 ; __FrameLR0

.L0283 ;  player1:

	LDX #<playerL0283_1
	STX player1pointerlo
	LDA #>playerL0283_1
	STA player1pointerhi
	LDA #9
	STA player1height
.
 ; 

.L0284 ;  goto __Done_LR_Anim

 jmp .__Done_LR_Anim

.
 ; 

.
 ; 

.__FrameLR1
 ; __FrameLR1

.L0285 ;  player1:

	LDX #<playerL0285_1
	STX player1pointerlo
	LDA #>playerL0285_1
	STA player1pointerhi
	LDA #9
	STA player1height
.
 ; 

.L0286 ;  goto __Done_LR_Anim

 jmp .__Done_LR_Anim

.
 ; 

.
 ; 

.__FrameLR2
 ; __FrameLR2

.L0287 ;  player1:

	LDX #<playerL0287_1
	STX player1pointerlo
	LDA #>playerL0287_1
	STA player1pointerhi
	LDA #9
	STA player1height
.
 ; 

.L0288 ;  goto __Done_LR_Anim

 jmp .__Done_LR_Anim

.
 ; 

.
 ; 

.__FrameLR3
 ; __FrameLR3

.L0289 ;  player1:

	LDX #<playerL0289_1
	STX player1pointerlo
	LDA #>playerL0289_1
	STA player1pointerhi
	LDA #9
	STA player1height
.
 ; 

.L0290 ;  goto __Done_LR_Anim

 jmp .__Done_LR_Anim

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__FrameD0
 ; __FrameD0

.L0291 ;  player1:

	LDX #<playerL0291_1
	STX player1pointerlo
	LDA #>playerL0291_1
	STA player1pointerhi
	LDA #9
	STA player1height
.
 ; 

.L0292 ;  goto __Done_UD_Anim

 jmp .__Done_UD_Anim

.__FrameD1
 ; __FrameD1

.L0293 ;  player1:

	LDX #<playerL0293_1
	STX player1pointerlo
	LDA #>playerL0293_1
	STA player1pointerhi
	LDA #9
	STA player1height
.
 ; 

.L0294 ;  goto __Done_UD_Anim

 jmp .__Done_UD_Anim

.
 ; 

.
 ; 

.__FrameD2
 ; __FrameD2

.L0295 ;  player1:

	LDX #<playerL0295_1
	STX player1pointerlo
	LDA #>playerL0295_1
	STA player1pointerhi
	LDA #9
	STA player1height
.
 ; 

.L0296 ;  goto __Done_UD_Anim

 jmp .__Done_UD_Anim

.
 ; 

.
 ; 

.__FrameD3
 ; __FrameD3

.L0297 ;  player1:

	LDX #<playerL0297_1
	STX player1pointerlo
	LDA #>playerL0297_1
	STA player1pointerhi
	LDA #9
	STA player1height
.
 ; 

.L0298 ;  goto __Done_UD_Anim

 jmp .__Done_UD_Anim

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0299 ;  bank 2

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

.
 ; 

.
 ; 

.__Continue_in_Bank_2
 ; __Continue_in_Bank_2

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0300 ;  if !_Bit1_Next_Room_Up{1}  &&  !_Bit2_Next_Room_Down{2}  &&  !_Bit3_Next_Room_Left{3}  &&  !_Bit4_Next_Room_Right{4} then goto __Done_Next_Room

	LDA _Bit1_Next_Room_Up
	AND #2
	BNE .skipL0300
.condpart58
	LDA _Bit2_Next_Room_Down
	AND #4
	BNE .skip58then
.condpart59
	LDA _Bit3_Next_Room_Left
	AND #8
	BNE .skip59then
.condpart60
	LDA _Bit4_Next_Room_Right
	AND #16
	BNE .skip60then
.condpart61
 jmp .__Done_Next_Room

.skip60then
.skip59then
.skip58then
.skipL0300
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0301 ;  if !_Bit4_Next_Room_Right{4}  &&  !_Bit2_Next_Room_Down{2} then goto __Skip_bBRand

	LDA _Bit4_Next_Room_Right
	AND #16
	BNE .skipL0301
.condpart62
	LDA _Bit2_Next_Room_Down
	AND #4
	BNE .skip62then
.condpart63
 jmp .__Skip_bBRand

.skip62then
.skipL0301
.
 ; 

.__Special_Rand
 ; __Special_Rand

.
 ; 

.L0302 ;  _Temp  =  0

	LDA #0
	STA _Temp
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__bBRand
 ; __bBRand

.L0303 ;  asm

   lda _RoomRand

   lsr

   bcc __bB_Rand_no_eor

   eor #$B4

__bB_Rand_no_eor

   sta _RoomRand

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0304 ;  if _Bit2_Next_Room_Down{2} then _Temp  =  _Temp  +  1  :  if _Temp  <=  _c_World_Limit_Right then goto __bBRand

	LDA _Bit2_Next_Room_Down
	AND #4
	BEQ .skipL0304
.condpart64
	INC _Temp
	LDA #_c_World_Limit_Right
	CMP _Temp
     BCC .skip64then
.condpart65
 jmp .__bBRand

.skip64then
.skipL0304
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0305 ;  _CurrentScene  =  _RoomRand

	LDA _RoomRand
	STA _CurrentScene
.
 ; 

.__Skip_bBRand
 ; __Skip_bBRand

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0306 ;  if !_Bit1_Next_Room_Up{1}  &&  !_Bit3_Next_Room_Left{3} then goto __Skip_UnRand

	LDA _Bit1_Next_Room_Up
	AND #2
	BNE .skipL0306
.condpart66
	LDA _Bit3_Next_Room_Left
	AND #8
	BNE .skip66then
.condpart67
 jmp .__Skip_UnRand

.skip66then
.skipL0306
.
 ; 

.L0307 ;  _Temp  =  0

	LDA #0
	STA _Temp
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__UnRand
 ; __UnRand

.L0308 ;  asm

   LDA _RoomRand

   ASL

   BCC __UnRand_no_eor

   EOR #$69

__UnRand_no_eor:

   STA _RoomRand

   STA _CurrentScene

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0309 ;  if _Bit1_Next_Room_Up{1} then _Temp  =  _Temp  +  1  :  if _Temp  <=  _c_World_Limit_Right then goto __UnRand

	LDA _Bit1_Next_Room_Up
	AND #2
	BEQ .skipL0309
.condpart68
	INC _Temp
	LDA #_c_World_Limit_Right
	CMP _Temp
     BCC .skip68then
.condpart69
 jmp .__UnRand

.skip68then
.skipL0309
.
 ; 

.__Skip_UnRand
 ; __Skip_UnRand

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0310 ;  _CurrentScene  =   ( _CurrentScene & 31 ) 

; complex statement detected
	LDA _CurrentScene
	AND #31
	STA _CurrentScene
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0311 ;  _Temp  =  _VisitedRooms[_YRoom]

	LDX _YRoom
	LDA _VisitedRooms,x
	STA _Temp
.L0312 ;  temp5  =  _Data_Number_to_Bit[_XRoom]

	LDX _XRoom
	LDA _Data_Number_to_Bit,x
	STA temp5
.L0313 ;  _Temp  =   ( _Temp & temp5 ) 

; complex statement detected
	LDA _Temp
	AND temp5
	STA _Temp
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0314 ;  if _Temp  &&  lives  <  32 then lives  =  lives  +  32

	LDA _Temp
	BEQ .skipL0314
.condpart70
	LDA lives
	CMP #32
     BCS .skip70then
.condpart71
	LDA lives
	CLC
	ADC #32
	STA lives
.skip70then
.skipL0314
.L0315 ;  if !_Temp  &&  lives  >=  32 then lives  =  lives  -  32

	LDA _Temp
	BNE .skipL0315
.condpart72
	LDA lives
	CMP #32
     BCC .skip72then
.condpart73
	LDA lives
	SEC
	SBC #32
	STA lives
.skip72then
.skipL0315
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0316 ;  _Temp  =  _VisitedRooms[_YRoom]

	LDX _YRoom
	LDA _VisitedRooms,x
	STA _Temp
.L0317 ;  temp5  =  _Data_Number_to_Bit[_XRoom]

	LDX _XRoom
	LDA _Data_Number_to_Bit,x
	STA temp5
.L0318 ;  _VisitedRooms[_YRoom]  =   ( _Temp | temp5 ) 

; complex statement detected
	LDA _Temp
	ORA temp5
	LDX _YRoom
	STA _VisitedRooms,x
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0319 ;  goto __Set_Current_Scene

 jmp .__Set_Current_Scene

.
 ; 

.__Done_Next_Room
 ; __Done_Next_Room

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0320 ;  drawscreen

 sta temp7
 lda #>(ret_point12-1)
 pha
 lda #<(ret_point12-1)
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
ret_point12
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0321 ;  goto __Continue_in_Bank_3 bank3

 sta temp7
 lda #>(.__Continue_in_Bank_3-1)
 pha
 lda #<(.__Continue_in_Bank_3-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #3
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

.
 ; 

.__Set_Current_Scene
 ; __Set_Current_Scene

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0322 ;  COLUBK  =  _Data_Background_Color[_CurrentScene]

	LDX _CurrentScene
	LDA _Data_Background_Color,x
	STA COLUBK
.L0323 ;  COLUPF  =  _Data_Foreground_Color[_CurrentScene]

	LDX _CurrentScene
	LDA _Data_Foreground_Color,x
	STA COLUPF
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0324 ;  on _CurrentScene goto __s0 __s1 __s2 __s3 __s4 __s5 __s6 __s7 __s8 __s9 __sA __sB __sC __sD __sE __sF __sG __sH __sI __sJ __sK __sL __sM __sN __sO __sP __sQ __sR __sS __sT __sU __sV

	LDX _CurrentScene
	LDA .L0324jumptablehi,x
	PHA
	LDA .L0324jumptablelo,x
	PHA
	RTS
.L0324jumptablehi
	.byte >(.__s0-1)
	.byte >(.__s1-1)
	.byte >(.__s2-1)
	.byte >(.__s3-1)
	.byte >(.__s4-1)
	.byte >(.__s5-1)
	.byte >(.__s6-1)
	.byte >(.__s7-1)
	.byte >(.__s8-1)
	.byte >(.__s9-1)
	.byte >(.__sA-1)
	.byte >(.__sB-1)
	.byte >(.__sC-1)
	.byte >(.__sD-1)
	.byte >(.__sE-1)
	.byte >(.__sF-1)
	.byte >(.__sG-1)
	.byte >(.__sH-1)
	.byte >(.__sI-1)
	.byte >(.__sJ-1)
	.byte >(.__sK-1)
	.byte >(.__sL-1)
	.byte >(.__sM-1)
	.byte >(.__sN-1)
	.byte >(.__sO-1)
	.byte >(.__sP-1)
	.byte >(.__sQ-1)
	.byte >(.__sR-1)
	.byte >(.__sS-1)
	.byte >(.__sT-1)
	.byte >(.__sU-1)
	.byte >(.__sV-1)
.L0324jumptablelo
	.byte <(.__s0-1)
	.byte <(.__s1-1)
	.byte <(.__s2-1)
	.byte <(.__s3-1)
	.byte <(.__s4-1)
	.byte <(.__s5-1)
	.byte <(.__s6-1)
	.byte <(.__s7-1)
	.byte <(.__s8-1)
	.byte <(.__s9-1)
	.byte <(.__sA-1)
	.byte <(.__sB-1)
	.byte <(.__sC-1)
	.byte <(.__sD-1)
	.byte <(.__sE-1)
	.byte <(.__sF-1)
	.byte <(.__sG-1)
	.byte <(.__sH-1)
	.byte <(.__sI-1)
	.byte <(.__sJ-1)
	.byte <(.__sK-1)
	.byte <(.__sL-1)
	.byte <(.__sM-1)
	.byte <(.__sN-1)
	.byte <(.__sO-1)
	.byte <(.__sP-1)
	.byte <(.__sQ-1)
	.byte <(.__sR-1)
	.byte <(.__sS-1)
	.byte <(.__sT-1)
	.byte <(.__sU-1)
	.byte <(.__sV-1)
.
 ; 

.
 ; 

.__s0
 ; __s0

.L0325 ;  playfield:

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
	.byte %00000000, %01000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %11100000
	if (pfwidth>2)
	.byte %00000001, %00000000
 endif
	.byte %00000000, %11110000
	if (pfwidth>2)
	.byte %10000011, %00000001
 endif
	.byte %00000010, %00000000
	if (pfwidth>2)
	.byte %00000111, %00000011
 endif
	.byte %00000111, %00000000
	if (pfwidth>2)
	.byte %00001111, %00000111
 endif
	.byte %00001111, %00000001
	if (pfwidth>2)
	.byte %00011111, %00001111
 endif
	.byte %00011111, %00000011
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
pflabel1
	lda PF_data1,x
	sta playfield,x
	dex
	bpl pflabel1
.
 ; 

.L0326 ;  goto __Done_Next_Room

 jmp .__Done_Next_Room

.
 ; 

.
 ; 

.__s1
 ; __s1

.L0327 ;  playfield:

  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel2
PF_data2
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00001111, %11111000
	if (pfwidth>2)
	.byte %11111000, %00001111
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00001111, %11111111
	if (pfwidth>2)
	.byte %11111111, %00001111
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00001111, %11111000
	if (pfwidth>2)
	.byte %11111000, %00001111
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
pflabel2
	lda PF_data2,x
	sta playfield,x
	dex
	bpl pflabel2
.
 ; 

.L0328 ;  goto __Done_Next_Room

 jmp .__Done_Next_Room

.
 ; 

.
 ; 

.__s2
 ; __s2

.L0329 ;  playfield:

  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel3
PF_data3
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000001, %00000011
	if (pfwidth>2)
	.byte %00000011, %00000001
 endif
	.byte %00000011, %00000111
	if (pfwidth>2)
	.byte %00000111, %00000011
 endif
	.byte %00000001, %00000011
	if (pfwidth>2)
	.byte %00000011, %00000001
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %11000000
	if (pfwidth>2)
	.byte %11000000, %00000000
 endif
	.byte %00000000, %11100000
	if (pfwidth>2)
	.byte %11100000, %00000000
 endif
	.byte %00000000, %11000000
	if (pfwidth>2)
	.byte %11000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
pflabel3
	lda PF_data3,x
	sta playfield,x
	dex
	bpl pflabel3
.
 ; 

.L0330 ;  goto __Done_Next_Room

 jmp .__Done_Next_Room

.
 ; 

.
 ; 

.__s3
 ; __s3

.L0331 ;  playfield:

  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel4
PF_data4
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00001111, %11110001
	if (pfwidth>2)
	.byte %11100011, %00001111
 endif
	.byte %00001111, %11110001
	if (pfwidth>2)
	.byte %11100011, %00001111
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
	.byte %00001111, %11110001
	if (pfwidth>2)
	.byte %11100011, %00001111
 endif
	.byte %00001111, %11110001
	if (pfwidth>2)
	.byte %11100011, %00001111
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
pflabel4
	lda PF_data4,x
	sta playfield,x
	dex
	bpl pflabel4
.
 ; 

.L0332 ;  goto __Done_Next_Room

 jmp .__Done_Next_Room

.
 ; 

.
 ; 

.__s4
 ; __s4

.L0333 ;  playfield:

  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel5
PF_data5
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %10000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %11000000
	if (pfwidth>2)
	.byte %10000000, %00000000
 endif
	.byte %00000000, %11100000
	if (pfwidth>2)
	.byte %11000000, %00000000
 endif
	.byte %00000000, %11111000
	if (pfwidth>2)
	.byte %11110000, %00000000
 endif
	.byte %00000000, %11111110
	if (pfwidth>2)
	.byte %11111100, %00000000
 endif
	.byte %00000001, %11111111
	if (pfwidth>2)
	.byte %11111111, %00000000
 endif
	.byte %00000111, %11111111
	if (pfwidth>2)
	.byte %11111111, %00000011
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
pflabel5
	lda PF_data5,x
	sta playfield,x
	dex
	bpl pflabel5
.
 ; 

.L0334 ;  goto __Done_Next_Room

 jmp .__Done_Next_Room

.
 ; 

.
 ; 

.__s5
 ; __s5

.L0335 ;  playfield:

  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel6
PF_data6
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00001000, %00000100
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00011100, %00001110
	if (pfwidth>2)
	.byte %00000100, %00000000
 endif
	.byte %00001000, %00000100
	if (pfwidth>2)
	.byte %00001110, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000100, %00000000
 endif
	.byte %00000000, %10000000
	if (pfwidth>2)
	.byte %00000000, %00000100
 endif
	.byte %00000000, %11000000
	if (pfwidth>2)
	.byte %10000000, %00001110
 endif
	.byte %00000000, %10000000
	if (pfwidth>2)
	.byte %00000000, %00000100
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
pflabel6
	lda PF_data6,x
	sta playfield,x
	dex
	bpl pflabel6
.
 ; 

.L0336 ;  goto __Done_Next_Room

 jmp .__Done_Next_Room

.
 ; 

.
 ; 

.__s6
 ; __s6

.L0337 ;  playfield:

  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel7
PF_data7
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00110000
	if (pfwidth>2)
	.byte %00110000, %00000000
 endif
	.byte %00000000, %00110000
	if (pfwidth>2)
	.byte %00110000, %00000000
 endif
	.byte %00001111, %00000011
	if (pfwidth>2)
	.byte %00000011, %00001111
 endif
	.byte %00001111, %00000011
	if (pfwidth>2)
	.byte %00000011, %00001111
 endif
	.byte %00001111, %00000011
	if (pfwidth>2)
	.byte %00000011, %00001111
 endif
	.byte %00000000, %00110000
	if (pfwidth>2)
	.byte %00110000, %00000000
 endif
	.byte %00000000, %00110000
	if (pfwidth>2)
	.byte %00110000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
pflabel7
	lda PF_data7,x
	sta playfield,x
	dex
	bpl pflabel7
.
 ; 

.L0338 ;  goto __Done_Next_Room

 jmp .__Done_Next_Room

.
 ; 

.
 ; 

.__s7
 ; __s7

.L0339 ;  playfield:

  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel8
PF_data8
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
	.byte %11111111, %00000000
 endif
	.byte %00000000, %11111100
	if (pfwidth>2)
	.byte %11111111, %00000001
 endif
	.byte %00000000, %11111110
	if (pfwidth>2)
	.byte %11111110, %00000000
 endif
	.byte %00000000, %11111111
	if (pfwidth>2)
	.byte %11111110, %00000000
 endif
	.byte %00000000, %11111111
	if (pfwidth>2)
	.byte %11111111, %00000011
 endif
	.byte %00000000, %11111110
	if (pfwidth>2)
	.byte %11111111, %00000011
 endif
	.byte %00000000, %11110000
	if (pfwidth>2)
	.byte %10011111, %00000001
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
pflabel8
	lda PF_data8,x
	sta playfield,x
	dex
	bpl pflabel8
.
 ; 

.L0340 ;  goto __Done_Next_Room

 jmp .__Done_Next_Room

.
 ; 

.
 ; 

.__s8
 ; __s8

.L0341 ;  playfield:

  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel9
PF_data9
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %11111111
	if (pfwidth>2)
	.byte %10000000, %00000010
 endif
	.byte %00000011, %11111111
	if (pfwidth>2)
	.byte %11000000, %00000111
 endif
	.byte %00000111, %11111111
	if (pfwidth>2)
	.byte %11000001, %00001111
 endif
	.byte %00000111, %11111111
	if (pfwidth>2)
	.byte %10000011, %00011111
 endif
	.byte %00000011, %11111100
	if (pfwidth>2)
	.byte %10000000, %00000010
 endif
	.byte %00000011, %11111100
	if (pfwidth>2)
	.byte %00000000, %00000010
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
pflabel9
	lda PF_data9,x
	sta playfield,x
	dex
	bpl pflabel9
.
 ; 

.L0342 ;  goto __Done_Next_Room

 jmp .__Done_Next_Room

.
 ; 

.
 ; 

.__s9
 ; __s9

.L0343 ;  playfield:

  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel10
PF_data10
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
	.byte %00000111, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00001111, %00000001
	if (pfwidth>2)
	.byte %00001110, %00000000
 endif
	.byte %00001111, %00000001
	if (pfwidth>2)
	.byte %00011111, %00000000
 endif
	.byte %00000111, %00000000
	if (pfwidth>2)
	.byte %00011111, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00001110, %00000000
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
pflabel10
	lda PF_data10,x
	sta playfield,x
	dex
	bpl pflabel10
.
 ; 

.L0344 ;  goto __Done_Next_Room

 jmp .__Done_Next_Room

.
 ; 

.
 ; 

.__sA
 ; __sA

.L0345 ;  playfield:

  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel11
PF_data11
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00001111, %11110011
	if (pfwidth>2)
	.byte %11110011, %00001111
 endif
	.byte %00001100, %00000000
	if (pfwidth>2)
	.byte %00000000, %00001100
 endif
	.byte %00001100, %00000000
	if (pfwidth>2)
	.byte %00000000, %00001100
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00001100, %00000000
	if (pfwidth>2)
	.byte %00000000, %00001100
 endif
	.byte %00001111, %11110011
	if (pfwidth>2)
	.byte %11110011, %00001111
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
pflabel11
	lda PF_data11,x
	sta playfield,x
	dex
	bpl pflabel11
.L0346 ;  goto __Done_Next_Room

 jmp .__Done_Next_Room

.
 ; 

.
 ; 

.__sB
 ; __sB

.L0347 ;  playfield:

  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel12
PF_data12
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000001, %00000111
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000111, %00011111
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00011111, %01111111
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000111, %00011111
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000001, %00000111
	if (pfwidth>2)
	.byte %00000001, %00000011
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000011, %00000111
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000001, %00000011
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
pflabel12
	lda PF_data12,x
	sta playfield,x
	dex
	bpl pflabel12
.
 ; 

.L0348 ;  goto __Done_Next_Room

 jmp .__Done_Next_Room

.
 ; 

.
 ; 

.__sC
 ; __sC

.L0349 ;  playfield:

  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel13
PF_data13
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000011, %11110001
	if (pfwidth>2)
	.byte %11110001, %00000011
 endif
	.byte %00001111, %11000011
	if (pfwidth>2)
	.byte %11000011, %00001111
 endif
	.byte %00011111, %11000011
	if (pfwidth>2)
	.byte %11000011, %00011111
 endif
	.byte %00011111, %11000001
	if (pfwidth>2)
	.byte %11000001, %00011111
 endif
	.byte %00001111, %11000000
	if (pfwidth>2)
	.byte %11000000, %00001111
 endif
	.byte %00001110, %11110000
	if (pfwidth>2)
	.byte %11110000, %00001110
 endif
	.byte %00001111, %11111000
	if (pfwidth>2)
	.byte %11111000, %00001111
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
pflabel13
	lda PF_data13,x
	sta playfield,x
	dex
	bpl pflabel13
.
 ; 

.L0350 ;  goto __Done_Next_Room

 jmp .__Done_Next_Room

.
 ; 

.
 ; 

.__sD
 ; __sD

.L0351 ;  playfield:

  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel14
PF_data14
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %11111100
	if (pfwidth>2)
	.byte %11111100, %00000000
 endif
	.byte %00000000, %11111111
	if (pfwidth>2)
	.byte %11111111, %00000000
 endif
	.byte %00000000, %11111111
	if (pfwidth>2)
	.byte %11111111, %00000000
 endif
	.byte %00000000, %11111111
	if (pfwidth>2)
	.byte %11111111, %00000000
 endif
	.byte %00000000, %11111111
	if (pfwidth>2)
	.byte %11111111, %00000000
 endif
	.byte %00000000, %11111111
	if (pfwidth>2)
	.byte %11001111, %00000000
 endif
	.byte %00000000, %11111100
	if (pfwidth>2)
	.byte %11001110, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
pflabel14
	lda PF_data14,x
	sta playfield,x
	dex
	bpl pflabel14
.
 ; 

.L0352 ;  goto __Done_Next_Room

 jmp .__Done_Next_Room

.
 ; 

.
 ; 

.__sE
 ; __sE

.L0353 ;  playfield:

  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel15
PF_data15
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
	.byte %00001100, %00000000
	if (pfwidth>2)
	.byte %00000000, %00001100
 endif
	.byte %00001100, %00000000
	if (pfwidth>2)
	.byte %00000000, %00001100
 endif
	.byte %00001100, %00000000
	if (pfwidth>2)
	.byte %00000000, %00001100
 endif
	.byte %00000000, %01110000
	if (pfwidth>2)
	.byte %01110000, %00000000
 endif
	.byte %00000000, %01110000
	if (pfwidth>2)
	.byte %01110000, %00000000
 endif
	.byte %00001111, %01110011
	if (pfwidth>2)
	.byte %01110011, %00001111
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
pflabel15
	lda PF_data15,x
	sta playfield,x
	dex
	bpl pflabel15
.
 ; 

.L0354 ;  goto __Done_Next_Room

 jmp .__Done_Next_Room

.
 ; 

.
 ; 

.__sF
 ; __sF

.L0355 ;  playfield:

  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel16
PF_data16
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %11111100
	if (pfwidth>2)
	.byte %10000000, %00000000
 endif
	.byte %00000000, %11111110
	if (pfwidth>2)
	.byte %11100000, %00000000
 endif
	.byte %00000001, %11111111
	if (pfwidth>2)
	.byte %11111000, %00000000
 endif
	.byte %00000011, %11111111
	if (pfwidth>2)
	.byte %11111000, %00000000
 endif
	.byte %00000001, %11111111
	if (pfwidth>2)
	.byte %11110000, %00000000
 endif
	.byte %00000000, %11111100
	if (pfwidth>2)
	.byte %10000000, %00000000
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
pflabel16
	lda PF_data16,x
	sta playfield,x
	dex
	bpl pflabel16
.
 ; 

.L0356 ;  goto __Done_Next_Room

 jmp .__Done_Next_Room

.
 ; 

.
 ; 

.__sG
 ; __sG

.L0357 ;  playfield:

  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel17
PF_data17
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00001111, %00000000
	if (pfwidth>2)
	.byte %00000000, %00001111
 endif
	.byte %00001111, %00000000
	if (pfwidth>2)
	.byte %00000000, %00001111
 endif
	.byte %00001111, %00000000
	if (pfwidth>2)
	.byte %00000000, %00001111
 endif
	.byte %00001111, %00011111
	if (pfwidth>2)
	.byte %00011111, %00001111
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00001111, %00011111
	if (pfwidth>2)
	.byte %00011111, %00001111
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
pflabel17
	lda PF_data17,x
	sta playfield,x
	dex
	bpl pflabel17
.
 ; 

.L0358 ;  goto __Done_Next_Room

 jmp .__Done_Next_Room

.
 ; 

.
 ; 

.__sH
 ; __sH

.L0359 ;  playfield:

  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel18
PF_data18
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00011111, %00000011
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00001111, %00000001
	if (pfwidth>2)
	.byte %00011111, %00001111
 endif
	.byte %00000111, %00000000
	if (pfwidth>2)
	.byte %00001111, %00000111
 endif
	.byte %00000010, %00000000
	if (pfwidth>2)
	.byte %00000111, %00000011
 endif
	.byte %00000000, %11110000
	if (pfwidth>2)
	.byte %10000011, %00000001
 endif
	.byte %00000000, %11100000
	if (pfwidth>2)
	.byte %00000001, %00000000
 endif
	.byte %00000000, %01000000
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
pflabel18
	lda PF_data18,x
	sta playfield,x
	dex
	bpl pflabel18
.
 ; 

.L0360 ;  goto __Done_Next_Room

 jmp .__Done_Next_Room

.
 ; 

.
 ; 

.__sI
 ; __sI

.L0361 ;  playfield:

  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel19
PF_data19
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00001111, %10011001
	if (pfwidth>2)
	.byte %10011001, %00001111
 endif
	.byte %00001111, %10011001
	if (pfwidth>2)
	.byte %10011001, %00001111
 endif
	.byte %00001111, %10011001
	if (pfwidth>2)
	.byte %10011001, %00001111
 endif
	.byte %00001111, %10011001
	if (pfwidth>2)
	.byte %10011001, %00001111
 endif
	.byte %00000000, %10011000
	if (pfwidth>2)
	.byte %10011000, %00000000
 endif
	.byte %00000000, %10011000
	if (pfwidth>2)
	.byte %10011000, %00000000
 endif
	.byte %00001111, %10011111
	if (pfwidth>2)
	.byte %10011111, %00001111
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
pflabel19
	lda PF_data19,x
	sta playfield,x
	dex
	bpl pflabel19
.
 ; 

.L0362 ;  goto __Done_Next_Room

 jmp .__Done_Next_Room

.
 ; 

.
 ; 

.__sJ
 ; __sJ

.L0363 ;  playfield:

  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel20
PF_data20
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
	.byte %00011000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00111100, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %01111110, %00000000
 endif
	.byte %00000011, %00000000
	if (pfwidth>2)
	.byte %01100110, %00000000
 endif
	.byte %00000111, %00000001
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00001111, %00000011
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00001100, %00000011
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
pflabel20
	lda PF_data20,x
	sta playfield,x
	dex
	bpl pflabel20
.
 ; 

.L0364 ;  goto __Done_Next_Room

 jmp .__Done_Next_Room

.
 ; 

.
 ; 

.__sK
 ; __sK

.L0365 ;  playfield:

  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel21
PF_data21
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %11000000
	if (pfwidth>2)
	.byte %10000000, %00000000
 endif
	.byte %00000000, %11100000
	if (pfwidth>2)
	.byte %11000000, %00000000
 endif
	.byte %00000000, %11000000
	if (pfwidth>2)
	.byte %10000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000001, %00000011
	if (pfwidth>2)
	.byte %00000111, %00000000
 endif
	.byte %00000011, %00000111
	if (pfwidth>2)
	.byte %00001111, %00000001
 endif
	.byte %00000001, %00000011
	if (pfwidth>2)
	.byte %00000111, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
pflabel21
	lda PF_data21,x
	sta playfield,x
	dex
	bpl pflabel21
.
 ; 

.L0366 ;  goto __Done_Next_Room

 jmp .__Done_Next_Room

.
 ; 

.
 ; 

.__sL
 ; __sL

.L0367 ;  playfield:

  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel22
PF_data22
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000110, %11111110
	if (pfwidth>2)
	.byte %11111111, %00000111
 endif
	.byte %00000110, %00000110
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000110, %00000110
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000110, %11000110
	if (pfwidth>2)
	.byte %11111111, %00000111
 endif
	.byte %00000110, %11000110
	if (pfwidth>2)
	.byte %00000000, %00000110
 endif
	.byte %00000110, %11000110
	if (pfwidth>2)
	.byte %00000000, %00000110
 endif
	.byte %00000110, %11000110
	if (pfwidth>2)
	.byte %00111110, %00000110
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
pflabel22
	lda PF_data22,x
	sta playfield,x
	dex
	bpl pflabel22
.
 ; 

.L0368 ;  goto __Done_Next_Room

 jmp .__Done_Next_Room

.
 ; 

.
 ; 

.__sM
 ; __sM

.L0369 ;  playfield:

  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel23
PF_data23
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000001, %11111111
	if (pfwidth>2)
	.byte %10000000, %00000000
 endif
	.byte %00000111, %11111111
	if (pfwidth>2)
	.byte %11000000, %00000000
 endif
	.byte %00000111, %11111111
	if (pfwidth>2)
	.byte %11000000, %00000000
 endif
	.byte %00000111, %11111111
	if (pfwidth>2)
	.byte %11000000, %00000000
 endif
	.byte %00000111, %11111100
	if (pfwidth>2)
	.byte %11000000, %00001110
 endif
	.byte %00000011, %11111100
	if (pfwidth>2)
	.byte %10000000, %00001110
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
pflabel23
	lda PF_data23,x
	sta playfield,x
	dex
	bpl pflabel23
.
 ; 

.
 ; 

.L0370 ;  goto __Done_Next_Room

 jmp .__Done_Next_Room

.
 ; 

.
 ; 

.__sN
 ; __sN

.L0371 ;  playfield:

  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel24
PF_data24
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000010, %00000000
	if (pfwidth>2)
	.byte %11111110, %00000000
 endif
	.byte %00000111, %11000000
	if (pfwidth>2)
	.byte %11111111, %00000001
 endif
	.byte %00001111, %11000001
	if (pfwidth>2)
	.byte %11111111, %00000011
 endif
	.byte %00011111, %11000011
	if (pfwidth>2)
	.byte %11111111, %00000011
 endif
	.byte %00000010, %11000000
	if (pfwidth>2)
	.byte %10011111, %00000011
 endif
	.byte %00000010, %10000000
	if (pfwidth>2)
	.byte %10011111, %00000001
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
pflabel24
	lda PF_data24,x
	sta playfield,x
	dex
	bpl pflabel24
.
 ; 

.L0372 ;  goto __Done_Next_Room

 jmp .__Done_Next_Room

.
 ; 

.
 ; 

.__sO
 ; __sO

.L0373 ;  playfield:

  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel25
PF_data25
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
	.byte %00111110, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00111111, %00000001
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00011111, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00111110
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000001, %00111111
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00011111
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
pflabel25
	lda PF_data25,x
	sta playfield,x
	dex
	bpl pflabel25
.
 ; 

.L0374 ;  goto __Done_Next_Room

 jmp .__Done_Next_Room

.
 ; 

.
 ; 

.__sP
 ; __sP

.L0375 ;  playfield:

  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel26
PF_data26
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000111, %11111111
	if (pfwidth>2)
	.byte %11111111, %00000111
 endif
	.byte %00000111, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000111
 endif
	.byte %00000111, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000111
 endif
	.byte %00000111, %11111100
	if (pfwidth>2)
	.byte %11111100, %00000111
 endif
	.byte %00000111, %11111100
	if (pfwidth>2)
	.byte %11111100, %00000111
 endif
	.byte %00000111, %11111100
	if (pfwidth>2)
	.byte %11111100, %00000111
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
pflabel26
	lda PF_data26,x
	sta playfield,x
	dex
	bpl pflabel26
.
 ; 

.L0376 ;  goto __Done_Next_Room

 jmp .__Done_Next_Room

.
 ; 

.
 ; 

.__sQ
 ; __sQ

.L0377 ;  playfield:

  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel27
PF_data27
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00001110
	if (pfwidth>2)
	.byte %00001110, %00000000
 endif
	.byte %00000001, %00111111
	if (pfwidth>2)
	.byte %00111111, %00000001
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
	.byte %00000001, %00111111
	if (pfwidth>2)
	.byte %00111111, %00000001
 endif
	.byte %00000000, %00001110
	if (pfwidth>2)
	.byte %00001110, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
pflabel27
	lda PF_data27,x
	sta playfield,x
	dex
	bpl pflabel27
.
 ; 

.L0378 ;  goto __Done_Next_Room

 jmp .__Done_Next_Room

.
 ; 

.
 ; 

.__sR
 ; __sR

.L0379 ;  playfield:

  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel28
PF_data28
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000111, %01111111
	if (pfwidth>2)
	.byte %01111001, %00000111
 endif
	.byte %00000111, %01111111
	if (pfwidth>2)
	.byte %01111001, %00000111
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %01111001, %00000111
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %01111001, %00000111
 endif
	.byte %00000111, %01111111
	if (pfwidth>2)
	.byte %01111001, %00000111
 endif
	.byte %00000111, %01111111
	if (pfwidth>2)
	.byte %01111001, %00000111
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
pflabel28
	lda PF_data28,x
	sta playfield,x
	dex
	bpl pflabel28
.
 ; 

.L0380 ;  goto __Done_Next_Room

 jmp .__Done_Next_Room

.
 ; 

.
 ; 

.__sS
 ; __sS

.L0381 ;  playfield:

  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel29
PF_data29
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %01110000
	if (pfwidth>2)
	.byte %01110000, %00000000
 endif
	.byte %00000000, %01111100
	if (pfwidth>2)
	.byte %01111100, %00000000
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
	.byte %00000000, %01111100
	if (pfwidth>2)
	.byte %01111100, %00000000
 endif
	.byte %00000000, %01110000
	if (pfwidth>2)
	.byte %01110000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
pflabel29
	lda PF_data29,x
	sta playfield,x
	dex
	bpl pflabel29
.
 ; 

.L0382 ;  goto __Done_Next_Room

 jmp .__Done_Next_Room

.
 ; 

.
 ; 

.__sT
 ; __sT

.L0383 ;  playfield:

  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel30
PF_data30
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000111, %00111100
	if (pfwidth>2)
	.byte %00111100, %00000111
 endif
	.byte %00000111, %11111100
	if (pfwidth>2)
	.byte %11111100, %00000111
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000111, %11111100
	if (pfwidth>2)
	.byte %11111100, %00000111
 endif
	.byte %00000111, %00111100
	if (pfwidth>2)
	.byte %00111100, %00000111
 endif
	.byte %00000111, %00111100
	if (pfwidth>2)
	.byte %00111100, %00000111
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
pflabel30
	lda PF_data30,x
	sta playfield,x
	dex
	bpl pflabel30
.
 ; 

.L0384 ;  goto __Done_Next_Room

 jmp .__Done_Next_Room

.
 ; 

.
 ; 

.__sU
 ; __sU

.L0385 ;  playfield:

  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel31
PF_data31
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %01110000
	if (pfwidth>2)
	.byte %01110000, %00000000
 endif
	.byte %00000000, %01111100
	if (pfwidth>2)
	.byte %01111100, %00000000
 endif
	.byte %00000000, %01111110
	if (pfwidth>2)
	.byte %01111110, %00000000
 endif
	.byte %00000000, %01111111
	if (pfwidth>2)
	.byte %01111111, %00000000
 endif
	.byte %00000000, %01111110
	if (pfwidth>2)
	.byte %01111110, %00000000
 endif
	.byte %00000000, %01111100
	if (pfwidth>2)
	.byte %01111100, %00000000
 endif
	.byte %00000000, %01110000
	if (pfwidth>2)
	.byte %01110000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
pflabel31
	lda PF_data31,x
	sta playfield,x
	dex
	bpl pflabel31
.
 ; 

.L0386 ;  goto __Done_Next_Room

 jmp .__Done_Next_Room

.
 ; 

.
 ; 

.__sV
 ; __sV

.L0387 ;  playfield:

  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel32
PF_data32
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000111, %00111111
	if (pfwidth>2)
	.byte %00111111, %00000111
 endif
	.byte %00000111, %00111111
	if (pfwidth>2)
	.byte %00111111, %00000111
 endif
	.byte %00000111, %00000001
	if (pfwidth>2)
	.byte %00000001, %00000111
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00111000
	if (pfwidth>2)
	.byte %00111000, %00000000
 endif
	.byte %00000000, %00111000
	if (pfwidth>2)
	.byte %00111000, %00000000
 endif
	.byte %00000111, %00111111
	if (pfwidth>2)
	.byte %00111111, %00000111
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
pflabel32
	lda PF_data32,x
	sta playfield,x
	dex
	bpl pflabel32
.
 ; 

.L0388 ;  goto __Done_Next_Room

 jmp .__Done_Next_Room

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0389 ;  data _Data_Background_Color

	JMP .skipL0389
_Data_Background_Color
	.byte    _20

	.byte    _30

	.byte    _50

	.byte    _B0

	.byte    _C0

	.byte    _D0

	.byte    _E0

	.byte    _F0

	.byte    _80

	.byte    _62

	.byte    _C2

	.byte    _60

	.byte    _40

	.byte    _D2

	.byte    _30

	.byte    _D0

	.byte    _62

	.byte    _62

	.byte    _90

	.byte    _90

	.byte    _D0

	.byte    _D0

	.byte    _40

	.byte    _40

	.byte    _C2

	.byte    _C0

	.byte    _20

	.byte    _22

	.byte    _22

	.byte    _D2

	.byte    _C2

	.byte    _22

.skipL0389
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0390 ;  data _Data_Foreground_Color

	JMP .skipL0390
_Data_Foreground_Color
	.byte    _BC

	.byte    _3C

	.byte    _BC

	.byte    _CC

	.byte    _2C

	.byte    _0C

	.byte    _BC

	.byte    _AC

	.byte    _9C

	.byte    _6C

	.byte    _CC

	.byte    _3C

	.byte    _CC

	.byte    _9C

	.byte    _CC

	.byte    _2C

	.byte    _5C

	.byte    _9C

	.byte    _BC

	.byte    _5C

	.byte    _2C

	.byte    _4C

	.byte    _0C

	.byte    _3C

	.byte    _0C

	.byte    _AC

	.byte    _CC

	.byte    _4C

	.byte    _3C

	.byte    _EC

	.byte    _4C

	.byte    _2E

.skipL0390
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0391 ;  data _Data_Number_to_Bit

	JMP .skipL0391
_Data_Number_to_Bit
	.byte    %00000001

	.byte    %00000010

	.byte    %00000100

	.byte    %00001000

	.byte    %00010000

	.byte    %00100000

	.byte    %01000000

	.byte    %10000000

.skipL0391
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0392 ;  bank 3

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

.
 ; 

.
 ; 

.__Continue_in_Bank_3
 ; __Continue_in_Bank_3

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0393 ;  if !switchreset then _Bit0_Reset_Restrainer{0}  =  0  :  goto __Main_Loop bank1

 lda #1
 bit SWCHB
	BEQ .skipL0393
.condpart74
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
.skipL0393
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0394 ;  if _Bit0_Reset_Restrainer{0} then goto __Main_Loop bank1

	LDA _Bit0_Reset_Restrainer
	LSR
	BCC .skipL0394
.condpart75
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
.skipL0394
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0395 ;  goto __Start_Restart bank1

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

.L0396 ;  bank 4

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
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0397 ;  inline 6lives.asm

 include 6lives.asm

 if (<*) > (<(*+8))
	repeat ($100-<*)
	.byte 0
	repend
	endif
lives__L0173
	.byte    %00000000
	.byte    %00011000
	.byte    %00100100
	.byte    %01011010
	.byte    %10011001
	.byte    %01011010
	.byte    %00100100
	.byte    %00011000
 if (<*) > (<(*+9))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playercolorL0214_1
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
playerL0215_1
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
playercolorL0226_1
	.byte    _26
	.byte    _9C
	.byte    _9C
	.byte    _9C
	.byte    _DA
	.byte    _DA
	.byte    _3C
	.byte    _26
	.byte    _26
	.byte    _26
 if (<*) > (<(*+9))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playercolorL0280_1
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
playerL0283_1
	.byte    %01100110
	.byte    %01100110
	.byte    %00111100
	.byte    %00001100
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
playerL0285_1
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
playerL0287_1
	.byte    %00110110
	.byte    %00110110
	.byte    %00011100
	.byte    %00001100
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
playerL0289_1
	.byte    %00111100
	.byte    %00011100
	.byte    %00011100
	.byte    %00000100
	.byte    %00011100
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
playerL0291_1
	.byte    %01100110
	.byte    %00100100
	.byte    %00011100
	.byte    %00011000
	.byte    %01111010
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
playerL0293_1
	.byte    %01100000
	.byte    %00100110
	.byte    %00111100
	.byte    %00011000
	.byte    %00111110
	.byte    %00111110
	.byte    %00011000
	.byte    %00111100
	.byte    %00111100
	.byte    %00011000
 if (<*) > (<(*+9))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0295_1
	.byte    %01100110
	.byte    %00100100
	.byte    %00111000
	.byte    %00011000
	.byte    %01011110
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
playerL0297_1
	.byte    %00000110
	.byte    %01100100
	.byte    %00111100
	.byte    %00011000
	.byte    %01111100
	.byte    %01111100
	.byte    %00011000
	.byte    %00111100
	.byte    %00111100
	.byte    %00011000
 if ECHOFIRST
       echo "    ",[(scoretable - *)]d , "bytes of ROM space left in bank 4")
 endif 
ECHOFIRST = 1
 
 
 
