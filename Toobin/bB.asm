game
.
 ; 

.
 ; 

.L00 ;  set debug cyclescore

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01 ;  dim _P0x  =  player0x.a

.L02 ;  dim _P0y  =  player0y.b

.
 ; 

.L03 ;  dim _xvelt  =  c.d

.L04 ;  dim _yvelt  =  e.f

.
 ; 

.L05 ;  dim _xvel  =  g.h

.L06 ;  dim _yvel  =  i.j

.
 ; 

.L07 ;  dim _direction  =  k

.L08 ;  dim _frame  =  l

.
 ; 

.L09 ;  dim _bit1_left  =  x

.L010 ;  dim _bit2_right  =  x

.
 ; 

.L011 ;  missile0height  =  88

	LDA #88
	STA missile0height
.L012 ;  missile0y  =  88

	LDA #88
	STA missile0y
.
 ; 

.L013 ;  scorecolor = $0E

	LDA #$0E
	STA scorecolor
.
 ; 

.L014 ;  COLUPF = $2C

	LDA #$2C
	STA COLUPF
.
 ; 

.
 ; 

.L015 ;  _P0x = 44.0 : _P0y = 44.0

	LDX #0
	STX a
	LDA #44
	STA _P0x
	LDX #0
	STX b
	LDA #44
	STA _P0y
.L016 ;  _direction = 0

	LDA #0
	STA _direction
.
 ; 

.L017 ;  playfield:

  ifconst pfres
	  ldx #(12>pfres)*(pfres*pfwidth-1)+(12<=pfres)*47
  else
	  ldx #((12*pfwidth-1)*((12*pfwidth-1)<47))+(47*((12*pfwidth-1)>=47))
  endif
	jmp pflabel0
PF_data0
	.byte %11100000, %00000000
	if (pfwidth>2)
	.byte %00000000, %10000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %10000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %10000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %10000000, %00000000
	if (pfwidth>2)
	.byte %10000000, %10000000
 endif
	.byte %00000000, %10000000
	if (pfwidth>2)
	.byte %10000000, %00000000
 endif
	.byte %10000000, %00000000
	if (pfwidth>2)
	.byte %11000000, %10000000
 endif
	.byte %00000000, %10000000
	if (pfwidth>2)
	.byte %10000000, %00000000
 endif
	.byte %10000000, %00000000
	if (pfwidth>2)
	.byte %10000000, %10000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %11100000, %00000000
	if (pfwidth>2)
	.byte %00000000, %10000000
 endif
	.byte %11111110, %00000000
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

.__main
 ; __main

.
 ; 

.L018 ;  if joy0left then gosub __left else _bit1_left{1} = 0

 bit SWCHA
	BVS .skipL018
.condpart0
 jsr .__left
 jmp .skipelse0
.skipL018
	LDA _bit1_left
	AND #253
	STA _bit1_left
.skipelse0
.L019 ;  if joy0right then gosub __right else _bit2_right{2} = 0

 bit SWCHA
	BMI .skipL019
.condpart1
 jsr .__right
 jmp .skipelse1
.skipL019
	LDA _bit2_right
	AND #251
	STA _bit2_right
.skipelse1
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L020 ;  if _direction = 255 then _direction = 15

	LDA _direction
	CMP #255
     BNE .skipL020
.condpart2
	LDA #15
	STA _direction
.skipL020
.L021 ;  if _direction > 15 then _direction = 0

	LDA #15
	CMP _direction
     BCS .skipL021
.condpart3
	LDA #0
	STA _direction
.skipL021
.L022 ;  on _direction gosub __0 __1 __2 __3 __4 __5 __6 __7 __8 __9 __10 __11 __12 __13 __14 __15

	lda #>(ongosub0-1)
	PHA
	lda #<(ongosub0-1)
	PHA
	LDX _direction
	LDA .L022jumptablehi,x
	PHA
	LDA .L022jumptablelo,x
	PHA
	RTS
.L022jumptablehi
	.byte >(.__0-1)
	.byte >(.__1-1)
	.byte >(.__2-1)
	.byte >(.__3-1)
	.byte >(.__4-1)
	.byte >(.__5-1)
	.byte >(.__6-1)
	.byte >(.__7-1)
	.byte >(.__8-1)
	.byte >(.__9-1)
	.byte >(.__10-1)
	.byte >(.__11-1)
	.byte >(.__12-1)
	.byte >(.__13-1)
	.byte >(.__14-1)
	.byte >(.__15-1)
.L022jumptablelo
	.byte <(.__0-1)
	.byte <(.__1-1)
	.byte <(.__2-1)
	.byte <(.__3-1)
	.byte <(.__4-1)
	.byte <(.__5-1)
	.byte <(.__6-1)
	.byte <(.__7-1)
	.byte <(.__8-1)
	.byte <(.__9-1)
	.byte <(.__10-1)
	.byte <(.__11-1)
	.byte <(.__12-1)
	.byte <(.__13-1)
	.byte <(.__14-1)
	.byte <(.__15-1)
ongosub0
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L023 ;  _P0x = _P0x + _xvel

	LDA a
	CLC 
	ADC h
	STA a
	LDA _P0x
	ADC _xvel
	STA _P0x
.L024 ;  _P0y = _P0y + _yvel

	LDA b
	CLC 
	ADC j
	STA b
	LDA _P0y
	ADC _yvel
	STA _P0y
.L025 ;  if _P0y > 60 then gosub __scroll

	LDA #60
	CMP _P0y
     BCS .skipL025
.condpart4
 jsr .__scroll

.skipL025
.L026 ;  if _P0y > 70 then gosub __scroll

	LDA #70
	CMP _P0y
     BCS .skipL026
.condpart5
 jsr .__scroll

.skipL026
.L027 ;  if _xvel > 200 then _xvel = _xvel + 0.06 else _xvel = _xvel - 0.06

	LDA #200
	CMP _xvel
     BCS .skipL027
.condpart6
	LDA h
	CLC 
	ADC #15
	STA h
	LDA _xvel
	ADC #0
	STA _xvel
 jmp .skipelse2
.skipL027
	LDA h
	SEC 
	SBC #15
	STA h
	LDA _xvel
	SBC #0
	STA _xvel
.skipelse2
.L028 ;  if _yvel > 200 then _yvel = _yvel + 0.06 else _yvel = _yvel - 0.06

	LDA #200
	CMP _yvel
     BCS .skipL028
.condpart7
	LDA j
	CLC 
	ADC #15
	STA j
	LDA _yvel
	ADC #0
	STA _yvel
 jmp .skipelse3
.skipL028
	LDA j
	SEC 
	SBC #15
	STA j
	LDA _yvel
	SBC #0
	STA _yvel
.skipelse3
.L029 ;  if _P0x < 17 then _P0x = 17.0  :  _xvel = 0.0 - _xvel

	LDA _P0x
	CMP #17
     BCS .skipL029
.condpart8
	LDX #0
	STX a
	LDA #17
	STA _P0x
	LDA #0
	SEC 
	SBC h
	STA h
	LDA #0
	SBC _xvel
	STA _xvel
.skipL029
.L030 ;  if _P0x > 137 then _P0x = 137.0  :  _xvel = 0.0 - _xvel

	LDA #137
	CMP _P0x
     BCS .skipL030
.condpart9
	LDX #0
	STX a
	LDA #137
	STA _P0x
	LDA #0
	SEC 
	SBC h
	STA h
	LDA #0
	SBC _xvel
	STA _xvel
.skipL030
.L031 ;  if _P0y < 10 then _P0y = 10.0  :  _yvel = 0.0

	LDA _P0y
	CMP #10
     BCS .skipL031
.condpart10
	LDX #0
	STX b
	LDA #10
	STA _P0y
	LDX #0
	STX j
	LDA #0
	STA _yvel
.skipL031
.
 ; 

.
 ; 

.L032 ;  _frame = _frame + 1

	INC _frame
.L033 ;  if _frame > 20 then _frame = 0  :  missile0x = missile0x + 1

	LDA #20
	CMP _frame
     BCS .skipL033
.condpart11
	LDA #0
	STA _frame
	INC missile0x
.skipL033
.
 ; 

.L034 ;  COLUBK = $9A

	LDA #$9A
	STA COLUBK
.
 ; 

.L035 ;  ENAM0 = 2

	LDA #2
	STA ENAM0
.L036 ;  PF0  =  %11111111

	LDA #%11111111
	STA PF0
.L037 ;  drawscreen

 jsr drawscreen
.L038 ;  goto __main

 jmp .__main

.
 ; 

.
 ; 

.__left
 ; __left

.L039 ;  if !_bit1_left{1} then _direction = _direction - 1  :  gosub __moveForward

	LDA _bit1_left
	AND #2
	BNE .skipL039
.condpart12
	DEC _direction
 jsr .__moveForward

.skipL039
.L040 ;  _bit1_left{1} = 1

	LDA _bit1_left
	ORA #2
	STA _bit1_left
.L041 ;  return

	RTS
.__right
 ; __right

.L042 ;  if !_bit2_right{2} then _direction = _direction + 1  :  gosub __moveForward

	LDA _bit2_right
	AND #4
	BNE .skipL042
.condpart13
	INC _direction
 jsr .__moveForward

.skipL042
.L043 ;  _bit2_right{2} = 1

	LDA _bit2_right
	ORA #4
	STA _bit2_right
.L044 ;  return

	RTS
.
 ; 

.__moveForward
 ; __moveForward

.L045 ;  if _yvel < 1  ||  _yvel > 254 then _yvel = _yvel + _yvelt

	LDA _yvel
	CMP #1
     BCS .skipL045
.condpart14
 jmp .condpart15
.skipL045
	LDA #254
	CMP _yvel
     BCS .skip0OR
.condpart15
	LDA j
	CLC 
	ADC f
	STA j
	LDA _yvel
	ADC _yvelt
	STA _yvel
.skip0OR
.L046 ;  if _direction > 8 then _xvelt = 0.0 - _xvelt

	LDA #8
	CMP _direction
     BCS .skipL046
.condpart16
	LDA #0
	SEC 
	SBC d
	STA d
	LDA #0
	SBC _xvelt
	STA _xvelt
.skipL046
.L047 ;  if _xvel < 1  ||  _xvel > 254 then _xvel = _xvel + _xvelt

	LDA _xvel
	CMP #1
     BCS .skipL047
.condpart17
 jmp .condpart18
.skipL047
	LDA #254
	CMP _xvel
     BCS .skip1OR
.condpart18
	LDA h
	CLC 
	ADC d
	STA h
	LDA _xvel
	ADC _xvelt
	STA _xvel
.skip1OR
.L048 ;  return

	RTS
.
 ; 

.__scroll
 ; __scroll

.L049 ;  _P0y = _P0y - 1

	DEC _P0y
.L050 ;  pfscroll up

	LDA #2
 jsr pfscroll
.L051 ;  missile0x = missile0x - 34

	LDA missile0x
	SEC
	SBC #34
	STA missile0x
.L052 ;  if missile0x > 200 then missile0x = missile0x + 160

	LDA #200
	CMP missile0x
     BCS .skipL052
.condpart19
	LDA missile0x
	CLC
	ADC #160
	STA missile0x
.skipL052
.
 ; 

.L053 ;  return

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

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__0
 ; __0

.L054 ;  _xvelt = 0.0 : _yvelt =  - 1.0

	LDX #0
	STX d
	LDA #0
	STA _xvelt
	LDX #0
	STX f
	LDA #255
	STA _yvelt
.L055 ;  player0:

	LDX #<playerL055_0
	STX player0pointerlo
	LDA #>playerL055_0
	STA player0pointerhi
	LDA #7
	STA player0height
.L056 ;  return

	RTS
.__1
 ; __1

.L057 ;  _xvelt = 0.383 : _yvelt =  - 0.924

	LDX #98
	STX d
	LDA #0
	STA _xvelt
	LDX #19
	STX f
	LDA #255
	STA _yvelt
.L058 ;  player0:

	LDX #<playerL058_0
	STX player0pointerlo
	LDA #>playerL058_0
	STA player0pointerhi
	LDA #7
	STA player0height
.L059 ;  return

	RTS
.__2
 ; __2

.L060 ;  _xvelt = 0.707 : _yvelt =  - 0.707

	LDX #180
	STX d
	LDA #0
	STA _xvelt
	LDX #75
	STX f
	LDA #255
	STA _yvelt
.L061 ;  player0:

	LDX #<playerL061_0
	STX player0pointerlo
	LDA #>playerL061_0
	STA player0pointerhi
	LDA #7
	STA player0height
.L062 ;  return

	RTS
.__3
 ; __3

.L063 ;  _xvelt = 0.924 : _yvelt =  - 0.383

	LDX #236
	STX d
	LDA #0
	STA _xvelt
	LDX #157
	STX f
	LDA #255
	STA _yvelt
.L064 ;  player0:

	LDX #<playerL064_0
	STX player0pointerlo
	LDA #>playerL064_0
	STA player0pointerhi
	LDA #7
	STA player0height
.L065 ;  return

	RTS
.__4
 ; __4

.L066 ;  _xvelt = 1.0 : _yvelt = 0.00

	LDX #0
	STX d
	LDA #1
	STA _xvelt
	LDX #0
	STX f
	LDA #0
	STA _yvelt
.L067 ;  player0:

	LDX #<playerL067_0
	STX player0pointerlo
	LDA #>playerL067_0
	STA player0pointerhi
	LDA #7
	STA player0height
.L068 ;  return

	RTS
.__5
 ; __5

.L069 ;  _xvelt = 0.924 : _yvelt = 0.383

	LDX #236
	STX d
	LDA #0
	STA _xvelt
	LDX #98
	STX f
	LDA #0
	STA _yvelt
.L070 ;  player0:

	LDX #<playerL070_0
	STX player0pointerlo
	LDA #>playerL070_0
	STA player0pointerhi
	LDA #7
	STA player0height
.L071 ;  return

	RTS
.__6
 ; __6

.L072 ;  _xvelt = 0.707 : _yvelt = 0.707

	LDX #180
	STX d
	LDA #0
	STA _xvelt
	LDX #180
	STX f
	LDA #0
	STA _yvelt
.L073 ;  player0:

	LDX #<playerL073_0
	STX player0pointerlo
	LDA #>playerL073_0
	STA player0pointerhi
	LDA #7
	STA player0height
.L074 ;  return

	RTS
.__7
 ; __7

.L075 ;  _xvelt = 0.383 : _yvelt = 0.924

	LDX #98
	STX d
	LDA #0
	STA _xvelt
	LDX #236
	STX f
	LDA #0
	STA _yvelt
.L076 ;  player0:

	LDX #<playerL076_0
	STX player0pointerlo
	LDA #>playerL076_0
	STA player0pointerhi
	LDA #7
	STA player0height
.L077 ;  return

	RTS
.__8
 ; __8

.L078 ;  _xvelt = 0.0 : _yvelt = 1.0

	LDX #0
	STX d
	LDA #0
	STA _xvelt
	LDX #0
	STX f
	LDA #1
	STA _yvelt
.L079 ;  player0:

	LDX #<playerL079_0
	STX player0pointerlo
	LDA #>playerL079_0
	STA player0pointerhi
	LDA #7
	STA player0height
.L080 ;  return

	RTS
.__9
 ; __9

.L081 ;  REFP0 = 8

	LDA #8
	STA REFP0
.L082 ;  goto __7

 jmp .__7

.__10
 ; __10

.L083 ;  REFP0 = 8

	LDA #8
	STA REFP0
.L084 ;  goto __6

 jmp .__6

.__11
 ; __11

.L085 ;  REFP0 = 8

	LDA #8
	STA REFP0
.L086 ;  goto __5

 jmp .__5

.__12
 ; __12

.L087 ;  REFP0 = 8

	LDA #8
	STA REFP0
.L088 ;  goto __4

 jmp .__4

.__13
 ; __13

.L089 ;  REFP0 = 8

	LDA #8
	STA REFP0
.L090 ;  goto __3

 jmp .__3

.__14
 ; __14

.L091 ;  REFP0 = 8

	LDA #8
	STA REFP0
.L092 ;  goto __2

 jmp .__2

.__15
 ; __15

.L093 ;  REFP0 = 8

	LDA #8
	STA REFP0
.L094 ;  goto __1

 jmp .__1

.
 ; 

.
 ; 

.L095 ;  asm

minikernel

   sta WSYNC

   lda #$46

   sta COLUBK

   sta WSYNC

   lda #$44

   sta COLUBK

   rts

.
 ; 

.
 ; 

.L096 ;  vblank

vblank_bB_code
.L097 ;  asm

 sta HMCLR

 sta WSYNC

 lda #$ff

 sta HMM0

 lda #$c0

 sta WSYNC

 sta HMOVE

 sleep 5

 sta HMM0

.L098 ;  return

	RTS
.L099 ;  
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL055_0
	.byte  %00011000
	.byte  %00011000
	.byte  %00111100
	.byte  %01011010
	.byte  %01011010
	.byte  %00011000
	.byte  %00100100
	.byte  %00100100
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL058_0
	.byte  %00110000
	.byte  %00110000
	.byte  %00011110
	.byte  %00111101
	.byte  %01011100
	.byte  %01010110
	.byte  %00010010
	.byte  %00010010
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL061_0
	.byte  %00000000
	.byte  %01100000
	.byte  %01111110
	.byte  %00111000
	.byte  %00111111
	.byte  %00101001
	.byte  %00101000
	.byte  %00001100
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL064_0
	.byte  %00000000
	.byte  %00001100
	.byte  %11010000
	.byte  %11111111
	.byte  %00111000
	.byte  %00111100
	.byte  %00100111
	.byte  %00010000
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL067_0
	.byte  %00000000
	.byte  %00011000
	.byte  %00100011
	.byte  %11111100
	.byte  %11111100
	.byte  %00100011
	.byte  %00011000
	.byte  %00000000
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL070_0
	.byte  %00010000
	.byte  %00100111
	.byte  %00111100
	.byte  %00111000
	.byte  %11111111
	.byte  %11010000
	.byte  %00001100
	.byte  %00000000
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL073_0
	.byte  %00001100
	.byte  %00101000
	.byte  %00101001
	.byte  %00111111
	.byte  %00111000
	.byte  %01111110
	.byte  %01100000
	.byte  %00000000
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL076_0
	.byte  %00010010
	.byte  %00010010
	.byte  %01010110
	.byte  %01011100
	.byte  %00111101
	.byte  %00011110
	.byte  %00110000
	.byte  %00110000
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL079_0
	.byte  %00100100
	.byte  %00100100
	.byte  %00011000
	.byte  %01011010
	.byte  %01011010
	.byte  %00111100
	.byte  %00011000
	.byte  %00011000
 if ECHOFIRST
       echo "    ",[(scoretable - *)]d , "bytes of ROM space left")
 endif 
ECHOFIRST = 1
 
 
 
