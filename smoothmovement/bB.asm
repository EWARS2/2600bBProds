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

.L00 ;  dim _P0x  =  player0x.a

.L01 ;  dim _P0y  =  player0y.b

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L02 ;  dim _P0xSpeed1  =  c.d

.L03 ;  dim _P0xSpeed2  =  d

.L04 ;  dim _P0ySpeed1  =  e.f

.L05 ;  dim _P0ySpeed2  =  f

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L06 ;  dim _Bit0_Reset_Restrainer  =  g

.L07 ;  dim _Bit2_SlideU  =  g

.L08 ;  dim _Bit3_SlideD  =  g

.L09 ;  dim _Bit4_SlideL  =  g

.L010 ;  dim _Bit5_SlideR  =  g

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

;._d_Acceleration.0.060.
.L011 ;  def _d_Acceleration = 0.060

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

.L012 ;  const noscore  =  1

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

.L013 ;  const _c_Edge_Top  =  9

.L014 ;  const _c_Edge_Bottom  =  88

.L015 ;  const _c_Edge_Left  =  1

.L016 ;  const _c_Edge_Right  =  153

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

.L017 ;  const _c_Max_Speed  =  2

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

.__Start_Restart
 ; __Start_Restart

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

.L018 ;  AUDV0  =  0  :  AUDV1  =  0

	LDA #0
	STA AUDV0
	STA AUDV1
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

.L019 ;  a  =  0  :  b  =  0  :  c  =  0  :  d  =  0  :  e  =  0  :  f  =  0  :  g  =  0  :  h  =  0  :  i  =  0

	LDA #0
	STA a
	STA b
	STA c
	STA d
	STA e
	STA f
	STA g
	STA h
	STA i
.L020 ;  j  =  0  :  k  =  0  :  l  =  0  :  m  =  0  :  n  =  0  :  o  =  0  :  p  =  0  :  q  =  0  :  r  =  0

	LDA #0
	STA j
	STA k
	STA l
	STA m
	STA n
	STA o
	STA p
	STA q
	STA r
.L021 ;  s  =  0  :  t  =  0  :  u  =  0  :  v  =  0  :  w  =  0  :  x  =  0  :  y  =  0  :  z  =  0

	LDA #0
	STA s
	STA t
	STA u
	STA v
	STA w
	STA x
	STA y
	STA z
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

.L022 ;  player0x  =  77  :  player0y  =  53

	LDA #77
	STA player0x
	LDA #53
	STA player0y
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

.L023 ;  COLUBK  =  0

	LDA #0
	STA COLUBK
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

.L024 ;  _Bit0_Reset_Restrainer{0}  =  1

	LDA _Bit0_Reset_Restrainer
	ORA #1
	STA _Bit0_Reset_Restrainer
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

.L025 ;  player0:

	LDX #<playerL025_0
	STX player0pointerlo
	LDA #>playerL025_0
	STA player0pointerhi
	LDA #7
	STA player0height
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

.L026 ;  COLUP0  =  $9C

	LDA #$9C
	STA COLUP0
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

.L027 ;  if _Bit3_SlideD{3} then __Skip_Up_Slide

	LDA _Bit3_SlideD
	AND #8
	bne .__Skip_Up_Slide
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L028 ;  if !joy0up then __Up_Slide

 lda #$10
 bit SWCHA
	bne .__Up_Slide
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L029 ;  if _P0ySpeed1  <  _c_Max_Speed then _P0ySpeed1  =  _P0ySpeed1  +  _d_Acceleration

	LDA _P0ySpeed1
	CMP #_c_Max_Speed
     BCS .skipL029
.condpart0
	LDA f
	CLC 
	ADC #15
	STA f
	LDA _P0ySpeed1
	ADC #0
	STA _P0ySpeed1
.skipL029
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

.L030 ;  _Bit2_SlideU{2}  =  1

	LDA _Bit2_SlideU
	ORA #4
	STA _Bit2_SlideU
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L031 ;  goto __Move_Up

 jmp .__Move_Up

.
 ; 

.__Up_Slide
 ; __Up_Slide

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

.L032 ;  if !_Bit2_SlideU{2} then __Skip_Up_Slide

	LDA _Bit2_SlideU
	AND #4
	beq .__Skip_Up_Slide
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L033 ;  _P0ySpeed1  =  _P0ySpeed1  -  _d_Acceleration

	LDA f
	SEC 
	SBC #15
	STA f
	LDA _P0ySpeed1
	SBC #0
	STA _P0ySpeed1
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

.L034 ;  if _P0ySpeed1  =  0  &&  _P0ySpeed2  =  0 then _Bit2_SlideU{2}  =  0

	LDA _P0ySpeed1
	CMP #0
     BNE .skipL034
.condpart1
	LDA _P0ySpeed2
	CMP #0
     BNE .skip1then
.condpart2
	LDA _Bit2_SlideU
	AND #251
	STA _Bit2_SlideU
.skip1then
.skipL034
.
 ; 

.__Move_Up
 ; __Move_Up

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

.L035 ;  _P0y  =  _P0y  -  _P0ySpeed1

	LDA b
	SEC 
	SBC f
	STA b
	LDA _P0y
	SBC _P0ySpeed1
	STA _P0y
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L036 ;  if player0y  <=  _c_Edge_Top then player0y  =  _c_Edge_Top  :  _P0ySpeed1  =  0  :  _P0ySpeed2  =  0  :  _Bit2_SlideU{2}  =  0

	LDA #_c_Edge_Top
	CMP player0y
     BCC .skipL036
.condpart3
	LDA #_c_Edge_Top
	STA player0y
	LDA #0
	STA f
	LDA #0
	STA _P0ySpeed1
	STA _P0ySpeed2
	LDA _Bit2_SlideU
	AND #251
	STA _Bit2_SlideU
.skipL036
.
 ; 

.__Skip_Up_Slide
 ; __Skip_Up_Slide

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

.L037 ;  if _Bit2_SlideU{2} then __Skip_Down_Slide

	LDA _Bit2_SlideU
	AND #4
	bne .__Skip_Down_Slide
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L038 ;  if !joy0down then __Down_Slide

 lda #$20
 bit SWCHA
	bne .__Down_Slide
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L039 ;  if _P0ySpeed1  <  _c_Max_Speed then _P0ySpeed1  =  _P0ySpeed1  +  _d_Acceleration

	LDA _P0ySpeed1
	CMP #_c_Max_Speed
     BCS .skipL039
.condpart4
	LDA f
	CLC 
	ADC #15
	STA f
	LDA _P0ySpeed1
	ADC #0
	STA _P0ySpeed1
.skipL039
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

.L040 ;  _Bit3_SlideD{3}  =  1

	LDA _Bit3_SlideD
	ORA #8
	STA _Bit3_SlideD
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L041 ;  goto __Move_Down

 jmp .__Move_Down

.
 ; 

.__Down_Slide
 ; __Down_Slide

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

.L042 ;  if !_Bit3_SlideD{3} then __Skip_Down_Slide

	LDA _Bit3_SlideD
	AND #8
	beq .__Skip_Down_Slide
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L043 ;  _P0ySpeed1  =  _P0ySpeed1  -  _d_Acceleration

	LDA f
	SEC 
	SBC #15
	STA f
	LDA _P0ySpeed1
	SBC #0
	STA _P0ySpeed1
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

.L044 ;  if _P0ySpeed1  =  0  &&  _P0ySpeed2  =  0 then _Bit3_SlideD{3}  =  0

	LDA _P0ySpeed1
	CMP #0
     BNE .skipL044
.condpart5
	LDA _P0ySpeed2
	CMP #0
     BNE .skip5then
.condpart6
	LDA _Bit3_SlideD
	AND #247
	STA _Bit3_SlideD
.skip5then
.skipL044
.
 ; 

.__Move_Down
 ; __Move_Down

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

.L045 ;  _P0y  =  _P0y  +  _P0ySpeed1

	LDA b
	CLC 
	ADC f
	STA b
	LDA _P0y
	ADC _P0ySpeed1
	STA _P0y
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L046 ;  if player0y  >=  _c_Edge_Bottom then player0y  =  _c_Edge_Bottom  :  _P0ySpeed1  =  0  :  _P0ySpeed2  =  0  :  _Bit3_SlideD{3}  =  0

	LDA player0y
	CMP #_c_Edge_Bottom
     BCC .skipL046
.condpart7
	LDA #_c_Edge_Bottom
	STA player0y
	LDA #0
	STA f
	LDA #0
	STA _P0ySpeed1
	STA _P0ySpeed2
	LDA _Bit3_SlideD
	AND #247
	STA _Bit3_SlideD
.skipL046
.
 ; 

.__Skip_Down_Slide
 ; __Skip_Down_Slide

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

.L047 ;  if _Bit5_SlideR{5} then __Skip_Left_Slide

	LDA _Bit5_SlideR
	AND #32
	bne .__Skip_Left_Slide
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L048 ;  if !joy0left then __Left_Slide

 bit SWCHA
	bvs .__Left_Slide
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L049 ;  if _P0xSpeed1  <  _c_Max_Speed then _P0xSpeed1  =  _P0xSpeed1  +  _d_Acceleration

	LDA _P0xSpeed1
	CMP #_c_Max_Speed
     BCS .skipL049
.condpart8
	LDA d
	CLC 
	ADC #15
	STA d
	LDA _P0xSpeed1
	ADC #0
	STA _P0xSpeed1
.skipL049
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

.L050 ;  _Bit4_SlideL{4}  =  1

	LDA _Bit4_SlideL
	ORA #16
	STA _Bit4_SlideL
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L051 ;  goto __Move_Left

 jmp .__Move_Left

.
 ; 

.__Left_Slide
 ; __Left_Slide

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

.L052 ;  if !_Bit4_SlideL{4} then __Skip_Left_Slide

	LDA _Bit4_SlideL
	AND #16
	beq .__Skip_Left_Slide
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L053 ;  _P0xSpeed1  =  _P0xSpeed1  -  _d_Acceleration

	LDA d
	SEC 
	SBC #15
	STA d
	LDA _P0xSpeed1
	SBC #0
	STA _P0xSpeed1
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

.L054 ;  if _P0xSpeed1  =  0  &&  _P0xSpeed2  =  0 then _Bit4_SlideL{4}  =  0

	LDA _P0xSpeed1
	CMP #0
     BNE .skipL054
.condpart9
	LDA _P0xSpeed2
	CMP #0
     BNE .skip9then
.condpart10
	LDA _Bit4_SlideL
	AND #239
	STA _Bit4_SlideL
.skip9then
.skipL054
.
 ; 

.__Move_Left
 ; __Move_Left

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

.L055 ;  _P0x  =  _P0x  -  _P0xSpeed1

	LDA a
	SEC 
	SBC d
	STA a
	LDA _P0x
	SBC _P0xSpeed1
	STA _P0x
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L056 ;  if player0x  <=  _c_Edge_Left  ||  player0x  >  200 then player0x  =  _c_Edge_Left  :  _P0xSpeed1  =  0  :  _P0xSpeed2  =  0  :  _Bit4_SlideL{4}  =  0

	LDA #_c_Edge_Left
	CMP player0x
     BCC .skipL056
.condpart11
 jmp .condpart12
.skipL056
	LDA #200
	CMP player0x
     BCS .skip3OR
.condpart12
	LDA #_c_Edge_Left
	STA player0x
	LDA #0
	STA d
	LDA #0
	STA _P0xSpeed1
	STA _P0xSpeed2
	LDA _Bit4_SlideL
	AND #239
	STA _Bit4_SlideL
.skip3OR
.
 ; 

.__Skip_Left_Slide
 ; __Skip_Left_Slide

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

.L057 ;  if _Bit4_SlideL{4} then __Skip_Right_Slide

	LDA _Bit4_SlideL
	AND #16
	bne .__Skip_Right_Slide
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L058 ;  if !joy0right then __Right_Slide

 bit SWCHA
	bmi .__Right_Slide
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L059 ;  if _P0xSpeed1  <  _c_Max_Speed then _P0xSpeed1  =  _P0xSpeed1  +  _d_Acceleration

	LDA _P0xSpeed1
	CMP #_c_Max_Speed
     BCS .skipL059
.condpart13
	LDA d
	CLC 
	ADC #15
	STA d
	LDA _P0xSpeed1
	ADC #0
	STA _P0xSpeed1
.skipL059
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

.L060 ;  _Bit5_SlideR{5}  =  1

	LDA _Bit5_SlideR
	ORA #32
	STA _Bit5_SlideR
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L061 ;  goto __Move_Right

 jmp .__Move_Right

.
 ; 

.__Right_Slide
 ; __Right_Slide

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

.L062 ;  if !_Bit5_SlideR{5} then __Skip_Right_Slide

	LDA _Bit5_SlideR
	AND #32
	beq .__Skip_Right_Slide
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L063 ;  _P0xSpeed1  =  _P0xSpeed1  -  _d_Acceleration

	LDA d
	SEC 
	SBC #15
	STA d
	LDA _P0xSpeed1
	SBC #0
	STA _P0xSpeed1
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

.L064 ;  if _P0xSpeed1  =  0  &&  _P0xSpeed2  =  0 then _Bit5_SlideR{5}  =  0

	LDA _P0xSpeed1
	CMP #0
     BNE .skipL064
.condpart14
	LDA _P0xSpeed2
	CMP #0
     BNE .skip14then
.condpart15
	LDA _Bit5_SlideR
	AND #223
	STA _Bit5_SlideR
.skip14then
.skipL064
.
 ; 

.__Move_Right
 ; __Move_Right

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

.L065 ;  _P0x  =  _P0x  +  _P0xSpeed1

	LDA a
	CLC 
	ADC d
	STA a
	LDA _P0x
	ADC _P0xSpeed1
	STA _P0x
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L066 ;  if player0x  >=  _c_Edge_Right then player0x  =  _c_Edge_Right  :  _P0xSpeed1  =  0  :  _P0xSpeed2  =  0  :  _Bit5_SlideR{5}  =  0

	LDA player0x
	CMP #_c_Edge_Right
     BCC .skipL066
.condpart16
	LDA #_c_Edge_Right
	STA player0x
	LDA #0
	STA d
	LDA #0
	STA _P0xSpeed1
	STA _P0xSpeed2
	LDA _Bit5_SlideR
	AND #223
	STA _Bit5_SlideR
.skipL066
.
 ; 

.__Skip_Right_Slide
 ; __Skip_Right_Slide

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

.L067 ;  drawscreen

 jsr drawscreen
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

.L068 ;  if !switchreset then _Bit0_Reset_Restrainer{0}  =  0  :  goto __Main_Loop

 lda #1
 bit SWCHB
	BEQ .skipL068
.condpart17
	LDA _Bit0_Reset_Restrainer
	AND #254
	STA _Bit0_Reset_Restrainer
 jmp .__Main_Loop

.skipL068
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

.L069 ;  if _Bit0_Reset_Restrainer{0} then goto __Main_Loop

	LDA _Bit0_Reset_Restrainer
	LSR
	BCC .skipL069
.condpart18
 jmp .__Main_Loop

.skipL069
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L070 ;  goto __Start_Restart
 jmp .__Start_Restart
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL025_0
	.byte    %00111100
	.byte    %01111110
	.byte    %11000011
	.byte    %10111101
	.byte    %11111111
	.byte    %11011011
	.byte    %01111110
	.byte    %00111100
 if ECHOFIRST
       echo "    ",[(scoretable - *)]d , "bytes of ROM space left")
 endif 
ECHOFIRST = 1
 
 
 
