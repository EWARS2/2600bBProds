 ;set kernel_options no_blank_lines
 ;set kernel multisprite
  set debug cyclescore
 
 ;const scorefade = 1
 
 
 
 ;Fractions for smooth movement
 dim _P0x = player0x.a
 dim _P0y = player0y.b
 
 dim _xvelt = c.d
 dim _yvelt = e.f
 
 dim _xvel = g.h
 dim _yvel = i.j
 
 dim _direction = k
 dim _frame = l
 
 dim _bit1_left = x
 dim _bit2_right = x
 
 missile0height = 88
 missile0y = 88
 ;NUSIZ0=$00 ;Doesn't do squat for the missile.
 scorecolor=$0E
 ;COLUP0=$0E
 COLUPF=$2C
 

 _P0x=44.0:_P0y=44.0
 _direction=0
 
 playfield:
 XXX............................X
 ................................
 X..............................X
 ................................
 X...............X..............X
 ...............XX...............
 X...............XX.............X
 ...............XX...............
 X...............X..............X
 ................................
 XXX............................X
 XXXXXXX.........................
end
 
 
 ;**************************************
__main
 
 if joy0left then gosub __left else _bit1_left{1}=0
 if joy0right then gosub __right else _bit2_right{2}=0
 
 
 
 
 
 if _direction=255 then _direction=15
 if _direction>15 then _direction=0 
 on _direction gosub __0 __1 __2 __3 __4 __5 __6 __7 __8 __9 __10 __11 __12 __13 __14 __15
 
 ;if joy0fire then gosub __moveForward
 
 
 _P0x=_P0x+_xvel
 _P0y=_P0y+_yvel
 if _P0y>60 then gosub __scroll
 if _P0y>70 then gosub __scroll
 if _xvel>200 then _xvel=_xvel+0.06 else _xvel=_xvel-0.06
 if _yvel>200 then _yvel=_yvel+0.06 else _yvel=_yvel-0.06
 if _P0x<17 then _P0x=17.0 : _xvel=0.0-_xvel
 if _P0x>137 then _P0x=137.0 : _xvel=0.0-_xvel
 if _P0y<10 then _P0y=10.0 : _yvel=0.0;-_yvel
 
 
 _frame=_frame+1
 if _frame>20 then _frame=0 : missile0x=missile0x+1
 
 COLUBK=$9A
 ;COLUP0=$0E
 ENAM0=2
 PF0 = %11111111
 drawscreen
 goto __main
 ;************************************
 
__left
 if !_bit1_left{1} then _direction=_direction-1 : gosub __moveForward
 _bit1_left{1}=1
 return
__right
 if !_bit2_right{2} then _direction=_direction+1 : gosub __moveForward
 _bit2_right{2}=1
 return
 
__moveForward
 if _yvel<1 || _yvel>254 then _yvel=_yvel+_yvelt
 if _direction>8 then _xvelt=0.0-_xvelt
 if _xvel<1 || _xvel>254 then _xvel=_xvel+_xvelt
 return
 
__scroll
 _P0y=_P0y-1
 pfscroll up
 missile0x=missile0x-34
 if missile0x>200 then missile0x=missile0x+160
 ;if missile0x>159 then missile0x=missile0x-160
 return
 
 

 
 
 ;***************
 ;Graphics & ASM
 ;***************
 
__0
 _xvelt=0.0:_yvelt=-1.0
 player0:
 %00011000
 %00011000
 %00111100
 %01011010
 %01011010
 %00011000
 %00100100
 %00100100
end
 return
__1
 _xvelt=0.383:_yvelt=-0.924
 player0:
 %00110000
 %00110000
 %00011110
 %00111101
 %01011100
 %01010110
 %00010010
 %00010010
end
 return
__2
 _xvelt=0.707:_yvelt=-0.707
 player0:
 %00000000
 %01100000
 %01111110
 %00111000
 %00111111
 %00101001
 %00101000
 %00001100
end
 return
__3
 _xvelt=0.924:_yvelt=-0.383
 player0:
 %00000000
 %00001100
 %11010000
 %11111111
 %00111000
 %00111100
 %00100111
 %00010000
end
 return
__4
 _xvelt=1.0:_yvelt=0.00
 player0:
 %00000000
 %00011000
 %00100011
 %11111100
 %11111100
 %00100011
 %00011000
 %00000000
end
 return
__5
 _xvelt=0.924:_yvelt=0.383
 player0:
 %00010000
 %00100111
 %00111100
 %00111000
 %11111111
 %11010000
 %00001100
 %00000000
end
 return
__6
 _xvelt=0.707:_yvelt=0.707
 player0:
 %00001100
 %00101000
 %00101001
 %00111111
 %00111000
 %01111110
 %01100000
 %00000000
end
 return
__7
 _xvelt=0.383:_yvelt=0.924
 player0:
 %00010010
 %00010010
 %01010110
 %01011100
 %00111101
 %00011110
 %00110000
 %00110000
end
 return
__8
 _xvelt=0.0:_yvelt=1.0
 player0:
 %00100100
 %00100100
 %00011000
 %01011010
 %01011010
 %00111100
 %00011000
 %00011000
end
 return
__9 
 REFP0=8
 goto __7
__10
 REFP0=8
 goto __6
__11
 REFP0=8
 goto __5
__12
 REFP0=8
 goto __4
__13
 REFP0=8
 goto __3
__14
 REFP0=8
 goto __2
__15
 REFP0=8
 goto __1
 
 ;Changes the score's background color.
 asm
minikernel
   sta WSYNC
   lda #$46
   sta COLUBK
   sta WSYNC
   lda #$44
   sta COLUBK
   rts
end 
 
 ;Enables the TIA chip bug that creates the starfield effect.
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
 