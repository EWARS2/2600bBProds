 set kernel_options no_blank_lines

 const noscore = 1
 rem const pfrowheight=5
 
 COLUPF=$0A
 COLUBK=$00
 
 pfscroll upup
 pfscroll upup
 
 playfield:
 X.X.XX.X..X...X..X.X.X..X...X...
 X.X.X..X..X..X.X.X.X.X.X.X.X.X..
 XXX.XX.X..X..X.X.X.X.X.X.X.XX..X
 X.X.X..X..X..X.X..X.X..X.X.X.X..
 X.X.XX.XX.XX..X...X.X...X..X.X..
 ................................
 X..XX...........................
 X..X.X..........................
 X..X.X..........................
 X..X.X..........................
 XX.XX...........................
 ................................
end

__main

 if joy0up then pfscroll up
 if joy0down then pfscroll down
 if joy0left then pfscroll left
 if joy0right then pfscroll right



 drawscreen
 goto __main