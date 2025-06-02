 ;set kernel_options player1colors pfcolors no_blank_lines background
 set kernel_options player1colors pfcolors pfheights background
 set smartbranching on
 dim rand1=$DA
 ;set kernel multisprite
 set optimization speed
 set romsize 2k
 const screenheight=88
 const noscore=1

 ;const pfrowheight=8
 
 const _mouseSpeed=7
 
 dim _up=a
 dim _down=b
 dim _left=c
 dim _right=d

 
 pfheights:
   1
   1
   1
   1
   1
   1
   1
   1
   1
   19
   60
   1
end 
 
 pfcolors:
   $0E
   $0E
   $0E
   $00
   $C8
   $C8
   $C8
   $C8
   $C8
   $C8
   $C8
   $C8
end 
 
 
 gosub __screen0
 gosub __icons
 COLUPF=0
 player0x=76:player0y=51:COLUP0=0
 player1x=16:player1y=88:COLUP1=14


__main

 /**
 if joy0up then player1y=player1y-1
 if joy0down then player1y=player1y+1
 if joy0left then player1x=player1x-1
 if joy0right then player1x=player1x+1
 **/

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
 player0y=player0y-_up/2
 player0y=player0y+_down/2

 if player0y>110 then player0y=110
 if player0y<15 then player0y=15
 if player0x>200 then player0x=1
 if player0x>144 then player0x=144
 
 
 if joy0fire then gosub __cursorLoad else gosub __cursor1
 
 
 COLUBK=$0E
 drawscreen
 goto __main




 ;******************
 ;Playfield Graphics
 ;******************



__screen0
 playfield:
 .XX..XXX..X.X.X...XX.X.X..XXX...
 .X.X.X.X.XX.XX....XX.X.X..X.X...
 .XX..XX..X..X.X...X..X.XX.XX....
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 ................................
 ................................
 ................................
 ................................
 ................................
 ................................
 XXXX............................
 ................................
end
 return


 
 
 
 
 ;**********************
 ; Sprite Graphics Space
 ;**********************
 
 
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




__icons
 NUSIZ1=$35
 player1:
 %11111111
 %10000001
 %00111100
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
 %11111111
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
 %00100000
 %10000000
 %10110000
 %11010110
 %11000110
 %11110101
 %11111001
end
 player1color:
 200
 200
 14
 14
 14
 14
 14
 14
 14
 14
 14
 14
 14
 14
 14
 14
 14
 14
 14
 14
 14
 14
 14
 14
 200
 14
 14
 14
 200
 200
 200
 14
 14
 14
 14
 14
 14
 14
 14
 14
 14
 14
 14
 14
 14
 14
 14
 14
 14
 14
 14
 14
 14
 14
 200
 200
 200
 200
 200
 200
end
 return


