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

.L00 ;  dim _D_Counter  =  m

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01 ;  dim _D_Mem  =  n

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

.L02 ;  dim _sc1  =  score

.L03 ;  dim _sc2  =  score + 1

.L04 ;  dim _sc3  =  score + 2

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L05 ;  dim _Bit6_Joy0_Restrainer  =  y

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

.L06 ;  scorecolor  =  $9C

	LDA #$9C
	STA scorecolor
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

.
 ; 

.L07 ;  if !joy0left  &&  !joy0right then _Bit6_Joy0_Restrainer{6}  =  0  :  goto __Skip_Joy0

 bit SWCHA
	BVC .skipL07
.condpart0
 bit SWCHA
	BPL .skip0then
.condpart1
	LDA _Bit6_Joy0_Restrainer
	AND #191
	STA _Bit6_Joy0_Restrainer
 jmp .__Skip_Joy0

.skip0then
.skipL07
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L08 ;  if _Bit6_Joy0_Restrainer{6} then goto __Skip_Joy0

	BIT _Bit6_Joy0_Restrainer
	BVC .skipL08
.condpart2
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

.L09 ;  _Bit6_Joy0_Restrainer{6}  =  1

	LDA _Bit6_Joy0_Restrainer
	ORA #64
	STA _Bit6_Joy0_Restrainer
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L010 ;  if joy0left then _D_Mem  =  _Data_Baked_Potato[_D_Counter]

 bit SWCHA
	BVS .skipL010
.condpart3
	LDX _D_Counter
	LDA _Data_Baked_Potato,x
	STA _D_Mem
.skipL010
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L011 ;  if joy0right then _D_Mem  =  _Data_Toenail_Fungus[_D_Counter]

 bit SWCHA
	BMI .skipL011
.condpart4
	LDX _D_Counter
	LDA _Data_Toenail_Fungus,x
	STA _D_Mem
.skipL011
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L012 ;  _D_Counter  =  _D_Counter  +  1  :  if _D_Counter  >  6 then _D_Counter  =  0

	INC _D_Counter
	LDA #6
	CMP _D_Counter
     BCS .skipL012
.condpart5
	LDA #0
	STA _D_Counter
.skipL012
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

.L013 ;  temp4  =  _D_Mem

	LDA _D_Mem
	STA temp4
.L014 ;  _sc2  =  _sc2  &  240  :  _sc3  =  0

	LDA _sc2
	AND #240
	STA _sc2
	LDA #0
	STA _sc3
.L015 ;  if temp4  >=  100 then _sc2  =  _sc2  +  1  :  temp4  =  temp4  -  100

	LDA temp4
	CMP #100
     BCC .skipL015
.condpart6
	INC _sc2
	LDA temp4
	SEC
	SBC #100
	STA temp4
.skipL015
.L016 ;  if temp4  >=  100 then _sc2  =  _sc2  +  1  :  temp4  =  temp4  -  100

	LDA temp4
	CMP #100
     BCC .skipL016
.condpart7
	INC _sc2
	LDA temp4
	SEC
	SBC #100
	STA temp4
.skipL016
.L017 ;  if temp4  >=  50 then _sc3  =  _sc3  +  80  :  temp4  =  temp4  -  50

	LDA temp4
	CMP #50
     BCC .skipL017
.condpart8
	LDA _sc3
	CLC
	ADC #80
	STA _sc3
	LDA temp4
	SEC
	SBC #50
	STA temp4
.skipL017
.L018 ;  if temp4  >=  30 then _sc3  =  _sc3  +  48  :  temp4  =  temp4  -  30

	LDA temp4
	CMP #30
     BCC .skipL018
.condpart9
	LDA _sc3
	CLC
	ADC #48
	STA _sc3
	LDA temp4
	SEC
	SBC #30
	STA temp4
.skipL018
.L019 ;  if temp4  >=  20 then _sc3  =  _sc3  +  32  :  temp4  =  temp4  -  20

	LDA temp4
	CMP #20
     BCC .skipL019
.condpart10
	LDA _sc3
	CLC
	ADC #32
	STA _sc3
	LDA temp4
	SEC
	SBC #20
	STA temp4
.skipL019
.L020 ;  if temp4  >=  10 then _sc3  =  _sc3  +  16  :  temp4  =  temp4  -  10

	LDA temp4
	CMP #10
     BCC .skipL020
.condpart11
	LDA _sc3
	CLC
	ADC #16
	STA _sc3
	LDA temp4
	SEC
	SBC #10
	STA temp4
.skipL020
.L021 ;  _sc3  =  _sc3  |  temp4

	LDA _sc3
	ORA temp4
	STA _sc3
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

.L022 ;  drawscreen

 jsr drawscreen
.
 ; 

.
 ; 

.
 ; 

.L023 ;  goto __Main_Loop

 jmp .__Main_Loop

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

.L024 ;  data _Data_Baked_Potato

	JMP .skipL024
_Data_Baked_Potato
	.byte    11, 22, 33, 44, 55, 66, 77

.skipL024
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

.L025 ;  data _Data_Toenail_Fungus

	JMP .skipL025
_Data_Toenail_Fungus
	.byte    1, 2, 3, 4, 5, 6, 7

.skipL025
 if ECHOFIRST
       echo "    ",[(scoretable - *)]d , "bytes of ROM space left")
 endif 
ECHOFIRST = 1
 
 
 
