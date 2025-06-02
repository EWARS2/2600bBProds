
 set kernel_options pfcolors ;no_blank_lines background

 const noscore = 1
 
 const _mapHRes = 8 :rem Makes designing the level easier
 
 dim _frameCounter = a :rem should be 0-12
 dim _respawnX = b
 dim _respawnY = c
 dim _respawnRoom = d
 dim _playerRoom = e
 
 dim _Bit1_HFlip_P0 = y : rem for horizontal flip
 dim _Bit2_VFlip_P0 = y : rem for vertical flip
 dim _Bit3_Walking_P0 = y : rem If walking
 dim _Bit4_AnimStars = y : rem If to show stars
 
 CTRLPF=5
 
 
 pfscroll upup:pfscroll upup
 
 COLUPF=$56 :rem playfield
 
 
 rem very top color seems to be ignored?
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
 
 
 
 
 missile0height = 88
 missile0y = 88

 
__start
 _respawnX=55:_respawnY=59
 player1x=75:player1y=67
 gosub __objCheckpoint
 rem NUSIZ1 = $33
 
 
__respawn
 COLUP0=$9A :rem player
 player0x=_respawnX:player0y=_respawnY
 _playerRoom=_respawnRoom
 _Bit1_HFlip_P0{1}=0
 _Bit2_VFlip_P0{2}=1
 gosub __updateScreen
 





__main
 gosub __draw
 
 _Bit3_Walking_P0{3}=0
 if joy0left then gosub __moveLeft
 if joy0right then gosub __moveRight
 if _Bit2_VFlip_P0{2} then gosub __moveDown else gosub __moveUp
 if player0x>135 then player0x=15:_playerRoom=_playerRoom+1:gosub __updateScreen
 if player0x<15 then player0x=135:_playerRoom=_playerRoom-1:gosub __updateScreen
 if player0y<20 then player0y=88:_playerRoom=_playerRoom-_mapHRes:gosub __updateScreen
 if player0y>88 then player0y=20:_playerRoom=_playerRoom+_mapHRes:gosub __updateScreen
 
 if _playerRoom=_respawnRoom then COLUP1=$0E else COLUP1=$9A
 if collision(player0,player1) then gosub __scriptCheckpoint
 
 
 
 
 goto __main
__draw
 if _Bit1_HFlip_P0{1} then REFP0 = 8
 _frameCounter=_frameCounter+1
 if _frameCounter=12 then _frameCounter=0
 ENAM0=2
 if _Bit4_AnimStars{4} then missile0x=missile0x-1 else missile0x=0
 if missile0x>200 then missile0x=missile0x+160
 if missile0x>159 then missile0x=missile0x-160 
 drawscreen
 if switchreset then goto __scriptHazard
 return
 
__updateScreen
 /* Okay, so the limit for "on...goto..." is ~45, so plan this accordingly. 
 on (_playerA+(16*_playerB)) goto __lvl0 __lvl1 __lvl2 __lvl3 __lvl4 __lvl5 __lvl6 __lvl7 __lvl8 __lvl9 __lvl10 __lvl11 __lvl12 __lvl13 __lvl14 __lvl15 __lvl16 __lvl17 __lvl18 __lvl19 __lvl20 __lvl21 __lvl22 __lvl23 __lvl24 __lvl25 __lvl26 __lvl27 __lvl28 __lvl29 __lvl30 __lvl31 __lvl32 __lvl33 __lvl34 __lvl35 __lvl36 __lvl37 __lvl38 __lvl39 __lvl40 __lvl41 __lvl42 __lvl43 __lvl44 __lvl45 __lvl46 __lvl47 __lvl48 __lvl49 __lvl50 __lvl51 __lvl52 __lvl53 __lvl54 __lvl55 __lvl56 __lvl57 __lvl58 __lvl59 __lvl60 __lvl61 __lvl62 __lvl63 __lvl64 __lvl65 __lvl66 __lvl67 __lvl68 __lvl69 __lvl70 __lvl71 __lvl72 __lvl73 __lvl74 __lvl75 __lvl76 __lvl77 __lvl78 __lvl79 __lvl80 __lvl81 __lvl82 __lvl83 __lvl84 __lvl85 __lvl86 __lvl87 __lvl88 __lvl89 __lvl90 __lvl91 __lvl92 __lvl93 __lvl94 __lvl95 __lvl96 __lvl97 __lvl98 __lvl99 __lvl100 __lvl101 __lvl102 __lvl103 __lvl104 __lvl105 __lvl106 __lvl107 __lvl108 __lvl109 __lvl110 __lvl111 __lvl112 __lvl113 __lvl114 __lvl115 __lvl116 __lvl117 __lvl118 __lvl119 __lvl120 __lvl121 __lvl122 __lvl123 __lvl124 __lvl125 __lvl126 __lvl127 __lvl128 __lvl129 __lvl130 __lvl131 __lvl132 __lvl133 __lvl134 __lvl135 __lvl136 __lvl137 __lvl138 __lvl139 __lvl140 __lvl141 __lvl142 __lvl143 __lvl144 __lvl145 __lvl146 __lvl147 __lvl148 __lvl149 __lvl150 __lvl151 __lvl152 __lvl153 __lvl154 __lvl155 __lvl156 __lvl157 __lvl158 __lvl159 __lvl160 __lvl161 __lvl162 __lvl163 __lvl164 __lvl165 __lvl166 __lvl167 __lvl168 __lvl169 __lvl170 __lvl171 __lvl172 __lvl173 __lvl174 __lvl175 __lvl176 __lvl177 __lvl178 __lvl179 __lvl180 __lvl181 __lvl182 __lvl183 __lvl184 __lvl185 __lvl186 __lvl187 __lvl188 __lvl189 __lvl190 __lvl191 __lvl192 __lvl193 __lvl194 __lvl195 __lvl196 __lvl197 __lvl198 __lvl199 __lvl200 __lvl201 __lvl202 __lvl203 __lvl204 __lvl205 __lvl206 __lvl207 __lvl208 __lvl209 __lvl210 __lvl211 __lvl212 __lvl213 __lvl214 __lvl215 __lvl216 __lvl217 __lvl218 __lvl219 __lvl220 __lvl221 __lvl222 __lvl223 __lvl224 __lvl225 __lvl226 __lvl227 __lvl228 __lvl229 __lvl230 __lvl231 __lvl232 __lvl233 __lvl234 __lvl235 __lvl236 __lvl237 __lvl238 __lvl239 __lvl240 __lvl241 __lvl242 __lvl243 __lvl244 __lvl245 __lvl246 __lvl247 __lvl248 __lvl249 __lvl250 __lvl251 __lvl252 __lvl253 __lvl254 __lvl255
 */
 on _playerRoom goto __lvl0 __lvl1 __lvl2 __lvl3
return
 
 rem *********************************************************************************************************
 rem Level Data here
 rem *********************************************************************************************************
 
__lvl
 playfield:
 ................................
 ................................
 ..X.X..X.X..X.X..X.X..X.X..X.X..
 ...X....X....X....X....X....X...
 ................................
 ................................
 ................................
 ................................
 ................................
 ................................
 ................................
 ................................
end
 return

 /*
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
 */

__lvl0
 COLUBK=$00 :rem bg
 _Bit4_AnimStars{4}=1
 playfield:
 X.X.X.X.X.X.X.X.X.X.X.X.X.X.X.X.
 .X.X.X.X.X.X.X.X.X.X.X.X.X.X.X.X
 X.XXXXXXXXXXXXXXXXXXXXXXXXXXXXX.
 .XX..........................X.X
 X.X..........................XXX
 .XX.............................
 X.X.............................
 .XX.............................
 X.X.............................
 .XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 X.X.X.X.X.X.X.X.X.X.X.X.X.X.X.X.
 .X.X.X.X.X.X.X.X.X.X.X.X.X.X.X.X
end
 return
 
__lvl1
 COLUBK=$50 :rem bg
 _Bit4_AnimStars{4}=0
 playfield:
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 ................................
 ................................
 ................................
 ................................
 XXXXXXXXX...............XXXXXXXX
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 .X.X.X.X.X.X.X.X.X.X.X.X.X.X.X.X
end
 return 
 
__lvl2
 COLUBK=$00 :rem bg
 _Bit4_AnimStars{4}=1
 playfield:
 XXX..........................XXX
 XXX..........................XXX
 XXX..........................XXX
 XXX..........................XXX
 XXX..........................XXX
 .............................XXX
 ................................
 ................................
 ................................
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 X.X.X.X.X.X.X.X.X.X.X.X.X.X.X.X.
 .X.X.X.X.X.X.X.X.X.X.X.X.X.X.X.X
end
 return
 
__lvl3
 COLUBK=$00 :rem bg
 _Bit4_AnimStars{4}=1
 playfield:
 XXXXXXXXXXXXXXXXXXXXXX.XXXXXXXXX
 XXXXXX.......................XXX
 XXXXX........................XXX
 XXXX.........................XXX
 XXX..........................XXX
 .............................XXX
 .............................XX.
 ..............................X.
 ..............................XX
 XXXX.......................XXXXX
 XXXXXXX..................XXXXXXX
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end
 return 
 
 
 
 rem ****************************************************************************************
 rem Scripts for controlling objects
 rem ****************************************************************************************
 
__scriptCheckpoint
 _respawnX=player1x:_respawnY=player1y
 _respawnRoom=_playerRoom
 return
 
__scriptHazard
 COLUP0=$44:rem Player color
 _frameCounter=0
 pop
 
__death
 gosub __draw
 if _frameCounter<11 then goto __death
 goto __respawn
 
 

 
 
 
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
 %11111111
 %01111110
 %00000000
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
 
 
 /* The following are gfx for spikes.
 They take up a lot of resources and are thus commented out rn.
 
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
 
 