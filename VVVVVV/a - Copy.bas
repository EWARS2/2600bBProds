 
 rem set kernel_options no_blank_lines
 rem set kernel_options pfcolors
 rem set kernel multisprite
 rem set romsize 8k

 const noscore = 1
 rem const pfrowheight=5
 
 dim _frameCounter = a :rem Consolidate this
 dim _respawnX = b
 dim _respawnY = c
 dim _respawnA = d
 dim _respawnB = e
 dim _playerA = f
 dim _playerB = g
 
 dim _Bit1_HFlip_P0 = y : rem for horizontal flip
 dim _Bit2_VFlip_P0 = y : rem for vertical flip
 dim _Bit3_Walking_P0 = y : rem If walking
 
 rem COLUBK=$00 :rem bg
 COLUP0=$9A :rem player
 COLUP1=$9A :rem obj
 COLUPF=$9A :rem playfield :rem make this a single bit kind of boolean thing

 
 
 pfscroll upup
 pfscroll upup
 

 
 
 
 
 playfield:
 XXXXXXXXXXXXXXX....XXXXXXXXXXXXX
 ................................
 ................................
 ................................
 X..............................X
 X.............XXXXX............X
 X..............................X
 X..............................X
 ................................
 ................................
 ................................
 XXXXXXXXXXXXXXX....XXXXXXXXXXXXX
end

 
__start
 _respawnX=55:_respawnY=59
 player1x=75:player1y=83
 gosub __objCheckpoint
 rem NUSIZ1 = $33

__respawn
 player0x=_respawnX:player0y=_respawnY
 _Bit1_HFlip_P0{1}=0
 _Bit2_VFlip_P0{2}=1





__main
 gosub __draw
 
 
 _Bit3_Walking_P0{3}=0
 if joy0left then gosub __moveLeft
 if joy0right then gosub __moveRight
 if _Bit2_VFlip_P0{2} then gosub __moveDown else gosub __moveUp
 if player0x>135 then player0x=15
 if player0x<15 then player0x=135
 if player0y<20 then player0y=88
 if player0y>88 then player0y=20
 
 
 if collision(player0,player1) then gosub __scriptCheckpoint
 
 
 
 goto __main
 
__draw
 if _Bit1_HFlip_P0{1} then REFP0 = 8
 _frameCounter=_frameCounter+1
 if _frameCounter=12 then _frameCounter=0
 drawscreen
 if switchreset then pop:goto __respawn
 return
 
 
 
 
 
 
 
 
 
 
 rem ****************************************************************************************
 rem Scripts for controlling objects
 rem ****************************************************************************************
 
__scriptCheckpoint
 _respawnX=player1x:_respawnY=player1y
 COLUP1=$0A
 return
 
__scriptHazard
 pop:goto __respawn
 return
 
 
 
 
 
 
 
 
 
 
 
 
 rem ******************************************************************************************************************
 rem Player Scripts
 rem ******************************************************************************************************************
 
__moveLeft
 _Bit1_HFlip_P0{1}=1
 temp6 = (player0x-18)/4
 temp5 = (player0y+3)/8
 if temp6 < 34 then if pfread(temp6,temp5) then return
 temp3 = (player0y-5)/8
 if temp6 < 34 then if pfread(temp6,temp3) then return
 temp4 = (player0y-13)/8
 if temp6 < 34 then if pfread(temp6,temp4) then return
 player0x=player0x-2
 _Bit3_Walking_P0{3}=1
 return

__moveRight
 _Bit1_HFlip_P0{1}=0
 temp6 = (player0x-9)/4
 temp5 = (player0y+3)/8
 if temp6 < 34 then if pfread(temp6,temp5) then return
 temp3 = (player0y-5)/8
 if temp6 < 34 then if pfread(temp6,temp3) then return
 temp4 = (player0y-13)/8
 if temp6 < 34 then if pfread(temp6,temp4) then return
 player0x=player0x+2
 _Bit3_Walking_P0{3}=1
 return
 
__moveUp
 gosub __playerIdle
 temp5 = (player0x-10)/4
 temp6 = (player0y-15)/8
 if temp5 < 34 then if pfread(temp5,temp6) then goto __touchingUp
 temp4 = (player0x-17)/4
 if temp4 < 34 then if pfread(temp4,temp6) then goto __touchingUp
 temp3 = temp5 - 1
 if temp3 < 34 then if pfread(temp3,temp6) then goto __touchingUp
 gosub __playerWalk
 player0y = player0y - 2
 return

__moveDown
 gosub __playerFlippedIdle
 temp5 = (player0x-10)/4
 temp6 = (player0y+5)/8
 if temp5 < 34 then if pfread(temp5,temp6) then goto __touchingDown
 temp4 = (player0x-17)/4
 if temp4 < 34 then if pfread(temp4,temp6) then goto __touchingDown
 temp3 = temp5 - 1
 if temp3 < 34 then if pfread(temp3,temp6) then goto __touchingDown
 gosub __playerFlippedWalk
 player0y = player0y + 2
 return

__touchingUp
 gosub __animate
 goto __touchingGround
 
__touchingDown
 gosub __animateFlipped
 goto __touchingGround
 
__touchingGround
 if joy0up || joy0down then _Bit2_VFlip_P0{2}=!_Bit2_VFlip_P0{2} else if joy0fire then _Bit2_VFlip_P0{2}=!_Bit2_VFlip_P0{2}
 return
 
__animate
 if _Bit3_Walking_P0{3} && _frameCounter<=6 then gosub __playerWalk 
 return
 
__animateFlipped
 if _Bit3_Walking_P0{3} && _frameCounter<=6 then gosub __playerFlippedWalk 
 return








 rem *********************************************************************************************************
 rem Level Data here
 rem *********************************************************************************************************
 

 

 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 rem ****************************************
 rem GFX Area
 rem ****************************************
 
 
__playerIdle
 player0:
 %01111110
 %11111111
 %11001001
 %11001001
 %11111111
 %11111111
 %11000001
 %11100011
 %01111110
 %00011000
 %00111100
 %01111110
 %01111110
 %01011010
 %00111100
 %00100100
 %01100110
 %01100110
end
 return
 
__playerWalk
 player0:
 %00000000
 %01111110
 %11111111
 %11001001
 %11001001
 %11111111
 %11111111
 %11000001
 %11100011
 %01111110
 %00011000
 %00111100
 %01111110
 %10011001
 %00111100 
 %00100100
 %01100110
 %11000011
end
 return
 
__playerFlippedIdle
 player0:
 %01100110
 %01100110
 %00100100
 %00111100
 %01011010
 %01111110
 %01111110
 %00111100
 %00011000
 %01111110
 %11100011
 %11000001
 %11111111
 %11111111
 %11001001
 %11001001
 %11111111
 %01111110
end
 return
 
__playerFlippedWalk
 player0:
 %11000011
 %01100110
 %00100100
 %00111100
 %10011001
 %01111110
 %00111100
 %00011000
 %01111110
 %11100011
 %11000001
 %11111111
 %11111111
 %11001001
 %11001001
 %11111111
 %01111110
 %00000000
end
 return
 
__objCheckpoint
 player1:
 %00111100
 %01000010
 %10000001
 %10011001
 %10111101
 %10100101
 %10100001
 %10100001
 %10100101
 %10111101
 %10011001
 %10000001
 %01000010
 %00111100
end
 return
 
__objBigSpikeUp
 player1:
 %11111111
 %01000010
 %00100100
 %00011000
end
 return
 
__objBigSpikeDown
 player1:
 %00011000
 %00100100
 %01000010
 %11111111
end
 return
 
__objBigSpikeRight
 player1:
 %10000000
 %11000000
 %10100000
 %10010000
 %10010000
 %10100000
 %11000000
 %10000000
end
 return
 
 
 
 rem inline pfread_msk.asm