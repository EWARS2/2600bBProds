game
.L00 ;  dim _Ch0_Sound  =  c

.L01 ;  dim _Ch0_Duration  =  d

.L02 ;  dim _C0  =  e

.L03 ;  dim _V0  =  f

.L04 ;  dim _F0  =  g

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Main_Loop
 ; __Main_Loop

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L05 ;  if joy0fire then if !_Ch0_Sound then _Ch0_Sound  =  1  :  _Ch0_Duration  =  15

 bit INPT4
	BMI .skipL05
.condpart0
	LDA _Ch0_Sound
	BNE .skip0then
.condpart1
	LDA #1
	STA _Ch0_Sound
	LDA #15
	STA _Ch0_Duration
.skip0then
.skipL05
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L06 ;  if !_Ch0_Sound then goto __Skip_Ch_0

	LDA _Ch0_Sound
	BNE .skipL06
.condpart2
 jmp .__Skip_Ch_0

.skipL06
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L07 ;  _Ch0_Duration  =  _Ch0_Duration  -  1

	DEC _Ch0_Duration
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L08 ;  if !_Ch0_Duration then goto __Clear_Ch_0

	LDA _Ch0_Duration
	BNE .skipL08
.condpart3
 jmp .__Clear_Ch_0

.skipL08
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L09 ;  if _Ch0_Sound  <>  1 then goto __Skip_Ch0_Sound_001

	LDA _Ch0_Sound
	CMP #1
     BEQ .skipL09
.condpart4
 jmp .__Skip_Ch0_Sound_001

.skipL09
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L010 ;  AUDC0  =  4  :  AUDV0  =  8  :  AUDF0  =  19

	LDA #4
	STA AUDC0
	LDA #8
	STA AUDV0
	LDA #19
	STA AUDF0
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L011 ;  goto __Skip_Ch_0

 jmp .__Skip_Ch_0

.
 ; 

.__Skip_Ch0_Sound_001
 ; __Skip_Ch0_Sound_001

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L012 ;  goto __Skip_Ch_0

 jmp .__Skip_Ch_0

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Clear_Ch_0
 ; __Clear_Ch_0

.
 ; 

.L013 ;  _Ch0_Sound  =  0  :  AUDV0  =  0

	LDA #0
	STA _Ch0_Sound
	STA AUDV0
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Skip_Ch_0
 ; __Skip_Ch_0

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L014 ;  drawscreen

 jsr drawscreen
.
 ; 

.
 ; 

.
 ; 

.L015 ;  goto __Main_Loop
 jmp .__Main_Loop
 if ECHOFIRST
       echo "    ",[(scoretable - *)]d , "bytes of ROM space left")
 endif 
ECHOFIRST = 1
 
 
 
