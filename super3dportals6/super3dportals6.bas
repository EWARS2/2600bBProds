 include div_mul.asm

 rem ********************************
 rem * ZACHARY HINCHLIFFE FRESENTS: *
 rem *      SUPER 3D PORTALS 6      *
 rem ********************************

title
 COLUPF = 222
 playfield:
 .XX.X.X.XXX.XXX.XXX....XX..XX..
 X...X.X.X.X.X...X.X......X.X.X.
 XXX.X.X.XXX.XX..XXX....XXX.X.X.
 ..X.X.X.X...X...XX.......X.X.X.
 XX..XXX.X...XXX.X.X....XX..XX..
 ...............................
 XXX.XXX.XXX.XXX..X..X...XX...XX
 X.X.X.X.X.X..X..X.X.X..X....X..
 XXX.X.X.XXX..X..XXX.X..XXX..XXX
 X...X.X.XX...X..X.X.X....X..X.X
 X...XXX.X.X..X..X.X.XX.XX...XXX
end
 drawscreen
 if joy0fire then goto begin

 r = r + 1

 if r>0 && r<8 then AUDV0 = 10 : AUDC0 = 12 : AUDF0 = 27
 if r>7 && r<16 then AUDV0 = 10 : AUDC0 = 12 : AUDF0 = 15
 if r>15 && r<24 then AUDV0 = 10 : AUDC0 = 12 : AUDF0 = 16
 if r>23 && r<32 then AUDV0 = 10 : AUDC0 = 12 : AUDF0 = 18
 if r>31 && r<40 then AUDV0 = 10 : AUDC0 = 12 : AUDF0 = 18
 if r>39 && r<48 then AUDV0 = 10 : AUDC0 = 12 : AUDF0 = 16 : AUDV1 = 10 : AUDC1 = 1 : AUDF1 = 16
 if r>47 && r<120 then AUDV0 = 0
 if r>119 && r<128 then AUDV0 = 10 : AUDC0 = 12 : AUDF0 = 27
 if r>127 && r<136 then AUDV0 = 10 : AUDC0 = 12 : AUDF0 = 15
 if r>135 && r<144 then AUDV0 = 10 : AUDC0 = 12 : AUDF0 = 16
 if r>143 && r<152 then AUDV0 = 10 : AUDC0 = 12 : AUDF0 = 18
 if r>151 && r<160 then AUDV0 = 10 : AUDC0 = 12 : AUDF0 = 18
 if r>159 && r<168 then AUDV0 = 10 : AUDC0 = 12 : AUDF0 = 16
 if r>167 && r<192 then AUDV0 = 0
 if r>191 && r<208 then AUDV0 = 10 : AUDC0 = 12 : AUDF0 = 20
 if r>207 && r<216 then AUDV0 = 10 : AUDC0 = 12 : AUDF0 = 18
 if r>215 && r<224 then AUDV0 = 10 : AUDC0 = 12 : AUDF0 = 27 : AUDV1 = 10 : AUDC1 = 1 : AUDF1 = 22
 if r>223 && r<248 then AUDV0 = 0
 if r>247 then r = 1

 goto title

begin
 AUDV0 = 0 : AUDV1 = 0
 score = 1
 player0x = 128
 player0y = 68

 missile0height = 4
 missile1height = 4

 f = missile0x
 g = missile0y
 h = missile1x
 i = missile1y
 goto start

 
start
 if switchreset then reboot

 const pfscore=0

 COLUP0 = 56
 COLUP1 = 138
 COLUPF = 222
 scorecolor = 222
 pfscorecolor = 222
 NUSIZ0=$20
 NUSIZ1=$20
 
 if a > 9 then a=0

 on a goto level1 level2 level3 level4 level5 level6 level7 level8 level9 level10
 rem level11 level12 level13 level14 level15 level16

level1 playfield:
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 X..............................X
 XXXXXXXXXXXXXXXXXXX............X
 XXXXXXXXXXXXXXXXXX.............X
 X......................XXXXXXXXX
 X........XXXXXXXXXXXXXXX.......X
 X........XXXXXXXXXXXXXX........X
 X..............................X
 XXXXXXXXXXXXXXXXXXXXXXX........X
 XXXXXXXXXXXXXXXXXXXXXXX........X
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end
 ballx = 24
 bally = 13
 goto main

level2 playfield:
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 X..............................X
 XXXXXXXXX......................X
 XXXXXXXXX......................X
 XXXXXXXXX......................X
 XXXXXXXXX......................X
 XXXXXXXXX....................XXX
 XXXXXXXXX....................XXX
 XXXXXXXXX....................XXX
 XXXXXXXXX....................XXX
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end
 ballx = 135
 bally = 42
 goto main

level3 playfield:
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 X..........................XX..X
 XXXXXX.....................XX..X
 XXXXXX.....................XX..X
 X.....XXXX.................XX..X
 X.....XXXX.................XX..X
 X..........................XX..X
 X..........................XX..X
 XXXXXXXXXXXXXXXX...........XX..X
 XXXXXXXXXXXXXXXXXXXXXXX........X
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end
 ballx = 24
 bally = 13
 goto main

level4 playfield:
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 X........XX.............XXXXXXXX
 XXXX.....XX..XXXXXXXXX..XXXXXXXX
 XXXX.....XX..XX.........XXXXXXXX
 XXXX.....XX..XX..XXXXXXXXXX....X
 XXXX.........XX......X.........X
 XXXX.........XX..XX..X..XXX..XXX
 XXXXXXXXXXXXXXX..XX..X..XXX..XXX
 XXXXXXXXXXXXXXX..XX..X..XXXXXXXX
 XXXXXXXXXXXXXXX..XX.....XXXXXXXX
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end
 ballx = 135
 bally = 42
 goto main

level5 playfield:
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 X..............................X
 XXXXXXXXXXXXXXXXXXXXXXX........X
 XXXXXXXXXXXXXXXXXXXXXXX........X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 X..............................X
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end
 ballx = 24
 bally = 13
 goto main

level6 playfield:
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 X........................X.....X
 X........................X.....X
 X........................X.....X
 XX.......................X.....X
 XXX.........XXXXXXXXX....X.....X
 XXXX........XXXXXXXXX....X...XXX
 XXXXX.......XXXXXXXXX........XXX
 XXXXXX......XXXXXXXXX........XXX
 XXXXXXX.....XXXXXXXXX........XXX
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end
 ballx = 135
 bally = 42
 goto main

level7 playfield:
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 X..XX..XX....XX......XX....XX..X
 X..XX......XX....XX..XX....XX..X
 X..XX..XX....XX..XX..XX....XX..X
 X..XX..XX..XX....XX........XX..X
 X..XX..XX....XX..XX..XX....XX..X
 X..XX..XX..XX....XX..XX....XX..X
 X..XX..XX....XX..XX..XX....XX..X
 X..XX..XX..XX....XX..XX....XX..X
 X......XX......XXXX..XX........X
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end
 ballx = 24
 bally = 13
 goto main

level8 playfield:
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 X........X..XXXX..XXXX..X.XXX.XX
 XXXXXX..XXX..XX....XX..XX.....XX
 XXXXX..XXXXX....XX....XXX.XXX.XX
 XXXX..XXXXXXX..XXXX..XXXX.XXX.XX
 XXX..XXXXXXXXXXXXXXXXXXXX.XXX.XX
 XX..XXXXXX....................XX
 X..........XXXXXXXXXXXXXXXXXXXXX
 XXXXXXXXXX....................XX
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end
 ballx = 135
 bally = 42
 goto main

level9 playfield:
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 X...X.......X..............XX..X
 X....X...X...X...X.........XX..X
 XX....X...X...X...X........XX..X
 XXX....X...X...X...X.......XX..X
 XXXX....X...X...X...X......XX..X
 XXXXX....X...X...X...X.....XX..X
 XXXXXX....X...X...X...X....XX..X
 XXXXXXX....X...X...X...X...XX..X
 XXXXXXXX........X.......X......X
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end
 ballx = 24
 bally = 13
 goto main

level10 playfield:
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 X........XXXXXXXXXXXXXXXXXXXXXXX
 XX......XXXX..XXXXXXXXXXXXXXXXXX
 XXX....XXXXX...................X
 XXXX..XXXXXX..XXXXXXXXXXXXXXX..X
 XXXX..XXXXXX..............XXX..X
 XXX....XXXXXXXXXXXXXXXXX..XXX..X
 XX......XX........XX......XXX..X
 X............XX.......XX..XXXXXX
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end
 ballx = 135
 bally = 42
 goto main

main

 rem playfield is 32 by 11 (128 by 88)
 rem screen is 160 by 88

 b = (player0x - 13) / 4
 k = (player0x - 9) / 4
 n = (player0x - 17) / 4
 l = (player0y) / 8
 m = (player0y - 4) / 8
 p = (player0y - 7) / 8

 if joy0left then player0x = player0x - 1
 if joy0right then player0x = player0x + 1

 rem fall if not touching ground
 if !pfread(b,l) then player0y = player0y + 1
 
 rem push left if in right wall
 if pfread(k,m) then player0x = player0x - 1
 
 rem push right if in left wall
 if pfread(n,m) then player0x = player0x + 1

 rem push down if in ceiling
 if pfread(b,p) then player0y = player0y + 1
 
 if collision(playfield,missile0) then d = c
 if missile0x=f && missile0y=g then d = c
 if missile0x<1 && missile0y<1 then d = c
 if collision(playfield,missile1) then j = c
 if missile1x=h && missile1x=i then j = c
 if missile1x<1 && missile1x<1 then j = c : s = 1 else s = 0
 if !collision(playfield,missile0) && d=0 then missile0x = missile0x - 1 : missile0y = missile0y + 1
 if !collision(playfield,missile0) && d=1 then missile0y = missile0y + 1
 if !collision(playfield,missile0) && d=2 then missile0x = missile0x + 1 : missile0y = missile0y + 1
 if !collision(playfield,missile0) && d=3 then missile0x = missile0x + 1
 if !collision(playfield,missile0) && d=4 then missile0x = missile0x + 1 : missile0y = missile0y - 1
 if !collision(playfield,missile0) && d=5 then missile0y = missile0y - 1
 if !collision(playfield,missile0) && d=6 then missile0x = missile0x - 1 : missile0y = missile0y - 1
 if !collision(playfield,missile0) && d=7 then missile0x = missile0x - 1
 if !collision(playfield,missile1) && j=0 && s=0 then missile1x = missile1x - 1 : missile1y = missile1y + 1
 if !collision(playfield,missile1) && j=1 && s=0 then missile1y = missile1y + 1
 if !collision(playfield,missile1) && j=2 && s=0 then missile1x = missile1x + 1 : missile1y = missile1y + 1
 if !collision(playfield,missile1) && j=3 && s=0 then missile1x = missile1x + 1
 if !collision(playfield,missile1) && j=4 && s=0 then missile1x = missile1x + 1 : missile1y = missile1y - 1
 if !collision(playfield,missile1) && j=5 && s=0 then missile1y = missile1y - 1
 if !collision(playfield,missile1) && j=6 && s=0 then missile1x = missile1x - 1 : missile1y = missile1y - 1
 if !collision(playfield,missile1) && j=7 && s=0 then missile1x = missile1x - 1
 

 if joy1right && c>0 && e=0 then c = c - 1 : e = 1
 if joy1left && c<7 && e=0 then c = c + 1  : e = 1
 if joy1right && c=0 && e=0 then c = 7 : e = 1
 if joy1left && c=7 && e=0 then c = 0 : e = 1
 if !joy1right && !joy1left then e = 0
 if joy0fire && r=0 then missile0x = player0x+2 : missile0y = player0y-2 : AUDV0 = 10 : AUDC0 = 3 : AUDF0 = 6 : q = 1
 if joy1fire && r=0 then missile1x = player0x+2 : missile1y = player0y-2 : AUDV0 = 10 : AUDC0 = 3 : AUDF0 = 6 : q = 1
 if !joy0fire && r<>0 then r=0
 
 if collision(player0,missile0) && collision(playfield,missile0) && collision(playfield,missile1) && z=0 then z=1 : player0x = missile1x : player0y = missile1y : AUDV0 = 10 : AUDC0 = 3 : AUDF0 = 11 : q = 1
 if collision(player0,missile1) && collision(playfield,missile0) && collision(playfield,missile1) && z=0 then z=1 : player0x = missile0x : player0y = missile0y : AUDV0 = 10 : AUDC0 = 3 : AUDF0 = 12 : q = 1
 if !collision(player0,missile0) && !collision(player0,missile1) then z=0

 if joy0up && o=0 && pfread(b,l) then o = 1 : player0y = player0y - 1
 
 if o>0 && o<11 then player0y = player0y - 2 : o = o + 1
 if o>10 then o = 0
 
 if q>0 && q<6 then q = q + 1
 if q>5 then AUDV0 = 0 : q = 0

 if collision(player0,ball) then score = score + 1 : a = a + 1 : ballx = ballx + 160 : missile0x = 0 : missile0y = 0 : missile1x = 0 : missile1y = 0 : j = 0 : d = 0 : c = 0

 on c goto dirdl dird dirdr dirr dirur diru dirul dirl

dirdl player0:
 %11110000
 %11100000
 %11010000
 %10001000
 %00000100
 %00000010
 %00000001
end
 goto donesetframe

dird player0:
 %00011000
 %00111100
 %01111110
 %11111111
 %00011000
 %00011000
 %00011000
end
 goto donesetframe

dirdr player0:
 %00001111
 %00000111
 %00001011
 %00010001
 %00100000
 %01000000
 %10000000
end
 goto donesetframe

dirr player0:
 %00001000
 %00001100
 %00001110
 %11111111
 %00001110
 %00001100
 %00001000
end
 goto donesetframe

dirur player0:
 %10000000
 %01000000
 %00100000
 %00010001
 %00001011
 %00000111
 %00001111
end
 goto donesetframe

diru player0:
 %00011000
 %00011000
 %00011000
 %11111111
 %01111110
 %00111100
 %00011000
end
 goto donesetframe

dirul player0:
 %00000001
 %00000010
 %00000100
 %10001000
 %11010000
 %11100000
 %11110000
end
 goto donesetframe

dirl player0:
 %00010000
 %00110000
 %01110000
 %11111111
 %01110000
 %00110000
 %00010000
end
 goto donesetframe

donesetframe drawscreen
 goto start