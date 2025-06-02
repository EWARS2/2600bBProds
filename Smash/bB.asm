game
.L00 ;  set kernel_options player1colors playercolors pfcolors

.
 ; 

.L01 ;  dim _P0XVel = a

.L02 ;  dim _P0YVel = b

.L03 ;  dim _P1XVel = c

.L04 ;  dim _P1YVel = d

.
 ; 

.
 ; 

.L05 ;  playfield:

  ifconst pfres
	  ldx #(10>pfres)*(pfres*pfwidth-1)+(10<=pfres)*39
  else
	  ldx #((10*pfwidth-1)*((10*pfwidth-1)<47))+(47*((10*pfwidth-1)>=47))
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
	.byte %00001111, %11111111
	if (pfwidth>2)
	.byte %11111111, %00001111
 endif
	.byte %00000011, %11111111
	if (pfwidth>2)
	.byte %11111111, %00000011
 endif
	.byte %00000000, %11111111
	if (pfwidth>2)
	.byte %11111111, %00000000
 endif
pflabel0
	lda PF_data0,x
	sta playfield,x
	dex
	bpl pflabel0
.
 ; 

.L06 ;  player0:

	LDX #<playerL06_0
	STX player0pointerlo
	LDA #>playerL06_0
	STA player0pointerhi
	LDA #13
	STA player0height
.L07 ;  player1:

	LDX #<playerL07_1
	STX player1pointerlo
	LDA #>playerL07_1
	STA player1pointerhi
	LDA #13
	STA player1height
.
 ; 

.
 ; 

.L08 ;  scorecolor = $0E

	LDA #$0E
	STA scorecolor
.L09 ;  COLUBK = $00

	LDA #$00
	STA COLUBK
.
 ; 

.L010 ;  player1color:

	LDX #<playercolorL010_1
	STX player1color
	LDA #>playercolorL010_1
	STA player1color+1
.
 ; 

.L011 ;  player0color:

	LDX #<playercolorL011_0
	STX player0color
	LDA #>playercolorL011_0
	STA player0color+1
.
 ; 

.L012 ;  pfcolors:

 lda # $0E
 sta COLUPF
 ifconst pfres
 lda #>(pfcolorlabel85-132+pfres*pfwidth)
 else
 lda #>(pfcolorlabel85-84)
 endif
 sta pfcolortable+1
 ifconst pfres
 lda #<(pfcolorlabel85-132+pfres*pfwidth)
 else
 lda #<(pfcolorlabel85-84)
 endif
 sta pfcolortable
.
 ; 

.L013 ;  player0x = 30

	LDA #30
	STA player0x
.L014 ;  player0y = 20

	LDA #20
	STA player0y
.L015 ;  player1x = 60

	LDA #60
	STA player1x
.L016 ;  player1y = 20

	LDA #20
	STA player1y
.
 ; 

.__main
 ; __main

.
 ; 

.L017 ;  if joy1left then gosub __moveLeft1

 lda #4
 bit SWCHA
	BNE .skipL017
.condpart0
 jsr .__moveLeft1

.skipL017
.L018 ;  if joy1right then gosub __moveRight1

 lda #8
 bit SWCHA
	BNE .skipL018
.condpart1
 jsr .__moveRight1

.skipL018
.L019 ;  if joy1up then gosub __moveUp1 else gosub __moveDown1

 lda #1
 bit SWCHA
	BNE .skipL019
.condpart2
 jsr .__moveUp1
 jmp .skipelse0
.skipL019
 jsr .__moveDown1

.skipelse0
.
 ; 

.L020 ;  if joy0left then gosub __moveLeft0

 bit SWCHA
	BVS .skipL020
.condpart3
 jsr .__moveLeft0

.skipL020
.L021 ;  if joy0right then gosub __moveRight0

 bit SWCHA
	BMI .skipL021
.condpart4
 jsr .__moveRight0

.skipL021
.L022 ;  if joy0up then gosub __moveUp0 else gosub __moveDown0

 lda #$10
 bit SWCHA
	BNE .skipL022
.condpart5
 jsr .__moveUp0
 jmp .skipelse1
.skipL022
 jsr .__moveDown0

.skipelse1
.
 ; 

.L023 ;  gosub __draw

 jsr .__draw

.L024 ;  goto __main

 jmp .__main

.__draw
 ; __draw

.L025 ;  drawscreen

 jsr drawscreen
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

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__moveLeft1
 ; __moveLeft1

.L027 ;  temp5  =   ( player1x - 18 )  / 4

; complex statement detected
	LDA player1x
	SEC
	SBC #18
	lsr
	lsr
	STA temp5
.L028 ;  temp6  =   ( player1y - 1 )  / 8

; complex statement detected
	LDA player1y
	SEC
	SBC #1
	lsr
	lsr
	lsr
	STA temp6
.L029 ;  if temp5  <  34 then if pfread ( temp5 , temp6 )  then return

	LDA temp5
	CMP #34
     BCS .skipL029
.condpart6
	LDA temp5
	LDY temp6
 jsr pfread
	BNE .skip6then
.condpart7
	RTS
.skip6then
.skipL029
.L030 ;  temp6  =   ( player1y - 8 )  / 8

; complex statement detected
	LDA player1y
	SEC
	SBC #8
	lsr
	lsr
	lsr
	STA temp6
.L031 ;  if temp5  <  34 then if pfread ( temp5 , temp6 )  then return

	LDA temp5
	CMP #34
     BCS .skipL031
.condpart8
	LDA temp5
	LDY temp6
 jsr pfread
	BNE .skip8then
.condpart9
	RTS
.skip8then
.skipL031
.L032 ;  player1x = player1x - 1

	DEC player1x
.L033 ;  return

	RTS
.__moveRight1
 ; __moveRight1

.L034 ;  temp5  =   ( player1x - 9 )  / 4

; complex statement detected
	LDA player1x
	SEC
	SBC #9
	lsr
	lsr
	STA temp5
.L035 ;  temp6  =   ( player1y - 1 )  / 8

; complex statement detected
	LDA player1y
	SEC
	SBC #1
	lsr
	lsr
	lsr
	STA temp6
.L036 ;  if temp5  <  34 then if pfread ( temp5 , temp6 )  then return

	LDA temp5
	CMP #34
     BCS .skipL036
.condpart10
	LDA temp5
	LDY temp6
 jsr pfread
	BNE .skip10then
.condpart11
	RTS
.skip10then
.skipL036
.L037 ;  temp6  =   ( player1y - 8 )  / 8

; complex statement detected
	LDA player1y
	SEC
	SBC #8
	lsr
	lsr
	lsr
	STA temp6
.L038 ;  if temp5  <  34 then if pfread ( temp5 , temp6 )  then return

	LDA temp5
	CMP #34
     BCS .skipL038
.condpart12
	LDA temp5
	LDY temp6
 jsr pfread
	BNE .skip12then
.condpart13
	RTS
.skip12then
.skipL038
.L039 ;  player1x = player1x + 1

	INC player1x
.L040 ;  return

	RTS
.__moveUp1
 ; __moveUp1

.L041 ;  temp5  =   ( player1x - 10 )  / 4

; complex statement detected
	LDA player1x
	SEC
	SBC #10
	lsr
	lsr
	STA temp5
.L042 ;  temp6  =   ( player1y - 9 )  / 8

; complex statement detected
	LDA player1y
	SEC
	SBC #9
	lsr
	lsr
	lsr
	STA temp6
.L043 ;  if temp5  <  34 then if pfread ( temp5 , temp6 )  then return

	LDA temp5
	CMP #34
     BCS .skipL043
.condpart14
	LDA temp5
	LDY temp6
 jsr pfread
	BNE .skip14then
.condpart15
	RTS
.skip14then
.skipL043
.L044 ;  temp5  =  temp5 - 1

	DEC temp5
.L045 ;  if temp5  <  34 then if pfread ( temp5 , temp6 )  then return

	LDA temp5
	CMP #34
     BCS .skipL045
.condpart16
	LDA temp5
	LDY temp6
 jsr pfread
	BNE .skip16then
.condpart17
	RTS
.skip16then
.skipL045
.L046 ;  temp5  =   ( player1x - 17 )  / 4

; complex statement detected
	LDA player1x
	SEC
	SBC #17
	lsr
	lsr
	STA temp5
.L047 ;  if temp5  <  34 then if pfread ( temp5 , temp6 )  then return

	LDA temp5
	CMP #34
     BCS .skipL047
.condpart18
	LDA temp5
	LDY temp6
 jsr pfread
	BNE .skip18then
.condpart19
	RTS
.skip18then
.skipL047
.L048 ;  player1y = player1y - 1

	DEC player1y
.L049 ;  return

	RTS
.__moveDown1
 ; __moveDown1

.L050 ;  temp5  =   ( player1x - 10 )  / 4

; complex statement detected
	LDA player1x
	SEC
	SBC #10
	lsr
	lsr
	STA temp5
.L051 ;  temp6  =   ( player1y )  / 8

; complex statement detected
	LDA player1y
	lsr
	lsr
	lsr
	STA temp6
.L052 ;  if temp5  <  34 then if pfread ( temp5 , temp6 )  then return

	LDA temp5
	CMP #34
     BCS .skipL052
.condpart20
	LDA temp5
	LDY temp6
 jsr pfread
	BNE .skip20then
.condpart21
	RTS
.skip20then
.skipL052
.L053 ;  temp5  =  temp5 - 1

	DEC temp5
.L054 ;  if temp5  <  34 then if pfread ( temp5 , temp6 )  then return

	LDA temp5
	CMP #34
     BCS .skipL054
.condpart22
	LDA temp5
	LDY temp6
 jsr pfread
	BNE .skip22then
.condpart23
	RTS
.skip22then
.skipL054
.L055 ;  temp5  =   ( player1x - 17 )  / 4

; complex statement detected
	LDA player1x
	SEC
	SBC #17
	lsr
	lsr
	STA temp5
.L056 ;  if temp5  <  34 then if pfread ( temp5 , temp6 )  then return

	LDA temp5
	CMP #34
     BCS .skipL056
.condpart24
	LDA temp5
	LDY temp6
 jsr pfread
	BNE .skip24then
.condpart25
	RTS
.skip24then
.skipL056
.L057 ;  player1y = player1y + 1

	INC player1y
.L058 ;  return

	RTS
.
 ; 

.__moveLeft0
 ; __moveLeft0

.L059 ;  temp5  =   ( player0x - 18 )  / 4

; complex statement detected
	LDA player0x
	SEC
	SBC #18
	lsr
	lsr
	STA temp5
.L060 ;  temp6  =   ( player0y - 1 )  / 8

; complex statement detected
	LDA player0y
	SEC
	SBC #1
	lsr
	lsr
	lsr
	STA temp6
.L061 ;  if temp5  <  34 then if pfread ( temp5 , temp6 )  then return

	LDA temp5
	CMP #34
     BCS .skipL061
.condpart26
	LDA temp5
	LDY temp6
 jsr pfread
	BNE .skip26then
.condpart27
	RTS
.skip26then
.skipL061
.L062 ;  temp6  =   ( player0y - 8 )  / 8

; complex statement detected
	LDA player0y
	SEC
	SBC #8
	lsr
	lsr
	lsr
	STA temp6
.L063 ;  if temp5  <  34 then if pfread ( temp5 , temp6 )  then return

	LDA temp5
	CMP #34
     BCS .skipL063
.condpart28
	LDA temp5
	LDY temp6
 jsr pfread
	BNE .skip28then
.condpart29
	RTS
.skip28then
.skipL063
.L064 ;  player0x = player0x - 1

	DEC player0x
.L065 ;  return

	RTS
.__moveRight0
 ; __moveRight0

.L066 ;  temp5  =   ( player0x - 9 )  / 4

; complex statement detected
	LDA player0x
	SEC
	SBC #9
	lsr
	lsr
	STA temp5
.L067 ;  temp6  =   ( player0y - 1 )  / 8

; complex statement detected
	LDA player0y
	SEC
	SBC #1
	lsr
	lsr
	lsr
	STA temp6
.L068 ;  if temp5  <  34 then if pfread ( temp5 , temp6 )  then return

	LDA temp5
	CMP #34
     BCS .skipL068
.condpart30
	LDA temp5
	LDY temp6
 jsr pfread
	BNE .skip30then
.condpart31
	RTS
.skip30then
.skipL068
.L069 ;  temp6  =   ( player0y - 8 )  / 8

; complex statement detected
	LDA player0y
	SEC
	SBC #8
	lsr
	lsr
	lsr
	STA temp6
.L070 ;  if temp5  <  34 then if pfread ( temp5 , temp6 )  then return

	LDA temp5
	CMP #34
     BCS .skipL070
.condpart32
	LDA temp5
	LDY temp6
 jsr pfread
	BNE .skip32then
.condpart33
	RTS
.skip32then
.skipL070
.L071 ;  player0x = player0x + 1

	INC player0x
.L072 ;  return

	RTS
.__moveUp0
 ; __moveUp0

.L073 ;  temp5  =   ( player0x - 10 )  / 4

; complex statement detected
	LDA player0x
	SEC
	SBC #10
	lsr
	lsr
	STA temp5
.L074 ;  temp6  =   ( player0y - 9 )  / 8

; complex statement detected
	LDA player0y
	SEC
	SBC #9
	lsr
	lsr
	lsr
	STA temp6
.L075 ;  if temp5  <  34 then if pfread ( temp5 , temp6 )  then return

	LDA temp5
	CMP #34
     BCS .skipL075
.condpart34
	LDA temp5
	LDY temp6
 jsr pfread
	BNE .skip34then
.condpart35
	RTS
.skip34then
.skipL075
.L076 ;  temp5  =  temp5 - 1

	DEC temp5
.L077 ;  if temp5  <  34 then if pfread ( temp5 , temp6 )  then return

	LDA temp5
	CMP #34
     BCS .skipL077
.condpart36
	LDA temp5
	LDY temp6
 jsr pfread
	BNE .skip36then
.condpart37
	RTS
.skip36then
.skipL077
.L078 ;  temp5  =   ( player0x - 17 )  / 4

; complex statement detected
	LDA player0x
	SEC
	SBC #17
	lsr
	lsr
	STA temp5
.L079 ;  if temp5  <  34 then if pfread ( temp5 , temp6 )  then return

	LDA temp5
	CMP #34
     BCS .skipL079
.condpart38
	LDA temp5
	LDY temp6
 jsr pfread
	BNE .skip38then
.condpart39
	RTS
.skip38then
.skipL079
.L080 ;  player0y = player0y - 1

	DEC player0y
.L081 ;  return

	RTS
.__moveDown0
 ; __moveDown0

.L082 ;  temp5  =   ( player0x - 10 )  / 4

; complex statement detected
	LDA player0x
	SEC
	SBC #10
	lsr
	lsr
	STA temp5
.L083 ;  temp6  =   ( player0y )  / 8

; complex statement detected
	LDA player0y
	lsr
	lsr
	lsr
	STA temp6
.L084 ;  if temp5  <  34 then if pfread ( temp5 , temp6 )  then return

	LDA temp5
	CMP #34
     BCS .skipL084
.condpart40
	LDA temp5
	LDY temp6
 jsr pfread
	BNE .skip40then
.condpart41
	RTS
.skip40then
.skipL084
.L085 ;  temp5  =  temp5 - 1

	DEC temp5
.L086 ;  if temp5  <  34 then if pfread ( temp5 , temp6 )  then return

	LDA temp5
	CMP #34
     BCS .skipL086
.condpart42
	LDA temp5
	LDY temp6
 jsr pfread
	BNE .skip42then
.condpart43
	RTS
.skip42then
.skipL086
.L087 ;  temp5  =   ( player0x - 17 )  / 4

; complex statement detected
	LDA player0x
	SEC
	SBC #17
	lsr
	lsr
	STA temp5
.L088 ;  if temp5  <  34 then if pfread ( temp5 , temp6 )  then return

	LDA temp5
	CMP #34
     BCS .skipL088
.condpart44
	LDA temp5
	LDY temp6
 jsr pfread
	BNE .skip44then
.condpart45
	RTS
.skip44then
.skipL088
.L089 ;  player0y = player0y + 1

	INC player0y
.L090 ;  return

	RTS
.L091 ;  
 if (<*) > (<(*+13))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL06_0
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
playerL07_1
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
playercolorL010_1
	.byte    $04
	.byte    $90
	.byte    $91
	.byte    $92
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
playercolorL011_0
	.byte    $04
	.byte    $90
	.byte    $91
	.byte    $92
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
pfcolorlabel85
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
 if ECHOFIRST
       echo "    ",[(scoretable - *)]d , "bytes of ROM space left")
 endif 
ECHOFIRST = 1
 
 
 
