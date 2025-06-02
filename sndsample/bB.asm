game
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

.
 ; 

.
 ; 

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

.L05 ;  const noscore  =  1

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

.
 ; 

.L06 ;  if _Ch0_Sound then goto __Skip_Joy0

	LDA _Ch0_Sound
	BEQ .skipL06
.condpart0
 jmp .__Skip_Joy0

.skipL06
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

.L07 ;  if joy0fire then _Ch0_Sound  =  1  :  _Ch0_Duration  =  15  :  COLUBK  =  $4A  :  goto __Skip_Joy0

 bit INPT4
	BMI .skipL07
.condpart1
	LDA #1
	STA _Ch0_Sound
	LDA #15
	STA _Ch0_Duration
	LDA #$4A
	STA COLUBK
 jmp .__Skip_Joy0

.skipL07
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

.L08 ;  if joy0up then _Ch0_Sound  =  2  :  _Ch0_Duration  =  30  :  _V0  =  12  :  COLUBK  =  $9E  :  goto __Skip_Joy0

 lda #$10
 bit SWCHA
	BNE .skipL08
.condpart2
	LDA #2
	STA _Ch0_Sound
	LDA #30
	STA _Ch0_Duration
	LDA #12
	STA _V0
	LDA #$9E
	STA COLUBK
 jmp .__Skip_Joy0

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

.L09 ;  if joy0down then _Ch0_Sound  =  3  :  _Ch0_Duration  =  32  :  _F0  =  31  :  COLUBK  =  $DE  :  goto __Skip_Joy0

 lda #$20
 bit SWCHA
	BNE .skipL09
.condpart3
	LDA #3
	STA _Ch0_Sound
	LDA #32
	STA _Ch0_Duration
	LDA #31
	STA _F0
	LDA #$DE
	STA COLUBK
 jmp .__Skip_Joy0

.skipL09
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

.L010 ;  if joy0left then _Ch0_Sound  =  4  :  _Ch0_Duration  =  32  :  _V0  =  12  :  _F0  =  31  :  COLUBK  =  $6E  :  goto __Skip_Joy0

 bit SWCHA
	BVS .skipL010
.condpart4
	LDA #4
	STA _Ch0_Sound
	LDA #32
	STA _Ch0_Duration
	LDA #12
	STA _V0
	LDA #31
	STA _F0
	LDA #$6E
	STA COLUBK
 jmp .__Skip_Joy0

.skipL010
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

.L011 ;  if joy0right then _Ch0_Sound  =  5  :  _Ch0_Duration  =  32  :  _C0  =  4  :  _V0  =  12  :  _F0  =  31  :  COLUBK  =  $1E

 bit SWCHA
	BMI .skipL011
.condpart5
	LDA #5
	STA _Ch0_Sound
	LDA #32
	STA _Ch0_Duration
	LDA #4
	STA _C0
	LDA #12
	STA _V0
	LDA #31
	STA _F0
	LDA #$1E
	STA COLUBK
.skipL011
.
 ; 

.__Skip_Joy0
 ; __Skip_Joy0

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

.L012 ;  if !_Ch0_Sound then goto __Skip_Ch_0

	LDA _Ch0_Sound
	BNE .skipL012
.condpart6
 jmp .__Skip_Ch_0

.skipL012
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L013 ;  _Ch0_Duration  =  _Ch0_Duration  -  1

	DEC _Ch0_Duration
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L014 ;  if !_Ch0_Duration then goto __Clear_Ch_0

	LDA _Ch0_Duration
	BNE .skipL014
.condpart7
 jmp .__Clear_Ch_0

.skipL014
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

.L015 ;  if _Ch0_Sound  <>  1 then goto __Skip_Ch0_Sound_001

	LDA _Ch0_Sound
	CMP #1
     BEQ .skipL015
.condpart8
 jmp .__Skip_Ch0_Sound_001

.skipL015
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L016 ;  AUDC0  =  4  :  AUDV0  =  8  :  AUDF0  =  19

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

.L017 ;  goto __Skip_Ch_0

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

.L018 ;  if _Ch0_Sound  <>  2 then goto __Skip_Ch0_Sound_002

	LDA _Ch0_Sound
	CMP #2
     BEQ .skipL018
.condpart9
 jmp .__Skip_Ch0_Sound_002

.skipL018
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L019 ;  AUDC0  =  4  :  AUDV0  =  _V0  :  AUDF0  =  19

	LDA #4
	STA AUDC0
	LDA _V0
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

.L020 ;  temp5  =  _Ch0_Duration  &  %00000001

	LDA _Ch0_Duration
	AND #%00000001
	STA temp5
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L021 ;  if temp5  &&  _V0 then _V0  =  _V0  -  1

	LDA temp5
	BEQ .skipL021
.condpart10
	LDA _V0
	BEQ .skip10then
.condpart11
	DEC _V0
.skip10then
.skipL021
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L022 ;  goto __Skip_Ch_0

 jmp .__Skip_Ch_0

.
 ; 

.__Skip_Ch0_Sound_002
 ; __Skip_Ch0_Sound_002

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

.L023 ;  if _Ch0_Sound  <>  3 then goto __Skip_Ch0_Sound_003

	LDA _Ch0_Sound
	CMP #3
     BEQ .skipL023
.condpart12
 jmp .__Skip_Ch0_Sound_003

.skipL023
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L024 ;  AUDC0  =  4  :  AUDV0  =  8  :  AUDF0  =  _F0

	LDA #4
	STA AUDC0
	LDA #8
	STA AUDV0
	LDA _F0
	STA AUDF0
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L025 ;  _F0  =  _F0  -  1

	DEC _F0
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L026 ;  goto __Skip_Ch_0

 jmp .__Skip_Ch_0

.
 ; 

.__Skip_Ch0_Sound_003
 ; __Skip_Ch0_Sound_003

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

.L027 ;  if _Ch0_Sound  <>  4 then goto __Skip_Ch0_Sound_004

	LDA _Ch0_Sound
	CMP #4
     BEQ .skipL027
.condpart13
 jmp .__Skip_Ch0_Sound_004

.skipL027
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L028 ;  AUDC0  =  4  :  AUDV0  =  _V0  :  AUDF0  =  _F0

	LDA #4
	STA AUDC0
	LDA _V0
	STA AUDV0
	LDA _F0
	STA AUDF0
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L029 ;  temp5  =  _Ch0_Duration  &  %00000001

	LDA _Ch0_Duration
	AND #%00000001
	STA temp5
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L030 ;  if temp5  &&  _V0 then _V0  =  _V0  -  1

	LDA temp5
	BEQ .skipL030
.condpart14
	LDA _V0
	BEQ .skip14then
.condpart15
	DEC _V0
.skip14then
.skipL030
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L031 ;  if _F0 then _F0  =  _F0  -  1

	LDA _F0
	BEQ .skipL031
.condpart16
	DEC _F0
.skipL031
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L032 ;  goto __Skip_Ch_0

 jmp .__Skip_Ch_0

.
 ; 

.__Skip_Ch0_Sound_004
 ; __Skip_Ch0_Sound_004

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

.L033 ;  if _Ch0_Sound  <>  5 then goto __Skip_Ch0_Sound_005

	LDA _Ch0_Sound
	CMP #5
     BEQ .skipL033
.condpart17
 jmp .__Skip_Ch0_Sound_005

.skipL033
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L034 ;  AUDC0  =  _C0  :  AUDV0  =  _V0  :  AUDF0  =  _F0

	LDA _C0
	STA AUDC0
	LDA _V0
	STA AUDV0
	LDA _F0
	STA AUDF0
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L035 ;  _C0  =  _C0  ^  8

	LDA _C0
	EOR #8
	STA _C0
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L036 ;  temp5  =  _Ch0_Duration  &  %00000001

	LDA _Ch0_Duration
	AND #%00000001
	STA temp5
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L037 ;  if temp5  &&  _V0 then _V0  =  _V0  -  1

	LDA temp5
	BEQ .skipL037
.condpart18
	LDA _V0
	BEQ .skip18then
.condpart19
	DEC _V0
.skip18then
.skipL037
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L038 ;  if _F0 then _F0  =  _F0  -  1

	LDA _F0
	BEQ .skipL038
.condpart20
	DEC _F0
.skipL038
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L039 ;  goto __Skip_Ch_0

 jmp .__Skip_Ch_0

.
 ; 

.__Skip_Ch0_Sound_005
 ; __Skip_Ch0_Sound_005

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

.L040 ;  goto __Skip_Ch_0

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

.L041 ;  _Ch0_Sound  =  0  :  AUDV0  =  0

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

.L042 ;  drawscreen

 jsr drawscreen
.
 ; 

.
 ; 

.
 ; 

.L043 ;  goto __Main_Loop
 jmp .__Main_Loop
 if ECHOFIRST
       echo "    ",[(scoretable - *)]d , "bytes of ROM space left")
 endif 
ECHOFIRST = 1
 
 
 
