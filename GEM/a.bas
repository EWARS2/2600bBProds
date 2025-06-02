 set smartbranching on
 dim rand1=$DA
 set kernel multisprite
 set optimization speed
 set romsize 4k
 const screenheight=88
 rem const noscore=1
 
 const _mouseSpeed=7
 
 dim _up=a
 dim _down=b
 dim _left=c
 dim _right=d
 
 COLUPF=0
 pfheight=0
 playfield:
 ................
 XX..XX..X.X.X...
 X.X.X..X..X.X...
 X.X.XX.XX.XX....
 X.X.X...X.X.X...
 XX..XX.X..X.X...
 ................
 ................
 ................
 ................
 ................
 ................
 ................
 ................
 ................
 ................
 ................
 XXXXXXXX........
 XXXXXXXX........
 XXXXXXXX........
 XXXXXXXX........
 XXXXXXXX........
 XXXXXXXX........
 XXXXXXXX........
 XXXXXXXX........
 XXXXXXXX........
 XXXXXXXX........
 XXXXXXXX........
 XXXXXXXX........
 XXXXXXXX........
 XXXXXXXX........
 XXXXXXXX........
 XXXXXXXX........
 XXXXXXXX........
 XXXXXXXX........
 XXXXXXXX........
 XXXXXXXX........
 XXXXXXXX........
 XXXXXXXX........
 XXXXXXXX........
 XXXXXXXX........
 XXXXXXXX........
 XXXXXXXX........
 XXXXXXXX........
 XXXXXXXX........
 XXXXXXXX........
 XXXXXXXX........
 ................
 ................
 ................
 XXXX............
 XXXX............
 XXXX............
 XXXX............
 XXXX............
 XXXX............
 XXXX............
 XXXX............
 XXXX............
 XXXX............
 XXXX............
 XXXX............
 XXXX............
 XXXX............
 XXXX............
 XXXX............
 XXXX............
 XXXX............
 XXXX............
 XXXX............
 XXXX............
 XXXX............
 XXXX............
 XXXX............
 XXXX............
 XXXX............
 XXXX............
 XXXX............
 XXXX............
 XXXX............
end

 
 player0x=76:player0y=51:COLUP0=0

 
 gosub __trashOG
 player2x=24:player2y=38
 
 ;108
 ;y=72

 
 gosub __file
 
 player3x=24:player3y=70
 player4x=25:player4y=0
 player5x=50:player5y=1:COLUP5=0
 
 
 
 
__main

 /** if joy0up then player0y=player0y+1
 if joy0down then player0y=player0y-1
 if joy0left then player0x=player0x-1
 if joy0right then player0x=player0x+1 **/

 if joy0up && _up<_mouseSpeed then _up=_up+2
 if joy0down && _down<_mouseSpeed then _down=_down+2
 if joy0left && _left<_mouseSpeed then _left=_left+2
 if joy0right && _right<_mouseSpeed then _right=_right+2
 
 if _up>0 then _up=_up-1
 if _down>0 then _down=_down-1
 if _left>0 then _left=_left-1
 if _right>0 then _right=_right-1
 
 player0x=player0x+_right/2
 player0x=player0x-_left/2
 player0y=player0y+_up/2
 player0y=player0y-_down/2

 if player0y>90 then player0y=90
 if player0y<11 then player0y=11
 if player0x>200 then player0x=0
 if player0x>143 then player0x=143
 
 
 if joy0fire then gosub __cursorLoad else gosub __cursor1
 drawscreen
 goto __main

 
 ;***************
 ; Graphics Space
 ;***************
 
 
__cursor1
 NUSIZ0=$30
 player0:
 %00000110
 %00000110
 %00001100
 %10001100
 %11011000
 %11111000
 %11111111
 %11111110
 %11111100
 %11111000
 %11110000
 %11100000
 %11000000
 %10000000
end
 return
 
__cursorLoad
 NUSIZ0=$35
 player0:
 %11111111
 %01101010
 %01010110
 %01101010
 %00110100
 %00101100
 %00011000
 %00011000
 %00110100
 %00101100
 %01010110
 %01001010
 %01000010
 %11111111
end
 return

__trash
 COLUP2=14
 NUSIZ2=$35
 player2:
 %11000011
 %10000001
 %01111110
 %01011010
 %01011010
 %01011010
 %01011010
 %01011010
 %01011010
 %01011010
 %01011010
 %01011010
 %01011010
 %01011010
 %01011010
 %01011010
 %01011010
 %01011010
 %01011010
 %01011010
 %01111110
 %10000001
 %00000000
 %01111110
 %01111110
 %01111110
 %10000001
 %11011011
 %11000011
 %11100111
end
 return

__trashOG
 COLUP2=14
 NUSIZ2=$35
 player2:
 %11111111
 %11000011
 %10111101
 %01000100
 %00010000
 %01010100
 %01010100
 %01010100
 %01010100
 %01010100
 %01010100
 %01010100
 %01010100
 %01010100
 %01010100
 %01010000
 %01000000
 %01001000
 %01010100
 %01010100
 %01010100
 %01010100
 %01010100
 %01111110
 %10000001
 %00111100
 %01111110
 %00100100
 %10011001
 %11100111
end
 return

__file
 COLUP3=14
 NUSIZ3=$35
 player3:
 %00000011
 %01111011
 %01111011
 %01111011
 %00001001
 %00101001
 %01111001
 %01111001
 %00001000
 %00101000
 %00101000
 %00001000
 %01111000
 %01111000
 %01111000
 %01111000
 %01111000
 %01111000
 %01111000
 %00000000
 %01111000
 %00001000
 %10100000
 %10000000
 %10110000
 %11010110
 %11000110
 %11110101
 %11111001
end
 return

__floppyA
 COLUP3=14
 player3:
 %01011010
 %01000010
 %01011010
 %01100110
 %00000000
 %00111100
 %00110100
 %00110101
end
 return

__floppyB
 COLUP4=14
 player4:
 %01000110
 %01011010
 %01000110
 %01011010
 %00000000
 %00111100
 %00110100
 %00110101
end
 return

 
 data msk_bgcolor
 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200
 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200
 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200
 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200
 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 0, 14, 14, 14
 14, 14, 14, 14, 14, 14
end


 asm
minikernel
   sta WSYNC
   lda 0
   sta COLUBK
   rts
end
 
