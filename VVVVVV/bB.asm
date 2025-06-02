game
.
 ; 

.L00 ;  set kernel_options pfcolors

.
 ; 

.L01 ;  const noscore  =  1

.
 ; 

.L02 ;  const _mapHRes  =  8  : rem Makes designing the level easier

.
 ; 

.L03 ;  dim _frameCounter  =  a  : rem should be 0-12

.L04 ;  dim _respawnX  =  b

.L05 ;  dim _respawnY  =  c

.L06 ;  dim _respawnRoom  =  d

.L07 ;  dim _playerRoom  =  e

.
 ; 

.L08 ;  dim _Bit1_HFlip_P0  =  y  :  rem for horizontal flip

.L09 ;  dim _Bit2_VFlip_P0  =  y  :  rem for vertical flip

.L010 ;  dim _Bit3_Walking_P0  =  y  :  rem If walking

.L011 ;  dim _Bit4_AnimStars  =  y  :  rem If to show stars

.
 ; 

.L012 ;  CTRLPF = 5

	LDA #5
	STA CTRLPF
.
 ; 

.
 ; 

.L013 ;  pfscroll upup : pfscroll upup

	LDA #6
 jsr pfscroll
	LDA #6
 jsr pfscroll
.
 ; 

.L014 ;  COLUPF = $56  : rem playfield

	LDA #$56
	STA COLUPF
.
 ; 

.
 ; 

.L015 ;  rem very top color seems to be ignored?

.L016 ;  pfcolors:

 lda # $0E
 sta COLUPF
 ifconst pfres
 lda #>(pfcolorlabel13-132+pfres*pfwidth)
 else
 lda #>(pfcolorlabel13-84)
 endif
 sta pfcolortable+1
 ifconst pfres
 lda #<(pfcolorlabel13-132+pfres*pfwidth)
 else
 lda #<(pfcolorlabel13-84)
 endif
 sta pfcolortable
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L017 ;  missile0height  =  88

	LDA #88
	STA missile0height
.L018 ;  missile0y  =  88

	LDA #88
	STA missile0y
.
 ; 

.
 ; 

.__start
 ; __start

.L019 ;  _respawnX = 55 : _respawnY = 59

	LDA #55
	STA _respawnX
	LDA #59
	STA _respawnY
.L020 ;  player1x = 75 : player1y = 67

	LDA #75
	STA player1x
	LDA #67
	STA player1y
.L021 ;  gosub __objCheckpoint

 jsr .__objCheckpoint

.L022 ;  rem NUSIZ1 = $33

.
 ; 

.
 ; 

.__respawn
 ; __respawn

.L023 ;  COLUP0 = $9A  : rem player

	LDA #$9A
	STA COLUP0
.L024 ;  player0x = _respawnX : player0y = _respawnY

	LDA _respawnX
	STA player0x
	LDA _respawnY
	STA player0y
.L025 ;  _playerRoom = _respawnRoom

	LDA _respawnRoom
	STA _playerRoom
.L026 ;  _Bit1_HFlip_P0{1} = 0

	LDA _Bit1_HFlip_P0
	AND #253
	STA _Bit1_HFlip_P0
.L027 ;  _Bit2_VFlip_P0{2} = 1

	LDA _Bit2_VFlip_P0
	ORA #4
	STA _Bit2_VFlip_P0
.L028 ;  gosub __updateScreen

 jsr .__updateScreen

.
 ; 

.
 ; 

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

.L029 ;  gosub __draw

 jsr .__draw

.
 ; 

.L030 ;  _Bit3_Walking_P0{3} = 0

	LDA _Bit3_Walking_P0
	AND #247
	STA _Bit3_Walking_P0
.L031 ;  if joy0left then gosub __moveLeft

 bit SWCHA
	BVS .skipL031
.condpart0
 jsr .__moveLeft

.skipL031
.L032 ;  if joy0right then gosub __moveRight

 bit SWCHA
	BMI .skipL032
.condpart1
 jsr .__moveRight

.skipL032
.L033 ;  if _Bit2_VFlip_P0{2} then gosub __moveDown else gosub __moveUp

	LDA _Bit2_VFlip_P0
	AND #4
	BEQ .skipL033
.condpart2
 jsr .__moveDown
 jmp .skipelse0
.skipL033
 jsr .__moveUp

.skipelse0
.L034 ;  if player0x > 135 then player0x = 15 : _playerRoom = _playerRoom + 1 : gosub __updateScreen

	LDA #135
	CMP player0x
     BCS .skipL034
.condpart3
	LDA #15
	STA player0x
	INC _playerRoom
 jsr .__updateScreen

.skipL034
.L035 ;  if player0x < 15 then player0x = 135 : _playerRoom = _playerRoom - 1 : gosub __updateScreen

	LDA player0x
	CMP #15
     BCS .skipL035
.condpart4
	LDA #135
	STA player0x
	DEC _playerRoom
 jsr .__updateScreen

.skipL035
.L036 ;  if player0y < 20 then player0y = 88 : _playerRoom = _playerRoom - _mapHRes : gosub __updateScreen

	LDA player0y
	CMP #20
     BCS .skipL036
.condpart5
	LDA #88
	STA player0y
	LDA _playerRoom
	SEC
	SBC #_mapHRes
	STA _playerRoom
 jsr .__updateScreen

.skipL036
.L037 ;  if player0y > 88 then player0y = 20 : _playerRoom = _playerRoom + _mapHRes : gosub __updateScreen

	LDA #88
	CMP player0y
     BCS .skipL037
.condpart6
	LDA #20
	STA player0y
	LDA _playerRoom
	CLC
	ADC #_mapHRes
	STA _playerRoom
 jsr .__updateScreen

.skipL037
.
 ; 

.L038 ;  if _playerRoom = _respawnRoom then COLUP1 = $0E else COLUP1 = $9A

	LDA _playerRoom
	CMP _respawnRoom
     BNE .skipL038
.condpart7
	LDA #$0E
	STA COLUP1
 jmp .skipelse1
.skipL038
	LDA #$9A
	STA COLUP1
.skipelse1
.L039 ;  if collision(player0,player1) then gosub __scriptCheckpoint

	bit 	CXPPMM
	BPL .skipL039
.condpart8
 jsr .__scriptCheckpoint

.skipL039
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L040 ;  goto __main

 jmp .__main

.__draw
 ; __draw

.L041 ;  if _Bit1_HFlip_P0{1} then REFP0  =  8

	LDA _Bit1_HFlip_P0
	AND #2
	BEQ .skipL041
.condpart9
	LDA #8
	STA REFP0
.skipL041
.L042 ;  _frameCounter = _frameCounter + 1

	INC _frameCounter
.L043 ;  if _frameCounter = 12 then _frameCounter = 0

	LDA _frameCounter
	CMP #12
     BNE .skipL043
.condpart10
	LDA #0
	STA _frameCounter
.skipL043
.L044 ;  ENAM0 = 2

	LDA #2
	STA ENAM0
.L045 ;  if _Bit4_AnimStars{4} then missile0x = missile0x - 1 else missile0x = 0

	LDA _Bit4_AnimStars
	AND #16
	BEQ .skipL045
.condpart11
	DEC missile0x
 jmp .skipelse2
.skipL045
	LDA #0
	STA missile0x
.skipelse2
.L046 ;  if missile0x > 200 then missile0x = missile0x + 160

	LDA #200
	CMP missile0x
     BCS .skipL046
.condpart12
	LDA missile0x
	CLC
	ADC #160
	STA missile0x
.skipL046
.L047 ;  if missile0x > 159 then missile0x = missile0x - 160

	LDA #159
	CMP missile0x
     BCS .skipL047
.condpart13
	LDA missile0x
	SEC
	SBC #160
	STA missile0x
.skipL047
.L048 ;  drawscreen

 jsr drawscreen
.L049 ;  if switchreset then goto __scriptHazard

 lda #1
 bit SWCHB
	BNE .skipL049
.condpart14
 jmp .__scriptHazard

.skipL049
.L050 ;  return

	RTS
.
 ; 

.__updateScreen
 ; __updateScreen

.
 ; 

.
 ; 

.
 ; 

.L051 ;  on _playerRoom goto __lvl0 __lvl1 __lvl2 __lvl3

	LDX _playerRoom
	LDA .L051jumptablehi,x
	PHA
	LDA .L051jumptablelo,x
	PHA
	RTS
.L051jumptablehi
	.byte >(.__lvl0-1)
	.byte >(.__lvl1-1)
	.byte >(.__lvl2-1)
	.byte >(.__lvl3-1)
.L051jumptablelo
	.byte <(.__lvl0-1)
	.byte <(.__lvl1-1)
	.byte <(.__lvl2-1)
	.byte <(.__lvl3-1)
.return
 ; return

.
 ; 

.L052 ;  rem *********************************************************************************************************

.L053 ;  rem Level Data here

.L054 ;  rem *********************************************************************************************************

.
 ; 

.__lvl
 ; __lvl

.L055 ;  playfield:

  ifconst pfres
	  ldx #(12>pfres)*(pfres*pfwidth-1)+(12<=pfres)*47
  else
	  ldx #((12*pfwidth-1)*((12*pfwidth-1)<47))+(47*((12*pfwidth-1)>=47))
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
	.byte %00101001, %01010010
	if (pfwidth>2)
	.byte %01010010, %00101001
 endif
	.byte %00010000, %00100001
	if (pfwidth>2)
	.byte %00100001, %00010000
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
pflabel0
	lda PF_data0,x
	sta playfield,x
	dex
	bpl pflabel0
.L056 ;  return

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

.__lvl0
 ; __lvl0

.L057 ;  COLUBK = $00  : rem bg

	LDA #$00
	STA COLUBK
.L058 ;  _Bit4_AnimStars{4} = 1

	LDA _Bit4_AnimStars
	ORA #16
	STA _Bit4_AnimStars
.L059 ;  playfield:

  ifconst pfres
	  ldx #(12>pfres)*(pfres*pfwidth-1)+(12<=pfres)*47
  else
	  ldx #((12*pfwidth-1)*((12*pfwidth-1)<47))+(47*((12*pfwidth-1)>=47))
  endif
	jmp pflabel1
PF_data1
	.byte %10101010, %01010101
	if (pfwidth>2)
	.byte %10101010, %01010101
 endif
	.byte %01010101, %10101010
	if (pfwidth>2)
	.byte %01010101, %10101010
 endif
	.byte %10111111, %11111111
	if (pfwidth>2)
	.byte %11111111, %01111111
 endif
	.byte %01100000, %00000000
	if (pfwidth>2)
	.byte %00000000, %10100000
 endif
	.byte %10100000, %00000000
	if (pfwidth>2)
	.byte %00000000, %11100000
 endif
	.byte %01100000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %10100000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %01100000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %10100000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %01111111, %11111111
	if (pfwidth>2)
	.byte %11111111, %11111111
 endif
	.byte %10101010, %01010101
	if (pfwidth>2)
	.byte %10101010, %01010101
 endif
	.byte %01010101, %10101010
	if (pfwidth>2)
	.byte %01010101, %10101010
 endif
pflabel1
	lda PF_data1,x
	sta playfield,x
	dex
	bpl pflabel1
.L060 ;  return

	RTS
.
 ; 

.__lvl1
 ; __lvl1

.L061 ;  COLUBK = $50  : rem bg

	LDA #$50
	STA COLUBK
.L062 ;  _Bit4_AnimStars{4} = 0

	LDA _Bit4_AnimStars
	AND #239
	STA _Bit4_AnimStars
.L063 ;  playfield:

  ifconst pfres
	  ldx #(12>pfres)*(pfres*pfwidth-1)+(12<=pfres)*47
  else
	  ldx #((12*pfwidth-1)*((12*pfwidth-1)<47))+(47*((12*pfwidth-1)>=47))
  endif
	jmp pflabel2
PF_data2
	.byte %11111111, %11111111
	if (pfwidth>2)
	.byte %11111111, %11111111
 endif
	.byte %11111111, %11111111
	if (pfwidth>2)
	.byte %11111111, %11111111
 endif
	.byte %11111111, %11111111
	if (pfwidth>2)
	.byte %11111111, %11111111
 endif
	.byte %11111111, %11111111
	if (pfwidth>2)
	.byte %11111111, %11111111
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
	.byte %11111111, %00000001
	if (pfwidth>2)
	.byte %00000000, %11111111
 endif
	.byte %11111111, %11111111
	if (pfwidth>2)
	.byte %11111111, %11111111
 endif
	.byte %01010101, %10101010
	if (pfwidth>2)
	.byte %01010101, %10101010
 endif
pflabel2
	lda PF_data2,x
	sta playfield,x
	dex
	bpl pflabel2
.L064 ;  return

	RTS
.
 ; 

.__lvl2
 ; __lvl2

.L065 ;  COLUBK = $00  : rem bg

	LDA #$00
	STA COLUBK
.L066 ;  _Bit4_AnimStars{4} = 1

	LDA _Bit4_AnimStars
	ORA #16
	STA _Bit4_AnimStars
.L067 ;  playfield:

  ifconst pfres
	  ldx #(12>pfres)*(pfres*pfwidth-1)+(12<=pfres)*47
  else
	  ldx #((12*pfwidth-1)*((12*pfwidth-1)<47))+(47*((12*pfwidth-1)>=47))
  endif
	jmp pflabel3
PF_data3
	.byte %11100000, %00000000
	if (pfwidth>2)
	.byte %00000000, %11100000
 endif
	.byte %11100000, %00000000
	if (pfwidth>2)
	.byte %00000000, %11100000
 endif
	.byte %11100000, %00000000
	if (pfwidth>2)
	.byte %00000000, %11100000
 endif
	.byte %11100000, %00000000
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
	.byte %10101010, %01010101
	if (pfwidth>2)
	.byte %10101010, %01010101
 endif
	.byte %01010101, %10101010
	if (pfwidth>2)
	.byte %01010101, %10101010
 endif
pflabel3
	lda PF_data3,x
	sta playfield,x
	dex
	bpl pflabel3
.L068 ;  return

	RTS
.
 ; 

.__lvl3
 ; __lvl3

.L069 ;  COLUBK = $00  : rem bg

	LDA #$00
	STA COLUBK
.L070 ;  _Bit4_AnimStars{4} = 1

	LDA _Bit4_AnimStars
	ORA #16
	STA _Bit4_AnimStars
.L071 ;  playfield:

  ifconst pfres
	  ldx #(12>pfres)*(pfres*pfwidth-1)+(12<=pfres)*47
  else
	  ldx #((12*pfwidth-1)*((12*pfwidth-1)<47))+(47*((12*pfwidth-1)>=47))
  endif
	jmp pflabel4
PF_data4
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
	.byte %00000000, %01000000
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
	.byte %11111111, %11111111
	if (pfwidth>2)
	.byte %11111111, %11111111
 endif
pflabel4
	lda PF_data4,x
	sta playfield,x
	dex
	bpl pflabel4
.L072 ;  return

	RTS
.
 ; 

.
 ; 

.
 ; 

.L073 ;  rem ****************************************************************************************

.L074 ;  rem Scripts for controlling objects

.L075 ;  rem ****************************************************************************************

.
 ; 

.__scriptCheckpoint
 ; __scriptCheckpoint

.L076 ;  _respawnX = player1x : _respawnY = player1y

	LDA player1x
	STA _respawnX
	LDA player1y
	STA _respawnY
.L077 ;  _respawnRoom = _playerRoom

	LDA _playerRoom
	STA _respawnRoom
.L078 ;  return

	RTS
.
 ; 

.__scriptHazard
 ; __scriptHazard

.L079 ;  COLUP0 = $44 : rem Player color

	LDA #$44
	STA COLUP0
.L080 ;  _frameCounter = 0

	LDA #0
	STA _frameCounter
.L081 ;  pop

	pla
	pla
.
 ; 

.__death
 ; __death

.L082 ;  gosub __draw

 jsr .__draw

.L083 ;  if _frameCounter < 11 then goto __death

	LDA _frameCounter
	CMP #11
     BCS .skipL083
.condpart15
 jmp .__death

.skipL083
.L084 ;  goto __respawn

 jmp .__respawn

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L085 ;  rem ******************************************************************************************************************

.L086 ;  rem Player Scripts

.L087 ;  rem ******************************************************************************************************************

.
 ; 

.__moveLeft
 ; __moveLeft

.L088 ;  _Bit1_HFlip_P0{1} = 1

	LDA _Bit1_HFlip_P0
	ORA #2
	STA _Bit1_HFlip_P0
.L089 ;  temp6  =   ( player0x - 18 )  / 4

; complex statement detected
	LDA player0x
	SEC
	SBC #18
	lsr
	lsr
	STA temp6
.L090 ;  temp5  =   ( player0y + 3 )  / 8

; complex statement detected
	LDA player0y
	CLC
	ADC #3
	lsr
	lsr
	lsr
	STA temp5
.L091 ;  if temp6  <  34 then if pfread ( temp6 , temp5 )  then return

	LDA temp6
	CMP #34
     BCS .skipL091
.condpart16
	LDA temp6
	LDY temp5
 jsr pfread
	BNE .skip16then
.condpart17
	RTS
.skip16then
.skipL091
.L092 ;  temp3  =   ( player0y - 5 )  / 8

; complex statement detected
	LDA player0y
	SEC
	SBC #5
	lsr
	lsr
	lsr
	STA temp3
.L093 ;  if temp6  <  34 then if pfread ( temp6 , temp3 )  then return

	LDA temp6
	CMP #34
     BCS .skipL093
.condpart18
	LDA temp6
	LDY temp3
 jsr pfread
	BNE .skip18then
.condpart19
	RTS
.skip18then
.skipL093
.L094 ;  temp4  =   ( player0y - 13 )  / 8

; complex statement detected
	LDA player0y
	SEC
	SBC #13
	lsr
	lsr
	lsr
	STA temp4
.L095 ;  if temp6  <  34 then if pfread ( temp6 , temp4 )  then return

	LDA temp6
	CMP #34
     BCS .skipL095
.condpart20
	LDA temp6
	LDY temp4
 jsr pfread
	BNE .skip20then
.condpart21
	RTS
.skip20then
.skipL095
.L096 ;  player0x = player0x - 2

	LDA player0x
	SEC
	SBC #2
	STA player0x
.L097 ;  _Bit3_Walking_P0{3} = 1

	LDA _Bit3_Walking_P0
	ORA #8
	STA _Bit3_Walking_P0
.L098 ;  return

	RTS
.
 ; 

.__moveRight
 ; __moveRight

.L099 ;  _Bit1_HFlip_P0{1} = 0

	LDA _Bit1_HFlip_P0
	AND #253
	STA _Bit1_HFlip_P0
.L0100 ;  temp6  =   ( player0x - 9 )  / 4

; complex statement detected
	LDA player0x
	SEC
	SBC #9
	lsr
	lsr
	STA temp6
.L0101 ;  temp5  =   ( player0y + 3 )  / 8

; complex statement detected
	LDA player0y
	CLC
	ADC #3
	lsr
	lsr
	lsr
	STA temp5
.L0102 ;  if temp6  <  34 then if pfread ( temp6 , temp5 )  then return

	LDA temp6
	CMP #34
     BCS .skipL0102
.condpart22
	LDA temp6
	LDY temp5
 jsr pfread
	BNE .skip22then
.condpart23
	RTS
.skip22then
.skipL0102
.L0103 ;  temp3  =   ( player0y - 5 )  / 8

; complex statement detected
	LDA player0y
	SEC
	SBC #5
	lsr
	lsr
	lsr
	STA temp3
.L0104 ;  if temp6  <  34 then if pfread ( temp6 , temp3 )  then return

	LDA temp6
	CMP #34
     BCS .skipL0104
.condpart24
	LDA temp6
	LDY temp3
 jsr pfread
	BNE .skip24then
.condpart25
	RTS
.skip24then
.skipL0104
.L0105 ;  temp4  =   ( player0y - 13 )  / 8

; complex statement detected
	LDA player0y
	SEC
	SBC #13
	lsr
	lsr
	lsr
	STA temp4
.L0106 ;  if temp6  <  34 then if pfread ( temp6 , temp4 )  then return

	LDA temp6
	CMP #34
     BCS .skipL0106
.condpart26
	LDA temp6
	LDY temp4
 jsr pfread
	BNE .skip26then
.condpart27
	RTS
.skip26then
.skipL0106
.L0107 ;  player0x = player0x + 2

	LDA player0x
	CLC
	ADC #2
	STA player0x
.L0108 ;  _Bit3_Walking_P0{3} = 1

	LDA _Bit3_Walking_P0
	ORA #8
	STA _Bit3_Walking_P0
.L0109 ;  return

	RTS
.
 ; 

.__moveUp
 ; __moveUp

.L0110 ;  gosub __playerIdle

 jsr .__playerIdle

.L0111 ;  temp5  =   ( player0x - 10 )  / 4

; complex statement detected
	LDA player0x
	SEC
	SBC #10
	lsr
	lsr
	STA temp5
.L0112 ;  temp6  =   ( player0y - 15 )  / 8

; complex statement detected
	LDA player0y
	SEC
	SBC #15
	lsr
	lsr
	lsr
	STA temp6
.L0113 ;  if temp5  <  34 then if pfread ( temp5 , temp6 )  then goto __touchingUp

	LDA temp5
	CMP #34
     BCS .skipL0113
.condpart28
	LDA temp5
	LDY temp6
 jsr pfread
	BNE .skip28then
.condpart29
 jmp .__touchingUp

.skip28then
.skipL0113
.L0114 ;  temp4  =   ( player0x - 17 )  / 4

; complex statement detected
	LDA player0x
	SEC
	SBC #17
	lsr
	lsr
	STA temp4
.L0115 ;  if temp4  <  34 then if pfread ( temp4 , temp6 )  then goto __touchingUp

	LDA temp4
	CMP #34
     BCS .skipL0115
.condpart30
	LDA temp4
	LDY temp6
 jsr pfread
	BNE .skip30then
.condpart31
 jmp .__touchingUp

.skip30then
.skipL0115
.L0116 ;  temp3  =  temp5  -  1

	LDA temp5
	SEC
	SBC #1
	STA temp3
.L0117 ;  if temp3  <  34 then if pfread ( temp3 , temp6 )  then goto __touchingUp

	LDA temp3
	CMP #34
     BCS .skipL0117
.condpart32
	LDA temp3
	LDY temp6
 jsr pfread
	BNE .skip32then
.condpart33
 jmp .__touchingUp

.skip32then
.skipL0117
.L0118 ;  gosub __playerWalk

 jsr .__playerWalk

.L0119 ;  player0y  =  player0y  -  2

	LDA player0y
	SEC
	SBC #2
	STA player0y
.L0120 ;  return

	RTS
.
 ; 

.__moveDown
 ; __moveDown

.L0121 ;  gosub __playerFlippedIdle

 jsr .__playerFlippedIdle

.L0122 ;  temp5  =   ( player0x - 10 )  / 4

; complex statement detected
	LDA player0x
	SEC
	SBC #10
	lsr
	lsr
	STA temp5
.L0123 ;  temp6  =   ( player0y + 5 )  / 8

; complex statement detected
	LDA player0y
	CLC
	ADC #5
	lsr
	lsr
	lsr
	STA temp6
.L0124 ;  if temp5  <  34 then if pfread ( temp5 , temp6 )  then goto __touchingDown

	LDA temp5
	CMP #34
     BCS .skipL0124
.condpart34
	LDA temp5
	LDY temp6
 jsr pfread
	BNE .skip34then
.condpart35
 jmp .__touchingDown

.skip34then
.skipL0124
.L0125 ;  temp4  =   ( player0x - 17 )  / 4

; complex statement detected
	LDA player0x
	SEC
	SBC #17
	lsr
	lsr
	STA temp4
.L0126 ;  if temp4  <  34 then if pfread ( temp4 , temp6 )  then goto __touchingDown

	LDA temp4
	CMP #34
     BCS .skipL0126
.condpart36
	LDA temp4
	LDY temp6
 jsr pfread
	BNE .skip36then
.condpart37
 jmp .__touchingDown

.skip36then
.skipL0126
.L0127 ;  temp3  =  temp5  -  1

	LDA temp5
	SEC
	SBC #1
	STA temp3
.L0128 ;  if temp3  <  34 then if pfread ( temp3 , temp6 )  then goto __touchingDown

	LDA temp3
	CMP #34
     BCS .skipL0128
.condpart38
	LDA temp3
	LDY temp6
 jsr pfread
	BNE .skip38then
.condpart39
 jmp .__touchingDown

.skip38then
.skipL0128
.L0129 ;  gosub __playerFlippedWalk

 jsr .__playerFlippedWalk

.L0130 ;  player0y  =  player0y  +  2

	LDA player0y
	CLC
	ADC #2
	STA player0y
.L0131 ;  return

	RTS
.
 ; 

.__touchingUp
 ; __touchingUp

.L0132 ;  gosub __animate

 jsr .__animate

.L0133 ;  goto __touchingGround

 jmp .__touchingGround

.
 ; 

.__touchingDown
 ; __touchingDown

.L0134 ;  gosub __animateFlipped

 jsr .__animateFlipped

.L0135 ;  goto __touchingGround

 jmp .__touchingGround

.
 ; 

.__touchingGround
 ; __touchingGround

.L0136 ;  if joy0up  ||  joy0down then _Bit2_VFlip_P0{2} = !_Bit2_VFlip_P0{2} else if joy0fire then _Bit2_VFlip_P0{2} = !_Bit2_VFlip_P0{2}

 lda #$10
 bit SWCHA
	BNE .skipL0136
.condpart40
 jmp .condpart41
.skipL0136
 lda #$20
 bit SWCHA
	BNE .skip0OR
.condpart41
	LDA _Bit2_VFlip_P0
	AND #4
  PHP
	LDA _Bit2_VFlip_P0
	AND #251
  PLP
	.byte $D0, $02
	ORA #4
	STA _Bit2_VFlip_P0
 jmp .skipelse3
.skip0OR
 bit INPT4
	BMI .skipelse
.condpart42
	LDA _Bit2_VFlip_P0
	AND #4
  PHP
	LDA _Bit2_VFlip_P0
	AND #251
  PLP
	.byte $D0, $02
	ORA #4
	STA _Bit2_VFlip_P0
.skipelse
.skipelse3
.L0137 ;  return

	RTS
.
 ; 

.__animate
 ; __animate

.L0138 ;  if _Bit3_Walking_P0{3}  &&  _frameCounter <= 6 then gosub __playerWalk

	LDA _Bit3_Walking_P0
	AND #8
	BEQ .skipL0138
.condpart43
	LDA #6
	CMP _frameCounter
     BCC .skip43then
.condpart44
 jsr .__playerWalk

.skip43then
.skipL0138
.L0139 ;  return

	RTS
.
 ; 

.__animateFlipped
 ; __animateFlipped

.L0140 ;  if _Bit3_Walking_P0{3}  &&  _frameCounter <= 6 then gosub __playerFlippedWalk

	LDA _Bit3_Walking_P0
	AND #8
	BEQ .skipL0140
.condpart45
	LDA #6
	CMP _frameCounter
     BCC .skip45then
.condpart46
 jsr .__playerFlippedWalk

.skip45then
.skipL0140
.L0141 ;  return

	RTS
.
 ; 

.
 ; 

.
 ; 

.L0142 ;  rem ****************************************

.L0143 ;  rem GFX Area

.L0144 ;  rem ****************************************

.
 ; 

.
 ; 

.__playerIdle
 ; __playerIdle

.L0145 ;  player0:

	LDX #<playerL0145_0
	STX player0pointerlo
	LDA #>playerL0145_0
	STA player0pointerhi
	LDA #17
	STA player0height
.L0146 ;  return

	RTS
.
 ; 

.__playerWalk
 ; __playerWalk

.L0147 ;  player0:

	LDX #<playerL0147_0
	STX player0pointerlo
	LDA #>playerL0147_0
	STA player0pointerhi
	LDA #17
	STA player0height
.L0148 ;  return

	RTS
.
 ; 

.__playerFlippedIdle
 ; __playerFlippedIdle

.L0149 ;  player0:

	LDX #<playerL0149_0
	STX player0pointerlo
	LDA #>playerL0149_0
	STA player0pointerhi
	LDA #17
	STA player0height
.L0150 ;  return

	RTS
.
 ; 

.__playerFlippedWalk
 ; __playerFlippedWalk

.L0151 ;  player0:

	LDX #<playerL0151_0
	STX player0pointerlo
	LDA #>playerL0151_0
	STA player0pointerhi
	LDA #17
	STA player0height
.L0152 ;  return

	RTS
.
 ; 

.__objCheckpoint
 ; __objCheckpoint

.L0153 ;  player1:

	LDX #<playerL0153_1
	STX player1pointerlo
	LDA #>playerL0153_1
	STA player1pointerhi
	LDA #16
	STA player1height
.L0154 ;  return

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

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0155 ;  vblank

vblank_bB_code
.L0156 ;  asm

 sta HMCLR

 sta WSYNC

 lda #$ff

 sta HMM0

 lda #$c0

 sta WSYNC

 sta HMOVE

 sleep 5

 sta HMM0

.L0157 ;  return

	RTS
.
 ; 

.L0158 ;  
 ifconst pfres
 if (<*) > (254-pfres*pfwidth)
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
pfcolorlabel13
 .byte  $0E,0,0,0
 .byte  $9A,0,0,0
 .byte  $9A,0,0,0
 .byte  $9A,0,0,0
 .byte  $9A,0,0,0
 .byte  $0E,0,0,0
 .byte  $9A,0,0,0
 .byte  $9A,0,0,0
 .byte  $9A,0,0,0
 .byte  $9A,0,0,0
 .byte  $0E,0,0,0
 if (<*) > (<(*+17))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0145_0
	.byte  %01111110
	.byte  %11111111
	.byte  %11001001
	.byte  %11001001
	.byte  %11111111
	.byte  %11111111
	.byte  %11000001
	.byte  %11100011
	.byte  %01111110
	.byte  %00011000
	.byte  %00111100
	.byte  %01111110
	.byte  %01111110
	.byte  %01011010
	.byte  %00111100
	.byte  %00100100
	.byte  %01100110
	.byte  %01100110
 if (<*) > (<(*+17))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0147_0
	.byte  %00000000
	.byte  %01111110
	.byte  %11111111
	.byte  %11001001
	.byte  %11001001
	.byte  %11111111
	.byte  %11111111
	.byte  %11000001
	.byte  %11100011
	.byte  %01111110
	.byte  %00011000
	.byte  %00111100
	.byte  %01111110
	.byte  %10011001
	.byte  %00111100 
	.byte  %00100100
	.byte  %01100110
	.byte  %11000011
 if (<*) > (<(*+17))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0149_0
	.byte  %01100110
	.byte  %01100110
	.byte  %00100100
	.byte  %00111100
	.byte  %01011010
	.byte  %01111110
	.byte  %01111110
	.byte  %00111100
	.byte  %00011000
	.byte  %01111110
	.byte  %11100011
	.byte  %11000001
	.byte  %11111111
	.byte  %11111111
	.byte  %11001001
	.byte  %11001001
	.byte  %11111111
	.byte  %01111110
 if (<*) > (<(*+17))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0151_0
	.byte  %11000011
	.byte  %01100110
	.byte  %00100100
	.byte  %00111100
	.byte  %10011001
	.byte  %01111110
	.byte  %00111100
	.byte  %00011000
	.byte  %01111110
	.byte  %11100011
	.byte  %11000001
	.byte  %11111111
	.byte  %11111111
	.byte  %11001001
	.byte  %11001001
	.byte  %11111111
	.byte  %01111110
	.byte  %00000000
 if (<*) > (<(*+16))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0153_1
	.byte  %11111111
	.byte  %01111110
	.byte  %00000000
	.byte  %00111100
	.byte  %01000010
	.byte  %10000001
	.byte  %10011001
	.byte  %10111101
	.byte  %10100101
	.byte  %10100001
	.byte  %10100001
	.byte  %10100101
	.byte  %10111101
	.byte  %10011001
	.byte  %10000001
	.byte  %01000010
	.byte  %00111100
 if ECHOFIRST
       echo "    ",[(scoretable - *)]d , "bytes of ROM space left")
 endif 
ECHOFIRST = 1
 
 
 
