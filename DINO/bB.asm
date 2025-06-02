game
.L00 ;  rem set kernel_options pfcolors no_blank_lines background

.L01 ;  set kernel_options no_blank_lines

.L02 ;  set romsize 2k

.
 ; 

.L03 ;  set optimization size

.L04 ;  rem set optimization noinlinedata

.
 ; 

.L05 ;  rem COLUPF=$06 :rem PlayField Gray

.L06 ;  scorecolor = $06

	LDA #$06
	STA scorecolor
.L07 ;  AUDV0 = 8

	LDA #8
	STA AUDV0
.L08 ;  player0x = 41

	LDA #41
	STA player0x
.L09 ;  const pfres = 1

.L010 ;  const pfrowheight = 64

.
 ; 

.
 ; 

.L011 ;  dim _velocity = a

.L012 ;  dim _frameCounter = b

.L013 ;  dim _rng = c

.L014 ;  dim _scoreTemp = d

.L015 ;  dim _speed = e

.L016 ;  dim _checkpointCount = f

.L017 ;  dim _bgColor = g

.
 ; 

.L018 ;  dim _Bit7_Flip_P1  =  y

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__title
 ; __title

.L019 ;  player0y = 65

	LDA #65
	STA player0y
.L020 ;  player1x = 0

	LDA #0
	STA player1x
.L021 ;  _speed = 2

	LDA #2
	STA _speed
.L022 ;  score = 0

	LDA #$00
	STA score+2
	LDA #$00
	STA score+1
	LDA #$00
	STA score
.L023 ;  _scoreTemp = 0

	LDA #0
	STA _scoreTemp
.L024 ;  _checkpointCount = 0

	LDA #0
	STA _checkpointCount
.L025 ;  _velocity = 10

	LDA #10
	STA _velocity
.L026 ;  gosub __pfidle

 jsr .__pfidle

.L027 ;  gosub __draw

 jsr .__draw

.L028 ;  if !joy0fire  &&  !joy0up then goto __title

 bit INPT4
	BPL .skipL028
.condpart0
 lda #$10
 bit SWCHA
	BEQ .skip0then
.condpart1
 jmp .__title

.skip0then
.skipL028
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__mainloop
 ; __mainloop

.L029 ;  _frameCounter = _frameCounter + 1

	INC _frameCounter
.L030 ;  if _frameCounter >= 6 then missile0x = missile0x - _speed : score = score + _speed : _scoreTemp = _scoreTemp + _speed : _frameCounter = 0

	LDA _frameCounter
	CMP #6
     BCC .skipL030
.condpart2
	LDA missile0x
	SEC
	SBC _speed
	STA missile0x
	SED
	CLC
	LDA score+2
	ADC _speed
	STA score+2
	LDA score+1
	ADC #0
	STA score+1
	LDA score
	ADC #0
	STA score
	CLD
	LDA _scoreTemp
	CLC
	ADC _speed
	STA _scoreTemp
	LDA #0
	STA _frameCounter
.skipL030
.L031 ;  if missile0x > 200 then missile0x = missile0x + 160

	LDA #200
	CMP missile0x
     BCS .skipL031
.condpart3
	LDA missile0x
	CLC
	ADC #160
	STA missile0x
.skipL031
.L032 ;  player1x = player1x - _speed

	LDA player1x
	SEC
	SBC _speed
	STA player1x
.L033 ;  if player1x > 200 then gosub __nextObj

	LDA #200
	CMP player1x
     BCS .skipL033
.condpart4
 jsr .__nextObj

.skipL033
.
 ; 

.L034 ;  if _rng = 3 then gosub __animBird else gosub __obcactus

	LDA _rng
	CMP #3
     BNE .skipL034
.condpart5
 jsr .__animBird
 jmp .skipelse0
.skipL034
 jsr .__obcactus

.skipelse0
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L035 ;  player0y =  ( player0y - _velocity )  + 10

; complex statement detected
	LDA player0y
	SEC
	SBC _velocity
	CLC
	ADC #10
	STA player0y
.L036 ;  gosub __physics

 jsr .__physics

.L037 ;  if joy0down then gosub __physics : gosub __pfduck

 lda #$20
 bit SWCHA
	BNE .skipL037
.condpart6
 jsr .__physics
 jsr .__pfduck

.skipL037
.
 ; 

.
 ; 

.L038 ;  if _scoreTemp >= 100 then gosub __checkpoint

	LDA _scoreTemp
	CMP #100
     BCC .skipL038
.condpart7
 jsr .__checkpoint

.skipL038
.
 ; 

.
 ; 

.
 ; 

.L039 ;  if collision(player0,player1) then goto __gameover

	bit 	CXPPMM
	BPL .skipL039
.condpart8
 jmp .__gameover

.skipL039
.L040 ;  gosub __draw

 jsr .__draw

.L041 ;  goto __mainloop

 jmp .__mainloop

.
 ; 

.__draw
 ; __draw

.L042 ;  if switchbw then gosub __bg_black else gosub __bg_white

 lda #8
 bit SWCHB
	BNE .skipL042
.condpart9
 jsr .__bg_black
 jmp .skipelse1
.skipL042
 jsr .__bg_white

.skipelse1
.L043 ;  if _rng < 3  &&  _Bit7_Flip_P1{7} then REFP1  =  8

	LDA _rng
	CMP #3
     BCS .skipL043
.condpart10
	BIT _Bit7_Flip_P1
	BPL .skip10then
.condpart11
	LDA #8
	STA REFP1
.skip10then
.skipL043
.L044 ;  if _rng <= 1 then NUSIZ1 = $31

	LDA #1
	CMP _rng
     BCC .skipL044
.condpart12
	LDA #$31
	STA NUSIZ1
.skipL044
.L045 ;  COLUBK = _bgColor

	LDA _bgColor
	STA COLUBK
.L046 ;  drawscreen

 jsr drawscreen
.L047 ;  AUDC0 = 0

	LDA #0
	STA AUDC0
.L048 ;  AUDF0 = 12

	LDA #12
	STA AUDF0
.L049 ;  if switchreset then pop : goto __title

 lda #1
 bit SWCHB
	BNE .skipL049
.condpart13
	pla
	pla
 jmp .__title

.skipL049
.L050 ;  return

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

.L051 ;  rem **********

.L052 ;  rem Reused suff

.L053 ;  rem **********

.
 ; 

.__physics
 ; __physics

.L054 ;  if player0y  >=  65 then gosub __touchingGnd else gosub __gravity

	LDA player0y
	CMP #65
     BCC .skipL054
.condpart14
 jsr .__touchingGnd
 jmp .skipelse2
.skipL054
 jsr .__gravity

.skipelse2
.L055 ;  return

	RTS
.
 ; 

.__touchingGnd
 ; __touchingGnd

.L056 ;  player0y = 65

	LDA #65
	STA player0y
.L057 ;  _velocity = 10

	LDA #10
	STA _velocity
.L058 ;  if _frameCounter = 1 then gosub __input

	LDA _frameCounter
	CMP #1
     BNE .skipL058
.condpart15
 jsr .__input

.skipL058
.L059 ;  if _frameCounter < 3 then gosub __pf2 else gosub __pf3

	LDA _frameCounter
	CMP #3
     BCS .skipL059
.condpart16
 jsr .__pf2
 jmp .skipelse3
.skipL059
 jsr .__pf3

.skipelse3
.L060 ;  return

	RTS
.
 ; 

.__input
 ; __input

.L061 ;  if joy0fire  ||  joy0up then AUDC0 = 12 : _velocity = 13

 bit INPT4
	BMI .skipL061
.condpart17
 jmp .condpart18
.skipL061
 lda #$10
 bit SWCHA
	BNE .skip2OR
.condpart18
	LDA #12
	STA AUDC0
	LDA #13
	STA _velocity
.skip2OR
.L062 ;  return

	RTS
.
 ; 

.__gravity
 ; __gravity

.L063 ;  if _velocity > 0  &&  _frameCounter = 4 then _velocity = _velocity - 1

	LDA #0
	CMP _velocity
     BCS .skipL063
.condpart19
	LDA _frameCounter
	CMP #4
     BNE .skip19then
.condpart20
	DEC _velocity
.skip19then
.skipL063
.L064 ;  gosub __pfidle

 jsr .__pfidle

.L065 ;  return

	RTS
.
 ; 

.__nextObj
 ; __nextObj

.L066 ;  _rng =  ( rand & 3 ) 

; complex statement detected
 jsr randomize
	AND #3
	STA _rng
.L067 ;  player1x = 157 +  ( _rng ) 

; complex statement detected
	LDA #157
	CLC
	ADC _rng
	STA player1x
.L068 ;  if _rng = 3 then player1y = 56 else player1y = 65

	LDA _rng
	CMP #3
     BNE .skipL068
.condpart21
	LDA #56
	STA player1y
 jmp .skipelse4
.skipL068
	LDA #65
	STA player1y
.skipelse4
.L069 ;  _Bit7_Flip_P1{7}  =  !_Bit7_Flip_P1{7}

	LDA _Bit7_Flip_P1
	AND #128
  PHP
	LDA _Bit7_Flip_P1
	AND #127
  PLP
	.byte $D0, $02
	ORA #128
	STA _Bit7_Flip_P1
.L070 ;  return

	RTS
.
 ; 

.__animBird
 ; __animBird

.L071 ;  if _frameCounter < 3 then gosub __obbird1 else gosub __obbird2

	LDA _frameCounter
	CMP #3
     BCS .skipL071
.condpart22
 jsr .__obbird1
 jmp .skipelse5
.skipL071
 jsr .__obbird2

.skipelse5
.L072 ;  return

	RTS
.
 ; 

.__checkpoint
 ; __checkpoint

.L073 ;  AUDF0 = 5

	LDA #5
	STA AUDF0
.L074 ;  AUDC0 = 12

	LDA #12
	STA AUDC0
.L075 ;  if _checkpointCount >= 3  &&  _speed < 4 then _speed = _speed + 1 : _checkpointCount = 0 else _scoreTemp = 0 : _checkpointCount = _checkpointCount + 1

	LDA _checkpointCount
	CMP #3
     BCC .skipL075
.condpart23
	LDA _speed
	CMP #4
     BCS .skip23then
.condpart24
	INC _speed
	LDA #0
	STA _checkpointCount
 jmp .skipelse6
.skip23then
.skipL075
	LDA #0
	STA _scoreTemp
	INC _checkpointCount
.skipelse6
.L076 ;  return

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

.__gameover
 ; __gameover

.L077 ;  AUDC0 = 7

	LDA #7
	STA AUDC0
.L078 ;  gosub __pfdead

 jsr .__pfdead

.
 ; 

.__gameover1
 ; __gameover1

.L079 ;  gosub __draw

 jsr .__draw

.L080 ;  if joy0fire  ||  joy0up then goto __gameover1

 bit INPT4
	BMI .skipL080
.condpart25
 jmp .condpart26
.skipL080
 lda #$10
 bit SWCHA
	BNE .skip5OR
.condpart26
 jmp .__gameover1

.skip5OR
.
 ; 

.__gameover2
 ; __gameover2

.L081 ;  gosub __draw

 jsr .__draw

.L082 ;  if !joy0fire  &&  !joy0up then goto __gameover2

 bit INPT4
	BPL .skipL082
.condpart27
 lda #$10
 bit SWCHA
	BEQ .skip27then
.condpart28
 jmp .__gameover2

.skip27then
.skipL082
.
 ; 

.__gameover3
 ; __gameover3

.L083 ;  gosub __draw

 jsr .__draw

.L084 ;  if joy0fire  ||  joy0up then goto __gameover3

 bit INPT4
	BMI .skipL084
.condpart29
 jmp .condpart30
.skipL084
 lda #$10
 bit SWCHA
	BNE .skip7OR
.condpart30
 jmp .__gameover3

.skip7OR
.L085 ;  goto __title

 jmp .__title

.
 ; 

.__bg_white
 ; __bg_white

.L086 ;  _bgColor = $0F

	LDA #$0F
	STA _bgColor
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L087 ;  return

	RTS
.
 ; 

.__bg_black
 ; __bg_black

.L088 ;  _bgColor = $00

	LDA #$00
	STA _bgColor
.L089 ;  ENAM0 = 2

	LDA #2
	STA ENAM0
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L090 ;  return

	RTS
.
 ; 

.
 ; 

.L091 ;  rem *********************

.L092 ;  rem Area reserved for GFX

.L093 ;  rem *********************

.
 ; 

.L094 ;  rem __pf2

.L095 ;  rem __pf3

.L096 ;  rem __pfdead

.__pfidle
 ; __pfidle

.
 ; 

.L097 ;  player0:

	LDX #<playerL097_0
	STX player0pointerlo
	LDA #>playerL097_0
	STA player0pointerhi
	LDA #12
	STA player0height
.L098 ;  return

	RTS
.
 ; 

.
 ; 

.
 ; 

.__pf2
 ; __pf2

.L099 ;  player0:

	LDX #<playerL099_0
	STX player0pointerlo
	LDA #>playerL099_0
	STA player0pointerhi
	LDA #12
	STA player0height
.L0100 ;  return

	RTS
.
 ; 

.__pf3
 ; __pf3

.L0101 ;  player0:

	LDX #<playerL0101_0
	STX player0pointerlo
	LDA #>playerL0101_0
	STA player0pointerhi
	LDA #12
	STA player0height
.L0102 ;  return

	RTS
.
 ; 

.
 ; 

.
 ; 

.__pfdead
 ; __pfdead

.L0103 ;  player0:

	LDX #<playerL0103_0
	STX player0pointerlo
	LDA #>playerL0103_0
	STA player0pointerhi
	LDA #12
	STA player0height
.L0104 ;  return

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

.__pfduck
 ; __pfduck

.L0105 ;  player0:

	LDX #<playerL0105_0
	STX player0pointerlo
	LDA #>playerL0105_0
	STA player0pointerhi
	LDA #7
	STA player0height
.L0106 ;  return

	RTS
.
 ; 

.__obcactus
 ; __obcactus

.L0107 ;  player1:

	LDX #<playerL0107_1
	STX player1pointerlo
	LDA #>playerL0107_1
	STA player1pointerhi
	LDA #12
	STA player1height
.L0108 ;  return

	RTS
.
 ; 

.__obbird1
 ; __obbird1

.L0109 ;  player1:

	LDX #<playerL0109_1
	STX player1pointerlo
	LDA #>playerL0109_1
	STA player1pointerhi
	LDA #9
	STA player1height
.L0110 ;  return

	RTS
.
 ; 

.__obbird2
 ; __obbird2

.L0111 ;  player1:

	LDX #<playerL0111_1
	STX player1pointerlo
	LDA #>playerL0111_1
	STA player1pointerhi
	LDA #10
	STA player1height
.L0112 ;  return

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

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0113 ;  rem Enables the starfield effect thing

.L0114 ;  vblank

vblank_bB_code
.L0115 ;  asm

 sta HMCLR

 sta WSYNC

 lda #$ff

 sta HMM0

 lda #$c0

 sta WSYNC

 sta HMOVE

 sleep 5

 sta HMM0

.L0116 ;  return

	RTS
.
 ; 

.
 ; 

.L0117 ;  rem To make cool line at bottom of display to be the desert floor

.L0118 ;  asm

minikernel

 sta WSYNC

 lda $06

 sta COLUBK

 sta WSYNC

 lda _bgColor

 sta COLUBK

 rts

 if (<*) > (<(*+12))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL097_0
	.byte  %00101000
	.byte  %00101000
	.byte  %00101000
	.byte  %01111000
	.byte  %11111010
	.byte  %11111110
	.byte  %10111000
	.byte  %10011000
	.byte  %00001110
	.byte  %00001000
	.byte  %00001111
	.byte  %00001011
	.byte  %00000110
 if (<*) > (<(*+12))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL099_0
	.byte  %00001000
	.byte  %00001000
	.byte  %00101000
	.byte  %01111000
	.byte  %11111010
	.byte  %11111110
	.byte  %10111000
	.byte  %10011000
	.byte  %00001110
	.byte  %00001000
	.byte  %00001111
	.byte  %00001011
	.byte  %00000110
 if (<*) > (<(*+12))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0101_0
	.byte  %00100000
	.byte  %00100000
	.byte  %00101000
	.byte  %01111000
	.byte  %11111010
	.byte  %11111110
	.byte  %10111000
	.byte  %10011000
	.byte  %00001110
	.byte  %00001000
	.byte  %00001111
	.byte  %00001011
	.byte  %00000110
 if (<*) > (<(*+12))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0103_0
	.byte  %00101000
	.byte  %00101000
	.byte  %00101000
	.byte  %01111000
	.byte  %11111010
	.byte  %11111110
	.byte  %10111000
	.byte  %10011000
	.byte  %00001000
	.byte  %00001110
	.byte  %00001001
	.byte  %00001001
	.byte  %00000110
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0105_0
	.byte  %10100000
	.byte  %10101000
	.byte  %11111110
	.byte  %11111000
	.byte  %11111111
	.byte  %10111111
	.byte  %10001011
	.byte  %00000110
 if (<*) > (<(*+12))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0107_1
	.byte  %00111000
	.byte  %00111000
	.byte  %00111000
	.byte  %00111110
	.byte  %00111111
	.byte  %00111011
	.byte  %11111011
	.byte  %10111011
	.byte  %10111011
	.byte  %10111011
	.byte  %10111000
	.byte  %00111000
	.byte  %00010000
 if (<*) > (<(*+9))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0109_1
	.byte  %00010000
	.byte  %00011000
	.byte  %00011100
	.byte  %00011111
	.byte  %00011110
	.byte  %00011111
	.byte  %00111100
	.byte  %11110000
	.byte  %01100000
	.byte  %00100000
 if (<*) > (<(*+10))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0111_1
	.byte  %00000000
	.byte  %00000000
	.byte  %00000000
	.byte  %00000000
	.byte  %00000000
	.byte  %00011111
	.byte  %00111110
	.byte  %11111111
	.byte  %01101110
	.byte  %00101100
	.byte  %00001000
 if ECHOFIRST
       echo "    ",[(scoretable - *)]d , "bytes of ROM space left")
 endif 
ECHOFIRST = 1
 
 
 
