 set kernel_options no_blank_lines
 set romsize 2k
 
 const noscore = 1
 
 
 dim _frameCounter=a
 
 
__start 

 COLUPF=$84
 COLUBK=$00
 CTRLPF=5
 COLUP1=$0E
 COLUP0=$0E
 
 playfield:
 ...X..X...X...X.................
 ..X..X.X.X.X..X.................
 ...X..X...X...XX................
 ................................
 ...XX..XXX..X.....X...XX........
 ...X.X.X....XX...XX..X..X.......
 ...XX..XXXX.X.X.X.X..X..X.......
 .......X....X..X..X..X..X.......
 .......XXX..X.....X...XX........
 ..................X.............
end
 
 _frameCounter=0
__1
 ENAM0=2
 drawscreen
 if _frameCounter<50 then _frameCounter=_frameCounter+1:goto __1
 
 
 playfield:
 .X.X..X..XXX.XXX.X.X...XX.......
 .XXX.X.X.X.X.X.X.X.X...X.X......
 .X.X.XXX.XX..XX...X....XX...XXX.
 .....X.X.X...X....X....X.X......
 .......................XX.......
 .XX...X..X.X....X..X..X.XX.XX...
 .X.X.X.X.XXX...X..X.X.X.X..X.X..
 .XX..XXX..X....X..XXX.X.XX.XX...
 .....X.X..X.....X.X.X.X.X..X.X..
 ........................XX.XX...
end
 
 
  _frameCounter=0
__2
 ENAM0=2
 drawscreen
 if _frameCounter<50 then _frameCounter=_frameCounter+1:goto __2
 
 
 
 
 
 goto __start
 
 
 
 
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