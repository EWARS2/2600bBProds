 set kernel_options no_blank_lines
 const noscore = 1
 CTRLPF=5
 COLUPF=$0A
 COLUP0=$42
 
 dim _frameCounter = a
 
 dim _Bit1_P0_Walk = y
 
 player0x=70
 player0y=55
 
 
 
 
__main
 _Bit1_P0_Walk{1}=0
 if joy0up then missile0x=missile0x+34:_Bit1_P0_Walk{1}=1
 if joy0down then missile0x=missile0x-34:_Bit1_P0_Walk{1}=1
 if joy0left then missile0x=missile0x+1:_Bit1_P0_Walk{1}=1
 if joy0right then missile0x=missile0x-1:_Bit1_P0_Walk{1}=1
 if missile0x>200 then missile0x=missile0x+160
 if missile0x>159 then missile0x=missile0x-160
 if _frameCounter<6 && _Bit1_P0_Walk{1} then gosub __playerWalk1 else gosub __playerIdle 

 gosub __draw
 goto __main
__draw
 ENAM0=2
 _frameCounter=_frameCounter+1
 if _frameCounter>=12 then _frameCounter=0
 drawscreen
return
 
__playerIdle
 player0:
 %00111110
 %00101010
 %00101010
 %01100010
 %10100110
 %10101001
 %10101001
 %01100110
 %00100100
 %00011000
end
 return
 
__playerWalk1
 player0:
 %00000000
 %00000000
 %11111111
 %10001001
 %01100010
 %10100110
 %10101001
 %10101001
 %01100110
 %00100100
 %00011000
end
 return
 
 
 

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