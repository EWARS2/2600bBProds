game
.L00 ;  set kernel_options player1colors  : rem playercolors

.
 ; 

.
 ; 

.L01 ;  scorecolor = $0E

	LDA #$0E
	STA scorecolor
.L02 ;  const _animationLength = 26

.
 ; 

.L03 ;  dim _Room = a

.
 ; 

.L04 ;  dim _Bit7P1HFlip = y

.
 ; 

.
 ; 

.L05 ;  COLUPF = $0E

	LDA #$0E
	STA COLUPF
.
 ; 

.
 ; 

.L06 ;  _Room = 1

	LDA #1
	STA _Room
.
 ; 

.L07 ;  dim _frameCounter = a

.
 ; 

.
 ; 

.L08 ;  player1color:

	LDX #<playercolorL08_1
	STX player1color
	LDA #>playercolorL08_1
	STA player1color+1
.
 ; 

.
 ; 

.
 ; 

.__start
 ; __start

.
 ; 

.L09 ;  playfield:

  ifconst pfres
	  ldx #(12>pfres)*(pfres*pfwidth-1)+(12<=pfres)*47
  else
	  ldx #((12*pfwidth-1)*((12*pfwidth-1)<47))+(47*((12*pfwidth-1)>=47))
  endif
	jmp pflabel0
PF_data0
	.byte %11111111, %11111111
	if (pfwidth>2)
	.byte %11111101, %11111111
 endif
	.byte %11111100, %00000000
	if (pfwidth>2)
	.byte %00000000, %11100000
 endif
	.byte %11111000, %00000000
	if (pfwidth>2)
	.byte %00000000, %11100000
 endif
	.byte %11110000, %00000000
	if (pfwidth>2)
	.byte %00000000, %11100000
 endif
	.byte %11100000, %00000000
	if (pfwidth>2)
	.byte %00000000, %11100000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %11100000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %01100000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %11000000
 endif
	.byte %11110000, %00000000
	if (pfwidth>2)
	.byte %00000000, %11111000
 endif
	.byte %11111110, %00000000
	if (pfwidth>2)
	.byte %00000000, %11111110
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

.L010 ;  COLUBK = $C4

	LDA #$C4
	STA COLUBK
.
 ; 

.
 ; 

.L011 ;  player1x = 50 : player1y = 50

	LDA #50
	STA player1x
	STA player1y
.
 ; 

.L012 ;  gosub __playerDown

 jsr .__playerDown

.
 ; 

.__main
 ; __main

.L013 ;  if joy0left then gosub __moveLeft

 bit SWCHA
	BVS .skipL013
.condpart0
 jsr .__moveLeft

.skipL013
.L014 ;  if joy0right then gosub __moveRight

 bit SWCHA
	BMI .skipL014
.condpart1
 jsr .__moveRight

.skipL014
.L015 ;  if joy0up then gosub __moveUp

 lda #$10
 bit SWCHA
	BNE .skipL015
.condpart2
 jsr .__moveUp

.skipL015
.L016 ;  if joy0down then gosub __moveDown

 lda #$20
 bit SWCHA
	BNE .skipL016
.condpart3
 jsr .__moveDown

.skipL016
.L017 ;  if player1x > 200 then player1x = player1x + 160 : _Room = _Room - 1

	LDA #200
	CMP player1x
     BCS .skipL017
.condpart4
	LDA player1x
	CLC
	ADC #160
	STA player1x
	DEC _Room
.skipL017
.L018 ;  if player1x > 159 then player1x = player1x - 160 : _Room = _Room + 1

	LDA #159
	CMP player1x
     BCS .skipL018
.condpart5
	LDA player1x
	SEC
	SBC #160
	STA player1x
	INC _Room
.skipL018
.
 ; 

.L019 ;  gosub __draw

 jsr .__draw

.L020 ;  goto __main

 jmp .__main

.__draw
 ; __draw

.L021 ;  _frameCounter = _frameCounter + 1

	INC _frameCounter
.L022 ;  if _frameCounter >= _animationLength then _frameCounter = 0

	LDA _frameCounter
	CMP #_animationLength
     BCC .skipL022
.condpart6
	LDA #0
	STA _frameCounter
.skipL022
.L023 ;  if _Bit7P1HFlip{7} then REFP1  =  8

	BIT _Bit7P1HFlip
	BPL .skipL023
.condpart7
	LDA #8
	STA REFP1
.skipL023
.L024 ;  rem COLUBK=_DataBGColor[_Room]

.L025 ;  drawscreen

 jsr drawscreen
.L026 ;  if switchreset then goto __start

 lda #1
 bit SWCHB
	BNE .skipL026
.condpart8
 jmp .__start

.skipL026
.L027 ;  return

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

.L028 ;  rem temp5 is x & temp6 is y

.
 ; 

.__moveLeft
 ; __moveLeft

.L029 ;  _Bit7P1HFlip{7} = 1

	LDA _Bit7P1HFlip
	ORA #128
	STA _Bit7P1HFlip
.L030 ;  temp5  =   ( player1x - 18 )  / 4

; complex statement detected
	LDA player1x
	SEC
	SBC #18
	lsr
	lsr
	STA temp5
.L031 ;  temp6  =   ( player1y - 1 )  / 8

; complex statement detected
	LDA player1y
	SEC
	SBC #1
	lsr
	lsr
	lsr
	STA temp6
.L032 ;  if temp5  <  34 then if pfread ( temp5 , temp6 )  then goto __touching

	LDA temp5
	CMP #34
     BCS .skipL032
.condpart9
	LDA temp5
	LDY temp6
 jsr pfread
	BNE .skip9then
.condpart10
 jmp .__touching

.skip9then
.skipL032
.L033 ;  temp6  =   ( player1y - 8 )  / 8

; complex statement detected
	LDA player1y
	SEC
	SBC #8
	lsr
	lsr
	lsr
	STA temp6
.L034 ;  if temp5  <  34 then if pfread ( temp5 , temp6 )  then goto __touching

	LDA temp5
	CMP #34
     BCS .skipL034
.condpart11
	LDA temp5
	LDY temp6
 jsr pfread
	BNE .skip11then
.condpart12
 jmp .__touching

.skip11then
.skipL034
.L035 ;  player1x = player1x - 1

	DEC player1x
.L036 ;  if _frameCounter <  ( _animationLength / 2 )  then gosub __playerWalk0 else gosub __playerWalk1

; complex condition detected
; complex statement detected
	LDA #_animationLength
	lsr
  PHA
  TSX
  PLA
	LDA _frameCounter
	CMP  1,x
     BCS .skipL036
.condpart13
 jsr .__playerWalk0
 jmp .skipelse0
.skipL036
 jsr .__playerWalk1

.skipelse0
.L037 ;  return

	RTS
.
 ; 

.__moveRight
 ; __moveRight

.L038 ;  _Bit7P1HFlip{7} = 0

	LDA _Bit7P1HFlip
	AND #127
	STA _Bit7P1HFlip
.L039 ;  temp5  =   ( player1x - 9 )  / 4

; complex statement detected
	LDA player1x
	SEC
	SBC #9
	lsr
	lsr
	STA temp5
.L040 ;  temp6  =   ( player1y - 1 )  / 8

; complex statement detected
	LDA player1y
	SEC
	SBC #1
	lsr
	lsr
	lsr
	STA temp6
.L041 ;  if temp5  <  34 then if pfread ( temp5 , temp6 )  then goto __touching

	LDA temp5
	CMP #34
     BCS .skipL041
.condpart14
	LDA temp5
	LDY temp6
 jsr pfread
	BNE .skip14then
.condpart15
 jmp .__touching

.skip14then
.skipL041
.L042 ;  temp6  =   ( player1y - 8 )  / 8

; complex statement detected
	LDA player1y
	SEC
	SBC #8
	lsr
	lsr
	lsr
	STA temp6
.L043 ;  if temp5  <  34 then if pfread ( temp5 , temp6 )  then goto __touching

	LDA temp5
	CMP #34
     BCS .skipL043
.condpart16
	LDA temp5
	LDY temp6
 jsr pfread
	BNE .skip16then
.condpart17
 jmp .__touching

.skip16then
.skipL043
.L044 ;  player1x = player1x + 1

	INC player1x
.L045 ;  if _frameCounter <  ( _animationLength / 2 )  then gosub __playerWalk0 else gosub __playerWalk1

; complex condition detected
; complex statement detected
	LDA #_animationLength
	lsr
  PHA
  TSX
  PLA
	LDA _frameCounter
	CMP  1,x
     BCS .skipL045
.condpart18
 jsr .__playerWalk0
 jmp .skipelse1
.skipL045
 jsr .__playerWalk1

.skipelse1
.L046 ;  return

	RTS
.
 ; 

.__moveUp
 ; __moveUp

.L047 ;  temp5  =   ( player1x - 10 )  / 4

; complex statement detected
	LDA player1x
	SEC
	SBC #10
	lsr
	lsr
	STA temp5
.L048 ;  temp6  =   ( player1y - 9 )  / 8

; complex statement detected
	LDA player1y
	SEC
	SBC #9
	lsr
	lsr
	lsr
	STA temp6
.L049 ;  if temp5  <  34 then if pfread ( temp5 , temp6 )  then goto __touching

	LDA temp5
	CMP #34
     BCS .skipL049
.condpart19
	LDA temp5
	LDY temp6
 jsr pfread
	BNE .skip19then
.condpart20
 jmp .__touching

.skip19then
.skipL049
.L050 ;  temp5  =  temp5 - 1

	DEC temp5
.L051 ;  if temp5  <  34 then if pfread ( temp5 , temp6 )  then goto __touching

	LDA temp5
	CMP #34
     BCS .skipL051
.condpart21
	LDA temp5
	LDY temp6
 jsr pfread
	BNE .skip21then
.condpart22
 jmp .__touching

.skip21then
.skipL051
.L052 ;  temp5  =   ( player1x - 17 )  / 4

; complex statement detected
	LDA player1x
	SEC
	SBC #17
	lsr
	lsr
	STA temp5
.L053 ;  if temp5  <  34 then if pfread ( temp5 , temp6 )  then goto __touching

	LDA temp5
	CMP #34
     BCS .skipL053
.condpart23
	LDA temp5
	LDY temp6
 jsr pfread
	BNE .skip23then
.condpart24
 jmp .__touching

.skip23then
.skipL053
.L054 ;  player1y = player1y - 1

	DEC player1y
.L055 ;  gosub __playerUp

 jsr .__playerUp

.L056 ;  REFP1  =  0

	LDA #0
	STA REFP1
.L057 ;  if _frameCounter <  ( _animationLength / 2 )  then _Bit7P1HFlip{7} = 1 else _Bit7P1HFlip{7} = 0

; complex condition detected
; complex statement detected
	LDA #_animationLength
	lsr
  PHA
  TSX
  PLA
	LDA _frameCounter
	CMP  1,x
     BCS .skipL057
.condpart25
	LDA _Bit7P1HFlip
	ORA #128
	STA _Bit7P1HFlip
 jmp .skipelse2
.skipL057
	LDA _Bit7P1HFlip
	AND #127
	STA _Bit7P1HFlip
.skipelse2
.L058 ;  return

	RTS
.
 ; 

.__moveDown
 ; __moveDown

.L059 ;  temp5  =   ( player1x - 10 )  / 4

; complex statement detected
	LDA player1x
	SEC
	SBC #10
	lsr
	lsr
	STA temp5
.L060 ;  temp6  =   ( player1y )  / 8

; complex statement detected
	LDA player1y
	lsr
	lsr
	lsr
	STA temp6
.L061 ;  if temp5  <  34 then if pfread ( temp5 , temp6 )  then goto __touching

	LDA temp5
	CMP #34
     BCS .skipL061
.condpart26
	LDA temp5
	LDY temp6
 jsr pfread
	BNE .skip26then
.condpart27
 jmp .__touching

.skip26then
.skipL061
.L062 ;  temp5  =  temp5 - 1

	DEC temp5
.L063 ;  if temp5  <  34 then if pfread ( temp5 , temp6 )  then goto __touching

	LDA temp5
	CMP #34
     BCS .skipL063
.condpart28
	LDA temp5
	LDY temp6
 jsr pfread
	BNE .skip28then
.condpart29
 jmp .__touching

.skip28then
.skipL063
.L064 ;  temp5  =   ( player1x - 17 )  / 4

; complex statement detected
	LDA player1x
	SEC
	SBC #17
	lsr
	lsr
	STA temp5
.L065 ;  if temp5  <  34 then if pfread ( temp5 , temp6 )  then goto __touching

	LDA temp5
	CMP #34
     BCS .skipL065
.condpart30
	LDA temp5
	LDY temp6
 jsr pfread
	BNE .skip30then
.condpart31
 jmp .__touching

.skip30then
.skipL065
.L066 ;  player1y = player1y + 1

	INC player1y
.L067 ;  gosub __playerDown

 jsr .__playerDown

.L068 ;  REFP1  =  0

	LDA #0
	STA REFP1
.L069 ;  if _frameCounter <  ( _animationLength / 2 )  then _Bit7P1HFlip{7} = 1 else _Bit7P1HFlip{7} = 0

; complex condition detected
; complex statement detected
	LDA #_animationLength
	lsr
  PHA
  TSX
  PLA
	LDA _frameCounter
	CMP  1,x
     BCS .skipL069
.condpart32
	LDA _Bit7P1HFlip
	ORA #128
	STA _Bit7P1HFlip
 jmp .skipelse3
.skipL069
	LDA _Bit7P1HFlip
	AND #127
	STA _Bit7P1HFlip
.skipelse3
.L070 ;  return

	RTS
.
 ; 

.__notTouching
 ; __notTouching

.L071 ;  temp5 = temp5 - 1 : temp6 = temp6 - 1

	DEC temp5
	DEC temp6
.L072 ;  if joy0fire then pfpixel temp5 temp6 on : score = score - 1

 bit INPT4
	BMI .skipL072
.condpart33
	LDX #0
	LDY temp6
	LDA temp5
 jsr pfpixel
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
.skipL072
.L073 ;  return

	RTS
.
 ; 

.__touching
 ; __touching

.L074 ;  pfpixel temp5 temp6 off : score = score + 1

	LDX #1
	LDY temp6
	LDA temp5
 jsr pfpixel
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
.L075 ;  return

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

.L076 ;  data _DataBGColor

	JMP .skipL076
_DataBGColor
	.byte    $20 

	.byte    $30 

	.byte    $50 

	.byte    $B0 

	.byte    $C0 

	.byte    $D0 

	.byte    $E0 

	.byte    $F0 

	.byte    $80 

	.byte    $62 

	.byte    $C2 

	.byte    $60 

	.byte    $40 

	.byte    $D2 

	.byte    $30 

	.byte    $D0 

	.byte    $62 

	.byte    $62 

	.byte    $90 

	.byte    $90 

	.byte    $D0 

	.byte    $D0 

	.byte    $40 

	.byte    $40 

	.byte    $C2 

	.byte    $C0 

	.byte    $20 

	.byte    $22 

	.byte    $22 

	.byte    $D2 

	.byte    $C2 

	.byte    $22

.skipL076
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__playerDown
 ; __playerDown

.L077 ;  player1:

	LDX #<playerL077_1
	STX player1pointerlo
	LDA #>playerL077_1
	STA player1pointerhi
	LDA #13
	STA player1height
.L078 ;  return

	RTS
.
 ; 

.__playerUp
 ; __playerUp

.L079 ;  player1:

	LDX #<playerL079_1
	STX player1pointerlo
	LDA #>playerL079_1
	STA player1pointerhi
	LDA #13
	STA player1height
.L080 ;  return

	RTS
.
 ; 

.__playerWalk0
 ; __playerWalk0

.L081 ;  player1:

	LDX #<playerL081_1
	STX player1pointerlo
	LDA #>playerL081_1
	STA player1pointerhi
	LDA #13
	STA player1height
.L082 ;  return

	RTS
.
 ; 

.__playerWalk1
 ; __playerWalk1

.L083 ;  player1:

	LDX #<playerL083_1
	STX player1pointerlo
	LDA #>playerL083_1
	STA player1pointerhi
	LDA #13
	STA player1height
.L084 ;  return
	RTS
 if (<*) > (<(*+13))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playercolorL08_1
	.byte    $04
	.byte    $90
	.byte    $92
	.byte    $94
	.byte    $2C
	.byte    $2E
	.byte    $9E
	.byte    $20
	.byte    $2A
	.byte    $2C
	.byte    $2E
	.byte    $24
	.byte    $22
	.byte    $20
 if (<*) > (<(*+13))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL077_1
	.byte  %00110000
	.byte  %00110000
	.byte  %00111100
	.byte  %00111100
	.byte  %00000011
	.byte  %10000011
	.byte  %11111110
	.byte  %01111110
	.byte  %01111110
	.byte  %01011010
	.byte  %01111110
	.byte  %01111110
	.byte  %01111110
	.byte  %01111110
 if (<*) > (<(*+13))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL079_1
	.byte  %00110000
	.byte  %00110000
	.byte  %00111100
	.byte  %00111100
	.byte  %00000011
	.byte  %10000011
	.byte  %11111110
	.byte  %01111110
	.byte  %01111110
	.byte  %01111110
	.byte  %01111110
	.byte  %01111110
	.byte  %01111110
	.byte  %01111110
 if (<*) > (<(*+13))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL081_1
	.byte  %00011000
	.byte  %00011000
	.byte  %00011000
	.byte  %00011000
	.byte  %00011000
	.byte  %00011000
	.byte  %00011000
	.byte  %01111110
	.byte  %01111110
	.byte  %01111010
	.byte  %01111110
	.byte  %01111110
	.byte  %01111110
	.byte  %01111110
 if (<*) > (<(*+13))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL083_1
	.byte  %11000011
	.byte  %11110011
	.byte  %11111111
	.byte  %00111100
	.byte  %11000011
	.byte  %11000011
	.byte  %11111111
	.byte  %01111110
	.byte  %01111110
	.byte  %01111010
	.byte  %01111110
	.byte  %01111110
	.byte  %01111110
	.byte  %01111110
 if ECHOFIRST
       echo "    ",[(scoretable - *)]d , "bytes of ROM space left")
 endif 
ECHOFIRST = 1
 
 
 
