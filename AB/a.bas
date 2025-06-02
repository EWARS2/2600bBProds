 set kernel_options player1colors playercolors pfcolors
 
 
 
 scorecolor=$0E
 COLUPF=$F4
 
 
__main
 
 drawscreen
 goto __main
 

 vblank
 asm
 sta HMCLR
 sta WSYNC
 lda #$C8
 sta HMM0
 lda #$2C
 sta WSYNC
 sta HMOVE
 sleep 5
 sta HMM0
end
 return