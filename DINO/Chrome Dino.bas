 set kernel_options pfcolors no_blank_lines background
 set romsize 4k
 rem set smartbranching on
 
 rem COLUPF=$06 :rem PlayField Gray
 scorecolor=$06
 AUDV0=8
 player0x=41
 const pfres=3
 
 
 dim _velocity=a
 dim _frameCounter=b
 dim _rng=c
 dim _scoreTemp=d
 dim _speed=e
 dim _checkpointCount=f
 
 dim _Bit7_Flip_P1 = y


 
 
 
 
 


__title
 player0y=55
 player1x=0
 _speed=2
 score=0
 _scoreTemp=0
 _checkpointCount=0
 _velocity=10
 gosub __pfidle
 gosub __draw
 if !joy0fire && !joy0up then goto __title






__mainloop
 _frameCounter=_frameCounter+1
 if _frameCounter>=6 then missile0x=missile0x-_speed:score=score+_speed:_scoreTemp=_scoreTemp+_speed:_frameCounter=0
 if missile0x>200 then missile0x=missile0x+160
 player1x=player1x-_speed
 if player1x>200 then gosub __nextObj
 
 if _rng=3 then gosub __animBird else gosub __obcactus

 




 player0y=(player0y-_velocity)+10
 gosub __physics
 if joy0down then gosub __physics:gosub __pfduck
 
 
 if _scoreTemp>=100 then gosub __checkpoint
 
 
  
 if collision(player0,player1) then goto __gameover
 gosub __draw
 goto __mainloop

__draw
 if switchbw then gosub __bg_black else gosub __bg_white
 if _rng<3 && _Bit7_Flip_P1{7} then REFP1 = 8
 if _rng<=1 then NUSIZ1=$31 
 drawscreen
 AUDC0=0
 AUDF0=12
 if switchreset then pop:goto __title
 return

 
 
 
 

 rem **********
 rem Reused suff
 rem **********

__physics
 if player0y >= 55 then gosub __touchingGnd else gosub __gravity
 return
 
__touchingGnd
 player0y=55
 _velocity=10
 if _frameCounter=1 then gosub __input
 if _frameCounter<3 then gosub __pf2 else gosub __pf3
 return
 
__input
 if joy0fire || joy0up then AUDC0=12:_velocity=13
 return
 
__gravity
 if _velocity>0 && _frameCounter=4 then _velocity=_velocity-1
 gosub __pfidle
 return

__nextObj
 _rng=(rand&3)
 player1x=157+(_rng)
 if _rng=3 then player1y=46 else player1y=55
 _Bit7_Flip_P1{7} = !_Bit7_Flip_P1{7}
 return

__animBird
 if _frameCounter<3 then gosub __obbird1 else gosub __obbird2
 return

__checkpoint
 AUDF0=5
 AUDC0=12
 if _checkpointCount>=3 && _speed<4 then _speed=_speed+1:_checkpointCount=0 else _scoreTemp=0:_checkpointCount=_checkpointCount+1
 return





__gameover
 AUDC0=7
 gosub __pfdead
 
__gameover1
 gosub __draw
 if joy0fire || joy0up then goto __gameover1

__gameover2
 gosub __draw
 if !joy0fire && !joy0up then goto __gameover2
 
__gameover3
 gosub __draw
 if joy0fire || joy0up then goto __gameover3
 goto __title

__bg_white
 rem COLUBK=$0F
 
 pfcolors:
   $0F
   $0F
   $0F
   $0F
   $0F
   $0F
   $0F
   $0F
   $06
   $0F
   $0F
   $0F
end
 
 return

__bg_black
 rem COLUBK=$00
 ENAM0=2
 
 pfcolors:
   $00
   $00
   $00
   $00
   $00
   $00
   $00
   $00
   $06
   $00
   $00
   $00
end
 
 return
 
 
 rem *********************
 rem Area reserved for GFX
 rem *********************
 
__pf2
__pf3
__pfdead
__pfidle

 player0:
 %00101000
 %00101000
 %00101000
 %01111000
 %11111010
 %11111110
 %10111000
 %10011000
 %00001110
 %00001000
 %00001111
 %00001011
 %00000110
end
 return
 
 
 /*
__pf2
 player0:
 %00001000
 %00001000
 %00101000
 %01111000
 %11111010
 %11111110
 %10111000
 %10011000
 %00001110
 %00001000
 %00001111
 %00001011
 %00000110
end
 return
 
__pf3
 player0:
 %00100000
 %00100000
 %00101000
 %01111000
 %11111010
 %11111110
 %10111000
 %10011000
 %00001110
 %00001000
 %00001111
 %00001011
 %00000110
end
 return
 
 
 
__pfdead
 player0:
 %00101000
 %00101000
 %00101000
 %01111000
 %11111010
 %11111110
 %10111000
 %10011000
 %00001000
 %00001110
 %00001001
 %00001001
 %00000110
end
 return

 */



__pfduck
 player0:
 %10100000
 %10101000
 %11111110
 %11111000
 %11111111
 %10111111
 %10001011
 %00000110
end
 return
 
__obcactus
 player1:
 %00111000
 %00111000
 %00111000
 %00111110
 %00111111
 %00111011
 %11111011
 %10111011
 %10111011
 %10111011
 %10111000
 %00111000
 %00010000
end
 return
 
__obbird1
 player1:
 %00010000
 %00011000
 %00011100
 %00011111
 %00011110
 %00011111
 %00111100
 %11110000
 %01100000
 %00100000
end
 return
 
__obbird2
 player1:
 %00000000
 %00000000
 %00000000
 %00000000
 %00000000
 %00011111
 %00111110
 %11111111
 %01101110
 %00101100
 %00001000
end
 return
 
 /*
 rem gameoversprites
 rem player0:
 rem %01110010
 rem %01010111
 rem %01010101
 rem %01010101
 rem %01110101
 rem %00000000
 rem %11101010
 rem %10101010
 rem %10001110
 rem %10001010
 rem %11100100
 rem end
 rem player1:
 rem %01101010
 rem %01001010
 rem %01101100
 rem %01001010
 rem %01101100
 rem %00000000
 rem %10101011
 rem %10101010
 rem %10101011
 rem %10101010
 rem %01010011
 rem end
  */
  
  
 vblank
 asm
 sta HMCLR
 sta WSYNC
 lda #$ff
 sta HMM0
 lda #$c0
 sta WSYNC
 sta HMOVE
 sleep 5
 sta HMM0
end
 return
 
 