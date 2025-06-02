
 set romsize 16kSC

 rem ** Demo of the Cosmic Ark starfield effect in bB

 rem ** no_blank_lines takes away missile0, so we'll create our starfield
 rem ** using it.
 set kernel_options no_blank_lines

 scorecolor=$0f

 dim frame=a
 dim effect=b

   CTRLPF=5
   playfield:
   ................................
   ................................
   ................................
   ................................
   ................................
   ................................
   ................................
   ................................
   ......XXXXXXXXXXXXXXXXXXXX......
   ...XXXXXXXXXXXXXXXXXXXXXXXXXX...
   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end

 player0:
 %10000001
 %11000011
 %11111111
 %01011010
 %00111100
end

 player1:
 %00111100
 %01011010
 %11111111
 %11000011
 %10000001
end


 rem ** position the other objects, to prove we still can
 player0x=50:player0y=40
 player1x=120:player1y=40
 ballx=70:bally=40:ballheight=6
 missile1x=100:missile1y=40:missile1height=6


mainloop
 COLUP0=$0A
 COLUP1=$44
 COLUBK=$80
 COLUPF=$B4

 player0x=player0x-1

  frame=frame+1
  if frame=0 then effect=effect+1
  if effect>6 then effect=0

  ENAM0=2 : rem ** set ENAM0=0 when you want the stars to be gone

  rem ** no adjustment leaves the stars in place
  if effect=0 then score=0

  rem ** Adjusting missile0x by +1 or -1 moves the stars right or left
  if effect=1 then missile0x=missile0x-1:score=1
 
  rem ** +8 or -8 moves the stars diagonally, and displays them closer together
  if effect=2 then missile0x=missile0x-8:score=8

  rem ** +16 or -16 moves them diagonally, and displays them farther apart 
  if effect=3 then missile0x=missile0x+16:score=16

  rem ** +12 or -12 is quick and nearly vertical
  if effect=4 then missile0x=missile0x-12:score=12

  rem ** +48 or -48 is a slow diagonal effect
  if effect=5 then missile0x=missile0x-48:score=48

  rem ** +48 or -48 is a slow diagonal effect
  if effect=6 then missile0x=missile0x+32:score=32

  rem ** You need to ensure the missile0x position ranges from 0-159. 
  rem ** If missile0x is 0 and decreases, then set it to 159. 
  rem ** If missile0x is 159 and increases, set it to 0.
  if missile0x>200 then missile0x=missile0x+160
  if missile0x>159 then missile0x=missile0x-160

  drawscreen
  goto mainloop

 bank 2
 bank 3
 bank 4
   
  vblank
  rem ** Enable the TIA bug that causes missile0 to be repeated
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
