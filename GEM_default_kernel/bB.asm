game
.
 ; 

.L00 ;  set kernel_options player1colors pfcolors pfheights background

.L01 ;  set smartbranching on

.L02 ;  dim rand1 = $DA

.
 ; 

.L03 ;  set optimization speed

.L04 ;  set romsize 2k

.L05 ;  const screenheight = 88

.L06 ;  const noscore = 1

.
 ; 

.
 ; 

.
 ; 

.L07 ;  const _mouseSpeed = 7

.
 ; 

.L08 ;  dim _up = a

.L09 ;  dim _down = b

.L010 ;  dim _left = c

.L011 ;  dim _right = d

.
 ; 

.
 ; 

.L012 ;  pfheights:

 lda # 1
 sta playfieldpos
.
 ; 

.L013 ;  pfcolors:

 lda # $0E
 sta COLUPF
.
 ; 

.
 ; 

.L014 ;  gosub __screen0

 jsr .__screen0

.L015 ;  gosub __icons

 jsr .__icons

.L016 ;  COLUPF = 0

	LDA #0
	STA COLUPF
.L017 ;  player0x = 76 : player0y = 51 : COLUP0 = 0

	LDA #76
	STA player0x
	LDA #51
	STA player0y
	LDA #0
	STA COLUP0
.L018 ;  player1x = 16 : player1y = 88 : COLUP1 = 14

	LDA #16
	STA player1x
	LDA #88
	STA player1y
	LDA #14
	STA COLUP1
.
 ; 

.
 ; 

.__main
 ; __main

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L019 ;  if joy0up  &&  _up < _mouseSpeed then _up = _up + 2

 lda #$10
 bit SWCHA
	BNE .skipL019
.condpart0
	LDA _up
	CMP #_mouseSpeed
     BCS .skip0then
.condpart1
	LDA _up
	CLC
	ADC #2
	STA _up
.skip0then
.skipL019
.L020 ;  if joy0down  &&  _down < _mouseSpeed then _down = _down + 2

 lda #$20
 bit SWCHA
	BNE .skipL020
.condpart2
	LDA _down
	CMP #_mouseSpeed
     BCS .skip2then
.condpart3
	LDA _down
	CLC
	ADC #2
	STA _down
.skip2then
.skipL020
.L021 ;  if joy0left  &&  _left < _mouseSpeed then _left = _left + 2

 bit SWCHA
	BVS .skipL021
.condpart4
	LDA _left
	CMP #_mouseSpeed
     BCS .skip4then
.condpart5
	LDA _left
	CLC
	ADC #2
	STA _left
.skip4then
.skipL021
.L022 ;  if joy0right  &&  _right < _mouseSpeed then _right = _right + 2

 bit SWCHA
	BMI .skipL022
.condpart6
	LDA _right
	CMP #_mouseSpeed
     BCS .skip6then
.condpart7
	LDA _right
	CLC
	ADC #2
	STA _right
.skip6then
.skipL022
.
 ; 

.L023 ;  if _up > 0 then _up = _up - 1

	LDA #0
	CMP _up
     BCS .skipL023
.condpart8
	DEC _up
.skipL023
.L024 ;  if _down > 0 then _down = _down - 1

	LDA #0
	CMP _down
     BCS .skipL024
.condpart9
	DEC _down
.skipL024
.L025 ;  if _left > 0 then _left = _left - 1

	LDA #0
	CMP _left
     BCS .skipL025
.condpart10
	DEC _left
.skipL025
.L026 ;  if _right > 0 then _right = _right - 1

	LDA #0
	CMP _right
     BCS .skipL026
.condpart11
	DEC _right
.skipL026
.
 ; 

.L027 ;  player0x = player0x + _right / 2

; complex statement detected
	LDA player0x
	PHA
	LDA _right
	lsr
	TSX
	INX
	TXS
	CLC
	ADC $00,x
	STA player0x
.L028 ;  player0x = player0x - _left / 2

; complex statement detected
	LDA player0x
	PHA
	LDA _left
	lsr
	TAY
	PLA
	TSX
	STY $00,x
	SEC
	SBC $00,x
	STA player0x
.L029 ;  player0y = player0y - _up / 2

; complex statement detected
	LDA player0y
	PHA
	LDA _up
	lsr
	TAY
	PLA
	TSX
	STY $00,x
	SEC
	SBC $00,x
	STA player0y
.L030 ;  player0y = player0y + _down / 2

; complex statement detected
	LDA player0y
	PHA
	LDA _down
	lsr
	TSX
	INX
	TXS
	CLC
	ADC $00,x
	STA player0y
.
 ; 

.L031 ;  if player0y > 110 then player0y = 110

	LDA #110
	CMP player0y
     BCS .skipL031
.condpart12
	LDA #110
	STA player0y
.skipL031
.L032 ;  if player0y < 15 then player0y = 15

	LDA player0y
	CMP #15
     BCS .skipL032
.condpart13
	LDA #15
	STA player0y
.skipL032
.L033 ;  if player0x > 200 then player0x = 1

	LDA #200
	CMP player0x
     BCS .skipL033
.condpart14
	LDA #1
	STA player0x
.skipL033
.L034 ;  if player0x > 144 then player0x = 144

	LDA #144
	CMP player0x
     BCS .skipL034
.condpart15
	LDA #144
	STA player0x
.skipL034
.
 ; 

.
 ; 

.L035 ;  if joy0fire then gosub __cursorLoad else gosub __cursor1

 bit INPT4
	BMI .skipL035
.condpart16
 jsr .__cursorLoad
 jmp .skipelse0
.skipL035
 jsr .__cursor1

.skipelse0
.
 ; 

.
 ; 

.L036 ;  COLUBK = $0E

	LDA #$0E
	STA COLUBK
.L037 ;  drawscreen

 jsr drawscreen
.L038 ;  goto __main

 jmp .__main

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__screen0
 ; __screen0

.L039 ;  playfield:

  ifconst pfres
	  ldx #(12>pfres)*(pfres*pfwidth-1)+(12<=pfres)*47
  else
	  ldx #((12*pfwidth-1)*((12*pfwidth-1)<47))+(47*((12*pfwidth-1)>=47))
  endif
	jmp pflabel0
PF_data0
	.byte %01100111, %01010100
	if (pfwidth>2)
	.byte %00110101, %00011100
 endif
	.byte %01010101, %00110110
	if (pfwidth>2)
	.byte %00110101, %00010100
 endif
	.byte %01100110, %01010010
	if (pfwidth>2)
	.byte %00100101, %00001101
 endif
	.byte %11111111, %11111111
	if (pfwidth>2)
	.byte %11111111, %11111111
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
	.byte %11110000, %00000000
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
.L040 ;  return

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

.__cursor1
 ; __cursor1

.L041 ;  NUSIZ0 = $30

	LDA #$30
	STA NUSIZ0
.L042 ;  player0:

	LDX #<playerL042_0
	STX player0pointerlo
	LDA #>playerL042_0
	STA player0pointerhi
	LDA #13
	STA player0height
.L043 ;  return

	RTS
.
 ; 

.__cursorLoad
 ; __cursorLoad

.L044 ;  NUSIZ0 = $35

	LDA #$35
	STA NUSIZ0
.L045 ;  player0:

	LDX #<playerL045_0
	STX player0pointerlo
	LDA #>playerL045_0
	STA player0pointerhi
	LDA #13
	STA player0height
.L046 ;  return

	RTS
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__icons
 ; __icons

.L047 ;  NUSIZ1 = $35

	LDA #$35
	STA NUSIZ1
.L048 ;  player1:

	LDX #<playerL048_1
	STX player1pointerlo
	LDA #>playerL048_1
	STA player1pointerhi
	LDA #59
	STA player1height
.L049 ;  player1color:

	LDX #<playercolorL049_1
	STX player1color
	LDA #>playercolorL049_1
	STA player1color+1
.L050 ;  return

	RTS
.
 ; 

.
 ; 

 ifconst pfres
 if (<*) > (254-pfres)
	align 256
	endif
 if (<*) < (136-pfres*pfwidth)
	repeat ((136-pfres*pfwidth)-(<*))
	.byte 0
	repend
	endif
 else
 if (<*) > 206
	align 256
	endif
 if (<*) < 88
	repeat (88-(<*))
	.byte 0
	repend
	endif
 endif
playfieldcolorandheight
 .byte  1, $0E,0,0
 .byte  1, $0E,0,0
 .byte  1, $00,0,0
 .byte  1, $C8,0,0
 .byte  1, $C8,0,0
 .byte  1, $C8,0,0
 .byte  1, $C8,0,0
 .byte  1, $C8,0,0
 .byte  19, $C8,0,0
 .byte  60, $C8,0,0
 .byte  1, $C8,0,0
 if (<*) > (<(*+13))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL042_0
	.byte  %00000110
	.byte  %00000110
	.byte  %00001100
	.byte  %10001100
	.byte  %11011000
	.byte  %11111000
	.byte  %11111111
	.byte  %11111110
	.byte  %11111100
	.byte  %11111000
	.byte  %11110000
	.byte  %11100000
	.byte  %11000000
	.byte  %10000000
 if (<*) > (<(*+13))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL045_0
	.byte  %11111111
	.byte  %01101010
	.byte  %01010110
	.byte  %01101010
	.byte  %00110100
	.byte  %00101100
	.byte  %00011000
	.byte  %00011000
	.byte  %00110100
	.byte  %00101100
	.byte  %01010110
	.byte  %01001010
	.byte  %01000010
	.byte  %11111111
 if (<*) > (<(*+59))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL048_1
	.byte  %11111111
	.byte  %10000001
	.byte  %00111100
	.byte  %01000100
	.byte  %00010000
	.byte  %01010100
	.byte  %01010100
	.byte  %01010100
	.byte  %01010100
	.byte  %01010100
	.byte  %01010100
	.byte  %01010100
	.byte  %01010100
	.byte  %01010100
	.byte  %01010100
	.byte  %01010000
	.byte  %01000000
	.byte  %01001000
	.byte  %01010100
	.byte  %01010100
	.byte  %01010100
	.byte  %01010100
	.byte  %01010100
	.byte  %01111110
	.byte  %10000001
	.byte  %00111100
	.byte  %01111110
	.byte  %00100100
	.byte  %10011001
	.byte  %11100111
	.byte  %11111111
	.byte  %00000011
	.byte  %01111011
	.byte  %01111011
	.byte  %01111011
	.byte  %00001001
	.byte  %00101001
	.byte  %01111001
	.byte  %01111001
	.byte  %00001000
	.byte  %00101000
	.byte  %00101000
	.byte  %00001000
	.byte  %01111000
	.byte  %01111000
	.byte  %01111000
	.byte  %01111000
	.byte  %01111000
	.byte  %01111000
	.byte  %01111000
	.byte  %00000000
	.byte  %01111000
	.byte  %00001000
	.byte  %00100000
	.byte  %10000000
	.byte  %10110000
	.byte  %11010110
	.byte  %11000110
	.byte  %11110101
	.byte  %11111001
 if (<*) > (<(*+59))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playercolorL049_1
	.byte  200
	.byte  200
	.byte  14
	.byte  14
	.byte  14
	.byte  14
	.byte  14
	.byte  14
	.byte  14
	.byte  14
	.byte  14
	.byte  14
	.byte  14
	.byte  14
	.byte  14
	.byte  14
	.byte  14
	.byte  14
	.byte  14
	.byte  14
	.byte  14
	.byte  14
	.byte  14
	.byte  14
	.byte  200
	.byte  14
	.byte  14
	.byte  14
	.byte  200
	.byte  200
	.byte  200
	.byte  14
	.byte  14
	.byte  14
	.byte  14
	.byte  14
	.byte  14
	.byte  14
	.byte  14
	.byte  14
	.byte  14
	.byte  14
	.byte  14
	.byte  14
	.byte  14
	.byte  14
	.byte  14
	.byte  14
	.byte  14
	.byte  14
	.byte  14
	.byte  14
	.byte  14
	.byte  14
	.byte  200
	.byte  200
	.byte  200
	.byte  200
	.byte  200
	.byte  200
 if ECHOFIRST
       echo "    ",[(scoretable - *)]d , "bytes of ROM space left")
 endif 
ECHOFIRST = 1
 
 
 
