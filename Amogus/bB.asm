game
.L00 ;  set kernel_options no_blank_lines

.L01 ;  const noscore  =  1

.L02 ;  CTRLPF = 5

	LDA #5
	STA CTRLPF
.L03 ;  COLUPF = $0A

	LDA #$0A
	STA COLUPF
.L04 ;  COLUP0 = $42

	LDA #$42
	STA COLUP0
.
 ; 

.L05 ;  dim _frameCounter  =  a

.
 ; 

.L06 ;  dim _Bit1_P0_Walk  =  y

.
 ; 

.L07 ;  player0x = 70

	LDA #70
	STA player0x
.L08 ;  player0y = 55

	LDA #55
	STA player0y
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

.L09 ;  _Bit1_P0_Walk{1} = 0

	LDA _Bit1_P0_Walk
	AND #253
	STA _Bit1_P0_Walk
.L010 ;  if joy0up then missile0x = missile0x + 34 : _Bit1_P0_Walk{1} = 1

 lda #$10
 bit SWCHA
	BNE .skipL010
.condpart0
	LDA missile0x
	CLC
	ADC #34
	STA missile0x
	LDA _Bit1_P0_Walk
	ORA #2
	STA _Bit1_P0_Walk
.skipL010
.L011 ;  if joy0down then missile0x = missile0x - 34 : _Bit1_P0_Walk{1} = 1

 lda #$20
 bit SWCHA
	BNE .skipL011
.condpart1
	LDA missile0x
	SEC
	SBC #34
	STA missile0x
	LDA _Bit1_P0_Walk
	ORA #2
	STA _Bit1_P0_Walk
.skipL011
.L012 ;  if joy0left then missile0x = missile0x + 1 : _Bit1_P0_Walk{1} = 1

 bit SWCHA
	BVS .skipL012
.condpart2
	INC missile0x
	LDA _Bit1_P0_Walk
	ORA #2
	STA _Bit1_P0_Walk
.skipL012
.L013 ;  if joy0right then missile0x = missile0x - 1 : _Bit1_P0_Walk{1} = 1

 bit SWCHA
	BMI .skipL013
.condpart3
	DEC missile0x
	LDA _Bit1_P0_Walk
	ORA #2
	STA _Bit1_P0_Walk
.skipL013
.L014 ;  if missile0x > 200 then missile0x = missile0x + 160

	LDA #200
	CMP missile0x
     BCS .skipL014
.condpart4
	LDA missile0x
	CLC
	ADC #160
	STA missile0x
.skipL014
.L015 ;  if missile0x > 159 then missile0x = missile0x - 160

	LDA #159
	CMP missile0x
     BCS .skipL015
.condpart5
	LDA missile0x
	SEC
	SBC #160
	STA missile0x
.skipL015
.L016 ;  if _frameCounter < 6  &&  _Bit1_P0_Walk{1} then gosub __playerWalk1 else gosub __playerIdle

	LDA _frameCounter
	CMP #6
     BCS .skipL016
.condpart6
	LDA _Bit1_P0_Walk
	AND #2
	BEQ .skip6then
.condpart7
 jsr .__playerWalk1
 jmp .skipelse0
.skip6then
.skipL016
 jsr .__playerIdle

.skipelse0
.
 ; 

.L017 ;  gosub __draw

 jsr .__draw

.L018 ;  goto __main

 jmp .__main

.__draw
 ; __draw

.L019 ;  ENAM0 = 2

	LDA #2
	STA ENAM0
.L020 ;  _frameCounter = _frameCounter + 1

	INC _frameCounter
.L021 ;  if _frameCounter >= 12 then _frameCounter = 0

	LDA _frameCounter
	CMP #12
     BCC .skipL021
.condpart8
	LDA #0
	STA _frameCounter
.skipL021
.L022 ;  drawscreen

 jsr drawscreen
.return
 ; return

.
 ; 

.__playerIdle
 ; __playerIdle

.L023 ;  player0:

	LDX #<playerL023_0
	STX player0pointerlo
	LDA #>playerL023_0
	STA player0pointerhi
	LDA #9
	STA player0height
.L024 ;  return

	RTS
.
 ; 

.__playerWalk1
 ; __playerWalk1

.L025 ;  player0:

	LDX #<playerL025_0
	STX player0pointerlo
	LDA #>playerL025_0
	STA player0pointerhi
	LDA #10
	STA player0height
.L026 ;  return

	RTS
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L027 ;  vblank

vblank_bB_code
.L028 ;  asm

 sta HMCLR

 sta WSYNC

 lda #$ff

 sta HMM0

 lda #$c0

 sta WSYNC

 sta HMOVE

 sleep 5

 sta HMM0

.L029 ;  return 
	RTS
 if (<*) > (<(*+9))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL023_0
	.byte  %00111110
	.byte  %00101010
	.byte  %00101010
	.byte  %01100010
	.byte  %10100110
	.byte  %10101001
	.byte  %10101001
	.byte  %01100110
	.byte  %00100100
	.byte  %00011000
 if (<*) > (<(*+10))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL025_0
	.byte  %00000000
	.byte  %00000000
	.byte  %11111111
	.byte  %10001001
	.byte  %01100010
	.byte  %10100110
	.byte  %10101001
	.byte  %10101001
	.byte  %01100110
	.byte  %00100100
	.byte  %00011000
 if ECHOFIRST
       echo "    ",[(scoretable - *)]d , "bytes of ROM space left")
 endif 
ECHOFIRST = 1
 
 
 
