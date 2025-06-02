game
.
 ; 

.L00 ;  rem ** Demo of the Cosmic Ark starfield direction in bB

.
 ; 

.L01 ;  rem ** no_blank_lines takes away missile0, so we'll create our starfield

.L02 ;  rem ** using it.

.L03 ;  set kernel_options no_blank_lines

.
 ; 

.L04 ;  scorecolor = $0f

	LDA #$0f
	STA scorecolor
.
 ; 

.L05 ;  dim frame = a

.L06 ;  dim direction = b

.
 ; 

.L07 ;  CTRLPF = 5

	LDA #5
	STA CTRLPF
.L08 ;  playfield:

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
	.byte %00000011, %11111111
	if (pfwidth>2)
	.byte %11111111, %00000011
 endif
	.byte %00011111, %11111111
	if (pfwidth>2)
	.byte %11111111, %00011111
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

.L09 ;  player0:

	LDX #<playerL09_0
	STX player0pointerlo
	LDA #>playerL09_0
	STA player0pointerhi
	LDA #4
	STA player0height
.
 ; 

.L010 ;  player1:

	LDX #<playerL010_1
	STX player1pointerlo
	LDA #>playerL010_1
	STA player1pointerhi
	LDA #4
	STA player1height
.
 ; 

.
 ; 

.L011 ;  rem ** position the other objects, to prove we still can

.L012 ;  player0x = 50 : player0y = 40

	LDA #50
	STA player0x
	LDA #40
	STA player0y
.L013 ;  player1x = 120 : player1y = 40

	LDA #120
	STA player1x
	LDA #40
	STA player1y
.L014 ;  ballx = 70 : bally = 40 : ballheight = 6

	LDA #70
	STA ballx
	LDA #40
	STA bally
	LDA #6
	STA ballheight
.L015 ;  missile1x = 100 : missile1y = 40 : missile1height = 6

	LDA #100
	STA missile1x
	LDA #40
	STA missile1y
	LDA #6
	STA missile1height
.
 ; 

.L016 ;  direction = 2

	LDA #2
	STA direction
.
 ; 

.mainloop
 ; mainloop

.L017 ;  COLUP0 = $0A

	LDA #$0A
	STA COLUP0
.L018 ;  COLUP1 = $44

	LDA #$44
	STA COLUP1
.L019 ;  COLUBK = $80

	LDA #$80
	STA COLUBK
.L020 ;  COLUPF = $B4

	LDA #$B4
	STA COLUPF
.
 ; 

.L021 ;  player0x = player0x - 1

	DEC player0x
.
 ; 

.L022 ;  frame = frame + 1

	INC frame
.L023 ;  if frame = 0 then direction = direction + 1

	LDA frame
	CMP #0
     BNE .skipL023
.condpart0
	INC direction
.skipL023
.L024 ;  if direction > 7 then direction = 0

	LDA #7
	CMP direction
     BCS .skipL024
.condpart1
	LDA #0
	STA direction
.skipL024
.
 ; 

.L025 ;  ENAM0 = 2  :  rem ** set ENAM0=0 when you want the stars to be gone

	LDA #2
	STA ENAM0
.
 ; 

.L026 ;  temp2 = frame & 1

	LDA frame
	AND #1
	STA temp2
.L027 ;  rem ** Adjusting missile0x moves the stars

.L028 ;  if direction = 0 then missile0x = missile0x + 1 : score = 1

	LDA direction
	CMP #0
     BNE .skipL028
.condpart2
	INC missile0x
	LDA #$01
	STA score+2
	LDA #$00
	STA score+1
	LDA #$00
	STA score
.skipL028
.L029 ;  if direction = 1 then missile0x = missile0x + 18 : score = 18

	LDA direction
	CMP #1
     BNE .skipL029
.condpart3
	LDA missile0x
	CLC
	ADC #18
	STA missile0x
	LDA #$18
	STA score+2
	LDA #$00
	STA score+1
	LDA #$00
	STA score
.skipL029
.L030 ;  if direction = 2  &&  temp2 = 1 then missile0x = missile0x + 18 : score = 18

	LDA direction
	CMP #2
     BNE .skipL030
.condpart4
	LDA temp2
	CMP #1
     BNE .skip4then
.condpart5
	LDA missile0x
	CLC
	ADC #18
	STA missile0x
	LDA #$18
	STA score+2
	LDA #$00
	STA score+1
	LDA #$00
	STA score
.skip4then
.skipL030
.L031 ;  if direction = 2  &&  temp2 = 0 then missile0x = missile0x + 16 : score = 16

	LDA direction
	CMP #2
     BNE .skipL031
.condpart6
	LDA temp2
	CMP #0
     BNE .skip6then
.condpart7
	LDA missile0x
	CLC
	ADC #16
	STA missile0x
	LDA #$16
	STA score+2
	LDA #$00
	STA score+1
	LDA #$00
	STA score
.skip6then
.skipL031
.L032 ;  if direction = 3 then missile0x = missile0x + 16 : score = 16

	LDA direction
	CMP #3
     BNE .skipL032
.condpart8
	LDA missile0x
	CLC
	ADC #16
	STA missile0x
	LDA #$16
	STA score+2
	LDA #$00
	STA score+1
	LDA #$00
	STA score
.skipL032
.L033 ;  if direction = 4 then missile0x = missile0x - 1 : score = 1

	LDA direction
	CMP #4
     BNE .skipL033
.condpart9
	DEC missile0x
	LDA #$01
	STA score+2
	LDA #$00
	STA score+1
	LDA #$00
	STA score
.skipL033
.L034 ;  if direction = 5 then missile0x = missile0x - 18 : score = 18

	LDA direction
	CMP #5
     BNE .skipL034
.condpart10
	LDA missile0x
	SEC
	SBC #18
	STA missile0x
	LDA #$18
	STA score+2
	LDA #$00
	STA score+1
	LDA #$00
	STA score
.skipL034
.L035 ;  if direction = 6  &&  temp2 = 1 then missile0x = missile0x - 18 : score = 18

	LDA direction
	CMP #6
     BNE .skipL035
.condpart11
	LDA temp2
	CMP #1
     BNE .skip11then
.condpart12
	LDA missile0x
	SEC
	SBC #18
	STA missile0x
	LDA #$18
	STA score+2
	LDA #$00
	STA score+1
	LDA #$00
	STA score
.skip11then
.skipL035
.L036 ;  if direction = 6  &&  temp2 = 0 then missile0x = missile0x - 16 : score = 16

	LDA direction
	CMP #6
     BNE .skipL036
.condpart13
	LDA temp2
	CMP #0
     BNE .skip13then
.condpart14
	LDA missile0x
	SEC
	SBC #16
	STA missile0x
	LDA #$16
	STA score+2
	LDA #$00
	STA score+1
	LDA #$00
	STA score
.skip13then
.skipL036
.L037 ;  if direction = 7 then missile0x = missile0x - 16 : score = 16

	LDA direction
	CMP #7
     BNE .skipL037
.condpart15
	LDA missile0x
	SEC
	SBC #16
	STA missile0x
	LDA #$16
	STA score+2
	LDA #$00
	STA score+1
	LDA #$00
	STA score
.skipL037
.
 ; 

.L038 ;  rem ** You need to ensure the missile0x position ranges from 0-159. 

.L039 ;  rem ** If missile0x is 0 and decreases, then set it to 159. 

.L040 ;  rem ** If missile0x is 159 and increases, set it to 0.

.L041 ;  if missile0x > 200 then missile0x = missile0x + 160

	LDA #200
	CMP missile0x
     BCS .skipL041
.condpart16
	LDA missile0x
	CLC
	ADC #160
	STA missile0x
.skipL041
.L042 ;  if missile0x > 159 then missile0x = missile0x - 160

	LDA #159
	CMP missile0x
     BCS .skipL042
.condpart17
	LDA missile0x
	SEC
	SBC #160
	STA missile0x
.skipL042
.
 ; 

.L043 ;  drawscreen

 jsr drawscreen
.L044 ;  goto mainloop

 jmp .mainloop

.
 ; 

.L045 ;  vblank

vblank_bB_code
.L046 ;  rem ** Enable the TIA bug that causes missile0 to be repeated

.L047 ;  asm

 lda #$ff

 sta HMM0

 lda #$c0

 sta WSYNC

 sta HMOVE

 sleep 5

 sta HMM0

.L048 ;  return

	RTS
 if (<*) > (<(*+4))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL09_0
	.byte  %10000001
	.byte  %11000011
	.byte  %11111111
	.byte  %01011010
	.byte  %00111100
 if (<*) > (<(*+4))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL010_1
	.byte  %00111100
	.byte  %01011010
	.byte  %11111111
	.byte  %11000011
	.byte  %10000001
 if ECHOFIRST
       echo "    ",[(scoretable - *)]d , "bytes of ROM space left")
 endif 
ECHOFIRST = 1
 
 
 
