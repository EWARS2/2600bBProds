game
.L00 ;  set kernel_options pfcolors no_blank_lines background

.L01 ;  set optimization size

.L02 ;  pfscroll upup

	LDA #6
 jsr pfscroll
.L03 ;  pfscroll upup

	LDA #6
 jsr pfscroll
.L04 ;  pfcolors:

 lda # $06
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
.L05 ;  COLUPF = $92

	LDA #$92
	STA COLUPF
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

.__main
 ; __main

.L06 ;  drawscreen

 jsr drawscreen
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

.L07 ;  goto __main

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

.L08 ;  data _level

	JMP .skipL08
_level
	.byte  1,1,1,1,1 

	.byte  1,0,0,0,1 

	.byte  1,0,0,0,1 

	.byte  1,0,0,0,1 

	.byte  1,1,1,1,1

.skipL08
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
 .byte  $06,0,0,0
 .byte  $06,0,0,0
 .byte  $06,0,0,0
 .byte  $06,0,0,0
 .byte  $06,0,0,0
 .byte  $0E,0,0,0
 .byte  $0E,0,0,0
 .byte  $0E,0,0,0
 .byte  $0E,0,0,0
 .byte  $0E,0,0,0
 .byte  $06,0,0,0
 if ECHOFIRST
       echo "    ",[(scoretable - *)]d , "bytes of ROM space left")
 endif 
ECHOFIRST = 1
 
 
 
