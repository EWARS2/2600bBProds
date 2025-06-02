 set kernel_options player1colors :rem playercolors
 
 
 scorecolor=$0E
 const _animationLength=26
 
 dim _Room=a
 
 dim _Bit7P1HFlip=y
 
 
 COLUPF=$0E
 
 
 _Room=1
 
 dim _frameCounter=a


 player1color:
   $04
   $90
   $92
   $94
   $2C
   $2E
   $9E
   $20
   $2A
   $2C
   $2E
   $24
   $22
   $20
end



__start
 
 playfield:
 XXXXXXXXXXXXXXXXXXXXXX.XXXXXXXXX
 XXXXXX.......................XXX
 XXXXX........................XXX
 XXXX.........................XXX
 XXX..........................XXX
 .............................XXX
 .............................XX.
 ................................
 ..............................XX
 XXXX.......................XXXXX
 XXXXXXX..................XXXXXXX
 ................................
end
 
 COLUBK=$C4
 

 player1x=50:player1y=50
 
 gosub __playerDown
 
__main
 if joy0left then gosub __moveLeft
 if joy0right then gosub __moveRight
 if joy0up then gosub __moveUp
 if joy0down then gosub __moveDown
 if player1x>200 then player1x=player1x+160:_Room=_Room-1
 if player1x>159 then player1x=player1x-160:_Room=_Room+1
 
 gosub __draw
 goto __main
__draw
 _frameCounter=_frameCounter+1
 if _frameCounter>=_animationLength then _frameCounter=0
 if _Bit7P1HFlip{7} then REFP1 = 8
 rem COLUBK=_DataBGColor[_Room]
 drawscreen
 if switchreset then goto __start
 return
 
 
 
 
 
 
 
 rem temp5 is x & temp6 is y
 
__moveLeft
 _Bit7P1HFlip{7}=1
 temp5 = (player1x-18)/4
 temp6 = (player1y-1)/8
 if temp5 < 34 then if pfread(temp5,temp6) then goto __touching
 temp6 = (player1y-8)/8
 if temp5 < 34 then if pfread(temp5,temp6) then goto __touching
 player1x=player1x-1
 if _frameCounter<(_animationLength/2) then gosub __playerWalk0 else gosub __playerWalk1
 return

__moveRight
 _Bit7P1HFlip{7}=0
 temp5 = (player1x-9)/4
 temp6 = (player1y-1)/8
 if temp5 < 34 then if pfread(temp5,temp6) then goto __touching
 temp6 = (player1y-8)/8
 if temp5 < 34 then if pfread(temp5,temp6) then goto __touching
 player1x=player1x+1
 if _frameCounter<(_animationLength/2) then gosub __playerWalk0 else gosub __playerWalk1
 return
 
__moveUp
 temp5 = (player1x-10)/4
 temp6 = (player1y-9)/8
 if temp5 < 34 then if pfread(temp5,temp6) then goto __touching
 temp5 = temp5-1
 if temp5 < 34 then if pfread(temp5,temp6) then goto __touching
 temp5 = (player1x-17)/4
 if temp5 < 34 then if pfread(temp5,temp6) then goto __touching
 player1y=player1y-1
 gosub __playerUp
 REFP1 = 0
 if _frameCounter<(_animationLength/2) then _Bit7P1HFlip{7}=1 else _Bit7P1HFlip{7}=0
 return

__moveDown
 temp5 = (player1x-10)/4
 temp6 = (player1y)/8
 if temp5 < 34 then if pfread(temp5,temp6) then goto __touching
 temp5 = temp5-1
 if temp5 < 34 then if pfread(temp5,temp6) then goto __touching
 temp5 = (player1x-17)/4
 if temp5 < 34 then if pfread(temp5,temp6) then goto __touching
 player1y=player1y+1
 gosub __playerDown
 REFP1 = 0
 if _frameCounter<(_animationLength/2) then _Bit7P1HFlip{7}=1 else _Bit7P1HFlip{7}=0
 return
 
__notTouching
 temp5=temp5-1:temp6=temp6-1
 if joy0fire then pfpixel temp5 temp6 on:score=score-1
 return

__touching
 pfpixel temp5 temp6 off:score=score+1
 return
 
 
 
 
 
   data _DataBGColor
   $20,
   $30,
   $50,
   $B0,
   $C0,
   $D0,
   $E0,
   $F0,

   $80,
   $62,
   $C2,
   $60,
   $40,
   $D2,
   $30,
   $D0,

   $62,
   $62,
   $90,
   $90,
   $D0,
   $D0,
   $40,
   $40,

   $C2,
   $C0,
   $20,
   $22,
   $22,
   $D2,
   $C2,
   $22
end
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 

 
 
 
 
__playerDown
 player1:
 %00110000
 %00110000
 %00111100
 %00111100
 %00000011
 %10000011
 %11111110
 %01111110
 %01111110
 %01011010
 %01111110
 %01111110
 %01111110
 %01111110
end
 return
 
__playerUp
 player1:
 %00110000
 %00110000
 %00111100
 %00111100
 %00000011
 %10000011
 %11111110
 %01111110
 %01111110
 %01111110
 %01111110
 %01111110
 %01111110
 %01111110
end
 return
 
__playerWalk0
 player1:
 %00011000
 %00011000
 %00011000
 %00011000
 %00011000
 %00011000
 %00011000
 %01111110
 %01111110
 %01111010
 %01111110
 %01111110
 %01111110
 %01111110
end
 return
 
__playerWalk1
 player1:
 %11000011
 %11110011
 %11111111
 %00111100
 %11000011
 %11000011
 %11111111
 %01111110
 %01111110
 %01111010
 %01111110
 %01111110
 %01111110
 %01111110
end
 return