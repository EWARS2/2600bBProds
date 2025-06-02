game
.L00 ;  set kernel_options no_blank_lines

.L01 ;  set romsize 2k

.
 ; 

.L02 ;  const noscore  =  1

.
 ; 

.
 ; 

.L03 ;  dim _frameCounter = a

.
 ; 

.
 ; 

.__start
 ; __start

.
 ; 

.L04 ;  COLUPF = $84

	LDA #$84
	STA COLUPF
.L05 ;  COLUBK = $00

	LDA #$00
	STA COLUBK
.L06 ;  CTRLPF = 5

	LDA #5
	STA CTRLPF
.L07 ;  COLUP1 = $0E

	LDA #$0E
	STA COLUP1
.L08 ;  COLUP0 = $0E

	LDA #$0E
	STA COLUP0
.
 ; 

.L09 ;  playfield:

  ifconst pfres
	  ldx #(10>pfres)*(pfres*pfwidth-1)+(10<=pfres)*39
  else
	  ldx #((10*pfwidth-1)*((10*pfwidth-1)<47))+(47*((10*pfwidth-1)>=47))
  endif
	jmp pflabel0
PF_data0
	.byte %00010010, %01000100
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00100101, %01001010
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00010010, %11000100
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00011001, %00010011
	if (pfwidth>2)
	.byte %00100011, %00000000
 endif
	.byte %00010101, %00110000
	if (pfwidth>2)
	.byte %01100100, %00000001
 endif
	.byte %00011001, %01010111
	if (pfwidth>2)
	.byte %10100100, %00000001
 endif
	.byte %00000001, %10010000
	if (pfwidth>2)
	.byte %00100100, %00000001
 endif
	.byte %00000001, %00010011
	if (pfwidth>2)
	.byte %00100011, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00100000, %00000000
 endif
pflabel0
	lda PF_data0,x
	sta playfield,x
	dex
	bpl pflabel0
.
 ; 

.L010 ;  _frameCounter = 0

	LDA #0
	STA _frameCounter
.__1
 ; __1

.L011 ;  ENAM0 = 2

	LDA #2
	STA ENAM0
.L012 ;  drawscreen

 jsr drawscreen
.L013 ;  if _frameCounter < 50 then _frameCounter = _frameCounter + 1 : goto __1

	LDA _frameCounter
	CMP #50
     BCS .skipL013
.condpart0
	INC _frameCounter
 jmp .__1

.skipL013
.
 ; 

.
 ; 

.L014 ;  playfield:

  ifconst pfres
	  ldx #(10>pfres)*(pfres*pfwidth-1)+(10<=pfres)*39
  else
	  ldx #((10*pfwidth-1)*((10*pfwidth-1)<47))+(47*((10*pfwidth-1)>=47))
  endif
	jmp pflabel1
PF_data1
	.byte %01010010, %11101110
	if (pfwidth>2)
	.byte %01010001, %00000001
 endif
	.byte %01110101, %10101010
	if (pfwidth>2)
	.byte %01010001, %00000010
 endif
	.byte %01010111, %01100110
	if (pfwidth>2)
	.byte %00100001, %01110001
 endif
	.byte %00000101, %00100010
	if (pfwidth>2)
	.byte %00100001, %00000010
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000001, %00000001
 endif
	.byte %01100010, %00001010
	if (pfwidth>2)
	.byte %10010010, %00011011
 endif
	.byte %01010101, %10001110
	if (pfwidth>2)
	.byte %00101010, %00101001
 endif
	.byte %01100111, %10000100
	if (pfwidth>2)
	.byte %00111010, %00011011
 endif
	.byte %00000101, %00000100
	if (pfwidth>2)
	.byte %10101010, %00101001
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00011011
 endif
pflabel1
	lda PF_data1,x
	sta playfield,x
	dex
	bpl pflabel1
.
 ; 

.
 ; 

.L015 ;  _frameCounter = 0

	LDA #0
	STA _frameCounter
.__2
 ; __2

.L016 ;  ENAM0 = 2

	LDA #2
	STA ENAM0
.L017 ;  drawscreen

 jsr drawscreen
.L018 ;  if _frameCounter < 50 then _frameCounter = _frameCounter + 1 : goto __2

	LDA _frameCounter
	CMP #50
     BCS .skipL018
.condpart1
	INC _frameCounter
 jmp .__2

.skipL018
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

.L019 ;  goto __start

 jmp .__start

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L020 ;  vblank

vblank_bB_code
.L021 ;  asm

 sta HMCLR

 sta WSYNC

 lda #$ff

 sta HMM0

 lda #$c0

 sta WSYNC

 sta HMOVE

 sleep 5

 sta HMM0

.L022 ;  return
	RTS
 if ECHOFIRST
       echo "    ",[(scoretable - *)]d , "bytes of ROM space left")
 endif 
ECHOFIRST = 1
 
 
 
