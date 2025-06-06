   rem  *****************************************************
   rem  *
   rem  *  Music Starter using sdata
   rem  *
   rem  *  Based on code posted in the Ballblazer thread at AtariAge:
   rem  *  http://www.atariage.com/forums/index.php?s=&showtopic=130990&view=findpost&p=1615280
   rem  *
   rem  *  Code adapted by Duane Alan Hahn (Random Terrain)
   rem  *
   rem  *  Explanation:
   rem  *  The 256-byte limitation is removed when using sdata.
   rem  *  You can fill a whole 4k bank with music if you want.
   rem  *
   rem  *****************************************************


   set smartbranching on


   rem  *****************************************************
   rem  *  Create aliases for variables
   rem  *****************************************************
   dim duration=a
   dim rand16=z


   rem  *****************************************************
   rem  *  Variable descriptions
   rem  *****************************************************
   rem  *  duration - how long each note plays
   rem  *  x - used for sdata
   rem  *  y - used for sdata
   rem  *  rand16 - makes better random numbers


   rem  *  Volume off
   AUDV0=0
   AUDV1=0


   rem  *  Initialize duration and set up music
   duration = 1
   goto MusicSetup




   rem  *****************************************************
   rem  *
   rem  *  Main game loop starts here.
   rem  *
   rem  *****************************************************
MainLoop

   goto GetMusic
GotMusic

   drawscreen

   goto MainLoop




   rem  *****************************************************
   rem  *  Music
   rem  *****************************************************
GetMusic

   rem  *  Check for end of current note
   duration = duration - 1
   if duration>0 then GotMusic


   rem  *  Retrieve channel 0 data
   temp4 = sread(musicData)
   temp5 = sread(musicData)
   temp6 = sread(musicData)


   rem  *  Check for end of data
   if temp4=255 then duration = 1 : goto MusicSetup


   rem  *  Play channel 0
   AUDV0 = temp4
   AUDC0 = temp5
   AUDF0 = temp6


   rem  *  Retrieve channel 1 data
   temp4 = sread(musicData)
   temp5 = sread(musicData)
   temp6 = sread(musicData)


   rem  *  Play channel 1
   AUDV1 = temp4
   AUDC1 = temp5
   AUDF1 = temp6


   rem  *  Set duration
   duration = sread(musicData)
   goto GotMusic




   rem  *****************************************************
   rem  *  Music Data Block
   rem  *****************************************************
   rem  *  Format:
   rem  *  v,c,f (channel 0)
   rem  *  v,c,f (channel 1) 
   rem  *  d
   rem  *
   rem  *  Explanation:
   rem  *  v - volume (0 to 15)
   rem  *  c - control [a.k.a. tone, voice, and distortion] (0 to 15)
   rem  *  f - frequency (0 to 31)
   rem  *  d - duration

MusicSetup
   sdata musicData = x
	0, 0, 0
	255
	0, 0, 0
	181
	5, 1, 25
	2
	0, 0, 0
	5
	5, 1, 25
	7
	11, 12, 31
	1
	0, 0, 0
	6
	5, 1, 25
	2
	0, 0, 0
	5
	5, 1, 25
	7
	5, 1, 13
	1
	0, 0, 0
	5
	0, 0, 0
	1
	4, 1, 25
	2
	0, 0, 0
	4
	5, 1, 25
	7
	0, 0, 0
	6
	5, 1, 25
	2
	0, 0, 0
	5
	5, 1, 25
	7
	5, 1, 17
	1
	0, 0, 0
	6
	5, 1, 25
	3
	0, 0, 0
	4
	5, 1, 25
	7
	5, 1, 16
	6
	6, 1, 15
	5
	0, 0, 0
	1
	0, 0, 0
	1
	5, 1, 25
	1
	0, 0, 0
	6
	5, 1, 25
	7
	11, 12, 31
	1
	0, 0, 0
	5
	0, 0, 0
	1
	5, 1, 25
	2
	0, 0, 0
	5
	5, 1, 25
	7
	5, 1, 13
	1
	0, 0, 0
	6
	5, 1, 25
	2
	0, 0, 0
	4
	5, 1, 25
	7
	0, 0, 0
	5
	0, 0, 0
	1
	5, 1, 25
	3
	0, 0, 0
	4
	5, 1, 25
	7
	5, 1, 17
	33
	0, 0, 0
	1
	5, 1, 25
	1
	0, 0, 0
	1
	0, 0, 0
	5
	5, 1, 25
	7
	11, 12, 31
end
   goto GotMusic
