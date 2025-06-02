game
.L00 ;  set kernel_options player1colors playercolors pfcolors

.
 ; 

.
 ; 

.
 ; 

.L01 ;  scorecolor = $0E

	LDA #$0E
	STA scorecolor
.L02 ;  COLUPF = $F4

	LDA #$F4
	STA COLUPF
.
 ; 

.
 ; 

.__main
 ; __main

.
 ; 

.L03 ;  drawscreen

 jsr drawscreen
.L04 ;  goto __main

 jmp .__main

.
 ; 

.
 ; 

.L05 ;  vblank

vblank_bB_code
.L06 ;  asm

 sta HMCLR

 sta WSYNC

 lda #$C8

 sta HMM0

 lda #$2C

 sta WSYNC

 sta HMOVE

 sleep 5

 sta HMM0

.L07 ;  return
	RTS
 if ECHOFIRST
       echo "    ",[(scoretable - *)]d , "bytes of ROM space left")
 endif 
ECHOFIRST = 1
 
 
 
