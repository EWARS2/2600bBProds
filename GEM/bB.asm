game
.L00 ;  set smartbranching on

.L01 ;  dim rand1 = $DA

.L02 ;  set kernel multisprite

.L03 ;  set optimization speed

.L04 ;  set romsize 4k

.L05 ;  const screenheight = 88

.L06 ;  rem const noscore=1

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

.L012 ;  COLUPF = 0

	LDA #0
	STA COLUPF
.L013 ;  pfheight = 0

	LDA #0
	STA pfheight
.L014 ;  playfield:

	LDA #<PF1_data0
	STA PF1pointer
	LDA #>PF1_data0
	STA PF1pointer+1
	LDA #<PF2_data0
	STA PF2pointer
	LDA #>PF2_data0
	STA PF2pointer+1
.
 ; 

.
 ; 

.L015 ;  player0x = 76 : player0y = 51 : COLUP0 = 0

	LDA #76
	STA player0x
	LDA #51
	STA player0y
	LDA #0
	STA COLUP0
.
 ; 

.
 ; 

.L016 ;  gosub __trashOG

 jsr .__trashOG

.L017 ;  player2x = 24 : player2y = 38

	LDA #24
	STA player2x
	LDA #38
	STA player2y
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L018 ;  gosub __file

 jsr .__file

.
 ; 

.L019 ;  player3x = 24 : player3y = 70

	LDA #24
	STA player3x
	LDA #70
	STA player3y
.L020 ;  player4x = 25 : player4y = 0

	LDA #25
	STA player4x
	LDA #0
	STA player4y
.L021 ;  player5x = 50 : player5y = 1 : COLUP5 = 0

	LDA #50
	STA player5x
	LDA #1
	STA player5y
	LDA #0
	STA COLUP5
.
 ; 

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

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L022 ;  if joy0up  &&  _up < _mouseSpeed then _up = _up + 2

 lda #$10
 bit SWCHA
	BNE .skipL022
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
.skipL022
.L023 ;  if joy0down  &&  _down < _mouseSpeed then _down = _down + 2

 lda #$20
 bit SWCHA
	BNE .skipL023
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
.skipL023
.L024 ;  if joy0left  &&  _left < _mouseSpeed then _left = _left + 2

 bit SWCHA
	BVS .skipL024
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
.skipL024
.L025 ;  if joy0right  &&  _right < _mouseSpeed then _right = _right + 2

 bit SWCHA
	BMI .skipL025
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
.skipL025
.
 ; 

.L026 ;  if _up > 0 then _up = _up - 1

	LDA #0
	CMP _up
     BCS .skipL026
.condpart8
	DEC _up
.skipL026
.L027 ;  if _down > 0 then _down = _down - 1

	LDA #0
	CMP _down
     BCS .skipL027
.condpart9
	DEC _down
.skipL027
.L028 ;  if _left > 0 then _left = _left - 1

	LDA #0
	CMP _left
     BCS .skipL028
.condpart10
	DEC _left
.skipL028
.L029 ;  if _right > 0 then _right = _right - 1

	LDA #0
	CMP _right
     BCS .skipL029
.condpart11
	DEC _right
.skipL029
.
 ; 

.L030 ;  player0x = player0x + _right / 2

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
.L031 ;  player0x = player0x - _left / 2

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
.L032 ;  player0y = player0y + _up / 2

; complex statement detected
	LDA player0y
	PHA
	LDA _up
	lsr
	TSX
	INX
	TXS
	CLC
	ADC $00,x
	STA player0y
.L033 ;  player0y = player0y - _down / 2

; complex statement detected
	LDA player0y
	PHA
	LDA _down
	lsr
	TAY
	PLA
	TSX
	STY $00,x
	SEC
	SBC $00,x
	STA player0y
.
 ; 

.L034 ;  if player0y > 90 then player0y = 90

	LDA #90
	CMP player0y
     BCS .skipL034
.condpart12
	LDA #90
	STA player0y
.skipL034
.L035 ;  if player0y < 11 then player0y = 11

	LDA player0y
	CMP #11
     BCS .skipL035
.condpart13
	LDA #11
	STA player0y
.skipL035
.L036 ;  if player0x > 200 then player0x = 0

	LDA #200
	CMP player0x
     BCS .skipL036
.condpart14
	LDA #0
	STA player0x
.skipL036
.L037 ;  if player0x > 143 then player0x = 143

	LDA #143
	CMP player0x
     BCS .skipL037
.condpart15
	LDA #143
	STA player0x
.skipL037
.
 ; 

.
 ; 

.L038 ;  if joy0fire then gosub __cursorLoad else gosub __cursor1

 bit INPT4
	BMI .skipL038
.condpart16
 jsr .__cursorLoad
 jmp .skipelse0
.skipL038
 jsr .__cursor1

.skipelse0
.L039 ;  drawscreen

 jsr drawscreen
.L040 ;  goto __main

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
	LDA #15
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
	LDA #15
	STA player0height
.L046 ;  return

	RTS
.
 ; 

.__trash
 ; __trash

.L047 ;  COLUP2 = 14

	LDA #14
	STA COLUP2
.L048 ;  NUSIZ2 = $35

	LDA #$35
	STA NUSIZ2
.L049 ;  player2:

	LDX #<playerL049_2
	STX player2pointerlo
	LDA #>playerL049_2
	STA player2pointerhi
	LDA #31
	STA player2height
.L050 ;  return

	RTS
.
 ; 

.__trashOG
 ; __trashOG

.L051 ;  COLUP2 = 14

	LDA #14
	STA COLUP2
.L052 ;  NUSIZ2 = $35

	LDA #$35
	STA NUSIZ2
.L053 ;  player2:

	LDX #<playerL053_2
	STX player2pointerlo
	LDA #>playerL053_2
	STA player2pointerhi
	LDA #31
	STA player2height
.L054 ;  return

	RTS
.
 ; 

.__file
 ; __file

.L055 ;  COLUP3 = 14

	LDA #14
	STA COLUP3
.L056 ;  NUSIZ3 = $35

	LDA #$35
	STA NUSIZ3
.L057 ;  player3:

	LDX #<playerL057_3
	STX player3pointerlo
	LDA #>playerL057_3
	STA player3pointerhi
	LDA #30
	STA player3height
.L058 ;  return

	RTS
.
 ; 

.__floppyA
 ; __floppyA

.L059 ;  COLUP3 = 14

	LDA #14
	STA COLUP3
.L060 ;  player3:

	LDX #<playerL060_3
	STX player3pointerlo
	LDA #>playerL060_3
	STA player3pointerhi
	LDA #9
	STA player3height
.L061 ;  return

	RTS
.
 ; 

.__floppyB
 ; __floppyB

.L062 ;  COLUP4 = 14

	LDA #14
	STA COLUP4
.L063 ;  player4:

	LDX #<playerL063_4
	STX player4pointerlo
	LDA #>playerL063_4
	STA player4pointerhi
	LDA #9
	STA player4height
.L064 ;  return

	RTS
.
 ; 

.
 ; 

.L065 ;  data msk_bgcolor

	JMP .skipL065
msk_bgcolor
	.byte  200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200

	.byte  200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200

	.byte  200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200

	.byte  200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200

	.byte  200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 0, 14, 14, 14

	.byte  14, 14, 14, 14, 14, 14

.skipL065
.
 ; 

.
 ; 

.L066 ;  asm

minikernel

   sta WSYNC

   lda 0

   sta COLUBK

   rts

.
 ; 

 if (<*) > (<(*+14))
	repeat ($100-<*)
	.byte 0
	repend
	endif
 if (<*) < 90
	repeat (90-<*)
	.byte 0
	repend
	endif
playerL042_0
	.byte 0
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
 if (<*) > (<(*+14))
	repeat ($100-<*)
	.byte 0
	repend
	endif
 if (<*) < 90
	repeat (90-<*)
	.byte 0
	repend
	endif
playerL045_0
	.byte 0
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
 if (<*) > (<(*+29))
	repeat ($100-<*)
	.byte 0
	repend
	endif
 if (<*) < 90
	repeat (90-<*)
	.byte 0
	repend
	endif
playerL049_2
	.byte  %11000011
	.byte  %10000001
	.byte  %01111110
	.byte  %01011010
	.byte  %01011010
	.byte  %01011010
	.byte  %01011010
	.byte  %01011010
	.byte  %01011010
	.byte  %01011010
	.byte  %01011010
	.byte  %01011010
	.byte  %01011010
	.byte  %01011010
	.byte  %01011010
	.byte  %01011010
	.byte  %01011010
	.byte  %01011010
	.byte  %01011010
	.byte  %01011010
	.byte  %01111110
	.byte  %10000001
	.byte  %00000000
	.byte  %01111110
	.byte  %01111110
	.byte  %01111110
	.byte  %10000001
	.byte  %11011011
	.byte  %11000011
	.byte  %11100111
 if (<*) > (<(*+29))
	repeat ($100-<*)
	.byte 0
	repend
	endif
 if (<*) < 90
	repeat (90-<*)
	.byte 0
	repend
	endif
playerL053_2
	.byte  %11111111
	.byte  %11000011
	.byte  %10111101
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
 if (<*) > (<(*+28))
	repeat ($100-<*)
	.byte 0
	repend
	endif
 if (<*) < 90
	repeat (90-<*)
	.byte 0
	repend
	endif
playerL057_3
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
	.byte  %10100000
	.byte  %10000000
	.byte  %10110000
	.byte  %11010110
	.byte  %11000110
	.byte  %11110101
	.byte  %11111001
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
 if (<*) < 90
	repeat (90-<*)
	.byte 0
	repend
	endif
playerL060_3
	.byte  %01011010
	.byte  %01000010
	.byte  %01011010
	.byte  %01100110
	.byte  %00000000
	.byte  %00111100
	.byte  %00110100
	.byte  %00110101
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
 if (<*) < 90
	repeat (90-<*)
	.byte 0
	repend
	endif
playerL063_4
	.byte  %01000110
	.byte  %01011010
	.byte  %01000110
	.byte  %01011010
	.byte  %00000000
	.byte  %00111100
	.byte  %00110100
	.byte  %00110101
 if ((>(*+80)) > (>*))
 ALIGN 256
 endif
PF1_data0
 .byte %11110000
 .byte %11110000
 .byte %11110000
 .byte %11110000
 .byte %11110000
 .byte %11110000
 .byte %11110000
 .byte %11110000
 .byte %11110000
 .byte %11110000
 .byte %11110000
 .byte %11110000
 .byte %11110000
 .byte %11110000
 .byte %11110000
 .byte %11110000
 .byte %11110000
 .byte %11110000
 .byte %11110000
 .byte %11110000
 .byte %11110000
 .byte %11110000
 .byte %11110000
 .byte %11110000
 .byte %11110000
 .byte %11110000
 .byte %11110000
 .byte %11110000
 .byte %11110000
 .byte %11110000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %11001101
 .byte %10101000
 .byte %10101101
 .byte %10101001
 .byte %11001100
 .byte %00000000
 if ((>(*+80)) > (>*))
 ALIGN 256
 endif
PF2_data0
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00010100
 .byte %00010101
 .byte %00001101
 .byte %00010100
 .byte %00010101
 .byte %00000000
 if ECHOFIRST
       echo "    ",[(scoretable - *)]d , "bytes of ROM space left")
 endif 
ECHOFIRST = 1
 
 
 
