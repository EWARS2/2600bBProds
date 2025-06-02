game
.
 ; 

.
 ; 

.__main
 ; __main

.L00 ;  drawscreen

 jsr drawscreen
.L01 ;  goto __main

 jmp .__main

.
 ; 

.L02 ;  vblank

vblank_bB_code
.L03 ;  asm

 sta WSYNC

   lda #$46

   sta COLUBK

   sta WSYNC

   lda #$44

   sta COLUBK

   rts

.L04 ;  return
	RTS
 if ECHOFIRST
       echo "    ",[(scoretable - *)]d , "bytes of ROM space left")
 endif 
ECHOFIRST = 1
 
 
 
