 set kernel_options player1colors playercolors pfcolors
 
 dim _P0XVel=a
 dim _P0YVel=b
 dim _P1XVel=c
 dim _P1YVel=d
 
 
 playfield:
 ................................
 ................................
 ................................
 ................................
 ................................
 ................................
 ................................
 ....XXXXXXXXXXXXXXXXXXXXXXXX....
 ......XXXXXXXXXXXXXXXXXXXX......
 ........XXXXXXXXXXXXXXXX........
end

 player0:
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

 
 scorecolor=$0E
 COLUBK=$00
 
 player1color:
   $04
   $90
   $91
   $92
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

 player0color:
   $04
   $90
   $91
   $92
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
 
 pfcolors:
   $0E
   $0E
   $9A
   $9A
   $9A
   $9A
   $0E
   $9A
   $9A
   $9A
   $9A
   $0E
end
 
 player0x=30
 player0y=20
 player1x=60
 player1y=20
 
__main
 
 if joy1left then gosub __moveLeft1
 if joy1right then gosub __moveRight1
 if joy1up then gosub __moveUp1 else gosub __moveDown1
 
 if joy0left then gosub __moveLeft0
 if joy0right then gosub __moveRight0
 if joy0up then gosub __moveUp0 else gosub __moveDown0
 
 gosub __draw
 goto __main
__draw
 drawscreen
 return 
 
 
 
 
 
 
 
 
 
__moveLeft1
 temp5 = (player1x-18)/4
 temp6 = (player1y-1)/8
 if temp5 < 34 then if pfread(temp5,temp6) then return
 temp6 = (player1y-8)/8
 if temp5 < 34 then if pfread(temp5,temp6) then return
 player1x=player1x-1
 return
__moveRight1
 temp5 = (player1x-9)/4
 temp6 = (player1y-1)/8
 if temp5 < 34 then if pfread(temp5,temp6) then return
 temp6 = (player1y-8)/8
 if temp5 < 34 then if pfread(temp5,temp6) then return
 player1x=player1x+1
 return
__moveUp1
 temp5 = (player1x-10)/4
 temp6 = (player1y-9)/8
 if temp5 < 34 then if pfread(temp5,temp6) then return
 temp5 = temp5-1
 if temp5 < 34 then if pfread(temp5,temp6) then return
 temp5 = (player1x-17)/4
 if temp5 < 34 then if pfread(temp5,temp6) then return
 player1y=player1y-1
 return
__moveDown1
 temp5 = (player1x-10)/4
 temp6 = (player1y)/8
 if temp5 < 34 then if pfread(temp5,temp6) then return
 temp5 = temp5-1
 if temp5 < 34 then if pfread(temp5,temp6) then return
 temp5 = (player1x-17)/4
 if temp5 < 34 then if pfread(temp5,temp6) then return
 player1y=player1y+1
 return

__moveLeft0
 temp5 = (player0x-18)/4
 temp6 = (player0y-1)/8
 if temp5 < 34 then if pfread(temp5,temp6) then return
 temp6 = (player0y-8)/8
 if temp5 < 34 then if pfread(temp5,temp6) then return
 player0x=player0x-1
 return
__moveRight0
 temp5 = (player0x-9)/4
 temp6 = (player0y-1)/8
 if temp5 < 34 then if pfread(temp5,temp6) then return
 temp6 = (player0y-8)/8
 if temp5 < 34 then if pfread(temp5,temp6) then return
 player0x=player0x+1
 return
__moveUp0
 temp5 = (player0x-10)/4
 temp6 = (player0y-9)/8
 if temp5 < 34 then if pfread(temp5,temp6) then return
 temp5 = temp5-1
 if temp5 < 34 then if pfread(temp5,temp6) then return
 temp5 = (player0x-17)/4
 if temp5 < 34 then if pfread(temp5,temp6) then return
 player0y=player0y-1
 return
__moveDown0
 temp5 = (player0x-10)/4
 temp6 = (player0y)/8
 if temp5 < 34 then if pfread(temp5,temp6) then return
 temp5 = temp5-1
 if temp5 < 34 then if pfread(temp5,temp6) then return
 temp5 = (player0x-17)/4
 if temp5 < 34 then if pfread(temp5,temp6) then return
 player0y=player0y+1
 return
 