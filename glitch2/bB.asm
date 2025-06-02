game
.L00 ;  include fixed_point_math.asm

.L01 ;  include div_mul.asm

.L02 ;  set kernel_options no_blank_lines

.
 ; 

.L03 ;  dim _sc1  =  score

.L04 ;  dim _sc2  =  score + 1

.L05 ;  dim _sc3  =  score + 2

.
 ; 

.L06 ;  rem Setup 8.8 fixed point variables for smooth movement

.L07 ;  dim _player0x = player0x.a

.L08 ;  dim _player1x = player1x.b

.L09 ;  dim _missile0x =  missile0x.c

.L010 ;  dim _missile1x =  missile1x.d

.L011 ;  dim _ballx = ballx.e

.
 ; 

.L012 ;  dim _player0shift = f.g

.L013 ;  dim _player1shift = h.i

.L014 ;  dim _ballShift = j.k

.L015 ;  dim _missile0shift = l.m

.L016 ;  dim _missile1shift = n.o

.L017 ;  dim moveAmount = p.q

.
 ; 

.
 ; 

.L018 ;  dim buttonPressed = x

.L019 ;  dim editing = y

.L020 ;  dim currentPreview = z

.
 ; 

.
 ; 

.L021 ;  gosub getPlayers

 jsr .getPlayers

.L022 ;  rem This is the smallest amount that a fraction of 8.8 can be moved

.L023 ;  moveAmount = 0.003921

	LDX #1
	STX q
	LDA #0
	STA moveAmount
.
 ; 

.L024 ;  rem The 2 data arrays hold the visual preset positions

.L025 ;  rem Even numbers are the whole and odd the fractions

.L026 ;  data shiftPostions0

	JMP .skipL026
shiftPostions0
	.byte 	1 

	.byte 	16 

	.byte 	17 

	.byte 	238 

	.byte 	239 

	.byte 	240 

	.byte 	255	

.skipL026
.
 ; 

.
 ; 

.
 ; 

.L027 ;  rem 

.L028 ;  rem  player0:

.L029 ;  rem  %00011000

.L030 ;  rem  %01100110

.L031 ;  rem  %01100110

.L032 ;  rem  %00111100

.L033 ;  rem  %00111100

.L034 ;  rem  %01011010

.L035 ;  rem  %01100110

.L036 ;  rem  %00011000

.L037 ;  rem end

.
 ; 

.resetPoint
 ; resetPoint

.L038 ;  rem Read data for movement

.L039 ;  f = shiftPostions0[currentPreview]

	LDX currentPreview
	LDA shiftPostions0,x
	STA f
.L040 ;  h = shiftPostions0[currentPreview]

	LDX currentPreview
	LDA shiftPostions0,x
	STA h
.L041 ;  j = shiftPostions0[currentPreview]

	LDX currentPreview
	LDA shiftPostions0,x
	STA j
.L042 ;  l = shiftPostions0[currentPreview]

	LDX currentPreview
	LDA shiftPostions0,x
	STA l
.L043 ;  n = shiftPostions0[currentPreview]

	LDX currentPreview
	LDA shiftPostions0,x
	STA n
.L044 ;  temp3 = currentPreview + 1

	LDA currentPreview
	CLC
	ADC #1
	STA temp3
.
 ; 

.L045 ;  g = 0

	LDA #0
	STA g
.L046 ;  i = 50

	LDA #50
	STA i
.L047 ;  k = 100

	LDA #100
	STA k
.L048 ;  m = 150

	LDA #150
	STA m
.L049 ;  o = 200

	LDA #200
	STA o
.L050 ;  currentPreview = temp3

	LDA temp3
	STA currentPreview
.
 ; 

.L051 ;  if currentPreview = shiftPostions0_length then currentPreview = 0

	LDA currentPreview
	CMP #shiftPostions0_length
     BNE .skipL051
.condpart0
	LDA #0
	STA currentPreview
.skipL051
.
 ; 

.L052 ;  editing = 4

	LDA #4
	STA editing
.L053 ;  gosub changeEdit

 jsr .changeEdit

.main
 ; main

.L054 ;  ENAM0 = 2

	LDA #2
	STA ENAM0
.L055 ;  missile1height = 0

	LDA #0
	STA missile1height
.L056 ;  ballheight = 255

	LDA #255
	STA ballheight
.
 ; 

.L057 ;  CTRLPF = $01

	LDA #$01
	STA CTRLPF
.
 ; 

.
 ; 

.L058 ;  player0height = 255

	LDA #255
	STA player0height
.L059 ;  player1height = 255

	LDA #255
	STA player1height
.
 ; 

.L060 ;  missile0height = 10

	LDA #10
	STA missile0height
.L061 ;  rem By making missile1height 255 it was able to wrap around the whole screen

.
 ; 

.L062 ;  COLUP0 = 196

	LDA #196
	STA COLUP0
.L063 ;  COLUP1  =  64

	LDA #64
	STA COLUP1
.L064 ;  COLUBK  =  00

	LDA #00
	STA COLUBK
.L065 ;  COLUPF = 132

	LDA #132
	STA COLUPF
.
 ; 

.L066 ;  rem Changes whether you're editing the green or red missile

.L067 ;  if joy0fire  &&  buttonPressed = 0 then gosub changeEdit

 bit INPT4
	BMI .skipL067
.condpart1
	LDA buttonPressed
	CMP #0
     BNE .skip1then
.condpart2
 jsr .changeEdit

.skip1then
.skipL067
.L068 ;  if editing = 0 then goto checkInput0

	LDA editing
	CMP #0
     BNE .skipL068
.condpart3
 jmp .checkInput0

.skipL068
.L069 ;  if editing = 1 then goto checkInput1

	LDA editing
	CMP #1
     BNE .skipL069
.condpart4
 jmp .checkInput1

.skipL069
.L070 ;  if editing = 2 then goto checkInput2

	LDA editing
	CMP #2
     BNE .skipL070
.condpart5
 jmp .checkInput2

.skipL070
.L071 ;  if editing = 3 then goto checkInput3

	LDA editing
	CMP #3
     BNE .skipL071
.condpart6
 jmp .checkInput3

.skipL071
.L072 ;  if editing = 4 then goto checkInput4

	LDA editing
	CMP #4
     BNE .skipL072
.condpart7
 jmp .checkInput4

.skipL072
.checkedInput
 ; checkedInput

.L073 ;  rem Update positions and check limits

.L074 ;  _player0x = _player0x + _player0shift

	LDA a
	CLC 
	ADC g
	STA a
	LDA _player0x
	ADC _player0shift
	STA _player0x
.L075 ;  _player1x = _player1x + _player1shift

	LDA b
	CLC 
	ADC i
	STA b
	LDA _player1x
	ADC _player1shift
	STA _player1x
.L076 ;  _ballx = _ballx + _ballShift

	LDA e
	CLC 
	ADC k
	STA e
	LDA _ballx
	ADC _ballShift
	STA _ballx
.L077 ;  _missile0x = _missile0x + _missile0shift

	LDA c
	CLC 
	ADC m
	STA c
	LDA _missile0x
	ADC _missile0shift
	STA _missile0x
.L078 ;  _missile1x = _missile1x + _missile1shift

	LDA d
	CLC 
	ADC o
	STA d
	LDA _missile1x
	ADC _missile1shift
	STA _missile1x
.
 ; 

.L079 ;  if player0x > 200 then player0x = player0x + 160

	LDA #200
	CMP player0x
     BCS .skipL079
.condpart8
	LDA player0x
	CLC
	ADC #160
	STA player0x
.skipL079
.L080 ;  if player0x > 159 then player0x = player0x - 160

	LDA #159
	CMP player0x
     BCS .skipL080
.condpart9
	LDA player0x
	SEC
	SBC #160
	STA player0x
.skipL080
.
 ; 

.L081 ;  if player1x > 200 then player1x = player1x + 160

	LDA #200
	CMP player1x
     BCS .skipL081
.condpart10
	LDA player1x
	CLC
	ADC #160
	STA player1x
.skipL081
.L082 ;  if player1x > 159 then player1x = player1x - 160

	LDA #159
	CMP player1x
     BCS .skipL082
.condpart11
	LDA player1x
	SEC
	SBC #160
	STA player1x
.skipL082
.
 ; 

.
 ; 

.L083 ;  if missile0x > 200 then missile0x = missile0x + 160

	LDA #200
	CMP missile0x
     BCS .skipL083
.condpart12
	LDA missile0x
	CLC
	ADC #160
	STA missile0x
.skipL083
.L084 ;  if missile0x > 159 then missile0x = missile0x - 160

	LDA #159
	CMP missile0x
     BCS .skipL084
.condpart13
	LDA missile0x
	SEC
	SBC #160
	STA missile0x
.skipL084
.
 ; 

.L085 ;  if missile1x > 200 then missile1x = missile1x + 160

	LDA #200
	CMP missile1x
     BCS .skipL085
.condpart14
	LDA missile1x
	CLC
	ADC #160
	STA missile1x
.skipL085
.L086 ;  if missile1x > 159 then missile1x = missile1x - 160

	LDA #159
	CMP missile1x
     BCS .skipL086
.condpart15
	LDA missile1x
	SEC
	SBC #160
	STA missile1x
.skipL086
.
 ; 

.L087 ;  if ballx > 200 then ballx = ballx + 160

	LDA #200
	CMP ballx
     BCS .skipL087
.condpart16
	LDA ballx
	CLC
	ADC #160
	STA ballx
.skipL087
.L088 ;  if ballx > 159 then ballx = ballx - 160

	LDA #159
	CMP ballx
     BCS .skipL088
.condpart17
	LDA ballx
	SEC
	SBC #160
	STA ballx
.skipL088
.
 ; 

.L089 ;  gosub trace

 jsr .trace

.L090 ;  drawscreen

 jsr drawscreen
.
 ; 

.L091 ;  rem When reset it will pick the next preset visual

.L092 ;  if switchreset  &&  buttonPressed = 0 then buttonPressed = 1 :  goto resetPoint

 lda #1
 bit SWCHB
	BNE .skipL092
.condpart18
	LDA buttonPressed
	CMP #0
     BNE .skip18then
.condpart19
	LDA #1
	STA buttonPressed
 jmp .resetPoint

.skip18then
.skipL092
.L093 ;  if !joy0fire  &&  !switchreset then buttonPressed = 0

 bit INPT4
	BPL .skipL093
.condpart20
 lda #1
 bit SWCHB
	BEQ .skip20then
.condpart21
	LDA #0
	STA buttonPressed
.skip20then
.skipL093
.
 ; 

.L094 ;  goto main

 jmp .main

.
 ; 

.changeEdit
 ; changeEdit

.L095 ;  rem Picks what colour you're editing

.L096 ;  buttonPressed = 1

	LDA #1
	STA buttonPressed
.L097 ;  editing = editing + 1 :  if editing > 4 then editing = 0

	INC editing
	LDA #4
	CMP editing
     BCS .skipL097
.condpart22
	LDA #0
	STA editing
.skipL097
.L098 ;  if editing = 0 then scorecolor = 196

	LDA editing
	CMP #0
     BNE .skipL098
.condpart23
	LDA #196
	STA scorecolor
.skipL098
.L099 ;  if editing = 1 then scorecolor = 64

	LDA editing
	CMP #1
     BNE .skipL099
.condpart24
	LDA #64
	STA scorecolor
.skipL099
.L0100 ;  if editing = 2 then scorecolor = 132

	LDA editing
	CMP #2
     BNE .skipL0100
.condpart25
	LDA #132
	STA scorecolor
.skipL0100
.L0101 ;  if editing = 3 then scorecolor = 196

	LDA editing
	CMP #3
     BNE .skipL0101
.condpart26
	LDA #196
	STA scorecolor
.skipL0101
.L0102 ;  if editing = 4 then scorecolor = 64

	LDA editing
	CMP #4
     BNE .skipL0102
.condpart27
	LDA #64
	STA scorecolor
.skipL0102
.L0103 ;  return

	RTS
.
 ; 

.L0104 ;  rem Up and down control the whole number and left and right the fraction

.
 ; 

.checkInput0
 ; checkInput0

.L0105 ;  if joy0up then _player0shift = _player0shift + 1

 lda #$10
 bit SWCHA
	BNE .skipL0105
.condpart28
	INC _player0shift
.skipL0105
.L0106 ;  if joy0down then _player0shift = _player0shift - 1

 lda #$20
 bit SWCHA
	BNE .skipL0106
.condpart29
	DEC _player0shift
.skipL0106
.L0107 ;  if joy0right then _player0shift = _player0shift  + moveAmount

 bit SWCHA
	BMI .skipL0107
.condpart30
	LDA g
	CLC 
	ADC q
	STA g
	LDA _player0shift
	ADC moveAmount
	STA _player0shift
.skipL0107
.L0108 ;  if joy0left then _player0shift = _player0shift  - moveAmount

 bit SWCHA
	BVS .skipL0108
.condpart31
	LDA g
	SEC 
	SBC q
	STA g
	LDA _player0shift
	SBC moveAmount
	STA _player0shift
.skipL0108
.L0109 ;  goto checkedInput

 jmp .checkedInput

.
 ; 

.checkInput1
 ; checkInput1

.L0110 ;  if joy0up then _player1shift = _player1shift + 1

 lda #$10
 bit SWCHA
	BNE .skipL0110
.condpart32
	INC _player1shift
.skipL0110
.L0111 ;  if joy0down then _player1shift = _player1shift - 1

 lda #$20
 bit SWCHA
	BNE .skipL0111
.condpart33
	DEC _player1shift
.skipL0111
.L0112 ;  if joy0right then _player1shift = _player1shift  + moveAmount

 bit SWCHA
	BMI .skipL0112
.condpart34
	LDA i
	CLC 
	ADC q
	STA i
	LDA _player1shift
	ADC moveAmount
	STA _player1shift
.skipL0112
.L0113 ;  if joy0left then _player1shift = _player1shift  - moveAmount

 bit SWCHA
	BVS .skipL0113
.condpart35
	LDA i
	SEC 
	SBC q
	STA i
	LDA _player1shift
	SBC moveAmount
	STA _player1shift
.skipL0113
.L0114 ;  goto checkedInput

 jmp .checkedInput

.
 ; 

.checkInput2
 ; checkInput2

.L0115 ;  if joy0up then _ballShift = _ballShift + 1

 lda #$10
 bit SWCHA
	BNE .skipL0115
.condpart36
	INC _ballShift
.skipL0115
.L0116 ;  if joy0down then _ballShift = _ballShift - 1

 lda #$20
 bit SWCHA
	BNE .skipL0116
.condpart37
	DEC _ballShift
.skipL0116
.L0117 ;  if joy0right then _ballShift = _ballShift + moveAmount

 bit SWCHA
	BMI .skipL0117
.condpart38
	LDA k
	CLC 
	ADC q
	STA k
	LDA _ballShift
	ADC moveAmount
	STA _ballShift
.skipL0117
.L0118 ;  if joy0left then _ballShift = _ballShift - moveAmount

 bit SWCHA
	BVS .skipL0118
.condpart39
	LDA k
	SEC 
	SBC q
	STA k
	LDA _ballShift
	SBC moveAmount
	STA _ballShift
.skipL0118
.L0119 ;  goto checkedInput

 jmp .checkedInput

.
 ; 

.checkInput3
 ; checkInput3

.L0120 ;  if joy0up then _missile0shift = _missile0shift + 1

 lda #$10
 bit SWCHA
	BNE .skipL0120
.condpart40
	INC _missile0shift
.skipL0120
.L0121 ;  if joy0down then _missile0shift = _missile0shift - 1

 lda #$20
 bit SWCHA
	BNE .skipL0121
.condpart41
	DEC _missile0shift
.skipL0121
.L0122 ;  if joy0right then _missile0shift = _missile0shift  + moveAmount

 bit SWCHA
	BMI .skipL0122
.condpart42
	LDA m
	CLC 
	ADC q
	STA m
	LDA _missile0shift
	ADC moveAmount
	STA _missile0shift
.skipL0122
.L0123 ;  if joy0left then _missile0shift = _missile0shift  - moveAmount

 bit SWCHA
	BVS .skipL0123
.condpart43
	LDA m
	SEC 
	SBC q
	STA m
	LDA _missile0shift
	SBC moveAmount
	STA _missile0shift
.skipL0123
.L0124 ;  goto checkedInput

 jmp .checkedInput

.
 ; 

.checkInput4
 ; checkInput4

.L0125 ;  if joy0up then _missile1shift = _missile1shift + 1

 lda #$10
 bit SWCHA
	BNE .skipL0125
.condpart44
	INC _missile1shift
.skipL0125
.L0126 ;  if joy0down then _missile1shift = _missile1shift - 1

 lda #$20
 bit SWCHA
	BNE .skipL0126
.condpart45
	DEC _missile1shift
.skipL0126
.L0127 ;  if joy0right then _missile1shift = _missile1shift  + moveAmount

 bit SWCHA
	BMI .skipL0127
.condpart46
	LDA o
	CLC 
	ADC q
	STA o
	LDA _missile1shift
	ADC moveAmount
	STA _missile1shift
.skipL0127
.L0128 ;  if joy0left then _missile1shift = _missile1shift  - moveAmount

 bit SWCHA
	BVS .skipL0128
.condpart47
	LDA o
	SEC 
	SBC q
	STA o
	LDA _missile1shift
	SBC moveAmount
	STA _missile1shift
.skipL0128
.L0129 ;  goto checkedInput

 jmp .checkedInput

.
 ; 

.
 ; 

.
 ; 

.L0130 ;  rem Original code by Random Terrain from ex_multisprite_9_objects.bas

.L0131 ;  rem Uses score to display an 8.8 fixed point variable 

.L0132 ;  rem First 3 digits are the whole number and the second 3 digits the fraction 

.
 ; 

.trace
 ; trace

.L0133 ;  if editing = 0 then temp4 = f :  temp5 = g

	LDA editing
	CMP #0
     BNE .skipL0133
.condpart48
	LDA f
	STA temp4
	LDA g
	STA temp5
.skipL0133
.L0134 ;  if editing = 1 then temp4 = h :  temp5 = i

	LDA editing
	CMP #1
     BNE .skipL0134
.condpart49
	LDA h
	STA temp4
	LDA i
	STA temp5
.skipL0134
.L0135 ;  if editing = 2 then temp4 = j :  temp5 = k

	LDA editing
	CMP #2
     BNE .skipL0135
.condpart50
	LDA j
	STA temp4
	LDA k
	STA temp5
.skipL0135
.L0136 ;  if editing = 3 then temp4 = l :  temp5 = m

	LDA editing
	CMP #3
     BNE .skipL0136
.condpart51
	LDA l
	STA temp4
	LDA m
	STA temp5
.skipL0136
.L0137 ;  if editing = 4 then temp4 = n :  temp5 = o

	LDA editing
	CMP #4
     BNE .skipL0137
.condpart52
	LDA n
	STA temp4
	LDA o
	STA temp5
.skipL0137
.
 ; 

.L0138 ;  _sc1  =  0  :  _sc2  =  _sc2  &  15

	LDA #0
	STA _sc1
	LDA _sc2
	AND #15
	STA _sc2
.L0139 ;  if temp4  >=  100 then _sc1  =  _sc1  +  16  :  temp4  =  temp4  -  100

	LDA temp4
	CMP #100
     BCC .skipL0139
.condpart53
	LDA _sc1
	CLC
	ADC #16
	STA _sc1
	LDA temp4
	SEC
	SBC #100
	STA temp4
.skipL0139
.L0140 ;  if temp4  >=  100 then _sc1  =  _sc1  +  16  :  temp4  =  temp4  -  100

	LDA temp4
	CMP #100
     BCC .skipL0140
.condpart54
	LDA _sc1
	CLC
	ADC #16
	STA _sc1
	LDA temp4
	SEC
	SBC #100
	STA temp4
.skipL0140
.L0141 ;  if temp4  >=  50 then _sc1  =  _sc1  +  5  :  temp4  =  temp4  -  50

	LDA temp4
	CMP #50
     BCC .skipL0141
.condpart55
	LDA _sc1
	CLC
	ADC #5
	STA _sc1
	LDA temp4
	SEC
	SBC #50
	STA temp4
.skipL0141
.L0142 ;  if temp4  >=  30 then _sc1  =  _sc1  +  3  :  temp4  =  temp4  -  30

	LDA temp4
	CMP #30
     BCC .skipL0142
.condpart56
	LDA _sc1
	CLC
	ADC #3
	STA _sc1
	LDA temp4
	SEC
	SBC #30
	STA temp4
.skipL0142
.L0143 ;  if temp4  >=  20 then _sc1  =  _sc1  +  2  :  temp4  =  temp4  -  20

	LDA temp4
	CMP #20
     BCC .skipL0143
.condpart57
	LDA _sc1
	CLC
	ADC #2
	STA _sc1
	LDA temp4
	SEC
	SBC #20
	STA temp4
.skipL0143
.L0144 ;  if temp4  >=  10 then _sc1  =  _sc1  +  1  :  temp4  =  temp4  -  10

	LDA temp4
	CMP #10
     BCC .skipL0144
.condpart58
	INC _sc1
	LDA temp4
	SEC
	SBC #10
	STA temp4
.skipL0144
.L0145 ;  _sc2  =   ( temp4  *  4  *  4 )   |  _sc2

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

.L0146 ;  _sc2  =  _sc2  &  240  :  _sc3  =  0

	LDA _sc2
	AND #240
	STA _sc2
	LDA #0
	STA _sc3
.L0147 ;  if temp5  >=  100 then _sc2  =  _sc2  +  1  :  temp5  =  temp5  -  100

	LDA temp5
	CMP #100
     BCC .skipL0147
.condpart59
	INC _sc2
	LDA temp5
	SEC
	SBC #100
	STA temp5
.skipL0147
.L0148 ;  if temp5  >=  100 then _sc2  =  _sc2  +  1  :  temp5  =  temp5  -  100

	LDA temp5
	CMP #100
     BCC .skipL0148
.condpart60
	INC _sc2
	LDA temp5
	SEC
	SBC #100
	STA temp5
.skipL0148
.L0149 ;  if temp5  >=  50 then _sc3  =  _sc3  +  80  :  temp5  =  temp5  -  50

	LDA temp5
	CMP #50
     BCC .skipL0149
.condpart61
	LDA _sc3
	CLC
	ADC #80
	STA _sc3
	LDA temp5
	SEC
	SBC #50
	STA temp5
.skipL0149
.L0150 ;  if temp5  >=  30 then _sc3  =  _sc3  +  48  :  temp5  =  temp5  -  30

	LDA temp5
	CMP #30
     BCC .skipL0150
.condpart62
	LDA _sc3
	CLC
	ADC #48
	STA _sc3
	LDA temp5
	SEC
	SBC #30
	STA temp5
.skipL0150
.L0151 ;  if temp5  >=  20 then _sc3  =  _sc3  +  32  :  temp5  =  temp5  -  20

	LDA temp5
	CMP #20
     BCC .skipL0151
.condpart63
	LDA _sc3
	CLC
	ADC #32
	STA _sc3
	LDA temp5
	SEC
	SBC #20
	STA temp5
.skipL0151
.L0152 ;  if temp5  >=  10 then _sc3  =  _sc3  +  16  :  temp5  =  temp5  -  10

	LDA temp5
	CMP #10
     BCC .skipL0152
.condpart64
	LDA _sc3
	CLC
	ADC #16
	STA _sc3
	LDA temp5
	SEC
	SBC #10
	STA temp5
.skipL0152
.L0153 ;  _sc3  =  _sc3  |  temp5

	LDA _sc3
	ORA temp5
	STA _sc3
.L0154 ;  return

	RTS
.
 ; 

.L0155 ;  rem Enable the TIA bug

.
 ; 

.
 ; 

.L0156 ;  vblank

vblank_bB_code
.
 ; 

.L0157 ;  HMP0 = 255 :  HMP1 = 255 :  HMM0  =  255 :  HMM1  =  100 :  HMBL = 100

	LDA #255
	STA HMP0
	STA HMP1
	STA HMM0
	LDA #100
	STA HMM1
	STA HMBL
.
 ; 

.L0158 ;  WSYNC = 255

	LDA #255
	STA WSYNC
.L0159 ;  HMOVE  =  255

	LDA #255
	STA HMOVE
.
 ; 

.L0160 ;  HMP0  = 144 :  HMP1  = 144 :  HMM0  =  144 :  HMM1 = 255 :  HMBL  =  255

	LDA #144
	STA HMP0
	STA HMP1
	STA HMM0
	LDA #255
	STA HMM1
	STA HMBL
.
 ; 

.L0161 ;  return

	RTS
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0162 ;  rem order top ball-m0-m1

.L0163 ;  rem order bottom m1-m0-ball

.
 ; 

.
 ; 

.getPlayers
 ; getPlayers

.L0164 ;  player0:

	LDX #<playerL0164_0
	STX player0pointerlo
	LDA #>playerL0164_0
	STA player0pointerhi
	LDA #254
	STA player0height
.
 ; 

.L0165 ;  player1:

	LDX #<playerL0165_1
	STX player1pointerlo
	LDA #>playerL0165_1
	STA player1pointerhi
	LDA #254
	STA player1height
.
 ; 

.
 ; 

.L0166 ;  return

	RTS
.
 ; 

.
 ; 

.
 ; 

.
 ; 

 if (<*) > (<(*+254))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0164_0
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
 if (<*) > (<(*+254))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0165_1
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
 if ECHOFIRST
       echo "    ",[(scoretable - *)]d , "bytes of ROM space left")
 endif 
ECHOFIRST = 1
 
 
 
