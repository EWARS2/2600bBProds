 
 
__main
 drawscreen
 goto __main
 
 vblank
 asm
 sta WSYNC
   lda #$46
   sta COLUBK
   sta WSYNC
   lda #$44
   sta COLUBK
   rts
end
 return