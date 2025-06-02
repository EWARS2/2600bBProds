; Provided under the CC0 license. See the included LICENSE.txt for details.

 processor 6502
 include "vcs.h"
 include "macro.h"
 include "2600basic.h"
 include "2600basic_variable_redefs.h"
 ifconst bankswitch
  if bankswitch == 8
     ORG $1000
     RORG $D000
  endif
  if bankswitch == 16
     ORG $1000
     RORG $9000
  endif
  if bankswitch == 32
     ORG $1000
     RORG $1000
  endif
  if bankswitch == 64
     ORG $1000
     RORG $1000
  endif
 else
   ORG $F000
 endif

 ifconst bankswitch_hotspot
 if bankswitch_hotspot = $083F ; 0840 bankswitching hotspot
   .byte 0 ; stop unexpected bankswitches
 endif
 endif
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

.L00 ;  set kernel_options playercolors player1colors pfcolors

.L01 ;  set tv ntsc

.L02 ;  set romsize 32k

.L03 ;  set optimization speed

.L04 ;  set smartbranching on

.L05 ;  set optimization noinlinedata

.L06 ;  set optimization inlinerand

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L07 ;  rem set debug

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L08 ;  dim _Animation_Timer  =  a

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L09 ;  dim _Level_Data_Pointer  =  b

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L010 ;  dim _Coin_Counter  =  c

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L011 ;  dim _BitOp_Player_Data_Flags  =  d

.L012 ;  dim _Bit0_Player_Facing_Direction  =  d

.L013 ;  dim _Bit1_Jumping_Flag  =  d

.L014 ;  dim _Bit2_Fire_Button_Pressed  =  d

.L015 ;  dim _Bit3_Super_Mario_Power  =  d

.L016 ;  dim _Bit4_Firey_Mario_Power  =  d

.L017 ;  dim _Bit5_Ducking_Flag  =  d

.L018 ;  dim _Bit6_Regular_Mario  =  d

.L019 ;  dim _Bit7_Mario_Invincibility  =  d

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L020 ;  dim _Level_Timer  =  e

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L021 ;  dim _Boss_Life  =  e

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L022 ;  dim _BitOp_Extra_Bits  =  f

.L023 ;  dim _Bit0_Genesis_Controller  =  f

.L024 ;  dim _Bit1_Genesis_Button_Pressed  =  f

.L025 ;  dim _Bit7_2nd_Quest  =  f

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L026 ;  dim _BitOp_Extra_Bit_Flags  =  g

.L027 ;  dim _Bit0_Mario_Fireball_Going_Down  =  g

.L028 ;  dim _Bit1_Mario_Fireball_Going_Up  =  g

.L029 ;  dim _Bit2_Mario_Fireball_Direction  =  g

.L030 ;  dim _Bit3_Enemy_Direction  =  g

.L031 ;  dim _Bit4_Enemy_Dead_Flag  =  g

.L032 ;  dim _Bit5_Moving_Turtle_Shell_Direction  =  g

.L033 ;  dim _Bit6_Checkpoint_Flag  =  g

.L034 ;  dim _Bit7_Mario_On_Off  =  g

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L035 ;  dim _Object_Scroll_In_Data  =  h

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L036 ;  dim _Enemy_Type  =  i

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L037 ;  dim _Enemy_Momentum  =  j

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L038 ;  dim _Star_Invincibility_Timer  =  k

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L039 ;  dim _Lives_Counter  =  l

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L040 ;  dim _Momentum_Left_Right  =  m

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L041 ;  dim _Momentum_Up_Down  =  n

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L042 ;  dim _Farthest_Traveled_On_Level  =  o

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L043 ;  dim _Music_Duration  =  p

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L044 ;  dim _Moving_Shell_X_Coordinate  =  s

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L045 ;  dim _Moving_Shell_Y_Coordinate  =  t

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L046 ;  dim _Temp_u_PF_Column  =  u

.L047 ;  dim _Temp_u_PF_Row  =  u

.L048 ;  dim _Temp_u_Freq  =  u

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L049 ;  dim _World  =  v

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L050 ;  dim _Level  =  w

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L051 ;  const _Goomba  =  0

.L052 ;  const _Green_Koopa  =  2

.L053 ;  const _Beetle  =  4

.L054 ;  const _Spiney  =  6

.L055 ;  const _Red_Koopa  =  8

.L056 ;  const _Flying_Green_Koopa  =  10

.L057 ;  const _Bullet_Bill  =  12

.L058 ;  const _Flying_Red_Koopa  =  14

.L059 ;  const _Spiney_Ball  =  16

.L060 ;  const _Fireball_Enemy  =  18

.L061 ;  const _Flagpole  =  20

.L062 ;  const _Silver_Coin  =  22

.L063 ;  const _Starman  =  24

.L064 ;  const _1up_Mushroom  =  26

.L065 ;  const _Kinetic_Platforms  =  28

.L066 ;  const _Pirahna_Plant  =  30

.L067 ;  const _P_Plant_31  =  31

.L068 ;  const _Beetle_Shell  =  32

.L069 ;  const _Green_Shell  =  34

.L070 ;  const _Red_Shell  =  36

.L071 ;  const _Trampoline  =  38

.L072 ;  const _P_Plant_39  =  39

.L073 ;  const _Thwomp  =  40

.L074 ;  const _Two_Goombas  =  42

.L075 ;  const _Two_Thwomps  =  44

.L076 ;  const _Two_Spineys  =  46

.L077 ;  const _Bowser_Jr  =  64

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L078 ;  const pfscore  =  1

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Start
 ; __Start

.
 ; 

.L079 ;  if switchleftb then _Lives_Counter  =  3 else _Lives_Counter  =  5

 bit SWCHB
	BVS .skipL079
.condpart0
	LDA #3
	STA _Lives_Counter
 jmp .skipelse0
.skipL079
	LDA #5
	STA _Lives_Counter
.skipelse0
.
 ; 

.L080 ;  _World  =  1  :  _Level  =  1  :  _Bit6_Regular_Mario{6}  =  1

	LDA #1
	STA _World
	STA _Level
	LDA _Bit6_Regular_Mario
	ORA #64
	STA _Bit6_Regular_Mario
.
 ; 

.L081 ;  _Bit6_Checkpoint_Flag{6}  =  0  :  score  =  0  :  _Coin_Counter  =  0  :  pfscore2  =  0  :  d  =  0

	LDA _Bit6_Checkpoint_Flag
	AND #191
	STA _Bit6_Checkpoint_Flag
	LDA #$00
	STA score+2
	LDA #$00
	STA score+1
	LDA #$00
	STA score
	LDA #0
	STA _Coin_Counter
	STA pfscore2
	STA d
.
 ; 

.L082 ;  ballheight  =  2

	LDA #2
	STA ballheight
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L083 ;  if INPT1{7} then _Bit0_Genesis_Controller{0}  =  1 else _Bit0_Genesis_Controller{0}  =  0

	BIT INPT1
	BPL .skipL083
.condpart1
	LDA _Bit0_Genesis_Controller
	ORA #1
	STA _Bit0_Genesis_Controller
 jmp .skipelse1
.skipL083
	LDA _Bit0_Genesis_Controller
	AND #254
	STA _Bit0_Genesis_Controller
.skipelse1
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L084 ;  gosub __Title_Screen bank2

 sta temp7
 lda #>(ret_point1-1)
 pha
 lda #<(ret_point1-1)
 pha
 lda #>(.__Title_Screen-1)
 pha
 lda #<(.__Title_Screen-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #2
 jmp BS_jsr
ret_point1
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Init
 ; __Init

.
 ; 

.L085 ;  drawscreen

 sta temp7
 lda #>(ret_point2-1)
 pha
 lda #<(ret_point2-1)
 pha
 lda #>(drawscreen-1)
 pha
 lda #<(drawscreen-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #8
 jmp BS_jsr
ret_point2
.
 ; 

.L086 ;  gosub __Intro_Screen bank4

 sta temp7
 lda #>(ret_point3-1)
 pha
 lda #<(ret_point3-1)
 pha
 lda #>(.__Intro_Screen-1)
 pha
 lda #<(.__Intro_Screen-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point3
.
 ; 

.L087 ;  if _Level  =  4  &&  _Bit6_Checkpoint_Flag{6} then goto __Bos_Setup bank4

	LDA _Level
	CMP #4
     BNE .skipL087
.condpart2
	BIT _Bit6_Checkpoint_Flag
	BVC .skip2then
.condpart3
 sta temp7
 lda #>(.__Bos_Setup-1)
 pha
 lda #<(.__Bos_Setup-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
.skip2then
.skipL087
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
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

.L088 ;  _Object_Scroll_In_Data  =  0

	LDA #0
	STA _Object_Scroll_In_Data
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L089 ;  if switchreset then reboot

 lda #1
 bit SWCHB
	BNE .skipL089
.condpart4
	JMP ($FFFC)
.skipL089
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L090 ;  gosub __Set_Up_Mario

 jsr .__Set_Up_Mario

.
 ; 

.L091 ;  gosub __Render_Screen

 jsr .__Render_Screen

.
 ; 

.L092 ;  goto __Enemy_Collision_Routine bank3

 sta temp7
 lda #>(.__Enemy_Collision_Routine-1)
 pha
 lda #<(.__Enemy_Collision_Routine-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #3
 jmp BS_jsr
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Mario_Hit_01
 ; __Mario_Hit_01

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L093 ;  if _Bit7_Mario_Invincibility{7}  ||  _Enemy_Type  =  _Kinetic_Platforms then goto __Draw bank3

	BIT _Bit7_Mario_Invincibility
	BPL .skipL093
.condpart5
 jmp .condpart6
.skipL093
	LDA _Enemy_Type
	CMP #_Kinetic_Platforms
     BNE .skip1OR
.condpart6
 sta temp7
 lda #>(.__Draw-1)
 pha
 lda #<(.__Draw-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #3
 jmp BS_jsr
.skip1OR
.
 ; 

.L094 ;  if _Enemy_Type  =  _Trampoline then goto __Draw bank3

	LDA _Enemy_Type
	CMP #_Trampoline
     BNE .skipL094
.condpart7
 sta temp7
 lda #>(.__Draw-1)
 pha
 lda #<(.__Draw-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #3
 jmp BS_jsr
.skipL094
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L095 ;  if _Bit6_Regular_Mario{6} then goto __Mario_Death bank3

	BIT _Bit6_Regular_Mario
	BVC .skipL095
.condpart8
 sta temp7
 lda #>(.__Mario_Death-1)
 pha
 lda #<(.__Mario_Death-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #3
 jmp BS_jsr
.skipL095
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L096 ;  if _Bit4_Firey_Mario_Power{4} then _Bit3_Super_Mario_Power{3}  =  1  :  _Bit4_Firey_Mario_Power{4}  =  0 else _Bit6_Regular_Mario{6}  =  1  :  _Bit3_Super_Mario_Power{3}  =  0  :  _Temp_u_Freq  =  0  :  y  =  8

	LDA _Bit4_Firey_Mario_Power
	AND #16
	BEQ .skipL096
.condpart9
	LDA _Bit3_Super_Mario_Power
	ORA #8
	STA _Bit3_Super_Mario_Power
	LDA _Bit4_Firey_Mario_Power
	AND #239
	STA _Bit4_Firey_Mario_Power
 jmp .skipelse2
.skipL096
	LDA _Bit6_Regular_Mario
	ORA #64
	STA _Bit6_Regular_Mario
	LDA _Bit3_Super_Mario_Power
	AND #247
	STA _Bit3_Super_Mario_Power
	LDA #0
	STA _Temp_u_Freq
	LDA #8
	STA y
.skipelse2
.
 ; 

.L097 ;  for z  =  1 to 8

	LDA #1
	STA z
.L097forz
.
 ; 

.L098 ;  for x  =  1 to 4

	LDA #1
	STA x
.L098forx
.
 ; 

.L099 ;  if _Bit3_Super_Mario_Power{3} then gosub __Fire_Mario_Color  :  gosub __Super_Mario else gosub __Super_Mario_Color  :  gosub __Super_Mario

	LDA _Bit3_Super_Mario_Power
	AND #8
	BEQ .skipL099
.condpart10
 jsr .__Fire_Mario_Color
 jsr .__Super_Mario
 jmp .skipelse3
.skipL099
 jsr .__Super_Mario_Color
 jsr .__Super_Mario

.skipelse3
.
 ; 

.L0100 ;  gosub __Power_Down_SFX

 jsr .__Power_Down_SFX

.
 ; 

.L0101 ;  gosub __Render_Screen

 jsr .__Render_Screen

.
 ; 

.L0102 ;  next x

	LDA x
	CMP #4

	INC x
 if ((* - .L098forx) < 127) && ((* - .L098forx) > -128)
	bcc .L098forx
 else
	bcs .0skipL098forx
	jmp .L098forx
.0skipL098forx
 endif
.
 ; 

.L0103 ;  for x  =  1 to 4

	LDA #1
	STA x
.L0103forx
.
 ; 

.L0104 ;  if _Bit3_Super_Mario_Power{3} then gosub __Super_Mario_Color  :  gosub __Super_Mario else gosub __Mario_Color  :  gosub __Mario

	LDA _Bit3_Super_Mario_Power
	AND #8
	BEQ .skipL0104
.condpart11
 jsr .__Super_Mario_Color
 jsr .__Super_Mario
 jmp .skipelse4
.skipL0104
 jsr .__Mario_Color
 jsr .__Mario

.skipelse4
.
 ; 

.L0105 ;  gosub __Power_Down_SFX

 jsr .__Power_Down_SFX

.
 ; 

.L0106 ;  gosub __Render_Screen

 jsr .__Render_Screen

.
 ; 

.L0107 ;  next x

	LDA x
	CMP #4

	INC x
 if ((* - .L0103forx) < 127) && ((* - .L0103forx) > -128)
	bcc .L0103forx
 else
	bcs .1skipL0103forx
	jmp .L0103forx
.1skipL0103forx
 endif
.
 ; 

.L0108 ;  next z

	LDA z
	CMP #8

	INC z
 if ((* - .L097forz) < 127) && ((* - .L097forz) > -128)
	bcc .L097forz
 else
	bcs .2skipL097forz
	jmp .L097forz
.2skipL097forz
 endif
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0109 ;  if _Enemy_Type  <  _Bowser_Jr then _Bit7_Mario_Invincibility{7}  =  1  :  _Level_Timer  =  0  :  _Bit7_Mario_On_Off{7}  =  0 else _Star_Invincibility_Timer  =  1  :  _Bit7_Mario_On_Off{7}  =  1  :  _Bit7_Mario_Invincibility{7}  =  1

	LDA _Enemy_Type
	CMP #_Bowser_Jr
     BCS .skipL0109
.condpart12
	LDA _Bit7_Mario_Invincibility
	ORA #128
	STA _Bit7_Mario_Invincibility
	LDA #0
	STA _Level_Timer
	LDA _Bit7_Mario_On_Off
	AND #127
	STA _Bit7_Mario_On_Off
 jmp .skipelse5
.skipL0109
	LDA #1
	STA _Star_Invincibility_Timer
	LDA _Bit7_Mario_On_Off
	ORA #128
	STA _Bit7_Mario_On_Off
	LDA _Bit7_Mario_Invincibility
	ORA #128
	STA _Bit7_Mario_Invincibility
.skipelse5
.
 ; 

.L0110 ;  goto __Draw bank3

 sta temp7
 lda #>(.__Draw-1)
 pha
 lda #<(.__Draw-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #3
 jmp BS_jsr
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Main_2
 ; __Main_2

.
 ; 

.L0111 ;  gosub __Render_Screen

 jsr .__Render_Screen

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0112 ;  if _Momentum_Left_Right  >  0  &&  _Bit0_Player_Facing_Direction{0} then player0x  =  player0x  -  _Momentum_Left_Right

	LDA #0
	CMP _Momentum_Left_Right
     BCS .skipL0112
.condpart13
	LDA _Bit0_Player_Facing_Direction
	LSR
	BCC .skip13then
.condpart14
	LDA player0x
	SEC
	SBC _Momentum_Left_Right
	STA player0x
.skip13then
.skipL0112
.
 ; 

.L0113 ;  if _Momentum_Left_Right  >  0  &&  !_Bit0_Player_Facing_Direction{0} then player0x  =  player0x  +  _Momentum_Left_Right

	LDA #0
	CMP _Momentum_Left_Right
     BCS .skipL0113
.condpart15
	LDA _Bit0_Player_Facing_Direction
	LSR
	BCS .skip15then
.condpart16
	LDA player0x
	CLC
	ADC _Momentum_Left_Right
	STA player0x
.skip15then
.skipL0113
.
 ; 

.L0114 ;  if _Momentum_Up_Down  >  0  &&  _Bit1_Jumping_Flag{1} then player0y  =  player0y  -  _Momentum_Up_Down

	LDA #0
	CMP _Momentum_Up_Down
     BCS .skipL0114
.condpart17
	LDA _Bit1_Jumping_Flag
	AND #2
	BEQ .skip17then
.condpart18
	LDA player0y
	SEC
	SBC _Momentum_Up_Down
	STA player0y
.skip17then
.skipL0114
.
 ; 

.L0115 ;  if _Momentum_Up_Down  >  0  &&  !_Bit1_Jumping_Flag{1} then player0y  =  player0y  +  _Momentum_Up_Down

	LDA #0
	CMP _Momentum_Up_Down
     BCS .skipL0115
.condpart19
	LDA _Bit1_Jumping_Flag
	AND #2
	BNE .skip19then
.condpart20
	LDA player0y
	CLC
	ADC _Momentum_Up_Down
	STA player0y
.skip19then
.skipL0115
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0116 ;  if player0x  <  17 then player0x  =  17

	LDA player0x
	CMP #17
     BCS .skipL0116
.condpart21
	LDA #17
	STA player0x
.skipL0116
.
 ; 

.L0117 ;  if player0x  >  137 then player0x  =  137

	LDA #137
	CMP player0x
     BCS .skipL0117
.condpart22
	LDA #137
	STA player0x
.skipL0117
.
 ; 

.L0118 ;  if _Enemy_Type  >  60 then goto __Fall_Collision_Check

	LDA #60
	CMP _Enemy_Type
     BCS .skipL0118
.condpart23
 jmp .__Fall_Collision_Check

.skipL0118
.
 ; 

.L0119 ;  if !_Bit0_Player_Facing_Direction{0}  &&  player0x  >  80  &&  _Level_Data_Pointer  <  127 then player0x  =  80  :  gosub __Scroll_Left

	LDA _Bit0_Player_Facing_Direction
	LSR
	BCS .skipL0119
.condpart24
	LDA #80
	CMP player0x
     BCS .skip24then
.condpart25
	LDA _Level_Data_Pointer
	CMP #127
     BCS .skip25then
.condpart26
	LDA #80
	STA player0x
 jsr .__Scroll_Left

.skip25then
.skip24then
.skipL0119
.
 ; 

.L0120 ;  if _Bit0_Player_Facing_Direction{0}  &&  player0x  <  72  &&  _Level_Data_Pointer  >  32 then player0x  =  72  :  gosub __Scroll_Right

	LDA _Bit0_Player_Facing_Direction
	LSR
	BCC .skipL0120
.condpart27
	LDA player0x
	CMP #72
     BCS .skip27then
.condpart28
	LDA #32
	CMP _Level_Data_Pointer
     BCS .skip28then
.condpart29
	LDA #72
	STA player0x
 jsr .__Scroll_Right

.skip28then
.skip27then
.skipL0120
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Fall_Collision_Check
 ; __Fall_Collision_Check

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0121 ;  if _Bit1_Jumping_Flag{1} then goto __Jump_Collision_Check

	LDA _Bit1_Jumping_Flag
	AND #2
	BEQ .skipL0121
.condpart30
 jmp .__Jump_Collision_Check

.skipL0121
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0122 ;  if _Momentum_Up_Down  >  0 then z  =  0 else z  =  1

	LDA #0
	CMP _Momentum_Up_Down
     BCS .skipL0122
.condpart31
	LDA #0
	STA z
 jmp .skipelse6
.skipL0122
	LDA #1
	STA z
.skipelse6
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0123 ;  y  =   ( player0y  +  z )  / 8

; complex statement detected
	LDA player0y
	CLC
	ADC z
	lsr
	lsr
	lsr
	STA y
.
 ; 

.L0124 ;  x  =   ( player0x  -  15 )  / 4

; complex statement detected
	LDA player0x
	SEC
	SBC #15
	lsr
	lsr
	STA x
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0125 ;  if pfread ( x , y )  then player0y  =   ( y  *  8 )   -  1  :  _Momentum_Up_Down  =  0  :  goto __Jump_Collision_Check

	LDA x
	LDY y
 sta temp7
 lda #>(ret_point4-1)
 pha
 lda #<(ret_point4-1)
 pha
 lda #>(pfread-1)
 pha
 lda #<(pfread-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #8
 jmp BS_jsr
ret_point4
	BNE .skipL0125
.condpart32
; complex statement detected
	LDA y
	asl
	asl
	asl
	SEC
	SBC #1
	STA player0y
	LDA #0
	STA _Momentum_Up_Down
 jmp .__Jump_Collision_Check

.skipL0125
.
 ; 

.L0126 ;  x  =   ( player0x  -  11 )  / 4

; complex statement detected
	LDA player0x
	SEC
	SBC #11
	lsr
	lsr
	STA x
.
 ; 

.L0127 ;  if pfread ( x , y )  then player0y  =   ( y  *  8 )   -  1  :  _Momentum_Up_Down  =  0  :  goto __Jump_Collision_Check

	LDA x
	LDY y
 sta temp7
 lda #>(ret_point5-1)
 pha
 lda #<(ret_point5-1)
 pha
 lda #>(pfread-1)
 pha
 lda #<(pfread-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #8
 jmp BS_jsr
ret_point5
	BNE .skipL0127
.condpart33
; complex statement detected
	LDA y
	asl
	asl
	asl
	SEC
	SBC #1
	STA player0y
	LDA #0
	STA _Momentum_Up_Down
 jmp .__Jump_Collision_Check

.skipL0127
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0128 ;  if _Momentum_Up_Down  <  7 then _Momentum_Up_Down  =  _Momentum_Up_Down  +  1

	LDA _Momentum_Up_Down
	CMP #7
     BCS .skipL0128
.condpart34
	INC _Momentum_Up_Down
.skipL0128
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Jump_Collision_Check
 ; __Jump_Collision_Check

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0129 ;  if !_Bit1_Jumping_Flag{1} then goto __Momentum_Left_Right_Check

	LDA _Bit1_Jumping_Flag
	AND #2
	BNE .skipL0129
.condpart35
 jmp .__Momentum_Left_Right_Check

.skipL0129
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0130 ;  if _Bit3_Super_Mario_Power{3}  ||  _Bit4_Firey_Mario_Power{4} then y  =   ( player0y  -  22 )  / 8  :  z  =  10

	LDA _Bit3_Super_Mario_Power
	AND #8
	BEQ .skipL0130
.condpart36
 jmp .condpart37
.skipL0130
	LDA _Bit4_Firey_Mario_Power
	AND #16
	BEQ .skip10OR
.condpart37
; complex statement detected
	LDA player0y
	SEC
	SBC #22
	lsr
	lsr
	lsr
	STA y
	LDA #10
	STA z
.skip10OR
.
 ; 

.L0131 ;  if _Bit5_Ducking_Flag{5}  ||  _Bit6_Regular_Mario{6} then y  =   ( player0y  -  12 )  / 8  :  z  =  0

	LDA _Bit5_Ducking_Flag
	AND #32
	BEQ .skipL0131
.condpart38
 jmp .condpart39
.skipL0131
	BIT _Bit6_Regular_Mario
	BVC .skip11OR
.condpart39
; complex statement detected
	LDA player0y
	SEC
	SBC #12
	lsr
	lsr
	lsr
	STA y
	LDA #0
	STA z
.skip11OR
.
 ; 

.L0132 ;  if y  <  0  ||  y  >  11 then goto __Jump_Collsn_Check_02

	LDA y
	CMP #0
     BCS .skipL0132
.condpart40
 jmp .condpart41
.skipL0132
	LDA #11
	CMP y
     BCS .skip12OR
.condpart41
 jmp .__Jump_Collsn_Check_02

.skip12OR
.
 ; 

.L0133 ;  if _Level  =  3  &&  y  >  1 then goto __Jump_Collsn_Check_02

	LDA _Level
	CMP #3
     BNE .skipL0133
.condpart42
	LDA #1
	CMP y
     BCS .skip42then
.condpart43
 jmp .__Jump_Collsn_Check_02

.skip42then
.skipL0133
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0134 ;  x  =   ( player0x  -  15 )  / 4

; complex statement detected
	LDA player0x
	SEC
	SBC #15
	lsr
	lsr
	STA x
.
 ; 

.L0135 ;  if pfread ( x , y )  then player0y  =   ( y  *  8 )   +  18  +  z  :  _Bit1_Jumping_Flag{1}  =  0  :  _Momentum_Up_Down  =  1  :  goto __Bonus_Check

	LDA x
	LDY y
 sta temp7
 lda #>(ret_point6-1)
 pha
 lda #<(ret_point6-1)
 pha
 lda #>(pfread-1)
 pha
 lda #<(pfread-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #8
 jmp BS_jsr
ret_point6
	BNE .skipL0135
.condpart44
; complex statement detected
	LDA y
	asl
	asl
	asl
	CLC
	ADC #18
	CLC
	ADC z
	STA player0y
	LDA _Bit1_Jumping_Flag
	AND #253
	STA _Bit1_Jumping_Flag
	LDA #1
	STA _Momentum_Up_Down
 jmp .__Bonus_Check

.skipL0135
.
 ; 

.L0136 ;  x  =   ( player0x  -  11 )  / 4

; complex statement detected
	LDA player0x
	SEC
	SBC #11
	lsr
	lsr
	STA x
.
 ; 

.L0137 ;  if pfread ( x , y )  then player0y  =   ( y  *  8 )   +  18  +  z  :  _Bit1_Jumping_Flag{1}  =  0  :  _Momentum_Up_Down  =  1  :  goto __Bonus_Check

	LDA x
	LDY y
 sta temp7
 lda #>(ret_point7-1)
 pha
 lda #<(ret_point7-1)
 pha
 lda #>(pfread-1)
 pha
 lda #<(pfread-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #8
 jmp BS_jsr
ret_point7
	BNE .skipL0137
.condpart45
; complex statement detected
	LDA y
	asl
	asl
	asl
	CLC
	ADC #18
	CLC
	ADC z
	STA player0y
	LDA _Bit1_Jumping_Flag
	AND #253
	STA _Bit1_Jumping_Flag
	LDA #1
	STA _Momentum_Up_Down
 jmp .__Bonus_Check

.skipL0137
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Jump_Collsn_Check_02
 ; __Jump_Collsn_Check_02

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0138 ;  _Momentum_Up_Down  =  _Momentum_Up_Down  -  1

	DEC _Momentum_Up_Down
.
 ; 

.L0139 ;  if _Momentum_Up_Down  <  1 then _Momentum_Up_Down  =  1  :  _Bit1_Jumping_Flag{1}  =  0

	LDA _Momentum_Up_Down
	CMP #1
     BCS .skipL0139
.condpart46
	LDA #1
	STA _Momentum_Up_Down
	LDA _Bit1_Jumping_Flag
	AND #253
	STA _Bit1_Jumping_Flag
.skipL0139
.
 ; 

.L0140 ;  if player0y  <  8 then player0y  =  8

	LDA player0y
	CMP #8
     BCS .skipL0140
.condpart47
	LDA #8
	STA player0y
.skipL0140
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Momentum_Left_Right_Check
 ; __Momentum_Left_Right_Check

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0141 ;  if _Level  =  3 then goto __Finish_Check

	LDA _Level
	CMP #3
     BNE .skipL0141
.condpart48
 jmp .__Finish_Check

.skipL0141
.
 ; 

.L0142 ;  if _Bit0_Player_Facing_Direction{0} then x  =   ( player0x  -  17 )  / 4 else x  =   ( player0x  -  9 )  / 4

	LDA _Bit0_Player_Facing_Direction
	LSR
	BCC .skipL0142
.condpart49
; complex statement detected
	LDA player0x
	SEC
	SBC #17
	lsr
	lsr
	STA x
 jmp .skipelse7
.skipL0142
; complex statement detected
	LDA player0x
	SEC
	SBC #9
	lsr
	lsr
	STA x
.skipelse7
.
 ; 

.L0143 ;  y  =   ( player0y  -  4 )  / 8

; complex statement detected
	LDA player0y
	SEC
	SBC #4
	lsr
	lsr
	lsr
	STA y
.
 ; 

.L0144 ;  if pfread ( x , y )  then goto __Fix_Mario

	LDA x
	LDY y
 sta temp7
 lda #>(ret_point8-1)
 pha
 lda #<(ret_point8-1)
 pha
 lda #>(pfread-1)
 pha
 lda #<(pfread-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #8
 jmp BS_jsr
ret_point8
	BNE .skipL0144
.condpart50
 jmp .__Fix_Mario

.skipL0144
.
 ; 

.L0145 ;  y  =   ( player0y  -  11 )  / 8

; complex statement detected
	LDA player0y
	SEC
	SBC #11
	lsr
	lsr
	lsr
	STA y
.
 ; 

.L0146 ;  if pfread ( x , y )  then goto __Fix_Mario

	LDA x
	LDY y
 sta temp7
 lda #>(ret_point9-1)
 pha
 lda #<(ret_point9-1)
 pha
 lda #>(pfread-1)
 pha
 lda #<(pfread-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #8
 jmp BS_jsr
ret_point9
	BNE .skipL0146
.condpart51
 jmp .__Fix_Mario

.skipL0146
.
 ; 

.L0147 ;  if _Bit5_Ducking_Flag{5}  ||  _Bit6_Regular_Mario{6} then goto __Finish_Check

	LDA _Bit5_Ducking_Flag
	AND #32
	BEQ .skipL0147
.condpart52
 jmp .condpart53
.skipL0147
	BIT _Bit6_Regular_Mario
	BVC .skip14OR
.condpart53
 jmp .__Finish_Check

.skip14OR
.
 ; 

.L0148 ;  y  =   ( player0y  -  18 )  / 8

; complex statement detected
	LDA player0y
	SEC
	SBC #18
	lsr
	lsr
	lsr
	STA y
.
 ; 

.L0149 ;  if pfread ( x , y )  then goto __Fix_Mario

	LDA x
	LDY y
 sta temp7
 lda #>(ret_point10-1)
 pha
 lda #<(ret_point10-1)
 pha
 lda #>(pfread-1)
 pha
 lda #<(pfread-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #8
 jmp BS_jsr
ret_point10
	BNE .skipL0149
.condpart54
 jmp .__Fix_Mario

.skipL0149
.
 ; 

.L0150 ;  goto __Finish_Check

 jmp .__Finish_Check

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Bonus_Check
 ; __Bonus_Check

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0151 ;  if _Level  =  4 then goto __Momentum_Left_Right_Check

	LDA _Level
	CMP #4
     BNE .skipL0151
.condpart55
 jmp .__Momentum_Left_Right_Check

.skipL0151
.
 ; 

.L0152 ;  if player1y  <  player0y then goto __Enemy_Bump

	LDA player1y
	CMP player0y
     BCS .skipL0152
.condpart56
 jmp .__Enemy_Bump

.skipL0152
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Bonus_Check_02
 ; __Bonus_Check_02

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0153 ;  if y  =  0  &&  _Level  =  3 then goto __Yellow_Block

	LDA y
	CMP #0
     BNE .skipL0153
.condpart57
	LDA _Level
	CMP #3
     BNE .skip57then
.condpart58
 jmp .__Yellow_Block

.skip57then
.skipL0153
.
 ; 

.L0154 ;  if y  =  1  &&  _Level  =  1 then goto __Yellow_Block

	LDA y
	CMP #1
     BNE .skipL0154
.condpart59
	LDA _Level
	CMP #1
     BNE .skip59then
.condpart60
 jmp .__Yellow_Block

.skip59then
.skipL0154
.
 ; 

.L0155 ;  if y  =  6  &&  _Level  <>  3 then goto __Yellow_Block

	LDA y
	CMP #6
     BNE .skipL0155
.condpart61
	LDA _Level
	CMP #3
     BEQ .skip61then
.condpart62
 jmp .__Yellow_Block

.skip61then
.skipL0155
.
 ; 

.__Brick_Block
 ; __Brick_Block

.
 ; 

.L0156 ;  if y  <>  1  &&  _Level  =  3 then goto __Finish_Check

	LDA y
	CMP #1
     BEQ .skipL0156
.condpart63
	LDA _Level
	CMP #3
     BNE .skip63then
.condpart64
 jmp .__Finish_Check

.skip63then
.skipL0156
.
 ; 

.L0157 ;  if player1x  =  0  &&  _Level_Data_Pointer  >  31  &&  y  >  1  &&  !_Bit6_Regular_Mario{6} then goto __Hidden_Block

	LDA player1x
	CMP #0
     BNE .skipL0157
.condpart65
	LDA #31
	CMP _Level_Data_Pointer
     BCS .skip65then
.condpart66
	LDA #1
	CMP y
     BCS .skip66then
.condpart67
	BIT _Bit6_Regular_Mario
	BVS .skip67then
.condpart68
 jmp .__Hidden_Block

.skip67then
.skip66then
.skip65then
.skipL0157
.
 ; 

.__Brick_Block_02
 ; __Brick_Block_02

.
 ; 

.L0158 ;  if _Bit6_Regular_Mario{6} then goto __Finish_Check

	BIT _Bit6_Regular_Mario
	BVC .skipL0158
.condpart69
 jmp .__Finish_Check

.skipL0158
.
 ; 

.L0159 ;  AUDV0  =  10  :  AUDC0  =  7  :  AUDF0  =  22

	LDA #10
	STA AUDV0
	LDA #7
	STA AUDC0
	LDA #22
	STA AUDF0
.
 ; 

.L0160 ;  score  =  score  +  10

	SED
	CLC
	LDA score+2
	ADC #$10
	STA score+2
	LDA score+1
	ADC #$00
	STA score+1
	LDA score
	ADC #$00
	STA score
	CLD
.
 ; 

.L0161 ;  pfpixel x y off

	LDX #1
	LDY y
	LDA x
 sta temp7
 lda #>(ret_point11-1)
 pha
 lda #<(ret_point11-1)
 pha
 lda #>(pfpixel-1)
 pha
 lda #<(pfpixel-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #8
 jmp BS_jsr
ret_point11
.
 ; 

.L0162 ;  goto __Finish_Check

 jmp .__Finish_Check

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Yellow_Block
 ; __Yellow_Block

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0163 ;  pfpixel x y off

	LDX #1
	LDY y
	LDA x
 sta temp7
 lda #>(ret_point12-1)
 pha
 lda #<(ret_point12-1)
 pha
 lda #>(pfpixel-1)
 pha
 lda #<(pfpixel-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #8
 jmp BS_jsr
ret_point12
.
 ; 

.L0164 ;  if _Animation_Timer  >  1  ||  _Bit4_Firey_Mario_Power{4} then score  =  score  +  100  :  goto __Add_Coin_Counter

	LDA #1
	CMP _Animation_Timer
     BCS .skipL0164
.condpart70
 jmp .condpart71
.skipL0164
	LDA _Bit4_Firey_Mario_Power
	AND #16
	BEQ .skip22OR
.condpart71
	SED
	CLC
	LDA score+1
	ADC #$01
	STA score+1
	LDA score
	ADC #$00
	STA score
	CLD
 jmp .__Add_Coin_Counter

.skip22OR
.
 ; 

.L0165 ;  score  =  score  +  1000

	SED
	CLC
	LDA score+1
	ADC #$10
	STA score+1
	LDA score
	ADC #$00
	STA score
	CLD
.
 ; 

.L0166 ;  if _Bit4_Firey_Mario_Power{4} then goto __Finish_Check

	LDA _Bit4_Firey_Mario_Power
	AND #16
	BEQ .skipL0166
.condpart72
 jmp .__Finish_Check

.skipL0166
.
 ; 

.L0167 ;  if _Bit3_Super_Mario_Power{3} then _Bit3_Super_Mario_Power{3}  =  0  :  _Bit4_Firey_Mario_Power{4}  =  1 else _Bit3_Super_Mario_Power{3}  =  1  :  _Bit4_Firey_Mario_Power{4}  =  0  :  _Bit6_Regular_Mario{6}  =  0

	LDA _Bit3_Super_Mario_Power
	AND #8
	BEQ .skipL0167
.condpart73
	LDA _Bit3_Super_Mario_Power
	AND #247
	STA _Bit3_Super_Mario_Power
	LDA _Bit4_Firey_Mario_Power
	ORA #16
	STA _Bit4_Firey_Mario_Power
 jmp .skipelse8
.skipL0167
	LDA _Bit3_Super_Mario_Power
	ORA #8
	STA _Bit3_Super_Mario_Power
	LDA _Bit4_Firey_Mario_Power
	AND #239
	STA _Bit4_Firey_Mario_Power
	LDA _Bit6_Regular_Mario
	AND #191
	STA _Bit6_Regular_Mario
.skipelse8
.
 ; 

.L0168 ;  y  =  31  :  u  =  0

	LDA #31
	STA y
	LDA #0
	STA u
.
 ; 

.L0169 ;  for z  =  1 to 8

	LDA #1
	STA z
.L0169forz
.
 ; 

.L0170 ;  for x  =  1 to 4

	LDA #1
	STA x
.L0170forx
.
 ; 

.L0171 ;  if _Bit3_Super_Mario_Power{3} then gosub __Super_Mario_Color  :  gosub __Super_Mario else gosub __Fire_Mario_Color  :  gosub __Super_Mario

	LDA _Bit3_Super_Mario_Power
	AND #8
	BEQ .skipL0171
.condpart74
 jsr .__Super_Mario_Color
 jsr .__Super_Mario
 jmp .skipelse9
.skipL0171
 jsr .__Fire_Mario_Color
 jsr .__Super_Mario

.skipelse9
.
 ; 

.L0172 ;  gosub __Power_Up_SFX

 jsr .__Power_Up_SFX

.
 ; 

.L0173 ;  gosub __Render_Screen

 jsr .__Render_Screen

.
 ; 

.L0174 ;  next x

	LDA x
	CMP #4

	INC x
 if ((* - .L0170forx) < 127) && ((* - .L0170forx) > -128)
	bcc .L0170forx
 else
	bcs .3skipL0170forx
	jmp .L0170forx
.3skipL0170forx
 endif
.
 ; 

.L0175 ;  for x  =  1 to 4

	LDA #1
	STA x
.L0175forx
.
 ; 

.L0176 ;  if _Bit3_Super_Mario_Power{3} then gosub __Mario_Color  :  gosub __Mario else gosub __Super_Mario_Color  :  gosub __Super_Mario

	LDA _Bit3_Super_Mario_Power
	AND #8
	BEQ .skipL0176
.condpart75
 jsr .__Mario_Color
 jsr .__Mario
 jmp .skipelse10
.skipL0176
 jsr .__Super_Mario_Color
 jsr .__Super_Mario

.skipelse10
.
 ; 

.L0177 ;  gosub __Power_Up_SFX

 jsr .__Power_Up_SFX

.
 ; 

.L0178 ;  gosub __Render_Screen

 jsr .__Render_Screen

.
 ; 

.L0179 ;  next x

	LDA x
	CMP #4

	INC x
 if ((* - .L0175forx) < 127) && ((* - .L0175forx) > -128)
	bcc .L0175forx
 else
	bcs .4skipL0175forx
	jmp .L0175forx
.4skipL0175forx
 endif
.
 ; 

.L0180 ;  next z

	LDA z
	CMP #8

	INC z
 if ((* - .L0169forz) < 127) && ((* - .L0169forz) > -128)
	bcc .L0169forz
 else
	bcs .5skipL0169forz
	jmp .L0169forz
.5skipL0169forz
 endif
.
 ; 

.L0181 ;  goto __Finish_Check

 jmp .__Finish_Check

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Hidden_Block
 ; __Hidden_Block

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0182 ;  u  =  _Level_Timer  +  _Animation_Timer

	LDA _Level_Timer
	CLC
	ADC _Animation_Timer
	STA u
.
 ; 

.L0183 ;  if u  =  10  ||  u  =  16 then goto __Hidden_Blck_02

	LDA u
	CMP #10
     BNE .skipL0183
.condpart76
 jmp .condpart77
.skipL0183
	LDA u
	CMP #16
     BNE .skip23OR
.condpart77
 jmp .__Hidden_Blck_02

.skip23OR
.
 ; 

.L0184 ;  if u  =  25 then goto __Hidden_Blck_02

	LDA u
	CMP #25
     BNE .skipL0184
.condpart78
 jmp .__Hidden_Blck_02

.skipL0184
.
 ; 

.L0185 ;  goto __Brick_Block_02

 jmp .__Brick_Block_02

.
 ; 

.__Hidden_Blck_02
 ; __Hidden_Blck_02

.
 ; 

.L0186 ;  _Bit3_Enemy_Direction{3}  =  0

	LDA _Bit3_Enemy_Direction
	AND #247
	STA _Bit3_Enemy_Direction
.
 ; 

.L0187 ;  player1x  =   ( x  *  4 )   +  17

; complex statement detected
	LDA x
	asl
	asl
	CLC
	ADC #17
	STA player1x
.
 ; 

.L0188 ;  player1y  =  y  *  8

	LDA y
	asl
	asl
	asl
	STA player1y
.
 ; 

.L0189 ;  _Enemy_Type  =  _Silver_Coin

	LDA #_Silver_Coin
	STA _Enemy_Type
.
 ; 

.L0190 ;  if _Animation_Timer  >  3  &&  _Star_Invincibility_Timer  =  0 then _Enemy_Type  =  _Starman

	LDA #3
	CMP _Animation_Timer
     BCS .skipL0190
.condpart79
	LDA _Star_Invincibility_Timer
	CMP #0
     BNE .skip79then
.condpart80
	LDA #_Starman
	STA _Enemy_Type
.skip79then
.skipL0190
.
 ; 

.L0191 ;  if _Animation_Timer  =  6 then _Enemy_Type  =  _1up_Mushroom

	LDA _Animation_Timer
	CMP #6
     BNE .skipL0191
.condpart81
	LDA #_1up_Mushroom
	STA _Enemy_Type
.skipL0191
.
 ; 

.L0192 ;  _Enemy_Momentum  =  3

	LDA #3
	STA _Enemy_Momentum
.
 ; 

.L0193 ;  goto __Brick_Block_02

 jmp .__Brick_Block_02

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Enemy_Bump
 ; __Enemy_Bump

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0194 ;  _Temp_u_PF_Row  =   ( y  *  8 )   -  1

; complex statement detected
	LDA y
	asl
	asl
	asl
	SEC
	SBC #1
	STA _Temp_u_PF_Row
.
 ; 

.L0195 ;  if _Temp_u_PF_Row  <>  player1y then goto __Bonus_Check_02

	LDA _Temp_u_PF_Row
	CMP player1y
     BEQ .skipL0195
.condpart82
 jmp .__Bonus_Check_02

.skipL0195
.
 ; 

.L0196 ;  _Temp_u_PF_Column  =   ( x  *  4 )   +  13  :  z  =   ( x  *  4 )   +  23

; complex statement detected
	LDA x
	asl
	asl
	CLC
	ADC #13
	STA _Temp_u_PF_Column
; complex statement detected
	LDA x
	asl
	asl
	CLC
	ADC #23
	STA z
.
 ; 

.L0197 ;  if player1x  >  _Temp_u_PF_Column  &&  player1x  <  z then goto __Enemy_Bump_02

	LDA _Temp_u_PF_Column
	CMP player1x
     BCS .skipL0197
.condpart83
	LDA player1x
	CMP z
     BCS .skip83then
.condpart84
 jmp .__Enemy_Bump_02

.skip83then
.skipL0197
.
 ; 

.L0198 ;  goto __Bonus_Check_02

 jmp .__Bonus_Check_02

.
 ; 

.__Enemy_Bump_02
 ; __Enemy_Bump_02

.
 ; 

.L0199 ;  _Bit4_Enemy_Dead_Flag{4}  =  1  :  score  =  score  +  300

	LDA _Bit4_Enemy_Dead_Flag
	ORA #16
	STA _Bit4_Enemy_Dead_Flag
	SED
	CLC
	LDA score+1
	ADC #$03
	STA score+1
	LDA score
	ADC #$00
	STA score
	CLD
.
 ; 

.L0200 ;  goto __Bonus_Check_02

 jmp .__Bonus_Check_02

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Add_Coin_Counter
 ; __Add_Coin_Counter

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0201 ;  _Coin_Counter  =  _Coin_Counter  +  1

	INC _Coin_Counter
.
 ; 

.L0202 ;  if _Coin_Counter  >  3 then _Coin_Counter  =  0  :  pfscore2  =  pfscore2  *  2 | 1

	LDA #3
	CMP _Coin_Counter
     BCS .skipL0202
.condpart85
	LDA #0
	STA _Coin_Counter
; complex statement detected
	LDA pfscore2
	asl
	ORA #1
	STA pfscore2
.skipL0202
.
 ; 

.L0203 ;  AUDV0  =  12  :  AUDC0  =  4  :  AUDF0  =  7

	LDA #12
	STA AUDV0
	LDA #4
	STA AUDC0
	LDA #7
	STA AUDF0
.
 ; 

.L0204 ;  if pfscore2  <  250 then goto __Finish_Check

	LDA pfscore2
	CMP #250
     BCS .skipL0204
.condpart86
 jmp .__Finish_Check

.skipL0204
.
 ; 

.L0205 ;  y  =  11  :  _Temp_u_PF_Column  =  0  :  _Lives_Counter  =  _Lives_Counter  +  1

	LDA #11
	STA y
	LDA #0
	STA _Temp_u_PF_Column
	INC _Lives_Counter
.
 ; 

.L0206 ;  if _Lives_Counter  =  255 then _Lives_Counter  =  254

	LDA _Lives_Counter
	CMP #255
     BNE .skipL0206
.condpart87
	LDA #254
	STA _Lives_Counter
.skipL0206
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__1Up
 ; __1Up

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0207 ;  gosub __1Up_SFX

 jsr .__1Up_SFX

.
 ; 

.L0208 ;  gosub __Render_Screen  :  gosub __Render_Screen  :  gosub __Render_Screen  :  gosub __Render_Screen

 jsr .__Render_Screen
 jsr .__Render_Screen
 jsr .__Render_Screen
 jsr .__Render_Screen

.
 ; 

.L0209 ;  _Bit7_Mario_On_Off{7}  =  1  :  _Bit7_Mario_Invincibility{7}  =  1

	LDA _Bit7_Mario_On_Off
	ORA #128
	STA _Bit7_Mario_On_Off
	LDA _Bit7_Mario_Invincibility
	ORA #128
	STA _Bit7_Mario_Invincibility
.
 ; 

.L0210 ;  gosub __Render_Screen  :  gosub __Render_Screen  :  gosub __Render_Screen  :  gosub __Render_Screen

 jsr .__Render_Screen
 jsr .__Render_Screen
 jsr .__Render_Screen
 jsr .__Render_Screen

.
 ; 

.L0211 ;  _Bit7_Mario_On_Off{7}  =  0  :  _Bit7_Mario_Invincibility{7}  =  0  :  gosub __Set_Up_Mario

	LDA _Bit7_Mario_On_Off
	AND #127
	STA _Bit7_Mario_On_Off
	LDA _Bit7_Mario_Invincibility
	AND #127
	STA _Bit7_Mario_Invincibility
 jsr .__Set_Up_Mario

.
 ; 

.L0212 ;  if y  =  3 then pfscore2  =  0  :  goto __Finish_Check

	LDA y
	CMP #3
     BNE .skipL0212
.condpart88
	LDA #0
	STA pfscore2
 jmp .__Finish_Check

.skipL0212
.
 ; 

.L0213 ;  goto __1Up

 jmp .__1Up

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Fix_Mario
 ; __Fix_Mario

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0214 ;  if _Bit0_Player_Facing_Direction{0} then player0x  =   ( x  *  4 )   +  21 else player0x  =   ( x  *  4 )   +  9

	LDA _Bit0_Player_Facing_Direction
	LSR
	BCC .skipL0214
.condpart89
; complex statement detected
	LDA x
	asl
	asl
	CLC
	ADC #21
	STA player0x
 jmp .skipelse11
.skipL0214
; complex statement detected
	LDA x
	asl
	asl
	CLC
	ADC #9
	STA player0x
.skipelse11
.
 ; 

.L0215 ;  _Momentum_Left_Right  =  0

	LDA #0
	STA _Momentum_Left_Right
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Finish_Check
 ; __Finish_Check

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0216 ;  if ballx  >  0 then u  =  bally  :  bally  =  120

	LDA #0
	CMP ballx
     BCS .skipL0216
.condpart90
	LDA bally
	STA u
	LDA #120
	STA bally
.skipL0216
.
 ; 

.L0217 ;  if _Object_Scroll_In_Data  >  0  &&  _Bit0_Player_Facing_Direction{0}  &&  player1x  >  0 then player1x  =  player1x  +  4

	LDA #0
	CMP _Object_Scroll_In_Data
     BCS .skipL0217
.condpart91
	LDA _Bit0_Player_Facing_Direction
	LSR
	BCC .skip91then
.condpart92
	LDA #0
	CMP player1x
     BCS .skip92then
.condpart93
	LDA player1x
	CLC
	ADC #4
	STA player1x
.skip92then
.skip91then
.skipL0217
.
 ; 

.L0218 ;  if _Object_Scroll_In_Data  >  0  &&  !_Bit0_Player_Facing_Direction{0}  &&  player1x  >  0 then player1x  =  player1x  -  4

	LDA #0
	CMP _Object_Scroll_In_Data
     BCS .skipL0218
.condpart94
	LDA _Bit0_Player_Facing_Direction
	LSR
	BCS .skip94then
.condpart95
	LDA #0
	CMP player1x
     BCS .skip95then
.condpart96
	LDA player1x
	SEC
	SBC #4
	STA player1x
.skip95then
.skip94then
.skipL0218
.
 ; 

.L0219 ;  if _Moving_Shell_X_Coordinate  >  0  ||  _Moving_Shell_Y_Coordinate  >  0 then gosub __Redraw_Shell

	LDA #0
	CMP _Moving_Shell_X_Coordinate
     BCS .skipL0219
.condpart97
 jmp .condpart98
.skipL0219
	LDA #0
	CMP _Moving_Shell_Y_Coordinate
     BCS .skip30OR
.condpart98
 jsr .__Redraw_Shell

.skip30OR
.
 ; 

.L0220 ;  gosub __Render_Screen

 jsr .__Render_Screen

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0221 ;  goto __Fireball_Enemy_Routine bank2

 sta temp7
 lda #>(.__Fireball_Enemy_Routine-1)
 pha
 lda #<(.__Fireball_Enemy_Routine-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #2
 jmp BS_jsr
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Redraw_Shell
 ; __Redraw_Shell

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0222 ;  gosub __Render_Screen

 jsr .__Render_Screen

.
 ; 

.L0223 ;  if _Object_Scroll_In_Data  >  0  &&  _Bit0_Player_Facing_Direction{0} then _Moving_Shell_X_Coordinate  =  _Moving_Shell_X_Coordinate  +  1

	LDA #0
	CMP _Object_Scroll_In_Data
     BCS .skipL0223
.condpart99
	LDA _Bit0_Player_Facing_Direction
	LSR
	BCC .skip99then
.condpart100
	INC _Moving_Shell_X_Coordinate
.skip99then
.skipL0223
.
 ; 

.L0224 ;  if _Object_Scroll_In_Data  >  0  &&  !_Bit0_Player_Facing_Direction{0} then _Moving_Shell_X_Coordinate  =  _Moving_Shell_X_Coordinate  -  1

	LDA #0
	CMP _Object_Scroll_In_Data
     BCS .skipL0224
.condpart101
	LDA _Bit0_Player_Facing_Direction
	LSR
	BCS .skip101then
.condpart102
	DEC _Moving_Shell_X_Coordinate
.skip101then
.skipL0224
.
 ; 

.L0225 ;  if _Moving_Shell_X_Coordinate  <  0  ||  _Moving_Shell_X_Coordinate  >  30 then _Moving_Shell_X_Coordinate  =  0  :  _Moving_Shell_Y_Coordinate  =  0  :  return

	LDA _Moving_Shell_X_Coordinate
	CMP #0
     BCS .skipL0225
.condpart103
 jmp .condpart104
.skipL0225
	LDA #30
	CMP _Moving_Shell_X_Coordinate
     BCS .skip33OR
.condpart104
	LDA #0
	STA _Moving_Shell_X_Coordinate
	STA _Moving_Shell_Y_Coordinate
	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.skip33OR
.
 ; 

.L0226 ;  pfpixel _Moving_Shell_X_Coordinate _Moving_Shell_Y_Coordinate on

	LDX #0
	LDY _Moving_Shell_Y_Coordinate
	LDA _Moving_Shell_X_Coordinate
 sta temp7
 lda #>(ret_point13-1)
 pha
 lda #<(ret_point13-1)
 pha
 lda #>(pfpixel-1)
 pha
 lda #<(pfpixel-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #8
 jmp BS_jsr
ret_point13
.
 ; 

.L0227 ;  x  =  _Moving_Shell_X_Coordinate  +  1

	LDA _Moving_Shell_X_Coordinate
	CLC
	ADC #1
	STA x
.
 ; 

.L0228 ;  pfpixel x _Moving_Shell_Y_Coordinate on

	LDX #0
	LDY _Moving_Shell_Y_Coordinate
	LDA x
 sta temp7
 lda #>(ret_point14-1)
 pha
 lda #<(ret_point14-1)
 pha
 lda #>(pfpixel-1)
 pha
 lda #<(pfpixel-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #8
 jmp BS_jsr
ret_point14
.
 ; 

.L0229 ;  return thisbank

	RTS
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Set_Up_Mario
 ; __Set_Up_Mario

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0230 ;  if _Bit7_Mario_Invincibility{7}  &&  _Bit7_Mario_On_Off{7} then _Bit7_Mario_On_Off{7}  =  0  :  gosub __No_Mario  :  return

	BIT _Bit7_Mario_Invincibility
	BPL .skipL0230
.condpart105
	BIT _Bit7_Mario_On_Off
	BPL .skip105then
.condpart106
	LDA _Bit7_Mario_On_Off
	AND #127
	STA _Bit7_Mario_On_Off
 jsr .__No_Mario
	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.skip105then
.skipL0230
.
 ; 

.L0231 ;  if _Bit7_Mario_Invincibility{7}  &&  !_Bit7_Mario_On_Off{7} then _Bit7_Mario_On_Off{7}  =  1

	BIT _Bit7_Mario_Invincibility
	BPL .skipL0231
.condpart107
	BIT _Bit7_Mario_On_Off
	BMI .skip107then
.condpart108
	LDA _Bit7_Mario_On_Off
	ORA #128
	STA _Bit7_Mario_On_Off
.skip107then
.skipL0231
.
 ; 

.L0232 ;  if _Animation_Timer  >  3 then x  =  1 else x  =  0

	LDA #3
	CMP _Animation_Timer
     BCS .skipL0232
.condpart109
	LDA #1
	STA x
 jmp .skipelse12
.skipL0232
	LDA #0
	STA x
.skipelse12
.
 ; 

.L0233 ;  if _Momentum_Left_Right  =  0 then x  =  0

	LDA _Momentum_Left_Right
	CMP #0
     BNE .skipL0233
.condpart110
	LDA #0
	STA x
.skipL0233
.
 ; 

.L0234 ;  if _Bit5_Ducking_Flag{5} then x  =  3

	LDA _Bit5_Ducking_Flag
	AND #32
	BEQ .skipL0234
.condpart111
	LDA #3
	STA x
.skipL0234
.
 ; 

.L0235 ;  if _Bit1_Jumping_Flag{1}  ||  _Momentum_Up_Down  >  0 then x  =  2

	LDA _Bit1_Jumping_Flag
	AND #2
	BEQ .skipL0235
.condpart112
 jmp .condpart113
.skipL0235
	LDA #0
	CMP _Momentum_Up_Down
     BCS .skip36OR
.condpart113
	LDA #2
	STA x
.skip36OR
.
 ; 

.L0236 ;  if _Bit6_Regular_Mario{6} then goto __Small_Mario

	BIT _Bit6_Regular_Mario
	BVC .skipL0236
.condpart114
 jmp .__Small_Mario

.skipL0236
.
 ; 

.L0237 ;  if _Bit3_Super_Mario_Power{3} then goto __Big_Mario_Color

	LDA _Bit3_Super_Mario_Power
	AND #8
	BEQ .skipL0237
.condpart115
 jmp .__Big_Mario_Color

.skipL0237
.
 ; 

.L0238 ;  on x gosub __Fire_Mario_Color __Fire_Mario_Color __Fire_Mario_Jump_Color __Fire_Mario_Duck_Color

	lda #>(ongosub0-1)
	PHA
	lda #<(ongosub0-1)
	PHA
	LDX x
	LDA .L0238jumptablehi,x
	PHA
	LDA .L0238jumptablelo,x
	PHA
	RTS
.L0238jumptablehi
	.byte >(.__Fire_Mario_Color-1)
	.byte >(.__Fire_Mario_Color-1)
	.byte >(.__Fire_Mario_Jump_Color-1)
	.byte >(.__Fire_Mario_Duck_Color-1)
.L0238jumptablelo
	.byte <(.__Fire_Mario_Color-1)
	.byte <(.__Fire_Mario_Color-1)
	.byte <(.__Fire_Mario_Jump_Color-1)
	.byte <(.__Fire_Mario_Duck_Color-1)
ongosub0
.
 ; 

.L0239 ;  goto __Big_Mario_Sprite

 jmp .__Big_Mario_Sprite

.
 ; 

.__Big_Mario_Color
 ; __Big_Mario_Color

.L0240 ;  on x gosub __Super_Mario_Color __Super_Mario_Color __Super_Mario_Jump_Color __Mario_Duck_Color

	lda #>(ongosub1-1)
	PHA
	lda #<(ongosub1-1)
	PHA
	LDX x
	LDA .L0240jumptablehi,x
	PHA
	LDA .L0240jumptablelo,x
	PHA
	RTS
.L0240jumptablehi
	.byte >(.__Super_Mario_Color-1)
	.byte >(.__Super_Mario_Color-1)
	.byte >(.__Super_Mario_Jump_Color-1)
	.byte >(.__Mario_Duck_Color-1)
.L0240jumptablelo
	.byte <(.__Super_Mario_Color-1)
	.byte <(.__Super_Mario_Color-1)
	.byte <(.__Super_Mario_Jump_Color-1)
	.byte <(.__Mario_Duck_Color-1)
ongosub1
.
 ; 

.__Big_Mario_Sprite
 ; __Big_Mario_Sprite

.L0241 ;  on x gosub __Super_Mario __Super_Mario_02 __Super_Mario_Jump __Mario_Duck

	lda #>(ongosub2-1)
	PHA
	lda #<(ongosub2-1)
	PHA
	LDX x
	LDA .L0241jumptablehi,x
	PHA
	LDA .L0241jumptablelo,x
	PHA
	RTS
.L0241jumptablehi
	.byte >(.__Super_Mario-1)
	.byte >(.__Super_Mario_02-1)
	.byte >(.__Super_Mario_Jump-1)
	.byte >(.__Mario_Duck-1)
.L0241jumptablelo
	.byte <(.__Super_Mario-1)
	.byte <(.__Super_Mario_02-1)
	.byte <(.__Super_Mario_Jump-1)
	.byte <(.__Mario_Duck-1)
ongosub2
.
 ; 

.L0242 ;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ; 

.__Small_Mario
 ; __Small_Mario

.L0243 ;  on x gosub __Mario_Color __Mario_Color __Mario_Jump_Color __Mario_Color

	lda #>(ongosub3-1)
	PHA
	lda #<(ongosub3-1)
	PHA
	LDX x
	LDA .L0243jumptablehi,x
	PHA
	LDA .L0243jumptablelo,x
	PHA
	RTS
.L0243jumptablehi
	.byte >(.__Mario_Color-1)
	.byte >(.__Mario_Color-1)
	.byte >(.__Mario_Jump_Color-1)
	.byte >(.__Mario_Color-1)
.L0243jumptablelo
	.byte <(.__Mario_Color-1)
	.byte <(.__Mario_Color-1)
	.byte <(.__Mario_Jump_Color-1)
	.byte <(.__Mario_Color-1)
ongosub3
.
 ; 

.L0244 ;  on x gosub __Mario __Mario2 __Mario_Jump __Mario

	lda #>(ongosub4-1)
	PHA
	lda #<(ongosub4-1)
	PHA
	LDX x
	LDA .L0244jumptablehi,x
	PHA
	LDA .L0244jumptablelo,x
	PHA
	RTS
.L0244jumptablehi
	.byte >(.__Mario-1)
	.byte >(.__Mario2-1)
	.byte >(.__Mario_Jump-1)
	.byte >(.__Mario-1)
.L0244jumptablelo
	.byte <(.__Mario-1)
	.byte <(.__Mario2-1)
	.byte <(.__Mario_Jump-1)
	.byte <(.__Mario-1)
ongosub4
.
 ; 

.L0245 ;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ; 

.__Power_Up_SFX
 ; __Power_Up_SFX

.
 ; 

.L0246 ;  y  =  y  -  1  :  _Temp_u_Freq  =  _Temp_u_Freq  +  1

	DEC y
	INC _Temp_u_Freq
.
 ; 

.L0247 ;  if _Temp_u_Freq  >  21 then y  =  y  +  18  :  _Temp_u_Freq  =  0

	LDA #21
	CMP _Temp_u_Freq
     BCS .skipL0247
.condpart116
	LDA y
	CLC
	ADC #18
	STA y
	LDA #0
	STA _Temp_u_Freq
.skipL0247
.
 ; 

.L0248 ;  AUDV0  =  8  :  AUDC0  =  4  :  AUDF0  =  y  :  AUDV1  =  0

	LDA #8
	STA AUDV0
	LDA #4
	STA AUDC0
	LDA y
	STA AUDF0
	LDA #0
	STA AUDV1
.
 ; 

.L0249 ;  return thisbank

	RTS
.
 ; 

.__Power_Down_SFX
 ; __Power_Down_SFX

.
 ; 

.L0250 ;  y  =  y  +  1

	INC y
.
 ; 

.L0251 ;  temp4  =  8

	LDA #8
	STA temp4
.
 ; 

.L0252 ;  if _Temp_u_Freq  >  6 then y  =  8  :  _Temp_u_Freq  =  0

	LDA #6
	CMP _Temp_u_Freq
     BCS .skipL0252
.condpart117
	LDA #8
	STA y
	LDA #0
	STA _Temp_u_Freq
.skipL0252
.
 ; 

.L0253 ;  if y  >  30 then _Temp_u_Freq  =  _Temp_u_Freq  +  1  :  y  =  9  :  temp4  =  8  -  _Temp_u_Freq

	LDA #30
	CMP y
     BCS .skipL0253
.condpart118
	INC _Temp_u_Freq
	LDA #9
	STA y
	LDA #8
	SEC
	SBC _Temp_u_Freq
	STA temp4
.skipL0253
.
 ; 

.L0254 ;  AUDV0  =  temp4  :  AUDC0  =  6  :  AUDF0  =  y  :  AUDV1  =  0

	LDA temp4
	STA AUDV0
	LDA #6
	STA AUDC0
	LDA y
	STA AUDF0
	LDA #0
	STA AUDV1
.
 ; 

.L0255 ;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ; 

.__1Up_SFX
 ; __1Up_SFX

.
 ; 

.L0256 ;  y  =  y  -  2  :  _Temp_u_Freq  =  _Temp_u_Freq  +  1

	LDA y
	SEC
	SBC #2
	STA y
	INC _Temp_u_Freq
.
 ; 

.L0257 ;  if _Temp_u_Freq  =  4 then _Temp_u_Freq  =  0  :  y  =  7

	LDA _Temp_u_Freq
	CMP #4
     BNE .skipL0257
.condpart119
	LDA #0
	STA _Temp_u_Freq
	LDA #7
	STA y
.skipL0257
.
 ; 

.L0258 ;  AUDV0  =  8  :  AUDC0  =  4  :  AUDF0  =  y  :  AUDV1  =  0

	LDA #8
	STA AUDV0
	LDA #4
	STA AUDC0
	LDA y
	STA AUDF0
	LDA #0
	STA AUDV1
.
 ; 

.L0259 ;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Scroll_Left
 ; __Scroll_Left

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0260 ;  pfscroll left

	LDA #0
 sta temp7
 lda #>(ret_point15-1)
 pha
 lda #<(ret_point15-1)
 pha
 lda #>(pfscroll-1)
 pha
 lda #<(pfscroll-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #8
 jmp BS_jsr
ret_point15
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0261 ;  if ballx  >  0 then ballx  =  ballx  -  4

	LDA #0
	CMP ballx
     BCS .skipL0261
.condpart120
	LDA ballx
	SEC
	SBC #4
	STA ballx
.skipL0261
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0262 ;  x  =  _Level_Data_Pointer  *  2

	LDA _Level_Data_Pointer
	asl
	STA x
.
 ; 

.L0263 ;  if x  >  _Farthest_Traveled_On_Level then _Farthest_Traveled_On_Level  =  x

	LDA _Farthest_Traveled_On_Level
	CMP x
     BCS .skipL0263
.condpart121
	LDA x
	STA _Farthest_Traveled_On_Level
.skipL0263
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0264 ;  z  =   (  ( _World  -  1 )   *  8 )   +   (  ( _Level  -  1 )   *  2 ) 

; complex statement detected
	LDA _World
	SEC
	SBC #1
	asl
	asl
	asl
	PHA
	LDA _Level
	SEC
	SBC #1
	asl
	TSX
	INX
	TXS
	CLC
	ADC $00,x
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

.L0265 ;  if _Bit6_Checkpoint_Flag{6} then z  =  z  +  1

	BIT _Bit6_Checkpoint_Flag
	BVC .skipL0265
.condpart122
	INC z
.skipL0265
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0266 ;  if z  <  16 then gosub __Level_Data_Bank1 bank5 else gosub __Level_Data_Bank2 bank6

	LDA z
	CMP #16
     BCS .skipL0266
.condpart123
 sta temp7
 lda #>(ret_point16-1)
 pha
 lda #<(ret_point16-1)
 pha
 lda #>(.__Level_Data_Bank1-1)
 pha
 lda #<(.__Level_Data_Bank1-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #5
 jmp BS_jsr
ret_point16
 jmp .skipelse13
.skipL0266
 sta temp7
 lda #>(ret_point17-1)
 pha
 lda #<(ret_point17-1)
 pha
 lda #>(.__Level_Data_Bank2-1)
 pha
 lda #<(.__Level_Data_Bank2-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #6
 jmp BS_jsr
ret_point17
.skipelse13
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0267 ;  if y{0} then var3  =  var3  |  128 else var3  =  var3  &  127

	LDA y
	LSR
	BCC .skipL0267
.condpart124
	LDA var3
	ORA #128
	STA var3
 jmp .skipelse14
.skipL0267
	LDA var3
	AND #127
	STA var3
.skipelse14
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0268 ;  if _Farthest_Traveled_On_Level  >  x  &&  _Level  =  1 then var7  =  var7  &  127  :  goto __Render_1

	LDA x
	CMP _Farthest_Traveled_On_Level
     BCS .skipL0268
.condpart125
	LDA _Level
	CMP #1
     BNE .skip125then
.condpart126
	LDA var7
	AND #127
	STA var7
 jmp .__Render_1

.skip125then
.skipL0268
.
 ; 

.L0269 ;  if y{1} then var7  =  var7  |  128 else var7  =  var7  &  127

	LDA y
	AND #2
	BEQ .skipL0269
.condpart127
	LDA var7
	ORA #128
	STA var7
 jmp .skipelse15
.skipL0269
	LDA var7
	AND #127
	STA var7
.skipelse15
.
 ; 

.__Render_1
 ; __Render_1

.
 ; 

.L0270 ;  if y{2} then var11  =  var11  |  128 else var11  =  var11  &  127

	LDA y
	AND #4
	BEQ .skipL0270
.condpart128
	LDA var11
	ORA #128
	STA var11
 jmp .skipelse16
.skipL0270
	LDA var11
	AND #127
	STA var11
.skipelse16
.
 ; 

.L0271 ;  if y{3} then var15  =  var15  |  128 else var15  =  var15  &  127

	LDA y
	AND #8
	BEQ .skipL0271
.condpart129
	LDA var15
	ORA #128
	STA var15
 jmp .skipelse17
.skipL0271
	LDA var15
	AND #127
	STA var15
.skipelse17
.
 ; 

.L0272 ;  if y{4} then var19  =  var19  |  128 else var19  =  var19  &  127

	LDA y
	AND #16
	BEQ .skipL0272
.condpart130
	LDA var19
	ORA #128
	STA var19
 jmp .skipelse18
.skipL0272
	LDA var19
	AND #127
	STA var19
.skipelse18
.
 ; 

.L0273 ;  if y{5} then var23  =  var23  |  128 else var23  =  var23  &  127

	LDA y
	AND #32
	BEQ .skipL0273
.condpart131
	LDA var23
	ORA #128
	STA var23
 jmp .skipelse19
.skipL0273
	LDA var23
	AND #127
	STA var23
.skipelse19
.
 ; 

.L0274 ;  if _Farthest_Traveled_On_Level  >  x  &&  _Level  <  3 then var27  =  var27  &  127  :  goto __Render_2

	LDA x
	CMP _Farthest_Traveled_On_Level
     BCS .skipL0274
.condpart132
	LDA _Level
	CMP #3
     BCS .skip132then
.condpart133
	LDA var27
	AND #127
	STA var27
 jmp .__Render_2

.skip132then
.skipL0274
.
 ; 

.L0275 ;  if y{6} then var27  =  var27  |  128 else var27  =  var27  &  127

	BIT y
	BVC .skipL0275
.condpart134
	LDA var27
	ORA #128
	STA var27
 jmp .skipelse20
.skipL0275
	LDA var27
	AND #127
	STA var27
.skipelse20
.
 ; 

.__Render_2
 ; __Render_2

.
 ; 

.L0276 ;  if y{7} then var31  =  var31  |  128 else var31  =  var31  &  127

	BIT y
	BPL .skipL0276
.condpart135
	LDA var31
	ORA #128
	STA var31
 jmp .skipelse21
.skipL0276
	LDA var31
	AND #127
	STA var31
.skipelse21
.
 ; 

.L0277 ;  if u{0} then var35  =  var35  |  128 else var35  =  var35  &  127

	LDA u
	LSR
	BCC .skipL0277
.condpart136
	LDA var35
	ORA #128
	STA var35
 jmp .skipelse22
.skipL0277
	LDA var35
	AND #127
	STA var35
.skipelse22
.
 ; 

.L0278 ;  if u{1} then var39  =  var39  |  128 else var39  =  var39  &  127

	LDA u
	AND #2
	BEQ .skipL0278
.condpart137
	LDA var39
	ORA #128
	STA var39
 jmp .skipelse23
.skipL0278
	LDA var39
	AND #127
	STA var39
.skipelse23
.
 ; 

.L0279 ;  if u{2} then var43  =  var43  |  128 else var43  =  var43  &  127

	LDA u
	AND #4
	BEQ .skipL0279
.condpart138
	LDA var43
	ORA #128
	STA var43
 jmp .skipelse24
.skipL0279
	LDA var43
	AND #127
	STA var43
.skipelse24
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0280 ;  if u{3} then _Object_Scroll_In_Data  =  u else _Object_Scroll_In_Data  =  1

	LDA u
	AND #8
	BEQ .skipL0280
.condpart139
	LDA u
	STA _Object_Scroll_In_Data
 jmp .skipelse25
.skipL0280
	LDA #1
	STA _Object_Scroll_In_Data
.skipelse25
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0281 ;  _Level_Data_Pointer  =  _Level_Data_Pointer  +  1

	INC _Level_Data_Pointer
.
 ; 

.L0282 ;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Scroll_Right
 ; __Scroll_Right

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0283 ;  pfscroll right

	LDA #1
 sta temp7
 lda #>(ret_point18-1)
 pha
 lda #<(ret_point18-1)
 pha
 lda #>(pfscroll-1)
 pha
 lda #<(pfscroll-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #8
 jmp BS_jsr
ret_point18
.
 ; 

.L0284 ;  if ballx  >  0 then ballx  =  ballx  +  4

	LDA #0
	CMP ballx
     BCS .skipL0284
.condpart140
	LDA ballx
	CLC
	ADC #4
	STA ballx
.skipL0284
.
 ; 

.L0285 ;  x  =   ( _Level_Data_Pointer  -  32 )   *  2

; complex statement detected
	LDA _Level_Data_Pointer
	SEC
	SBC #32
	asl
	STA x
.
 ; 

.L0286 ;  z  =   (  ( _World  -  1 )   *  8 )   +   (  ( _Level  -  1 )   *  2 ) 

; complex statement detected
	LDA _World
	SEC
	SBC #1
	asl
	asl
	asl
	PHA
	LDA _Level
	SEC
	SBC #1
	asl
	TSX
	INX
	TXS
	CLC
	ADC $00,x
	STA z
.
 ; 

.L0287 ;  if _Bit6_Checkpoint_Flag{6} then z  =  z  +  1

	BIT _Bit6_Checkpoint_Flag
	BVC .skipL0287
.condpart141
	INC z
.skipL0287
.
 ; 

.L0288 ;  if z  <  16 then gosub __Level_Data_Bank1 bank5 else gosub __Level_Data_Bank2 bank6

	LDA z
	CMP #16
     BCS .skipL0288
.condpart142
 sta temp7
 lda #>(ret_point19-1)
 pha
 lda #<(ret_point19-1)
 pha
 lda #>(.__Level_Data_Bank1-1)
 pha
 lda #<(.__Level_Data_Bank1-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #5
 jmp BS_jsr
ret_point19
 jmp .skipelse26
.skipL0288
 sta temp7
 lda #>(ret_point20-1)
 pha
 lda #<(ret_point20-1)
 pha
 lda #>(.__Level_Data_Bank2-1)
 pha
 lda #<(.__Level_Data_Bank2-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #6
 jmp BS_jsr
ret_point20
.skipelse26
.
 ; 

.L0289 ;  if y{0} then var0  =  var0  |  128 else var0  =  var0  &  127

	LDA y
	LSR
	BCC .skipL0289
.condpart143
	LDA var0
	ORA #128
	STA var0
 jmp .skipelse27
.skipL0289
	LDA var0
	AND #127
	STA var0
.skipelse27
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0290 ;  if _Level  =  1  &&  _Animation_Timer  <>  250 then var4  =  var4  &  127  :  goto __Render_3

	LDA _Level
	CMP #1
     BNE .skipL0290
.condpart144
	LDA _Animation_Timer
	CMP #250
     BEQ .skip144then
.condpart145
	LDA var4
	AND #127
	STA var4
 jmp .__Render_3

.skip144then
.skipL0290
.
 ; 

.L0291 ;  if y{1} then var4  =  var4  |  128 else var4  =  var4  &  127

	LDA y
	AND #2
	BEQ .skipL0291
.condpart146
	LDA var4
	ORA #128
	STA var4
 jmp .skipelse28
.skipL0291
	LDA var4
	AND #127
	STA var4
.skipelse28
.
 ; 

.__Render_3
 ; __Render_3

.
 ; 

.L0292 ;  if y{2} then var8  =  var8  |  128 else var8  =  var8  &  127

	LDA y
	AND #4
	BEQ .skipL0292
.condpart147
	LDA var8
	ORA #128
	STA var8
 jmp .skipelse29
.skipL0292
	LDA var8
	AND #127
	STA var8
.skipelse29
.
 ; 

.L0293 ;  if y{3} then var12  =  var12  |  128 else var12  =  var12  &  127

	LDA y
	AND #8
	BEQ .skipL0293
.condpart148
	LDA var12
	ORA #128
	STA var12
 jmp .skipelse30
.skipL0293
	LDA var12
	AND #127
	STA var12
.skipelse30
.
 ; 

.L0294 ;  if y{4} then var16  =  var16  |  128 else var16  =  var16  &  127

	LDA y
	AND #16
	BEQ .skipL0294
.condpart149
	LDA var16
	ORA #128
	STA var16
 jmp .skipelse31
.skipL0294
	LDA var16
	AND #127
	STA var16
.skipelse31
.
 ; 

.L0295 ;  if y{5} then var20  =  var20  |  128 else var20  =  var20  &  127

	LDA y
	AND #32
	BEQ .skipL0295
.condpart150
	LDA var20
	ORA #128
	STA var20
 jmp .skipelse32
.skipL0295
	LDA var20
	AND #127
	STA var20
.skipelse32
.
 ; 

.L0296 ;  if _Level  <  3  &&  _Animation_Timer  <>  250 then var24  =  var24  &  127  :  goto __Render_4

	LDA _Level
	CMP #3
     BCS .skipL0296
.condpart151
	LDA _Animation_Timer
	CMP #250
     BEQ .skip151then
.condpart152
	LDA var24
	AND #127
	STA var24
 jmp .__Render_4

.skip151then
.skipL0296
.
 ; 

.L0297 ;  if y{6} then var24  =  var24  |  128 else var24  =  var24  &  127

	BIT y
	BVC .skipL0297
.condpart153
	LDA var24
	ORA #128
	STA var24
 jmp .skipelse33
.skipL0297
	LDA var24
	AND #127
	STA var24
.skipelse33
.
 ; 

.__Render_4
 ; __Render_4

.
 ; 

.L0298 ;  if y{7} then var28  =  var28  |  128 else var28  =  var28  &  127

	BIT y
	BPL .skipL0298
.condpart154
	LDA var28
	ORA #128
	STA var28
 jmp .skipelse34
.skipL0298
	LDA var28
	AND #127
	STA var28
.skipelse34
.
 ; 

.L0299 ;  if u{0} then var32  =  var32  |  128 else var32  =  var32  &  127

	LDA u
	LSR
	BCC .skipL0299
.condpart155
	LDA var32
	ORA #128
	STA var32
 jmp .skipelse35
.skipL0299
	LDA var32
	AND #127
	STA var32
.skipelse35
.
 ; 

.L0300 ;  if u{1} then var36  =  var36  |  128 else var36  =  var36  &  127

	LDA u
	AND #2
	BEQ .skipL0300
.condpart156
	LDA var36
	ORA #128
	STA var36
 jmp .skipelse36
.skipL0300
	LDA var36
	AND #127
	STA var36
.skipelse36
.
 ; 

.L0301 ;  if u{2} then var40  =  var40  |  128 else var40  =  var40  &  127

	LDA u
	AND #4
	BEQ .skipL0301
.condpart157
	LDA var40
	ORA #128
	STA var40
 jmp .skipelse37
.skipL0301
	LDA var40
	AND #127
	STA var40
.skipelse37
.
 ; 

.L0302 ;  if u{3} then _Object_Scroll_In_Data  =  u else _Object_Scroll_In_Data  =  1

	LDA u
	AND #8
	BEQ .skipL0302
.condpart158
	LDA u
	STA _Object_Scroll_In_Data
 jmp .skipelse38
.skipL0302
	LDA #1
	STA _Object_Scroll_In_Data
.skipelse38
.
 ; 

.L0303 ;  _Level_Data_Pointer  =  _Level_Data_Pointer  -  1

	DEC _Level_Data_Pointer
.
 ; 

.L0304 ;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Render_Screen
 ; __Render_Screen

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0305 ;  if _Level  =  1  ||  _Level  =  3 then COLUPF  =  $32 else COLUPF  =  $04

	LDA _Level
	CMP #1
     BNE .skipL0305
.condpart159
 jmp .condpart160
.skipL0305
	LDA _Level
	CMP #3
     BNE .skip41OR
.condpart160
	LDA #$32
	STA COLUPF
 jmp .skipelse39
.skip41OR
	LDA #$04
	STA COLUPF
.skipelse39
.
 ; 

.L0306 ;  if _Level  =  2 then COLUPF  =  $A4

	LDA _Level
	CMP #2
     BNE .skipL0306
.condpart161
	LDA #$A4
	STA COLUPF
.skipL0306
.
 ; 

.L0307 ;  if _Enemy_Type  =  _Kinetic_Platforms  &&  !_Bit7_2nd_Quest{7} then NUSIZ1  =  $17  :  goto __Finish_Render

	LDA _Enemy_Type
	CMP #_Kinetic_Platforms
     BNE .skipL0307
.condpart162
	BIT _Bit7_2nd_Quest
	BMI .skip162then
.condpart163
	LDA #$17
	STA NUSIZ1
 jmp .__Finish_Render

.skip162then
.skipL0307
.
 ; 

.L0308 ;  if _Enemy_Type  =  _Kinetic_Platforms  &&  _Bit7_2nd_Quest{7} then NUSIZ1  =  $15  :  goto __Finish_Render

	LDA _Enemy_Type
	CMP #_Kinetic_Platforms
     BNE .skipL0308
.condpart164
	BIT _Bit7_2nd_Quest
	BPL .skip164then
.condpart165
	LDA #$15
	STA NUSIZ1
 jmp .__Finish_Render

.skip164then
.skipL0308
.
 ; 

.L0309 ;  if _Enemy_Type  =  _Thwomp  ||  _Enemy_Type  =  _Bowser_Jr then NUSIZ1  =  $15  :  goto __Finish_Render

	LDA _Enemy_Type
	CMP #_Thwomp
     BNE .skipL0309
.condpart166
 jmp .condpart167
.skipL0309
	LDA _Enemy_Type
	CMP #_Bowser_Jr
     BNE .skip44OR
.condpart167
	LDA #$15
	STA NUSIZ1
 jmp .__Finish_Render

.skip44OR
.
 ; 

.L0310 ;  if _Enemy_Type  =  _Bullet_Bill then NUSIZ1  =  $15  :  goto __Finish_Render

	LDA _Enemy_Type
	CMP #_Bullet_Bill
     BNE .skipL0310
.condpart168
	LDA #$15
	STA NUSIZ1
 jmp .__Finish_Render

.skipL0310
.
 ; 

.L0311 ;  if _Enemy_Type  =  _Two_Goombas  &&  player1x  <  122 then NUSIZ1  =  $11  :  goto __Finish_Render

	LDA _Enemy_Type
	CMP #_Two_Goombas
     BNE .skipL0311
.condpart169
	LDA player1x
	CMP #122
     BCS .skip169then
.condpart170
	LDA #$11
	STA NUSIZ1
 jmp .__Finish_Render

.skip169then
.skipL0311
.
 ; 

.L0312 ;  if _Enemy_Type  =  _Two_Spineys  &&  player1x  <  122 then NUSIZ1  =  $11  :  goto __Finish_Render

	LDA _Enemy_Type
	CMP #_Two_Spineys
     BNE .skipL0312
.condpart171
	LDA player1x
	CMP #122
     BCS .skip171then
.condpart172
	LDA #$11
	STA NUSIZ1
 jmp .__Finish_Render

.skip171then
.skipL0312
.
 ; 

.L0313 ;  if _Enemy_Type  =  _Two_Thwomps  &&  player1x  <  106 then NUSIZ1  =  $12

	LDA _Enemy_Type
	CMP #_Two_Thwomps
     BNE .skipL0313
.condpart173
	LDA player1x
	CMP #106
     BCS .skip173then
.condpart174
	LDA #$12
	STA NUSIZ1
.skip173then
.skipL0313
.
 ; 

.__Finish_Render
 ; __Finish_Render

.
 ; 

.L0314 ;  if _Bit0_Player_Facing_Direction{0} then REFP0  =  8 else REFP0  =  0

	LDA _Bit0_Player_Facing_Direction
	LSR
	BCC .skipL0314
.condpart175
	LDA #8
	STA REFP0
 jmp .skipelse40
.skipL0314
	LDA #0
	STA REFP0
.skipelse40
.
 ; 

.L0315 ;  if _Bit3_Enemy_Direction{3} then REFP1  =  8 else REFP1  =  0

	LDA _Bit3_Enemy_Direction
	AND #8
	BEQ .skipL0315
.condpart176
	LDA #8
	STA REFP1
 jmp .skipelse41
.skipL0315
	LDA #0
	STA REFP1
.skipelse41
.
 ; 

.L0316 ;  drawscreen

 sta temp7
 lda #>(ret_point21-1)
 pha
 lda #<(ret_point21-1)
 pha
 lda #>(drawscreen-1)
 pha
 lda #<(drawscreen-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #8
 jmp BS_jsr
ret_point21
.
 ; 

.L0317 ;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Mario_Color
 ; __Mario_Color

.L0318 ;  player0color:

	LDX #<playercolorL0318_0
	STX player0color
	LDA #>playercolorL0318_0
	STA player0color+1
.L0319 ;  return thisbank

	RTS
.
 ; 

.__Mario_Jump_Color
 ; __Mario_Jump_Color

.L0320 ;  player0color:

	LDX #<playercolorL0320_0
	STX player0color
	LDA #>playercolorL0320_0
	STA player0color+1
.L0321 ;  return thisbank

	RTS
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Mario
 ; __Mario

.L0322 ;  player0:

	LDX #<playerL0322_0
	STX player0pointerlo
	LDA #>playerL0322_0
	STA player0pointerhi
	LDA #12
	STA player0height
.L0323 ;  return thisbank

	RTS
.
 ; 

.__Mario2
 ; __Mario2

.L0324 ;  player0:

	LDX #<playerL0324_0
	STX player0pointerlo
	LDA #>playerL0324_0
	STA player0pointerhi
	LDA #12
	STA player0height
.L0325 ;  return thisbank

	RTS
.
 ; 

.__Mario_Jump
 ; __Mario_Jump

.L0326 ;  player0:

	LDX #<playerL0326_0
	STX player0pointerlo
	LDA #>playerL0326_0
	STA player0pointerhi
	LDA #14
	STA player0height
.L0327 ;  return thisbank

	RTS
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Super_Mario_Color
 ; __Super_Mario_Color

.L0328 ;  player0color:

	LDX #<playercolorL0328_0
	STX player0color
	LDA #>playercolorL0328_0
	STA player0color+1
.L0329 ;  return thisbank

	RTS
.
 ; 

.__Super_Mario
 ; __Super_Mario

.L0330 ;  player0:

	LDX #<playerL0330_0
	STX player0pointerlo
	LDA #>playerL0330_0
	STA player0pointerhi
	LDA #23
	STA player0height
.L0331 ;  return thisbank

	RTS
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Fire_Mario_Color
 ; __Fire_Mario_Color

.L0332 ;  player0color:

	LDX #<playercolorL0332_0
	STX player0color
	LDA #>playercolorL0332_0
	STA player0color+1
.L0333 ;  return thisbank

	RTS
.
 ; 

.__Fire_Mario_Jump_Color
 ; __Fire_Mario_Jump_Color

.L0334 ;  player0color:

	LDX #<playercolorL0334_0
	STX player0color
	LDA #>playercolorL0334_0
	STA player0color+1
.L0335 ;  return thisbank

	RTS
.
 ; 

.__Super_Mario_02
 ; __Super_Mario_02

.L0336 ;  player0:

	LDX #<playerL0336_0
	STX player0pointerlo
	LDA #>playerL0336_0
	STA player0pointerhi
	LDA #23
	STA player0height
.L0337 ;  return thisbank

	RTS
.
 ; 

.__Super_Mario_Jump_Color
 ; __Super_Mario_Jump_Color

.L0338 ;  player0color:

	LDX #<playercolorL0338_0
	STX player0color
	LDA #>playercolorL0338_0
	STA player0color+1
.L0339 ;  return thisbank

	RTS
.
 ; 

.__Super_Mario_Jump
 ; __Super_Mario_Jump

.L0340 ;  player0:

	LDX #<playerL0340_0
	STX player0pointerlo
	LDA #>playerL0340_0
	STA player0pointerhi
	LDA #25
	STA player0height
.L0341 ;  return thisbank

	RTS
.
 ; 

.__Mario_Duck_Color
 ; __Mario_Duck_Color

.L0342 ;  player0color:

	LDX #<playercolorL0342_0
	STX player0color
	LDA #>playercolorL0342_0
	STA player0color+1
.L0343 ;  return thisbank

	RTS
.
 ; 

.__Fire_Mario_Duck_Color
 ; __Fire_Mario_Duck_Color

.L0344 ;  player0color:

	LDX #<playercolorL0344_0
	STX player0color
	LDA #>playercolorL0344_0
	STA player0color+1
.L0345 ;  return thisbank

	RTS
.
 ; 

.__Mario_Duck
 ; __Mario_Duck

.L0346 ;  player0:

	LDX #<playerL0346_0
	STX player0pointerlo
	LDA #>playerL0346_0
	STA player0pointerhi
	LDA #12
	STA player0height
.L0347 ;  return thisbank

	RTS
.
 ; 

.
 ; 

.__No_Mario
 ; __No_Mario

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0348 ;  player0:

	LDX #<playerL0348_0
	STX player0pointerlo
	LDA #>playerL0348_0
	STA player0pointerhi
	LDA #0
	STA player0height
.L0349 ;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0350 ;  bank 2

 if ECHO1
 echo "    ",[(start_bank1 - *)]d , "bytes of ROM space left in bank 1")
 endif
ECHO1 = 1
 ORG $1FF4-bscode_length
 RORG $1FF4-bscode_length
start_bank1 ldx #$ff
 ifconst FASTFETCH ; using DPC+
 stx FASTFETCH
 endif 
 txs
 if bankswitch == 64
   lda #(((>(start-1)) & $0F) | $F0)
 else
   lda #>(start-1)
 endif
 pha
 lda #<(start-1)
 pha
 pha
 txa
 pha
 tsx
 if bankswitch != 64
   lda 4,x ; get high byte of return address
   rol
   rol
   rol
   rol
   and #bs_mask ;1 3 or 7 for F8/F6/F4
   tax
   inx
 else
   lda 4,x ; get high byte of return address
   tay
   ora #$10 ; change our bank nibble into a valid rom mirror
   sta 4,x
   tya
   lsr 
   lsr 
   lsr 
   lsr 
   tax
   inx
 endif
 lda bankswitch_hotspot-1,x
 pla
 tax
 pla
 rts
 if ((* & $1FFF) > ((bankswitch_hotspot & $1FFF) - 1))
   echo "WARNING: size parameter in banksw.asm too small - the program probably will not work."
   echo "Change to",[(*-begin_bscode+1)&$FF]d,"and try again."
 endif
 ORG $1FFC
 RORG $1FFC
 .word (start_bank1 & $ffff)
 .word (start_bank1 & $ffff)
 ORG $2000
 RORG $3000
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Fireball_Enemy_Routine
 ; __Fireball_Enemy_Routine

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0351 ;  if _Object_Scroll_In_Data  >  1 then gosub __Initialize_Enemy

	LDA #1
	CMP _Object_Scroll_In_Data
     BCS .skipL0351
.condpart177
 jsr .__Initialize_Enemy

.skipL0351
.
 ; 

.L0352 ;  if ballx  >  0 then bally  =  u else goto __Enemy_Routine

	LDA #0
	CMP ballx
     BCS .skipL0352
.condpart178
	LDA u
	STA bally
 jmp .skipelse42
.skipL0352
 jmp .__Enemy_Routine

.skipelse42
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0353 ;  if _Bit2_Mario_Fireball_Direction{2} then ballx  =  ballx  +  6 else ballx  =  ballx  -  6

	LDA _Bit2_Mario_Fireball_Direction
	AND #4
	BEQ .skipL0353
.condpart179
	LDA ballx
	CLC
	ADC #6
	STA ballx
 jmp .skipelse43
.skipL0353
	LDA ballx
	SEC
	SBC #6
	STA ballx
.skipelse43
.
 ; 

.L0354 ;  bally  =  bally  +  3

	LDA bally
	CLC
	ADC #3
	STA bally
.
 ; 

.L0355 ;  if ballx  >  137 then gosub __Kill_Fireball

	LDA #137
	CMP ballx
     BCS .skipL0355
.condpart180
 jsr .__Kill_Fireball

.skipL0355
.
 ; 

.L0356 ;  if ballx  <  17 then gosub __Kill_Fireball

	LDA ballx
	CMP #17
     BCS .skipL0356
.condpart181
 jsr .__Kill_Fireball

.skipL0356
.
 ; 

.L0357 ;  if bally  >  96 then gosub __Kill_Fireball

	LDA #96
	CMP bally
     BCS .skipL0357
.condpart182
 jsr .__Kill_Fireball

.skipL0357
.
 ; 

.L0358 ;  x  =   ( ballx  -  17 )  / 4  :  y  =  bally / 8

; complex statement detected
	LDA ballx
	SEC
	SBC #17
	lsr
	lsr
	STA x
	LDA bally
	lsr
	lsr
	lsr
	STA y
.
 ; 

.L0359 ;  if pfread ( x , y )  then goto __Fireball_Collision

	LDA x
	LDY y
 sta temp7
 lda #>(ret_point22-1)
 pha
 lda #<(ret_point22-1)
 pha
 lda #>(pfread-1)
 pha
 lda #<(pfread-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #8
 jmp BS_jsr
ret_point22
	BNE .skipL0359
.condpart183
 jmp .__Fireball_Collision

.skipL0359
.
 ; 

.L0360 ;  goto __Enemy_Routine

 jmp .__Enemy_Routine

.
 ; 

.
 ; 

.__Fireball_Collision
 ; __Fireball_Collision

.
 ; 

.L0361 ;  z  =  y  -  1

	LDA y
	SEC
	SBC #1
	STA z
.
 ; 

.L0362 ;  if pfread ( x , z )  then gosub __Kill_Fireball

	LDA x
	LDY z
 sta temp7
 lda #>(ret_point23-1)
 pha
 lda #<(ret_point23-1)
 pha
 lda #>(pfread-1)
 pha
 lda #<(pfread-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #8
 jmp BS_jsr
ret_point23
	BNE .skipL0362
.condpart184
 jsr .__Kill_Fireball

.skipL0362
.
 ; 

.L0363 ;  bally  =  bally  -  6

	LDA bally
	SEC
	SBC #6
	STA bally
.
 ; 

.
 ; 

.__Enemy_Routine
 ; __Enemy_Routine

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0364 ;  if _Moving_Shell_X_Coordinate  >  0  ||  _Moving_Shell_Y_Coordinate  >  0 then gosub __Moving_Shell_Routine

	LDA #0
	CMP _Moving_Shell_X_Coordinate
     BCS .skipL0364
.condpart185
 jmp .condpart186
.skipL0364
	LDA #0
	CMP _Moving_Shell_Y_Coordinate
     BCS .skip48OR
.condpart186
 jsr .__Moving_Shell_Routine

.skip48OR
.
 ; 

.L0365 ;  if _Moving_Shell_Y_Coordinate  >  0  &&  player1x  >  0 then gosub __Render_Screen bank1

	LDA #0
	CMP _Moving_Shell_Y_Coordinate
     BCS .skipL0365
.condpart187
	LDA #0
	CMP player1x
     BCS .skip187then
.condpart188
 sta temp7
 lda #>(ret_point24-1)
 pha
 lda #<(ret_point24-1)
 pha
 lda #>(.__Render_Screen-1)
 pha
 lda #<(.__Render_Screen-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
ret_point24
.skip187then
.skipL0365
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0366 ;  if player1x  =  0 then goto __Main_Loop bank1

	LDA player1x
	CMP #0
     BNE .skipL0366
.condpart189
 sta temp7
 lda #>(.__Main_Loop-1)
 pha
 lda #<(.__Main_Loop-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
.skipL0366
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0367 ;  if player1x  >  136  ||  player1x  <  17 then gosub __Kill_Enemy  :  goto __Main_Loop bank1

	LDA #136
	CMP player1x
     BCS .skipL0367
.condpart190
 jmp .condpart191
.skipL0367
	LDA player1x
	CMP #17
     BCS .skip50OR
.condpart191
 jsr .__Kill_Enemy
 sta temp7
 lda #>(.__Main_Loop-1)
 pha
 lda #<(.__Main_Loop-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
.skip50OR
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0368 ;  if _Bit4_Enemy_Dead_Flag{4} then goto __Enemy_Death_Routine

	LDA _Bit4_Enemy_Dead_Flag
	AND #16
	BEQ .skipL0368
.condpart192
 jmp .__Enemy_Death_Routine

.skipL0368
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0369 ;  if _Enemy_Type  =  _Bowser_Jr then goto __Bowser_Jr bank4

	LDA _Enemy_Type
	CMP #_Bowser_Jr
     BNE .skipL0369
.condpart193
 sta temp7
 lda #>(.__Bowser_Jr-1)
 pha
 lda #<(.__Bowser_Jr-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
.skipL0369
.
 ; 

.L0370 ;  if _Enemy_Type  =  _Thwomp  ||  _Enemy_Type  =  _Two_Thwomps then goto __Thwomp bank8

	LDA _Enemy_Type
	CMP #_Thwomp
     BNE .skipL0370
.condpart194
 jmp .condpart195
.skipL0370
	LDA _Enemy_Type
	CMP #_Two_Thwomps
     BNE .skip51OR
.condpart195
 sta temp7
 lda #>(.__Thwomp-1)
 pha
 lda #<(.__Thwomp-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #8
 jmp BS_jsr
.skip51OR
.
 ; 

.L0371 ;  if _Enemy_Type  =  _Flying_Red_Koopa then goto __Red_Flying_Koopa

	LDA _Enemy_Type
	CMP #_Flying_Red_Koopa
     BNE .skipL0371
.condpart196
 jmp .__Red_Flying_Koopa

.skipL0371
.
 ; 

.L0372 ;  if _Enemy_Type  =  _Spiney_Ball then goto __Spiney_Ball

	LDA _Enemy_Type
	CMP #_Spiney_Ball
     BNE .skipL0372
.condpart197
 jmp .__Spiney_Ball

.skipL0372
.
 ; 

.L0373 ;  if _Enemy_Type  =  _Fireball_Enemy then goto __Fireball_Enemy

	LDA _Enemy_Type
	CMP #_Fireball_Enemy
     BNE .skipL0373
.condpart198
 jmp .__Fireball_Enemy

.skipL0373
.
 ; 

.L0374 ;  if _Enemy_Type  =  _Pirahna_Plant then goto __Pirahna_Plant

	LDA _Enemy_Type
	CMP #_Pirahna_Plant
     BNE .skipL0374
.condpart199
 jmp .__Pirahna_Plant

.skipL0374
.
 ; 

.L0375 ;  if _Enemy_Type  =  _Kinetic_Platforms then goto __Kinetic_Platform

	LDA _Enemy_Type
	CMP #_Kinetic_Platforms
     BNE .skipL0375
.condpart200
 jmp .__Kinetic_Platform

.skipL0375
.
 ; 

.L0376 ;  if _Enemy_Type  =  _Flagpole then goto __Enemy_Collision_Check

	LDA _Enemy_Type
	CMP #_Flagpole
     BNE .skipL0376
.condpart201
 jmp .__Enemy_Collision_Check

.skipL0376
.
 ; 

.L0377 ;  if _Enemy_Type  >  _Flagpole  &&  _Enemy_Type  <  _Kinetic_Platforms then goto __Special_Item

	LDA #_Flagpole
	CMP _Enemy_Type
     BCS .skipL0377
.condpart202
	LDA _Enemy_Type
	CMP #_Kinetic_Platforms
     BCS .skip202then
.condpart203
 jmp .__Special_Item

.skip202then
.skipL0377
.
 ; 

.L0378 ;  if _Enemy_Type  >  _P_Plant_31  &&  _Enemy_Type  <  _P_Plant_39 then goto __Enemy_Collision_Check

	LDA #_P_Plant_31
	CMP _Enemy_Type
     BCS .skipL0378
.condpart204
	LDA _Enemy_Type
	CMP #_P_Plant_39
     BCS .skip204then
.condpart205
 jmp .__Enemy_Collision_Check

.skip204then
.skipL0378
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0379 ;  if _Enemy_Type  =  _Bullet_Bill then x  =  2 else x  =  1

	LDA _Enemy_Type
	CMP #_Bullet_Bill
     BNE .skipL0379
.condpart206
	LDA #2
	STA x
 jmp .skipelse44
.skipL0379
	LDA #1
	STA x
.skipelse44
.
 ; 

.L0380 ;  if _Bit7_2nd_Quest{7} then x  =  x  *  2

	BIT _Bit7_2nd_Quest
	BPL .skipL0380
.condpart207
	LDA x
	asl
	STA x
.skipL0380
.
 ; 

.L0381 ;  if _Bit3_Enemy_Direction{3} then player1x  =  player1x  +  x else player1x  =  player1x  -  x

	LDA _Bit3_Enemy_Direction
	AND #8
	BEQ .skipL0381
.condpart208
	LDA player1x
	CLC
	ADC x
	STA player1x
 jmp .skipelse45
.skipL0381
	LDA player1x
	SEC
	SBC x
	STA player1x
.skipelse45
.
 ; 

.L0382 ;  if player1x  <  17  ||  player1x  >  137 then gosub __Kill_Enemy  :  goto __Main_Loop bank1

	LDA player1x
	CMP #17
     BCS .skipL0382
.condpart209
 jmp .condpart210
.skipL0382
	LDA #137
	CMP player1x
     BCS .skip54OR
.condpart210
 jsr .__Kill_Enemy
 sta temp7
 lda #>(.__Main_Loop-1)
 pha
 lda #<(.__Main_Loop-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
.skip54OR
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Enemy_Collision_Check
 ; __Enemy_Collision_Check

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0383 ;  if _Enemy_Type  >  _Red_Koopa  &&  _Enemy_Type  <  _Beetle_Shell then goto __Enemy_LR_Check

	LDA #_Red_Koopa
	CMP _Enemy_Type
     BCS .skipL0383
.condpart211
	LDA _Enemy_Type
	CMP #_Beetle_Shell
     BCS .skip211then
.condpart212
 jmp .__Enemy_LR_Check

.skip211then
.skipL0383
.
 ; 

.L0384 ;  if _Enemy_Momentum  <  7 then _Enemy_Momentum  =  _Enemy_Momentum  +  1

	LDA _Enemy_Momentum
	CMP #7
     BCS .skipL0384
.condpart213
	INC _Enemy_Momentum
.skipL0384
.
 ; 

.L0385 ;  player1y  =  player1y  +  _Enemy_Momentum

	LDA player1y
	CLC
	ADC _Enemy_Momentum
	STA player1y
.
 ; 

.L0386 ;  if _Bit3_Enemy_Direction{3} then x  =   ( player1x  -  17 )  / 4 else x  =   ( player1x  -  9 )  / 4

	LDA _Bit3_Enemy_Direction
	AND #8
	BEQ .skipL0386
.condpart214
; complex statement detected
	LDA player1x
	SEC
	SBC #17
	lsr
	lsr
	STA x
 jmp .skipelse46
.skipL0386
; complex statement detected
	LDA player1x
	SEC
	SBC #9
	lsr
	lsr
	STA x
.skipelse46
.
 ; 

.L0387 ;  if _Bit3_Enemy_Direction{3}  &&  _Enemy_Type  =  _Red_Koopa then x  =  x  +  1

	LDA _Bit3_Enemy_Direction
	AND #8
	BEQ .skipL0387
.condpart215
	LDA _Enemy_Type
	CMP #_Red_Koopa
     BNE .skip215then
.condpart216
	INC x
.skip215then
.skipL0387
.
 ; 

.L0388 ;  if !_Bit3_Enemy_Direction{3}  &&  _Enemy_Type  =  _Red_Koopa then x  =  x  -  1

	LDA _Bit3_Enemy_Direction
	AND #8
	BNE .skipL0388
.condpart217
	LDA _Enemy_Type
	CMP #_Red_Koopa
     BNE .skip217then
.condpart218
	DEC x
.skip217then
.skipL0388
.
 ; 

.L0389 ;  y  =   ( player1y  +  1 )  / 8

; complex statement detected
	LDA player1y
	CLC
	ADC #1
	lsr
	lsr
	lsr
	STA y
.
 ; 

.L0390 ;  if pfread ( x , y )  then player1y  =   ( y  *  8 )   -  1  :  _Enemy_Momentum  =  0  :  goto __Enemy_LR_Check

	LDA x
	LDY y
 sta temp7
 lda #>(ret_point25-1)
 pha
 lda #<(ret_point25-1)
 pha
 lda #>(pfread-1)
 pha
 lda #<(pfread-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #8
 jmp BS_jsr
ret_point25
	BNE .skipL0390
.condpart219
; complex statement detected
	LDA y
	asl
	asl
	asl
	SEC
	SBC #1
	STA player1y
	LDA #0
	STA _Enemy_Momentum
 jmp .__Enemy_LR_Check

.skipL0390
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0391 ;  if _Enemy_Type  =  _Red_Koopa  &&  _Enemy_Momentum  <>  8 then gosub __Fix_Enemy  :  player1y  =   ( y  *  8 )   -  1  :  _Enemy_Momentum  =  0  :  goto __Enemy_LR_Check

	LDA _Enemy_Type
	CMP #_Red_Koopa
     BNE .skipL0391
.condpart220
	LDA _Enemy_Momentum
	CMP #8
     BEQ .skip220then
.condpart221
 jsr .__Fix_Enemy
; complex statement detected
	LDA y
	asl
	asl
	asl
	SEC
	SBC #1
	STA player1y
	LDA #0
	STA _Enemy_Momentum
 jmp .__Enemy_LR_Check

.skip220then
.skipL0391
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0392 ;  if _Enemy_Type  =  _Two_Goombas then player1x  =  player1x  +  16  :  _Enemy_Type  =  _Goomba

	LDA _Enemy_Type
	CMP #_Two_Goombas
     BNE .skipL0392
.condpart222
	LDA player1x
	CLC
	ADC #16
	STA player1x
	LDA #_Goomba
	STA _Enemy_Type
.skipL0392
.
 ; 

.L0393 ;  if _Enemy_Type  =  _Two_Spineys then player1x  =  player1x  +  16  :  _Enemy_Type  =  _Spiney

	LDA _Enemy_Type
	CMP #_Two_Spineys
     BNE .skipL0393
.condpart223
	LDA player1x
	CLC
	ADC #16
	STA player1x
	LDA #_Spiney
	STA _Enemy_Type
.skipL0393
.
 ; 

.L0394 ;  if player1y  >  90 then gosub __Kill_Enemy  :  goto __Main_Loop bank1

	LDA #90
	CMP player1y
     BCS .skipL0394
.condpart224
 jsr .__Kill_Enemy
 sta temp7
 lda #>(.__Main_Loop-1)
 pha
 lda #<(.__Main_Loop-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
.skipL0394
.
 ; 

.__Enemy_LR_Check
 ; __Enemy_LR_Check

.
 ; 

.
 ; 

.
 ; 

.L0395 ;  if _Enemy_Type  =  _Bullet_Bill then goto __Enemy_End_Move

	LDA _Enemy_Type
	CMP #_Bullet_Bill
     BNE .skipL0395
.condpart225
 jmp .__Enemy_End_Move

.skipL0395
.
 ; 

.L0396 ;  if !collision(playfield,player1) then goto __Enemy_End_Move

	bit 	CXP1FB
	BMI .skipL0396
.condpart226
 jmp .__Enemy_End_Move

.skipL0396
.
 ; 

.L0397 ;  gosub __Fix_Enemy

 jsr .__Fix_Enemy

.
 ; 

.
 ; 

.__Enemy_End_Move
 ; __Enemy_End_Move

.
 ; 

.
 ; 

.
 ; 

.L0398 ;  if _Enemy_Type  >  29  &&  _Enemy_Type  <  _Two_Goombas then goto __Enemy_End_Move_32

	LDA #29
	CMP _Enemy_Type
     BCS .skipL0398
.condpart227
	LDA _Enemy_Type
	CMP #_Two_Goombas
     BCS .skip227then
.condpart228
 jmp .__Enemy_End_Move_32

.skip227then
.skipL0398
.
 ; 

.L0399 ;  if _Animation_Timer  >  3  &&  !_Bit4_Enemy_Dead_Flag{4} then x  =  _Enemy_Type  +  1 else x  =  _Enemy_Type

	LDA #3
	CMP _Animation_Timer
     BCS .skipL0399
.condpart229
	LDA _Bit4_Enemy_Dead_Flag
	AND #16
	BNE .skip229then
.condpart230
	LDA _Enemy_Type
	CLC
	ADC #1
	STA x
 jmp .skipelse47
.skip229then
.skipL0399
	LDA _Enemy_Type
	STA x
.skipelse47
.
 ; 

.L0400 ;  if x  =  42  ||  x  =  43 then x  =  x  -  42

	LDA x
	CMP #42
     BNE .skipL0400
.condpart231
 jmp .condpart232
.skipL0400
	LDA x
	CMP #43
     BNE .skip61OR
.condpart232
	LDA x
	SEC
	SBC #42
	STA x
.skip61OR
.
 ; 

.L0401 ;  if x  =  46  ||  x  =  47 then x  =  x  -  40

	LDA x
	CMP #46
     BNE .skipL0401
.condpart233
 jmp .condpart234
.skipL0401
	LDA x
	CMP #47
     BNE .skip62OR
.condpart234
	LDA x
	SEC
	SBC #40
	STA x
.skip62OR
.
 ; 

.L0402 ;  on x gosub __Goomba_Color __Goomba_Color __Green_Koopa_Color __Green_Koopa_Color __Beetle_Color __Beetle_Color __SpineyC __SpineyC __Red_Koopa_Color __Red_Koopa_Color __Green_Koopa_Color __Green_Koopa_Color __Bullet_Bill __Bullet_Bill __Red_Koopa_Color __Red_Koopa_Color __Spny_Ball_Color __Spny_Ball_Color __Fireball_Color __Fireball_Color __Flagpole __Flagpole __CoinC __CoinC __StarC1 __StarC2 __1UPC __1UPC __PlatformC __PlatformC

	lda #>(ongosub5-1)
	PHA
	lda #<(ongosub5-1)
	PHA
	LDX x
	LDA .L0402jumptablehi,x
	PHA
	LDA .L0402jumptablelo,x
	PHA
	RTS
.L0402jumptablehi
	.byte >(.__Goomba_Color-1)
	.byte >(.__Goomba_Color-1)
	.byte >(.__Green_Koopa_Color-1)
	.byte >(.__Green_Koopa_Color-1)
	.byte >(.__Beetle_Color-1)
	.byte >(.__Beetle_Color-1)
	.byte >(.__SpineyC-1)
	.byte >(.__SpineyC-1)
	.byte >(.__Red_Koopa_Color-1)
	.byte >(.__Red_Koopa_Color-1)
	.byte >(.__Green_Koopa_Color-1)
	.byte >(.__Green_Koopa_Color-1)
	.byte >(.__Bullet_Bill-1)
	.byte >(.__Bullet_Bill-1)
	.byte >(.__Red_Koopa_Color-1)
	.byte >(.__Red_Koopa_Color-1)
	.byte >(.__Spny_Ball_Color-1)
	.byte >(.__Spny_Ball_Color-1)
	.byte >(.__Fireball_Color-1)
	.byte >(.__Fireball_Color-1)
	.byte >(.__Flagpole-1)
	.byte >(.__Flagpole-1)
	.byte >(.__CoinC-1)
	.byte >(.__CoinC-1)
	.byte >(.__StarC1-1)
	.byte >(.__StarC2-1)
	.byte >(.__1UPC-1)
	.byte >(.__1UPC-1)
	.byte >(.__PlatformC-1)
	.byte >(.__PlatformC-1)
.L0402jumptablelo
	.byte <(.__Goomba_Color-1)
	.byte <(.__Goomba_Color-1)
	.byte <(.__Green_Koopa_Color-1)
	.byte <(.__Green_Koopa_Color-1)
	.byte <(.__Beetle_Color-1)
	.byte <(.__Beetle_Color-1)
	.byte <(.__SpineyC-1)
	.byte <(.__SpineyC-1)
	.byte <(.__Red_Koopa_Color-1)
	.byte <(.__Red_Koopa_Color-1)
	.byte <(.__Green_Koopa_Color-1)
	.byte <(.__Green_Koopa_Color-1)
	.byte <(.__Bullet_Bill-1)
	.byte <(.__Bullet_Bill-1)
	.byte <(.__Red_Koopa_Color-1)
	.byte <(.__Red_Koopa_Color-1)
	.byte <(.__Spny_Ball_Color-1)
	.byte <(.__Spny_Ball_Color-1)
	.byte <(.__Fireball_Color-1)
	.byte <(.__Fireball_Color-1)
	.byte <(.__Flagpole-1)
	.byte <(.__Flagpole-1)
	.byte <(.__CoinC-1)
	.byte <(.__CoinC-1)
	.byte <(.__StarC1-1)
	.byte <(.__StarC2-1)
	.byte <(.__1UPC-1)
	.byte <(.__1UPC-1)
	.byte <(.__PlatformC-1)
	.byte <(.__PlatformC-1)
ongosub5
.
 ; 

.L0403 ;  on x gosub __Goomba_1 __Goomba_2 __Koopa_1 __Koopa_2 __Beetle_1 __Beetle_2 __Spiney1 __Spiney2 __Koopa_1 __Koopa_2 __F_Koopa_1 __F_Koopa_2 __Bullet_Bill __Bullet_Bill __F_Koopa_1 __F_Koopa_2 __Spny_Ball_1 __Spny_Ball_2 __Fireball_1 __Fireball_2 __Flagpole __Flagpole __Coin1 __Coin2 __Star __Star __1UPMush __1UPMush __Platform __Platform

	lda #>(ongosub6-1)
	PHA
	lda #<(ongosub6-1)
	PHA
	LDX x
	LDA .L0403jumptablehi,x
	PHA
	LDA .L0403jumptablelo,x
	PHA
	RTS
.L0403jumptablehi
	.byte >(.__Goomba_1-1)
	.byte >(.__Goomba_2-1)
	.byte >(.__Koopa_1-1)
	.byte >(.__Koopa_2-1)
	.byte >(.__Beetle_1-1)
	.byte >(.__Beetle_2-1)
	.byte >(.__Spiney1-1)
	.byte >(.__Spiney2-1)
	.byte >(.__Koopa_1-1)
	.byte >(.__Koopa_2-1)
	.byte >(.__F_Koopa_1-1)
	.byte >(.__F_Koopa_2-1)
	.byte >(.__Bullet_Bill-1)
	.byte >(.__Bullet_Bill-1)
	.byte >(.__F_Koopa_1-1)
	.byte >(.__F_Koopa_2-1)
	.byte >(.__Spny_Ball_1-1)
	.byte >(.__Spny_Ball_2-1)
	.byte >(.__Fireball_1-1)
	.byte >(.__Fireball_2-1)
	.byte >(.__Flagpole-1)
	.byte >(.__Flagpole-1)
	.byte >(.__Coin1-1)
	.byte >(.__Coin2-1)
	.byte >(.__Star-1)
	.byte >(.__Star-1)
	.byte >(.__1UPMush-1)
	.byte >(.__1UPMush-1)
	.byte >(.__Platform-1)
	.byte >(.__Platform-1)
.L0403jumptablelo
	.byte <(.__Goomba_1-1)
	.byte <(.__Goomba_2-1)
	.byte <(.__Koopa_1-1)
	.byte <(.__Koopa_2-1)
	.byte <(.__Beetle_1-1)
	.byte <(.__Beetle_2-1)
	.byte <(.__Spiney1-1)
	.byte <(.__Spiney2-1)
	.byte <(.__Koopa_1-1)
	.byte <(.__Koopa_2-1)
	.byte <(.__F_Koopa_1-1)
	.byte <(.__F_Koopa_2-1)
	.byte <(.__Bullet_Bill-1)
	.byte <(.__Bullet_Bill-1)
	.byte <(.__F_Koopa_1-1)
	.byte <(.__F_Koopa_2-1)
	.byte <(.__Spny_Ball_1-1)
	.byte <(.__Spny_Ball_2-1)
	.byte <(.__Fireball_1-1)
	.byte <(.__Fireball_2-1)
	.byte <(.__Flagpole-1)
	.byte <(.__Flagpole-1)
	.byte <(.__Coin1-1)
	.byte <(.__Coin2-1)
	.byte <(.__Star-1)
	.byte <(.__Star-1)
	.byte <(.__1UPMush-1)
	.byte <(.__1UPMush-1)
	.byte <(.__Platform-1)
	.byte <(.__Platform-1)
ongosub6
.
 ; 

.L0404 ;  goto __Main_Loop bank1

 sta temp7
 lda #>(.__Main_Loop-1)
 pha
 lda #<(.__Main_Loop-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
.
 ; 

.__Enemy_End_Move_32
 ; __Enemy_End_Move_32

.
 ; 

.L0405 ;  x  =  _Enemy_Type  -  30

	LDA _Enemy_Type
	SEC
	SBC #30
	STA x
.
 ; 

.L0406 ;  on x gosub __PirahnaC __PirahnaC __SBColor __SBColor __SGKColor __SGKColor __SRKColor __SRKColor __Tramp1C __Tramp1C

	lda #>(ongosub7-1)
	PHA
	lda #<(ongosub7-1)
	PHA
	LDX x
	LDA .L0406jumptablehi,x
	PHA
	LDA .L0406jumptablelo,x
	PHA
	RTS
.L0406jumptablehi
	.byte >(.__PirahnaC-1)
	.byte >(.__PirahnaC-1)
	.byte >(.__SBColor-1)
	.byte >(.__SBColor-1)
	.byte >(.__SGKColor-1)
	.byte >(.__SGKColor-1)
	.byte >(.__SRKColor-1)
	.byte >(.__SRKColor-1)
	.byte >(.__Tramp1C-1)
	.byte >(.__Tramp1C-1)
.L0406jumptablelo
	.byte <(.__PirahnaC-1)
	.byte <(.__PirahnaC-1)
	.byte <(.__SBColor-1)
	.byte <(.__SBColor-1)
	.byte <(.__SGKColor-1)
	.byte <(.__SGKColor-1)
	.byte <(.__SRKColor-1)
	.byte <(.__SRKColor-1)
	.byte <(.__Tramp1C-1)
	.byte <(.__Tramp1C-1)
ongosub7
.
 ; 

.L0407 ;  if _Animation_Timer  >  3  &&  !_Bit4_Enemy_Dead_Flag{4} then x  =  x  +  1

	LDA #3
	CMP _Animation_Timer
     BCS .skipL0407
.condpart235
	LDA _Bit4_Enemy_Dead_Flag
	AND #16
	BNE .skip235then
.condpart236
	INC x
.skip235then
.skipL0407
.
 ; 

.L0408 ;  on x gosub __Pirahna1 __Pirahna2 __ShellB __ShellB __ShellK __ShellK __ShellK __ShellK __Tramp1 __Tramp1

	lda #>(ongosub8-1)
	PHA
	lda #<(ongosub8-1)
	PHA
	LDX x
	LDA .L0408jumptablehi,x
	PHA
	LDA .L0408jumptablelo,x
	PHA
	RTS
.L0408jumptablehi
	.byte >(.__Pirahna1-1)
	.byte >(.__Pirahna2-1)
	.byte >(.__ShellB-1)
	.byte >(.__ShellB-1)
	.byte >(.__ShellK-1)
	.byte >(.__ShellK-1)
	.byte >(.__ShellK-1)
	.byte >(.__ShellK-1)
	.byte >(.__Tramp1-1)
	.byte >(.__Tramp1-1)
.L0408jumptablelo
	.byte <(.__Pirahna1-1)
	.byte <(.__Pirahna2-1)
	.byte <(.__ShellB-1)
	.byte <(.__ShellB-1)
	.byte <(.__ShellK-1)
	.byte <(.__ShellK-1)
	.byte <(.__ShellK-1)
	.byte <(.__ShellK-1)
	.byte <(.__Tramp1-1)
	.byte <(.__Tramp1-1)
ongosub8
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0409 ;  goto __Main_Loop bank1

 sta temp7
 lda #>(.__Main_Loop-1)
 pha
 lda #<(.__Main_Loop-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Red_Flying_Koopa
 ; __Red_Flying_Koopa

.
 ; 

.L0410 ;  if _Bit7_2nd_Quest{7} then x  =  4 else x  =  2

	BIT _Bit7_2nd_Quest
	BPL .skipL0410
.condpart237
	LDA #4
	STA x
 jmp .skipelse48
.skipL0410
	LDA #2
	STA x
.skipelse48
.
 ; 

.L0411 ;  if _Bit3_Enemy_Direction{3} then player1y  =  player1y  +  x else player1y  =  player1y  -  x

	LDA _Bit3_Enemy_Direction
	AND #8
	BEQ .skipL0411
.condpart238
	LDA player1y
	CLC
	ADC x
	STA player1y
 jmp .skipelse49
.skipL0411
	LDA player1y
	SEC
	SBC x
	STA player1y
.skipelse49
.
 ; 

.L0412 ;  if player1y  >  72 then gosub __Fix_Enemy  :  player1y  =  72

	LDA #72
	CMP player1y
     BCS .skipL0412
.condpart239
 jsr .__Fix_Enemy
	LDA #72
	STA player1y
.skipL0412
.
 ; 

.L0413 ;  if player1y  <  24 then gosub __Fix_Enemy  :  player1y  =  24

	LDA player1y
	CMP #24
     BCS .skipL0413
.condpart240
 jsr .__Fix_Enemy
	LDA #24
	STA player1y
.skipL0413
.
 ; 

.L0414 ;  goto __Enemy_End_Move

 jmp .__Enemy_End_Move

.
 ; 

.__Spiney_Ball
 ; __Spiney_Ball

.
 ; 

.L0415 ;  player1y  =  player1y  +  4

	LDA player1y
	CLC
	ADC #4
	STA player1y
.
 ; 

.L0416 ;  if _Bit3_Enemy_Direction{3} then x  =   ( player1x  -  17 )  / 4 else x  =   ( player1x  -  9 )  / 4

	LDA _Bit3_Enemy_Direction
	AND #8
	BEQ .skipL0416
.condpart241
; complex statement detected
	LDA player1x
	SEC
	SBC #17
	lsr
	lsr
	STA x
 jmp .skipelse50
.skipL0416
; complex statement detected
	LDA player1x
	SEC
	SBC #9
	lsr
	lsr
	STA x
.skipelse50
.
 ; 

.L0417 ;  y  =   ( player1y  +  1 )  / 8

; complex statement detected
	LDA player1y
	CLC
	ADC #1
	lsr
	lsr
	lsr
	STA y
.
 ; 

.L0418 ;  if pfread ( x , y )  then _Enemy_Type  =  _Spiney

	LDA x
	LDY y
 sta temp7
 lda #>(ret_point26-1)
 pha
 lda #<(ret_point26-1)
 pha
 lda #>(pfread-1)
 pha
 lda #<(pfread-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #8
 jmp BS_jsr
ret_point26
	BNE .skipL0418
.condpart242
	LDA #_Spiney
	STA _Enemy_Type
.skipL0418
.
 ; 

.L0419 ;  goto __Enemy_End_Move

 jmp .__Enemy_End_Move

.
 ; 

.__Fireball_Enemy
 ; __Fireball_Enemy

.
 ; 

.L0420 ;  if _Bit3_Enemy_Direction{3} then player1y  =  player1y  +  _Enemy_Momentum else player1y  =  player1y  -  _Enemy_Momentum

	LDA _Bit3_Enemy_Direction
	AND #8
	BEQ .skipL0420
.condpart243
	LDA player1y
	CLC
	ADC _Enemy_Momentum
	STA player1y
 jmp .skipelse51
.skipL0420
	LDA player1y
	SEC
	SBC _Enemy_Momentum
	STA player1y
.skipelse51
.
 ; 

.L0421 ;  if _Bit3_Enemy_Direction{3}  &&  player1y  >  120 then _Bit3_Enemy_Direction{3}  =  0

	LDA _Bit3_Enemy_Direction
	AND #8
	BEQ .skipL0421
.condpart244
	LDA #120
	CMP player1y
     BCS .skip244then
.condpart245
	LDA _Bit3_Enemy_Direction
	AND #247
	STA _Bit3_Enemy_Direction
.skip244then
.skipL0421
.
 ; 

.L0422 ;  if !_Bit3_Enemy_Direction{3}  &&  player1y  <  40 then _Enemy_Momentum  =  _Enemy_Momentum  -  2

	LDA _Bit3_Enemy_Direction
	AND #8
	BNE .skipL0422
.condpart246
	LDA player1y
	CMP #40
     BCS .skip246then
.condpart247
	LDA _Enemy_Momentum
	SEC
	SBC #2
	STA _Enemy_Momentum
.skip246then
.skipL0422
.
 ; 

.L0423 ;  if _Bit3_Enemy_Direction{3}  &&  _Enemy_Momentum  <  6 then _Enemy_Momentum  =  _Enemy_Momentum  +  2

	LDA _Bit3_Enemy_Direction
	AND #8
	BEQ .skipL0423
.condpart248
	LDA _Enemy_Momentum
	CMP #6
     BCS .skip248then
.condpart249
	LDA _Enemy_Momentum
	CLC
	ADC #2
	STA _Enemy_Momentum
.skip248then
.skipL0423
.
 ; 

.L0424 ;  if _Enemy_Momentum  =  0 then _Bit3_Enemy_Direction{3}  =  1

	LDA _Enemy_Momentum
	CMP #0
     BNE .skipL0424
.condpart250
	LDA _Bit3_Enemy_Direction
	ORA #8
	STA _Bit3_Enemy_Direction
.skipL0424
.
 ; 

.L0425 ;  x  =  player0x  -  16

	LDA player0x
	SEC
	SBC #16
	STA x
.
 ; 

.L0426 ;  if x  >  player1x then gosub __Kill_Enemy  :  goto __Main_Loop bank1

	LDA player1x
	CMP x
     BCS .skipL0426
.condpart251
 jsr .__Kill_Enemy
 sta temp7
 lda #>(.__Main_Loop-1)
 pha
 lda #<(.__Main_Loop-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
.skipL0426
.
 ; 

.L0427 ;  goto __Enemy_End_Move

 jmp .__Enemy_End_Move

.
 ; 

.__Pirahna_Plant
 ; __Pirahna_Plant

.
 ; 

.L0428 ;  x  =  player1x  +  16

	LDA player1x
	CLC
	ADC #16
	STA x
.
 ; 

.L0429 ;  if player0x  >  x then gosub __Kill_Enemy  :  goto __Main_Loop bank1

	LDA x
	CMP player0x
     BCS .skipL0429
.condpart252
 jsr .__Kill_Enemy
 sta temp7
 lda #>(.__Main_Loop-1)
 pha
 lda #<(.__Main_Loop-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
.skipL0429
.
 ; 

.L0430 ;  if _Bit3_Enemy_Direction{3} then player1y  =  64 else player1y  =  120

	LDA _Bit3_Enemy_Direction
	AND #8
	BEQ .skipL0430
.condpart253
	LDA #64
	STA player1y
 jmp .skipelse52
.skipL0430
	LDA #120
	STA player1y
.skipelse52
.
 ; 

.L0431 ;  _Enemy_Momentum  =  _Enemy_Momentum  +  1

	INC _Enemy_Momentum
.
 ; 

.L0432 ;  if _Bit7_2nd_Quest{7} then x  =  32 else x  =  48

	BIT _Bit7_2nd_Quest
	BPL .skipL0432
.condpart254
	LDA #32
	STA x
 jmp .skipelse53
.skipL0432
	LDA #48
	STA x
.skipelse53
.
 ; 

.L0433 ;  if _Enemy_Momentum  <  x then goto __Enemy_End_Move

	LDA _Enemy_Momentum
	CMP x
     BCS .skipL0433
.condpart255
 jmp .__Enemy_End_Move

.skipL0433
.
 ; 

.L0434 ;  _Enemy_Momentum  =  0

	LDA #0
	STA _Enemy_Momentum
.
 ; 

.L0435 ;  if _Bit3_Enemy_Direction{3} then _Bit3_Enemy_Direction{3}  =  0 else _Bit3_Enemy_Direction{3}  =  1

	LDA _Bit3_Enemy_Direction
	AND #8
	BEQ .skipL0435
.condpart256
	LDA _Bit3_Enemy_Direction
	AND #247
	STA _Bit3_Enemy_Direction
 jmp .skipelse54
.skipL0435
	LDA _Bit3_Enemy_Direction
	ORA #8
	STA _Bit3_Enemy_Direction
.skipelse54
.
 ; 

.L0436 ;  goto __Enemy_End_Move

 jmp .__Enemy_End_Move

.
 ; 

.__Kinetic_Platform
 ; __Kinetic_Platform

.
 ; 

.L0437 ;  if collision(player1,playfield) then goto __K_Platform_03

	bit 	CXP1FB
	BPL .skipL0437
.condpart257
 jmp .__K_Platform_03

.skipL0437
.
 ; 

.L0438 ;  if player1y  >  72  &&  _Bit3_Enemy_Direction{3} then _Enemy_Momentum  =  _Enemy_Momentum  -  1  :  goto __K_Platform_02

	LDA #72
	CMP player1y
     BCS .skipL0438
.condpart258
	LDA _Bit3_Enemy_Direction
	AND #8
	BEQ .skip258then
.condpart259
	DEC _Enemy_Momentum
 jmp .__K_Platform_02

.skip258then
.skipL0438
.
 ; 

.L0439 ;  if player1y  <  24  &&  !_Bit3_Enemy_Direction{3} then _Enemy_Momentum  =  _Enemy_Momentum  -  1  :  goto __K_Platform_02

	LDA player1y
	CMP #24
     BCS .skipL0439
.condpart260
	LDA _Bit3_Enemy_Direction
	AND #8
	BNE .skip260then
.condpart261
	DEC _Enemy_Momentum
 jmp .__K_Platform_02

.skip260then
.skipL0439
.
 ; 

.L0440 ;  if _Enemy_Momentum  <  5 then _Enemy_Momentum  =  _Enemy_Momentum  +  1

	LDA _Enemy_Momentum
	CMP #5
     BCS .skipL0440
.condpart262
	INC _Enemy_Momentum
.skipL0440
.
 ; 

.L0441 ;  goto __K_Platform_04

 jmp .__K_Platform_04

.
 ; 

.__K_Platform_02
 ; __K_Platform_02

.
 ; 

.L0442 ;  if _Enemy_Momentum  >  0 then goto __K_Platform_04

	LDA #0
	CMP _Enemy_Momentum
     BCS .skipL0442
.condpart263
 jmp .__K_Platform_04

.skipL0442
.
 ; 

.__K_Platform_03
 ; __K_Platform_03

.
 ; 

.L0443 ;  if _Bit3_Enemy_Direction{3} then _Bit3_Enemy_Direction{3}  =  0 else _Bit3_Enemy_Direction{3}  =  1

	LDA _Bit3_Enemy_Direction
	AND #8
	BEQ .skipL0443
.condpart264
	LDA _Bit3_Enemy_Direction
	AND #247
	STA _Bit3_Enemy_Direction
 jmp .skipelse55
.skipL0443
	LDA _Bit3_Enemy_Direction
	ORA #8
	STA _Bit3_Enemy_Direction
.skipelse55
.
 ; 

.__K_Platform_04
 ; __K_Platform_04

.
 ; 

.L0444 ;  if _Bit3_Enemy_Direction{3} then player1y  =  player1y  +  _Enemy_Momentum else player1y  =  player1y  -  _Enemy_Momentum

	LDA _Bit3_Enemy_Direction
	AND #8
	BEQ .skipL0444
.condpart265
	LDA player1y
	CLC
	ADC _Enemy_Momentum
	STA player1y
 jmp .skipelse56
.skipL0444
	LDA player1y
	SEC
	SBC _Enemy_Momentum
	STA player1y
.skipelse56
.
 ; 

.L0445 ;  goto __Enemy_End_Move

 jmp .__Enemy_End_Move

.
 ; 

.__Kill_Fireball
 ; __Kill_Fireball

.
 ; 

.L0446 ;  ballx  =  0  :  bally  =  120

	LDA #0
	STA ballx
	LDA #120
	STA bally
.
 ; 

.L0447 ;  return thisbank

	RTS
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Initialize_Enemy
 ; __Initialize_Enemy

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0448 ;  if _Object_Scroll_In_Data  >  151  &&  _Object_Scroll_In_Data  <  168  &&  _Level  =  3 then goto __Init_Enemy_02

	LDA #151
	CMP _Object_Scroll_In_Data
     BCS .skipL0448
.condpart266
	LDA _Object_Scroll_In_Data
	CMP #168
     BCS .skip266then
.condpart267
	LDA _Level
	CMP #3
     BNE .skip267then
.condpart268
 jmp .__Init_Enemy_02

.skip267then
.skip266then
.skipL0448
.
 ; 

.L0449 ;  if _Object_Scroll_In_Data  >  167  &&  _Object_Scroll_In_Data  <  184 then goto __Init_Enemy_02

	LDA #167
	CMP _Object_Scroll_In_Data
     BCS .skipL0449
.condpart269
	LDA _Object_Scroll_In_Data
	CMP #184
     BCS .skip269then
.condpart270
 jmp .__Init_Enemy_02

.skip269then
.skipL0449
.
 ; 

.L0450 ;  if _Object_Scroll_In_Data  >  135  &&  _Object_Scroll_In_Data  <  152  &&  _Level  =  4 then goto __Init_Enemy_02

	LDA #135
	CMP _Object_Scroll_In_Data
     BCS .skipL0450
.condpart271
	LDA _Object_Scroll_In_Data
	CMP #152
     BCS .skip271then
.condpart272
	LDA _Level
	CMP #4
     BNE .skip272then
.condpart273
 jmp .__Init_Enemy_02

.skip272then
.skip271then
.skipL0450
.
 ; 

.L0451 ;  if player1x  >  0 then return thisbank

	LDA #0
	CMP player1x
     BCS .skipL0451
.condpart274
	RTS
.skipL0451
.
 ; 

.__Init_Enemy_02
 ; __Init_Enemy_02

.
 ; 

.L0452 ;  _Enemy_Type  =  _Object_Scroll_In_Data / 8

	LDA _Object_Scroll_In_Data
	lsr
	lsr
	lsr
	STA _Enemy_Type
.
 ; 

.L0453 ;  _Enemy_Type  =  _Enemy_Type  -  1  :  _Enemy_Momentum  =  0

	DEC _Enemy_Type
	LDA #0
	STA _Enemy_Momentum
.
 ; 

.L0454 ;  if _Enemy_Type  >  21  &&  _Enemy_Type  <  27 then _Enemy_Type  =  _Enemy_Type  +  20

	LDA #21
	CMP _Enemy_Type
     BCS .skipL0454
.condpart275
	LDA _Enemy_Type
	CMP #27
     BCS .skip275then
.condpart276
	LDA _Enemy_Type
	CLC
	ADC #20
	STA _Enemy_Type
.skip275then
.skipL0454
.
 ; 

.L0455 ;  _Bit4_Enemy_Dead_Flag{4}  =  0

	LDA _Bit4_Enemy_Dead_Flag
	AND #239
	STA _Bit4_Enemy_Dead_Flag
.
 ; 

.L0456 ;  if _Bit7_2nd_Quest{7}  &&  _Enemy_Type  =  _Goomba then _Enemy_Type  =  _Beetle

	BIT _Bit7_2nd_Quest
	BPL .skipL0456
.condpart277
	LDA _Enemy_Type
	CMP #_Goomba
     BNE .skip277then
.condpart278
	LDA #_Beetle
	STA _Enemy_Type
.skip277then
.skipL0456
.
 ; 

.L0457 ;  if _Bit7_2nd_Quest{7}  &&  _Enemy_Type  =  _Two_Goombas then _Enemy_Type  =  _Beetle

	BIT _Bit7_2nd_Quest
	BPL .skipL0457
.condpart279
	LDA _Enemy_Type
	CMP #_Two_Goombas
     BNE .skip279then
.condpart280
	LDA #_Beetle
	STA _Enemy_Type
.skip279then
.skipL0457
.
 ; 

.L0458 ;  if _Bit7_2nd_Quest{7}  &&  _Enemy_Type  =  _Green_Koopa  &&  _Animation_Timer  >  3 then _Enemy_Type  =  _Red_Koopa

	BIT _Bit7_2nd_Quest
	BPL .skipL0458
.condpart281
	LDA _Enemy_Type
	CMP #_Green_Koopa
     BNE .skip281then
.condpart282
	LDA #3
	CMP _Animation_Timer
     BCS .skip282then
.condpart283
	LDA #_Red_Koopa
	STA _Enemy_Type
.skip282then
.skip281then
.skipL0458
.
 ; 

.L0459 ;  if _Enemy_Type  =  _Two_Thwomps then z  =  24  :  _Enemy_Momentum  =  0  :  _Bit3_Enemy_Direction{3}  =  0  :  goto __Finish_Enemy_Init

	LDA _Enemy_Type
	CMP #_Two_Thwomps
     BNE .skipL0459
.condpart284
	LDA #24
	STA z
	LDA #0
	STA _Enemy_Momentum
	LDA _Bit3_Enemy_Direction
	AND #247
	STA _Bit3_Enemy_Direction
 jmp .__Finish_Enemy_Init

.skipL0459
.
 ; 

.L0460 ;  if _Enemy_Type  =  _Bullet_Bill  &&  _Level  =  4  &&  _Bit0_Player_Facing_Direction{0} then _Enemy_Type  =  _Goomba  :  return thisbank

	LDA _Enemy_Type
	CMP #_Bullet_Bill
     BNE .skipL0460
.condpart285
	LDA _Level
	CMP #4
     BNE .skip285then
.condpart286
	LDA _Bit0_Player_Facing_Direction
	LSR
	BCC .skip286then
.condpart287
	LDA #_Goomba
	STA _Enemy_Type
	RTS
.skip286then
.skip285then
.skipL0460
.
 ; 

.L0461 ;  if _Enemy_Type  =  _Bullet_Bill then AUDC0  =  8  :  AUDF0  =  31

	LDA _Enemy_Type
	CMP #_Bullet_Bill
     BNE .skipL0461
.condpart288
	LDA #8
	STA AUDC0
	LDA #31
	STA AUDF0
.skipL0461
.
 ; 

.L0462 ;  if _Enemy_Type  >  9  &&  _Enemy_Type  <  15 then z  =   ( _Animation_Timer  +  8 )   *  4  :  goto __Enemy_Facing_Init

	LDA #9
	CMP _Enemy_Type
     BCS .skipL0462
.condpart289
	LDA _Enemy_Type
	CMP #15
     BCS .skip289then
.condpart290
; complex statement detected
	LDA _Animation_Timer
	CLC
	ADC #8
	asl
	asl
	STA z
 jmp .__Enemy_Facing_Init

.skip289then
.skipL0462
.
 ; 

.L0463 ;  if _Enemy_Type  =  _Spiney_Ball  &&  _Level  =  4 then _Enemy_Type  =  _Thwomp  :  z  =  24  :  _Enemy_Momentum  =  0  :  _Bit3_Enemy_Direction{3}  =  0  :  goto __Finish_Enemy_Init

	LDA _Enemy_Type
	CMP #_Spiney_Ball
     BNE .skipL0463
.condpart291
	LDA _Level
	CMP #4
     BNE .skip291then
.condpart292
	LDA #_Thwomp
	STA _Enemy_Type
	LDA #24
	STA z
	LDA #0
	STA _Enemy_Momentum
	LDA _Bit3_Enemy_Direction
	AND #247
	STA _Bit3_Enemy_Direction
 jmp .__Finish_Enemy_Init

.skip291then
.skipL0463
.
 ; 

.L0464 ;  if _Enemy_Type  =  _Spiney_Ball  &&  _Level  =  2 then _Enemy_Type  =  _Thwomp  :  z  =  24  :  _Enemy_Momentum  =  0  :  _Bit3_Enemy_Direction{3}  =  0  :  goto __Finish_Enemy_Init

	LDA _Enemy_Type
	CMP #_Spiney_Ball
     BNE .skipL0464
.condpart293
	LDA _Level
	CMP #2
     BNE .skip293then
.condpart294
	LDA #_Thwomp
	STA _Enemy_Type
	LDA #24
	STA z
	LDA #0
	STA _Enemy_Momentum
	LDA _Bit3_Enemy_Direction
	AND #247
	STA _Bit3_Enemy_Direction
 jmp .__Finish_Enemy_Init

.skip293then
.skipL0464
.
 ; 

.L0465 ;  if _Enemy_Type  =  _Spiney_Ball then z  =  8  :  _Bit3_Enemy_Direction{3}  =  0  :  goto __Finish_Enemy_Init

	LDA _Enemy_Type
	CMP #_Spiney_Ball
     BNE .skipL0465
.condpart295
	LDA #8
	STA z
	LDA _Bit3_Enemy_Direction
	AND #247
	STA _Bit3_Enemy_Direction
 jmp .__Finish_Enemy_Init

.skipL0465
.
 ; 

.L0466 ;  if _Enemy_Type  =  _Fireball_Enemy then z  =  121  :  _Bit3_Enemy_Direction{3}  =  0  :  _Enemy_Momentum  =  6  :  goto __Finish_Enemy_Init

	LDA _Enemy_Type
	CMP #_Fireball_Enemy
     BNE .skipL0466
.condpart296
	LDA #121
	STA z
	LDA _Bit3_Enemy_Direction
	AND #247
	STA _Bit3_Enemy_Direction
	LDA #6
	STA _Enemy_Momentum
 jmp .__Finish_Enemy_Init

.skipL0466
.
 ; 

.L0467 ;  if _Enemy_Type  =  _Kinetic_Platforms then z  =  48  :  _Bit3_Enemy_Direction{3}  =  0  :  goto __Finish_Enemy_Init

	LDA _Enemy_Type
	CMP #_Kinetic_Platforms
     BNE .skipL0467
.condpart297
	LDA #48
	STA z
	LDA _Bit3_Enemy_Direction
	AND #247
	STA _Bit3_Enemy_Direction
 jmp .__Finish_Enemy_Init

.skipL0467
.
 ; 

.L0468 ;  if _Enemy_Type  =  _Pirahna_Plant then z  =  120  :  _Enemy_Momentum  =  0  :  _Bit3_Enemy_Direction{3}  =  1  :  goto __Finish_Enemy_Init

	LDA _Enemy_Type
	CMP #_Pirahna_Plant
     BNE .skipL0468
.condpart298
	LDA #120
	STA z
	LDA #0
	STA _Enemy_Momentum
	LDA _Bit3_Enemy_Direction
	ORA #8
	STA _Bit3_Enemy_Direction
 jmp .__Finish_Enemy_Init

.skipL0468
.
 ; 

.L0469 ;  y  =  1

	LDA #1
	STA y
.
 ; 

.L0470 ;  if _Bit0_Player_Facing_Direction{0} then x  =  0 else x  =  31

	LDA _Bit0_Player_Facing_Direction
	LSR
	BCC .skipL0470
.condpart299
	LDA #0
	STA x
 jmp .skipelse57
.skipL0470
	LDA #31
	STA x
.skipelse57
.
 ; 

.__Init_Enemy_Placement
 ; __Init_Enemy_Placement

.
 ; 

.L0471 ;  y  =  y  +  1

	INC y
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0472 ;  if y  =  11 then return

	LDA y
	CMP #11
     BNE .skipL0472
.condpart300
	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.skipL0472
.
 ; 

.L0473 ;  if pfread ( x , y )  then z  =   ( y  *  8 )   -  1 else goto __Init_Enemy_Placement

	LDA x
	LDY y
 sta temp7
 lda #>(ret_point27-1)
 pha
 lda #<(ret_point27-1)
 pha
 lda #>(pfread-1)
 pha
 lda #<(pfread-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #8
 jmp BS_jsr
ret_point27
	BNE .skipL0473
.condpart301
; complex statement detected
	LDA y
	asl
	asl
	asl
	SEC
	SBC #1
	STA z
 jmp .skipelse58
.skipL0473
 jmp .__Init_Enemy_Placement

.skipelse58
.
 ; 

.__Enemy_Facing_Init
 ; __Enemy_Facing_Init

.
 ; 

.L0474 ;  if _Bit0_Player_Facing_Direction{0} then _Bit3_Enemy_Direction{3}  =  1

	LDA _Bit0_Player_Facing_Direction
	LSR
	BCC .skipL0474
.condpart302
	LDA _Bit3_Enemy_Direction
	ORA #8
	STA _Bit3_Enemy_Direction
.skipL0474
.
 ; 

.L0475 ;  if !_Bit0_Player_Facing_Direction{0} then _Bit3_Enemy_Direction{3}  =  0

	LDA _Bit0_Player_Facing_Direction
	LSR
	BCS .skipL0475
.condpart303
	LDA _Bit3_Enemy_Direction
	AND #247
	STA _Bit3_Enemy_Direction
.skipL0475
.
 ; 

.__Finish_Enemy_Init
 ; __Finish_Enemy_Init

.
 ; 

.L0476 ;  if _Bit0_Player_Facing_Direction{0} then x  =  17 else x  =  135

	LDA _Bit0_Player_Facing_Direction
	LSR
	BCC .skipL0476
.condpart304
	LDA #17
	STA x
 jmp .skipelse59
.skipL0476
	LDA #135
	STA x
.skipelse59
.
 ; 

.L0477 ;  if _Enemy_Type  =  _Spiney_Ball then x  =  96  +   ( _Animation_Timer  *  4 ) 

	LDA _Enemy_Type
	CMP #_Spiney_Ball
     BNE .skipL0477
.condpart305
; complex statement detected
	LDA #96
	PHA
	LDA _Animation_Timer
	asl
	asl
	TSX
	INX
	TXS
	CLC
	ADC $00,x
	STA x
.skipL0477
.
 ; 

.L0478 ;  player1x  =  x  :  player1y  =  z

	LDA x
	STA player1x
	LDA z
	STA player1y
.
 ; 

.L0479 ;  if _Enemy_Type  =  _Flagpole  ||  _Enemy_Type  =  _Trampoline then _Bit3_Enemy_Direction{3}  =  0

	LDA _Enemy_Type
	CMP #_Flagpole
     BNE .skipL0479
.condpart306
 jmp .condpart307
.skipL0479
	LDA _Enemy_Type
	CMP #_Trampoline
     BNE .skip84OR
.condpart307
	LDA _Bit3_Enemy_Direction
	AND #247
	STA _Bit3_Enemy_Direction
.skip84OR
.
 ; 

.L0480 ;  gosub __Render_Screen bank1

 sta temp7
 lda #>(ret_point28-1)
 pha
 lda #<(ret_point28-1)
 pha
 lda #>(.__Render_Screen-1)
 pha
 lda #<(.__Render_Screen-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
ret_point28
.
 ; 

.L0481 ;  return thisbank

	RTS
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0482 ;  if _Bit0_Player_Facing_Direction{0} then y  =  0 else y  =  8

	LDA _Bit0_Player_Facing_Direction
	LSR
	BCC .skipL0482
.condpart308
	LDA #0
	STA y
 jmp .skipelse60
.skipL0482
	LDA #8
	STA y
.skipelse60
.
 ; 

.L0483 ;  player1x  =  player1x  +  4  -  y

; complex statement detected
	LDA player1x
	CLC
	ADC #4
	SEC
	SBC y
	STA player1x
.
 ; 

.L0484 ;  return thisbank

	RTS
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Kill_Enemy
 ; __Kill_Enemy

.
 ; 

.L0485 ;  player1x  =  0  :  player1y  =  150  :  _Enemy_Type  =  _Goomba  :  _Bit3_Enemy_Direction{3}  =  0  :  _Enemy_Momentum  =  0  :  _Bit4_Enemy_Dead_Flag{4}  =  0

	LDA #0
	STA player1x
	LDA #150
	STA player1y
	LDA #_Goomba
	STA _Enemy_Type
	LDA _Bit3_Enemy_Direction
	AND #247
	STA _Bit3_Enemy_Direction
	LDA #0
	STA _Enemy_Momentum
	LDA _Bit4_Enemy_Dead_Flag
	AND #239
	STA _Bit4_Enemy_Dead_Flag
.
 ; 

.L0486 ;  return thisbank

	RTS
.
 ; 

.__Fix_Enemy
 ; __Fix_Enemy

.
 ; 

.L0487 ;  if _Bit3_Enemy_Direction{3} then _Bit3_Enemy_Direction{3}  =  0 else _Bit3_Enemy_Direction{3}  =  1

	LDA _Bit3_Enemy_Direction
	AND #8
	BEQ .skipL0487
.condpart309
	LDA _Bit3_Enemy_Direction
	AND #247
	STA _Bit3_Enemy_Direction
 jmp .skipelse61
.skipL0487
	LDA _Bit3_Enemy_Direction
	ORA #8
	STA _Bit3_Enemy_Direction
.skipelse61
.
 ; 

.L0488 ;  x  =  2

	LDA #2
	STA x
.
 ; 

.L0489 ;  if _Enemy_Type  =  _Green_Koopa  ||  _Enemy_Type  =  _Flying_Green_Koopa then x  =  4

	LDA _Enemy_Type
	CMP #_Green_Koopa
     BNE .skipL0489
.condpart310
 jmp .condpart311
.skipL0489
	LDA _Enemy_Type
	CMP #_Flying_Green_Koopa
     BNE .skip85OR
.condpart311
	LDA #4
	STA x
.skip85OR
.
 ; 

.L0490 ;  if _Enemy_Type  =  _Red_Koopa then x  =  4

	LDA _Enemy_Type
	CMP #_Red_Koopa
     BNE .skipL0490
.condpart312
	LDA #4
	STA x
.skipL0490
.
 ; 

.L0491 ;  if _Bit7_2nd_Quest{7} then x  =  x  *  2

	BIT _Bit7_2nd_Quest
	BPL .skipL0491
.condpart313
	LDA x
	asl
	STA x
.skipL0491
.
 ; 

.L0492 ;  if _Bit3_Enemy_Direction{3} then player1x  =  player1x  +  x else player1x  =  player1x  -  x

	LDA _Bit3_Enemy_Direction
	AND #8
	BEQ .skipL0492
.condpart314
	LDA player1x
	CLC
	ADC x
	STA player1x
 jmp .skipelse62
.skipL0492
	LDA player1x
	SEC
	SBC x
	STA player1x
.skipelse62
.
 ; 

.L0493 ;  return thisbank

	RTS
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Enemy_Death_Routine
 ; __Enemy_Death_Routine

.
 ; 

.L0494 ;  player1y  =  player1y  +  _Enemy_Momentum

	LDA player1y
	CLC
	ADC _Enemy_Momentum
	STA player1y
.
 ; 

.L0495 ;  if _Enemy_Momentum  <  6 then _Enemy_Momentum  =  _Enemy_Momentum  +  1

	LDA _Enemy_Momentum
	CMP #6
     BCS .skipL0495
.condpart315
	INC _Enemy_Momentum
.skipL0495
.
 ; 

.L0496 ;  if player1y  >  90 then gosub __Kill_Enemy

	LDA #90
	CMP player1y
     BCS .skipL0496
.condpart316
 jsr .__Kill_Enemy

.skipL0496
.
 ; 

.L0497 ;  if _Enemy_Momentum  =  6 then goto __Enemy_End_Move

	LDA _Enemy_Momentum
	CMP #6
     BNE .skipL0497
.condpart317
 jmp .__Enemy_End_Move

.skipL0497
.
 ; 

.L0498 ;  temp4  =  26  -  _Enemy_Momentum

	LDA #26
	SEC
	SBC _Enemy_Momentum
	STA temp4
.
 ; 

.L0499 ;  AUDV0  =  12

	LDA #12
	STA AUDV0
.L0500 ;  AUDC0  =  4

	LDA #4
	STA AUDC0
.L0501 ;  AUDF0  =  temp4

	LDA temp4
	STA AUDF0
.
 ; 

.L0502 ;  goto __Enemy_End_Move

 jmp .__Enemy_End_Move

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Moving_Shell_Routine
 ; __Moving_Shell_Routine

.
 ; 

.L0503 ;  x  =  _Moving_Shell_X_Coordinate  +  1

	LDA _Moving_Shell_X_Coordinate
	CLC
	ADC #1
	STA x
.
 ; 

.L0504 ;  pfpixel _Moving_Shell_X_Coordinate _Moving_Shell_Y_Coordinate off

	LDX #1
	LDY _Moving_Shell_Y_Coordinate
	LDA _Moving_Shell_X_Coordinate
 sta temp7
 lda #>(ret_point29-1)
 pha
 lda #<(ret_point29-1)
 pha
 lda #>(pfpixel-1)
 pha
 lda #<(pfpixel-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #8
 jmp BS_jsr
ret_point29
.
 ; 

.L0505 ;  pfpixel x _Moving_Shell_Y_Coordinate off

	LDX #1
	LDY _Moving_Shell_Y_Coordinate
	LDA x
 sta temp7
 lda #>(ret_point30-1)
 pha
 lda #<(ret_point30-1)
 pha
 lda #>(pfpixel-1)
 pha
 lda #<(pfpixel-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #8
 jmp BS_jsr
ret_point30
.
 ; 

.L0506 ;  if _Bit5_Moving_Turtle_Shell_Direction{5} then _Moving_Shell_X_Coordinate  =  _Moving_Shell_X_Coordinate  -  2 else _Moving_Shell_X_Coordinate  =  _Moving_Shell_X_Coordinate  +  2

	LDA _Bit5_Moving_Turtle_Shell_Direction
	AND #32
	BEQ .skipL0506
.condpart318
	LDA _Moving_Shell_X_Coordinate
	SEC
	SBC #2
	STA _Moving_Shell_X_Coordinate
 jmp .skipelse63
.skipL0506
	LDA _Moving_Shell_X_Coordinate
	CLC
	ADC #2
	STA _Moving_Shell_X_Coordinate
.skipelse63
.
 ; 

.L0507 ;  if _Moving_Shell_X_Coordinate  <  0 then _Moving_Shell_X_Coordinate  =  0  :  _Moving_Shell_Y_Coordinate  =  0  :  return thisbank

	LDA _Moving_Shell_X_Coordinate
	CMP #0
     BCS .skipL0507
.condpart319
	LDA #0
	STA _Moving_Shell_X_Coordinate
	STA _Moving_Shell_Y_Coordinate
	RTS
.skipL0507
.
 ; 

.L0508 ;  if _Moving_Shell_X_Coordinate  >  30 then _Moving_Shell_X_Coordinate  =  0  :  _Moving_Shell_Y_Coordinate  =  0  :  return thisbank

	LDA #30
	CMP _Moving_Shell_X_Coordinate
     BCS .skipL0508
.condpart320
	LDA #0
	STA _Moving_Shell_X_Coordinate
	STA _Moving_Shell_Y_Coordinate
	RTS
.skipL0508
.
 ; 

.L0509 ;  y  =  _Moving_Shell_Y_Coordinate  +  1

	LDA _Moving_Shell_Y_Coordinate
	CLC
	ADC #1
	STA y
.
 ; 

.L0510 ;  if pfread ( _Moving_Shell_X_Coordinate , y )  then goto __Moving_Shell_02

	LDA _Moving_Shell_X_Coordinate
	LDY y
 sta temp7
 lda #>(ret_point31-1)
 pha
 lda #<(ret_point31-1)
 pha
 lda #>(pfread-1)
 pha
 lda #<(pfread-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #8
 jmp BS_jsr
ret_point31
	BNE .skipL0510
.condpart321
 jmp .__Moving_Shell_02

.skipL0510
.
 ; 

.L0511 ;  if pfread ( x , y )  then goto __Moving_Shell_02

	LDA x
	LDY y
 sta temp7
 lda #>(ret_point32-1)
 pha
 lda #<(ret_point32-1)
 pha
 lda #>(pfread-1)
 pha
 lda #<(pfread-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #8
 jmp BS_jsr
ret_point32
	BNE .skipL0511
.condpart322
 jmp .__Moving_Shell_02

.skipL0511
.
 ; 

.L0512 ;  _Moving_Shell_Y_Coordinate  =  _Moving_Shell_Y_Coordinate  +  1

	INC _Moving_Shell_Y_Coordinate
.
 ; 

.L0513 ;  if _Moving_Shell_Y_Coordinate  =  11 then _Moving_Shell_X_Coordinate  =  0  :  _Moving_Shell_Y_Coordinate  =  0  :  return thisbank

	LDA _Moving_Shell_Y_Coordinate
	CMP #11
     BNE .skipL0513
.condpart323
	LDA #0
	STA _Moving_Shell_X_Coordinate
	STA _Moving_Shell_Y_Coordinate
	RTS
.skipL0513
.
 ; 

.__Moving_Shell_02
 ; __Moving_Shell_02

.
 ; 

.L0514 ;  if _Level  =  3 then goto __Moving_Shell_03

	LDA _Level
	CMP #3
     BNE .skipL0514
.condpart324
 jmp .__Moving_Shell_03

.skipL0514
.
 ; 

.L0515 ;  y  =  0

	LDA #0
	STA y
.
 ; 

.L0516 ;  if pfread ( _Moving_Shell_X_Coordinate , _Moving_Shell_Y_Coordinate )  then goto __Change_Shell_Direction

	LDA _Moving_Shell_X_Coordinate
	LDY _Moving_Shell_Y_Coordinate
 sta temp7
 lda #>(ret_point33-1)
 pha
 lda #<(ret_point33-1)
 pha
 lda #>(pfread-1)
 pha
 lda #<(pfread-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #8
 jmp BS_jsr
ret_point33
	BNE .skipL0516
.condpart325
 jmp .__Change_Shell_Direction

.skipL0516
.
 ; 

.L0517 ;  y  =  1

	LDA #1
	STA y
.
 ; 

.L0518 ;  x  =  _Moving_Shell_X_Coordinate  +  1

	LDA _Moving_Shell_X_Coordinate
	CLC
	ADC #1
	STA x
.
 ; 

.L0519 ;  if pfread ( x , _Moving_Shell_Y_Coordinate )  then goto __Change_Shell_Direction

	LDA x
	LDY _Moving_Shell_Y_Coordinate
 sta temp7
 lda #>(ret_point34-1)
 pha
 lda #<(ret_point34-1)
 pha
 lda #>(pfread-1)
 pha
 lda #<(pfread-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #8
 jmp BS_jsr
ret_point34
	BNE .skipL0519
.condpart326
 jmp .__Change_Shell_Direction

.skipL0519
.
 ; 

.__Moving_Shell_03
 ; __Moving_Shell_03

.
 ; 

.L0520 ;  x  =  _Moving_Shell_X_Coordinate  +  1

	LDA _Moving_Shell_X_Coordinate
	CLC
	ADC #1
	STA x
.
 ; 

.L0521 ;  pfpixel _Moving_Shell_X_Coordinate _Moving_Shell_Y_Coordinate on

	LDX #0
	LDY _Moving_Shell_Y_Coordinate
	LDA _Moving_Shell_X_Coordinate
 sta temp7
 lda #>(ret_point35-1)
 pha
 lda #<(ret_point35-1)
 pha
 lda #>(pfpixel-1)
 pha
 lda #<(pfpixel-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #8
 jmp BS_jsr
ret_point35
.
 ; 

.L0522 ;  pfpixel x _Moving_Shell_Y_Coordinate on

	LDX #0
	LDY _Moving_Shell_Y_Coordinate
	LDA x
 sta temp7
 lda #>(ret_point36-1)
 pha
 lda #<(ret_point36-1)
 pha
 lda #>(pfpixel-1)
 pha
 lda #<(pfpixel-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #8
 jmp BS_jsr
ret_point36
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0523 ;  if _Bit4_Enemy_Dead_Flag{4}  ||  _Enemy_Type  =  _Flagpole then return thisbank

	LDA _Bit4_Enemy_Dead_Flag
	AND #16
	BEQ .skipL0523
.condpart327
 jmp .condpart328
.skipL0523
	LDA _Enemy_Type
	CMP #_Flagpole
     BNE .skip86OR
.condpart328
	RTS
.skip86OR
.
 ; 

.L0524 ;  x  =   ( _Moving_Shell_X_Coordinate  *  4 )   +  17

; complex statement detected
	LDA _Moving_Shell_X_Coordinate
	asl
	asl
	CLC
	ADC #17
	STA x
.
 ; 

.L0525 ;  y  =   ( _Moving_Shell_X_Coordinate  *  4 )   +  25

; complex statement detected
	LDA _Moving_Shell_X_Coordinate
	asl
	asl
	CLC
	ADC #25
	STA y
.
 ; 

.L0526 ;  if player1x  >=  x  &&  player1x  <=  y then goto __Moving_Shell_04

	LDA player1x
	CMP x
     BCC .skipL0526
.condpart329
	LDA y
	CMP player1x
     BCC .skip329then
.condpart330
 jmp .__Moving_Shell_04

.skip329then
.skipL0526
.
 ; 

.L0527 ;  return thisbank

	RTS
.
 ; 

.__Moving_Shell_04
 ; __Moving_Shell_04

.
 ; 

.L0528 ;  x  =   ( _Moving_Shell_Y_Coordinate  *  8 ) 

; complex statement detected
	LDA _Moving_Shell_Y_Coordinate
	asl
	asl
	asl
	STA x
.
 ; 

.L0529 ;  y  =   ( _Moving_Shell_Y_Coordinate  *  8 )   +  8

; complex statement detected
	LDA _Moving_Shell_Y_Coordinate
	asl
	asl
	asl
	CLC
	ADC #8
	STA y
.
 ; 

.L0530 ;  if player1y  >=  x  &&  player1y  <=  y then _Bit4_Enemy_Dead_Flag{4}  =  1  :  score  =  score  +  400

	LDA player1y
	CMP x
     BCC .skipL0530
.condpart331
	LDA y
	CMP player1y
     BCC .skip331then
.condpart332
	LDA _Bit4_Enemy_Dead_Flag
	ORA #16
	STA _Bit4_Enemy_Dead_Flag
	SED
	CLC
	LDA score+1
	ADC #$04
	STA score+1
	LDA score
	ADC #$00
	STA score
	CLD
.skip331then
.skipL0530
.
 ; 

.L0531 ;  if _Enemy_Type  >  41 then score  =  score  +  800

	LDA #41
	CMP _Enemy_Type
     BCS .skipL0531
.condpart333
	SED
	CLC
	LDA score+1
	ADC #$08
	STA score+1
	LDA score
	ADC #$00
	STA score
	CLD
.skipL0531
.
 ; 

.L0532 ;  return thisbank

	RTS
.
 ; 

.__Change_Shell_Direction
 ; __Change_Shell_Direction

.
 ; 

.L0533 ;  if _Moving_Shell_Y_Coordinate  <  8  &&  _Level  <  3 then goto __Destroy_Block

	LDA _Moving_Shell_Y_Coordinate
	CMP #8
     BCS .skipL0533
.condpart334
	LDA _Level
	CMP #3
     BCS .skip334then
.condpart335
 jmp .__Destroy_Block

.skip334then
.skipL0533
.
 ; 

.L0534 ;  AUDV0  =  12

	LDA #12
	STA AUDV0
.L0535 ;  AUDC0  =  1

	LDA #1
	STA AUDC0
.L0536 ;  AUDF0  =  31

	LDA #31
	STA AUDF0
.
 ; 

.__Change_Shell_Dir_02
 ; __Change_Shell_Dir_02

.
 ; 

.L0537 ;  if _Bit5_Moving_Turtle_Shell_Direction{5} then _Moving_Shell_X_Coordinate  =  _Moving_Shell_X_Coordinate  +  4  :  _Bit5_Moving_Turtle_Shell_Direction{5}  =  0  :  goto __Moving_Shell_03

	LDA _Bit5_Moving_Turtle_Shell_Direction
	AND #32
	BEQ .skipL0537
.condpart336
	LDA _Moving_Shell_X_Coordinate
	CLC
	ADC #4
	STA _Moving_Shell_X_Coordinate
	LDA _Bit5_Moving_Turtle_Shell_Direction
	AND #223
	STA _Bit5_Moving_Turtle_Shell_Direction
 jmp .__Moving_Shell_03

.skipL0537
.
 ; 

.L0538 ;  if !_Bit5_Moving_Turtle_Shell_Direction{5} then _Moving_Shell_X_Coordinate  =  _Moving_Shell_X_Coordinate  -  4  :  _Bit5_Moving_Turtle_Shell_Direction{5}  =  1

	LDA _Bit5_Moving_Turtle_Shell_Direction
	AND #32
	BNE .skipL0538
.condpart337
	LDA _Moving_Shell_X_Coordinate
	SEC
	SBC #4
	STA _Moving_Shell_X_Coordinate
	LDA _Bit5_Moving_Turtle_Shell_Direction
	ORA #32
	STA _Bit5_Moving_Turtle_Shell_Direction
.skipL0538
.
 ; 

.L0539 ;  goto __Moving_Shell_03

 jmp .__Moving_Shell_03

.
 ; 

.__Destroy_Block
 ; __Destroy_Block

.
 ; 

.L0540 ;  score  =  score  +  20

	SED
	CLC
	LDA score+2
	ADC #$20
	STA score+2
	LDA score+1
	ADC #$00
	STA score+1
	LDA score
	ADC #$00
	STA score
	CLD
.
 ; 

.L0541 ;  if y  =  0 then pfpixel _Moving_Shell_X_Coordinate _Moving_Shell_Y_Coordinate off

	LDA y
	CMP #0
     BNE .skipL0541
.condpart338
	LDX #1
	LDY _Moving_Shell_Y_Coordinate
	LDA _Moving_Shell_X_Coordinate
 sta temp7
 lda #>(ret_point37-1)
 pha
 lda #<(ret_point37-1)
 pha
 lda #>(pfpixel-1)
 pha
 lda #<(pfpixel-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #8
 jmp BS_jsr
ret_point37
.skipL0541
.
 ; 

.L0542 ;  if y  =  1 then pfpixel x _Moving_Shell_Y_Coordinate off

	LDA y
	CMP #1
     BNE .skipL0542
.condpart339
	LDX #1
	LDY _Moving_Shell_Y_Coordinate
	LDA x
 sta temp7
 lda #>(ret_point38-1)
 pha
 lda #<(ret_point38-1)
 pha
 lda #>(pfpixel-1)
 pha
 lda #<(pfpixel-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #8
 jmp BS_jsr
ret_point38
.skipL0542
.
 ; 

.L0543 ;  AUDV0  =  10

	LDA #10
	STA AUDV0
.L0544 ;  AUDC0  =  7

	LDA #7
	STA AUDC0
.L0545 ;  AUDF0  =  22

	LDA #22
	STA AUDF0
.
 ; 

.L0546 ;  goto __Change_Shell_Dir_02

 jmp .__Change_Shell_Dir_02

.
 ; 

.__Special_Item
 ; __Special_Item

.
 ; 

.L0547 ;  if _Enemy_Momentum  >  249 then gosub __Kill_Enemy  :  goto __Enemy_End_Move

	LDA #249
	CMP _Enemy_Momentum
     BCS .skipL0547
.condpart340
 jsr .__Kill_Enemy
 jmp .__Enemy_End_Move

.skipL0547
.
 ; 

.L0548 ;  if _Enemy_Momentum  >  199 then _Enemy_Momentum  =  _Enemy_Momentum  +  1  :  goto __Enemy_End_Move

	LDA #199
	CMP _Enemy_Momentum
     BCS .skipL0548
.condpart341
	INC _Enemy_Momentum
 jmp .__Enemy_End_Move

.skipL0548
.
 ; 

.L0549 ;  if _Bit3_Enemy_Direction{3} then _Enemy_Momentum  =  _Enemy_Momentum  +  1 else _Enemy_Momentum  =  _Enemy_Momentum  -  1

	LDA _Bit3_Enemy_Direction
	AND #8
	BEQ .skipL0549
.condpart342
	INC _Enemy_Momentum
 jmp .skipelse64
.skipL0549
	DEC _Enemy_Momentum
.skipelse64
.
 ; 

.L0550 ;  if _Enemy_Momentum  =  0 then _Bit3_Enemy_Direction{3}  =  1

	LDA _Enemy_Momentum
	CMP #0
     BNE .skipL0550
.condpart343
	LDA _Bit3_Enemy_Direction
	ORA #8
	STA _Bit3_Enemy_Direction
.skipL0550
.
 ; 

.L0551 ;  if _Enemy_Momentum  >  6 then _Enemy_Momentum  =  6

	LDA #6
	CMP _Enemy_Momentum
     BCS .skipL0551
.condpart344
	LDA #6
	STA _Enemy_Momentum
.skipL0551
.
 ; 

.L0552 ;  player1y  =  player1y  +  _Enemy_Momentum

	LDA player1y
	CLC
	ADC _Enemy_Momentum
	STA player1y
.
 ; 

.L0553 ;  if _Enemy_Momentum  <  5 then goto __Enemy_End_Move

	LDA _Enemy_Momentum
	CMP #5
     BCS .skipL0553
.condpart345
 jmp .__Enemy_End_Move

.skipL0553
.
 ; 

.L0554 ;  x  =   ( player1x  -  17 )  / 4  :  y  =  player1y / 8

; complex statement detected
	LDA player1x
	SEC
	SBC #17
	lsr
	lsr
	STA x
	LDA player1y
	lsr
	lsr
	lsr
	STA y
.
 ; 

.L0555 ;  if pfread ( x , y )  then player1y  =   ( y  *  8 )   -  1  :  _Enemy_Momentum  =  200

	LDA x
	LDY y
 sta temp7
 lda #>(ret_point39-1)
 pha
 lda #<(ret_point39-1)
 pha
 lda #>(pfread-1)
 pha
 lda #<(pfread-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #8
 jmp BS_jsr
ret_point39
	BNE .skipL0555
.condpart346
; complex statement detected
	LDA y
	asl
	asl
	asl
	SEC
	SBC #1
	STA player1y
	LDA #200
	STA _Enemy_Momentum
.skipL0555
.
 ; 

.L0556 ;  goto __Enemy_End_Move

 jmp .__Enemy_End_Move

.
 ; 

.__Title_Screen
 ; __Title_Screen

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0557 ;  pfcolors:

 lda # $08
 sta COLUPF
 ifconst pfres
 lda #>(pfcolorlabel360-132+pfres*pfwidth)
 else
 lda #>(pfcolorlabel360-84)
 endif
 sta pfcolortable+1
 ifconst pfres
 lda #<(pfcolorlabel360-132+pfres*pfwidth)
 else
 lda #<(pfcolorlabel360-84)
 endif
 sta pfcolortable
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0558 ;  playfield:

  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel0
PF_data0
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %01100100
	if (pfwidth>2)
	.byte %01100100, %00000000
 endif
	.byte %00000000, %11111100
	if (pfwidth>2)
	.byte %11111100, %00000000
 endif
	.byte %00000000, %10011100
	if (pfwidth>2)
	.byte %10011100, %00000000
 endif
	.byte %00000000, %10011100
	if (pfwidth>2)
	.byte %10011100, %00000000
 endif
	.byte %00000010, %01100110
	if (pfwidth>2)
	.byte %01100110, %00000010
 endif
	.byte %00000011, %11111111
	if (pfwidth>2)
	.byte %11111111, %00000011
 endif
	.byte %00000011, %00111100
	if (pfwidth>2)
	.byte %00111100, %00000011
 endif
	.byte %00000011, %00111100
	if (pfwidth>2)
	.byte %00111100, %00000011
 endif
	.byte %00000011, %00111111
	if (pfwidth>2)
	.byte %00111111, %00000011
 endif
	.byte %11111111, %11111111
	if (pfwidth>2)
	.byte %11111111, %11111111
 endif
pflabel0
	lda PF_data0,x
	sta playfield,x
	dex
	bpl pflabel0
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0559 ;  player0y  =  150  :  player0x  =  42  :  _Bit3_Super_Mario_Power{3}  =  1  :  _Momentum_Left_Right  =  2

	LDA #150
	STA player0y
	LDA #42
	STA player0x
	LDA _Bit3_Super_Mario_Power
	ORA #8
	STA _Bit3_Super_Mario_Power
	LDA #2
	STA _Momentum_Left_Right
.
 ; 

.L0560 ;  _Animation_Timer  =  0  :  _Level_Timer  =  0  :  _Bit6_Regular_Mario{6}  =  0  :  _Bit0_Player_Facing_Direction{0}  =  0

	LDA #0
	STA _Animation_Timer
	STA _Level_Timer
	LDA _Bit6_Regular_Mario
	AND #191
	STA _Bit6_Regular_Mario
	LDA _Bit0_Player_Facing_Direction
	AND #254
	STA _Bit0_Player_Facing_Direction
.
 ; 

.
 ; 

.__S2
 ; __S2

.
 ; 

.L0561 ;  _Animation_Timer  =  _Animation_Timer  +  1

	INC _Animation_Timer
.
 ; 

.L0562 ;  if _Animation_Timer  >  6 then _Animation_Timer  =  0  :  _Level_Timer  =  _Level_Timer  +  1

	LDA #6
	CMP _Animation_Timer
     BCS .skipL0562
.condpart347
	LDA #0
	STA _Animation_Timer
	INC _Level_Timer
.skipL0562
.
 ; 

.L0563 ;  if player0y  >  100  &&  _Level_Timer  <  4 then goto __S3

	LDA #100
	CMP player0y
     BCS .skipL0563
.condpart348
	LDA _Level_Timer
	CMP #4
     BCS .skip348then
.condpart349
 jmp .__S3

.skip348then
.skipL0563
.
 ; 

.L0564 ;  _Level_Timer  =  0  :  player0y  =  79

	LDA #0
	STA _Level_Timer
	LDA #79
	STA player0y
.
 ; 

.L0565 ;  if _Bit0_Player_Facing_Direction{0} then player0x  =  player0x  -  1 else player0x  =  player0x  +  1

	LDA _Bit0_Player_Facing_Direction
	LSR
	BCC .skipL0565
.condpart350
	DEC player0x
 jmp .skipelse65
.skipL0565
	INC player0x
.skipelse65
.
 ; 

.L0566 ;  if player0x  <  42 then player0x  =  42  :  player0y  =  150  :  _Bit0_Player_Facing_Direction{0}  =  0

	LDA player0x
	CMP #42
     BCS .skipL0566
.condpart351
	LDA #42
	STA player0x
	LDA #150
	STA player0y
	LDA _Bit0_Player_Facing_Direction
	AND #254
	STA _Bit0_Player_Facing_Direction
.skipL0566
.
 ; 

.L0567 ;  if player0x  >  112 then player0x  =  112  :  player0y  =  150  :  _Bit0_Player_Facing_Direction{0}  =  1

	LDA #112
	CMP player0x
     BCS .skipL0567
.condpart352
	LDA #112
	STA player0x
	LDA #150
	STA player0y
	LDA _Bit0_Player_Facing_Direction
	ORA #1
	STA _Bit0_Player_Facing_Direction
.skipL0567
.
 ; 

.__S3
 ; __S3

.
 ; 

.L0568 ;  gosub __Set_Up_Mario bank1

 sta temp7
 lda #>(ret_point40-1)
 pha
 lda #<(ret_point40-1)
 pha
 lda #>(.__Set_Up_Mario-1)
 pha
 lda #<(.__Set_Up_Mario-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
ret_point40
.
 ; 

.L0569 ;  for x  =  1 to 3

	LDA #1
	STA x
.L0569forx
.
 ; 

.L0570 ;  CTRLPF  =  $15

	LDA #$15
	STA CTRLPF
.
 ; 

.L0571 ;  if _Bit0_Player_Facing_Direction{0} then REFP0  =  8

	LDA _Bit0_Player_Facing_Direction
	LSR
	BCC .skipL0571
.condpart353
	LDA #8
	STA REFP0
.skipL0571
.
 ; 

.L0572 ;  drawscreen

 sta temp7
 lda #>(ret_point41-1)
 pha
 lda #<(ret_point41-1)
 pha
 lda #>(drawscreen-1)
 pha
 lda #<(drawscreen-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #8
 jmp BS_jsr
ret_point41
.
 ; 

.L0573 ;  next x

	LDA x
	CMP #3

	INC x
 if ((* - .L0569forx) < 127) && ((* - .L0569forx) > -128)
	bcc .L0569forx
 else
	bcs .6skipL0569forx
	jmp .L0569forx
.6skipL0569forx
 endif
.
 ; 

.L0574 ;  if !joy0fire then goto __S2

 bit INPT4
	BPL .skipL0574
.condpart354
 jmp .__S2

.skipL0574
.
 ; 

.L0575 ;  _Bit6_Regular_Mario{6}  =  1

	LDA _Bit6_Regular_Mario
	ORA #64
	STA _Bit6_Regular_Mario
.
 ; 

.L0576 ;  _Bit3_Super_Mario_Power{3}  =  0  :  _Bit0_Player_Facing_Direction{0}  =  0

	LDA _Bit3_Super_Mario_Power
	AND #247
	STA _Bit3_Super_Mario_Power
	LDA _Bit0_Player_Facing_Direction
	AND #254
	STA _Bit0_Player_Facing_Direction
.
 ; 

.L0577 ;  return otherbank

	JMP BS_return
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Goomba_Color
 ; __Goomba_Color

.L0578 ;  player1color:

	LDX #<playercolorL0578_1
	STX player1color
	LDA #>playercolorL0578_1
	STA player1color+1
.L0579 ;  return thisbank

	RTS
.
 ; 

.__Goomba_1
 ; __Goomba_1

.L0580 ;  player1:

	LDX #<playerL0580_1
	STX player1pointerlo
	LDA #>playerL0580_1
	STA player1pointerhi
	LDA #10
	STA player1height
.L0581 ;  return thisbank

	RTS
.
 ; 

.__Goomba_2
 ; __Goomba_2

.L0582 ;  player1:

	LDX #<playerL0582_1
	STX player1pointerlo
	LDA #>playerL0582_1
	STA player1pointerhi
	LDA #10
	STA player1height
.L0583 ;  return thisbank

	RTS
.
 ; 

.__Beetle_Color
 ; __Beetle_Color

.L0584 ;  player1color:

	LDX #<playercolorL0584_1
	STX player1color
	LDA #>playercolorL0584_1
	STA player1color+1
.L0585 ;  return thisbank

	RTS
.
 ; 

.__Beetle_1
 ; __Beetle_1

.L0586 ;  player1:

	LDX #<playerL0586_1
	STX player1pointerlo
	LDA #>playerL0586_1
	STA player1pointerhi
	LDA #9
	STA player1height
.L0587 ;  return thisbank

	RTS
.
 ; 

.__Beetle_2
 ; __Beetle_2

.L0588 ;  player1:

	LDX #<playerL0588_1
	STX player1pointerlo
	LDA #>playerL0588_1
	STA player1pointerhi
	LDA #9
	STA player1height
.L0589 ;  return thisbank

	RTS
.
 ; 

.__Bullet_Bill
 ; __Bullet_Bill

.L0590 ;  player1color:

	LDX #<playercolorL0590_1
	STX player1color
	LDA #>playercolorL0590_1
	STA player1color+1
.
 ; 

.L0591 ;  player1:

	LDX #<playerL0591_1
	STX player1pointerlo
	LDA #>playerL0591_1
	STA player1pointerhi
	LDA #7
	STA player1height
.L0592 ;  return thisbank

	RTS
.
 ; 

.__Fireball_Color
 ; __Fireball_Color

.L0593 ;  player1color:

	LDX #<playercolorL0593_1
	STX player1color
	LDA #>playercolorL0593_1
	STA player1color+1
.L0594 ;  return thisbank

	RTS
.
 ; 

.__Fireball_1
 ; __Fireball_1

.L0595 ;  player1:

	LDX #<playerL0595_1
	STX player1pointerlo
	LDA #>playerL0595_1
	STA player1pointerhi
	LDA #7
	STA player1height
.L0596 ;  return thisbank

	RTS
.
 ; 

.__Fireball_2
 ; __Fireball_2

.L0597 ;  player1:

	LDX #<playerL0597_1
	STX player1pointerlo
	LDA #>playerL0597_1
	STA player1pointerhi
	LDA #7
	STA player1height
.L0598 ;  return thisbank

	RTS
.
 ; 

.__Green_Koopa_Color
 ; __Green_Koopa_Color

.L0599 ;  player1color:

	LDX #<playercolorL0599_1
	STX player1color
	LDA #>playercolorL0599_1
	STA player1color+1
.L0600 ;  return thisbank

	RTS
.
 ; 

.__Red_Koopa_Color
 ; __Red_Koopa_Color

.L0601 ;  player1color:

	LDX #<playercolorL0601_1
	STX player1color
	LDA #>playercolorL0601_1
	STA player1color+1
.L0602 ;  return thisbank

	RTS
.
 ; 

.__F_Koopa_1
 ; __F_Koopa_1

.L0603 ;  player1:

	LDX #<playerL0603_1
	STX player1pointerlo
	LDA #>playerL0603_1
	STA player1pointerhi
	LDA #12
	STA player1height
.L0604 ;  return thisbank

	RTS
.
 ; 

.__F_Koopa_2
 ; __F_Koopa_2

.L0605 ;  player1:

	LDX #<playerL0605_1
	STX player1pointerlo
	LDA #>playerL0605_1
	STA player1pointerhi
	LDA #12
	STA player1height
.L0606 ;  return thisbank

	RTS
.
 ; 

.__Koopa_1
 ; __Koopa_1

.L0607 ;  player1:

	LDX #<playerL0607_1
	STX player1pointerlo
	LDA #>playerL0607_1
	STA player1pointerhi
	LDA #12
	STA player1height
.L0608 ;  return thisbank

	RTS
.
 ; 

.__Koopa_2
 ; __Koopa_2

.L0609 ;  player1:

	LDX #<playerL0609_1
	STX player1pointerlo
	LDA #>playerL0609_1
	STA player1pointerhi
	LDA #12
	STA player1height
.L0610 ;  return thisbank

	RTS
.
 ; 

.__Spny_Ball_Color
 ; __Spny_Ball_Color

.L0611 ;  player1color:

	LDX #<playercolorL0611_1
	STX player1color
	LDA #>playercolorL0611_1
	STA player1color+1
.L0612 ;  return thisbank

	RTS
.
 ; 

.__Spny_Ball_1
 ; __Spny_Ball_1

.L0613 ;  player1:

	LDX #<playerL0613_1
	STX player1pointerlo
	LDA #>playerL0613_1
	STA player1pointerhi
	LDA #8
	STA player1height
.L0614 ;  return thisbank

	RTS
.
 ; 

.__Spny_Ball_2
 ; __Spny_Ball_2

.L0615 ;  player1:

	LDX #<playerL0615_1
	STX player1pointerlo
	LDA #>playerL0615_1
	STA player1pointerhi
	LDA #8
	STA player1height
.L0616 ;  return thisbank

	RTS
.
 ; 

.__SBColor
 ; __SBColor

.L0617 ;  player1color:

	LDX #<playercolorL0617_1
	STX player1color
	LDA #>playercolorL0617_1
	STA player1color+1
.L0618 ;  return thisbank

	RTS
.
 ; 

.__ShellB
 ; __ShellB

.L0619 ;  player1:

	LDX #<playerL0619_1
	STX player1pointerlo
	LDA #>playerL0619_1
	STA player1pointerhi
	LDA #7
	STA player1height
.L0620 ;  return thisbank

	RTS
.
 ; 

.__SGKColor
 ; __SGKColor

.L0621 ;  player1color:

	LDX #<playercolorL0621_1
	STX player1color
	LDA #>playercolorL0621_1
	STA player1color+1
.L0622 ;  return thisbank

	RTS
.
 ; 

.__SRKColor
 ; __SRKColor

.L0623 ;  player1color:

	LDX #<playercolorL0623_1
	STX player1color
	LDA #>playercolorL0623_1
	STA player1color+1
.L0624 ;  return thisbank

	RTS
.
 ; 

.__ShellK
 ; __ShellK

.L0625 ;  player1:

	LDX #<playerL0625_1
	STX player1pointerlo
	LDA #>playerL0625_1
	STA player1pointerhi
	LDA #7
	STA player1height
.L0626 ;  return thisbank

	RTS
.
 ; 

.__SpineyC
 ; __SpineyC

.L0627 ;  player1color:

	LDX #<playercolorL0627_1
	STX player1color
	LDA #>playercolorL0627_1
	STA player1color+1
.L0628 ;  return thisbank

	RTS
.
 ; 

.__Spiney1
 ; __Spiney1

.L0629 ;  player1:

	LDX #<playerL0629_1
	STX player1pointerlo
	LDA #>playerL0629_1
	STA player1pointerhi
	LDA #8
	STA player1height
.L0630 ;  return thisbank

	RTS
.
 ; 

.__Spiney2
 ; __Spiney2

.L0631 ;  player1:

	LDX #<playerL0631_1
	STX player1pointerlo
	LDA #>playerL0631_1
	STA player1pointerhi
	LDA #8
	STA player1height
.L0632 ;  return thisbank

	RTS
.
 ; 

.__Flagpole
 ; __Flagpole

.L0633 ;  player1color:

	LDX #<playercolorL0633_1
	STX player1color
	LDA #>playercolorL0633_1
	STA player1color+1
.
 ; 

.L0634 ;  player1:

	LDX #<playerL0634_1
	STX player1pointerlo
	LDA #>playerL0634_1
	STA player1pointerhi
	LDA #31
	STA player1height
.L0635 ;  return thisbank

	RTS
.
 ; 

.__1UPC
 ; __1UPC

.L0636 ;  player1color:

	LDX #<playercolorL0636_1
	STX player1color
	LDA #>playercolorL0636_1
	STA player1color+1
.L0637 ;  return thisbank

	RTS
.
 ; 

.__1UPMush
 ; __1UPMush

.L0638 ;  player1:

	LDX #<playerL0638_1
	STX player1pointerlo
	LDA #>playerL0638_1
	STA player1pointerhi
	LDA #7
	STA player1height
.L0639 ;  return thisbank

	RTS
.
 ; 

.__CoinC
 ; __CoinC

.L0640 ;  player1color:

	LDX #<playercolorL0640_1
	STX player1color
	LDA #>playercolorL0640_1
	STA player1color+1
.L0641 ;  return thisbank

	RTS
.
 ; 

.__Coin1
 ; __Coin1

.L0642 ;  player1:

	LDX #<playerL0642_1
	STX player1pointerlo
	LDA #>playerL0642_1
	STA player1pointerhi
	LDA #7
	STA player1height
.L0643 ;  return thisbank

	RTS
.
 ; 

.__Coin2
 ; __Coin2

.L0644 ;  player1:

	LDX #<playerL0644_1
	STX player1pointerlo
	LDA #>playerL0644_1
	STA player1pointerhi
	LDA #7
	STA player1height
.L0645 ;  return thisbank

	RTS
.
 ; 

.__StarC1
 ; __StarC1

.L0646 ;  player1color:

	LDX #<playercolorL0646_1
	STX player1color
	LDA #>playercolorL0646_1
	STA player1color+1
.L0647 ;  return thisbank

	RTS
.
 ; 

.__StarC2
 ; __StarC2

.L0648 ;  player1color:

	LDX #<playercolorL0648_1
	STX player1color
	LDA #>playercolorL0648_1
	STA player1color+1
.L0649 ;  return thisbank

	RTS
.
 ; 

.__Star
 ; __Star

.L0650 ;  player1:

	LDX #<playerL0650_1
	STX player1pointerlo
	LDA #>playerL0650_1
	STA player1pointerhi
	LDA #7
	STA player1height
.L0651 ;  return thisbank

	RTS
.
 ; 

.__PirahnaC
 ; __PirahnaC

.L0652 ;  player1color:

	LDX #<playercolorL0652_1
	STX player1color
	LDA #>playercolorL0652_1
	STA player1color+1
.L0653 ;  return thisbank

	RTS
.
 ; 

.__Pirahna1
 ; __Pirahna1

.L0654 ;  player1:

	LDX #<playerL0654_1
	STX player1pointerlo
	LDA #>playerL0654_1
	STA player1pointerhi
	LDA #14
	STA player1height
.L0655 ;  return thisbank

	RTS
.
 ; 

.__Pirahna2
 ; __Pirahna2

.L0656 ;  player1:

	LDX #<playerL0656_1
	STX player1pointerlo
	LDA #>playerL0656_1
	STA player1pointerhi
	LDA #14
	STA player1height
.L0657 ;  return thisbank

	RTS
.
 ; 

.__PlatformC
 ; __PlatformC

.L0658 ;  player1color:

	LDX #<playercolorL0658_1
	STX player1color
	LDA #>playercolorL0658_1
	STA player1color+1
.L0659 ;  return thisbank

	RTS
.
 ; 

.__Platform
 ; __Platform

.L0660 ;  player1:

	LDX #<playerL0660_1
	STX player1pointerlo
	LDA #>playerL0660_1
	STA player1pointerhi
	LDA #7
	STA player1height
.L0661 ;  return thisbank

	RTS
.
 ; 

.__Tramp1C
 ; __Tramp1C

.L0662 ;  player1color:

	LDX #<playercolorL0662_1
	STX player1color
	LDA #>playercolorL0662_1
	STA player1color+1
.L0663 ;  return thisbank

	RTS
.
 ; 

.__Tramp1
 ; __Tramp1

.L0664 ;  player1:

	LDX #<playerL0664_1
	STX player1pointerlo
	LDA #>playerL0664_1
	STA player1pointerhi
	LDA #7
	STA player1height
.L0665 ;  return thisbank

	RTS
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0666 ;  bank 3

 if ECHO2
 echo "    ",[(start_bank2 - *)]d , "bytes of ROM space left in bank 2")
 endif
ECHO2 = 1
 ORG $2FF4-bscode_length
 RORG $3FF4-bscode_length
start_bank2 ldx #$ff
 ifconst FASTFETCH ; using DPC+
 stx FASTFETCH
 endif 
 txs
 if bankswitch == 64
   lda #(((>(start-1)) & $0F) | $F0)
 else
   lda #>(start-1)
 endif
 pha
 lda #<(start-1)
 pha
 pha
 txa
 pha
 tsx
 if bankswitch != 64
   lda 4,x ; get high byte of return address
   rol
   rol
   rol
   rol
   and #bs_mask ;1 3 or 7 for F8/F6/F4
   tax
   inx
 else
   lda 4,x ; get high byte of return address
   tay
   ora #$10 ; change our bank nibble into a valid rom mirror
   sta 4,x
   tya
   lsr 
   lsr 
   lsr 
   lsr 
   tax
   inx
 endif
 lda bankswitch_hotspot-1,x
 pla
 tax
 pla
 rts
 if ((* & $1FFF) > ((bankswitch_hotspot & $1FFF) - 1))
   echo "WARNING: size parameter in banksw.asm too small - the program probably will not work."
   echo "Change to",[(*-begin_bscode+1)&$FF]d,"and try again."
 endif
 ORG $2FFC
 RORG $3FFC
 .word (start_bank2 & $ffff)
 .word (start_bank2 & $ffff)
 ORG $3000
 RORG $5000
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Draw
 ; __Draw

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0667 ;  _Animation_Timer  =  _Animation_Timer  +  1

	INC _Animation_Timer
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0668 ;  if _Enemy_Type  >  63 then goto __Draw_Boss

	LDA #63
	CMP _Enemy_Type
     BCS .skipL0668
.condpart355
 jmp .__Draw_Boss

.skipL0668
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0669 ;  if _Animation_Timer  >  7 then _Animation_Timer  =  0  :  _Level_Timer  =  _Level_Timer  +  1

	LDA #7
	CMP _Animation_Timer
     BCS .skipL0669
.condpart356
	LDA #0
	STA _Animation_Timer
	INC _Level_Timer
.skipL0669
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0670 ;  if _Level_Timer  >  6  &&  _Bit7_Mario_Invincibility{7}  &&  _Star_Invincibility_Timer  =  0 then _Bit7_Mario_Invincibility{7}  =  0

	LDA #6
	CMP _Level_Timer
     BCS .skipL0670
.condpart357
	BIT _Bit7_Mario_Invincibility
	BPL .skip357then
.condpart358
	LDA _Star_Invincibility_Timer
	CMP #0
     BNE .skip358then
.condpart359
	LDA _Bit7_Mario_Invincibility
	AND #127
	STA _Bit7_Mario_Invincibility
.skip358then
.skip357then
.skipL0670
.
 ; 

.L0671 ;  if _Star_Invincibility_Timer  >  0 then _Star_Invincibility_Timer  =  _Star_Invincibility_Timer  +  1

	LDA #0
	CMP _Star_Invincibility_Timer
     BCS .skipL0671
.condpart360
	INC _Star_Invincibility_Timer
.skipL0671
.
 ; 

.L0672 ;  if _Star_Invincibility_Timer  =  160 then gosub __Star_Power_End

	LDA _Star_Invincibility_Timer
	CMP #160
     BNE .skipL0672
.condpart361
 jsr .__Star_Power_End

.skipL0672
.
 ; 

.L0673 ;  if _Level_Timer  >  25 then _Level_Timer  =  0  :  pfscore1  =  pfscore1 / 2

	LDA #25
	CMP _Level_Timer
     BCS .skipL0673
.condpart362
	LDA #0
	STA _Level_Timer
	LDA pfscore1
	lsr
	STA pfscore1
.skipL0673
.
 ; 

.L0674 ;  if pfscore1  =  0 then goto __Mario_Death

	LDA pfscore1
	CMP #0
     BNE .skipL0674
.condpart363
 jmp .__Mario_Death

.skipL0674
.
 ; 

.L0675 ;  if pfscore1  <  6  &&  pfscore1  >  2  &&  _Level_Timer  <  5 then AUDV0  =  10  :  AUDC0  =  1  :  AUDF0  =  10

	LDA pfscore1
	CMP #6
     BCS .skipL0675
.condpart364
	LDA #2
	CMP pfscore1
     BCS .skip364then
.condpart365
	LDA _Level_Timer
	CMP #5
     BCS .skip365then
.condpart366
	LDA #10
	STA AUDV0
	LDA #1
	STA AUDC0
	LDA #10
	STA AUDF0
.skip365then
.skip364then
.skipL0675
.
 ; 

.L0676 ;  goto __Draw_2

 jmp .__Draw_2

.
 ; 

.__Draw_Boss
 ; __Draw_Boss

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0677 ;  if _Animation_Timer  >  7 then _Animation_Timer  =  0

	LDA #7
	CMP _Animation_Timer
     BCS .skipL0677
.condpart367
	LDA #0
	STA _Animation_Timer
.skipL0677
.
 ; 

.L0678 ;  if _Star_Invincibility_Timer  >  0 then _Star_Invincibility_Timer  =  _Star_Invincibility_Timer  +  1

	LDA #0
	CMP _Star_Invincibility_Timer
     BCS .skipL0678
.condpart368
	INC _Star_Invincibility_Timer
.skipL0678
.
 ; 

.L0679 ;  if _Star_Invincibility_Timer  =  40 then _Star_Invincibility_Timer  =  0  :  _Bit7_Mario_On_Off{7}  =  0  :  _Bit7_Mario_Invincibility{7}  =  0

	LDA _Star_Invincibility_Timer
	CMP #40
     BNE .skipL0679
.condpart369
	LDA #0
	STA _Star_Invincibility_Timer
	LDA _Bit7_Mario_On_Off
	AND #127
	STA _Bit7_Mario_On_Off
	LDA _Bit7_Mario_Invincibility
	AND #127
	STA _Bit7_Mario_Invincibility
.skipL0679
.
 ; 

.__Draw_2
 ; __Draw_2

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0680 ;  if player0y  >  94 then goto __Mario_Death

	LDA #94
	CMP player0y
     BCS .skipL0680
.condpart370
 jmp .__Mario_Death

.skipL0680
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0681 ;  if _Level  =  3  &&  _Level_Data_Pointer  >  126  &&  player1y  >  96 then _Enemy_Type  =  _Trampoline  :  player1x  =  135  :  player1y  =  79

	LDA _Level
	CMP #3
     BNE .skipL0681
.condpart371
	LDA #126
	CMP _Level_Data_Pointer
     BCS .skip371then
.condpart372
	LDA #96
	CMP player1y
     BCS .skip372then
.condpart373
	LDA #_Trampoline
	STA _Enemy_Type
	LDA #135
	STA player1x
	LDA #79
	STA player1y
.skip372then
.skip371then
.skipL0681
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0682 ;  if !joy0down then _Bit5_Ducking_Flag{5}  =  0

 lda #$20
 bit SWCHA
	BEQ .skipL0682
.condpart374
	LDA _Bit5_Ducking_Flag
	AND #223
	STA _Bit5_Ducking_Flag
.skipL0682
.
 ; 

.L0683 ;  if joy0down  &&  player0y  =  63  &&  _Momentum_Up_Down  =  0  &&  player0x  >  110 then goto __Checkpoint

 lda #$20
 bit SWCHA
	BNE .skipL0683
.condpart375
	LDA player0y
	CMP #63
     BNE .skip375then
.condpart376
	LDA _Momentum_Up_Down
	CMP #0
     BNE .skip376then
.condpart377
	LDA #110
	CMP player0x
     BCS .skip377then
.condpart378
 jmp .__Checkpoint

.skip377then
.skip376then
.skip375then
.skipL0683
.
 ; 

.__More_Joy_Checks
 ; __More_Joy_Checks

.
 ; 

.L0684 ;  if joy0down  &&  !_Bit6_Regular_Mario{6} then _Bit5_Ducking_Flag{5}  =  1

 lda #$20
 bit SWCHA
	BNE .skipL0684
.condpart379
	BIT _Bit6_Regular_Mario
	BVS .skip379then
.condpart380
	LDA _Bit5_Ducking_Flag
	ORA #32
	STA _Bit5_Ducking_Flag
.skip379then
.skipL0684
.
 ; 

.L0685 ;  if joy0left  &&  !_Bit5_Ducking_Flag{5} then _Bit0_Player_Facing_Direction{0}  =  1  :  goto __Moving

 bit SWCHA
	BVS .skipL0685
.condpart381
	LDA _Bit5_Ducking_Flag
	AND #32
	BNE .skip381then
.condpart382
	LDA _Bit0_Player_Facing_Direction
	ORA #1
	STA _Bit0_Player_Facing_Direction
 jmp .__Moving

.skip381then
.skipL0685
.
 ; 

.L0686 ;  if joy0right  &&  !_Bit5_Ducking_Flag{5} then _Bit0_Player_Facing_Direction{0}  =  0  :  goto __Moving

 bit SWCHA
	BMI .skipL0686
.condpart383
	LDA _Bit5_Ducking_Flag
	AND #32
	BNE .skip383then
.condpart384
	LDA _Bit0_Player_Facing_Direction
	AND #254
	STA _Bit0_Player_Facing_Direction
 jmp .__Moving

.skip383then
.skipL0686
.
 ; 

.L0687 ;  if _Momentum_Left_Right  >  0 then _Momentum_Left_Right  =  _Momentum_Left_Right  -  1

	LDA #0
	CMP _Momentum_Left_Right
     BCS .skipL0687
.condpart385
	DEC _Momentum_Left_Right
.skipL0687
.
 ; 

.L0688 ;  goto __Check_Fire

 jmp .__Check_Fire

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Moving
 ; __Moving

.L0689 ;  _Momentum_Left_Right  =  _Momentum_Left_Right  +  1

	INC _Momentum_Left_Right
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0690 ;  if _Bit0_Genesis_Controller{0}  &&  !INPT1{7}  &&  _Momentum_Left_Right  >  4 then _Momentum_Left_Right  =  4

	LDA _Bit0_Genesis_Controller
	LSR
	BCC .skipL0690
.condpart386
	BIT INPT1
	BMI .skip386then
.condpart387
	LDA #4
	CMP _Momentum_Left_Right
     BCS .skip387then
.condpart388
	LDA #4
	STA _Momentum_Left_Right
.skip387then
.skip386then
.skipL0690
.
 ; 

.L0691 ;  if _Bit0_Genesis_Controller{0}  &&  INPT1{7}  &&  _Momentum_Left_Right  >  2 then _Momentum_Left_Right  =  2

	LDA _Bit0_Genesis_Controller
	LSR
	BCC .skipL0691
.condpart389
	BIT INPT1
	BPL .skip389then
.condpart390
	LDA #2
	CMP _Momentum_Left_Right
     BCS .skip390then
.condpart391
	LDA #2
	STA _Momentum_Left_Right
.skip390then
.skip389then
.skipL0691
.
 ; 

.L0692 ;  if _Bit0_Genesis_Controller{0} then goto __Check_Fire

	LDA _Bit0_Genesis_Controller
	LSR
	BCC .skipL0692
.condpart392
 jmp .__Check_Fire

.skipL0692
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0693 ;  if joy0up  &&  _Momentum_Left_Right  >  4 then _Momentum_Left_Right  =  4

 lda #$10
 bit SWCHA
	BNE .skipL0693
.condpart393
	LDA #4
	CMP _Momentum_Left_Right
     BCS .skip393then
.condpart394
	LDA #4
	STA _Momentum_Left_Right
.skip393then
.skipL0693
.
 ; 

.L0694 ;  if !joy0up  &&  _Momentum_Left_Right  >  2 then _Momentum_Left_Right  =  2

 lda #$10
 bit SWCHA
	BEQ .skipL0694
.condpart395
	LDA #2
	CMP _Momentum_Left_Right
     BCS .skip395then
.condpart396
	LDA #2
	STA _Momentum_Left_Right
.skip395then
.skipL0694
.
 ; 

.__Check_Fire
 ; __Check_Fire

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0695 ;  if _Bit0_Genesis_Controller{0}  &&  INPT1{7} then _Bit1_Genesis_Button_Pressed{1}  =  0

	LDA _Bit0_Genesis_Controller
	LSR
	BCC .skipL0695
.condpart397
	BIT INPT1
	BPL .skip397then
.condpart398
	LDA _Bit1_Genesis_Button_Pressed
	AND #253
	STA _Bit1_Genesis_Button_Pressed
.skip397then
.skipL0695
.
 ; 

.L0696 ;  if _Bit0_Genesis_Controller{0}  &&  !INPT1{7}  &&  _Bit4_Firey_Mario_Power{4}  &&  ballx  =  0  &&  !_Bit1_Genesis_Button_Pressed{1} then gosub __Init_Fire

	LDA _Bit0_Genesis_Controller
	LSR
	BCC .skipL0696
.condpart399
	BIT INPT1
	BMI .skip399then
.condpart400
	LDA _Bit4_Firey_Mario_Power
	AND #16
	BEQ .skip400then
.condpart401
	LDA ballx
	CMP #0
     BNE .skip401then
.condpart402
	LDA _Bit1_Genesis_Button_Pressed
	AND #2
	BNE .skip402then
.condpart403
 jsr .__Init_Fire

.skip402then
.skip401then
.skip400then
.skip399then
.skipL0696
.
 ; 

.L0697 ;  if _Bit0_Genesis_Controller{0} then goto __Check_Jump

	LDA _Bit0_Genesis_Controller
	LSR
	BCC .skipL0697
.condpart404
 jmp .__Check_Jump

.skipL0697
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0698 ;  if !joy0up then _Bit1_Genesis_Button_Pressed{1}  =  0

 lda #$10
 bit SWCHA
	BEQ .skipL0698
.condpart405
	LDA _Bit1_Genesis_Button_Pressed
	AND #253
	STA _Bit1_Genesis_Button_Pressed
.skipL0698
.
 ; 

.L0699 ;  if joy0up  &&  _Bit4_Firey_Mario_Power{4}  &&  ballx  =  0  &&  !_Bit1_Genesis_Button_Pressed{1} then gosub __Init_Fire

 lda #$10
 bit SWCHA
	BNE .skipL0699
.condpart406
	LDA _Bit4_Firey_Mario_Power
	AND #16
	BEQ .skip406then
.condpart407
	LDA ballx
	CMP #0
     BNE .skip407then
.condpart408
	LDA _Bit1_Genesis_Button_Pressed
	AND #2
	BNE .skip408then
.condpart409
 jsr .__Init_Fire

.skip408then
.skip407then
.skip406then
.skipL0699
.
 ; 

.__Check_Jump
 ; __Check_Jump

.
 ; 

.L0700 ;  if !joy0fire then _Bit2_Fire_Button_Pressed{2}  =  0

 bit INPT4
	BPL .skipL0700
.condpart410
	LDA _Bit2_Fire_Button_Pressed
	AND #251
	STA _Bit2_Fire_Button_Pressed
.skipL0700
.
 ; 

.L0701 ;  if joy0fire  &&  !_Bit1_Jumping_Flag{1}  &&  _Momentum_Up_Down  =  0  &&  !_Bit2_Fire_Button_Pressed{2} then gosub __Init_Jump

 bit INPT4
	BMI .skipL0701
.condpart411
	LDA _Bit1_Jumping_Flag
	AND #2
	BNE .skip411then
.condpart412
	LDA _Momentum_Up_Down
	CMP #0
     BNE .skip412then
.condpart413
	LDA _Bit2_Fire_Button_Pressed
	AND #4
	BNE .skip413then
.condpart414
 jsr .__Init_Jump

.skip413then
.skip412then
.skip411then
.skipL0701
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0702 ;  if !_Bit1_Jumping_Flag{1} then goto __Check_Shell

	LDA _Bit1_Jumping_Flag
	AND #2
	BNE .skipL0702
.condpart415
 jmp .__Check_Shell

.skipL0702
.
 ; 

.L0703 ;  temp4  =  6  +  _Momentum_Up_Down

	LDA #6
	CLC
	ADC _Momentum_Up_Down
	STA temp4
.
 ; 

.L0704 ;  AUDV0  =  12

	LDA #12
	STA AUDV0
.L0705 ;  AUDC0  =  12

	LDA #12
	STA AUDC0
.L0706 ;  AUDF0  =  temp4

	LDA temp4
	STA AUDF0
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Check_Shell
 ; __Check_Shell

.
 ; 

.L0707 ;  if _Moving_Shell_X_Coordinate  =  0  &&  _Moving_Shell_Y_Coordinate  =  0 then goto __Music_Part

	LDA _Moving_Shell_X_Coordinate
	CMP #0
     BNE .skipL0707
.condpart416
	LDA _Moving_Shell_Y_Coordinate
	CMP #0
     BNE .skip416then
.condpart417
 jmp .__Music_Part

.skip416then
.skipL0707
.
 ; 

.L0708 ;  pfpixel _Moving_Shell_X_Coordinate _Moving_Shell_Y_Coordinate off

	LDX #1
	LDY _Moving_Shell_Y_Coordinate
	LDA _Moving_Shell_X_Coordinate
 sta temp7
 lda #>(ret_point42-1)
 pha
 lda #<(ret_point42-1)
 pha
 lda #>(pfpixel-1)
 pha
 lda #<(pfpixel-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #8
 jmp BS_jsr
ret_point42
.
 ; 

.L0709 ;  x  =  _Moving_Shell_X_Coordinate  +  1

	LDA _Moving_Shell_X_Coordinate
	CLC
	ADC #1
	STA x
.
 ; 

.L0710 ;  pfpixel x _Moving_Shell_Y_Coordinate off

	LDX #1
	LDY _Moving_Shell_Y_Coordinate
	LDA x
 sta temp7
 lda #>(ret_point43-1)
 pha
 lda #<(ret_point43-1)
 pha
 lda #>(pfpixel-1)
 pha
 lda #<(pfpixel-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #8
 jmp BS_jsr
ret_point43
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Music_Part
 ; __Music_Part

.
 ; 

.L0711 ;  if _Star_Invincibility_Timer  >  0  &&  _Enemy_Type  <  63 then goto __Get_Star_Music bank7

	LDA #0
	CMP _Star_Invincibility_Timer
     BCS .skipL0711
.condpart418
	LDA _Enemy_Type
	CMP #63
     BCS .skip418then
.condpart419
 sta temp7
 lda #>(.__Get_Star_Music-1)
 pha
 lda #<(.__Get_Star_Music-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #7
 jmp BS_jsr
.skip418then
.skipL0711
.
 ; 

.L0712 ;  if _Level  =  1  ||  _Level  =  3 then goto __Get_Music bank7

	LDA _Level
	CMP #1
     BNE .skipL0712
.condpart420
 jmp .condpart421
.skipL0712
	LDA _Level
	CMP #3
     BNE .skip122OR
.condpart421
 sta temp7
 lda #>(.__Get_Music-1)
 pha
 lda #<(.__Get_Music-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #7
 jmp BS_jsr
.skip122OR
.
 ; 

.L0713 ;  if _Level  =  2  ||  _Level  =  4 then goto __Get_UW_Music bank7

	LDA _Level
	CMP #2
     BNE .skipL0713
.condpart422
 jmp .condpart423
.skipL0713
	LDA _Level
	CMP #4
     BNE .skip123OR
.condpart423
 sta temp7
 lda #>(.__Get_UW_Music-1)
 pha
 lda #<(.__Get_UW_Music-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #7
 jmp BS_jsr
.skip123OR
.
 ; 

.__Got_Music
 ; __Got_Music

.
 ; 

.L0714 ;  goto __Main_2 bank1

 sta temp7
 lda #>(.__Main_2-1)
 pha
 lda #<(.__Main_2-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
.
 ; 

.__Init_Jump
 ; __Init_Jump

.
 ; 

.L0715 ;  _Bit1_Jumping_Flag{1}  =  1  :  _Momentum_Up_Down  =  7  :  _Bit2_Fire_Button_Pressed{2}  =  1

	LDA _Bit1_Jumping_Flag
	ORA #2
	STA _Bit1_Jumping_Flag
	LDA #7
	STA _Momentum_Up_Down
	LDA _Bit2_Fire_Button_Pressed
	ORA #4
	STA _Bit2_Fire_Button_Pressed
.
 ; 

.L0716 ;  if _Momentum_Left_Right  =  4 then _Momentum_Up_Down  =  8

	LDA _Momentum_Left_Right
	CMP #4
     BNE .skipL0716
.condpart424
	LDA #8
	STA _Momentum_Up_Down
.skipL0716
.
 ; 

.L0717 ;  return thisbank

	RTS
.
 ; 

.__Init_Fire
 ; __Init_Fire

.
 ; 

.L0718 ;  if _Bit0_Player_Facing_Direction{0} then ballx  =  player0x  :  _Bit2_Mario_Fireball_Direction{2}  =  0 else ballx  =  player0x  +  4  :  _Bit2_Mario_Fireball_Direction{2}  =  1

	LDA _Bit0_Player_Facing_Direction
	LSR
	BCC .skipL0718
.condpart425
	LDA player0x
	STA ballx
	LDA _Bit2_Mario_Fireball_Direction
	AND #251
	STA _Bit2_Mario_Fireball_Direction
 jmp .skipelse66
.skipL0718
	LDA player0x
	CLC
	ADC #4
	STA ballx
	LDA _Bit2_Mario_Fireball_Direction
	ORA #4
	STA _Bit2_Mario_Fireball_Direction
.skipelse66
.
 ; 

.L0719 ;  bally  =  player0y  -  8

	LDA player0y
	SEC
	SBC #8
	STA bally
.
 ; 

.L0720 ;  _Bit0_Mario_Fireball_Going_Down{0}  =  1  :  _Bit1_Genesis_Button_Pressed{1}  =  1

	LDA _Bit0_Mario_Fireball_Going_Down
	ORA #1
	STA _Bit0_Mario_Fireball_Going_Down
	LDA _Bit1_Genesis_Button_Pressed
	ORA #2
	STA _Bit1_Genesis_Button_Pressed
.
 ; 

.L0721 ;  AUDV0  =  12

	LDA #12
	STA AUDV0
.L0722 ;  AUDC0  =  14

	LDA #14
	STA AUDC0
.L0723 ;  AUDF0  =  0

	LDA #0
	STA AUDF0
.
 ; 

.L0724 ;  return thisbank

	RTS
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Enemy_Hit
 ; __Enemy_Hit

.
 ; 

.L0725 ;  if _Enemy_Type  =  _Two_Thwomps then goto __Draw

	LDA _Enemy_Type
	CMP #_Two_Thwomps
     BNE .skipL0725
.condpart426
 jmp .__Draw

.skipL0725
.
 ; 

.L0726 ;  score  =  score  +  200

	SED
	CLC
	LDA score+1
	ADC #$02
	STA score+1
	LDA score
	ADC #$00
	STA score
	CLD
.
 ; 

.L0727 ;  if _Enemy_Type  <  _Flagpole  &&  _Star_Invincibility_Timer  =  0 then _Bit1_Jumping_Flag{1}  =  1  :  _Momentum_Up_Down  =  2  :  _Bit2_Fire_Button_Pressed{2}  =  1

	LDA _Enemy_Type
	CMP #_Flagpole
     BCS .skipL0727
.condpart427
	LDA _Star_Invincibility_Timer
	CMP #0
     BNE .skip427then
.condpart428
	LDA _Bit1_Jumping_Flag
	ORA #2
	STA _Bit1_Jumping_Flag
	LDA #2
	STA _Momentum_Up_Down
	LDA _Bit2_Fire_Button_Pressed
	ORA #4
	STA _Bit2_Fire_Button_Pressed
.skip427then
.skipL0727
.
 ; 

.L0728 ;  if _Enemy_Type  >  41  &&  _Star_Invincibility_Timer  =  0 then _Bit1_Jumping_Flag{1}  =  1  :  _Momentum_Up_Down  =  2  :  _Bit2_Fire_Button_Pressed{2}  =  1

	LDA #41
	CMP _Enemy_Type
     BCS .skipL0728
.condpart429
	LDA _Star_Invincibility_Timer
	CMP #0
     BNE .skip429then
.condpart430
	LDA _Bit1_Jumping_Flag
	ORA #2
	STA _Bit1_Jumping_Flag
	LDA #2
	STA _Momentum_Up_Down
	LDA _Bit2_Fire_Button_Pressed
	ORA #4
	STA _Bit2_Fire_Button_Pressed
.skip429then
.skipL0728
.
 ; 

.L0729 ;  if _Star_Invincibility_Timer  >  0  &&  _Enemy_Type  >  41 then goto __Double_To_Single

	LDA #0
	CMP _Star_Invincibility_Timer
     BCS .skipL0729
.condpart431
	LDA #41
	CMP _Enemy_Type
     BCS .skip431then
.condpart432
 jmp .__Double_To_Single

.skip431then
.skipL0729
.
 ; 

.L0730 ;  if _Star_Invincibility_Timer  >  0 then goto __Enemy_Hit_2

	LDA #0
	CMP _Star_Invincibility_Timer
     BCS .skipL0730
.condpart433
 jmp .__Enemy_Hit_2

.skipL0730
.
 ; 

.L0731 ;  if _Enemy_Type  <  _Fireball_Enemy  &&  joy0fire then _Momentum_Up_Down  =  6

	LDA _Enemy_Type
	CMP #_Fireball_Enemy
     BCS .skipL0731
.condpart434
 bit INPT4
	BMI .skip434then
.condpart435
	LDA #6
	STA _Momentum_Up_Down
.skip434then
.skipL0731
.
 ; 

.L0732 ;  if _Enemy_Type  >  41  &&  joy0fire then _Momentum_Up_Down  =  6  :  AUDV0  =  12  :  AUDC0  =  4  :  AUDF0  =  24

	LDA #41
	CMP _Enemy_Type
     BCS .skipL0732
.condpart436
 bit INPT4
	BMI .skip436then
.condpart437
	LDA #6
	STA _Momentum_Up_Down
	LDA #12
	STA AUDV0
	LDA #4
	STA AUDC0
	LDA #24
	STA AUDF0
.skip436then
.skipL0732
.
 ; 

.L0733 ;  if !joy0fire then player0y  =  player0y  -  3

 bit INPT4
	BPL .skipL0733
.condpart438
	LDA player0y
	SEC
	SBC #3
	STA player0y
.skipL0733
.
 ; 

.L0734 ;  if _Enemy_Type  >  41 then goto __Double_To_Single

	LDA #41
	CMP _Enemy_Type
     BCS .skipL0734
.condpart439
 jmp .__Double_To_Single

.skipL0734
.
 ; 

.L0735 ;  if _Enemy_Type  =  _Flying_Green_Koopa then _Enemy_Type  =  _Green_Koopa  :  goto __Draw

	LDA _Enemy_Type
	CMP #_Flying_Green_Koopa
     BNE .skipL0735
.condpart440
	LDA #_Green_Koopa
	STA _Enemy_Type
 jmp .__Draw

.skipL0735
.
 ; 

.L0736 ;  if _Enemy_Type  =  _Flying_Red_Koopa then _Enemy_Type  =  _Red_Koopa  :  _Enemy_Momentum  =  8  :  goto __Draw

	LDA _Enemy_Type
	CMP #_Flying_Red_Koopa
     BNE .skipL0736
.condpart441
	LDA #_Red_Koopa
	STA _Enemy_Type
	LDA #8
	STA _Enemy_Momentum
 jmp .__Draw

.skipL0736
.
 ; 

.L0737 ;  if _Enemy_Type  =  _Green_Koopa then _Enemy_Type  =  _Green_Shell  :  goto __Draw

	LDA _Enemy_Type
	CMP #_Green_Koopa
     BNE .skipL0737
.condpart442
	LDA #_Green_Shell
	STA _Enemy_Type
 jmp .__Draw

.skipL0737
.
 ; 

.L0738 ;  if _Enemy_Type  =  _Beetle then _Enemy_Type  =  _Beetle_Shell  :  goto __Draw

	LDA _Enemy_Type
	CMP #_Beetle
     BNE .skipL0738
.condpart443
	LDA #_Beetle_Shell
	STA _Enemy_Type
 jmp .__Draw

.skipL0738
.
 ; 

.L0739 ;  if _Enemy_Type  =  _Red_Koopa then _Enemy_Type  =  _Red_Shell  :  goto __Draw

	LDA _Enemy_Type
	CMP #_Red_Koopa
     BNE .skipL0739
.condpart444
	LDA #_Red_Shell
	STA _Enemy_Type
 jmp .__Draw

.skipL0739
.
 ; 

.L0740 ;  if _Enemy_Type  >  _P_Plant_31  &&  _Enemy_Type  <  _Trampoline then goto __Init_Kicked_Shell

	LDA #_P_Plant_31
	CMP _Enemy_Type
     BCS .skipL0740
.condpart445
	LDA _Enemy_Type
	CMP #_Trampoline
     BCS .skip445then
.condpart446
 jmp .__Init_Kicked_Shell

.skip445then
.skipL0740
.
 ; 

.__Enemy_Hit_2
 ; __Enemy_Hit_2

.
 ; 

.L0741 ;  player1y  =  player1y  -  3

	LDA player1y
	SEC
	SBC #3
	STA player1y
.
 ; 

.L0742 ;  _Bit4_Enemy_Dead_Flag{4}  =  1

	LDA _Bit4_Enemy_Dead_Flag
	ORA #16
	STA _Bit4_Enemy_Dead_Flag
.
 ; 

.L0743 ;  goto __Draw

 jmp .__Draw

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Double_To_Single
 ; __Double_To_Single

.
 ; 

.L0744 ;  _Enemy_Type  =  _Enemy_Type  -  42

	LDA _Enemy_Type
	SEC
	SBC #42
	STA _Enemy_Type
.
 ; 

.L0745 ;  x  =  player1x  +  8

	LDA player1x
	CLC
	ADC #8
	STA x
.
 ; 

.L0746 ;  if player0x  <  x then player1x  =  player1x  +  16

	LDA player0x
	CMP x
     BCS .skipL0746
.condpart447
	LDA player1x
	CLC
	ADC #16
	STA player1x
.skipL0746
.
 ; 

.L0747 ;  goto __Draw

 jmp .__Draw

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Enemy_Hit_By_Fireball
 ; __Enemy_Hit_By_Fireball

.
 ; 

.L0748 ;  if _Enemy_Type  =  _Bowser_Jr then goto __Fireball_BJr_Collision bank4

	LDA _Enemy_Type
	CMP #_Bowser_Jr
     BNE .skipL0748
.condpart448
 sta temp7
 lda #>(.__Fireball_BJr_Collision-1)
 pha
 lda #<(.__Fireball_BJr_Collision-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
.skipL0748
.
 ; 

.L0749 ;  if _Enemy_Type  =  _Kinetic_Platforms then goto __Draw

	LDA _Enemy_Type
	CMP #_Kinetic_Platforms
     BNE .skipL0749
.condpart449
 jmp .__Draw

.skipL0749
.
 ; 

.L0750 ;  if _Enemy_Type  <  _Two_Goombas then ballx  =  0  :  bally  =  120

	LDA _Enemy_Type
	CMP #_Two_Goombas
     BCS .skipL0750
.condpart450
	LDA #0
	STA ballx
	LDA #120
	STA bally
.skipL0750
.
 ; 

.L0751 ;  if _Enemy_Type  =  _Beetle then goto __Draw

	LDA _Enemy_Type
	CMP #_Beetle
     BNE .skipL0751
.condpart451
 jmp .__Draw

.skipL0751
.
 ; 

.L0752 ;  if _Enemy_Type  =  _Bullet_Bill then goto __Draw

	LDA _Enemy_Type
	CMP #_Bullet_Bill
     BNE .skipL0752
.condpart452
 jmp .__Draw

.skipL0752
.
 ; 

.L0753 ;  if _Enemy_Type  =  _Beetle_Shell then goto __Draw

	LDA _Enemy_Type
	CMP #_Beetle_Shell
     BNE .skipL0753
.condpart453
 jmp .__Draw

.skipL0753
.
 ; 

.L0754 ;  if _Enemy_Type  =  _Trampoline then goto __Draw

	LDA _Enemy_Type
	CMP #_Trampoline
     BNE .skipL0754
.condpart454
 jmp .__Draw

.skipL0754
.
 ; 

.L0755 ;  if _Enemy_Type  =  _Thwomp  ||  _Enemy_Type  =  _Two_Thwomps then goto __Draw

	LDA _Enemy_Type
	CMP #_Thwomp
     BNE .skipL0755
.condpart455
 jmp .condpart456
.skipL0755
	LDA _Enemy_Type
	CMP #_Two_Thwomps
     BNE .skip130OR
.condpart456
 jmp .__Draw

.skip130OR
.
 ; 

.L0756 ;  if _Enemy_Type  >  17  &&  _Enemy_Type  <  29 then goto __Draw

	LDA #17
	CMP _Enemy_Type
     BCS .skipL0756
.condpart457
	LDA _Enemy_Type
	CMP #29
     BCS .skip457then
.condpart458
 jmp .__Draw

.skip457then
.skipL0756
.
 ; 

.L0757 ;  if _Enemy_Type  =  _Spiney_Ball then _Enemy_Type  =  _Spiney

	LDA _Enemy_Type
	CMP #_Spiney_Ball
     BNE .skipL0757
.condpart459
	LDA #_Spiney
	STA _Enemy_Type
.skipL0757
.
 ; 

.L0758 ;  score  =  score  +  100

	SED
	CLC
	LDA score+1
	ADC #$01
	STA score+1
	LDA score
	ADC #$00
	STA score
	CLD
.
 ; 

.L0759 ;  if _Enemy_Type  >  41 then goto __Double_To_Single_Fire

	LDA #41
	CMP _Enemy_Type
     BCS .skipL0759
.condpart460
 jmp .__Double_To_Single_Fire

.skipL0759
.
 ; 

.L0760 ;  player1y  =  player1y  -  3

	LDA player1y
	SEC
	SBC #3
	STA player1y
.
 ; 

.L0761 ;  _Bit4_Enemy_Dead_Flag{4}  =  1

	LDA _Bit4_Enemy_Dead_Flag
	ORA #16
	STA _Bit4_Enemy_Dead_Flag
.
 ; 

.L0762 ;  goto __Draw

 jmp .__Draw

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Double_To_Single_Fire
 ; __Double_To_Single_Fire

.
 ; 

.L0763 ;  if _Enemy_Type  =  _Two_Goombas then _Enemy_Type  =  _Goomba else _Enemy_Type  =  _Spiney

	LDA _Enemy_Type
	CMP #_Two_Goombas
     BNE .skipL0763
.condpart461
	LDA #_Goomba
	STA _Enemy_Type
 jmp .skipelse67
.skipL0763
	LDA #_Spiney
	STA _Enemy_Type
.skipelse67
.
 ; 

.L0764 ;  x  =  player1x  +  8

	LDA player1x
	CLC
	ADC #8
	STA x
.
 ; 

.L0765 ;  if ballx  <  x then player1x  =  player1x  +  16

	LDA ballx
	CMP x
     BCS .skipL0765
.condpart462
	LDA player1x
	CLC
	ADC #16
	STA player1x
.skipL0765
.
 ; 

.L0766 ;  ballx  =  0  :  bally  =  120

	LDA #0
	STA ballx
	LDA #120
	STA bally
.
 ; 

.L0767 ;  goto __Draw

 jmp .__Draw

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Init_Kicked_Shell
 ; __Init_Kicked_Shell

.
 ; 

.L0768 ;  player0y  =  player0y  +  3

	LDA player0y
	CLC
	ADC #3
	STA player0y
.
 ; 

.L0769 ;  _Enemy_Type  =  _Goomba  :  _Bit3_Enemy_Direction{3}  =  0  :  _Enemy_Momentum  =  0  :  _Bit4_Enemy_Dead_Flag{4}  =  0

	LDA #_Goomba
	STA _Enemy_Type
	LDA _Bit3_Enemy_Direction
	AND #247
	STA _Bit3_Enemy_Direction
	LDA #0
	STA _Enemy_Momentum
	LDA _Bit4_Enemy_Dead_Flag
	AND #239
	STA _Bit4_Enemy_Dead_Flag
.
 ; 

.L0770 ;  if !_Bit0_Player_Facing_Direction{0} then _Bit5_Moving_Turtle_Shell_Direction{5}  =  0 else _Bit5_Moving_Turtle_Shell_Direction{5}  =  1

	LDA _Bit0_Player_Facing_Direction
	LSR
	BCS .skipL0770
.condpart463
	LDA _Bit5_Moving_Turtle_Shell_Direction
	AND #223
	STA _Bit5_Moving_Turtle_Shell_Direction
 jmp .skipelse68
.skipL0770
	LDA _Bit5_Moving_Turtle_Shell_Direction
	ORA #32
	STA _Bit5_Moving_Turtle_Shell_Direction
.skipelse68
.
 ; 

.L0771 ;  _Moving_Shell_X_Coordinate  =   ( player1x  -  13 )  / 4  :  _Moving_Shell_Y_Coordinate  =   ( player1y  -  4 )  / 8

; complex statement detected
	LDA player1x
	SEC
	SBC #13
	lsr
	lsr
	STA _Moving_Shell_X_Coordinate
; complex statement detected
	LDA player1y
	SEC
	SBC #4
	lsr
	lsr
	lsr
	STA _Moving_Shell_Y_Coordinate
.
 ; 

.L0772 ;  if _Bit5_Moving_Turtle_Shell_Direction{5} then _Moving_Shell_X_Coordinate  =  _Moving_Shell_X_Coordinate  -  1 else _Moving_Shell_X_Coordinate  =  _Moving_Shell_X_Coordinate  +  1

	LDA _Bit5_Moving_Turtle_Shell_Direction
	AND #32
	BEQ .skipL0772
.condpart464
	DEC _Moving_Shell_X_Coordinate
 jmp .skipelse69
.skipL0772
	INC _Moving_Shell_X_Coordinate
.skipelse69
.
 ; 

.L0773 ;  player1x  =  0  :  player1y  =  150

	LDA #0
	STA player1x
	LDA #150
	STA player1y
.
 ; 

.L0774 ;  goto __Draw

 jmp .__Draw

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Mario_Death
 ; __Mario_Death

.
 ; 

.L0775 ;  if player0y  >  94 then player0y  =  150

	LDA #94
	CMP player0y
     BCS .skipL0775
.condpart465
	LDA #150
	STA player0y
.skipL0775
.
 ; 

.L0776 ;  gosub __Death_Music bank7

 sta temp7
 lda #>(ret_point44-1)
 pha
 lda #<(ret_point44-1)
 pha
 lda #>(.__Death_Music-1)
 pha
 lda #<(.__Death_Music-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #7
 jmp BS_jsr
ret_point44
.
 ; 

.L0777 ;  gosub __Mario_Die

 jsr .__Mario_Die

.
 ; 

.L0778 ;  p  =  1  :  _Lives_Counter  =  _Lives_Counter  -  1  :  _Bit6_Regular_Mario{6}  =  1  :  _Bit4_Firey_Mario_Power{4}  =  0  :  _Bit3_Super_Mario_Power{3}  =  0  :  _Moving_Shell_X_Coordinate  =  0  :  _Moving_Shell_Y_Coordinate  =  0

	LDA #1
	STA p
	DEC _Lives_Counter
	LDA _Bit6_Regular_Mario
	ORA #64
	STA _Bit6_Regular_Mario
	LDA _Bit4_Firey_Mario_Power
	AND #239
	STA _Bit4_Firey_Mario_Power
	LDA _Bit3_Super_Mario_Power
	AND #247
	STA _Bit3_Super_Mario_Power
	LDA #0
	STA _Moving_Shell_X_Coordinate
	STA _Moving_Shell_Y_Coordinate
.
 ; 

.L0779 ;  ballx  =  0  :  bally  =  150

	LDA #0
	STA ballx
	LDA #150
	STA bally
.
 ; 

.L0780 ;  for x  =  6 to 0 step -1

	LDA #6
	STA x
.L0780forx
.
 ; 

.L0781 ;  if player0y  <>  150 then player0y  =  player0y  -  x

	LDA player0y
	CMP #150
     BEQ .skipL0781
.condpart466
	LDA player0y
	SEC
	SBC x
	STA player0y
.skipL0781
.
 ; 

.L0782 ;  gosub __Play_Death_Music bank7

 sta temp7
 lda #>(ret_point45-1)
 pha
 lda #<(ret_point45-1)
 pha
 lda #>(.__Play_Death_Music-1)
 pha
 lda #<(.__Play_Death_Music-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #7
 jmp BS_jsr
ret_point45
.
 ; 

.L0783 ;  gosub __Render_Screen_B3  :  gosub __Render_Screen_B3  :  gosub __Render_Screen_B3

 jsr .__Render_Screen_B3
 jsr .__Render_Screen_B3
 jsr .__Render_Screen_B3

.
 ; 

.L0784 ;  next x

	LDA x
	CLC
	ADC #-1

 if ((* - .L0780forx_failsafe) < 127) && ((* - .L0780forx_failsafe) > -128)
	bcc .L0780forx_failsafe
 else
	bcs .7skipL0780forx_failsafe
	jmp .L0780forx_failsafe
.7skipL0780forx_failsafe
 endif
	STA x
	CMP #0
 if ((* - .L0780forx) < 127) && ((* - .L0780forx) > -128)
	bcs .L0780forx
 else
	bcc .8skipL0780forx
	jmp .L0780forx
.8skipL0780forx
 endif
.L0780forx_failsafe
.
 ; 

.__Mario_Death_2
 ; __Mario_Death_2

.
 ; 

.L0785 ;  if x  <  7 then x  =  x  +  1

	LDA x
	CMP #7
     BCS .skipL0785
.condpart467
	INC x
.skipL0785
.
 ; 

.L0786 ;  if player0y  <>  150 then player0y  =  player0y  +  x

	LDA player0y
	CMP #150
     BEQ .skipL0786
.condpart468
	LDA player0y
	CLC
	ADC x
	STA player0y
.skipL0786
.
 ; 

.L0787 ;  gosub __Play_Death_Music bank7

 sta temp7
 lda #>(ret_point46-1)
 pha
 lda #<(ret_point46-1)
 pha
 lda #>(.__Play_Death_Music-1)
 pha
 lda #<(.__Play_Death_Music-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #7
 jmp BS_jsr
ret_point46
.
 ; 

.L0788 ;  if _Music_Duration  =  255 then goto __Check_Lives

	LDA _Music_Duration
	CMP #255
     BNE .skipL0788
.condpart469
 jmp .__Check_Lives

.skipL0788
.
 ; 

.L0789 ;  gosub __Render_Screen_B3  :  gosub __Render_Screen_B3  :  gosub __Render_Screen_B3

 jsr .__Render_Screen_B3
 jsr .__Render_Screen_B3
 jsr .__Render_Screen_B3

.
 ; 

.L0790 ;  if player0y  >  120 then player0y  =  120

	LDA #120
	CMP player0y
     BCS .skipL0790
.condpart470
	LDA #120
	STA player0y
.skipL0790
.
 ; 

.L0791 ;  goto __Mario_Death_2

 jmp .__Mario_Death_2

.
 ; 

.__Check_Lives
 ; __Check_Lives

.
 ; 

.L0792 ;  _Enemy_Type  =  _Goomba  :  player1y  =  150

	LDA #_Goomba
	STA _Enemy_Type
	LDA #150
	STA player1y
.
 ; 

.L0793 ;  player1x  =  0  :  _Star_Invincibility_Timer  =  0  :  _Bit7_Mario_Invincibility{7}  =  0  :  _Bit7_Mario_On_Off{7}  =  0  :  _Bit5_Ducking_Flag{5}  =  0  :  _Level_Timer  =  0  :  _Momentum_Up_Down  =  0  :  _Momentum_Left_Right  =  0  :  _Bit1_Jumping_Flag{1}  =  0

	LDA #0
	STA player1x
	STA _Star_Invincibility_Timer
	LDA _Bit7_Mario_Invincibility
	AND #127
	STA _Bit7_Mario_Invincibility
	LDA _Bit7_Mario_On_Off
	AND #127
	STA _Bit7_Mario_On_Off
	LDA _Bit5_Ducking_Flag
	AND #223
	STA _Bit5_Ducking_Flag
	LDA #0
	STA _Level_Timer
	STA _Momentum_Up_Down
	STA _Momentum_Left_Right
	LDA _Bit1_Jumping_Flag
	AND #253
	STA _Bit1_Jumping_Flag
.
 ; 

.L0794 ;  if _Lives_Counter  <  1 then goto __Game_Over_Screen bank4 else goto __Init bank1

	LDA _Lives_Counter
	CMP #1
     BCS .skipL0794
.condpart471
 sta temp7
 lda #>(.__Game_Over_Screen-1)
 pha
 lda #<(.__Game_Over_Screen-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
 jmp .skipelse70
.skipL0794
 sta temp7
 lda #>(.__Init-1)
 pha
 lda #<(.__Init-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
.skipelse70
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Checkpoint
 ; __Checkpoint

.
 ; 

.L0795 ;  x  =   ( player0x  -  9 )  / 4

; complex statement detected
	LDA player0x
	SEC
	SBC #9
	lsr
	lsr
	STA x
.
 ; 

.L0796 ;  if !pfread ( x , 9 )  then goto __More_Joy_Checks

	LDA x
	LDY #9
 sta temp7
 lda #>(ret_point47-1)
 pha
 lda #<(ret_point47-1)
 pha
 lda #>(pfread-1)
 pha
 lda #<(pfread-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #8
 jmp BS_jsr
ret_point47
	BEQ .skipL0796
.condpart472
 jmp .__More_Joy_Checks

.skipL0796
.
 ; 

.L0797 ;  x  =   ( player0x  -  17 )  / 4

; complex statement detected
	LDA player0x
	SEC
	SBC #17
	lsr
	lsr
	STA x
.
 ; 

.L0798 ;  if !pfread ( x , 9 )  then goto __More_Joy_Checks

	LDA x
	LDY #9
 sta temp7
 lda #>(ret_point48-1)
 pha
 lda #<(ret_point48-1)
 pha
 lda #>(pfread-1)
 pha
 lda #<(pfread-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #8
 jmp BS_jsr
ret_point48
	BEQ .skipL0798
.condpart473
 jmp .__More_Joy_Checks

.skipL0798
.
 ; 

.L0799 ;  y  =  8  :  bally  =  150

	LDA #8
	STA y
	LDA #150
	STA bally
.
 ; 

.L0800 ;  ballx  =  0  :  u  =  0  :  _Star_Invincibility_Timer  =  0  :  _Bit7_Mario_Invincibility{7}  =  0  :  _Bit7_Mario_On_Off{7}  =  0

	LDA #0
	STA ballx
	STA u
	STA _Star_Invincibility_Timer
	LDA _Bit7_Mario_Invincibility
	AND #127
	STA _Bit7_Mario_Invincibility
	LDA _Bit7_Mario_On_Off
	AND #127
	STA _Bit7_Mario_On_Off
.
 ; 

.__fl2
 ; __fl2

.
 ; 

.L0801 ;  CTRLPF  =  $15

	LDA #$15
	STA CTRLPF
.
 ; 

.L0802 ;  player0y  =  player0y  +  1

	INC player0y
.
 ; 

.L0803 ;  gosub __Power_Down_SFX bank1

 sta temp7
 lda #>(ret_point49-1)
 pha
 lda #<(ret_point49-1)
 pha
 lda #>(.__Power_Down_SFX-1)
 pha
 lda #<(.__Power_Down_SFX-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
ret_point49
.
 ; 

.L0804 ;  gosub __Render_Screen_B3

 jsr .__Render_Screen_B3

.
 ; 

.L0805 ;  if player0y  <  79 then goto __fl2

	LDA player0y
	CMP #79
     BCS .skipL0805
.condpart474
 jmp .__fl2

.skipL0805
.
 ; 

.L0806 ;  player0x  =  0  :  player0y  =  150

	LDA #0
	STA player0x
	LDA #150
	STA player0y
.
 ; 

.L0807 ;  pfclear

	LDA #0
 sta temp7
 lda #>(ret_point50-1)
 pha
 lda #<(ret_point50-1)
 pha
 lda #>(pfclear-1)
 pha
 lda #<(pfclear-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #8
 jmp BS_jsr
ret_point50
.
 ; 

.L0808 ;  _Enemy_Type  =  _Goomba  :  player1y  =  150  :  player1x  =  0

	LDA #_Goomba
	STA _Enemy_Type
	LDA #150
	STA player1y
	LDA #0
	STA player1x
.
 ; 

.L0809 ;  _Level_Data_Pointer  =  32  :  _Bit6_Checkpoint_Flag{6}  =  1  :  _Moving_Shell_X_Coordinate  =  0  :  _Moving_Shell_Y_Coordinate  =  0

	LDA #32
	STA _Level_Data_Pointer
	LDA _Bit6_Checkpoint_Flag
	ORA #64
	STA _Bit6_Checkpoint_Flag
	LDA #0
	STA _Moving_Shell_X_Coordinate
	STA _Moving_Shell_Y_Coordinate
.
 ; 

.L0810 ;  for x  =  1 to 32

	LDA #1
	STA x
.L0810forx
.
 ; 

.L0811 ;  gosub __Power_Down_SFX bank1

 sta temp7
 lda #>(ret_point51-1)
 pha
 lda #<(ret_point51-1)
 pha
 lda #>(.__Power_Down_SFX-1)
 pha
 lda #<(.__Power_Down_SFX-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
ret_point51
.
 ; 

.L0812 ;  gosub __Render_Screen_B3

 jsr .__Render_Screen_B3

.
 ; 

.L0813 ;  next x

	LDA x
	CMP #32

	INC x
 if ((* - .L0810forx) < 127) && ((* - .L0810forx) > -128)
	bcc .L0810forx
 else
	bcs .9skipL0810forx
	jmp .L0810forx
.9skipL0810forx
 endif
.
 ; 

.L0814 ;  gosub __Intro_Screen_3 bank4

 sta temp7
 lda #>(ret_point52-1)
 pha
 lda #<(ret_point52-1)
 pha
 lda #>(.__Intro_Screen_3-1)
 pha
 lda #<(.__Intro_Screen_3-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point52
.
 ; 

.L0815 ;  if _Level  =  4 then goto __Bos_Setup bank4

	LDA _Level
	CMP #4
     BNE .skipL0815
.condpart475
 sta temp7
 lda #>(.__Bos_Setup-1)
 pha
 lda #<(.__Bos_Setup-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
.skipL0815
.
 ; 

.L0816 ;  player0x  =  24  :  player0y  =  80

	LDA #24
	STA player0x
	LDA #80
	STA player0y
.
 ; 

.__fl3
 ; __fl3

.
 ; 

.L0817 ;  player0y  =  player0y  -  1

	DEC player0y
.
 ; 

.L0818 ;  gosub __Power_Down_SFX bank1

 sta temp7
 lda #>(ret_point53-1)
 pha
 lda #<(ret_point53-1)
 pha
 lda #>(.__Power_Down_SFX-1)
 pha
 lda #<(.__Power_Down_SFX-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
ret_point53
.
 ; 

.L0819 ;  gosub __Render_Screen_B3

 jsr .__Render_Screen_B3

.
 ; 

.L0820 ;  if player0y  <  64 then CTRLPF  =  $11  :  goto __More_Joy_Checks

	LDA player0y
	CMP #64
     BCS .skipL0820
.condpart476
	LDA #$11
	STA CTRLPF
 jmp .__More_Joy_Checks

.skipL0820
.
 ; 

.L0821 ;  goto __fl3

 jmp .__fl3

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Checkpoint_L3
 ; __Checkpoint_L3

.
 ; 

.L0822 ;  _Temp_u_Freq  =  31

	LDA #31
	STA _Temp_u_Freq
.
 ; 

.L0823 ;  gosub __Tramp2C

 jsr .__Tramp2C

.
 ; 

.__Checkpoint_2
 ; __Checkpoint_2

.
 ; 

.L0824 ;  player0y  =  player0y  -  8

	LDA player0y
	SEC
	SBC #8
	STA player0y
.
 ; 

.L0825 ;  AUDV0  =  8

	LDA #8
	STA AUDV0
.L0826 ;  AUDC0  =  12

	LDA #12
	STA AUDC0
.L0827 ;  AUDF0  =  _Temp_u_Freq

	LDA _Temp_u_Freq
	STA AUDF0
.L0828 ;  AUDV1  =  0

	LDA #0
	STA AUDV1
.
 ; 

.L0829 ;  gosub __Render_Screen_B3

 jsr .__Render_Screen_B3

.
 ; 

.L0830 ;  _Temp_u_Freq  =  _Temp_u_Freq  -  4

	LDA _Temp_u_Freq
	SEC
	SBC #4
	STA _Temp_u_Freq
.
 ; 

.L0831 ;  if player0y  >  8 then goto __Checkpoint_2

	LDA #8
	CMP player0y
     BCS .skipL0831
.condpart477
 jmp .__Checkpoint_2

.skipL0831
.
 ; 

.L0832 ;  player0x  =  0  :  player0y  =  150

	LDA #0
	STA player0x
	LDA #150
	STA player0y
.
 ; 

.L0833 ;  _Enemy_Type  =  _Goomba  :  player1x  =  0  :  player1y  =  150

	LDA #_Goomba
	STA _Enemy_Type
	LDA #0
	STA player1x
	LDA #150
	STA player1y
.
 ; 

.L0834 ;  _Level_Data_Pointer  =  32  :  _Bit6_Checkpoint_Flag{6}  =  1

	LDA #32
	STA _Level_Data_Pointer
	LDA _Bit6_Checkpoint_Flag
	ORA #64
	STA _Bit6_Checkpoint_Flag
.
 ; 

.L0835 ;  pfclear

	LDA #0
 sta temp7
 lda #>(ret_point54-1)
 pha
 lda #<(ret_point54-1)
 pha
 lda #>(pfclear-1)
 pha
 lda #<(pfclear-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #8
 jmp BS_jsr
ret_point54
.
 ; 

.L0836 ;  AUDV0  =  0

	LDA #0
	STA AUDV0
.
 ; 

.L0837 ;  for x  =  1 to 32

	LDA #1
	STA x
.L0837forx
.
 ; 

.L0838 ;  gosub __Render_Screen_B3

 jsr .__Render_Screen_B3

.
 ; 

.L0839 ;  next x

	LDA x
	CMP #32

	INC x
 if ((* - .L0837forx) < 127) && ((* - .L0837forx) > -128)
	bcc .L0837forx
 else
	bcs .10skipL0837forx
	jmp .L0837forx
.10skipL0837forx
 endif
.
 ; 

.L0840 ;  gosub __Intro_Screen_3 bank4

 sta temp7
 lda #>(ret_point55-1)
 pha
 lda #<(ret_point55-1)
 pha
 lda #>(.__Intro_Screen_3-1)
 pha
 lda #<(.__Intro_Screen_3-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
ret_point55
.
 ; 

.L0841 ;  player0x  =  24  :  player0y  =  100

	LDA #24
	STA player0x
	LDA #100
	STA player0y
.
 ; 

.L0842 ;  _Temp_u_Freq  =  31

	LDA #31
	STA _Temp_u_Freq
.
 ; 

.L0843 ;  x  =  8

	LDA #8
	STA x
.
 ; 

.__Checkpoint_3
 ; __Checkpoint_3

.
 ; 

.L0844 ;  player0y  =  player0y  -  x

	LDA player0y
	SEC
	SBC x
	STA player0y
.
 ; 

.L0845 ;  AUDV0  =  8

	LDA #8
	STA AUDV0
.L0846 ;  AUDC0  =  12

	LDA #12
	STA AUDC0
.L0847 ;  AUDF0  =  _Temp_u_Freq

	LDA _Temp_u_Freq
	STA AUDF0
.L0848 ;  AUDV1  =  0

	LDA #0
	STA AUDV1
.
 ; 

.L0849 ;  gosub __Render_Screen_B3

 jsr .__Render_Screen_B3

.
 ; 

.L0850 ;  _Temp_u_Freq  =  _Temp_u_Freq  -  4  :  x  =  x  -  1

	LDA _Temp_u_Freq
	SEC
	SBC #4
	STA _Temp_u_Freq
	DEC x
.
 ; 

.L0851 ;  if player0y  <  80 then goto __More_Joy_Checks

	LDA player0y
	CMP #80
     BCS .skipL0851
.condpart478
 jmp .__More_Joy_Checks

.skipL0851
.
 ; 

.L0852 ;  goto __Checkpoint_3

 jmp .__Checkpoint_3

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Level_Completed
 ; __Level_Completed

.
 ; 

.L0853 ;  ballx  =  0  :  bally  =  150

	LDA #0
	STA ballx
	LDA #150
	STA bally
.
 ; 

.L0854 ;  gosub __Flag_Pole_Down

 jsr .__Flag_Pole_Down

.
 ; 

.L0855 ;  gosub __Fanfare_Music bank7

 sta temp7
 lda #>(ret_point56-1)
 pha
 lda #<(ret_point56-1)
 pha
 lda #>(.__Fanfare_Music-1)
 pha
 lda #<(.__Fanfare_Music-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #7
 jmp BS_jsr
ret_point56
.
 ; 

.L0856 ;  z  =  player1y  -  player0y

	LDA player1y
	SEC
	SBC player0y
	STA z
.
 ; 

.L0857 ;  if z  =  0 then z  =  1

	LDA z
	CMP #0
     BNE .skipL0857
.condpart479
	LDA #1
	STA z
.skipL0857
.
 ; 

.L0858 ;  AUDV0  =  0

	LDA #0
	STA AUDV0
.L0859 ;  AUDV1  =  0

	LDA #0
	STA AUDV1
.
 ; 

.L0860 ;  player0y  =  player1y  :  _Music_Duration  =  1

	LDA player1y
	STA player0y
	LDA #1
	STA _Music_Duration
.
 ; 

.L0861 ;  _Animation_Timer  =  0  :  _Bit1_Jumping_Flag{1}  =  0  :  _Bit0_Player_Facing_Direction{0}  =  0  :  _Bit5_Ducking_Flag{5}  =  0  :  _Momentum_Up_Down  =  0  :  _Bit7_Mario_Invincibility{7}  =  0  :  _Bit7_Mario_On_Off{7}  =  0  :  _Momentum_Left_Right  =  0

	LDA #0
	STA _Animation_Timer
	LDA _Bit1_Jumping_Flag
	AND #253
	STA _Bit1_Jumping_Flag
	LDA _Bit0_Player_Facing_Direction
	AND #254
	STA _Bit0_Player_Facing_Direction
	LDA _Bit5_Ducking_Flag
	AND #223
	STA _Bit5_Ducking_Flag
	LDA #0
	STA _Momentum_Up_Down
	LDA _Bit7_Mario_Invincibility
	AND #127
	STA _Bit7_Mario_Invincibility
	LDA _Bit7_Mario_On_Off
	AND #127
	STA _Bit7_Mario_On_Off
	LDA #0
	STA _Momentum_Left_Right
.
 ; 

.L0862 ;  gosub __Set_Up_Mario bank1

 sta temp7
 lda #>(ret_point57-1)
 pha
 lda #<(ret_point57-1)
 pha
 lda #>(.__Set_Up_Mario-1)
 pha
 lda #<(.__Set_Up_Mario-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
ret_point57
.
 ; 

.L0863 ;  for y  =  1 to z

	LDA #1
	STA y
.L0863fory
.
 ; 

.L0864 ;  score  =  score  +  100

	SED
	CLC
	LDA score+1
	ADC #$01
	STA score+1
	LDA score
	ADC #$00
	STA score
	CLD
.
 ; 

.L0865 ;  gosub __Render_Screen_B3

 jsr .__Render_Screen_B3

.
 ; 

.L0866 ;  AUDV0  =  8

	LDA #8
	STA AUDV0
.L0867 ;  AUDC0  =  12

	LDA #12
	STA AUDC0
.L0868 ;  AUDF0  =  y

	LDA y
	STA AUDF0
.
 ; 

.L0869 ;  next y

	LDA y
	CMP z

	INC y
 if ((* - .L0863fory) < 127) && ((* - .L0863fory) > -128)
	bcc .L0863fory
 else
	bcs .11skipL0863fory
	jmp .L0863fory
.11skipL0863fory
 endif
.
 ; 

.L0870 ;  AUDV0  =  0

	LDA #0
	STA AUDV0
.
 ; 

.L0871 ;  _Momentum_Left_Right  =  2

	LDA #2
	STA _Momentum_Left_Right
.
 ; 

.__elr3
 ; __elr3

.
 ; 

.L0872 ;  gosub __Play_FF_Music bank7

 sta temp7
 lda #>(ret_point58-1)
 pha
 lda #<(ret_point58-1)
 pha
 lda #>(.__Play_FF_Music-1)
 pha
 lda #<(.__Play_FF_Music-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #7
 jmp BS_jsr
ret_point58
.
 ; 

.L0873 ;  _Animation_Timer  =  _Animation_Timer  +  1

	INC _Animation_Timer
.
 ; 

.L0874 ;  player0x  =  player0x  +  1

	INC player0x
.
 ; 

.L0875 ;  if player0x  >  137 then player0x  =  137  :  player0y  =  150

	LDA #137
	CMP player0x
     BCS .skipL0875
.condpart480
	LDA #137
	STA player0x
	LDA #150
	STA player0y
.skipL0875
.
 ; 

.L0876 ;  if _Animation_Timer  >  6 then _Animation_Timer  =  0

	LDA #6
	CMP _Animation_Timer
     BCS .skipL0876
.condpart481
	LDA #0
	STA _Animation_Timer
.skipL0876
.
 ; 

.L0877 ;  gosub __Set_Up_Mario bank1

 sta temp7
 lda #>(ret_point59-1)
 pha
 lda #<(ret_point59-1)
 pha
 lda #>(.__Set_Up_Mario-1)
 pha
 lda #<(.__Set_Up_Mario-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
ret_point59
.
 ; 

.L0878 ;  gosub __Render_Screen_B3  :  gosub __Render_Screen_B3

 jsr .__Render_Screen_B3
 jsr .__Render_Screen_B3

.
 ; 

.L0879 ;  if _Music_Duration  <>  255 then goto __elr3

	LDA _Music_Duration
	CMP #255
     BEQ .skipL0879
.condpart482
 jmp .__elr3

.skipL0879
.
 ; 

.__elr4
 ; __elr4

.
 ; 

.L0880 ;  if pfscore1  =  0 then goto __elr5

	LDA pfscore1
	CMP #0
     BNE .skipL0880
.condpart483
 jmp .__elr5

.skipL0880
.
 ; 

.L0881 ;  AUDV0  =  8

	LDA #8
	STA AUDV0
.L0882 ;  AUDC0  =  4

	LDA #4
	STA AUDC0
.L0883 ;  AUDF0  =  8

	LDA #8
	STA AUDF0
.L0884 ;  AUDV1  =  0

	LDA #0
	STA AUDV1
.
 ; 

.L0885 ;  pfscore1  =  pfscore1 / 2

	LDA pfscore1
	lsr
	STA pfscore1
.
 ; 

.L0886 ;  score  =  score  +  500

	SED
	CLC
	LDA score+1
	ADC #$05
	STA score+1
	LDA score
	ADC #$00
	STA score
	CLD
.
 ; 

.L0887 ;  gosub __Render_Screen_B3

 jsr .__Render_Screen_B3

.
 ; 

.L0888 ;  AUDV0  =  0

	LDA #0
	STA AUDV0
.
 ; 

.L0889 ;  gosub __Render_Screen_B3

 jsr .__Render_Screen_B3

.
 ; 

.L0890 ;  goto __elr4

 jmp .__elr4

.
 ; 

.__elr5
 ; __elr5

.
 ; 

.L0891 ;  for x  =  1 to 64

	LDA #1
	STA x
.L0891forx
.
 ; 

.L0892 ;  gosub __Render_Screen_B3

 jsr .__Render_Screen_B3

.
 ; 

.L0893 ;  next x

	LDA x
	CMP #64

	INC x
 if ((* - .L0891forx) < 127) && ((* - .L0891forx) > -128)
	bcc .L0891forx
 else
	bcs .12skipL0891forx
	jmp .L0891forx
.12skipL0891forx
 endif
.
 ; 

.L0894 ;  _Bit6_Checkpoint_Flag{6}  =  0  :  _Enemy_Type  =  _Goomba  :  player1y  =  150  :  player1x  =  0  :  _Star_Invincibility_Timer  =  0  :  _Bit7_Mario_Invincibility{7}  =  0  :  _Bit7_Mario_On_Off{7}  =  0  :  _Bit5_Ducking_Flag{5}  =  0  :  _Level_Timer  =  0

	LDA _Bit6_Checkpoint_Flag
	AND #191
	STA _Bit6_Checkpoint_Flag
	LDA #_Goomba
	STA _Enemy_Type
	LDA #150
	STA player1y
	LDA #0
	STA player1x
	STA _Star_Invincibility_Timer
	LDA _Bit7_Mario_Invincibility
	AND #127
	STA _Bit7_Mario_Invincibility
	LDA _Bit7_Mario_On_Off
	AND #127
	STA _Bit7_Mario_On_Off
	LDA _Bit5_Ducking_Flag
	AND #223
	STA _Bit5_Ducking_Flag
	LDA #0
	STA _Level_Timer
.
 ; 

.L0895 ;  _Moving_Shell_X_Coordinate  =  0  :  _Moving_Shell_Y_Coordinate  =  0  :  _Bit1_Jumping_Flag{1}  =  0  :  _Momentum_Up_Down  =  0  :  _Momentum_Left_Right  =  0

	LDA #0
	STA _Moving_Shell_X_Coordinate
	STA _Moving_Shell_Y_Coordinate
	LDA _Bit1_Jumping_Flag
	AND #253
	STA _Bit1_Jumping_Flag
	LDA #0
	STA _Momentum_Up_Down
	STA _Momentum_Left_Right
.
 ; 

.L0896 ;  _Level  =  _Level  +  1

	INC _Level
.
 ; 

.L0897 ;  if _Level  =  5 then _Level  =  1  :  _World  =  _World  +  1

	LDA _Level
	CMP #5
     BNE .skipL0897
.condpart484
	LDA #1
	STA _Level
	INC _World
.skipL0897
.
 ; 

.L0898 ;  goto __Init bank1

 sta temp7
 lda #>(.__Init-1)
 pha
 lda #<(.__Init-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__8coins
 ; __8coins

.
 ; 

.L0899 ;  score  =  score  +  800

	SED
	CLC
	LDA score+1
	ADC #$08
	STA score+1
	LDA score
	ADC #$00
	STA score
	CLD
.
 ; 

.L0900 ;  pfscore2  =  pfscore2  *  2 | 1

; complex statement detected
	LDA pfscore2
	asl
	ORA #1
	STA pfscore2
.
 ; 

.L0901 ;  AUDV0  =  12

	LDA #12
	STA AUDV0
.L0902 ;  AUDC0  =  4

	LDA #4
	STA AUDC0
.L0903 ;  AUDF0  =  7

	LDA #7
	STA AUDF0
.
 ; 

.L0904 ;  player1x  =  0  :  player1y  =  150  :  _Enemy_Type  =  _Goomba

	LDA #0
	STA player1x
	LDA #150
	STA player1y
	LDA #_Goomba
	STA _Enemy_Type
.
 ; 

.L0905 ;  if pfscore2  <  250 then goto __Draw

	LDA pfscore2
	CMP #250
     BCS .skipL0905
.condpart485
 jmp .__Draw

.skipL0905
.
 ; 

.L0906 ;  pfscore2  =  0

	LDA #0
	STA pfscore2
.
 ; 

.L0907 ;  goto __1Up_Mushroom

 jmp .__1Up_Mushroom

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Star_Power
 ; __Star_Power

.
 ; 

.L0908 ;  _Star_Invincibility_Timer  =  1  :  _Bit7_Mario_Invincibility{7}  =  1  :  _Bit7_Mario_On_Off{7}  =  1

	LDA #1
	STA _Star_Invincibility_Timer
	LDA _Bit7_Mario_Invincibility
	ORA #128
	STA _Bit7_Mario_Invincibility
	LDA _Bit7_Mario_On_Off
	ORA #128
	STA _Bit7_Mario_On_Off
.
 ; 

.L0909 ;  score  =  score  +  1000

	SED
	CLC
	LDA score+1
	ADC #$10
	STA score+1
	LDA score
	ADC #$00
	STA score
	CLD
.
 ; 

.L0910 ;  player1x  =  0  :  player1y  =  150  :  _Enemy_Type  =  _Goomba

	LDA #0
	STA player1x
	LDA #150
	STA player1y
	LDA #_Goomba
	STA _Enemy_Type
.
 ; 

.L0911 ;  _Music_Duration  =  1

	LDA #1
	STA _Music_Duration
.
 ; 

.L0912 ;  gosub __Star_Power_Music bank7

 sta temp7
 lda #>(ret_point60-1)
 pha
 lda #<(ret_point60-1)
 pha
 lda #>(.__Star_Power_Music-1)
 pha
 lda #<(.__Star_Power_Music-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #7
 jmp BS_jsr
ret_point60
.
 ; 

.L0913 ;  goto __Draw

 jmp .__Draw

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__1Up_Mushroom
 ; __1Up_Mushroom

.
 ; 

.L0914 ;  y  =  11  :  u  =  0  :  _Lives_Counter  =  _Lives_Counter  +  1

	LDA #11
	STA y
	LDA #0
	STA u
	INC _Lives_Counter
.
 ; 

.L0915 ;  if _Lives_Counter  =  255 then _Lives_Counter  =  254

	LDA _Lives_Counter
	CMP #255
     BNE .skipL0915
.condpart486
	LDA #254
	STA _Lives_Counter
.skipL0915
.
 ; 

.L0916 ;  player1x  =  0  :  player1y  =  150  :  _Enemy_Type  =  _Goomba

	LDA #0
	STA player1x
	LDA #150
	STA player1y
	LDA #_Goomba
	STA _Enemy_Type
.
 ; 

.__1Up_Mush_2
 ; __1Up_Mush_2

.
 ; 

.L0917 ;  gosub __1Up_SFX_B3

 jsr .__1Up_SFX_B3

.
 ; 

.L0918 ;  gosub __Render_Screen_B3  :  gosub __Render_Screen_B3  :  gosub __Render_Screen_B3  :  gosub __Render_Screen_B3

 jsr .__Render_Screen_B3
 jsr .__Render_Screen_B3
 jsr .__Render_Screen_B3
 jsr .__Render_Screen_B3

.
 ; 

.L0919 ;  x  =  player0x  :  z  =  player0y  :  player0x  =  0  :  player0y  =  150

	LDA player0x
	STA x
	LDA player0y
	STA z
	LDA #0
	STA player0x
	LDA #150
	STA player0y
.
 ; 

.L0920 ;  gosub __Render_Screen_B3  :  gosub __Render_Screen_B3  :  gosub __Render_Screen_B3  :  gosub __Render_Screen_B3

 jsr .__Render_Screen_B3
 jsr .__Render_Screen_B3
 jsr .__Render_Screen_B3
 jsr .__Render_Screen_B3

.
 ; 

.L0921 ;  player0x  =  x  :  player0y  =  z

	LDA x
	STA player0x
	LDA z
	STA player0y
.
 ; 

.L0922 ;  if y  =  3 then goto __Draw

	LDA y
	CMP #3
     BNE .skipL0922
.condpart487
 jmp .__Draw

.skipL0922
.
 ; 

.L0923 ;  goto __1Up_Mush_2

 jmp .__1Up_Mush_2

.
 ; 

.__1Up_SFX_B3
 ; __1Up_SFX_B3

.
 ; 

.L0924 ;  y  =  y  -  2  :  u  =  u  +  1

	LDA y
	SEC
	SBC #2
	STA y
	INC u
.
 ; 

.L0925 ;  if u  =  4 then u  =  0  :  y  =  7

	LDA u
	CMP #4
     BNE .skipL0925
.condpart488
	LDA #0
	STA u
	LDA #7
	STA y
.skipL0925
.
 ; 

.L0926 ;  AUDV0  =  8

	LDA #8
	STA AUDV0
.L0927 ;  AUDC0  =  4

	LDA #4
	STA AUDC0
.L0928 ;  AUDF0  =  y

	LDA y
	STA AUDF0
.L0929 ;  AUDV1  =  0

	LDA #0
	STA AUDV1
.
 ; 

.L0930 ;  return thisbank

	RTS
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Star_Power_End
 ; __Star_Power_End

.
 ; 

.L0931 ;  _Star_Invincibility_Timer  =  0  :  _Level_Timer  =  0

	LDA #0
	STA _Star_Invincibility_Timer
	STA _Level_Timer
.
 ; 

.L0932 ;  if _Level  =  1  ||  _Level  =  3 then gosub __OW_Music bank7

	LDA _Level
	CMP #1
     BNE .skipL0932
.condpart489
 jmp .condpart490
.skipL0932
	LDA _Level
	CMP #3
     BNE .skip132OR
.condpart490
 sta temp7
 lda #>(ret_point61-1)
 pha
 lda #<(ret_point61-1)
 pha
 lda #>(.__OW_Music-1)
 pha
 lda #<(.__OW_Music-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #7
 jmp BS_jsr
ret_point61
.skip132OR
.
 ; 

.L0933 ;  if _Level  =  2  ||  _Level  =  4 then gosub __UW_Music bank7

	LDA _Level
	CMP #2
     BNE .skipL0933
.condpart491
 jmp .condpart492
.skipL0933
	LDA _Level
	CMP #4
     BNE .skip133OR
.condpart492
 sta temp7
 lda #>(ret_point62-1)
 pha
 lda #<(ret_point62-1)
 pha
 lda #>(.__UW_Music-1)
 pha
 lda #<(.__UW_Music-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #7
 jmp BS_jsr
ret_point62
.skip133OR
.
 ; 

.L0934 ;  return thisbank

	RTS
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Enemy_Collision_Routine
 ; __Enemy_Collision_Routine

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0935 ;  if collision(ball,player1)  &&  !_Bit4_Enemy_Dead_Flag{4} then goto __Enemy_Hit_By_Fireball

	bit 	CXP1FB
	BVC .skipL0935
.condpart493
	LDA _Bit4_Enemy_Dead_Flag
	AND #16
	BNE .skip493then
.condpart494
 jmp .__Enemy_Hit_By_Fireball

.skip493then
.skipL0935
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0936 ;  if _Moving_Shell_X_Coordinate  >  0  &&  _Moving_Shell_Y_Coordinate  >  0 then goto __Moving_Shell_Collision

	LDA #0
	CMP _Moving_Shell_X_Coordinate
     BCS .skipL0936
.condpart495
	LDA #0
	CMP _Moving_Shell_Y_Coordinate
     BCS .skip495then
.condpart496
 jmp .__Moving_Shell_Collision

.skip495then
.skipL0936
.
 ; 

.__Enemy_Coll_Rout_2
 ; __Enemy_Coll_Rout_2

.
 ; 

.L0937 ;  if !collision(player0,player1) then goto __Draw

	bit 	CXPPMM
	BMI .skipL0937
.condpart497
 jmp .__Draw

.skipL0937
.
 ; 

.L0938 ;  if _Enemy_Type  =  _Kinetic_Platforms then goto __Convert_Platform

	LDA _Enemy_Type
	CMP #_Kinetic_Platforms
     BNE .skipL0938
.condpart498
 jmp .__Convert_Platform

.skipL0938
.
 ; 

.L0939 ;  if _Enemy_Type  =  _Trampoline then goto __Checkpoint_L3

	LDA _Enemy_Type
	CMP #_Trampoline
     BNE .skipL0939
.condpart499
 jmp .__Checkpoint_L3

.skipL0939
.
 ; 

.L0940 ;  if _Enemy_Type  >=  _Bowser_Jr then goto __Mario_BJr_Collision bank4

	LDA _Enemy_Type
	CMP #_Bowser_Jr
     BCC .skipL0940
.condpart500
 sta temp7
 lda #>(.__Mario_BJr_Collision-1)
 pha
 lda #<(.__Mario_BJr_Collision-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
.skipL0940
.
 ; 

.L0941 ;  if _Bit4_Enemy_Dead_Flag{4} then goto __Draw

	LDA _Bit4_Enemy_Dead_Flag
	AND #16
	BEQ .skipL0941
.condpart501
 jmp .__Draw

.skipL0941
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0942 ;  if _Enemy_Type  =  _Flagpole then goto __Level_Completed

	LDA _Enemy_Type
	CMP #_Flagpole
     BNE .skipL0942
.condpart502
 jmp .__Level_Completed

.skipL0942
.
 ; 

.L0943 ;  if _Enemy_Type  =  _Silver_Coin then goto __8coins

	LDA _Enemy_Type
	CMP #_Silver_Coin
     BNE .skipL0943
.condpart503
 jmp .__8coins

.skipL0943
.
 ; 

.L0944 ;  if _Enemy_Type  =  _Starman then goto __Star_Power

	LDA _Enemy_Type
	CMP #_Starman
     BNE .skipL0944
.condpart504
 jmp .__Star_Power

.skipL0944
.
 ; 

.L0945 ;  if _Enemy_Type  =  _1up_Mushroom then goto __1Up_Mushroom

	LDA _Enemy_Type
	CMP #_1up_Mushroom
     BNE .skipL0945
.condpart505
 jmp .__1Up_Mushroom

.skipL0945
.
 ; 

.L0946 ;  if _Star_Invincibility_Timer  >  0 then goto __Enemy_Hit

	LDA #0
	CMP _Star_Invincibility_Timer
     BCS .skipL0946
.condpart506
 jmp .__Enemy_Hit

.skipL0946
.
 ; 

.L0947 ;  if _Enemy_Type  =  _Spiney then goto __Mario_Hit_01 bank1

	LDA _Enemy_Type
	CMP #_Spiney
     BNE .skipL0947
.condpart507
 sta temp7
 lda #>(.__Mario_Hit_01-1)
 pha
 lda #<(.__Mario_Hit_01-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
.skipL0947
.
 ; 

.L0948 ;  if _Enemy_Type  =  _Spiney_Ball then goto __Mario_Hit_01 bank1

	LDA _Enemy_Type
	CMP #_Spiney_Ball
     BNE .skipL0948
.condpart508
 sta temp7
 lda #>(.__Mario_Hit_01-1)
 pha
 lda #<(.__Mario_Hit_01-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
.skipL0948
.
 ; 

.L0949 ;  if _Enemy_Type  =  _Fireball_Enemy then goto __Mario_Hit_01 bank1

	LDA _Enemy_Type
	CMP #_Fireball_Enemy
     BNE .skipL0949
.condpart509
 sta temp7
 lda #>(.__Mario_Hit_01-1)
 pha
 lda #<(.__Mario_Hit_01-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
.skipL0949
.
 ; 

.L0950 ;  if _Enemy_Type  =  _Pirahna_Plant  ||  _Enemy_Type  =  _Two_Spineys then goto __Mario_Hit_01 bank1

	LDA _Enemy_Type
	CMP #_Pirahna_Plant
     BNE .skipL0950
.condpart510
 jmp .condpart511
.skipL0950
	LDA _Enemy_Type
	CMP #_Two_Spineys
     BNE .skip136OR
.condpart511
 sta temp7
 lda #>(.__Mario_Hit_01-1)
 pha
 lda #<(.__Mario_Hit_01-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
.skip136OR
.
 ; 

.L0951 ;  if _Enemy_Type  =  _Thwomp  ||  _Enemy_Type  =  _Two_Thwomps then goto __Mario_Hit_01 bank1

	LDA _Enemy_Type
	CMP #_Thwomp
     BNE .skipL0951
.condpart512
 jmp .condpart513
.skipL0951
	LDA _Enemy_Type
	CMP #_Two_Thwomps
     BNE .skip137OR
.condpart513
 sta temp7
 lda #>(.__Mario_Hit_01-1)
 pha
 lda #<(.__Mario_Hit_01-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
.skip137OR
.
 ; 

.L0952 ;  if _Enemy_Type  >=  _Flagpole then goto __Enemy_Hit

	LDA _Enemy_Type
	CMP #_Flagpole
     BCC .skipL0952
.condpart514
 jmp .__Enemy_Hit

.skipL0952
.
 ; 

.L0953 ;  if player0y  <  player1y  &&  !_Bit4_Enemy_Dead_Flag{4} then goto __Enemy_Hit

	LDA player0y
	CMP player1y
     BCS .skipL0953
.condpart515
	LDA _Bit4_Enemy_Dead_Flag
	AND #16
	BNE .skip515then
.condpart516
 jmp .__Enemy_Hit

.skip515then
.skipL0953
.
 ; 

.L0954 ;  goto __Mario_Hit_01 bank1

 sta temp7
 lda #>(.__Mario_Hit_01-1)
 pha
 lda #<(.__Mario_Hit_01-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Moving_Shell_Collision
 ; __Moving_Shell_Collision

.
 ; 

.L0955 ;  x  =   ( player0x  -  13 )  / 4  :  y  =   ( player0y )  / 8

; complex statement detected
	LDA player0x
	SEC
	SBC #13
	lsr
	lsr
	STA x
; complex statement detected
	LDA player0y
	lsr
	lsr
	lsr
	STA y
.
 ; 

.L0956 ;  if _Moving_Shell_X_Coordinate  =  x  &&  _Moving_Shell_Y_Coordinate  =  y then goto __Mario_Hit_01 bank1

	LDA _Moving_Shell_X_Coordinate
	CMP x
     BNE .skipL0956
.condpart517
	LDA _Moving_Shell_Y_Coordinate
	CMP y
     BNE .skip517then
.condpart518
 sta temp7
 lda #>(.__Mario_Hit_01-1)
 pha
 lda #<(.__Mario_Hit_01-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
.skip517then
.skipL0956
.
 ; 

.L0957 ;  z  =  _Moving_Shell_X_Coordinate  +  1

	LDA _Moving_Shell_X_Coordinate
	CLC
	ADC #1
	STA z
.
 ; 

.L0958 ;  if z  =  x  &&  _Moving_Shell_Y_Coordinate  =  y then goto __Mario_Hit_01 bank1

	LDA z
	CMP x
     BNE .skipL0958
.condpart519
	LDA _Moving_Shell_Y_Coordinate
	CMP y
     BNE .skip519then
.condpart520
 sta temp7
 lda #>(.__Mario_Hit_01-1)
 pha
 lda #<(.__Mario_Hit_01-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
.skip519then
.skipL0958
.
 ; 

.L0959 ;  goto __Enemy_Coll_Rout_2

 jmp .__Enemy_Coll_Rout_2

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Convert_Platform
 ; __Convert_Platform

.
 ; 

.L0960 ;  x  =   ( player1x  -  14 )  / 4  :  y  =  player1y / 8

; complex statement detected
	LDA player1x
	SEC
	SBC #14
	lsr
	lsr
	STA x
	LDA player1y
	lsr
	lsr
	lsr
	STA y
.
 ; 

.L0961 ;  _Enemy_Type  =  _Goomba  :  player1y  =  150  :  player1x  =  0

	LDA #_Goomba
	STA _Enemy_Type
	LDA #150
	STA player1y
	LDA #0
	STA player1x
.
 ; 

.L0962 ;  gosub __Render_Screen_B3

 jsr .__Render_Screen_B3

.
 ; 

.L0963 ;  if _Bit7_2nd_Quest{7} then z  =  x  +  3 else z  =  x  +  7

	BIT _Bit7_2nd_Quest
	BPL .skipL0963
.condpart521
	LDA x
	CLC
	ADC #3
	STA z
 jmp .skipelse71
.skipL0963
	LDA x
	CLC
	ADC #7
	STA z
.skipelse71
.
 ; 

.L0964 ;  pfhline x y z on

	LDX #0
	LDA z
	STA temp3
	LDY y
	LDA x
 sta temp7
 lda #>(ret_point63-1)
 pha
 lda #<(ret_point63-1)
 pha
 lda #>(pfhline-1)
 pha
 lda #<(pfhline-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #8
 jmp BS_jsr
ret_point63
.
 ; 

.L0965 ;  player0y  =  player0y  -  _Momentum_Up_Down  -  4

; complex statement detected
	LDA player0y
	SEC
	SBC _Momentum_Up_Down
	SEC
	SBC #4
	STA player0y
.
 ; 

.L0966 ;  gosub __Render_Screen_B3

 jsr .__Render_Screen_B3

.
 ; 

.L0967 ;  goto __Draw

 jmp .__Draw

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Render_Screen_B3
 ; __Render_Screen_B3

.
 ; 

.L0968 ;  if _Level  =  1  ||  _Level  =  3 then COLUPF  =  $32 else COLUPF  =  $04

	LDA _Level
	CMP #1
     BNE .skipL0968
.condpart522
 jmp .condpart523
.skipL0968
	LDA _Level
	CMP #3
     BNE .skip141OR
.condpart523
	LDA #$32
	STA COLUPF
 jmp .skipelse72
.skip141OR
	LDA #$04
	STA COLUPF
.skipelse72
.
 ; 

.L0969 ;  if _Level  =  2 then COLUPF  =  $A4

	LDA _Level
	CMP #2
     BNE .skipL0969
.condpart524
	LDA #$A4
	STA COLUPF
.skipL0969
.
 ; 

.L0970 ;  if _Enemy_Type  =  _Kinetic_Platforms  &&  !_Bit7_2nd_Quest{7} then NUSIZ1  =  $17  :  goto __Finish_Render_B3

	LDA _Enemy_Type
	CMP #_Kinetic_Platforms
     BNE .skipL0970
.condpart525
	BIT _Bit7_2nd_Quest
	BMI .skip525then
.condpart526
	LDA #$17
	STA NUSIZ1
 jmp .__Finish_Render_B3

.skip525then
.skipL0970
.
 ; 

.L0971 ;  if _Enemy_Type  =  _Kinetic_Platforms  &&  _Bit7_2nd_Quest{7} then NUSIZ1  =  $15  :  goto __Finish_Render_B3

	LDA _Enemy_Type
	CMP #_Kinetic_Platforms
     BNE .skipL0971
.condpart527
	BIT _Bit7_2nd_Quest
	BPL .skip527then
.condpart528
	LDA #$15
	STA NUSIZ1
 jmp .__Finish_Render_B3

.skip527then
.skipL0971
.
 ; 

.L0972 ;  if _Enemy_Type  =  _Thwomp  ||  _Enemy_Type  =  _Bowser_Jr then NUSIZ1  =  $15  :  goto __Finish_Render_B3

	LDA _Enemy_Type
	CMP #_Thwomp
     BNE .skipL0972
.condpart529
 jmp .condpart530
.skipL0972
	LDA _Enemy_Type
	CMP #_Bowser_Jr
     BNE .skip144OR
.condpart530
	LDA #$15
	STA NUSIZ1
 jmp .__Finish_Render_B3

.skip144OR
.
 ; 

.L0973 ;  if _Enemy_Type  =  _Bullet_Bill then NUSIZ1  =  $15  :  goto __Finish_Render_B3

	LDA _Enemy_Type
	CMP #_Bullet_Bill
     BNE .skipL0973
.condpart531
	LDA #$15
	STA NUSIZ1
 jmp .__Finish_Render_B3

.skipL0973
.
 ; 

.L0974 ;  if _Enemy_Type  =  _Two_Goombas  &&  player1x  <  122 then NUSIZ1  =  $11  :  goto __Finish_Render_B3

	LDA _Enemy_Type
	CMP #_Two_Goombas
     BNE .skipL0974
.condpart532
	LDA player1x
	CMP #122
     BCS .skip532then
.condpart533
	LDA #$11
	STA NUSIZ1
 jmp .__Finish_Render_B3

.skip532then
.skipL0974
.
 ; 

.L0975 ;  if _Enemy_Type  =  _Two_Spineys  &&  player1x  <  122 then NUSIZ1  =  $11  :  goto __Finish_Render_B3

	LDA _Enemy_Type
	CMP #_Two_Spineys
     BNE .skipL0975
.condpart534
	LDA player1x
	CMP #122
     BCS .skip534then
.condpart535
	LDA #$11
	STA NUSIZ1
 jmp .__Finish_Render_B3

.skip534then
.skipL0975
.
 ; 

.L0976 ;  if _Enemy_Type  =  _Two_Thwomps  &&  player1x  <  106 then NUSIZ1  =  $12

	LDA _Enemy_Type
	CMP #_Two_Thwomps
     BNE .skipL0976
.condpart536
	LDA player1x
	CMP #106
     BCS .skip536then
.condpart537
	LDA #$12
	STA NUSIZ1
.skip536then
.skipL0976
.
 ; 

.__Finish_Render_B3
 ; __Finish_Render_B3

.
 ; 

.L0977 ;  if _Bit0_Player_Facing_Direction{0} then REFP0  =  8 else REFP0  =  0

	LDA _Bit0_Player_Facing_Direction
	LSR
	BCC .skipL0977
.condpart538
	LDA #8
	STA REFP0
 jmp .skipelse73
.skipL0977
	LDA #0
	STA REFP0
.skipelse73
.
 ; 

.L0978 ;  if _Bit3_Enemy_Direction{3} then REFP1  =  8 else REFP1  =  0

	LDA _Bit3_Enemy_Direction
	AND #8
	BEQ .skipL0978
.condpart539
	LDA #8
	STA REFP1
 jmp .skipelse74
.skipL0978
	LDA #0
	STA REFP1
.skipelse74
.
 ; 

.L0979 ;  drawscreen

 sta temp7
 lda #>(ret_point64-1)
 pha
 lda #<(ret_point64-1)
 pha
 lda #>(drawscreen-1)
 pha
 lda #<(drawscreen-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #8
 jmp BS_jsr
ret_point64
.
 ; 

.L0980 ;  return thisbank

	RTS
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Mario_Die
 ; __Mario_Die

.L0981 ;  player0color:

	LDX #<playercolorL0981_0
	STX player0color
	LDA #>playercolorL0981_0
	STA player0color+1
.
 ; 

.L0982 ;  player0:

	LDX #<playerL0982_0
	STX player0pointerlo
	LDA #>playerL0982_0
	STA player0pointerhi
	LDA #14
	STA player0height
.L0983 ;  return thisbank

	RTS
.
 ; 

.__Flag_Pole_Down
 ; __Flag_Pole_Down

.L0984 ;  player1color:

	LDX #<playercolorL0984_1
	STX player1color
	LDA #>playercolorL0984_1
	STA player1color+1
.
 ; 

.L0985 ;  player1:

	LDX #<playerL0985_1
	STX player1pointerlo
	LDA #>playerL0985_1
	STA player1pointerhi
	LDA #31
	STA player1height
.L0986 ;  return thisbank

	RTS
.
 ; 

.__Tramp2C
 ; __Tramp2C

.L0987 ;  player1color:

	LDX #<playercolorL0987_1
	STX player1color
	LDA #>playercolorL0987_1
	STA player1color+1
.
 ; 

.L0988 ;  player1:

	LDX #<playerL0988_1
	STX player1pointerlo
	LDA #>playerL0988_1
	STA player1pointerhi
	LDA #15
	STA player1height
.L0989 ;  return thisbank

	RTS
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0990 ;  bank 4

 if ECHO3
 echo "    ",[(start_bank3 - *)]d , "bytes of ROM space left in bank 3")
 endif
ECHO3 = 1
 ORG $3FF4-bscode_length
 RORG $5FF4-bscode_length
start_bank3 ldx #$ff
 ifconst FASTFETCH ; using DPC+
 stx FASTFETCH
 endif 
 txs
 if bankswitch == 64
   lda #(((>(start-1)) & $0F) | $F0)
 else
   lda #>(start-1)
 endif
 pha
 lda #<(start-1)
 pha
 pha
 txa
 pha
 tsx
 if bankswitch != 64
   lda 4,x ; get high byte of return address
   rol
   rol
   rol
   rol
   and #bs_mask ;1 3 or 7 for F8/F6/F4
   tax
   inx
 else
   lda 4,x ; get high byte of return address
   tay
   ora #$10 ; change our bank nibble into a valid rom mirror
   sta 4,x
   tya
   lsr 
   lsr 
   lsr 
   lsr 
   tax
   inx
 endif
 lda bankswitch_hotspot-1,x
 pla
 tax
 pla
 rts
 if ((* & $1FFF) > ((bankswitch_hotspot & $1FFF) - 1))
   echo "WARNING: size parameter in banksw.asm too small - the program probably will not work."
   echo "Change to",[(*-begin_bscode+1)&$FF]d,"and try again."
 endif
 ORG $3FFC
 RORG $5FFC
 .word (start_bank3 & $ffff)
 .word (start_bank3 & $ffff)
 ORG $4000
 RORG $7000
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Intro_Screen
 ; __Intro_Screen

.
 ; 

.L0991 ;  AUDV0  =  0  :  AUDV1  =  0

	LDA #0
	STA AUDV0
	STA AUDV1
.
 ; 

.L0992 ;  pfclear

	LDA #0
 sta temp7
 lda #>(ret_point65-1)
 pha
 lda #<(ret_point65-1)
 pha
 lda #>(pfclear-1)
 pha
 lda #<(pfclear-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #8
 jmp BS_jsr
ret_point65
.
 ; 

.L0993 ;  _Level_Data_Pointer  =  63  :  _Animation_Timer  =  250

	LDA #63
	STA _Level_Data_Pointer
	LDA #250
	STA _Animation_Timer
.
 ; 

.L0994 ;  gosub __Setup_Colors

 jsr .__Setup_Colors

.
 ; 

.__Intro_Screen_2
 ; __Intro_Screen_2

.
 ; 

.L0995 ;  gosub __Show_Level

 jsr .__Show_Level

.
 ; 

.L0996 ;  COLUPF  =  $00

	LDA #$00
	STA COLUPF
.
 ; 

.L0997 ;  x  =  _Lives_Counter  -  1

	LDA _Lives_Counter
	SEC
	SBC #1
	STA x
.
 ; 

.L0998 ;  gosub __Mario_Icon

 jsr .__Mario_Icon

.
 ; 

.L0999 ;  gosub __Number_Colors_P1

 jsr .__Number_Colors_P1

.
 ; 

.L01000 ;  on x gosub __1Mario __2Mario __3Mario __4Mario __5Mario __6Mario __7Mario __8Mario __9Mario

	lda #>(ongosub9-1)
	PHA
	lda #<(ongosub9-1)
	PHA
	LDX x
	LDA .L01000jumptablehi,x
	PHA
	LDA .L01000jumptablelo,x
	PHA
	RTS
.L01000jumptablehi
	.byte >(.__1Mario-1)
	.byte >(.__2Mario-1)
	.byte >(.__3Mario-1)
	.byte >(.__4Mario-1)
	.byte >(.__5Mario-1)
	.byte >(.__6Mario-1)
	.byte >(.__7Mario-1)
	.byte >(.__8Mario-1)
	.byte >(.__9Mario-1)
.L01000jumptablelo
	.byte <(.__1Mario-1)
	.byte <(.__2Mario-1)
	.byte <(.__3Mario-1)
	.byte <(.__4Mario-1)
	.byte <(.__5Mario-1)
	.byte <(.__6Mario-1)
	.byte <(.__7Mario-1)
	.byte <(.__8Mario-1)
	.byte <(.__9Mario-1)
ongosub9
.
 ; 

.L01001 ;  player0x  =  71  :  player1x  =  81

	LDA #71
	STA player0x
	LDA #81
	STA player1x
.
 ; 

.L01002 ;  player0y  =  56  :  player1y  =  54

	LDA #56
	STA player0y
	LDA #54
	STA player1y
.
 ; 

.L01003 ;  drawscreen

 sta temp7
 lda #>(ret_point66-1)
 pha
 lda #<(ret_point66-1)
 pha
 lda #>(drawscreen-1)
 pha
 lda #<(drawscreen-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #8
 jmp BS_jsr
ret_point66
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01004 ;  if _Level  =  4  &&  _Bit6_Checkpoint_Flag{6} then _Level_Data_Pointer  =  0  :  goto __Skip_Scroll

	LDA _Level
	CMP #4
     BNE .skipL01004
.condpart540
	BIT _Bit6_Checkpoint_Flag
	BVC .skip540then
.condpart541
	LDA #0
	STA _Level_Data_Pointer
 jmp .__Skip_Scroll

.skip540then
.skipL01004
.
 ; 

.L01005 ;  if _Level_Data_Pointer  >  31 then gosub __Scroll_Right bank1

	LDA #31
	CMP _Level_Data_Pointer
     BCS .skipL01005
.condpart542
 sta temp7
 lda #>(ret_point67-1)
 pha
 lda #<(ret_point67-1)
 pha
 lda #>(.__Scroll_Right-1)
 pha
 lda #<(.__Scroll_Right-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
ret_point67
.skipL01005
.
 ; 

.__Skip_Scroll
 ; __Skip_Scroll

.
 ; 

.L01006 ;  if !joy0fire then goto __Intro_Screen_2

 bit INPT4
	BPL .skipL01006
.condpart543
 jmp .__Intro_Screen_2

.skipL01006
.
 ; 

.L01007 ;  if _Level_Data_Pointer  >  31 then goto __Intro_Screen_2

	LDA #31
	CMP _Level_Data_Pointer
     BCS .skipL01007
.condpart544
 jmp .__Intro_Screen_2

.skipL01007
.
 ; 

.L01008 ;  _Level_Timer  =  0  :  pfscore1  =  255

	LDA #0
	STA _Level_Timer
	LDA #255
	STA pfscore1
.
 ; 

.L01009 ;  _Bit2_Fire_Button_Pressed{2}  =  1

	LDA _Bit2_Fire_Button_Pressed
	ORA #4
	STA _Bit2_Fire_Button_Pressed
.
 ; 

.L01010 ;  if !_Bit6_Checkpoint_Flag{6} then player0y  =  79

	BIT _Bit6_Checkpoint_Flag
	BVS .skipL01010
.condpart545
	LDA #79
	STA player0y
.skipL01010
.
 ; 

.L01011 ;  if _Bit6_Checkpoint_Flag{6}  &&  _Level  <  3 then player0y  =  63

	BIT _Bit6_Checkpoint_Flag
	BVC .skipL01011
.condpart546
	LDA _Level
	CMP #3
     BCS .skip546then
.condpart547
	LDA #63
	STA player0y
.skip546then
.skipL01011
.
 ; 

.L01012 ;  goto __Intro_Screen_6

 jmp .__Intro_Screen_6

.
 ; 

.__Intro_Screen_3
 ; __Intro_Screen_3

.
 ; 

.L01013 ;  AUDV0  =  0  :  AUDV1  =  0  :  _Level_Data_Pointer  =  63  :  _Animation_Timer  =  250

	LDA #0
	STA AUDV0
	STA AUDV1
	LDA #63
	STA _Level_Data_Pointer
	LDA #250
	STA _Animation_Timer
.
 ; 

.L01014 ;  gosub __Setup_Colors

 jsr .__Setup_Colors

.
 ; 

.__Intro_Screen_5
 ; __Intro_Screen_5

.
 ; 

.L01015 ;  COLUPF  =  $00  :  COLUBK  =  $00

	LDA #$00
	STA COLUPF
	STA COLUBK
.
 ; 

.L01016 ;  gosub __Scroll_Right bank1

 sta temp7
 lda #>(ret_point68-1)
 pha
 lda #<(ret_point68-1)
 pha
 lda #>(.__Scroll_Right-1)
 pha
 lda #<(.__Scroll_Right-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
ret_point68
.
 ; 

.L01017 ;  drawscreen

 sta temp7
 lda #>(ret_point69-1)
 pha
 lda #<(ret_point69-1)
 pha
 lda #>(drawscreen-1)
 pha
 lda #<(drawscreen-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #8
 jmp BS_jsr
ret_point69
.
 ; 

.L01018 ;  if _Level_Data_Pointer  >  31 then goto __Intro_Screen_5

	LDA #31
	CMP _Level_Data_Pointer
     BCS .skipL01018
.condpart548
 jmp .__Intro_Screen_5

.skipL01018
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Intro_Screen_6
 ; __Intro_Screen_6

.
 ; 

.L01019 ;  if _Level  =  1 then gosub __OW1_Colors  :  COLUBK  =  $00  :  gosub __OW_Music bank7

	LDA _Level
	CMP #1
     BNE .skipL01019
.condpart549
 jsr .__OW1_Colors
	LDA #$00
	STA COLUBK
 sta temp7
 lda #>(ret_point70-1)
 pha
 lda #<(ret_point70-1)
 pha
 lda #>(.__OW_Music-1)
 pha
 lda #<(.__OW_Music-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #7
 jmp BS_jsr
ret_point70
.skipL01019
.
 ; 

.L01020 ;  if _Level  =  2 then gosub __UW1_Colors  :  COLUBK  =  $00  :  gosub __UW_Music bank7

	LDA _Level
	CMP #2
     BNE .skipL01020
.condpart550
 jsr .__UW1_Colors
	LDA #$00
	STA COLUBK
 sta temp7
 lda #>(ret_point71-1)
 pha
 lda #<(ret_point71-1)
 pha
 lda #>(.__UW_Music-1)
 pha
 lda #<(.__UW_Music-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #7
 jmp BS_jsr
ret_point71
.skipL01020
.
 ; 

.L01021 ;  if _Level  =  3 then gosub __OW2_Colors  :  COLUBK  =  $A0  :  gosub __OW_Music bank7

	LDA _Level
	CMP #3
     BNE .skipL01021
.condpart551
 jsr .__OW2_Colors
	LDA #$A0
	STA COLUBK
 sta temp7
 lda #>(ret_point72-1)
 pha
 lda #<(ret_point72-1)
 pha
 lda #>(.__OW_Music-1)
 pha
 lda #<(.__OW_Music-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #7
 jmp BS_jsr
ret_point72
.skipL01021
.
 ; 

.L01022 ;  if _Level  =  4 then COLUBK  =  $00

	LDA _Level
	CMP #4
     BNE .skipL01022
.condpart552
	LDA #$00
	STA COLUBK
.skipL01022
.
 ; 

.L01023 ;  if _Level  =  4  &&  !_Bit6_Checkpoint_Flag{6} then gosub __UW2_Colors  :  gosub __UW_Music bank7

	LDA _Level
	CMP #4
     BNE .skipL01023
.condpart553
	BIT _Bit6_Checkpoint_Flag
	BVS .skip553then
.condpart554
 jsr .__UW2_Colors
 sta temp7
 lda #>(ret_point73-1)
 pha
 lda #<(ret_point73-1)
 pha
 lda #>(.__UW_Music-1)
 pha
 lda #<(.__UW_Music-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #7
 jmp BS_jsr
ret_point73
.skip553then
.skipL01023
.
 ; 

.L01024 ;  if _Level  =  4  &&  _Bit6_Checkpoint_Flag{6} then gosub __Boss_Level_Setup

	LDA _Level
	CMP #4
     BNE .skipL01024
.condpart555
	BIT _Bit6_Checkpoint_Flag
	BVC .skip555then
.condpart556
 jsr .__Boss_Level_Setup

.skip555then
.skipL01024
.
 ; 

.L01025 ;  _Momentum_Left_Right  =  0  :  _Animation_Timer  =  0  :  _Momentum_Up_Down  =  0  :  _Object_Scroll_In_Data  =  0  :  _Farthest_Traveled_On_Level  =  0  :  _Moving_Shell_X_Coordinate  =  0  :  u  =  0

	LDA #0
	STA _Momentum_Left_Right
	STA _Animation_Timer
	STA _Momentum_Up_Down
	STA _Object_Scroll_In_Data
	STA _Farthest_Traveled_On_Level
	STA _Moving_Shell_X_Coordinate
	STA u
.
 ; 

.L01026 ;  scorecolor  =  $0E  :  _Level_Data_Pointer  =  32  :  _Music_Duration  =  1  :  _Bit5_Moving_Turtle_Shell_Direction{5}  =  1

	LDA #$0E
	STA scorecolor
	LDA #32
	STA _Level_Data_Pointer
	LDA #1
	STA _Music_Duration
	LDA _Bit5_Moving_Turtle_Shell_Direction
	ORA #32
	STA _Bit5_Moving_Turtle_Shell_Direction
.
 ; 

.L01027 ;  player1y  =  150  :  bally  =  150  :  player0x  =  24  :  pfscorecolor  =  28

	LDA #150
	STA player1y
	STA bally
	LDA #24
	STA player0x
	LDA #28
	STA pfscorecolor
.
 ; 

.L01028 ;  player1x  =  0  :  var44  =  0  :  var45  =  0  :  var46  =  0  :  var47  =  0  :  ballx  =  0

	LDA #0
	STA player1x
	STA var44
	STA var45
	STA var46
	STA var47
	STA ballx
.
 ; 

.L01029 ;  return otherbank

	JMP BS_return
.
 ; 

.__Boss_Level_Setup
 ; __Boss_Level_Setup

.
 ; 

.L01030 ;  if _World  =  1 then gosub __Boss_PF_Setup bank5

	LDA _World
	CMP #1
     BNE .skipL01030
.condpart557
 sta temp7
 lda #>(ret_point74-1)
 pha
 lda #<(ret_point74-1)
 pha
 lda #>(.__Boss_PF_Setup-1)
 pha
 lda #<(.__Boss_PF_Setup-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #5
 jmp BS_jsr
ret_point74
.skipL01030
.
 ; 

.L01031 ;  if _World  =  2 then gosub __Boss_PF_Setup_2 bank5

	LDA _World
	CMP #2
     BNE .skipL01031
.condpart558
 sta temp7
 lda #>(ret_point75-1)
 pha
 lda #<(ret_point75-1)
 pha
 lda #>(.__Boss_PF_Setup_2-1)
 pha
 lda #<(.__Boss_PF_Setup_2-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #5
 jmp BS_jsr
ret_point75
.skipL01031
.
 ; 

.L01032 ;  if _World  =  3 then gosub __Boss_PF_Setup_3 bank6

	LDA _World
	CMP #3
     BNE .skipL01032
.condpart559
 sta temp7
 lda #>(ret_point76-1)
 pha
 lda #<(ret_point76-1)
 pha
 lda #>(.__Boss_PF_Setup_3-1)
 pha
 lda #<(.__Boss_PF_Setup_3-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #6
 jmp BS_jsr
ret_point76
.skipL01032
.
 ; 

.L01033 ;  if _World  =  4 then gosub __Boss_PF_Setup_4 bank6

	LDA _World
	CMP #4
     BNE .skipL01033
.condpart560
 sta temp7
 lda #>(ret_point77-1)
 pha
 lda #<(ret_point77-1)
 pha
 lda #>(.__Boss_PF_Setup_4-1)
 pha
 lda #<(.__Boss_PF_Setup_4-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #6
 jmp BS_jsr
ret_point77
.skipL01033
.
 ; 

.L01034 ;  gosub __Boss_Colors

 jsr .__Boss_Colors

.
 ; 

.L01035 ;  return thisbank

	RTS
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Setup_Colors
 ; __Setup_Colors

.L01036 ;  pfcolors:

 lda # $00
 sta COLUPF
 ifconst pfres
 lda #>(pfcolorlabel360-131+pfres*pfwidth)
 else
 lda #>(pfcolorlabel360-83)
 endif
 sta pfcolortable+1
 ifconst pfres
 lda #<(pfcolorlabel360-131+pfres*pfwidth)
 else
 lda #<(pfcolorlabel360-83)
 endif
 sta pfcolortable
.L01037 ;  return thisbank

	RTS
.
 ; 

.__OW1_Colors
 ; __OW1_Colors

.L01038 ;  pfcolors:

 lda # $32
 sta COLUPF
 ifconst pfres
 lda #>(pfcolorlabel360-130+pfres*pfwidth)
 else
 lda #>(pfcolorlabel360-82)
 endif
 sta pfcolortable+1
 ifconst pfres
 lda #<(pfcolorlabel360-130+pfres*pfwidth)
 else
 lda #<(pfcolorlabel360-82)
 endif
 sta pfcolortable
.L01039 ;  return thisbank

	RTS
.
 ; 

.__OW2_Colors
 ; __OW2_Colors

.L01040 ;  pfcolors:

 lda # $18
 sta COLUPF
 ifconst pfres
 lda #>(pfcolorlabel360-129+pfres*pfwidth)
 else
 lda #>(pfcolorlabel360-81)
 endif
 sta pfcolortable+1
 ifconst pfres
 lda #<(pfcolorlabel360-129+pfres*pfwidth)
 else
 lda #<(pfcolorlabel360-81)
 endif
 sta pfcolortable
.L01041 ;  return thisbank

	RTS
.
 ; 

.__UW1_Colors
 ; __UW1_Colors

.L01042 ;  pfcolors:

 lda # $A4
 sta COLUPF
 ifconst pfres
 lda #>(pfcolorlabel1194-132+pfres*pfwidth)
 else
 lda #>(pfcolorlabel1194-84)
 endif
 sta pfcolortable+1
 ifconst pfres
 lda #<(pfcolorlabel1194-132+pfres*pfwidth)
 else
 lda #<(pfcolorlabel1194-84)
 endif
 sta pfcolortable
.L01043 ;  return thisbank

	RTS
.
 ; 

.__UW2_Colors
 ; __UW2_Colors

.L01044 ;  pfcolors:

 lda # $04
 sta COLUPF
 ifconst pfres
 lda #>(pfcolorlabel1194-131+pfres*pfwidth)
 else
 lda #>(pfcolorlabel1194-83)
 endif
 sta pfcolortable+1
 ifconst pfres
 lda #<(pfcolorlabel1194-131+pfres*pfwidth)
 else
 lda #<(pfcolorlabel1194-83)
 endif
 sta pfcolortable
.L01045 ;  return thisbank

	RTS
.
 ; 

.__Boss_Colors
 ; __Boss_Colors

.L01046 ;  pfcolors:

 lda # $04
 sta COLUPF
 ifconst pfres
 lda #>(pfcolorlabel1194-130+pfres*pfwidth)
 else
 lda #>(pfcolorlabel1194-82)
 endif
 sta pfcolortable+1
 ifconst pfres
 lda #<(pfcolorlabel1194-130+pfres*pfwidth)
 else
 lda #<(pfcolorlabel1194-82)
 endif
 sta pfcolortable
.L01047 ;  return thisbank

	RTS
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Game_Over_Screen
 ; __Game_Over_Screen

.
 ; 

.L01048 ;  pfclear

	LDA #0
 sta temp7
 lda #>(ret_point78-1)
 pha
 lda #<(ret_point78-1)
 pha
 lda #>(pfclear-1)
 pha
 lda #<(pfclear-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #8
 jmp BS_jsr
ret_point78
.
 ; 

.L01049 ;  COLUBK  =  $00

	LDA #$00
	STA COLUBK
.
 ; 

.L01050 ;  gosub __Game_Over_Music

 jsr .__Game_Over_Music

.
 ; 

.L01051 ;  _Music_Duration  =  1

	LDA #1
	STA _Music_Duration
.
 ; 

.__Gm_Ovr_Scrn_2
 ; __Gm_Ovr_Scrn_2

.
 ; 

.L01052 ;  gosub __Number_Colors_P0  :  gosub __Number_Colors_P1

 jsr .__Number_Colors_P0
 jsr .__Number_Colors_P1

.
 ; 

.L01053 ;  gosub __GA  :  gosub __ME

 jsr .__GA
 jsr .__ME

.
 ; 

.L01054 ;  player0x  =  73  :  player1x  =  81

	LDA #73
	STA player0x
	LDA #81
	STA player1x
.
 ; 

.L01055 ;  player0y  =  32  :  player1y  =  32

	LDA #32
	STA player0y
	STA player1y
.
 ; 

.L01056 ;  gosub __Play_Game_Over_Music

 jsr .__Play_Game_Over_Music

.
 ; 

.L01057 ;  drawscreen

 sta temp7
 lda #>(ret_point79-1)
 pha
 lda #<(ret_point79-1)
 pha
 lda #>(drawscreen-1)
 pha
 lda #<(drawscreen-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #8
 jmp BS_jsr
ret_point79
.
 ; 

.L01058 ;  gosub __OV  :  gosub __ER

 jsr .__OV
 jsr .__ER

.
 ; 

.L01059 ;  player0x  =  73  :  player1x  =  81

	LDA #73
	STA player0x
	LDA #81
	STA player1x
.
 ; 

.L01060 ;  player0y  =  44  :  player1y  =  44

	LDA #44
	STA player0y
	STA player1y
.
 ; 

.L01061 ;  gosub __Play_Game_Over_Music

 jsr .__Play_Game_Over_Music

.
 ; 

.L01062 ;  drawscreen

 sta temp7
 lda #>(ret_point80-1)
 pha
 lda #<(ret_point80-1)
 pha
 lda #>(drawscreen-1)
 pha
 lda #<(drawscreen-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #8
 jmp BS_jsr
ret_point80
.
 ; 

.L01063 ;  if _Music_Duration  =  255 then _Level  =  1  :  _Coin_Counter  =  0  :  _Bit3_Super_Mario_Power{3}  =  0  :  _Bit4_Firey_Mario_Power{4}  =  0  :  pfscore2  =  0  :  g  =  0  :  _Bit6_Regular_Mario{6}  =  1  :  _Animation_Timer  =  _World  :  goto __Gm_Ovr_Scrn_3

	LDA _Music_Duration
	CMP #255
     BNE .skipL01063
.condpart561
	LDA #1
	STA _Level
	LDA #0
	STA _Coin_Counter
	LDA _Bit3_Super_Mario_Power
	AND #247
	STA _Bit3_Super_Mario_Power
	LDA _Bit4_Firey_Mario_Power
	AND #239
	STA _Bit4_Firey_Mario_Power
	LDA #0
	STA pfscore2
	STA g
	LDA _Bit6_Regular_Mario
	ORA #64
	STA _Bit6_Regular_Mario
	LDA _World
	STA _Animation_Timer
 jmp .__Gm_Ovr_Scrn_3

.skipL01063
.
 ; 

.L01064 ;  goto __Gm_Ovr_Scrn_2

 jmp .__Gm_Ovr_Scrn_2

.
 ; 

.__Gm_Ovr_Scrn_3
 ; __Gm_Ovr_Scrn_3

.
 ; 

.L01065 ;  gosub __Show_Level

 jsr .__Show_Level

.
 ; 

.L01066 ;  if !joy0up then _Bit0_Mario_Fireball_Going_Down{0}  =  0

 lda #$10
 bit SWCHA
	BEQ .skipL01066
.condpart562
	LDA _Bit0_Mario_Fireball_Going_Down
	AND #254
	STA _Bit0_Mario_Fireball_Going_Down
.skipL01066
.
 ; 

.L01067 ;  if !joy0down then _Bit1_Mario_Fireball_Going_Up{1}  =  0

 lda #$20
 bit SWCHA
	BEQ .skipL01067
.condpart563
	LDA _Bit1_Mario_Fireball_Going_Up
	AND #253
	STA _Bit1_Mario_Fireball_Going_Up
.skipL01067
.
 ; 

.L01068 ;  if joy0up  &&  !_Bit0_Mario_Fireball_Going_Down{0} then _Level  =  _Level  +  1  :  _Bit0_Mario_Fireball_Going_Down{0}  =  1

 lda #$10
 bit SWCHA
	BNE .skipL01068
.condpart564
	LDA _Bit0_Mario_Fireball_Going_Down
	LSR
	BCS .skip564then
.condpart565
	INC _Level
	LDA _Bit0_Mario_Fireball_Going_Down
	ORA #1
	STA _Bit0_Mario_Fireball_Going_Down
.skip564then
.skipL01068
.
 ; 

.L01069 ;  if joy0down  &&  !_Bit1_Mario_Fireball_Going_Up{1} then _Level  =  _Level  -  1  :  _Bit1_Mario_Fireball_Going_Up{1}  =  1

 lda #$20
 bit SWCHA
	BNE .skipL01069
.condpart566
	LDA _Bit1_Mario_Fireball_Going_Up
	AND #2
	BNE .skip566then
.condpart567
	DEC _Level
	LDA _Bit1_Mario_Fireball_Going_Up
	ORA #2
	STA _Bit1_Mario_Fireball_Going_Up
.skip566then
.skipL01069
.
 ; 

.L01070 ;  if joy0fire then goto __Gm_Ovr_Scrn_4

 bit INPT4
	BMI .skipL01070
.condpart568
 jmp .__Gm_Ovr_Scrn_4

.skipL01070
.
 ; 

.L01071 ;  if _Level  =  0 then _Level  =  4  :  _World  =  _World  -  1

	LDA _Level
	CMP #0
     BNE .skipL01071
.condpart569
	LDA #4
	STA _Level
	DEC _World
.skipL01071
.
 ; 

.L01072 ;  if _Level  =  5 then _Level  =  1  :  _World  =  _World  +  1

	LDA _Level
	CMP #5
     BNE .skipL01072
.condpart570
	LDA #1
	STA _Level
	INC _World
.skipL01072
.
 ; 

.L01073 ;  if _World  =  0 then _World  =  _Animation_Timer  :  _Level  =  1

	LDA _World
	CMP #0
     BNE .skipL01073
.condpart571
	LDA _Animation_Timer
	STA _World
	LDA #1
	STA _Level
.skipL01073
.
 ; 

.L01074 ;  if _World  =  _Animation_Timer  &&  _Level  >  1 then _World  =  1  :  _Level  =  1

	LDA _World
	CMP _Animation_Timer
     BNE .skipL01074
.condpart572
	LDA #1
	CMP _Level
     BCS .skip572then
.condpart573
	LDA #1
	STA _World
	STA _Level
.skip572then
.skipL01074
.
 ; 

.L01075 ;  goto __Gm_Ovr_Scrn_3

 jmp .__Gm_Ovr_Scrn_3

.
 ; 

.__Gm_Ovr_Scrn_4
 ; __Gm_Ovr_Scrn_4

.
 ; 

.L01076 ;  if switchleftb then _Lives_Counter  =  3 else _Lives_Counter  =  5

 bit SWCHB
	BVS .skipL01076
.condpart574
	LDA #3
	STA _Lives_Counter
 jmp .skipelse75
.skipL01076
	LDA #5
	STA _Lives_Counter
.skipelse75
.
 ; 

.L01077 ;  g  =  0  :  _Animation_Timer  =  0  :  score  =  0

	LDA #0
	STA g
	STA _Animation_Timer
	LDA #$00
	STA score+2
	LDA #$00
	STA score+1
	LDA #$00
	STA score
.
 ; 

.L01078 ;  goto __Init bank1

 sta temp7
 lda #>(.__Init-1)
 pha
 lda #<(.__Init-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Show_Level
 ; __Show_Level

.
 ; 

.L01079 ;  COLUBK  =  $00  :  COLUPF  =  $00  :  CTRLPF  =  $11  :  x  =  _World  -  1  :  y  =  _Level  -  1

	LDA #$00
	STA COLUBK
	STA COLUPF
	LDA #$11
	STA CTRLPF
	LDA _World
	SEC
	SBC #1
	STA x
	LDA _Level
	SEC
	SBC #1
	STA y
.
 ; 

.L01080 ;  gosub __Number_Colors_P0  :  gosub __Number_Colors_P1

 jsr .__Number_Colors_P0
 jsr .__Number_Colors_P1

.
 ; 

.L01081 ;  on x gosub __1World __2World __3World __4World

	lda #>(ongosub10-1)
	PHA
	lda #<(ongosub10-1)
	PHA
	LDX x
	LDA .L01081jumptablehi,x
	PHA
	LDA .L01081jumptablelo,x
	PHA
	RTS
.L01081jumptablehi
	.byte >(.__1World-1)
	.byte >(.__2World-1)
	.byte >(.__3World-1)
	.byte >(.__4World-1)
.L01081jumptablelo
	.byte <(.__1World-1)
	.byte <(.__2World-1)
	.byte <(.__3World-1)
	.byte <(.__4World-1)
ongosub10
.
 ; 

.L01082 ;  on y gosub __1Level __2Level __3Level __4Level

	lda #>(ongosub11-1)
	PHA
	lda #<(ongosub11-1)
	PHA
	LDX y
	LDA .L01082jumptablehi,x
	PHA
	LDA .L01082jumptablelo,x
	PHA
	RTS
.L01082jumptablehi
	.byte >(.__1Level-1)
	.byte >(.__2Level-1)
	.byte >(.__3Level-1)
	.byte >(.__4Level-1)
.L01082jumptablelo
	.byte <(.__1Level-1)
	.byte <(.__2Level-1)
	.byte <(.__3Level-1)
	.byte <(.__4Level-1)
ongosub11
.
 ; 

.L01083 ;  player0x  =  73  :  player1x  =  81

	LDA #73
	STA player0x
	LDA #81
	STA player1x
.
 ; 

.L01084 ;  player0y  =  32  :  player1y  =  32

	LDA #32
	STA player0y
	STA player1y
.
 ; 

.L01085 ;  if switchreset then reboot

 lda #1
 bit SWCHB
	BNE .skipL01085
.condpart575
	JMP ($FFFC)
.skipL01085
.
 ; 

.L01086 ;  drawscreen

 sta temp7
 lda #>(ret_point81-1)
 pha
 lda #<(ret_point81-1)
 pha
 lda #>(drawscreen-1)
 pha
 lda #<(drawscreen-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #8
 jmp BS_jsr
ret_point81
.
 ; 

.L01087 ;  return thisbank

	RTS
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Number_Colors_P0
 ; __Number_Colors_P0

.L01088 ;  player0color:

	LDX #<playercolorL01088_0
	STX player0color
	LDA #>playercolorL01088_0
	STA player0color+1
.L01089 ;  return thisbank

	RTS
.
 ; 

.__Number_Colors_P1
 ; __Number_Colors_P1

.L01090 ;  player1color:

	LDX #<playercolorL01090_1
	STX player1color
	LDA #>playercolorL01090_1
	STA player1color+1
.L01091 ;  return thisbank

	RTS
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Bowser_Jr
 ; __Bowser_Jr

.
 ; 

.L01092 ;  if ballx  >  0  &&  _Farthest_Traveled_On_Level  <  3 then _Level_Data_Pointer  =  5  :  goto __Bowser_Jr_2

	LDA #0
	CMP ballx
     BCS .skipL01092
.condpart576
	LDA _Farthest_Traveled_On_Level
	CMP #3
     BCS .skip576then
.condpart577
	LDA #5
	STA _Level_Data_Pointer
 jmp .__Bowser_Jr_2

.skip576then
.skipL01092
.
 ; 

.__Bowser_Jr_1
 ; __Bowser_Jr_1

.
 ; 

.L01093 ;  if _Farthest_Traveled_On_Level  =  0 then goto __Bowser_Jr_Moving

	LDA _Farthest_Traveled_On_Level
	CMP #0
     BNE .skipL01093
.condpart578
 jmp .__Bowser_Jr_Moving

.skipL01093
.
 ; 

.L01094 ;  if _Farthest_Traveled_On_Level  >  0  &&  _Farthest_Traveled_On_Level  <  11 then goto __Bowser_Jr_Jumping

	LDA #0
	CMP _Farthest_Traveled_On_Level
     BCS .skipL01094
.condpart579
	LDA _Farthest_Traveled_On_Level
	CMP #11
     BCS .skip579then
.condpart580
 jmp .__Bowser_Jr_Jumping

.skip579then
.skipL01094
.
 ; 

.L01095 ;  if _Farthest_Traveled_On_Level  =  11  ||  _Farthest_Traveled_On_Level  =  12 then goto __Bowser_Jr_Shell

	LDA _Farthest_Traveled_On_Level
	CMP #11
     BNE .skipL01095
.condpart581
 jmp .condpart582
.skipL01095
	LDA _Farthest_Traveled_On_Level
	CMP #12
     BNE .skip157OR
.condpart582
 jmp .__Bowser_Jr_Shell

.skip157OR
.
 ; 

.L01096 ;  if _Farthest_Traveled_On_Level  >  12 then goto __Bowser_Jr_Standing

	LDA #12
	CMP _Farthest_Traveled_On_Level
     BCS .skipL01096
.condpart583
 jmp .__Bowser_Jr_Standing

.skipL01096
.
 ; 

.__Bowser_Jr_2
 ; __Bowser_Jr_2

.
 ; 

.L01097 ;  on _Level_Data_Pointer gosub __BJC1 __BJC1 __BJCColor __BJJColor __BJSC __BJDC

	lda #>(ongosub12-1)
	PHA
	lda #<(ongosub12-1)
	PHA
	LDX _Level_Data_Pointer
	LDA .L01097jumptablehi,x
	PHA
	LDA .L01097jumptablelo,x
	PHA
	RTS
.L01097jumptablehi
	.byte >(.__BJC1-1)
	.byte >(.__BJC1-1)
	.byte >(.__BJCColor-1)
	.byte >(.__BJJColor-1)
	.byte >(.__BJSC-1)
	.byte >(.__BJDC-1)
.L01097jumptablelo
	.byte <(.__BJC1-1)
	.byte <(.__BJC1-1)
	.byte <(.__BJCColor-1)
	.byte <(.__BJJColor-1)
	.byte <(.__BJSC-1)
	.byte <(.__BJDC-1)
ongosub12
.
 ; 

.L01098 ;  on _Level_Data_Pointer gosub __BJ1 __BJ2 __BJC __BJJ __BJS __BJD

	lda #>(ongosub13-1)
	PHA
	lda #<(ongosub13-1)
	PHA
	LDX _Level_Data_Pointer
	LDA .L01098jumptablehi,x
	PHA
	LDA .L01098jumptablelo,x
	PHA
	RTS
.L01098jumptablehi
	.byte >(.__BJ1-1)
	.byte >(.__BJ2-1)
	.byte >(.__BJC-1)
	.byte >(.__BJJ-1)
	.byte >(.__BJS-1)
	.byte >(.__BJD-1)
.L01098jumptablelo
	.byte <(.__BJ1-1)
	.byte <(.__BJ2-1)
	.byte <(.__BJC-1)
	.byte <(.__BJJ-1)
	.byte <(.__BJS-1)
	.byte <(.__BJD-1)
ongosub13
.
 ; 

.L01099 ;  goto __Main_Loop bank1

 sta temp7
 lda #>(.__Main_Loop-1)
 pha
 lda #<(.__Main_Loop-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
.
 ; 

.__Bowser_Jr_Moving
 ; __Bowser_Jr_Moving

.
 ; 

.L01100 ;  if !_Bit3_Enemy_Direction{3} then x  =  player1x  -  3  :  y  =   ( x  -  13 )  / 4 else x  =  player1x  +  3  :  y  =  x / 4

	LDA _Bit3_Enemy_Direction
	AND #8
	BNE .skipL01100
.condpart584
	LDA player1x
	SEC
	SBC #3
	STA x
; complex statement detected
	LDA x
	SEC
	SBC #13
	lsr
	lsr
	STA y
 jmp .skipelse76
.skipL01100
	LDA player1x
	CLC
	ADC #3
	STA x
	LDA x
	lsr
	lsr
	STA y
.skipelse76
.
 ; 

.L01101 ;  if _Animation_Timer  >  3 then _Level_Data_Pointer  =  1 else _Level_Data_Pointer  =  0

	LDA #3
	CMP _Animation_Timer
     BCS .skipL01101
.condpart585
	LDA #1
	STA _Level_Data_Pointer
 jmp .skipelse77
.skipL01101
	LDA #0
	STA _Level_Data_Pointer
.skipelse77
.
 ; 

.__Bowser_Jr_Moving_2
 ; __Bowser_Jr_Moving_2

.
 ; 

.L01102 ;  if pfread ( y , 9 )  then gosub __Change_Bowser_Jr_Direction  :  goto __Bowser_Jr_2

	LDA y
	LDY #9
 sta temp7
 lda #>(ret_point82-1)
 pha
 lda #<(ret_point82-1)
 pha
 lda #>(pfread-1)
 pha
 lda #<(pfread-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #8
 jmp BS_jsr
ret_point82
	BNE .skipL01102
.condpart586
 jsr .__Change_Bowser_Jr_Direction
 jmp .__Bowser_Jr_2

.skipL01102
.
 ; 

.L01103 ;  if !pfread ( y , 10 )  then gosub __Change_Bowser_Jr_Direction  :  goto __Bowser_Jr_2

	LDA y
	LDY #10
 sta temp7
 lda #>(ret_point83-1)
 pha
 lda #<(ret_point83-1)
 pha
 lda #>(pfread-1)
 pha
 lda #<(pfread-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #8
 jmp BS_jsr
ret_point83
	BEQ .skipL01103
.condpart587
 jsr .__Change_Bowser_Jr_Direction
 jmp .__Bowser_Jr_2

.skipL01103
.
 ; 

.L01104 ;  player1x  =  x

	LDA x
	STA player1x
.
 ; 

.L01105 ;  if _Enemy_Momentum  <  1  &&  _Farthest_Traveled_On_Level  =  12 then _Farthest_Traveled_On_Level  =  13  :  _Level_Data_Pointer  =  0  :  _Enemy_Momentum  =  8

	LDA _Enemy_Momentum
	CMP #1
     BCS .skipL01105
.condpart588
	LDA _Farthest_Traveled_On_Level
	CMP #12
     BNE .skip588then
.condpart589
	LDA #13
	STA _Farthest_Traveled_On_Level
	LDA #0
	STA _Level_Data_Pointer
	LDA #8
	STA _Enemy_Momentum
.skip588then
.skipL01105
.
 ; 

.L01106 ;  if _Farthest_Traveled_On_Level  =  0  &&  _Animation_Timer  >  4  &&  _Music_Duration  =  3 then _Farthest_Traveled_On_Level  =  1

	LDA _Farthest_Traveled_On_Level
	CMP #0
     BNE .skipL01106
.condpart590
	LDA #4
	CMP _Animation_Timer
     BCS .skip590then
.condpart591
	LDA _Music_Duration
	CMP #3
     BNE .skip591then
.condpart592
	LDA #1
	STA _Farthest_Traveled_On_Level
.skip591then
.skip590then
.skipL01106
.
 ; 

.L01107 ;  if _Farthest_Traveled_On_Level  =  11  &&  _Animation_Timer  >  4  &&  _Music_Duration  =  3 then _Farthest_Traveled_On_Level  =  12  :  _Enemy_Momentum  =  6

	LDA _Farthest_Traveled_On_Level
	CMP #11
     BNE .skipL01107
.condpart593
	LDA #4
	CMP _Animation_Timer
     BCS .skip593then
.condpart594
	LDA _Music_Duration
	CMP #3
     BNE .skip594then
.condpart595
	LDA #12
	STA _Farthest_Traveled_On_Level
	LDA #6
	STA _Enemy_Momentum
.skip594then
.skip593then
.skipL01107
.
 ; 

.L01108 ;  goto __Bowser_Jr_2

 jmp .__Bowser_Jr_2

.
 ; 

.__Change_Bowser_Jr_Direction
 ; __Change_Bowser_Jr_Direction

.
 ; 

.L01109 ;  if _Bit3_Enemy_Direction{3} then _Bit3_Enemy_Direction{3}  =  0 else _Bit3_Enemy_Direction{3}  =  1

	LDA _Bit3_Enemy_Direction
	AND #8
	BEQ .skipL01109
.condpart596
	LDA _Bit3_Enemy_Direction
	AND #247
	STA _Bit3_Enemy_Direction
 jmp .skipelse78
.skipL01109
	LDA _Bit3_Enemy_Direction
	ORA #8
	STA _Bit3_Enemy_Direction
.skipelse78
.
 ; 

.L01110 ;  return thisbank

	RTS
.
 ; 

.__Bowser_Jr_Jumping
 ; __Bowser_Jr_Jumping

.
 ; 

.L01111 ;  if !_Bit3_Enemy_Direction{3}  &&  player1x  <  68  &&  _Farthest_Traveled_On_Level  =  1 then _Farthest_Traveled_On_Level  =  0  :  _Level_Data_Pointer  =  0  :  goto __Bowser_Jr_2

	LDA _Bit3_Enemy_Direction
	AND #8
	BNE .skipL01111
.condpart597
	LDA player1x
	CMP #68
     BCS .skip597then
.condpart598
	LDA _Farthest_Traveled_On_Level
	CMP #1
     BNE .skip598then
.condpart599
	LDA #0
	STA _Farthest_Traveled_On_Level
	STA _Level_Data_Pointer
 jmp .__Bowser_Jr_2

.skip598then
.skip597then
.skipL01111
.
 ; 

.L01112 ;  if _Bit3_Enemy_Direction{3}  &&  player1x  >  82  &&  _Farthest_Traveled_On_Level  =  1 then _Farthest_Traveled_On_Level  =  0  :  _Level_Data_Pointer  =  0  :  goto __Bowser_Jr_2

	LDA _Bit3_Enemy_Direction
	AND #8
	BEQ .skipL01112
.condpart600
	LDA #82
	CMP player1x
     BCS .skip600then
.condpart601
	LDA _Farthest_Traveled_On_Level
	CMP #1
     BNE .skip601then
.condpart602
	LDA #0
	STA _Farthest_Traveled_On_Level
	STA _Level_Data_Pointer
 jmp .__Bowser_Jr_2

.skip601then
.skip600then
.skipL01112
.
 ; 

.L01113 ;  if _Farthest_Traveled_On_Level  <  8 then _Farthest_Traveled_On_Level  =  _Farthest_Traveled_On_Level  +  1  :  _Level_Data_Pointer  =  2  :  goto __Bowser_Jr_2

	LDA _Farthest_Traveled_On_Level
	CMP #8
     BCS .skipL01113
.condpart603
	INC _Farthest_Traveled_On_Level
	LDA #2
	STA _Level_Data_Pointer
 jmp .__Bowser_Jr_2

.skipL01113
.
 ; 

.L01114 ;  if _Farthest_Traveled_On_Level  =  8 then _Level_Data_Pointer  =  3  :  _Farthest_Traveled_On_Level  =  9  :  _Enemy_Momentum  =  8  :  goto __Bowser_Jr_2

	LDA _Farthest_Traveled_On_Level
	CMP #8
     BNE .skipL01114
.condpart604
	LDA #3
	STA _Level_Data_Pointer
	LDA #9
	STA _Farthest_Traveled_On_Level
	LDA #8
	STA _Enemy_Momentum
 jmp .__Bowser_Jr_2

.skipL01114
.
 ; 

.L01115 ;  if _Farthest_Traveled_On_Level  =  9 then player1y  =  player1y  -  _Enemy_Momentum else player1y  =  player1y  +  _Enemy_Momentum

	LDA _Farthest_Traveled_On_Level
	CMP #9
     BNE .skipL01115
.condpart605
	LDA player1y
	SEC
	SBC _Enemy_Momentum
	STA player1y
 jmp .skipelse79
.skipL01115
	LDA player1y
	CLC
	ADC _Enemy_Momentum
	STA player1y
.skipelse79
.
 ; 

.L01116 ;  if !_Bit3_Enemy_Direction{3} then player1x  =  player1x  -  3 else player1x  =  player1x  +  3

	LDA _Bit3_Enemy_Direction
	AND #8
	BNE .skipL01116
.condpart606
	LDA player1x
	SEC
	SBC #3
	STA player1x
 jmp .skipelse80
.skipL01116
	LDA player1x
	CLC
	ADC #3
	STA player1x
.skipelse80
.
 ; 

.L01117 ;  if _Farthest_Traveled_On_Level  =  9 then _Enemy_Momentum  =  _Enemy_Momentum  -  1 else _Enemy_Momentum  =  _Enemy_Momentum  +  1

	LDA _Farthest_Traveled_On_Level
	CMP #9
     BNE .skipL01117
.condpart607
	DEC _Enemy_Momentum
 jmp .skipelse81
.skipL01117
	INC _Enemy_Momentum
.skipelse81
.
 ; 

.L01118 ;  if _Enemy_Momentum  =  0 then _Farthest_Traveled_On_Level  =  10

	LDA _Enemy_Momentum
	CMP #0
     BNE .skipL01118
.condpart608
	LDA #10
	STA _Farthest_Traveled_On_Level
.skipL01118
.
 ; 

.L01119 ;  if player1y  >  79 then player1y  =  79  :  _Farthest_Traveled_On_Level  =  11  :  _Level_Data_Pointer  =  4

	LDA #79
	CMP player1y
     BCS .skipL01119
.condpart609
	LDA #79
	STA player1y
	LDA #11
	STA _Farthest_Traveled_On_Level
	LDA #4
	STA _Level_Data_Pointer
.skipL01119
.
 ; 

.L01120 ;  goto __Bowser_Jr_2

 jmp .__Bowser_Jr_2

.
 ; 

.__Bowser_Jr_Shell
 ; __Bowser_Jr_Shell

.
 ; 

.L01121 ;  if _Farthest_Traveled_On_Level  =  11 then _Enemy_Momentum  =  6 else _Enemy_Momentum  =  _Enemy_Momentum  -  1

	LDA _Farthest_Traveled_On_Level
	CMP #11
     BNE .skipL01121
.condpart610
	LDA #6
	STA _Enemy_Momentum
 jmp .skipelse82
.skipL01121
	DEC _Enemy_Momentum
.skipelse82
.
 ; 

.L01122 ;  if !_Bit3_Enemy_Direction{3} then x  =  player1x  -  _Enemy_Momentum  :  y  =   ( x  -  13 )  / 4 else x  =  player1x  +  _Enemy_Momentum  :  y  =  x / 4

	LDA _Bit3_Enemy_Direction
	AND #8
	BNE .skipL01122
.condpart611
	LDA player1x
	SEC
	SBC _Enemy_Momentum
	STA x
; complex statement detected
	LDA x
	SEC
	SBC #13
	lsr
	lsr
	STA y
 jmp .skipelse83
.skipL01122
	LDA player1x
	CLC
	ADC _Enemy_Momentum
	STA x
	LDA x
	lsr
	lsr
	STA y
.skipelse83
.
 ; 

.L01123 ;  goto __Bowser_Jr_Moving_2

 jmp .__Bowser_Jr_Moving_2

.
 ; 

.__Bowser_Jr_Standing
 ; __Bowser_Jr_Standing

.
 ; 

.L01124 ;  _Enemy_Momentum  =  _Enemy_Momentum  -  1

	DEC _Enemy_Momentum
.
 ; 

.L01125 ;  if _Enemy_Momentum  <  1 then _Farthest_Traveled_On_Level  =  0  :  _Level_Data_Pointer  =  0

	LDA _Enemy_Momentum
	CMP #1
     BCS .skipL01125
.condpart612
	LDA #0
	STA _Farthest_Traveled_On_Level
	STA _Level_Data_Pointer
.skipL01125
.
 ; 

.L01126 ;  goto __Bowser_Jr_2

 jmp .__Bowser_Jr_2

.
 ; 

.__Fireball_BJr_Collision
 ; __Fireball_BJr_Collision

.
 ; 

.L01127 ;  ballx  =  0  :  bally  =  120

	LDA #0
	STA ballx
	LDA #120
	STA bally
.
 ; 

.L01128 ;  if _Level_Data_Pointer  >  3 then goto __Draw bank3

	LDA #3
	CMP _Level_Data_Pointer
     BCS .skipL01128
.condpart613
 sta temp7
 lda #>(.__Draw-1)
 pha
 lda #<(.__Draw-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #3
 jmp BS_jsr
.skipL01128
.
 ; 

.L01129 ;  score  =  score  +  300

	SED
	CLC
	LDA score+1
	ADC #$03
	STA score+1
	LDA score
	ADC #$00
	STA score
	CLD
.
 ; 

.__Bowser_Jr_Hit
 ; __Bowser_Jr_Hit

.
 ; 

.L01130 ;  _Level_Timer  =  _Level_Timer  -  1  :  _Level_Data_Pointer  =  2  :  _Farthest_Traveled_On_Level  =  13  :  _Enemy_Momentum  =  6

	DEC _Level_Timer
	LDA #2
	STA _Level_Data_Pointer
	LDA #13
	STA _Farthest_Traveled_On_Level
	LDA #6
	STA _Enemy_Momentum
.
 ; 

.L01131 ;  pfscore1  =  pfscore1 / 2

	LDA pfscore1
	lsr
	STA pfscore1
.
 ; 

.L01132 ;  if _Level_Timer  <  1 then goto __Bowser_Jr_Defeated

	LDA _Level_Timer
	CMP #1
     BCS .skipL01132
.condpart614
 jmp .__Bowser_Jr_Defeated

.skipL01132
.
 ; 

.L01133 ;  goto __Draw bank3

 sta temp7
 lda #>(.__Draw-1)
 pha
 lda #<(.__Draw-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #3
 jmp BS_jsr
.
 ; 

.__Mario_BJr_Collision
 ; __Mario_BJr_Collision

.
 ; 

.L01134 ;  if player1y  <=  player0y then goto __Mario_Hit_01 bank1

	LDA player0y
	CMP player1y
     BCC .skipL01134
.condpart615
 sta temp7
 lda #>(.__Mario_Hit_01-1)
 pha
 lda #<(.__Mario_Hit_01-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
.skipL01134
.
 ; 

.L01135 ;  if _Farthest_Traveled_On_Level  =  11  ||  _Farthest_Traveled_On_Level  =  12 then player0y  =  player0y  -  3  :  _Bit1_Jumping_Flag{1}  =  1  :  _Momentum_Up_Down  =  2  :  _Bit2_Fire_Button_Pressed{2}  =  1  :  score  =  score  +  50  :  goto __Draw bank3

	LDA _Farthest_Traveled_On_Level
	CMP #11
     BNE .skipL01135
.condpart616
 jmp .condpart617
.skipL01135
	LDA _Farthest_Traveled_On_Level
	CMP #12
     BNE .skip167OR
.condpart617
	LDA player0y
	SEC
	SBC #3
	STA player0y
	LDA _Bit1_Jumping_Flag
	ORA #2
	STA _Bit1_Jumping_Flag
	LDA #2
	STA _Momentum_Up_Down
	LDA _Bit2_Fire_Button_Pressed
	ORA #4
	STA _Bit2_Fire_Button_Pressed
	SED
	CLC
	LDA score+2
	ADC #$50
	STA score+2
	LDA score+1
	ADC #$00
	STA score+1
	LDA score
	ADC #$00
	STA score
	CLD
 sta temp7
 lda #>(.__Draw-1)
 pha
 lda #<(.__Draw-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #3
 jmp BS_jsr
.skip167OR
.
 ; 

.L01136 ;  x  =  player1y  -  player0y

	LDA player1y
	SEC
	SBC player0y
	STA x
.
 ; 

.L01137 ;  if x  <  12 then goto __Mario_Hit_01 bank1

	LDA x
	CMP #12
     BCS .skipL01137
.condpart618
 sta temp7
 lda #>(.__Mario_Hit_01-1)
 pha
 lda #<(.__Mario_Hit_01-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
.skipL01137
.
 ; 

.L01138 ;  player0y  =  player0y  -  3  :  _Bit1_Jumping_Flag{1}  =  1  :  _Momentum_Up_Down  =  2  :  _Bit2_Fire_Button_Pressed{2}  =  1  :  _Momentum_Left_Right  =  6

	LDA player0y
	SEC
	SBC #3
	STA player0y
	LDA _Bit1_Jumping_Flag
	ORA #2
	STA _Bit1_Jumping_Flag
	LDA #2
	STA _Momentum_Up_Down
	LDA _Bit2_Fire_Button_Pressed
	ORA #4
	STA _Bit2_Fire_Button_Pressed
	LDA #6
	STA _Momentum_Left_Right
.
 ; 

.L01139 ;  if player1y  <  79 then player1y  =  79

	LDA player1y
	CMP #79
     BCS .skipL01139
.condpart619
	LDA #79
	STA player1y
.skipL01139
.
 ; 

.L01140 ;  if _Level_Data_Pointer  =  2 then _Enemy_Momentum  =  6  :  _Farthest_Traveled_On_Level  =  13  :  goto __Draw bank3

	LDA _Level_Data_Pointer
	CMP #2
     BNE .skipL01140
.condpart620
	LDA #6
	STA _Enemy_Momentum
	LDA #13
	STA _Farthest_Traveled_On_Level
 sta temp7
 lda #>(.__Draw-1)
 pha
 lda #<(.__Draw-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #3
 jmp BS_jsr
.skipL01140
.
 ; 

.L01141 ;  score  =  score  +  400

	SED
	CLC
	LDA score+1
	ADC #$04
	STA score+1
	LDA score
	ADC #$00
	STA score
	CLD
.
 ; 

.L01142 ;  goto __Bowser_Jr_Hit

 jmp .__Bowser_Jr_Hit

.
 ; 

.__Bowser_Jr_Defeated
 ; __Bowser_Jr_Defeated

.
 ; 

.L01143 ;  gosub __Pause_Boss

 jsr .__Pause_Boss

.
 ; 

.L01144 ;  player0y  =  79  :  player1y  =  79  :  _Bit1_Jumping_Flag{1}  =  0  :  _Momentum_Up_Down  =  0  :  _Bit0_Player_Facing_Direction{0}  =  0  :  _Momentum_Left_Right  =  0  :  player0x  =  player1x  -  16

	LDA #79
	STA player0y
	STA player1y
	LDA _Bit1_Jumping_Flag
	AND #253
	STA _Bit1_Jumping_Flag
	LDA #0
	STA _Momentum_Up_Down
	LDA _Bit0_Player_Facing_Direction
	AND #254
	STA _Bit0_Player_Facing_Direction
	LDA #0
	STA _Momentum_Left_Right
	LDA player1x
	SEC
	SBC #16
	STA player0x
.
 ; 

.L01145 ;  if player0x  <  24 then player0x  =  24

	LDA player0x
	CMP #24
     BCS .skipL01145
.condpart621
	LDA #24
	STA player0x
.skipL01145
.
 ; 

.L01146 ;  _Bit7_Mario_Invincibility{7}  =  0  :  _Bit7_Mario_On_Off{7}  =  0

	LDA _Bit7_Mario_Invincibility
	AND #127
	STA _Bit7_Mario_Invincibility
	LDA _Bit7_Mario_On_Off
	AND #127
	STA _Bit7_Mario_On_Off
.
 ; 

.L01147 ;  gosub __Set_Up_Mario bank1

 sta temp7
 lda #>(ret_point84-1)
 pha
 lda #<(ret_point84-1)
 pha
 lda #>(.__Set_Up_Mario-1)
 pha
 lda #<(.__Set_Up_Mario-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
ret_point84
.
 ; 

.L01148 ;  AUDV0  =  0  :  AUDV1  =  0

	LDA #0
	STA AUDV0
	STA AUDV1
.
 ; 

.L01149 ;  score  =  score  +  5000

	SED
	CLC
	LDA score+1
	ADC #$50
	STA score+1
	LDA score
	ADC #$00
	STA score
	CLD
.
 ; 

.L01150 ;  player1color:

	LDX #<playercolorL01150_1
	STX player1color
	LDA #>playercolorL01150_1
	STA player1color+1
.
 ; 

.L01151 ;  player1:

	LDX #<playerL01151_1
	STX player1pointerlo
	LDA #>playerL01151_1
	STA player1pointerhi
	LDA #17
	STA player1height
.
 ; 

.L01152 ;  AUDV0  =  12  :  AUDC0  =  7  :  AUDF0  =  31

	LDA #12
	STA AUDV0
	LDA #7
	STA AUDC0
	LDA #31
	STA AUDF0
.
 ; 

.L01153 ;  gosub __Pause_Boss

 jsr .__Pause_Boss

.
 ; 

.L01154 ;  gosub __Fanfare_Music bank7

 sta temp7
 lda #>(ret_point85-1)
 pha
 lda #<(ret_point85-1)
 pha
 lda #>(.__Fanfare_Music-1)
 pha
 lda #<(.__Fanfare_Music-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #7
 jmp BS_jsr
ret_point85
.
 ; 

.__BJr_Defeated_2
 ; __BJr_Defeated_2

.
 ; 

.L01155 ;  gosub __Play_FF_Music bank7

 sta temp7
 lda #>(ret_point86-1)
 pha
 lda #<(ret_point86-1)
 pha
 lda #>(.__Play_FF_Music-1)
 pha
 lda #<(.__Play_FF_Music-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #7
 jmp BS_jsr
ret_point86
.
 ; 

.L01156 ;  gosub __Render_Screen_Boss  :  gosub __Render_Screen_Boss

 jsr .__Render_Screen_Boss
 jsr .__Render_Screen_Boss

.
 ; 

.L01157 ;  if _Music_Duration  <>  255 then goto __BJr_Defeated_2

	LDA _Music_Duration
	CMP #255
     BEQ .skipL01157
.condpart622
 jmp .__BJr_Defeated_2

.skipL01157
.
 ; 

.L01158 ;  if _World  =  4 then goto __Final bank8

	LDA _World
	CMP #4
     BNE .skipL01158
.condpart623
 sta temp7
 lda #>(.__Final-1)
 pha
 lda #<(.__Final-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #8
 jmp BS_jsr
.skipL01158
.
 ; 

.L01159 ;  gosub __BJCColor  :  gosub __BJC

 jsr .__BJCColor
 jsr .__BJC

.
 ; 

.L01160 ;  gosub __Pause_Boss

 jsr .__Pause_Boss

.
 ; 

.L01161 ;  gosub __BJSC  :  gosub __BJS

 jsr .__BJSC
 jsr .__BJS

.
 ; 

.__BJr_Defeated_3
 ; __BJr_Defeated_3

.
 ; 

.L01162 ;  AUDV0  =  12  :  AUDC0  =  8  :  AUDF0  =  31  :  player1x  =  player1x  +  4

	LDA #12
	STA AUDV0
	LDA #8
	STA AUDC0
	LDA #31
	STA AUDF0
	LDA player1x
	CLC
	ADC #4
	STA player1x
.
 ; 

.L01163 ;  if player1x  >  137 then player1x  =  0  :  player1y  =  120  :  _Enemy_Type  =  _Goomba  :  goto __BJr_Defeated_4

	LDA #137
	CMP player1x
     BCS .skipL01163
.condpart624
	LDA #0
	STA player1x
	LDA #120
	STA player1y
	LDA #_Goomba
	STA _Enemy_Type
 jmp .__BJr_Defeated_4

.skipL01163
.
 ; 

.L01164 ;  if player1x  >  120 then pfhline 30 7 31 off  :  pfhline 30 8 31 off  :  pfhline 30 9 31 off  :  AUDC0  =  7

	LDA #120
	CMP player1x
     BCS .skipL01164
.condpart625
	LDX #1
	LDA #31
	STA temp3
	LDY #7
	LDA #30
 sta temp7
 lda #>(ret_point87-1)
 pha
 lda #<(ret_point87-1)
 pha
 lda #>(pfhline-1)
 pha
 lda #<(pfhline-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #8
 jmp BS_jsr
ret_point87
	LDX #1
	LDA #31
	STA temp3
	LDY #8
	LDA #30
 sta temp7
 lda #>(ret_point88-1)
 pha
 lda #<(ret_point88-1)
 pha
 lda #>(pfhline-1)
 pha
 lda #<(pfhline-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #8
 jmp BS_jsr
ret_point88
	LDX #1
	LDA #31
	STA temp3
	LDY #9
	LDA #30
 sta temp7
 lda #>(ret_point89-1)
 pha
 lda #<(ret_point89-1)
 pha
 lda #>(pfhline-1)
 pha
 lda #<(pfhline-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #8
 jmp BS_jsr
ret_point89
	LDA #7
	STA AUDC0
.skipL01164
.
 ; 

.L01165 ;  gosub __Slow_Boss

 jsr .__Slow_Boss

.
 ; 

.L01166 ;  goto __BJr_Defeated_3

 jmp .__BJr_Defeated_3

.
 ; 

.__BJr_Defeated_4
 ; __BJr_Defeated_4

.
 ; 

.L01167 ;  AUDV0  =  0  :  _Animation_Timer  =  _Animation_Timer  +  1  :  _Momentum_Left_Right  =  2

	LDA #0
	STA AUDV0
	INC _Animation_Timer
	LDA #2
	STA _Momentum_Left_Right
.
 ; 

.L01168 ;  if _Animation_Timer  >  6 then _Animation_Timer  =  0

	LDA #6
	CMP _Animation_Timer
     BCS .skipL01168
.condpart626
	LDA #0
	STA _Animation_Timer
.skipL01168
.
 ; 

.L01169 ;  gosub __Set_Up_Mario bank1

 sta temp7
 lda #>(ret_point90-1)
 pha
 lda #<(ret_point90-1)
 pha
 lda #>(.__Set_Up_Mario-1)
 pha
 lda #<(.__Set_Up_Mario-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
ret_point90
.
 ; 

.L01170 ;  player0x  =  player0x  +  2

	LDA player0x
	CLC
	ADC #2
	STA player0x
.
 ; 

.L01171 ;  gosub __Slow_Boss

 jsr .__Slow_Boss

.
 ; 

.L01172 ;  if player0x  >  138 then player0x  =  0  :  player0y  =  120  :  goto __elr5 bank3

	LDA #138
	CMP player0x
     BCS .skipL01172
.condpart627
	LDA #0
	STA player0x
	LDA #120
	STA player0y
 sta temp7
 lda #>(.__elr5-1)
 pha
 lda #<(.__elr5-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #3
 jmp BS_jsr
.skipL01172
.
 ; 

.L01173 ;  goto __BJr_Defeated_4

 jmp .__BJr_Defeated_4

.
 ; 

.
 ; 

.__Bos_Setup
 ; __Bos_Setup

.
 ; 

.L01174 ;  AUDV0  =  0  :  AUDV1  =  0

	LDA #0
	STA AUDV0
	STA AUDV1
.
 ; 

.L01175 ;  player0x  =  32  :  player0y  =  0

	LDA #32
	STA player0x
	LDA #0
	STA player0y
.
 ; 

.L01176 ;  _Momentum_Up_Down  =  4  :  u  =  10  :  pfscore1  =  0  :  _Bit0_Player_Facing_Direction{0}  =  0

	LDA #4
	STA _Momentum_Up_Down
	LDA #10
	STA u
	LDA #0
	STA pfscore1
	LDA _Bit0_Player_Facing_Direction
	AND #254
	STA _Bit0_Player_Facing_Direction
.
 ; 

.L01177 ;  gosub __Set_Up_Mario bank1

 sta temp7
 lda #>(ret_point91-1)
 pha
 lda #<(ret_point91-1)
 pha
 lda #>(.__Set_Up_Mario-1)
 pha
 lda #<(.__Set_Up_Mario-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
ret_point91
.
 ; 

.L01178 ;  y  =  1

	LDA #1
	STA y
.
 ; 

.__Mario_Fall
 ; __Mario_Fall

.
 ; 

.L01179 ;  u  =  u  +  1  :  AUDV0  =  8  :  AUDC0  =  4  :  AUDF0  =  u  :  player0y  =  player0y  +  y

	INC u
	LDA #8
	STA AUDV0
	LDA #4
	STA AUDC0
	LDA u
	STA AUDF0
	LDA player0y
	CLC
	ADC y
	STA player0y
.
 ; 

.L01180 ;  if y  <  7 then y  =  y  +  1

	LDA y
	CMP #7
     BCS .skipL01180
.condpart628
	INC y
.skipL01180
.
 ; 

.L01181 ;  if player0y  >  80 then player0y  =  79  :  _Momentum_Up_Down  =  0  :  _Momentum_Left_Right  =  0  :  gosub __Set_Up_Mario bank1  :  AUDC0  =  1  :  AUDF0  =  8

	LDA #80
	CMP player0y
     BCS .skipL01181
.condpart629
	LDA #79
	STA player0y
	LDA #0
	STA _Momentum_Up_Down
	STA _Momentum_Left_Right
 sta temp7
 lda #>(ret_point92-1)
 pha
 lda #<(ret_point92-1)
 pha
 lda #>(.__Set_Up_Mario-1)
 pha
 lda #<(.__Set_Up_Mario-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
ret_point92
	LDA #1
	STA AUDC0
	LDA #8
	STA AUDF0
.skipL01181
.
 ; 

.L01182 ;  gosub __Slow_Boss

 jsr .__Slow_Boss

.
 ; 

.L01183 ;  if player0y  =  79 then x  =  9  :  _Momentum_Up_Down  =  0  :  _Bit1_Jumping_Flag{1}  =  0  :  _Momentum_Left_Right  =  0  :  gosub __Set_Up_Mario bank1  :  goto __Boss_Fall

	LDA player0y
	CMP #79
     BNE .skipL01183
.condpart630
	LDA #9
	STA x
	LDA #0
	STA _Momentum_Up_Down
	LDA _Bit1_Jumping_Flag
	AND #253
	STA _Bit1_Jumping_Flag
	LDA #0
	STA _Momentum_Left_Right
 sta temp7
 lda #>(ret_point93-1)
 pha
 lda #<(ret_point93-1)
 pha
 lda #>(.__Set_Up_Mario-1)
 pha
 lda #<(.__Set_Up_Mario-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
ret_point93
 jmp .__Boss_Fall

.skipL01183
.
 ; 

.L01184 ;  goto __Mario_Fall

 jmp .__Mario_Fall

.
 ; 

.__Boss_Fall
 ; __Boss_Fall

.
 ; 

.L01185 ;  AUDV0  =  0

	LDA #0
	STA AUDV0
.
 ; 

.L01186 ;  for z  =  1 to 3

	LDA #1
	STA z
.L01186forz
.
 ; 

.L01187 ;  gosub __Pause_Boss

 jsr .__Pause_Boss

.
 ; 

.L01188 ;  next z

	LDA z
	CMP #3

	INC z
 if ((* - .L01186forz) < 127) && ((* - .L01186forz) > -128)
	bcc .L01186forz
 else
	bcs .13skipL01186forz
	jmp .L01186forz
.13skipL01186forz
 endif
.
 ; 

.L01189 ;  player1x  =  116  :  player1y  =  0

	LDA #116
	STA player1x
	LDA #0
	STA player1y
.
 ; 

.L01190 ;  u  =  10  :  x  =  1  :  g  =  0  :  _Bit6_Checkpoint_Flag{6}  =  1

	LDA #10
	STA u
	LDA #1
	STA x
	LDA #0
	STA g
	LDA _Bit6_Checkpoint_Flag
	ORA #64
	STA _Bit6_Checkpoint_Flag
.
 ; 

.L01191 ;  gosub __BJJColor  :  gosub __BJJ

 jsr .__BJJColor
 jsr .__BJJ

.
 ; 

.__Boss_Fall_2
 ; __Boss_Fall_2

.
 ; 

.L01192 ;  u  =  u  +  1  :  AUDV0  =  8  :  AUDC0  =  4  :  AUDF0  =  u  :  player1y  =  player1y  +  x

	INC u
	LDA #8
	STA AUDV0
	LDA #4
	STA AUDC0
	LDA u
	STA AUDF0
	LDA player1y
	CLC
	ADC x
	STA player1y
.
 ; 

.L01193 ;  if x  <  7 then x  =  x  +  1

	LDA x
	CMP #7
     BCS .skipL01193
.condpart631
	INC x
.skipL01193
.
 ; 

.L01194 ;  if player1y  >  80 then player1y  =  79  :  gosub __BJCColor  :  gosub __BJC  :  AUDC0  =  1  :  AUDF0  =  8  :  gosub __Pause_Boss

	LDA #80
	CMP player1y
     BCS .skipL01194
.condpart632
	LDA #79
	STA player1y
 jsr .__BJCColor
 jsr .__BJC
	LDA #1
	STA AUDC0
	LDA #8
	STA AUDF0
 jsr .__Pause_Boss

.skipL01194
.
 ; 

.L01195 ;  gosub __Slow_Boss

 jsr .__Slow_Boss

.
 ; 

.L01196 ;  if player1y  =  79 then gosub __BJC1  :  gosub __BJ1  :  x  =  0  :  goto __Boss_Fall_Fill_Lifebar

	LDA player1y
	CMP #79
     BNE .skipL01196
.condpart633
 jsr .__BJC1
 jsr .__BJ1
	LDA #0
	STA x
 jmp .__Boss_Fall_Fill_Lifebar

.skipL01196
.
 ; 

.L01197 ;  goto __Boss_Fall_2

 jmp .__Boss_Fall_2

.
 ; 

.__Boss_Fall_Fill_Lifebar
 ; __Boss_Fall_Fill_Lifebar

.
 ; 

.L01198 ;  x  =  x  +  1

	INC x
.
 ; 

.L01199 ;  if x  =  1 then pfscore1  =  1 else pfscore1  =  pfscore1  *  2 | 1

	LDA x
	CMP #1
     BNE .skipL01199
.condpart634
	LDA #1
	STA pfscore1
 jmp .skipelse84
.skipL01199
; complex statement detected
	LDA pfscore1
	asl
	ORA #1
	STA pfscore1
.skipelse84
.
 ; 

.L01200 ;  AUDV0  =  8  :  AUDC0  =  7  :  AUDF0  =  6

	LDA #8
	STA AUDV0
	LDA #7
	STA AUDC0
	LDA #6
	STA AUDF0
.
 ; 

.L01201 ;  gosub __Pause_Boss

 jsr .__Pause_Boss

.
 ; 

.L01202 ;  if x  <  3 then goto __Boss_Fall_Fill_Lifebar

	LDA x
	CMP #3
     BCS .skipL01202
.condpart635
 jmp .__Boss_Fall_Fill_Lifebar

.skipL01202
.
 ; 

.__Boss_Fall_3
 ; __Boss_Fall_3

.
 ; 

.L01203 ;  AUDV0  =  0

	LDA #0
	STA AUDV0
.
 ; 

.L01204 ;  for z  =  1 to 3

	LDA #1
	STA z
.L01204forz
.
 ; 

.L01205 ;  gosub __Pause_Boss

 jsr .__Pause_Boss

.
 ; 

.L01206 ;  next z

	LDA z
	CMP #3

	INC z
 if ((* - .L01204forz) < 127) && ((* - .L01204forz) > -128)
	bcc .L01204forz
 else
	bcs .14skipL01204forz
	jmp .L01204forz
.14skipL01204forz
 endif
.
 ; 

.L01207 ;  for z  =  1 to 3

	LDA #1
	STA z
.L01207forz
.
 ; 

.L01208 ;  u  =  $0e  :  x  =  17

	LDA #$0e
	STA u
	LDA #17
	STA x
.
 ; 

.__Boss_Fall_4
 ; __Boss_Fall_4

.
 ; 

.L01209 ;  x  =  x  +  1

	INC x
.
 ; 

.L01210 ;  COLUBK  =  u

	LDA u
	STA COLUBK
.
 ; 

.L01211 ;  AUDV0  =  8  :  AUDC0  =  1  :  AUDF0  =  x

	LDA #8
	STA AUDV0
	LDA #1
	STA AUDC0
	LDA x
	STA AUDF0
.
 ; 

.L01212 ;  gosub __Render_Screen_Boss

 jsr .__Render_Screen_Boss

.
 ; 

.L01213 ;  if u  >  0 then u  =  u  -  1  :  goto __Boss_Fall_4

	LDA #0
	CMP u
     BCS .skipL01213
.condpart636
	DEC u
 jmp .__Boss_Fall_4

.skipL01213
.
 ; 

.L01214 ;  next z

	LDA z
	CMP #3

	INC z
 if ((* - .L01207forz) < 127) && ((* - .L01207forz) > -128)
	bcc .L01207forz
 else
	bcs .15skipL01207forz
	jmp .L01207forz
.15skipL01207forz
 endif
.
 ; 

.L01215 ;  _Enemy_Type  =  _Bowser_Jr  :  _Level_Data_Pointer  =  0  :  _Level_Timer  =  3  :  _Bit3_Enemy_Direction{3}  =  0  :  _Object_Scroll_In_Data  =  0  :  _Farthest_Traveled_On_Level  =  0

	LDA #_Bowser_Jr
	STA _Enemy_Type
	LDA #0
	STA _Level_Data_Pointer
	LDA #3
	STA _Level_Timer
	LDA _Bit3_Enemy_Direction
	AND #247
	STA _Bit3_Enemy_Direction
	LDA #0
	STA _Object_Scroll_In_Data
	STA _Farthest_Traveled_On_Level
.
 ; 

.L01216 ;  gosub __UW_Music bank7

 sta temp7
 lda #>(ret_point94-1)
 pha
 lda #<(ret_point94-1)
 pha
 lda #>(.__UW_Music-1)
 pha
 lda #<(.__UW_Music-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #7
 jmp BS_jsr
ret_point94
.
 ; 

.L01217 ;  goto __Main_Loop bank1

 sta temp7
 lda #>(.__Main_Loop-1)
 pha
 lda #<(.__Main_Loop-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
.
 ; 

.__Pause_Boss
 ; __Pause_Boss

.
 ; 

.L01218 ;  for y  =  1 to 30

	LDA #1
	STA y
.L01218fory
.
 ; 

.L01219 ;  gosub __Render_Screen_Boss

 jsr .__Render_Screen_Boss

.
 ; 

.L01220 ;  if y  >  3 then AUDV0  =  0

	LDA #3
	CMP y
     BCS .skipL01220
.condpart637
	LDA #0
	STA AUDV0
.skipL01220
.
 ; 

.L01221 ;  next y

	LDA y
	CMP #30

	INC y
 if ((* - .L01218fory) < 127) && ((* - .L01218fory) > -128)
	bcc .L01218fory
 else
	bcs .16skipL01218fory
	jmp .L01218fory
.16skipL01218fory
 endif
.
 ; 

.L01222 ;  return thisbank

	RTS
.
 ; 

.__Slow_Boss
 ; __Slow_Boss

.
 ; 

.L01223 ;  for y  =  1 to 3

	LDA #1
	STA y
.L01223fory
.
 ; 

.L01224 ;  gosub __Render_Screen_Boss

 jsr .__Render_Screen_Boss

.
 ; 

.L01225 ;  next y

	LDA y
	CMP #3

	INC y
 if ((* - .L01223fory) < 127) && ((* - .L01223fory) > -128)
	bcc .L01223fory
 else
	bcs .17skipL01223fory
	jmp .L01223fory
.17skipL01223fory
 endif
.
 ; 

.L01226 ;  return thisbank

	RTS
.
 ; 

.__Render_Screen_Boss
 ; __Render_Screen_Boss

.
 ; 

.L01227 ;  COLUPF  =  $04

	LDA #$04
	STA COLUPF
.
 ; 

.L01228 ;  NUSIZ1  =  $15

	LDA #$15
	STA NUSIZ1
.
 ; 

.L01229 ;  if _Bit0_Player_Facing_Direction{0} then REFP0  =  8 else REFP0  =  0

	LDA _Bit0_Player_Facing_Direction
	LSR
	BCC .skipL01229
.condpart638
	LDA #8
	STA REFP0
 jmp .skipelse85
.skipL01229
	LDA #0
	STA REFP0
.skipelse85
.
 ; 

.L01230 ;  if _Bit3_Enemy_Direction{3} then REFP1  =  8 else REFP1  =  0

	LDA _Bit3_Enemy_Direction
	AND #8
	BEQ .skipL01230
.condpart639
	LDA #8
	STA REFP1
 jmp .skipelse86
.skipL01230
	LDA #0
	STA REFP1
.skipelse86
.
 ; 

.L01231 ;  drawscreen

 sta temp7
 lda #>(ret_point95-1)
 pha
 lda #<(ret_point95-1)
 pha
 lda #>(drawscreen-1)
 pha
 lda #<(drawscreen-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #8
 jmp BS_jsr
ret_point95
.
 ; 

.L01232 ;  return thisbank

	RTS
.
 ; 

.
 ; 

.__1World
 ; __1World

.L01233 ;  player0:

	LDX #<playerL01233_0
	STX player0pointerlo
	LDA #>playerL01233_0
	STA player0pointerhi
	LDA #7
	STA player0height
.L01234 ;  return thisbank

	RTS
.
 ; 

.__2World
 ; __2World

.L01235 ;  player0:

	LDX #<playerL01235_0
	STX player0pointerlo
	LDA #>playerL01235_0
	STA player0pointerhi
	LDA #7
	STA player0height
.L01236 ;  return thisbank

	RTS
.
 ; 

.__3World
 ; __3World

.L01237 ;  player0:

	LDX #<playerL01237_0
	STX player0pointerlo
	LDA #>playerL01237_0
	STA player0pointerhi
	LDA #7
	STA player0height
.L01238 ;  return thisbank

	RTS
.
 ; 

.__4World
 ; __4World

.L01239 ;  player0:

	LDX #<playerL01239_0
	STX player0pointerlo
	LDA #>playerL01239_0
	STA player0pointerhi
	LDA #7
	STA player0height
.L01240 ;  return thisbank

	RTS
.
 ; 

.__1Level
 ; __1Level

.L01241 ;  player1:

	LDX #<playerL01241_1
	STX player1pointerlo
	LDA #>playerL01241_1
	STA player1pointerhi
	LDA #7
	STA player1height
.L01242 ;  return thisbank

	RTS
.
 ; 

.__2Level
 ; __2Level

.L01243 ;  player1:

	LDX #<playerL01243_1
	STX player1pointerlo
	LDA #>playerL01243_1
	STA player1pointerhi
	LDA #7
	STA player1height
.L01244 ;  return thisbank

	RTS
.
 ; 

.__3Level
 ; __3Level

.L01245 ;  player1:

	LDX #<playerL01245_1
	STX player1pointerlo
	LDA #>playerL01245_1
	STA player1pointerhi
	LDA #7
	STA player1height
.L01246 ;  return thisbank

	RTS
.
 ; 

.__4Level
 ; __4Level

.L01247 ;  player1:

	LDX #<playerL01247_1
	STX player1pointerlo
	LDA #>playerL01247_1
	STA player1pointerhi
	LDA #7
	STA player1height
.L01248 ;  return thisbank

	RTS
.
 ; 

.__1Mario
 ; __1Mario

.L01249 ;  player1:

	LDX #<playerL01249_1
	STX player1pointerlo
	LDA #>playerL01249_1
	STA player1pointerhi
	LDA #7
	STA player1height
.L01250 ;  return thisbank

	RTS
.
 ; 

.__2Mario
 ; __2Mario

.L01251 ;  player1:

	LDX #<playerL01251_1
	STX player1pointerlo
	LDA #>playerL01251_1
	STA player1pointerhi
	LDA #7
	STA player1height
.L01252 ;  return thisbank

	RTS
.
 ; 

.__3Mario
 ; __3Mario

.L01253 ;  player1:

	LDX #<playerL01253_1
	STX player1pointerlo
	LDA #>playerL01253_1
	STA player1pointerhi
	LDA #7
	STA player1height
.L01254 ;  return thisbank

	RTS
.
 ; 

.__4Mario
 ; __4Mario

.L01255 ;  player1:

	LDX #<playerL01255_1
	STX player1pointerlo
	LDA #>playerL01255_1
	STA player1pointerhi
	LDA #7
	STA player1height
.L01256 ;  return thisbank

	RTS
.
 ; 

.__5Mario
 ; __5Mario

.L01257 ;  player1:

	LDX #<playerL01257_1
	STX player1pointerlo
	LDA #>playerL01257_1
	STA player1pointerhi
	LDA #7
	STA player1height
.L01258 ;  return thisbank

	RTS
.
 ; 

.__6Mario
 ; __6Mario

.L01259 ;  player1:

	LDX #<playerL01259_1
	STX player1pointerlo
	LDA #>playerL01259_1
	STA player1pointerhi
	LDA #7
	STA player1height
.L01260 ;  return thisbank

	RTS
.
 ; 

.__7Mario
 ; __7Mario

.L01261 ;  player1:

	LDX #<playerL01261_1
	STX player1pointerlo
	LDA #>playerL01261_1
	STA player1pointerhi
	LDA #7
	STA player1height
.L01262 ;  return thisbank

	RTS
.
 ; 

.__8Mario
 ; __8Mario

.L01263 ;  player1:

	LDX #<playerL01263_1
	STX player1pointerlo
	LDA #>playerL01263_1
	STA player1pointerhi
	LDA #7
	STA player1height
.L01264 ;  return thisbank

	RTS
.
 ; 

.__9Mario
 ; __9Mario

.L01265 ;  player1:

	LDX #<playerL01265_1
	STX player1pointerlo
	LDA #>playerL01265_1
	STA player1pointerhi
	LDA #7
	STA player1height
.L01266 ;  return thisbank

	RTS
.
 ; 

.__Mario_Icon
 ; __Mario_Icon

.L01267 ;  player0color:

	LDX #<playercolorL01267_0
	STX player0color
	LDA #>playercolorL01267_0
	STA player0color+1
.
 ; 

.L01268 ;  player0:

	LDX #<playerL01268_0
	STX player0pointerlo
	LDA #>playerL01268_0
	STA player0pointerhi
	LDA #12
	STA player0height
.L01269 ;  return thisbank

	RTS
.
 ; 

.
 ; 

.__GA
 ; __GA

.L01270 ;  player0:

	LDX #<playerL01270_0
	STX player0pointerlo
	LDA #>playerL01270_0
	STA player0pointerhi
	LDA #7
	STA player0height
.L01271 ;  return thisbank

	RTS
.
 ; 

.__ME
 ; __ME

.L01272 ;  player1:

	LDX #<playerL01272_1
	STX player1pointerlo
	LDA #>playerL01272_1
	STA player1pointerhi
	LDA #7
	STA player1height
.L01273 ;  return thisbank

	RTS
.
 ; 

.__OV
 ; __OV

.L01274 ;  player0:

	LDX #<playerL01274_0
	STX player0pointerlo
	LDA #>playerL01274_0
	STA player0pointerhi
	LDA #7
	STA player0height
.L01275 ;  return thisbank

	RTS
.
 ; 

.__ER
 ; __ER

.L01276 ;  player1:

	LDX #<playerL01276_1
	STX player1pointerlo
	LDA #>playerL01276_1
	STA player1pointerhi
	LDA #7
	STA player1height
.L01277 ;  return thisbank

	RTS
.
 ; 

.__BJC1
 ; __BJC1

.L01278 ;  player1color:

	LDX #<playercolorL01278_1
	STX player1color
	LDA #>playercolorL01278_1
	STA player1color+1
.L01279 ;  return thisbank

	RTS
.
 ; 

.__BJDColor
 ; __BJDColor

.L01280 ;  player1color:

	LDX #<playercolorL01280_1
	STX player1color
	LDA #>playercolorL01280_1
	STA player1color+1
.L01281 ;  return thisbank

	RTS
.
 ; 

.__BJ1
 ; __BJ1

.L01282 ;  player1:

	LDX #<playerL01282_1
	STX player1pointerlo
	LDA #>playerL01282_1
	STA player1pointerhi
	LDA #23
	STA player1height
.L01283 ;  return thisbank

	RTS
.
 ; 

.__BJ2
 ; __BJ2

.L01284 ;  player1:

	LDX #<playerL01284_1
	STX player1pointerlo
	LDA #>playerL01284_1
	STA player1pointerhi
	LDA #23
	STA player1height
.L01285 ;  return thisbank

	RTS
.
 ; 

.__BJCColor
 ; __BJCColor

.L01286 ;  player1color:

	LDX #<playercolorL01286_1
	STX player1color
	LDA #>playercolorL01286_1
	STA player1color+1
.L01287 ;  return thisbank

	RTS
.
 ; 

.__BJC
 ; __BJC

.L01288 ;  player1:

	LDX #<playerL01288_1
	STX player1pointerlo
	LDA #>playerL01288_1
	STA player1pointerhi
	LDA #19
	STA player1height
.L01289 ;  return thisbank

	RTS
.
 ; 

.__BJJColor
 ; __BJJColor

.L01290 ;  player1color:

	LDX #<playercolorL01290_1
	STX player1color
	LDA #>playercolorL01290_1
	STA player1color+1
.L01291 ;  return thisbank

	RTS
.
 ; 

.__BJJ
 ; __BJJ

.L01292 ;  player1:

	LDX #<playerL01292_1
	STX player1pointerlo
	LDA #>playerL01292_1
	STA player1pointerhi
	LDA #24
	STA player1height
.L01293 ;  return thisbank

	RTS
.
 ; 

.__BJDC
 ; __BJDC

.L01294 ;  player1color:

	LDX #<playercolorL01294_1
	STX player1color
	LDA #>playercolorL01294_1
	STA player1color+1
.L01295 ;  return thisbank

	RTS
.
 ; 

.__BJD
 ; __BJD

.L01296 ;  player1:

	LDX #<playerL01296_1
	STX player1pointerlo
	LDA #>playerL01296_1
	STA player1pointerhi
	LDA #20
	STA player1height
.L01297 ;  return thisbank

	RTS
.
 ; 

.__BJSC
 ; __BJSC

.L01298 ;  player1color:

	LDX #<playercolorL01298_1
	STX player1color
	LDA #>playercolorL01298_1
	STA player1color+1
.L01299 ;  return thisbank

	RTS
.
 ; 

.__BJS
 ; __BJS

.L01300 ;  player1:

	LDX #<playerL01300_1
	STX player1pointerlo
	LDA #>playerL01300_1
	STA player1pointerhi
	LDA #7
	STA player1height
.L01301 ;  return thisbank

	RTS
.
 ; 

.__Play_Game_Over_Music
 ; __Play_Game_Over_Music

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01302 ;  _Music_Duration  =  _Music_Duration  -  1

	DEC _Music_Duration
.
 ; 

.L01303 ;  if _Music_Duration  >  0 then goto __Got_Gm_Ovr_Music

	LDA #0
	CMP _Music_Duration
     BCS .skipL01303
.condpart640
 jmp .__Got_Gm_Ovr_Music

.skipL01303
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01304 ;  temp4  =  sread ( _GameOverMusicData ) 

	ldx #_GameOverMusicData
	lda (0,x)
	inc 0,x
	bne *+4
	inc 1,x
	STA temp4
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01305 ;  if temp4  =  255 then _Music_Duration  =  255  :  goto __Got_Gm_Ovr_Music

	LDA temp4
	CMP #255
     BNE .skipL01305
.condpart641
	LDA #255
	STA _Music_Duration
 jmp .__Got_Gm_Ovr_Music

.skipL01305
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01306 ;  temp5  =  sread ( _GameOverMusicData ) 

	ldx #_GameOverMusicData
	lda (0,x)
	inc 0,x
	bne *+4
	inc 1,x
	STA temp5
.L01307 ;  temp6  =  sread ( _GameOverMusicData ) 

	ldx #_GameOverMusicData
	lda (0,x)
	inc 0,x
	bne *+4
	inc 1,x
	STA temp6
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01308 ;  AUDV0  =  temp4

	LDA temp4
	STA AUDV0
.L01309 ;  AUDC0  =  temp5

	LDA temp5
	STA AUDC0
.L01310 ;  AUDF0  =  temp6

	LDA temp6
	STA AUDF0
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01311 ;  temp4  =  sread ( _GameOverMusicData ) 

	ldx #_GameOverMusicData
	lda (0,x)
	inc 0,x
	bne *+4
	inc 1,x
	STA temp4
.L01312 ;  temp5  =  sread ( _GameOverMusicData ) 

	ldx #_GameOverMusicData
	lda (0,x)
	inc 0,x
	bne *+4
	inc 1,x
	STA temp5
.L01313 ;  temp6  =  sread ( _GameOverMusicData ) 

	ldx #_GameOverMusicData
	lda (0,x)
	inc 0,x
	bne *+4
	inc 1,x
	STA temp6
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01314 ;  AUDV1  =  temp4

	LDA temp4
	STA AUDV1
.L01315 ;  AUDC1  =  temp5

	LDA temp5
	STA AUDC1
.L01316 ;  AUDF1  =  temp6

	LDA temp6
	STA AUDF1
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01317 ;  _Music_Duration  =  sread ( _GameOverMusicData ) 

	ldx #_GameOverMusicData
	lda (0,x)
	inc 0,x
	bne *+4
	inc 1,x
	STA _Music_Duration
.
 ; 

.__Got_Gm_Ovr_Music
 ; __Got_Gm_Ovr_Music

.
 ; 

.L01318 ;  return thisbank

	RTS
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Game_Over_Music
 ; __Game_Over_Music

.L01319 ;  sdata _GameOverMusicData = q

	lda #<_GameOverMusicData_begin
	sta q
	lda #>_GameOverMusicData_begin
	sta q+1
	JMP .skipL01319
_GameOverMusicData_begin
	.byte  8,4,14

	.byte  4,4,23

	.byte  10

	.byte  4,4,14

	.byte  2,4,23

	.byte  10

	.byte  0,0,0

	.byte  0,0,0

	.byte  10

	.byte  8,4,19

	.byte  4,4,29

	.byte  10

	.byte  4,4,19

	.byte  2,4,29

	.byte  10

	.byte  0,0,0

	.byte  0,0,0

	.byte  10

	.byte  8,4,23

	.byte  4,12,26

	.byte  20

	.byte  8,4,17

	.byte  4,4,21

	.byte  13

	.byte  8,4,15

	.byte  4,4,21

	.byte  13

	.byte  8,4,17

	.byte  4,4,21

	.byte  14

	.byte  8,4,18

	.byte  4,4,21

	.byte  20

	.byte  8,4,16

	.byte  4,4,21

	.byte  20

	.byte  8,4,18

	.byte  4,4,21

	.byte  20

	.byte  8,4,19

	.byte  4,4,23

	.byte  10

	.byte  8,4,19

	.byte  4,4,26

	.byte  10

	.byte  8,4,19

	.byte  4,4,23

	.byte  40

	.byte  0,0,0

	.byte  0,0,0

	.byte  3

	.byte  255

.skipL01319
.L01320 ;  return thisbank

	RTS
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01321 ;  bank 5

 if ECHO4
 echo "    ",[(start_bank4 - *)]d , "bytes of ROM space left in bank 4")
 endif
ECHO4 = 1
 ORG $4FF4-bscode_length
 RORG $7FF4-bscode_length
start_bank4 ldx #$ff
 ifconst FASTFETCH ; using DPC+
 stx FASTFETCH
 endif 
 txs
 if bankswitch == 64
   lda #(((>(start-1)) & $0F) | $F0)
 else
   lda #>(start-1)
 endif
 pha
 lda #<(start-1)
 pha
 pha
 txa
 pha
 tsx
 if bankswitch != 64
   lda 4,x ; get high byte of return address
   rol
   rol
   rol
   rol
   and #bs_mask ;1 3 or 7 for F8/F6/F4
   tax
   inx
 else
   lda 4,x ; get high byte of return address
   tay
   ora #$10 ; change our bank nibble into a valid rom mirror
   sta 4,x
   tya
   lsr 
   lsr 
   lsr 
   lsr 
   tax
   inx
 endif
 lda bankswitch_hotspot-1,x
 pla
 tax
 pla
 rts
 if ((* & $1FFF) > ((bankswitch_hotspot & $1FFF) - 1))
   echo "WARNING: size parameter in banksw.asm too small - the program probably will not work."
   echo "Change to",[(*-begin_bscode+1)&$FF]d,"and try again."
 endif
 ORG $4FFC
 RORG $7FFC
 .word (start_bank4 & $ffff)
 .word (start_bank4 & $ffff)
 ORG $5000
 RORG $9000
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Level_Data_Bank1
 ; __Level_Data_Bank1

.L01322 ;  on z goto __W11A __W11B __W12A __W12B __W13A __W13B __W14 __W14 __W21A __W21B __W22A __W22B __W23A __W23B __W24 __W24

	LDX z
	LDA .L01322jumptablehi,x
	PHA
	LDA .L01322jumptablelo,x
	PHA
	RTS
.L01322jumptablehi
	.byte >(.__W11A-1)
	.byte >(.__W11B-1)
	.byte >(.__W12A-1)
	.byte >(.__W12B-1)
	.byte >(.__W13A-1)
	.byte >(.__W13B-1)
	.byte >(.__W14-1)
	.byte >(.__W14-1)
	.byte >(.__W21A-1)
	.byte >(.__W21B-1)
	.byte >(.__W22A-1)
	.byte >(.__W22B-1)
	.byte >(.__W23A-1)
	.byte >(.__W23B-1)
	.byte >(.__W24-1)
	.byte >(.__W24-1)
.L01322jumptablelo
	.byte <(.__W11A-1)
	.byte <(.__W11B-1)
	.byte <(.__W12A-1)
	.byte <(.__W12B-1)
	.byte <(.__W13A-1)
	.byte <(.__W13B-1)
	.byte <(.__W14-1)
	.byte <(.__W14-1)
	.byte <(.__W21A-1)
	.byte <(.__W21B-1)
	.byte <(.__W22A-1)
	.byte <(.__W22B-1)
	.byte <(.__W23A-1)
	.byte <(.__W23B-1)
	.byte <(.__W24-1)
	.byte <(.__W24-1)
.
 ; 

.__W11A
 ; __W11A

.L01323 ;  y  =  _Data_Level1A[x] : x  =  x  +  1  :  u  =  _Data_Level1A[x] : return otherbank

	LDX x
	LDA _Data_Level1A,x
	STA y
	INC x
	LDX x
	LDA _Data_Level1A,x
	STA u
	JMP BS_return
.
 ; 

.__W11B
 ; __W11B

.L01324 ;  y  =  _Data_Level1B[x] : x  =  x  +  1  :  u  =  _Data_Level1B[x] : return otherbank

	LDX x
	LDA _Data_Level1B,x
	STA y
	INC x
	LDX x
	LDA _Data_Level1B,x
	STA u
	JMP BS_return
.
 ; 

.__W12A
 ; __W12A

.L01325 ;  y  =  _Data_Level2A[x} : x  =  x  +  1  :  u  =  _Data_Level2A[x] : return otherbank

	LDX x
	LDA _Data_Level2A,x
	STA y
	INC x
	LDX x
	LDA _Data_Level2A,x
	STA u
	JMP BS_return
.
 ; 

.__W12B
 ; __W12B

.L01326 ;  y  =  _Data_Level2B[x] : x  =  x  +  1  :  u  =  _Data_Level2B[x] : return otherbank

	LDX x
	LDA _Data_Level2B,x
	STA y
	INC x
	LDX x
	LDA _Data_Level2B,x
	STA u
	JMP BS_return
.
 ; 

.__W13A
 ; __W13A

.L01327 ;  y  =  _Data_Level3A[x] : x  =  x  +  1  :  u  =  _Data_Level3A[x] : return otherbank

	LDX x
	LDA _Data_Level3A,x
	STA y
	INC x
	LDX x
	LDA _Data_Level3A,x
	STA u
	JMP BS_return
.
 ; 

.__W13B
 ; __W13B

.L01328 ;  y  =  _Data_Level3B[x} : x  =  x  +  1  :  u  =  _Data_Level3B[x] : return otherbank

	LDX x
	LDA _Data_Level3B,x
	STA y
	INC x
	LDX x
	LDA _Data_Level3B,x
	STA u
	JMP BS_return
.
 ; 

.__W14
 ; __W14

.L01329 ;  y  =  _Data_Level4[x] : x  =  x  +  1  :  u  =  _Data_Level4[x] : return otherbank

	LDX x
	LDA _Data_Level4,x
	STA y
	INC x
	LDX x
	LDA _Data_Level4,x
	STA u
	JMP BS_return
.
 ; 

.__W21A
 ; __W21A

.L01330 ;  y  =  _Data_Level5A[x} : x  =  x  +  1  :  u  =  _Data_Level5A[x] : return otherbank

	LDX x
	LDA _Data_Level5A,x
	STA y
	INC x
	LDX x
	LDA _Data_Level5A,x
	STA u
	JMP BS_return
.
 ; 

.__W21B
 ; __W21B

.L01331 ;  y  =  _Data_Level5B[x} : x  =  x  +  1  :  u  =  _Data_Level5B[x] : return otherbank

	LDX x
	LDA _Data_Level5B,x
	STA y
	INC x
	LDX x
	LDA _Data_Level5B,x
	STA u
	JMP BS_return
.
 ; 

.__W22A
 ; __W22A

.L01332 ;  y  =  _Data_Level6A[x} : x  =  x  +  1  :  u  =  _Data_Level6A[x] : return otherbank

	LDX x
	LDA _Data_Level6A,x
	STA y
	INC x
	LDX x
	LDA _Data_Level6A,x
	STA u
	JMP BS_return
.
 ; 

.__W22B
 ; __W22B

.L01333 ;  y  =  _Data_Level6B[x} : x  =  x  +  1  :  u  =  _Data_Level6B[x] : return otherbank

	LDX x
	LDA _Data_Level6B,x
	STA y
	INC x
	LDX x
	LDA _Data_Level6B,x
	STA u
	JMP BS_return
.
 ; 

.__W23A
 ; __W23A

.L01334 ;  y  =  _Data_Level7A[x} : x  =  x  +  1  :  u  =  _Data_Level7A[x] : return otherbank

	LDX x
	LDA _Data_Level7A,x
	STA y
	INC x
	LDX x
	LDA _Data_Level7A,x
	STA u
	JMP BS_return
.
 ; 

.__W23B
 ; __W23B

.L01335 ;  y  =  _Data_Level7B[x} : x  =  x  +  1  :  u  =  _Data_Level7B[x] : return otherbank

	LDX x
	LDA _Data_Level7B,x
	STA y
	INC x
	LDX x
	LDA _Data_Level7B,x
	STA u
	JMP BS_return
.
 ; 

.__W24
 ; __W24

.L01336 ;  y  =  _Data_Level8[x] : x  =  x  +  1  :  u  =  _Data_Level8[x] : return otherbank

	LDX x
	LDA _Data_Level8,x
	STA y
	INC x
	LDX x
	LDA _Data_Level8,x
	STA u
	JMP BS_return
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01337 ;  data _Data_Level1A

_Data_Level1A
	.byte   12,12,0,4,0,4,0,4,0,4,0,4,0,4,0,4,0,4,0,4,0,4,0,4,0,4,0,4,0,4

	.byte   0,4,64,4,36,4,36,4,36,4,36,4,36,4,66,4,129,4,129,4,129,4,129

	.byte   4,129,4,64,4,0,4,0,12,0,12

	.byte   0,12,0,12,0,12,0,4,0,7,0,7,0,7,0,4,0,4,0,12,16,4,16,4,16,4,16

	.byte   4,16,4,16,4,0,12,0,4,0,7,0,7,0,7,0,4,0,4,0,12,0,12,0,12,0,12

	.byte   0,4,0,4,0,0,0,0,0,0

	.byte   0,0,0,0,0,0,0,0,0,0,0,4,0,4,0,4,0,4,32,12,32,12,32,12,32,12,36

	.byte   4,36,4,68,4,4,4,4,4,0,28,0,28,4,4,36,4,36,4,36,4,36,4,32,4,32

	.byte   4,32,4,0,188,0,188,0,188,0,4

	.byte   0,4,128,4,128,4,128,4,128,4,32,4,32,4,32,4,32,4,32,4,32,4,8,24

	.byte   8,24,8,24,8,24,8,24,8,24,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,4,0,7,0

	.byte   7,0,7,0,4,0,4,0,4,0,4

.skipL01337
.
 ; 

.
 ; 

.L01338 ;  data _Data_Level1B

_Data_Level1B
	.byte   0,4,0,7,0,7,0,7,0,4,0,188,0,188,0,188,64,4,0,188,0,188,0,188,0

	.byte   188,66,4,0,188,0,188,0,188,0,188,64,4,0,188,0,188,0,188,0,188

	.byte   0,188,0,188,32,4,32,4,32,4,32,4,0,12,0,12,0,12

	.byte   0,12,0,4,0,6,0,6,0,7,0,7,128,7,128,7,0,0,0,0,0,0,0,0,0,0,0,0,0

	.byte   0,0,0,128,7,128,7,0,7,0,7,0,6,0,6,0,4,0,4,0,28,16,4,16,4,16,4

	.byte   16,4,16,4,0,188,0,188

	.byte   0,188,0,188,0,188,0,188,0,188,0,188,33,4,33,4,33,4,33,4,33,4,33

	.byte   4,33,4,33,4,33,4,33,4,0,188,0,188,0,12,0,12,0,12,0,12,0,4,0,7,0

	.byte   7,0,7,0,4,0,4,0,188,0,188,64,4,32,4

	.byte   32,4,32,4,32,4,0,4,0,12,0,12,0,12,0,12,0,4,0,4,0,6,0,6,0,7,0,7

	.byte   128,7,128,7,0,4,0,4,0,4,0,4,0,4,0,4,0,4,0,4,0,4,0,4,0,4,0,4,0

	.byte   172,0,4,0,4,0,4

.skipL01338
.
 ; 

.
 ; 

.L01339 ;  data _Data_Level2A

_Data_Level2A
	.byte   255,7,0,4,0,4,0,4,0,4,0,4,0,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1

	.byte   4,1,4,65,4,65,4,65,4,65,4,65,4,65,4,1,188,1,188,1,188,1,188,1

	.byte   188,1,188,1,188,1,188,1,188

	.byte   1,12,1,12,1,4,1,4,1,7,1,7,1,4,1,4,129,7,129,7,1,4,1,4,33,4,33,4

	.byte   1,12,1,4,129,7,129,7,1,4,1,4,1,7,1,7,1,4,1,4,1,4,1,28,1,28,1,28

	.byte   1,28,1,28,1,28,1,28

	.byte   49,4,49,4,33,4,33,4,33,4,33,4,49,4,49,4,1,28,1,28,1,28,1,28,1

	.byte   28,63,4,63,4,32,4,32,4,129,4,129,4,1,188,1,188,1,188,1,188,1

	.byte   188,1,188,129,12,129,12,129,12,129,12,129,12,129,12,17,12

	.byte   17,12,17,12,17,12,17,12,17,12,1,6,1,6,1,6,1,0,1,0,1,0,1,0,1,7,1

	.byte   7,1,255,1,0,1,0,1,0,1,0,129,7,129,7,129,7,1,0,1,0,1,0,1,0,1,7,1

	.byte   7,1,7,1,0,1,0,255,7

.skipL01339
.
 ; 

.
 ; 

.L01340 ;  data _Data_Level2B

_Data_Level2B
	.byte   255,7,1,0,1,7,1,7,1,7,1,0,1,0,1,0,1,0,129,7,129,7,1,7,1,7,1,6,1

	.byte   6,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,0

	.byte   0,0,0

	.byte   0,232,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32,4,32,4,32,76,32,76

	.byte   32,76,32,76,32,76,32,76,32,76,32,76,32,76,32,4,32,4,0,0,0,0,0,0

	.byte   0,0,0,0,8,0,8,0,8,0,8,0

	.byte   0,0,0,0,0,0,0,4,0,76,64,4,64,4,32,4,32,4,32,4,32,4,32,4,32,4,64

	.byte   4,64,4,0,76,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,4,0,4,0,4

	.byte   0,6,0,6,0,15

	.byte   0,15,128,15,128,15,0,0,0,0,32,0,32,0,32,0,32,0,32,0,32,0,32,0

	.byte   224,7,224,7,224,7,224,7,224,7,224,7,224,7,224,7,224,7,224,7

	.byte   224,7,224,7,224,175,224,7,224,7,224,7,224,7,224,7,224,7,224,7

.skipL01340
.
 ; 

.
 ; 

.L01341 ;  data _Data_Level3A

_Data_Level3A
	.byte   0,4,0,4,0,4,0,4,0,4,0,4,0,4,0,4,0,4,0,4,0,4,0,4,0,4,0,4,128,0

	.byte   128,0,128,0,128,0,128,0,128,0,128,0,128,0,128,0,128,0,128,0,0

	.byte   0,16,8,16,8,16,8,16,8,16,8,16,8

	.byte   16,8,16,8,16,8,16,8,16,8,16,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0

	.byte   4,0,4,16,76,16,76,17,76,16,76,16,76,0,0,0,0,0,0,0,2,0,2,0,2,0,2

	.byte   0,2,0,2,64,24,64,24

	.byte   64,24,64,24,64,24,64,24,64,24,64,24,64,24,64,0,64,0,64,0,64,0,64

	.byte   0,0,0,0,0,0,4,0,4,0,92,0,92,0,88,0,88,0,88,0,88,0,88,0,88,0,88,0

	.byte   0,0,0,64,4,64,76,64,76,64,76,64,76

	.byte   64,76,64,4,0,4,0,4,0,0,0,0,0,0,0,0,16,0,16,0,16,0,16,0,16,0,16,0

	.byte   0,0,0,0,0,0,0,0,0,4,0,4,0,4,0,4,0,4,0,4,0,4,0,4,0,188,0,188,0,188

	.byte   0,188,0,188,0,188

.skipL01341
.
 ; 

.
 ; 

.L01342 ;  data _Data_Level3B

_Data_Level3B
	.byte   16,4,16,4,16,4,16,4,16,4,144,4,128,4,128,4,132,4,132,4,132,4,132

	.byte   4,4,0,4,0,4,0,0,0,0,0,0,0,0,0,8,0,8,0,8,0,8,0,8,0,8,0,136,0,136

	.byte   0,128,4,128,4,128,4,128,4,0,0

	.byte   0,0,0,232,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,128,0

	.byte   128,0,128,0,128,24,128,24,128,24,128,24,128,0,0,0,0,0,0,0,72,0

	.byte   72,0,72,0,72,0,72,0,72,0,0,0

	.byte   0,0,0,120,0,120,0,120,0,120,0,0,0,0,16,0,16,0,16,0,16,0,17,0,17

	.byte   0,16,0,16,0,16,0,16,0,0,0,0,0,0,0,0,92,0,92,0,92,0,92,0,92,0,92

	.byte   0,92,0,92,0,92,0,92,0,4,0,4

	.byte   0,4,128,4,128,4,128,4,128,0,16,0,16,0,16,72,16,72,16,72,16,0,0,0

	.byte   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,4,0,4,0,4,0,4,0,4,0,4

	.byte   0,4,0,172,0,4,0,4

.skipL01342
.
 ; 

.
 ; 

.L01343 ;  data _Data_Level4

_Data_Level4
	.byte   1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,6

	.byte   1,6,3,7,3,7,135,7,135,7,135,7,135,7,135,7,135,7,135,7,135,7,131

	.byte   7,131,7,1,0,1,0,1,0

	.byte   1,0,1,152,1,0,1,0,1,0,1,0,129,7,129,7,129,7,129,7,129,7,129,7,3

	.byte   7,3,7,7,6,7,6,15,4,15,4,15,4,15,4,15,4,1,4,1,4,1,140,1,4,1,4,1

	.byte   4,63,4,63,4,63,4,31,4,31,4

	.byte   15,0,15,0,7,0,7,0,3,0,3,0,1,0,1,0,1,0,1,4,1,4,1,4,1,4,127,4,127,4

	.byte   31,4,31,4,7,4,7,4,3,7,3,7,195,7,195,7,193,31,193,31,193,31,193,31

	.byte   193,31,1,1,1,1,1,0,1,152

	.byte   1,152,1,152,1,0,1,0,1,4,1,4,1,4,65,4,65,4,113,4,113,4,1,28,1,28

	.byte   113,28,113,28,65,28,65,4,1,4,1,4,1,0,1,0,1,152,1,152,1,152,1,0

	.byte   1,4,1,4,17,7,17,7,17,7,17,4,255,7

.skipL01343
.
 ; 

.
 ; 

.L01344 ;  data _Data_Level5A

_Data_Level5A
	.byte   34,4,34,4,32,4,32,4,56,4,56,4,0,4,0,4,0,4,0,4,0,4,0,4,128,4,128

	.byte   4,128,4,128,4,64,4,64,4,0,4,0,4,0,4,0,4,0,0,0,0,0,0,0,0,0,0,0,7

	.byte   0,7,0,7,0,4,0,44

	.byte   0,44,0,44,32,4,32,4,32,4,64,4,64,4,64,4,32,4,32,4,32,4,0,44,0,44

	.byte   0,4,0,4,0,7,0,7,0,7,0,4,0,4,0,12,0,12,0,12,0,12,0,12,0,4,0,4,0,0

	.byte   0,0,0,0,0,0,0,0

	.byte   0,0,0,0,0,0,0,4,0,4,0,4,16,79,16,79,16,79,0,0,0,0,0,0,0,0,0,0,0

	.byte   0,0,4,0,4,0,4,0,4,0,188,0,188,0,188,0,188,128,12,128,12,128,12

	.byte   128,12,32,12,32,12,32,12,32,12,0,188

	.byte   0,188,8,4,8,4,8,4,8,4,0,4,0,4,0,4,128,7,128,7,128,7,128,4,136,4

	.byte   136,76,136,76,136,76,136,76,184,76,184,76,56,76,56,76,56,76,56

	.byte   4,16,4,16,4,16,4,16,7,8,7,8,7,60,4,60,4,60,4

.skipL01344
.
 ; 

.
 ; 

.L01345 ;  data _Data_Level5B

_Data_Level5B
	.byte   0,0,0,7,0,7,0,7,0,0,0,0,128,4,128,4,128,4,128,4,0,4,0,4,32,4,32

	.byte   4,32,4,32,4,32,4,32,4,32,4,16,7,17,7,17,7,17,4,17,4,81,4,81,4

	.byte   16,4,0,0,0,0,0,0,0,0,0,88

	.byte   0,88,0,88,0,88,0,0,0,4,0,4,0,4,0,4,0,4,0,4,0,7,0,7,0,255,0,108

	.byte   0,108,64,108,64,108,0,108,0,108,0,108,0,111,0,111,0,111,0,108

	.byte   0,108,0,108,0,108,0,104,0,104,0,104,128,104,128,104

	.byte   128,104,136,104,136,104,136,104,8,104,16,108,16,108,16,108,16

	.byte   108,160,108,160,108,160,108,160,108,136,108,136,108,8,108,8

	.byte   108,0,104,0,104,0,104,0,104,0,104,0,104,8,104,8,104,4,104,5,108,5

	.byte   108,5,111,5,111,5,111,5,108,0,108,0,44,0,44,0,44,0,44,128,44,128

	.byte   44,128,44,128,44,0,44,0,44,0,44,0,44,0,44,32,44,32,44,48,44,48

	.byte   46,56,46,56,46,0,0,0,0,0,0,0,0,0,0,0,0,32,0,32,168,32,0,32,0,32,0,32,0

.skipL01345
.
 ; 

.
 ; 

.L01346 ;  data _Data_Level6A

_Data_Level6A
	.byte   255,7,0,4,0,4,0,4,0,4,0,4,0,4,1,4,1,0,1,4,1,0,1,0,1,4,1,4,1,0,1,0

	.byte   1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,4,1,4,0,7,0,7,0,7,0,4

	.byte   0,4,0,0,0,0,0,0,0,232,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,8,0,8,0

	.byte   8,0,8,0,8,0,8,0,0,0,0,0,0,0,0,0,0,0,0,7,0,7,0,255,0,4,0,4,64,4,0,4

	.byte   0,0,0,0,0,0,0,0,0,0,128,7,128,7,128,7,0,0,0,0,0,0,0,0,33,0,33,72

	.byte   33,72,33,72,33,72,33,0,1,0,1,0,1,0,1,4,1,4,1,4,1,4,1,4,1,4,1,6,1

	.byte   6,1,6,1,6,1,0

	.byte   1,0,1,0,1,0,1,0,1,0,1,6,3,6,3,6,7,6,7,4,7,4,1,4,1,4,1,204,7,4,7,4

	.byte   7,4,7,4,7,4,1,4,1,4,1,4,7,6,7,6,7,6,3,6,3,4,1,4,1,7,1,7,1,7,255,7

.skipL01346
.
 ; 

.
 ; 

.L01347 ;  data _Data_Level6B

_Data_Level6B
	.byte   255,7,1,4,1,7,1,7,1,7,1,0,1,0,1,0,1,0,1,0,1,0,1,4,1,4,1,4,1,4,1

	.byte   0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,7,1,7

	.byte   1,255,1,0,1,0,1,0,1,0,1,0,3,0,3,6,3,6,7,4,7,4,71,4,79,4,31,4,31

	.byte   4,71,4,67,4,1,44,1,44,1,44,3,4,3,4,7,4,7,4,79,4,15,4,7,4,1,6,1

	.byte   6,1,7,1,7,129,7

	.byte   129,7,161,31,161,31,49,24,49,24,16,24,16,0,0,0,0,0,0,0,0,0,0,0,0

	.byte   0,0,0,225,7,225,79,227,7,227,7,227,7,227,7,129,7,129,7,129,7,129

	.byte   7,1,4,1,4,1,188,1,188,1,188,65,188,65,188,1,12

	.byte   1,12,1,4,1,7,1,7,1,7,1,4,1,4,1,4,1,4,1,4,1,4,33,44,33,44,33,44,33

	.byte   44,48,44,48,44,56,44,56,44,56,44,56,44,0,0,0,0,0,0,0,0,0,0,0,0,48

	.byte   0,48,168,48,0,48,0,48,0

.skipL01347
.
 ; 

.
 ; 

.L01348 ;  data _Data_Level7A

_Data_Level7A
	.byte   68,4,68,4,68,4,68,4,0,4,0,4,0,4,0,4,0,4,16,0,16,0,16,0,16,0,16,0

	.byte   16,4,16,4,16,4,0,4,0,0,0,0,0,0,0,0,0,0,0,0,8,0,8,0,8,0,8,0,8,0,8

	.byte   0,64,0,64,0

	.byte   64,0,64,0,32,0,32,0,32,0,32,0,16,8,16,8,16,8,16,8,8,8,9,8,9,8,8

	.byte   8,0,0,0,0,0,0,0,88,0,88,0,88,0,92,0,92,0,92,0,4,8,4,8,76,8,72,8

	.byte   72,8,72,8,74,0,2,0,2

	.byte   0,90,0,90,0,90,0,88,0,88,0,0,64,4,64,4,64,4,64,4,64,4,0,188,0,188

	.byte   8,4,8,4,0,4,0,4,0,0,0,0,0,0,0,0,0,120,0,120,0,120,0,120,0,0,0,0

	.byte   64,0,64,72,64,72,64,72,64,72

	.byte   68,72,68,0,4,0,4,0,0,0,8,0,8,0,8,0,16,0,16,0,16,0,0,0,0,0,0,0,0

	.byte   0,0,0,0,0,0,0,0,0,144,0,144,72,144,72,16,72,16,76,16,76,0,4,0,4

	.byte   0,4,0,4,0,4,0,4,0,4

.skipL01348
.
 ; 

.
 ; 

.L01349 ;  data _Data_Level7B

_Data_Level7B
	.byte   0,4,0,4,64,4,64,4,64,4,64,4,0,0,0,0,0,0,16,0,16,0,16,0,16,4,16,4

	.byte   16,4,16,4,16,4,16,4,16,4,16,0,16,0,0,0,0,0,0,0,0,0,0,4,0,4,16,4

	.byte   16,4,16,0,16,8,16,8

	.byte   16,8,17,8,16,8,17,12,16,12,17,12,16,8,16,8,0,0,0,0,0,88,0,88,0,92

	.byte   0,92,0,92,128,4,128,4,0,4,0,0,16,0,16,0,16,0,0,0,0,0,8,0,8,72,8

	.byte   72,8,72,8,72,8,0,0,0,0,104

	.byte   0,104,64,104,64,104,64,104,64,104,64,104,64,104,64,104,64,104,0

	.byte   106,0,106,0,106,0,106,8,104,8,104,8,104,8,104,64,104,64,104,64

	.byte   104,64,104,0,104,0,104,4,104,4,104,4,104,0,104,0,104,0

	.byte   104,0,104,0,106,0,106,4,106,4,106,4,106,4,106,0,104,0,104,0,104

	.byte   0,104,0,104,0,104,0,104,0,106,0,106,0,106,0,106,0,106,0,106,0,1

	.byte   0,1,128,0,128,0,128,0,0,0,0,0,0,0,0,1,0,1,0,1,0,169,0,1,0,1,0,1

.skipL01349
.
 ; 

.
 ; 

.L01350 ;  data _Data_Level8

_Data_Level8
	.byte   1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,6,1,6,1,7,1,7,129,7,129

	.byte   7,193,7,193,7,225,7,225,7,225,7,225,7,225,7,225,7,225,7,225,7,225

	.byte   7,225,7,227,7,227,7,227,7,227,7

	.byte   1,4,1,4,1,140,1,4,1,4,1,4,7,4,7,4,7,4,63,4,63,4,63,4,33,4,33,4,1

	.byte   4,1,4,1,4,1,6,1,6,17,7,17,7,17,7,17,0,17,0,49,0,33,0,33,0,33,24

	.byte   33,24,33,24,33,24,33,24

	.byte   33,24,33,24,33,24,33,24,49,24,17,24,17,24,17,24,17,24,17,0,1,7,1

	.byte   7,1,7,1,0,31,0,15,0,15,0,7,4,7,4,3,4,3,4,3,0,3,0,1,152,1,152,1

	.byte   152,1,0,1,4,33,4,33,4,1,6,1,6

	.byte   1,4,1,4,1,4,1,4,65,4,65,4,65,28,65,28,65,28,1,28,1,28,1,28,1,28,1

	.byte   28,1,28,241,31,241,31,241,31,241,7,1,0,1,0,1,152,1,152,1,152,1,0

	.byte   1,4,1,4,1,7,1,7,1,7,1,4,255,7

.skipL01350
.
 ; 

.
 ; 

.__Boss_PF_Setup
 ; __Boss_PF_Setup

.L01351 ;  playfield:

  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel1
PF_data1
	.byte %11000011, %11111111
	if (pfwidth>2)
	.byte %11111111, %11000000
 endif
	.byte %11000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %11000000
 endif
	.byte %11000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %11000000
 endif
	.byte %11000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %11000000
 endif
	.byte %11000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %11000000
 endif
	.byte %11000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %11000000
 endif
	.byte %11000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %11000000
 endif
	.byte %11000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %11000000
 endif
	.byte %11000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %11000000
 endif
	.byte %11000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %11000000
 endif
	.byte %11111111, %11111111
	if (pfwidth>2)
	.byte %11111111, %11111111
 endif
pflabel1
	lda PF_data1,x
	sta playfield,x
	dex
	bpl pflabel1
.L01352 ;  return otherbank

	JMP BS_return
.
 ; 

.__Boss_PF_Setup_2
 ; __Boss_PF_Setup_2

.L01353 ;  playfield:

  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel2
PF_data2
	.byte %11000000, %11111111
	if (pfwidth>2)
	.byte %11111111, %11000000
 endif
	.byte %11000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %11000000
 endif
	.byte %11000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %11000000
 endif
	.byte %11000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %11000000
 endif
	.byte %11000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %11000000
 endif
	.byte %11000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %11000000
 endif
	.byte %11000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %11000000
 endif
	.byte %11000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %11000000
 endif
	.byte %11000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %11000000
 endif
	.byte %11000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %11000000
 endif
	.byte %11001111, %11111111
	if (pfwidth>2)
	.byte %11111111, %11001111
 endif
pflabel2
	lda PF_data2,x
	sta playfield,x
	dex
	bpl pflabel2
.L01354 ;  return otherbank

	JMP BS_return
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01355 ;  bank 6

 if ECHO5
 echo "    ",[(start_bank5 - *)]d , "bytes of ROM space left in bank 5")
 endif
ECHO5 = 1
 ORG $5FF4-bscode_length
 RORG $9FF4-bscode_length
start_bank5 ldx #$ff
 ifconst FASTFETCH ; using DPC+
 stx FASTFETCH
 endif 
 txs
 if bankswitch == 64
   lda #(((>(start-1)) & $0F) | $F0)
 else
   lda #>(start-1)
 endif
 pha
 lda #<(start-1)
 pha
 pha
 txa
 pha
 tsx
 if bankswitch != 64
   lda 4,x ; get high byte of return address
   rol
   rol
   rol
   rol
   and #bs_mask ;1 3 or 7 for F8/F6/F4
   tax
   inx
 else
   lda 4,x ; get high byte of return address
   tay
   ora #$10 ; change our bank nibble into a valid rom mirror
   sta 4,x
   tya
   lsr 
   lsr 
   lsr 
   lsr 
   tax
   inx
 endif
 lda bankswitch_hotspot-1,x
 pla
 tax
 pla
 rts
 if ((* & $1FFF) > ((bankswitch_hotspot & $1FFF) - 1))
   echo "WARNING: size parameter in banksw.asm too small - the program probably will not work."
   echo "Change to",[(*-begin_bscode+1)&$FF]d,"and try again."
 endif
 ORG $5FFC
 RORG $9FFC
 .word (start_bank5 & $ffff)
 .word (start_bank5 & $ffff)
 ORG $6000
 RORG $B000
.
 ; 

.
 ; 

.__Level_Data_Bank2
 ; __Level_Data_Bank2

.L01356 ;  z  =  z  -  16

	LDA z
	SEC
	SBC #16
	STA z
.L01357 ;  on z goto __W31A __W31B __W32A __W32B __W33A __W33B __W34 __W34 __W41A __W41B __W42A __W42B __W43A __W43B __W44 __W44

	LDX z
	LDA .L01357jumptablehi,x
	PHA
	LDA .L01357jumptablelo,x
	PHA
	RTS
.L01357jumptablehi
	.byte >(.__W31A-1)
	.byte >(.__W31B-1)
	.byte >(.__W32A-1)
	.byte >(.__W32B-1)
	.byte >(.__W33A-1)
	.byte >(.__W33B-1)
	.byte >(.__W34-1)
	.byte >(.__W34-1)
	.byte >(.__W41A-1)
	.byte >(.__W41B-1)
	.byte >(.__W42A-1)
	.byte >(.__W42B-1)
	.byte >(.__W43A-1)
	.byte >(.__W43B-1)
	.byte >(.__W44-1)
	.byte >(.__W44-1)
.L01357jumptablelo
	.byte <(.__W31A-1)
	.byte <(.__W31B-1)
	.byte <(.__W32A-1)
	.byte <(.__W32B-1)
	.byte <(.__W33A-1)
	.byte <(.__W33B-1)
	.byte <(.__W34-1)
	.byte <(.__W34-1)
	.byte <(.__W41A-1)
	.byte <(.__W41B-1)
	.byte <(.__W42A-1)
	.byte <(.__W42B-1)
	.byte <(.__W43A-1)
	.byte <(.__W43B-1)
	.byte <(.__W44-1)
	.byte <(.__W44-1)
.
 ; 

.__W31A
 ; __W31A

.L01358 ;  y  =  _Level9A[x] : x  =  x  +  1  :  u  =  _Level9A[x] : return otherbank

	LDX x
	LDA _Level9A,x
	STA y
	INC x
	LDX x
	LDA _Level9A,x
	STA u
	JMP BS_return
.
 ; 

.__W31B
 ; __W31B

.L01359 ;  y  =  _Level9B[x] : x  =  x  +  1  :  u  =  _Level9B[x] : return otherbank

	LDX x
	LDA _Level9B,x
	STA y
	INC x
	LDX x
	LDA _Level9B,x
	STA u
	JMP BS_return
.
 ; 

.__W32A
 ; __W32A

.L01360 ;  y  =  _Level10A[x] : x  =  x  +  1  :  u  =  _Level10A[x] : return otherbank

	LDX x
	LDA _Level10A,x
	STA y
	INC x
	LDX x
	LDA _Level10A,x
	STA u
	JMP BS_return
.
 ; 

.__W32B
 ; __W32B

.L01361 ;  y  =  _Level10B[x] : x  =  x  +  1  :  u  =  _Level10B[x] : return otherbank

	LDX x
	LDA _Level10B,x
	STA y
	INC x
	LDX x
	LDA _Level10B,x
	STA u
	JMP BS_return
.
 ; 

.__W33A
 ; __W33A

.L01362 ;  y  =  _Level11A[x] : x  =  x  +  1  :  u  =  _Level11A[x] : return otherbank

	LDX x
	LDA _Level11A,x
	STA y
	INC x
	LDX x
	LDA _Level11A,x
	STA u
	JMP BS_return
.
 ; 

.__W33B
 ; __W33B

.L01363 ;  y  =  _Level11B[x] : x  =  x  +  1  :  u  =  _Level11B[x] : return otherbank

	LDX x
	LDA _Level11B,x
	STA y
	INC x
	LDX x
	LDA _Level11B,x
	STA u
	JMP BS_return
.
 ; 

.__W34
 ; __W34

.L01364 ;  y  =  _Level12[x] : x  =  x  +  1  :  u  =  _Level12[x] : return otherbank

	LDX x
	LDA _Level12,x
	STA y
	INC x
	LDX x
	LDA _Level12,x
	STA u
	JMP BS_return
.
 ; 

.__W41A
 ; __W41A

.L01365 ;  y  =  _Level13A[x] : x  =  x  +  1  :  u  =  _Level13A[x] : return otherbank

	LDX x
	LDA _Level13A,x
	STA y
	INC x
	LDX x
	LDA _Level13A,x
	STA u
	JMP BS_return
.
 ; 

.__W41B
 ; __W41B

.L01366 ;  y  =  _Level13B[x] : x  =  x  +  1  :  u  =  _Level13B[x] : return otherbank

	LDX x
	LDA _Level13B,x
	STA y
	INC x
	LDX x
	LDA _Level13B,x
	STA u
	JMP BS_return
.
 ; 

.__W42A
 ; __W42A

.L01367 ;  y  =  _Level14A[x] : x  =  x  +  1  :  u  =  _Level14A[x] : return otherbank

	LDX x
	LDA _Level14A,x
	STA y
	INC x
	LDX x
	LDA _Level14A,x
	STA u
	JMP BS_return
.
 ; 

.__W42B
 ; __W42B

.L01368 ;  y  =  _Level14B[x] : x  =  x  +  1  :  u  =  _Level14B[x] : return otherbank

	LDX x
	LDA _Level14B,x
	STA y
	INC x
	LDX x
	LDA _Level14B,x
	STA u
	JMP BS_return
.
 ; 

.__W43A
 ; __W43A

.L01369 ;  y  =  _Level15A[x] : x  =  x  +  1  :  u  =  _Level15A[x] : return otherbank

	LDX x
	LDA _Level15A,x
	STA y
	INC x
	LDX x
	LDA _Level15A,x
	STA u
	JMP BS_return
.
 ; 

.__W43B
 ; __W43B

.L01370 ;  y  =  _Level15B[x] : x  =  x  +  1  :  u  =  _Level15B[x] : return otherbank

	LDX x
	LDA _Level15B,x
	STA y
	INC x
	LDX x
	LDA _Level15B,x
	STA u
	JMP BS_return
.
 ; 

.__W44
 ; __W44

.L01371 ;  y  =  _Level16[x] : x  =  x  +  1  :  u  =  _Level16[x] : return otherbank

	LDX x
	LDA _Level16,x
	STA y
	INC x
	LDX x
	LDA _Level16,x
	STA u
	JMP BS_return
.
 ; 

.
 ; 

.L01372 ;  data _Level9A

_Level9A
	.byte   0,4,0,4,0,4,0,4,0,4,0,4,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,0,7

	.byte   0,7,0,4,0,4,0,4,32,4,34,4,34,4,34,4,32,4,0,4,0,4,0,4,0,4,0,4,0

	.byte   4,0,220,0,220,0,220,0,220,32,140,32,140,64,140,64,140

	.byte   32,140,32,140,0,140,0,140,0,142,0,142,0,143,0,143,128,143,128

	.byte   143,128,143,0,136,0,136,0,136,0,136,0,136,0,136,0,136,0,136

	.byte   128,143,128,143,132,143,4,143,4,143,4,142,4,142,4,140,4,140,0

	.byte   140,0

	.byte   140,0,140,0,143,16,143,16,255,16,136,16,136,16,136,16,136,0,136

	.byte   0,136,0,140,0,140,0,140,0,140,4,140,4,140,4,140,4,140,0,220,0

	.byte   220,0,220,0,220,0,220,0,220,66,140,0,140,0,140,0,140,66,140,0

	.byte   220,0,220,0,220,0,220,0,140,0,140,0,140,0,142,0,142,0,143,0

	.byte   143,128,143,128,143,128,143,128,143,128,143,128,143,132,143

	.byte   4,143,4,143,4,142,4,142,4,140,4,140,4,143,4,143,4,143,4,140

	.byte   4,140,4,140

.skipL01372
.
 ; 

.
 ; 

.L01373 ;  data _Level9B

_Level9B
	.byte   0,0,0,7,0,7,0,7,0,0,0,0,32,0,34,0,34,0,32,0,0,0,0,0,0,7,0,7,0,7

	.byte   0,4,0,4,8,4,8,4,72,4,72,4,64,4,64,4,0,4,4,4,4,4,4,4,180,5,180,5

	.byte   180,5,0,108,0,108,0,108,0,108,16,104,16,104

	.byte   31,104,31,104,16,108,16,108,16,108,16,108,16,108,0,108,0,105,0

	.byte   105,0,105,0,105,0,104,0,104,32,108,32,108,40,108,40,108,8,108

	.byte   8,108,8,108,8,108,8,111,8,111,8,255,8,108,8,108,8,111

	.byte   8,111,8,255,8,108,8,108,8,111,8,111,8,255,8,108,8,108,8,108,8

	.byte   108,0,188,72,4,72,4,72,4,72,4,0,4,13,4,13,4,0,188,0,188,0,188

	.byte   32,4,32,4,34,4,34,4,32,4,32,4,0,188,0,188,0,4,0,4

	.byte   128,8,128,8,160,8,160,8,8,8,8,8,8,12,8,12,0,4,0,4,0,6,0,6,0,7,0

	.byte   7,128,7,128,7,128,7,128,7,160,7,160,7,160,7,160,7,0,0,0,0,0,0,0

	.byte   0,0,0,0,0,32,0,32,168,32,0,32,0

.skipL01373
.
 ; 

.
 ; 

.L01374 ;  data _Level10A

_Level10A
	.byte   255,7,0,4,0,4,0,4,0,4,0,4,0,4,1,4,129,4,129,4,129,4,129,4,32,4,32

	.byte   4,32,0,32,0,32,0,32,0,0,0,0,0,0,0,0,0,16,0,16,0,16,0,16,0,0,0,0,0

	.byte   0,0,0,0,240,7,240,7

	.byte   240,7,32,0,0,0,0,0,0,232,0,0,0,0,0,0,0,0,0,0,0,0,0,0,63,4,63,4,1

	.byte   4,1,4,1,4,1,4,17,4,17,28,17,28,17,28,17,28,17,28,17,28,17,28,17

	.byte   28,1,4,1,4,1,7,1,7,1,255

	.byte   1,0,1,0,1,120,1,120,192,7,192,7,192,7,192,7,0,0,0,0,0,120,0,120

	.byte   240,7,240,7,240,7,240,7,0,0,0,0,0,88,0,88,0,88,0,88,0,88,15,0,7

	.byte   4,3,4,1,4,1,4,1,4,137,4,137,44,137,44

	.byte   137,44,129,44,129,44,129,44,129,28,17,24,17,24,17,24,17,24,17,24

	.byte   129,28,129,44,129,44,137,44,137,44,137,44,9,76,9,76,9,12,9,12,1

	.byte   12,1,76,65,44,65,44,65,44,65,44,1,76,1,4,3,7,7,7,15,7,255,7

.skipL01374
.
 ; 

.
 ; 

.L01375 ;  data _Level10B

_Level10B
	.byte   0,0,16,7,16,7,16,7,16,4,16,4,16,4,0,4,64,4,0,4,64,4,0,4,64,4,0,4

	.byte   0,4,0,4,176,4,176,4,176,4,176,4,176,4,177,4,177,4,177,4,161,4,161

	.byte   4,161,4,161,4,163,4,163,4,1,4,1,4

	.byte   1,204,3,4,3,4,3,7,3,7,3,7,1,4,1,4,1,4,163,7,163,7,161,7,33,0,33

	.byte   0,1,4,1,4,1,4,1,4,63,4,63,4,31,4,15,4,7,4,3,4,65,4,65,4,1,188,1

	.byte   188,1,188,1,188,3,0,7,0

	.byte   15,6,31,6,31,6,31,6,3,7,1,31,0,31,0,31,16,24,16,24,16,24,16,24

	.byte   16,0,17,0,17,0,17,0,1,0,1,4,1,4,1,4,31,4,31,4,1,7,1,7,1,255,1

	.byte   4,1,4,9,4,9,4,1,15,1,15,193,15

	.byte   193,15,240,15,240,15,0,4,0,4,0,4,64,4,64,4,0,28,1,28,11,6,11,6,1

	.byte   31,1,31,129,31,129,31,128,31,128,31,0,0,0,0,0,0,0,0,0,0,0,0,0,0

	.byte   0,0,0,0,129,7,129,7,129,175,129,7,129,7

.skipL01375
.
 ; 

.
 ; 

.L01376 ;  data _Level11A

_Level11A
	.byte   0,4,0,4,0,4,0,4,0,4,0,4,0,4,0,4,0,4,0,4,0,4,128,4,128,4,128,4,128

	.byte   4,0,0,0,0,0,0,0,0,0,0,0,0,64,4,64,4,64,4,64,4,64,4,64,4,64,4,0,4

	.byte   0,4,0,4,0,140,0,140,0,140,0,140,16,140,16,140,16,140

	.byte   16,140,16,140,16,140,0,140,0,140,0,140,0,140,0,136,16,136,16,136

	.byte   16,136,16,136,16,136,16,136,0,136,0,136,0,136,0,136,0,136,0,136

	.byte   32,136,32,136,32,136,32,136,32,136,32,136

	.byte   32,136,0,136,0,136,0,136,0,136,0,136,0,136,0,136,32,140,32,140,32

	.byte   140,33,4,32,0,33,0,32,0,33,0,0,4,0,4,0,4,0,4,0,4,0,92,0,92,0,92,0

	.byte   88,0,88,0,0,0,0,8,0,8,72,8,76,8,76

	.byte   64,76,64,76,64,76,64,76,0,4,0,4,4,0,4,0,4,0,4,0,4,0,0,0,0,0,0,4,0

	.byte   4,0,4,0,4,0,4,0,4,8,0,8,0,8,0,8,72,8,72,8,72,8,76,8,76,8,76,8,76

	.byte   8,76,0,76,0,4

.skipL01376
.
 ; 

.
 ; 

.L01377 ;  data _Level11B

_Level11B
	.byte   0,4,0,4,0,4,0,4,0,4,0,4,0,4,0,4,0,4,0,4,0,4,0,4,0,0,0,0,0,0,64,0

	.byte   64,0,64,0,64,0,64,0,64,0,64,0,0,0,0,0,0,0,0,4,0,4,0,4,0,4,0,4,0

	.byte   4,0,92

	.byte   0,92,0,140,80,140,81,4,81,4,80,140,0,140,0,140,0,92,0,92,0,92,0

	.byte   88,0,88,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,4,0,4,0,4,80,4,81,4,81,4

	.byte   80,4,0,4,0,4,0,4,0,0,0,0

	.byte   0,120,0,120,0,120,0,120,0,120,0,120,0,0,64,0,64,0,64,0,64,0,64

	.byte   0,64,0,64,0,64,0,64,0,8,0,8,0,8,0,8,0,0,0,0,120,0,120,0,124,0

	.byte   124,0,124,0,124,0,124,0,124,0,120,0,120,0,88

	.byte   0,88,0,88,0,88,0,88,0,90,0,90,0,90,0,90,0,88,0,88,0,88,0,0,0,0

	.byte   0,0,0,1,0,1,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,4,0,172

	.byte   0,4,0,4,0,4,0,4

.skipL01377
.
 ; 

.
 ; 

.L01378 ;  data _Level12

_Level12
	.byte   1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,6,1,6,1,7,1,7,129,7,129

	.byte   7,193,7,193,7,227,7,227,7,227,7,227,7,227,7,227,7,3,4,3,4,3,4,3,4

	.byte   127,4,127,4,1,4,1,4

	.byte   1,140,1,4,1,4,1,4,3,6,3,6,3,6,3,6,3,6,3,6,3,0,3,0,3,0,195,7,192,7

	.byte   192,7,192,7,0,0,0,0,8,0,8,0,8,0,252,7,252,7,0,4,0,4,0,4,63,4,63,4

	.byte   32,4,32,4,0,4

	.byte   0,0,0,152,0,152,0,0,4,7,4,7,4,7,4,7,0,7,0,0,0,0,0,152,0,0,248,7

	.byte   252,7,28,0,12,0,28,0,252,7,248,7,0,0,0,0,0,0,0,0,24,6,24,44,24

	.byte   44,24,44,24,44,63,4,63,4,48,4

	.byte   48,4,32,4,32,4,0,28,0,28,0,30,0,30,128,31,128,31,248,31,248,31

	.byte   248,31,0,0,0,0,1,0,63,4,63,4,1,4,1,4,1,31,1,31,193,31,193,31,1

	.byte   0,1,0,1,152,1,152,1,152,1,7,1,7,1,7,255,7

.skipL01378
.
 ; 

.
 ; 

.L01379 ;  data _Level13A

_Level13A
	.byte   0,4,0,4,0,4,0,4,0,4,0,4,0,4,0,4,0,4,0,4,0,0,0,0,0,0,0,4,0,0,0,0

	.byte   0,0,0,4,0,4,0,0,0,0,0,0,0,4,0,4,0,0,0,0,0,0,0,4,0,4,0,28,32,4,34,4

	.byte   32,4,34,4,32,4,0,28,0,188,64,4,0,188,64,4,0,188,0,188,0,188,32

	.byte   12,32,12,32,12,32,4,0,7,0,7,0,7,0,4,0,4,64,4,64,4,0,44,0,4,0,7

	.byte   0,7,0,7,0,0,0,0,0,0,0,0,0,0

	.byte   0,0,0,4,0,4,0,4,60,4,60,4,32,4,32,28,32,28,32,28,32,28,32,28,0,28

	.byte   0,28,0,28,0,28,0,31,0,31,128,31,128,31,0,0,0,0,0,88,0,88,0,88,33

	.byte   0,33,72,34,72,34,72,33,72,33,72,0,0

	.byte   0,0,0,88,0,88,0,0,160,7,160,7,0,0,0,0,0,0,0,0,0,4,0,4,0,4,0,4,0,4

	.byte   0,4,0,0,0,0,0,0,0,0,0,4,0,4,0,4,0,4,0,0,0,0,8,7,8,7,8,255,0,0,0,0,0,0

.skipL01379
.
 ; 

.
 ; 

.L01380 ;  data _Level13B

_Level13B
	.byte   0,4,0,7,0,7,0,7,0,4,0,4,0,4,0,4,0,4,0,4,0,0,0,0,0,0,0,4,0,0,0,0

	.byte   0,4,0,4,0,4,0,0,0,0,0,4,0,4,0,4,0,0,0,0,0,0,0,4,0,4,0,4,0,4,128,44

	.byte   128,44,128,44,128,44,128,44,0,40,16,40,16,40,16,40,16,40,0,0,0,0

	.byte   0,88,0,88,0,88,0,0,13,7,13,7,13,255,0,4,0,4,0,4,0,4,16,12,16,12

	.byte   16,8,16,8,176,15,176,15,64,4,0,4,0,0,0,0

	.byte   0,0,0,0,0,7,0,7,0,255,0,4,0,4,0,76,40,4,40,4,0,76,0,76,0,88,0,88

	.byte   0,88,0,88,4,89,4,89,4,89,4,89,4,89,4,89,0,88,0,88,0,88,0,88,0,92

	.byte   0,92,0,92,0,92,0,92,0,88

	.byte   0,120,0,120,0,126,0,94,0,94,0,88,0,88,128,95,128,95,128,95,0,0,0

	.byte   0,32,0,32,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,4

	.byte   0,4,0,4,0,172,0,4,0,4

.skipL01380
.
 ; 

.
 ; 

.L01381 ;  data _Level14A

_Level14A
	.byte   0,4,0,4,0,4,0,4,0,4,0,4,0,4,0,4,0,4,0,4,0,6,0,6,0,7,0,7,128,7,128

	.byte   7,0,0,0,0,176,7,176,7,176,7,176,7,0,0,0,0,0,0,0,0,188,7,188,7,0,4

	.byte   0,4,0,188,0,188

	.byte   63,4,63,4,0,4,0,188,0,4,0,4,0,4,128,7,128,7,0,92,0,92,0,88,0,92,0

	.byte   92,0,88,0,88,0,0,32,4,32,76,32,72,32,72,0,4,0,4,0,120,0,120,0,0

	.byte   10,108,10,108,128,108,128,108,128,104,128,104

	.byte   0,104,0,104,0,104,0,104,0,108,0,108,42,108,42,108,0,108,0,108,0

	.byte   108,0,108,0,111,0,111,0,111,0,108,0,108,16,104,16,104,16,104,16

	.byte   104,0,104,0,104,0,104,128,104,128,108,128,108,128,108,64

	.byte   108,64,108,64,108,64,108,0,108,0,108,145,104,145,104,145,104,145

	.byte   104,1,104,1,104,63,108,63,108,8,4,8,4,8,4,8,4,0,0,0,0,128,0,128

	.byte   0,128,0,0,0,0,0,188,7,188,7,188,7,0,0,0,0,0,7,0,7,0,255,0,0,0,0,0,0

.skipL01381
.
 ; 

.
 ; 

.L01382 ;  data _Level14B

_Level14B
	.byte   1,4,1,7,1,7,1,7,1,4,1,4,1,4,1,4,1,4,1,4,1,0,1,0,1,0,1,0,1,0,1,0

	.byte   1,4,1,4,1,4,1,4,1,0,1,0,1,0,1,0,1,0,1,0,1,7,1,7,1,7,3,7,3,7,1,7

	.byte   1,7,1,207,3,7,3,7,3,7,3,7,3,7,1,7,1,7,1,7,163,7,163,7,163,7,163

	.byte   7,3,7,3,7,0,0,0,0,0,0,0,120,0,120,0,120,0,120,0,120,0,120,0,124

	.byte   0,124,0,124,0,124,0,120,0,120,0,120

	.byte   0,120,0,120,0,120,0,0,0,4,0,4,0,7,0,7,0,255,0,108,0,108,80,108

	.byte   80,108,80,108,80,108,0,104,0,104,176,111,176,111,176,111,0,108

	.byte   0,108,0,0,0,0,4,0,4,72,188,79,188,79,4,74,4,74,0,104,0,104

	.byte   31,104,31,104,0,108,0,108,0,108,0,108,128,104,128,104,128,104,0

	.byte   104,0,104,32,104,32,104,32,104,0,104,0,104,4,104,4,104,4,104,0

	.byte   104,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,48,0,48,168,48,0,48,0

.skipL01382
.
 ; 

.
 ; 

.L01383 ;  data _Level15A

_Level15A
	.byte   64,4,64,4,64,4,64,4,0,4,4,4,4,4,4,4,4,4,0,4,0,4,128,4,128,4,128

	.byte   4,132,4,4,4,4,4,4,4,0,4,0,4,0,4,0,0,0,0,0,0,0,0,0,0,8,0,8,4,8,4

	.byte   8,4,8,4,8,4

	.byte   8,4,8,4,8,4,8,12,8,12,8,12,0,4,0,4,0,124,0,124,0,124,0,124,0,4,0

	.byte   4,16,4,16,76,16,76,16,76,16,76,16,76,0,4,0,4,0,4,4,4,4,28,4,28,4

	.byte   28,4,28,4,28,4,28,4,28,4,28

	.byte   4,28,4,28,4,24,0,0,0,0,0,120,0,120,0,120,0,0,0,4,16,140,16,140

	.byte   16,140,16,140,16,140,16,140,16,140,16,140,16,140,16,140,16,140

	.byte   16,140,0,140,0,140,0,120,0,120,0,120,0,120,0,124,0,124,4,104,4,104

	.byte   4,104,4,104,0,104,0,104,32,104,32,104,32,104,32,104,0,104,0,104

	.byte   0,104,8,0,8,0,8,0,8,0,0,0,0,4,0,4,0,4,0,4,0,0,0,0,0,0,0,0,0,4,0

	.byte   124,0,124,0,124,0,124,0,124,0,4,0,0

.skipL01383
.
 ; 

.
 ; 

.L01384 ;  data _Level15B

_Level15B
	.byte   0,4,0,4,0,4,0,4,0,4,0,4,64,4,64,4,64,4,64,4,64,4,64,0,4,0,4,0,4

	.byte   0,4,0,4,0,0,0,0,0,0,0,0,0,4,0,4,4,4,4,4,0,4,0,4,0,4,0,4,0,4,0,0

	.byte   0,0,0

	.byte   0,0,0,232,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

	.byte   0,4,0,4,0,4,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,120,0

	.byte   120,0,120

	.byte   0,120,0,120,0,120,0,104,0,104,0,104,0,104,0,104,0,104,0,108,0

	.byte   108,0,108,0,108,0,108,0,108,0,108,0,108,144,108,145,76,145,76

	.byte   145,76,145,76,144,76,0,0,0,0,0,88,0,88,4,88,4,88,4,88,4,88,4,88

	.byte   4,88,0,88,0,88,0,88,0,88,0,88,0,104,0,108,0,108,0,108,0,108,0

	.byte   108,0,104,128,104,128,104,128,104,128,104,0,104,0,104,0,104,0

	.byte   104,0,104,0,108,0,108,0,108,0,108,16,4,16,172,16,4,144,4,144

	.byte   4,144,4

.skipL01384
.
 ; 

.
 ; 

.L01385 ;  data _Level16

_Level16
	.byte   1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,0,1,0,1,0,1,0,129,7,129

	.byte   7,193,7,193,7,225,7,225,7,225,0,225,0,225,0,225,0,225,0,225,0,225

	.byte   7,225,7,195,7,195,7,135,7,135,7

	.byte   135,7,7,0,7,0,7,0,4,152,4,24,132,31,132,31,132,31,132,31,4,31,12

	.byte   31,12,30,24,4,24,4,112,4,112,4,64,4,64,4,64,4,70,4,70,4,68,4,0,4

	.byte   0,4,252,7,252,7,0,4,0,4,0,4,0,4,0,0

	.byte   0,0,64,0,64,0,64,0,64,0,0,0,0,0,0,0,0,0,31,108,31,108,31,108,31

	.byte   108,8,104,8,104,0,104,0,104,128,104,128,104,252,104,252,104,0

	.byte   104,0,104,0,104,0,108,0,76,32,4,32,4,127,4,127,4,64,4,64,4

	.byte   0,76,0,108,240,111,240,111,0,104,0,104,193,111,195,111,3,108,3

	.byte   108,3,108,3,0,3,0,3,0,3,6,3,6,15,6,15,6,1,6,1,6,1,142,1,6,1,6

	.byte   1,6,195,7,195,7,7,0,7,0,15,7,15,7,31,7,255,7

.skipL01385
.
 ; 

.
 ; 

.
 ; 

.__Boss_PF_Setup_3
 ; __Boss_PF_Setup_3

.L01386 ;  playfield:

  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel3
PF_data3
	.byte %11000000, %11111111
	if (pfwidth>2)
	.byte %11111111, %11000000
 endif
	.byte %11000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %11000000
 endif
	.byte %11000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %11000000
 endif
	.byte %11000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %11000000
 endif
	.byte %11000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %11000000
 endif
	.byte %11000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %11000000
 endif
	.byte %11110000, %00000000
	if (pfwidth>2)
	.byte %00000000, %11110000
 endif
	.byte %11000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %11000000
 endif
	.byte %11000000, %10000000
	if (pfwidth>2)
	.byte %10000000, %11000000
 endif
	.byte %11000000, %10000000
	if (pfwidth>2)
	.byte %10000000, %11000000
 endif
	.byte %11001111, %11111111
	if (pfwidth>2)
	.byte %11111111, %11001111
 endif
pflabel3
	lda PF_data3,x
	sta playfield,x
	dex
	bpl pflabel3
.L01387 ;  return otherbank

	JMP BS_return
.
 ; 

.
 ; 

.
 ; 

.__Boss_PF_Setup_4
 ; __Boss_PF_Setup_4

.L01388 ;  playfield:

  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel4
PF_data4
	.byte %11100000, %11111111
	if (pfwidth>2)
	.byte %11111111, %11100000
 endif
	.byte %11000000, %11111110
	if (pfwidth>2)
	.byte %11111110, %11000000
 endif
	.byte %11100000, %00111100
	if (pfwidth>2)
	.byte %00111100, %11100000
 endif
	.byte %11000000, %00011000
	if (pfwidth>2)
	.byte %00011000, %11000000
 endif
	.byte %11000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %11000000
 endif
	.byte %11000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %11000000
 endif
	.byte %11110000, %00000000
	if (pfwidth>2)
	.byte %00000000, %11110000
 endif
	.byte %11000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %11000000
 endif
	.byte %11000000, %10000000
	if (pfwidth>2)
	.byte %10000000, %11000000
 endif
	.byte %11000000, %10000000
	if (pfwidth>2)
	.byte %10000000, %11000000
 endif
	.byte %11111111, %10011111
	if (pfwidth>2)
	.byte %10011111, %11111111
 endif
pflabel4
	lda PF_data4,x
	sta playfield,x
	dex
	bpl pflabel4
.L01389 ;  return otherbank

	JMP BS_return
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01390 ;  bank 7

 if ECHO6
 echo "    ",[(start_bank6 - *)]d , "bytes of ROM space left in bank 6")
 endif
ECHO6 = 1
 ORG $6FF4-bscode_length
 RORG $BFF4-bscode_length
start_bank6 ldx #$ff
 ifconst FASTFETCH ; using DPC+
 stx FASTFETCH
 endif 
 txs
 if bankswitch == 64
   lda #(((>(start-1)) & $0F) | $F0)
 else
   lda #>(start-1)
 endif
 pha
 lda #<(start-1)
 pha
 pha
 txa
 pha
 tsx
 if bankswitch != 64
   lda 4,x ; get high byte of return address
   rol
   rol
   rol
   rol
   and #bs_mask ;1 3 or 7 for F8/F6/F4
   tax
   inx
 else
   lda 4,x ; get high byte of return address
   tay
   ora #$10 ; change our bank nibble into a valid rom mirror
   sta 4,x
   tya
   lsr 
   lsr 
   lsr 
   lsr 
   tax
   inx
 endif
 lda bankswitch_hotspot-1,x
 pla
 tax
 pla
 rts
 if ((* & $1FFF) > ((bankswitch_hotspot & $1FFF) - 1))
   echo "WARNING: size parameter in banksw.asm too small - the program probably will not work."
   echo "Change to",[(*-begin_bscode+1)&$FF]d,"and try again."
 endif
 ORG $6FFC
 RORG $BFFC
 .word (start_bank6 & $ffff)
 .word (start_bank6 & $ffff)
 ORG $7000
 RORG $D000
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Get_Music
 ; __Get_Music

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01391 ;  _Music_Duration  =  _Music_Duration  -  1

	DEC _Music_Duration
.
 ; 

.L01392 ;  if _Music_Duration  >  0 then goto __Got_Music bank3

	LDA #0
	CMP _Music_Duration
     BCS .skipL01392
.condpart642
 sta temp7
 lda #>(.__Got_Music-1)
 pha
 lda #<(.__Got_Music-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #3
 jmp BS_jsr
.skipL01392
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01393 ;  temp4  =  sread ( _OWMusicData ) 

	ldx #_OWMusicData
	lda (0,x)
	inc 0,x
	bne *+4
	inc 1,x
	STA temp4
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01394 ;  if temp4  =  255 then _Music_Duration  =  1  :  gosub __OW_Music  :  goto __Get_Music

	LDA temp4
	CMP #255
     BNE .skipL01394
.condpart643
	LDA #1
	STA _Music_Duration
 jsr .__OW_Music
 jmp .__Get_Music

.skipL01394
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01395 ;  temp5  =  sread ( _OWMusicData ) 

	ldx #_OWMusicData
	lda (0,x)
	inc 0,x
	bne *+4
	inc 1,x
	STA temp5
.L01396 ;  temp6  =  sread ( _OWMusicData ) 

	ldx #_OWMusicData
	lda (0,x)
	inc 0,x
	bne *+4
	inc 1,x
	STA temp6
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01397 ;  if _Bit1_Jumping_Flag{1}  ||  _Bit4_Enemy_Dead_Flag{4} then goto __Skip_Melody

	LDA _Bit1_Jumping_Flag
	AND #2
	BEQ .skipL01397
.condpart644
 jmp .condpart645
.skipL01397
	LDA _Bit4_Enemy_Dead_Flag
	AND #16
	BEQ .skip168OR
.condpart645
 jmp .__Skip_Melody

.skip168OR
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01398 ;  AUDV0  =  temp4

	LDA temp4
	STA AUDV0
.L01399 ;  AUDC0  =  temp5

	LDA temp5
	STA AUDC0
.L01400 ;  AUDF0  =  temp6

	LDA temp6
	STA AUDF0
.
 ; 

.__Skip_Melody
 ; __Skip_Melody

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01401 ;  temp4  =  sread ( _OWMusicData ) 

	ldx #_OWMusicData
	lda (0,x)
	inc 0,x
	bne *+4
	inc 1,x
	STA temp4
.L01402 ;  temp5  =  sread ( _OWMusicData ) 

	ldx #_OWMusicData
	lda (0,x)
	inc 0,x
	bne *+4
	inc 1,x
	STA temp5
.L01403 ;  temp6  =  sread ( _OWMusicData ) 

	ldx #_OWMusicData
	lda (0,x)
	inc 0,x
	bne *+4
	inc 1,x
	STA temp6
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01404 ;  AUDV1  =  temp4

	LDA temp4
	STA AUDV1
.L01405 ;  AUDC1  =  temp5

	LDA temp5
	STA AUDC1
.L01406 ;  AUDF1  =  temp6

	LDA temp6
	STA AUDF1
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01407 ;  _Music_Duration  =  sread ( _OWMusicData ) 

	ldx #_OWMusicData
	lda (0,x)
	inc 0,x
	bne *+4
	inc 1,x
	STA _Music_Duration
.
 ; 

.L01408 ;  goto __Got_Music bank3

 sta temp7
 lda #>(.__Got_Music-1)
 pha
 lda #<(.__Got_Music-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #3
 jmp BS_jsr
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__OW_Music
 ; __OW_Music

.L01409 ;  sdata _OWMusicData = q

	lda #<_OWMusicData_begin
	sta q
	lda #>_OWMusicData_begin
	sta q+1
	JMP .skipL01409
_OWMusicData_begin
	.byte  8,4,23

	.byte  4,6,13

	.byte  2

	.byte  2,4,23

	.byte  1,6,13

	.byte  1

	.byte  8,4,23

	.byte  4,6,13

	.byte  3

	.byte  2,4,23

	.byte  1,6,13

	.byte  3

	.byte  8,4,23

	.byte  4,6,13

	.byte  3 

	.byte  2,4,23

	.byte  1,6,13

	.byte  3

	.byte  8,4,29

	.byte  4,6,13

	.byte  3

	.byte  8,4,23

	.byte  4,6,13

	.byte  3

	.byte  2,4,23

	.byte  1,6,13

	.byte  3

	.byte  8,4,19

	.byte  4,6,20

	.byte  3

	.byte  2,4,19

	.byte  1,6,20

	.byte  3

	.byte  0,0,0

	.byte  0,0,0

	.byte  6

	.byte  8,12,26

	.byte  4,6,20

	.byte  3

	.byte  2,12,26

	.byte  1,6,20

	.byte  3

	.byte  0,0,0

	.byte  0,0,0

	.byte  6

	.byte  8,4,14

	.byte  4,12,26

	.byte  3

	.byte  4,4,14

	.byte  2,12,26

	.byte  3

	.byte  0,0,0

	.byte  0,0,0

	.byte  3

	.byte  8,4,19

	.byte  4,12,31

	.byte  3

	.byte  4,4,19

	.byte  2,12,31

	.byte  3

	.byte  0,0,0

	.byte  0,0,0

	.byte  3

	.byte  8,4,23

	.byte  4,1,15

	.byte  3

	.byte  4,4,23

	.byte  2,1,15

	.byte  3

	.byte  0,0,0

	.byte  0,0,0

	.byte  3

	.byte  8,4,17

	.byte  4,12,29

	.byte  3

	.byte  4,4,17

	.byte  2,12,29

	.byte  3

	.byte  8,4,15

	.byte  4,12,26

	.byte  3

	.byte  4,4,15

	.byte  2,12,26

	.byte  3

	.byte  8,4,16

	.byte  4,12,27

	.byte  3

	.byte  8,4,17

	.byte  4,12,29

	.byte  3

	.byte  4,4,17

	.byte  2,12,29

	.byte  3

	.byte  8,4,19

	.byte  4,12,31

	.byte  4

	.byte  8,4,23

	.byte  4,12,19

	.byte  4

	.byte  8,4,19

	.byte  4,12,15

	.byte  4

	.byte  8,4,17

	.byte  4,12,14

	.byte  3

	.byte  4,4,17

	.byte  2,12,14

	.byte  3

	.byte  8,4,21

	.byte  4,12,17

	.byte  3

	.byte  8,4,19

	.byte  4,12,15

	.byte  3

	.byte  4,4,19

	.byte  2,12,15

	.byte  3

	.byte  8,4,23

	.byte  4,12,11

	.byte  3

	.byte  4,4,23

	.byte  2,12,11

	.byte  3

	.byte  8,4,29

	.byte  4,12,23

	.byte  3

	.byte  8,4,26

	.byte  4,12,20

	.byte  3

	.byte  8,4,31

	.byte  4,12,26

	.byte  3

	.byte  4,4,31

	.byte  2,12,26

	.byte  3

	.byte  0,0,0

	.byte  0,0,0

	.byte  3

	.byte  8,4,29

	.byte  4,12,26

	.byte  3

	.byte  4,4,29

	.byte  2,12,26

	.byte  3

	.byte  0,0,0

	.byte  0,0,0

	.byte  3

	.byte  8,4,19

	.byte  4,12,31

	.byte  3

	.byte  4,4,19

	.byte  2,12,31

	.byte  3

	.byte  0,0,0

	.byte  0,0,0

	.byte  3

	.byte  8,4,23

	.byte  4,1,15

	.byte  3

	.byte  4,4,23

	.byte  2,1,15

	.byte  3

	.byte  0,0,0

	.byte  0,0,0

	.byte  3

	.byte  8,4,17

	.byte  4,12,29

	.byte  3

	.byte  4,4,17

	.byte  2,12,29

	.byte  3

	.byte  8,4,15

	.byte  4,12,26

	.byte  3

	.byte  4,4,15

	.byte  2,12,26

	.byte  3

	.byte  8,4,16

	.byte  4,12,27

	.byte  3

	.byte  8,4,17

	.byte  4,12,29

	.byte  3

	.byte  4,4,17

	.byte  2,12,29

	.byte  3

	.byte  8,4,19

	.byte  4,12,31

	.byte  4

	.byte  8,4,23

	.byte  4,12,19

	.byte  4

	.byte  8,4,19

	.byte  4,12,15

	.byte  4

	.byte  8,4,17

	.byte  4,12,14

	.byte  3

	.byte  4,4,17

	.byte  2,12,14

	.byte  3

	.byte  8,4,21

	.byte  4,12,17

	.byte  3

	.byte  8,4,19

	.byte  4,12,15

	.byte  3

	.byte  4,4,19

	.byte  2,12,15

	.byte  3

	.byte  8,4,23

	.byte  4,12,11

	.byte  3

	.byte  4,4,23

	.byte  2,12,11

	.byte  3

	.byte  8,4,29

	.byte  4,12,23

	.byte  3

	.byte  8,4,26

	.byte  4,12,20

	.byte  3

	.byte  8,4,31

	.byte  4,12,26

	.byte  3

	.byte  4,4,31

	.byte  2,12,26

	.byte  3

	.byte  0,0,0

	.byte  4,1,31

	.byte  3

	.byte  0,0,0

	.byte  2,1,31

	.byte  3

	.byte  8,4,19

	.byte  4,4,23

	.byte  3

	.byte  8,4,20

	.byte  4,12,31

	.byte  3

	.byte  8,4,21

	.byte  4,4,26

	.byte  3

	.byte  8,4,24

	.byte  4,4,31

	.byte  3

	.byte  4,4,24

	.byte  4,12,19

	.byte  3

	.byte  8,4,23

	.byte  2,12,19

	.byte  3

	.byte  4,4,23

	.byte  4,12,29

	.byte  3

	.byte  4,1,4

	.byte  2,12,29

	.byte  3

	.byte  8,12,11

	.byte  4,12,14

	.byte  3

	.byte  8,4,29

	.byte  4,12,19

	.byte  3

	.byte  4,4,29

	.byte  4,12,19

	.byte  3

	.byte  8,12,11

	.byte  4,12,19

	.byte  3

	.byte  8,4,29

	.byte  4,12,29

	.byte  3

	.byte  8,4,26

	.byte  4,12,29

	.byte  3

	.byte  0,0,0

	.byte  4,1,31

	.byte  3

	.byte  0,0,0

	.byte  2,1,31

	.byte  3

	.byte  8,4,19

	.byte  4,4,23

	.byte  3

	.byte  8,4,20

	.byte  4,12,31

	.byte  3

	.byte  8,4,21

	.byte  4,4,26

	.byte  3

	.byte  8,4,24

	.byte  4,4,31

	.byte  3

	.byte  4,4,24

	.byte  4,12,26

	.byte  3

	.byte  8,4,23

	.byte  4,12,19

	.byte  3

	.byte  4,4,23

	.byte  2,12,19

	.byte  3

	.byte  8,4,14

	.byte  8,4,21

	.byte  3

	.byte  4,4,14

	.byte  4,4,21

	.byte  3

	.byte  8,4,14

	.byte  8,4,21

	.byte  2

	.byte  4,4,14

	.byte  4,4,21

	.byte  1

	.byte  8,4,14

	.byte  8,4,21

	.byte  3

	.byte  4,4,14

	.byte  4,4,21

	.byte  3

	.byte  0,0,0

	.byte  4,12,26

	.byte  3

	.byte  0,0,0

	.byte  2,12,26

	.byte  3

	.byte  0,0,0

	.byte  4,1,31

	.byte  3

	.byte  0,0,0

	.byte  2,1,31

	.byte  3

	.byte  8,4,19

	.byte  4,4,23

	.byte  3

	.byte  8,4,20

	.byte  4,12,31

	.byte  3

	.byte  8,4,21

	.byte  4,4,26

	.byte  3

	.byte  8,4,24

	.byte  4,4,31

	.byte  3

	.byte  4,4,24

	.byte  4,12,19

	.byte  3

	.byte  8,4,23

	.byte  2,12,19

	.byte  3

	.byte  4,4,23

	.byte  4,12,29

	.byte  3

	.byte  4,1,4

	.byte  2,12,29

	.byte  3

	.byte  8,12,11

	.byte  4,12,14

	.byte  3

	.byte  8,4,29

	.byte  4,12,19

	.byte  3

	.byte  4,4,29

	.byte  4,12,19

	.byte  3

	.byte  8,12,11

	.byte  4,12,19

	.byte  3

	.byte  8,4,29

	.byte  4,12,29

	.byte  3

	.byte  8,4,26

	.byte  4,12,29

	.byte  3

	.byte  0,0,0

	.byte  4,1,31

	.byte  3

	.byte  0,0,0

	.byte  2,1,31

	.byte  3

	.byte  8,4,24

	.byte  4,1,19

	.byte  3

	.byte  4,4,24

	.byte  2,1,19

	.byte  3

	.byte  0,0,0

	.byte  0,0,0

	.byte  3

	.byte  8,4,26

	.byte  4,1,17

	.byte  3

	.byte  4,4,26

	.byte  2,1,17

	.byte  3

	.byte  0,0,0

	.byte  0,0,0

	.byte  3

	.byte  8,4,29

	.byte  4,1,15

	.byte  3

	.byte  4,4,29

	.byte  2,1,15

	.byte  3

	.byte  0,0,0

	.byte  0,0,0

	.byte  3

	.byte  0,0,0

	.byte  4,12,26

	.byte  2

	.byte  0,0,0

	.byte  2,12,26

	.byte  1

	.byte  0,0,0

	.byte  4,12,26

	.byte  3

	.byte  0,0,0

	.byte  2,12,26

	.byte  3

	.byte  0,0,0

	.byte  4,1,31

	.byte  3

	.byte  0,0,0

	.byte  2,1,31

	.byte  3

	.byte  0,0,0

	.byte  4,1,31

	.byte  3

	.byte  0,0,0

	.byte  2,1,31

	.byte  3

	.byte  8,4,19

	.byte  4,4,23

	.byte  3

	.byte  8,4,20

	.byte  4,12,31

	.byte  3

	.byte  8,4,21

	.byte  4,4,26

	.byte  3

	.byte  8,4,24

	.byte  4,4,31

	.byte  3

	.byte  4,4,24

	.byte  4,12,19

	.byte  3

	.byte  8,4,23

	.byte  2,12,19

	.byte  3

	.byte  4,4,23

	.byte  4,12,29

	.byte  3

	.byte  4,1,4

	.byte  2,12,29

	.byte  3

	.byte  8,12,11

	.byte  4,12,14

	.byte  3

	.byte  8,4,29

	.byte  4,12,19

	.byte  3

	.byte  4,4,29

	.byte  4,12,19

	.byte  3

	.byte  8,12,11

	.byte  4,12,19

	.byte  3

	.byte  8,4,29

	.byte  4,12,29

	.byte  3

	.byte  8,4,26

	.byte  4,12,29

	.byte  3

	.byte  0,0,0

	.byte  4,1,31

	.byte  3

	.byte  0,0,0

	.byte  2,1,31

	.byte  3

	.byte  8,4,19

	.byte  4,4,23

	.byte  3

	.byte  8,4,20

	.byte  4,12,31

	.byte  3

	.byte  8,4,21

	.byte  4,4,26

	.byte  3

	.byte  8,4,24

	.byte  4,4,31

	.byte  3

	.byte  4,4,24

	.byte  4,12,26

	.byte  3

	.byte  8,4,23

	.byte  4,12,19

	.byte  3

	.byte  4,4,23

	.byte  2,12,19

	.byte  3

	.byte  8,4,14

	.byte  8,4,21

	.byte  3

	.byte  4,4,14

	.byte  4,4,21

	.byte  3

	.byte  8,4,14

	.byte  8,4,21

	.byte  2

	.byte  4,4,14

	.byte  4,4,21

	.byte  1

	.byte  8,4,14

	.byte  8,4,21

	.byte  3

	.byte  4,4,14

	.byte  4,4,21

	.byte  3

	.byte  0,0,0

	.byte  4,12,26

	.byte  3

	.byte  0,0,0

	.byte  2,12,26

	.byte  3

	.byte  0,0,0

	.byte  4,1,31

	.byte  3

	.byte  0,0,0

	.byte  2,1,31

	.byte  3

	.byte  8,4,19

	.byte  4,4,23

	.byte  3

	.byte  8,4,20

	.byte  4,12,31

	.byte  3

	.byte  8,4,21

	.byte  4,4,26

	.byte  3

	.byte  8,4,24

	.byte  4,4,31

	.byte  3

	.byte  4,4,24

	.byte  4,12,19

	.byte  3

	.byte  8,4,23

	.byte  2,12,19

	.byte  3

	.byte  4,4,23

	.byte  4,12,29

	.byte  3

	.byte  4,1,4

	.byte  2,12,29

	.byte  3

	.byte  8,12,11

	.byte  4,12,14

	.byte  3

	.byte  8,4,29

	.byte  4,12,19

	.byte  3

	.byte  4,4,29

	.byte  4,12,19

	.byte  3

	.byte  8,12,11

	.byte  4,12,19

	.byte  3

	.byte  8,4,29

	.byte  4,12,29

	.byte  3

	.byte  8,4,26

	.byte  4,12,29

	.byte  3

	.byte  0,0,0

	.byte  4,1,31

	.byte  3

	.byte  0,0,0

	.byte  2,1,31

	.byte  3

	.byte  8,4,24

	.byte  4,1,19

	.byte  3

	.byte  4,4,24

	.byte  2,1,19

	.byte  3

	.byte  0,0,0

	.byte  0,0,0

	.byte  3

	.byte  8,4,26

	.byte  4,1,17

	.byte  3

	.byte  4,4,26

	.byte  2,1,17

	.byte  3

	.byte  0,0,0

	.byte  0,0,0

	.byte  3

	.byte  8,4,29

	.byte  4,1,15

	.byte  3

	.byte  4,4,29

	.byte  2,1,15

	.byte  3

	.byte  0,0,0

	.byte  0,0,0

	.byte  3

	.byte  0,0,0

	.byte  4,12,26

	.byte  2

	.byte  0,0,0

	.byte  2,12,26

	.byte  1

	.byte  0,0,0

	.byte  4,12,26

	.byte  3

	.byte  0,0,0

	.byte  2,12,26

	.byte  3

	.byte  0,0,0

	.byte  4,1,31

	.byte  3

	.byte  0,0,0

	.byte  2,1,31

	.byte  3

	.byte  8,4,29

	.byte  3,1,9

	.byte  2

	.byte  4,4,29

	.byte  1,1,9

	.byte  1

	.byte  8,4,29

	.byte  3,1,9

	.byte  3

	.byte  4,4,29

	.byte  1,1,9

	.byte  3

	.byte  8,4,29

	.byte  3,1,9

	.byte  3

	.byte  4,4,29

	.byte  1,1,9

	.byte  3

	.byte  8,4,29

	.byte  3,1,9

	.byte  3

	.byte  8,4,26

	.byte  4,12,24

	.byte  3

	.byte  4,4,26

	.byte  2,12,24

	.byte  3

	.byte  8,4,23

	.byte  4,12,26

	.byte  3

	.byte  8,4,29

	.byte  4,12,15

	.byte  3

	.byte  4,4,29

	.byte  2,12,15

	.byte  3

	.byte  8,12,11

	.byte  4,1,31

	.byte  3

	.byte  8,12,26

	.byte  4,12,19

	.byte  3

	.byte  4,12,26

	.byte  2,12,19

	.byte  3

	.byte  0,0,0

	.byte  4,6,20

	.byte  3

	.byte  0,0,0

	.byte  2,6,20

	.byte  3

	.byte  8,4,29

	.byte  3,1,9

	.byte  2

	.byte  4,4,29

	.byte  1,1,9

	.byte  1

	.byte  8,4,29

	.byte  3,1,9

	.byte  3

	.byte  4,4,29

	.byte  1,1,9

	.byte  3

	.byte  8,4,29

	.byte  3,1,9

	.byte  3

	.byte  4,4,29

	.byte  1,1,9

	.byte  3

	.byte  8,4,29

	.byte  3,1,9

	.byte  3

	.byte  8,4,26

	.byte  4,12,24

	.byte  3

	.byte  4,4,23

	.byte  4,12,26

	.byte  3

	.byte  0,0,0

	.byte  2,12,26

	.byte  3

	.byte  0,0,0

	.byte  0,0,0

	.byte  3

	.byte  0,0,0

	.byte  4,1,31

	.byte  3

	.byte  0,0,0

	.byte  2,1,31

	.byte  3

	.byte  0,0,0

	.byte  0,0,0

	.byte  3

	.byte  0,0,0

	.byte  4,6,20

	.byte  3

	.byte  0,0,0

	.byte  2,6,20

	.byte  3

	.byte  8,4,29

	.byte  3,1,9

	.byte  2

	.byte  4,4,29

	.byte  1,1,9

	.byte  1

	.byte  8,4,29

	.byte  3,1,9

	.byte  3

	.byte  4,4,29

	.byte  1,1,9

	.byte  3

	.byte  8,4,29

	.byte  3,1,9

	.byte  3

	.byte  4,4,29

	.byte  1,1,9

	.byte  3

	.byte  8,4,29

	.byte  3,1,9

	.byte  3

	.byte  8,4,26

	.byte  4,12,24

	.byte  3

	.byte  4,4,26

	.byte  2,12,24

	.byte  3

	.byte  8,4,23

	.byte  4,12,26

	.byte  3

	.byte  8,4,29

	.byte  4,12,15

	.byte  3

	.byte  4,4,29

	.byte  2,12,15

	.byte  3

	.byte  8,12,11

	.byte  4,1,31

	.byte  3

	.byte  8,12,26

	.byte  4,12,19

	.byte  3

	.byte  4,12,26

	.byte  2,12,19

	.byte  3

	.byte  0,0,0

	.byte  4,6,20

	.byte  3

	.byte  0,0,0

	.byte  2,6,20

	.byte  3

	.byte  255

.skipL01409
.L01410 ;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Get_Star_Music
 ; __Get_Star_Music

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01411 ;  _Music_Duration  =  _Music_Duration  -  1

	DEC _Music_Duration
.
 ; 

.L01412 ;  if _Music_Duration  >  0 then goto __Got_Music bank3

	LDA #0
	CMP _Music_Duration
     BCS .skipL01412
.condpart646
 sta temp7
 lda #>(.__Got_Music-1)
 pha
 lda #<(.__Got_Music-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #3
 jmp BS_jsr
.skipL01412
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01413 ;  temp4  =  sread ( _StarPowerMusicData ) 

	ldx #_StarPowerMusicData
	lda (0,x)
	inc 0,x
	bne *+4
	inc 1,x
	STA temp4
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01414 ;  if temp4  =  255 then _Music_Duration  =  1  :  gosub __Star_Power_Music  :  goto __Get_Star_Music

	LDA temp4
	CMP #255
     BNE .skipL01414
.condpart647
	LDA #1
	STA _Music_Duration
 jsr .__Star_Power_Music
 jmp .__Get_Star_Music

.skipL01414
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01415 ;  temp5  =  sread ( _StarPowerMusicData ) 

	ldx #_StarPowerMusicData
	lda (0,x)
	inc 0,x
	bne *+4
	inc 1,x
	STA temp5
.L01416 ;  temp6  =  sread ( _StarPowerMusicData ) 

	ldx #_StarPowerMusicData
	lda (0,x)
	inc 0,x
	bne *+4
	inc 1,x
	STA temp6
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01417 ;  if _Bit1_Jumping_Flag{1}  ||  _Bit4_Enemy_Dead_Flag{4} then goto __Skip_Star_Melody

	LDA _Bit1_Jumping_Flag
	AND #2
	BEQ .skipL01417
.condpart648
 jmp .condpart649
.skipL01417
	LDA _Bit4_Enemy_Dead_Flag
	AND #16
	BEQ .skip169OR
.condpart649
 jmp .__Skip_Star_Melody

.skip169OR
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01418 ;  AUDV0  =  temp4

	LDA temp4
	STA AUDV0
.L01419 ;  AUDC0  =  temp5

	LDA temp5
	STA AUDC0
.L01420 ;  AUDF0  =  temp6

	LDA temp6
	STA AUDF0
.
 ; 

.__Skip_Star_Melody
 ; __Skip_Star_Melody

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01421 ;  temp4  =  sread ( _StarPowerMusicData ) 

	ldx #_StarPowerMusicData
	lda (0,x)
	inc 0,x
	bne *+4
	inc 1,x
	STA temp4
.L01422 ;  temp5  =  sread ( _StarPowerMusicData ) 

	ldx #_StarPowerMusicData
	lda (0,x)
	inc 0,x
	bne *+4
	inc 1,x
	STA temp5
.L01423 ;  temp6  =  sread ( _StarPowerMusicData ) 

	ldx #_StarPowerMusicData
	lda (0,x)
	inc 0,x
	bne *+4
	inc 1,x
	STA temp6
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01424 ;  AUDV1  =  temp4

	LDA temp4
	STA AUDV1
.L01425 ;  AUDC1  =  temp5

	LDA temp5
	STA AUDC1
.L01426 ;  AUDF1  =  temp6

	LDA temp6
	STA AUDF1
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01427 ;  _Music_Duration  =  sread ( _StarPowerMusicData ) 

	ldx #_StarPowerMusicData
	lda (0,x)
	inc 0,x
	bne *+4
	inc 1,x
	STA _Music_Duration
.
 ; 

.L01428 ;  goto __Got_Music bank3

 sta temp7
 lda #>(.__Got_Music-1)
 pha
 lda #<(.__Got_Music-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #3
 jmp BS_jsr
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Star_Power_Music
 ; __Star_Power_Music

.L01429 ;  sdata _StarPowerMusicData = q

	lda #<_StarPowerMusicData_begin
	sta q
	lda #>_StarPowerMusicData_begin
	sta q+1
	JMP .skipL01429
_StarPowerMusicData_begin
	.byte  8,4,29

	.byte  4,1,28

	.byte  3

	.byte  4,4,29

	.byte  2,1,28

	.byte  1

	.byte  8,4,29

	.byte  4,12,14

	.byte  3

	.byte  4,4,29

	.byte  2,12,14

	.byte  1

	.byte  8,4,29

	.byte  4,12,23

	.byte  3

	.byte  4,4,29

	.byte  2,12,23

	.byte  1

	.byte  8,12,17

	.byte  0,0,0

	.byte  2

	.byte  8,4,29

	.byte  4,12,17

	.byte  2

	.byte  0,0,0

	.byte  0,0,0

	.byte  2

	.byte  8,4,29

	.byte  4,12,14

	.byte  3

	.byte  4,4,29

	.byte  2,12,14

	.byte  1

	.byte  8,12,17

	.byte  0,0,0

	.byte  2

	.byte  8,4,29

	.byte  4,12,23

	.byte  2

	.byte  8,12,17

	.byte  4,12,23

	.byte  2

	.byte  8,4,29

	.byte  4,12,17

	.byte  3

	.byte  4,4,29

	.byte  4,12,17

	.byte  1

	.byte  8,4,31

	.byte  4,1,31

	.byte  3

	.byte  4,4,29

	.byte  2,1,31

	.byte  1

	.byte  8,4,31

	.byte  4,12,15

	.byte  3

	.byte  4,4,31

	.byte  2,12,15

	.byte  1

	.byte  8,4,31

	.byte  4,12,26

	.byte  3

	.byte  4,4,31

	.byte  2,12,26

	.byte  1

	.byte  8,12,19

	.byte  0,0,0

	.byte  2

	.byte  8,4,31

	.byte  4,12,19

	.byte  2

	.byte  0,0,0

	.byte  0,0,0

	.byte  2

	.byte  8,4,31

	.byte  4,12,15

	.byte  3

	.byte  4,4,31

	.byte  2,12,15

	.byte  1

	.byte  8,12,19

	.byte  0,0,0

	.byte  2

	.byte  8,4,31

	.byte  4,12,26

	.byte  2

	.byte  8,12,19

	.byte  4,12,26

	.byte  2

	.byte  8,4,31

	.byte  4,12,19

	.byte  2

	.byte  8,4,31

	.byte  4,12,19

	.byte  3

	.byte  255

.skipL01429
.L01430 ;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Get_UW_Music
 ; __Get_UW_Music

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01431 ;  _Music_Duration  =  _Music_Duration  -  1

	DEC _Music_Duration
.L01432 ;  if _Music_Duration  =  7  ||  _Music_Duration  =  12 then AUDV0  =  0  :  AUDV1  =  0  :  goto __Got_Music bank3

	LDA _Music_Duration
	CMP #7
     BNE .skipL01432
.condpart650
 jmp .condpart651
.skipL01432
	LDA _Music_Duration
	CMP #12
     BNE .skip170OR
.condpart651
	LDA #0
	STA AUDV0
	STA AUDV1
 sta temp7
 lda #>(.__Got_Music-1)
 pha
 lda #<(.__Got_Music-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #3
 jmp BS_jsr
.skip170OR
.L01433 ;  if _Music_Duration  =  17  ||  _Music_Duration  =  22 then AUDV0  =  0  :  AUDV1  =  0  :  goto __Got_Music bank3

	LDA _Music_Duration
	CMP #17
     BNE .skipL01433
.condpart652
 jmp .condpart653
.skipL01433
	LDA _Music_Duration
	CMP #22
     BNE .skip171OR
.condpart653
	LDA #0
	STA AUDV0
	STA AUDV1
 sta temp7
 lda #>(.__Got_Music-1)
 pha
 lda #<(.__Got_Music-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #3
 jmp BS_jsr
.skip171OR
.L01434 ;  if _Music_Duration  =  27  ||  _Music_Duration  =  31 then AUDV0  =  0  :  AUDV1  =  0  :  goto __Got_Music bank3

	LDA _Music_Duration
	CMP #27
     BNE .skipL01434
.condpart654
 jmp .condpart655
.skipL01434
	LDA _Music_Duration
	CMP #31
     BNE .skip172OR
.condpart655
	LDA #0
	STA AUDV0
	STA AUDV1
 sta temp7
 lda #>(.__Got_Music-1)
 pha
 lda #<(.__Got_Music-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #3
 jmp BS_jsr
.skip172OR
.L01435 ;  if _Music_Duration  >  0 then goto __Got_Music bank3

	LDA #0
	CMP _Music_Duration
     BCS .skipL01435
.condpart656
 sta temp7
 lda #>(.__Got_Music-1)
 pha
 lda #<(.__Got_Music-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #3
 jmp BS_jsr
.skipL01435
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01436 ;  temp4  =  sread ( _UWMusicData ) 

	ldx #_UWMusicData
	lda (0,x)
	inc 0,x
	bne *+4
	inc 1,x
	STA temp4
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01437 ;  if temp4  =  255 then _Music_Duration  =  1  :  gosub __UW_Music  :  goto __Get_UW_Music

	LDA temp4
	CMP #255
     BNE .skipL01437
.condpart657
	LDA #1
	STA _Music_Duration
 jsr .__UW_Music
 jmp .__Get_UW_Music

.skipL01437
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01438 ;  temp5  =  sread ( _UWMusicData ) 

	ldx #_UWMusicData
	lda (0,x)
	inc 0,x
	bne *+4
	inc 1,x
	STA temp5
.L01439 ;  temp6  =  sread ( _UWMusicData ) 

	ldx #_UWMusicData
	lda (0,x)
	inc 0,x
	bne *+4
	inc 1,x
	STA temp6
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01440 ;  if _Bit1_Jumping_Flag{1}  ||  _Bit4_Enemy_Dead_Flag{4} then goto __Skip_UW_Melody

	LDA _Bit1_Jumping_Flag
	AND #2
	BEQ .skipL01440
.condpart658
 jmp .condpart659
.skipL01440
	LDA _Bit4_Enemy_Dead_Flag
	AND #16
	BEQ .skip173OR
.condpart659
 jmp .__Skip_UW_Melody

.skip173OR
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01441 ;  AUDV0  =  temp4

	LDA temp4
	STA AUDV0
.L01442 ;  AUDC0  =  temp5

	LDA temp5
	STA AUDC0
.L01443 ;  AUDF0  =  temp6

	LDA temp6
	STA AUDF0
.
 ; 

.__Skip_UW_Melody
 ; __Skip_UW_Melody

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01444 ;  temp4  =  sread ( _UWMusicData ) 

	ldx #_UWMusicData
	lda (0,x)
	inc 0,x
	bne *+4
	inc 1,x
	STA temp4
.L01445 ;  temp5  =  sread ( _UWMusicData ) 

	ldx #_UWMusicData
	lda (0,x)
	inc 0,x
	bne *+4
	inc 1,x
	STA temp5
.L01446 ;  temp6  =  sread ( _UWMusicData ) 

	ldx #_UWMusicData
	lda (0,x)
	inc 0,x
	bne *+4
	inc 1,x
	STA temp6
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01447 ;  AUDV1  =  temp4

	LDA temp4
	STA AUDV1
.L01448 ;  AUDC1  =  temp5

	LDA temp5
	STA AUDC1
.L01449 ;  AUDF1  =  temp6

	LDA temp6
	STA AUDF1
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01450 ;  _Music_Duration  =  sread ( _UWMusicData ) 

	ldx #_UWMusicData
	lda (0,x)
	inc 0,x
	bne *+4
	inc 1,x
	STA _Music_Duration
.
 ; 

.L01451 ;  goto __Got_Music bank3

 sta temp7
 lda #>(.__Got_Music-1)
 pha
 lda #<(.__Got_Music-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #3
 jmp BS_jsr
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__UW_Music
 ; __UW_Music

.L01452 ;  sdata _UWMusicData = q

	lda #<_UWMusicData_begin
	sta q
	lda #>_UWMusicData_begin
	sta q+1
	JMP .skipL01452
_UWMusicData_begin
	.byte  0,0,0

	.byte  8,1,15

	.byte  3

	.byte  0,0,0

	.byte  8,12,19

	.byte  3

	.byte  0,0,0

	.byte  8,1,18

	.byte  3

	.byte  0,0,0

	.byte  8,12,23

	.byte  3

	.byte  0,0,0

	.byte  8,1,17

	.byte  3

	.byte  0,0,0

	.byte  8,1,8

	.byte  3

	.byte  0,0,0

	.byte  0,0,0

	.byte  18

	.byte  0,0,0

	.byte  8,1,15

	.byte  3

	.byte  0,0,0

	.byte  8,12,19

	.byte  3

	.byte  0,0,0

	.byte  8,1,18

	.byte  3

	.byte  0,0,0

	.byte  8,12,23

	.byte  3

	.byte  0,0,0

	.byte  8,1,17

	.byte  3

	.byte  0,0,0

	.byte  8,1,8

	.byte  3

	.byte  0,0,0

	.byte  0,0,0

	.byte  18

	.byte  0,0,0

	.byte  8,1,23

	.byte  3

	.byte  0,0,0

	.byte  8,12,29

	.byte  3

	.byte  0,0,0

	.byte  8,1,28

	.byte  3

	.byte  0,0,0

	.byte  8,6,13

	.byte  3

	.byte  0,0,0

	.byte  8,1,26

	.byte  3

	.byte  0,0,0

	.byte  8,6,12

	.byte  3

	.byte  0,0,0

	.byte  0,0,0

	.byte  18

	.byte  0,0,0

	.byte  8,1,23

	.byte  3

	.byte  0,0,0

	.byte  8,12,29

	.byte  3

	.byte  0,0,0

	.byte  8,1,28

	.byte  3

	.byte  0,0,0

	.byte  8,6,13

	.byte  3

	.byte  0,0,0

	.byte  8,1,26

	.byte  3

	.byte  0,0,0

	.byte  8,6,12

	.byte  3

	.byte  0,0,0

	.byte  0,0,0

	.byte  12

	.byte  0,0,0

	.byte  8,1,26

	.byte  2

	.byte  0,0,0

	.byte  8,1,28

	.byte  2

	.byte  0,0,0

	.byte  8,1,29

	.byte  2

	.byte  0,0,0

	.byte  8,1,31

	.byte  6

	.byte  0,0,0

	.byte  8,1,26

	.byte  6

	.byte  0,0,0

	.byte  8,1,28

	.byte  6

	.byte  0,0,0

	.byte  8,1,19

	.byte  6

	.byte  0,0,0

	.byte  8,7,20

	.byte  6

	.byte  0,0,0

	.byte  8,1,29

	.byte  6

	.byte  0,0,0

	.byte  8,1,31

	.byte  2

	.byte  0,0,0

	.byte  8,1,19

	.byte  2

	.byte  0,0,0

	.byte  8,1,23

	.byte  2

	.byte  0,0,0

	.byte  8,6,24

	.byte  2

	.byte  0,0,0

	.byte  8,1,17

	.byte  2

	.byte  0,0,0

	.byte  8,1,18

	.byte  2

	.byte  0,0,0

	.byte  8,1,19

	.byte  4

	.byte  0,0,0

	.byte  8,1,26

	.byte  4

	.byte  0,0,0

	.byte  8,14,10

	.byte  4

	.byte  0,0,0

	.byte  8,14,12

	.byte  4

	.byte  0,0,0

	.byte  8,14,14

	.byte  4

	.byte  0,0,0

	.byte  8,14,16

	.byte  4

	.byte  0,0,0

	.byte  0,0,0

	.byte  36

	.byte  255

.skipL01452
.L01453 ;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ; 

.__Play_FF_Music
 ; __Play_FF_Music

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01454 ;  _Music_Duration  =  _Music_Duration  -  1

	DEC _Music_Duration
.
 ; 

.L01455 ;  if _Music_Duration  >  0 then goto __Got_FF_Music

	LDA #0
	CMP _Music_Duration
     BCS .skipL01455
.condpart660
 jmp .__Got_FF_Music

.skipL01455
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01456 ;  temp4  =  sread ( _FanFareMusicData ) 

	ldx #_FanFareMusicData
	lda (0,x)
	inc 0,x
	bne *+4
	inc 1,x
	STA temp4
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01457 ;  if temp4  =  255 then _Music_Duration  =  255  :  goto __Got_FF_Music

	LDA temp4
	CMP #255
     BNE .skipL01457
.condpart661
	LDA #255
	STA _Music_Duration
 jmp .__Got_FF_Music

.skipL01457
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01458 ;  temp5  =  sread ( _FanFareMusicData ) 

	ldx #_FanFareMusicData
	lda (0,x)
	inc 0,x
	bne *+4
	inc 1,x
	STA temp5
.L01459 ;  temp6  =  sread ( _FanFareMusicData ) 

	ldx #_FanFareMusicData
	lda (0,x)
	inc 0,x
	bne *+4
	inc 1,x
	STA temp6
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01460 ;  AUDV0  =  temp4

	LDA temp4
	STA AUDV0
.L01461 ;  AUDC0  =  temp5

	LDA temp5
	STA AUDC0
.L01462 ;  AUDF0  =  temp6

	LDA temp6
	STA AUDF0
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01463 ;  temp4  =  sread ( _FanFareMusicData ) 

	ldx #_FanFareMusicData
	lda (0,x)
	inc 0,x
	bne *+4
	inc 1,x
	STA temp4
.L01464 ;  temp5  =  sread ( _FanFareMusicData ) 

	ldx #_FanFareMusicData
	lda (0,x)
	inc 0,x
	bne *+4
	inc 1,x
	STA temp5
.L01465 ;  temp6  =  sread ( _FanFareMusicData ) 

	ldx #_FanFareMusicData
	lda (0,x)
	inc 0,x
	bne *+4
	inc 1,x
	STA temp6
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01466 ;  AUDV1  =  temp4

	LDA temp4
	STA AUDV1
.L01467 ;  AUDC1  =  temp5

	LDA temp5
	STA AUDC1
.L01468 ;  AUDF1  =  temp6

	LDA temp6
	STA AUDF1
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01469 ;  _Music_Duration  =  sread ( _FanFareMusicData ) 

	ldx #_FanFareMusicData
	lda (0,x)
	inc 0,x
	bne *+4
	inc 1,x
	STA _Music_Duration
.
 ; 

.__Got_FF_Music
 ; __Got_FF_Music

.
 ; 

.L01470 ;  return otherbank

	JMP BS_return
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Fanfare_Music
 ; __Fanfare_Music

.L01471 ;  sdata _FanFareMusicData = q

	lda #<_FanFareMusicData_begin
	sta q
	lda #>_FanFareMusicData_begin
	sta q+1
	JMP .skipL01471
_FanFareMusicData_begin
	.byte  8,12,26

	.byte  4,12,26

	.byte  4

	.byte  8,12,19

	.byte  4,12,31

	.byte  4

	.byte  8,12,15

	.byte  4,12,26

	.byte  4

	.byte  8,4,19

	.byte  3,1,31

	.byte  4

	.byte  8,4,29

	.byte  4,12,31

	.byte  4

	.byte  8,4,23

	.byte  4,12,26

	.byte  4

	.byte  8,4,19

	.byte  4,12,15

	.byte  12

	.byte  8,4,23

	.byte  4,12,19

	.byte  12

	.byte  8,12,24

	.byte  4,12,24

	.byte  4

	.byte  8,12,19

	.byte  3,1,26

	.byte  4

	.byte  8,12,16

	.byte  4,12,24

	.byte  4

	.byte  6,1,4

	.byte  3,1,31

	.byte  4

	.byte  8,4,29

	.byte  3,1,26

	.byte  4

	.byte  8,4,24

	.byte  4,12,24

	.byte  4

	.byte  8,4,18

	.byte  4,12,16

	.byte  12

	.byte  8,4,24

	.byte  4,12,19

	.byte  12

	.byte  6,1,8

	.byte  0,0,0

	.byte  4

	.byte  8,12,17

	.byte  4,12,29

	.byte  4

	.byte  8,12,14

	.byte  3,1,8

	.byte  4

	.byte  6,1,8

	.byte  3,1,13

	.byte  4

	.byte  8,4,26

	.byte  4,12,29

	.byte  4

	.byte  8,4,21

	.byte  3,1,8

	.byte  4

	.byte  8,4,16

	.byte  4,12,14

	.byte  10

	.byte  4,4,16

	.byte  2,12,14

	.byte  2

	.byte  8,4,16

	.byte  4,12,17

	.byte  3

	.byte  4,4,16

	.byte  2,12,17

	.byte  1

	.byte  8,4,16

	.byte  4,12,17

	.byte  3

	.byte  4,4,16

	.byte  2,12,17

	.byte  1

	.byte  8,4,16

	.byte  4,12,17

	.byte  3

	.byte  4,4,16

	.byte  2,12,17

	.byte  1

	.byte  8,4,14

	.byte  4,12,15

	.byte  24

	.byte  0,0,0

	.byte  0,0,0

	.byte  12

	.byte  255

.skipL01471
.L01472 ;  return

	tsx
	lda 2,x ; check return address
	eor #(>*) ; vs. current PCH
	and #$E0 ;  mask off all but top 3 bits
	beq *+5 ; if equal, do normal return
	JMP BS_return
	RTS
.
 ; 

.__Play_Death_Music
 ; __Play_Death_Music

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01473 ;  _Music_Duration  =  _Music_Duration  -  1

	DEC _Music_Duration
.
 ; 

.L01474 ;  if _Music_Duration  >  0 then goto __Got_Death_Music

	LDA #0
	CMP _Music_Duration
     BCS .skipL01474
.condpart662
 jmp .__Got_Death_Music

.skipL01474
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01475 ;  temp4  =  sread ( _DeathMusicData ) 

	ldx #_DeathMusicData
	lda (0,x)
	inc 0,x
	bne *+4
	inc 1,x
	STA temp4
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01476 ;  if temp4  =  255 then _Music_Duration  =  255  :  goto __Got_Death_Music

	LDA temp4
	CMP #255
     BNE .skipL01476
.condpart663
	LDA #255
	STA _Music_Duration
 jmp .__Got_Death_Music

.skipL01476
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01477 ;  temp5  =  sread ( _DeathMusicData ) 

	ldx #_DeathMusicData
	lda (0,x)
	inc 0,x
	bne *+4
	inc 1,x
	STA temp5
.L01478 ;  temp6  =  sread ( _DeathMusicData ) 

	ldx #_DeathMusicData
	lda (0,x)
	inc 0,x
	bne *+4
	inc 1,x
	STA temp6
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01479 ;  AUDV0  =  temp4

	LDA temp4
	STA AUDV0
.L01480 ;  AUDC0  =  temp5

	LDA temp5
	STA AUDC0
.L01481 ;  AUDF0  =  temp6

	LDA temp6
	STA AUDF0
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01482 ;  temp4  =  sread ( _DeathMusicData ) 

	ldx #_DeathMusicData
	lda (0,x)
	inc 0,x
	bne *+4
	inc 1,x
	STA temp4
.L01483 ;  temp5  =  sread ( _DeathMusicData ) 

	ldx #_DeathMusicData
	lda (0,x)
	inc 0,x
	bne *+4
	inc 1,x
	STA temp5
.L01484 ;  temp6  =  sread ( _DeathMusicData ) 

	ldx #_DeathMusicData
	lda (0,x)
	inc 0,x
	bne *+4
	inc 1,x
	STA temp6
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01485 ;  AUDV1  =  temp4

	LDA temp4
	STA AUDV1
.L01486 ;  AUDC1  =  temp5

	LDA temp5
	STA AUDC1
.L01487 ;  AUDF1  =  temp6

	LDA temp6
	STA AUDF1
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01488 ;  _Music_Duration  =  sread ( _DeathMusicData ) 

	ldx #_DeathMusicData
	lda (0,x)
	inc 0,x
	bne *+4
	inc 1,x
	STA _Music_Duration
.
 ; 

.__Got_Death_Music
 ; __Got_Death_Music

.
 ; 

.L01489 ;  return otherbank

	JMP BS_return
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Death_Music
 ; __Death_Music

.L01490 ;  sdata _DeathMusicData = q

	lda #<_DeathMusicData_begin
	sta q
	lda #>_DeathMusicData_begin
	sta q+1
	JMP .skipL01490
_DeathMusicData_begin
	.byte  8,4,29

	.byte  0,0,0

	.byte  1

	.byte  8,4,27

	.byte  0,0,0

	.byte  1

	.byte  8,4,26

	.byte  0,0,0

	.byte  1

	.byte  0,0,0

	.byte  0,0,0

	.byte  9

	.byte  8,4,31

	.byte  4,12,26

	.byte  3

	.byte  8,4,21

	.byte  4,4,26

	.byte  3

	.byte  4,4,21

	.byte  2,4,26

	.byte  3

	.byte  8,4,21

	.byte  4,12,26

	.byte  2

	.byte  4,4,21

	.byte  2,12,26

	.byte  1

	.byte  8,4,21

	.byte  4,12,26

	.byte  4

	.byte  8,4,23

	.byte  4,12,23

	.byte  4

	.byte  8,4,26

	.byte  4,12,20

	.byte  4

	.byte  8,4,29

	.byte  4,12,19

	.byte  3

	.byte  8,12,15

	.byte  2,12,19

	.byte  3

	.byte  4,12,15

	.byte  4,12,26

	.byte  3

	.byte  8,12,15

	.byte  2,12,26

	.byte  3

	.byte  8,12,19

	.byte  4,1,31

	.byte  3

	.byte  4,12,19

	.byte  2,1,31

	.byte  3

	.byte  0,0,0

	.byte  0,0,0

	.byte  9

	.byte  255

.skipL01490
.L01491 ;  return otherbank

	JMP BS_return
.
 ; 

.__Play_Final_Music
 ; __Play_Final_Music

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01492 ;  _Music_Duration  =  _Music_Duration  -  1

	DEC _Music_Duration
.
 ; 

.L01493 ;  if _Music_Duration  >  0 then goto __Got_Final_Music

	LDA #0
	CMP _Music_Duration
     BCS .skipL01493
.condpart664
 jmp .__Got_Final_Music

.skipL01493
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01494 ;  temp4  =  sread ( _FinalMusicData ) 

	ldx #_FinalMusicData
	lda (0,x)
	inc 0,x
	bne *+4
	inc 1,x
	STA temp4
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01495 ;  if temp4  =  255 then _Music_Duration  =  255  :  goto __Got_Final_Music

	LDA temp4
	CMP #255
     BNE .skipL01495
.condpart665
	LDA #255
	STA _Music_Duration
 jmp .__Got_Final_Music

.skipL01495
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01496 ;  temp5  =  sread ( _FinalMusicData ) 

	ldx #_FinalMusicData
	lda (0,x)
	inc 0,x
	bne *+4
	inc 1,x
	STA temp5
.L01497 ;  temp6  =  sread ( _FinalMusicData ) 

	ldx #_FinalMusicData
	lda (0,x)
	inc 0,x
	bne *+4
	inc 1,x
	STA temp6
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01498 ;  AUDV0  =  temp4

	LDA temp4
	STA AUDV0
.L01499 ;  AUDC0  =  temp5

	LDA temp5
	STA AUDC0
.L01500 ;  AUDF0  =  temp6

	LDA temp6
	STA AUDF0
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01501 ;  _Music_Duration  =  sread ( _FinalMusicData ) 

	ldx #_FinalMusicData
	lda (0,x)
	inc 0,x
	bne *+4
	inc 1,x
	STA _Music_Duration
.
 ; 

.__Got_Final_Music
 ; __Got_Final_Music

.
 ; 

.L01502 ;  return otherbank

	JMP BS_return
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Final_Music
 ; __Final_Music

.L01503 ;  sdata _FinalMusicData = q

	lda #<_FinalMusicData_begin
	sta q
	lda #>_FinalMusicData_begin
	sta q+1
	JMP .skipL01503
_FinalMusicData_begin
	.byte  8,12,29

	.byte  4

	.byte  8,12,17

	.byte  4

	.byte  8,12,19

	.byte  4

	.byte  8,12,29

	.byte  4

	.byte  8,12,17

	.byte  4

	.byte  8,12,19

	.byte  4

	.byte  8,12,29

	.byte  4

	.byte  8,12,17

	.byte  4

	.byte  8,12,19

	.byte  2

	.byte  7,12,19

	.byte  2

	.byte  6,12,19

	.byte  2

	.byte  5,12,19

	.byte  2

	.byte  4,12,19

	.byte  2

	.byte  3,12,19

	.byte  2

	.byte  2,12,19

	.byte  2

	.byte  1,12,19

	.byte  2

	.byte  0,0,0

	.byte  2

	.byte  255

.skipL01503
.L01504 ;  return otherbank

	JMP BS_return
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01505 ;  bank 8

 if ECHO7
 echo "    ",[(start_bank7 - *)]d , "bytes of ROM space left in bank 7")
 endif
ECHO7 = 1
 ORG $7FF4-bscode_length
 RORG $DFF4-bscode_length
start_bank7 ldx #$ff
 ifconst FASTFETCH ; using DPC+
 stx FASTFETCH
 endif 
 txs
 if bankswitch == 64
   lda #(((>(start-1)) & $0F) | $F0)
 else
   lda #>(start-1)
 endif
 pha
 lda #<(start-1)
 pha
 pha
 txa
 pha
 tsx
 if bankswitch != 64
   lda 4,x ; get high byte of return address
   rol
   rol
   rol
   rol
   and #bs_mask ;1 3 or 7 for F8/F6/F4
   tax
   inx
 else
   lda 4,x ; get high byte of return address
   tay
   ora #$10 ; change our bank nibble into a valid rom mirror
   sta 4,x
   tya
   lsr 
   lsr 
   lsr 
   lsr 
   tax
   inx
 endif
 lda bankswitch_hotspot-1,x
 pla
 tax
 pla
 rts
 if ((* & $1FFF) > ((bankswitch_hotspot & $1FFF) - 1))
   echo "WARNING: size parameter in banksw.asm too small - the program probably will not work."
   echo "Change to",[(*-begin_bscode+1)&$FF]d,"and try again."
 endif
 ORG $7FFC
 RORG $DFFC
 .word (start_bank7 & $ffff)
 .word (start_bank7 & $ffff)
 ORG $8000
 RORG $F000
; Provided under the CC0 license. See the included LICENSE.txt for details.

     ; This is a 2-line kernel!
     ifnconst vertical_reflect
kernel
     endif
     sta WSYNC
     lda #255
     sta TIM64T

     lda #1
     sta VDELBL
     sta VDELP0
     ldx ballheight
     inx
     inx
     stx temp4
     lda player1y
     sta temp3

     ifconst shakescreen
         jsr doshakescreen
     else
         ldx missile0height
         inx
     endif

     inx
     stx stack1

     lda bally
     sta stack2

     lda player0y
     ldx #0
     sta WSYNC
     stx GRP0
     stx GRP1
     stx PF1L
     stx PF2
     stx CXCLR
     ifconst readpaddle
         stx paddle
     else
         sleep 3
     endif

     sta temp2,x

     ;store these so they can be retrieved later
     ifnconst pfres
         ldx #128-44+(4-pfwidth)*12
     else
         ldx #132-pfres*pfwidth
     endif

     dec player0y

     lda missile0y
     sta temp5
     lda missile1y
     sta temp6

     lda playfieldpos
     sta temp1
     
     ifconst pfrowheight
         lda #pfrowheight+2
     else
         ifnconst pfres
             lda #10
         else
             lda #(96/pfres)+2 ; try to come close to the real size
         endif
     endif
     clc
     sbc playfieldpos
     sta playfieldpos
     jmp .startkernel

.skipDrawP0
     lda #0
     tay
     jmp .continueP0

.skipDrawP1
     lda #0
     tay
     jmp .continueP1

.kerloop     ; enter at cycle 59??

continuekernel
     sleep 2
continuekernel2
     lda ballheight
     
     ifconst pfres
         ldy playfield+pfres*pfwidth-132,x
         sty PF1L ;3
         ldy playfield+pfres*pfwidth-131-pfadjust,x
         sty PF2L ;3
         ldy playfield+pfres*pfwidth-129,x
         sty PF1R ; 3 too early?
         ldy playfield+pfres*pfwidth-130-pfadjust,x
         sty PF2R ;3
     else
         ldy playfield-48+pfwidth*12+44-128,x
         sty PF1L ;3
         ldy playfield-48+pfwidth*12+45-128-pfadjust,x ;4
         sty PF2L ;3
         ldy playfield-48+pfwidth*12+47-128,x ;4
         sty PF1R ; 3 too early?
         ldy playfield-48+pfwidth*12+46-128-pfadjust,x;4
         sty PF2R ;3
     endif

     ; should be playfield+$38 for width=2

     dcp bally
     rol
     rol
     ; rol
     ; rol
goback
     sta ENABL 
.startkernel
     lda player1height ;3
     dcp player1y ;5
     bcc .skipDrawP1 ;2
     ldy player1y ;3
     lda (player1pointer),y ;5; player0pointer must be selected carefully by the compiler
     ; so it doesn't cross a page boundary!

.continueP1
     sta GRP1 ;3

     ifnconst player1colors
         lda missile1height ;3
         dcp missile1y ;5
         rol;2
         rol;2
         sta ENAM1 ;3
     else
         lda (player1color),y
         sta COLUP1
         ifnconst playercolors
             sleep 7
         else
             lda.w player0colorstore
             sta COLUP0
         endif
     endif

     ifconst pfres
         lda playfield+pfres*pfwidth-132,x 
         sta PF1L ;3
         lda playfield+pfres*pfwidth-131-pfadjust,x 
         sta PF2L ;3
         lda playfield+pfres*pfwidth-129,x 
         sta PF1R ; 3 too early?
         lda playfield+pfres*pfwidth-130-pfadjust,x 
         sta PF2R ;3
     else
         lda playfield-48+pfwidth*12+44-128,x ;4
         sta PF1L ;3
         lda playfield-48+pfwidth*12+45-128-pfadjust,x ;4
         sta PF2L ;3
         lda playfield-48+pfwidth*12+47-128,x ;4
         sta PF1R ; 3 too early?
         lda playfield-48+pfwidth*12+46-128-pfadjust,x;4
         sta PF2R ;3
     endif 
     ; sleep 3

     lda player0height
     dcp player0y
     bcc .skipDrawP0
     ldy player0y
     lda (player0pointer),y
.continueP0
     sta GRP0

     ifnconst no_blank_lines
         ifnconst playercolors
             lda missile0height ;3
             dcp missile0y ;5
             sbc stack1
             sta ENAM0 ;3
         else
             lda (player0color),y
             sta player0colorstore
             sleep 6
         endif
         dec temp1
         bne continuekernel
     else
         dec temp1
         beq altkernel2
         ifconst readpaddle
             ldy currentpaddle
             lda INPT0,y
             bpl noreadpaddle
             inc paddle
             jmp continuekernel2
noreadpaddle
             sleep 2
             jmp continuekernel
         else
             ifnconst playercolors 
                 ifconst PFcolors
                     txa
                     tay
                     lda (pfcolortable),y
                     ifnconst backgroundchange
                         sta COLUPF
                     else
                         sta COLUBK
                     endif
                     jmp continuekernel
                 else
                     ifconst kernelmacrodef
                         kernelmacro
                     else
                         sleep 12
                     endif
                 endif
             else
                 lda (player0color),y
                 sta player0colorstore
                 sleep 4
             endif
             jmp continuekernel
         endif
altkernel2
         txa
         ifnconst vertical_reflect
             sbx #256-pfwidth
         else
             sbx #256-pfwidth/2
         endif
         bmi lastkernelline
         ifconst pfrowheight
             lda #pfrowheight
         else
             ifnconst pfres
                 lda #8
             else
                 lda #(96/pfres) ; try to come close to the real size
             endif
         endif
         sta temp1
         jmp continuekernel
     endif

altkernel

     ifconst PFmaskvalue
         lda #PFmaskvalue
     else
         lda #0
     endif
     sta PF1L
     sta PF2


     ;sleep 3

     ;28 cycles to fix things
     ;minus 11=17

     ; lax temp4
     ; clc
     txa
     ifnconst vertical_reflect
         sbx #256-pfwidth
     else
         sbx #256-pfwidth/2
     endif

     bmi lastkernelline

     ifconst PFcolorandheight
         ifconst pfres
             ldy playfieldcolorandheight-131+pfres*pfwidth,x
         else
             ldy playfieldcolorandheight-87,x
         endif
         ifnconst backgroundchange
             sty COLUPF
         else
             sty COLUBK
         endif
         ifconst pfres
             lda playfieldcolorandheight-132+pfres*pfwidth,x
         else
             lda playfieldcolorandheight-88,x
         endif
         sta.w temp1
     endif
     ifconst PFheights
         lsr
         lsr
         tay
         lda (pfheighttable),y
         sta.w temp1
     endif
     ifconst PFcolors
         tay
         lda (pfcolortable),y
         ifnconst backgroundchange
             sta COLUPF
         else
             sta COLUBK
         endif
         ifconst pfrowheight
             lda #pfrowheight
         else
             ifnconst pfres
                 lda #8
             else
                 lda #(96/pfres) ; try to come close to the real size
             endif
         endif
         sta temp1
     endif
     ifnconst PFcolorandheight
         ifnconst PFcolors
             ifnconst PFheights
                 ifnconst no_blank_lines
                     ; read paddle 0
                     ; lo-res paddle read
                     ; bit INPT0
                     ; bmi paddleskipread
                     ; inc paddle0
                     ;donepaddleskip
                     sleep 10
                     ifconst pfrowheight
                         lda #pfrowheight
                     else
                         ifnconst pfres
                             lda #8
                         else
                             lda #(96/pfres) ; try to come close to the real size
                         endif
                     endif
                     sta temp1
                 endif
             endif
         endif
     endif
     

     lda ballheight
     dcp bally
     sbc temp4


     jmp goback


     ifnconst no_blank_lines
lastkernelline
         ifnconst PFcolors
             sleep 10
         else
             ldy #124
             lda (pfcolortable),y
             sta COLUPF
         endif

         ifconst PFheights
             ldx #1
             ;sleep 4
             sleep 3 ; this was over 1 cycle
         else
             ldx playfieldpos
             ;sleep 3
             sleep 2 ; this was over 1 cycle
         endif

         jmp enterlastkernel

     else
lastkernelline
         
         ifconst PFheights
             ldx #1
             ;sleep 5
             sleep 4 ; this was over 1 cycle
         else
             ldx playfieldpos
             ;sleep 4
             sleep 3 ; this was over 1 cycle
         endif

         cpx #0
         bne .enterfromNBL
         jmp no_blank_lines_bailout
     endif

     if ((<*)>$d5)
         align 256
     endif
     ; this is a kludge to prevent page wrapping - fix!!!

.skipDrawlastP1
     lda #0
     tay ; added so we don't cross a page
     jmp .continuelastP1

.endkerloop     ; enter at cycle 59??
     
     nop

.enterfromNBL
     ifconst pfres
         ldy.w playfield+pfres*pfwidth-4
         sty PF1L ;3
         ldy.w playfield+pfres*pfwidth-3-pfadjust
         sty PF2L ;3
         ldy.w playfield+pfres*pfwidth-1
         sty PF1R ; possibly too early?
         ldy.w playfield+pfres*pfwidth-2-pfadjust
         sty PF2R ;3
     else
         ldy.w playfield-48+pfwidth*12+44
         sty PF1L ;3
         ldy.w playfield-48+pfwidth*12+45-pfadjust
         sty PF2L ;3
         ldy.w playfield-48+pfwidth*12+47
         sty PF1R ; possibly too early?
         ldy.w playfield-48+pfwidth*12+46-pfadjust
         sty PF2R ;3
     endif

enterlastkernel
     lda ballheight

     ; tya
     dcp bally
     ; sleep 4

     ; sbc stack3
     rol
     rol
     sta ENABL 

     lda player1height ;3
     dcp player1y ;5
     bcc .skipDrawlastP1
     ldy player1y ;3
     lda (player1pointer),y ;5; player0pointer must be selected carefully by the compiler
     ; so it doesn't cross a page boundary!

.continuelastP1
     sta GRP1 ;3

     ifnconst player1colors
         lda missile1height ;3
         dcp missile1y ;5
     else
         lda (player1color),y
         sta COLUP1
     endif

     dex
     ;dec temp4 ; might try putting this above PF writes
     beq endkernel


     ifconst pfres
         ldy.w playfield+pfres*pfwidth-4
         sty PF1L ;3
         ldy.w playfield+pfres*pfwidth-3-pfadjust
         sty PF2L ;3
         ldy.w playfield+pfres*pfwidth-1
         sty PF1R ; possibly too early?
         ldy.w playfield+pfres*pfwidth-2-pfadjust
         sty PF2R ;3
     else
         ldy.w playfield-48+pfwidth*12+44
         sty PF1L ;3
         ldy.w playfield-48+pfwidth*12+45-pfadjust
         sty PF2L ;3
         ldy.w playfield-48+pfwidth*12+47
         sty PF1R ; possibly too early?
         ldy.w playfield-48+pfwidth*12+46-pfadjust
         sty PF2R ;3
     endif

     ifnconst player1colors
         rol;2
         rol;2
         sta ENAM1 ;3
     else
         ifnconst playercolors
             sleep 7
         else
             lda.w player0colorstore
             sta COLUP0
         endif
     endif
     
     lda.w player0height
     dcp player0y
     bcc .skipDrawlastP0
     ldy player0y
     lda (player0pointer),y
.continuelastP0
     sta GRP0



     ifnconst no_blank_lines
         lda missile0height ;3
         dcp missile0y ;5
         sbc stack1
         sta ENAM0 ;3
         jmp .endkerloop
     else
         ifconst readpaddle
             ldy currentpaddle
             lda INPT0,y
             bpl noreadpaddle2
             inc paddle
             jmp .endkerloop
noreadpaddle2
             sleep 4
             jmp .endkerloop
         else ; no_blank_lines and no paddle reading
             pla
             pha ; 14 cycles in 4 bytes
             pla
             pha
             ; sleep 14
             jmp .endkerloop
         endif
     endif


     ; ifconst donepaddleskip
         ;paddleskipread
         ; this is kind of lame, since it requires 4 cycles from a page boundary crossing
         ; plus we get a lo-res paddle read
         ; bmi donepaddleskip
     ; endif

.skipDrawlastP0
     lda #0
     tay
     jmp .continuelastP0

     ifconst no_blank_lines
no_blank_lines_bailout
         ldx #0
     endif

endkernel
     ; 6 digit score routine
     stx PF1
     stx PF2
     stx PF0
     clc

     ifconst pfrowheight
         lda #pfrowheight+2
     else
         ifnconst pfres
             lda #10
         else
             lda #(96/pfres)+2 ; try to come close to the real size
         endif
     endif

     sbc playfieldpos
     sta playfieldpos
     txa

     ifconst shakescreen
         bit shakescreen
         bmi noshakescreen2
         ldx #$3D
noshakescreen2
     endif

     sta WSYNC,x

     ; STA WSYNC ;first one, need one more
     sta REFP0
     sta REFP1
     STA GRP0
     STA GRP1
     ; STA PF1
     ; STA PF2
     sta HMCLR
     sta ENAM0
     sta ENAM1
     sta ENABL

     lda temp2 ;restore variables that were obliterated by kernel
     sta player0y
     lda temp3
     sta player1y
     ifnconst player1colors
         lda temp6
         sta missile1y
     endif
     ifnconst playercolors
         ifnconst readpaddle
             lda temp5
             sta missile0y
         endif
     endif
     lda stack2
     sta bally

     ; strangely, this isn't required any more. might have
     ; resulted from the no_blank_lines score bounce fix
     ;ifconst no_blank_lines
         ;sta WSYNC
     ;endif

     lda INTIM
     clc
     ifnconst vblank_time
         adc #43+12+87
     else
         adc #vblank_time+12+87

     endif
     ; sta WSYNC
     sta TIM64T

     ifconst minikernel
         jsr minikernel
     endif

     ; now reassign temp vars for score pointers

     ; score pointers contain:
     ; score1-5: lo1,lo2,lo3,lo4,lo5,lo6
     ; swap lo2->temp1
     ; swap lo4->temp3
     ; swap lo6->temp5
     ifnconst noscore
         lda scorepointers+1
         ; ldy temp1
         sta temp1
         ; sty scorepointers+1

         lda scorepointers+3
         ; ldy temp3
         sta temp3
         ; sty scorepointers+3


         sta HMCLR
         tsx
         stx stack1 
         ldx #$E0
         stx HMP0

         LDA scorecolor 
         STA COLUP0
         STA COLUP1
         ifconst scorefade
             STA stack2
         endif
         ifconst pfscore
             lda pfscorecolor
             sta COLUPF
         endif
         sta WSYNC
         ldx #0
         STx GRP0
         STx GRP1 ; seems to be needed because of vdel

         lda scorepointers+5
         ; ldy temp5
         sta temp5,x
         ; sty scorepointers+5
         lda #>scoretable
         sta scorepointers+1
         sta scorepointers+3
         sta scorepointers+5
         sta temp2
         sta temp4
         sta temp6
         LDY #7
         STY VDELP0
         STA RESP0
         STA RESP1


         LDA #$03
         STA NUSIZ0
         STA NUSIZ1
         STA VDELP1
         LDA #$F0
         STA HMP1
         lda (scorepointers),y
         sta GRP0
         STA HMOVE ; cycle 73 ?
         jmp beginscore


         if ((<*)>$d4)
             align 256 ; kludge that potentially wastes space! should be fixed!
         endif

loop2
         lda (scorepointers),y ;+5 68 204
         sta GRP0 ;+3 71 213 D1 -- -- --
         ifconst pfscore
             lda.w pfscore1
             sta PF1
         else
             ifconst scorefade
                 sleep 2
                 dec stack2 ; decrement the temporary scorecolor
             else
                 sleep 7
             endif
         endif
         ; cycle 0
beginscore
         lda (scorepointers+$8),y ;+5 5 15
         sta GRP1 ;+3 8 24 D1 D1 D2 --
         lda (scorepointers+$6),y ;+5 13 39
         sta GRP0 ;+3 16 48 D3 D1 D2 D2
         lax (scorepointers+$2),y ;+5 29 87
         txs
         lax (scorepointers+$4),y ;+5 36 108
         ifconst scorefade
             lda stack2
         else
             sleep 3
         endif

         ifconst pfscore
             lda pfscore2
             sta PF1
         else
             ifconst scorefade
                 sta COLUP0
                 sta COLUP1
             else
                 sleep 6
             endif
         endif

         lda (scorepointers+$A),y ;+5 21 63
         stx GRP1 ;+3 44 132 D3 D3 D4 D2!
         tsx
         stx GRP0 ;+3 47 141 D5 D3! D4 D4
         sta GRP1 ;+3 50 150 D5 D5 D6 D4!
         sty GRP0 ;+3 53 159 D4* D5! D6 D6
         dey
         bpl loop2 ;+2 60 180

         ldx stack1 
         txs
         ; lda scorepointers+1
         ldy temp1
         ; sta temp1
         sty scorepointers+1

         LDA #0 
         sta PF1
         STA GRP0
         STA GRP1
         STA VDELP0
         STA VDELP1;do we need these
         STA NUSIZ0
         STA NUSIZ1

         ; lda scorepointers+3
         ldy temp3
         ; sta temp3
         sty scorepointers+3

         ; lda scorepointers+5
         ldy temp5
         ; sta temp5
         sty scorepointers+5
     endif ;noscore
    ifconst readpaddle
        lda #%11000010
    else
        ifconst qtcontroller
            lda qtcontroller
            lsr    ; bit 0 in carry
            lda #4
            ror    ; carry into top of A
        else
            lda #2
        endif ; qtcontroller
    endif ; readpaddle
 sta WSYNC
 sta VBLANK
 RETURN
     ifconst shakescreen
doshakescreen
         bit shakescreen
         bmi noshakescreen
         sta WSYNC
noshakescreen
         ldx missile0height
         inx
         rts
     endif

; Provided under the CC0 license. See the included LICENSE.txt for details.

start
 sei
 cld
 ldy #0
 lda $D0
 cmp #$2C               ;check RAM location #1
 bne MachineIs2600
 lda $D1
 cmp #$A9               ;check RAM location #2
 bne MachineIs2600
 dey
MachineIs2600
 ldx #0
 txa
clearmem
 inx
 txs
 pha
 bne clearmem
 sty temp1
 ifnconst multisprite
 ifconst pfrowheight
 lda #pfrowheight
 else
 ifconst pfres
 lda #(96/pfres)
 else
 lda #8
 endif
 endif
 sta playfieldpos
 endif
 ldx #5
initscore
 lda #<scoretable
 sta scorepointers,x 
 dex
 bpl initscore
 lda #1
 sta CTRLPF
 ora INTIM
 sta rand

 ifconst multisprite
   jsr multisprite_setup
 endif

 ifnconst bankswitch
   jmp game
 else
   lda #>(game-1)
   pha
   lda #<(game-1)
   pha
   pha
   pha
   ldx #1
   jmp BS_jsr
 endif
; Provided under the CC0 license. See the included LICENSE.txt for details.

; playfield drawing routines
; you get a 32x12 bitmapped display in a single color :)
; 0-31 and 0-11

pfclear ; clears playfield - or fill with pattern
 ifconst pfres
 ldx #pfres*pfwidth-1
 else
 ldx #47-(4-pfwidth)*12 ; will this work?
 endif
pfclear_loop
 ifnconst superchip
 sta playfield,x
 else
 sta playfield-128,x
 endif
 dex
 bpl pfclear_loop
 RETURN
 
setuppointers
 stx temp2 ; store on.off.flip value
 tax ; put x-value in x 
 lsr
 lsr
 lsr ; divide x pos by 8 
 sta temp1
 tya
 asl
 if pfwidth=4
  asl ; multiply y pos by 4
 endif ; else multiply by 2
 clc
 adc temp1 ; add them together to get actual memory location offset
 tay ; put the value in y
 lda temp2 ; restore on.off.flip value
 rts

pfread
;x=xvalue, y=yvalue
 jsr setuppointers
 lda setbyte,x
 and playfield,y
 eor setbyte,x
; beq readzero
; lda #1
; readzero
 RETURN

pfpixel
;x=xvalue, y=yvalue, a=0,1,2
 jsr setuppointers

 ifconst bankswitch
 lda temp2 ; load on.off.flip value (0,1, or 2)
 beq pixelon_r  ; if "on" go to on
 lsr
 bcs pixeloff_r ; value is 1 if true
 lda playfield,y ; if here, it's "flip"
 eor setbyte,x
 ifconst superchip
 sta playfield-128,y
 else
 sta playfield,y
 endif
 RETURN
pixelon_r
 lda playfield,y
 ora setbyte,x
 ifconst superchip
 sta playfield-128,y
 else
 sta playfield,y
 endif
 RETURN
pixeloff_r
 lda setbyte,x
 eor #$ff
 and playfield,y
 ifconst superchip
 sta playfield-128,y
 else
 sta playfield,y
 endif
 RETURN

 else
 jmp plotpoint
 endif

pfhline
;x=xvalue, y=yvalue, a=0,1,2, temp3=endx
 jsr setuppointers
 jmp noinc
keepgoing
 inx
 txa
 and #7
 bne noinc
 iny
noinc
 jsr plotpoint
 cpx temp3
 bmi keepgoing
 RETURN

pfvline
;x=xvalue, y=yvalue, a=0,1,2, temp3=endx
 jsr setuppointers
 sty temp1 ; store memory location offset
 inc temp3 ; increase final x by 1 
 lda temp3
 asl
 if pfwidth=4
   asl ; multiply by 4
 endif ; else multiply by 2
 sta temp3 ; store it
 ; Thanks to Michael Rideout for fixing a bug in this code
 ; right now, temp1=y=starting memory location, temp3=final
 ; x should equal original x value
keepgoingy
 jsr plotpoint
 iny
 iny
 if pfwidth=4
   iny
   iny
 endif
 cpy temp3
 bmi keepgoingy
 RETURN

plotpoint
 lda temp2 ; load on.off.flip value (0,1, or 2)
 beq pixelon  ; if "on" go to on
 lsr
 bcs pixeloff ; value is 1 if true
 lda playfield,y ; if here, it's "flip"
 eor setbyte,x
  ifconst superchip
 sta playfield-128,y
 else
 sta playfield,y
 endif
 rts
pixelon
 lda playfield,y
 ora setbyte,x
 ifconst superchip
 sta playfield-128,y
 else
 sta playfield,y
 endif
 rts
pixeloff
 lda setbyte,x
 eor #$ff
 and playfield,y
 ifconst superchip
 sta playfield-128,y
 else
 sta playfield,y
 endif
 rts

setbyte
 ifnconst pfcenter
 .byte $80
 .byte $40
 .byte $20
 .byte $10
 .byte $08
 .byte $04
 .byte $02
 .byte $01
 endif
 .byte $01
 .byte $02
 .byte $04
 .byte $08
 .byte $10
 .byte $20
 .byte $40
 .byte $80
 .byte $80
 .byte $40
 .byte $20
 .byte $10
 .byte $08
 .byte $04
 .byte $02
 .byte $01
 .byte $01
 .byte $02
 .byte $04
 .byte $08
 .byte $10
 .byte $20
 .byte $40
 .byte $80
; Provided under the CC0 license. See the included LICENSE.txt for details.

pfscroll ;(a=0 left, 1 right, 2 up, 4 down, 6=upup, 12=downdown)
 bne notleft
;left
 ifconst pfres
 ldx #pfres*4
 else
 ldx #48
 endif
leftloop
 lda playfield-1,x
 lsr

 ifconst superchip
 lda playfield-2,x
 rol
 sta playfield-130,x
 lda playfield-3,x
 ror
 sta playfield-131,x
 lda playfield-4,x
 rol
 sta playfield-132,x
 lda playfield-1,x
 ror
 sta playfield-129,x
 else
 rol playfield-2,x
 ror playfield-3,x
 rol playfield-4,x
 ror playfield-1,x
 endif

 txa
 sbx #4
 bne leftloop
 RETURN

notleft
 lsr
 bcc notright
;right

 ifconst pfres
 ldx #pfres*4
 else
 ldx #48
 endif
rightloop
 lda playfield-4,x
 lsr
 ifconst superchip
 lda playfield-3,x
 rol
 sta playfield-131,x
 lda playfield-2,x
 ror
 sta playfield-130,x
 lda playfield-1,x
 rol
 sta playfield-129,x
 lda playfield-4,x
 ror
 sta playfield-132,x
 else
 rol playfield-3,x
 ror playfield-2,x
 rol playfield-1,x
 ror playfield-4,x
 endif
 txa
 sbx #4
 bne rightloop
  RETURN

notright
 lsr
 bcc notup
;up
 lsr
 bcc onedecup
 dec playfieldpos
onedecup
 dec playfieldpos
 beq shiftdown 
 bpl noshiftdown2 
shiftdown
  ifconst pfrowheight
 lda #pfrowheight
 else
 ifnconst pfres
   lda #8
 else
   lda #(96/pfres) ; try to come close to the real size
 endif
 endif

 sta playfieldpos
 lda playfield+3
 sta temp4
 lda playfield+2
 sta temp3
 lda playfield+1
 sta temp2
 lda playfield
 sta temp1
 ldx #0
up2
 lda playfield+4,x
 ifconst superchip
 sta playfield-128,x
 lda playfield+5,x
 sta playfield-127,x
 lda playfield+6,x
 sta playfield-126,x
 lda playfield+7,x
 sta playfield-125,x
 else
 sta playfield,x
 lda playfield+5,x
 sta playfield+1,x
 lda playfield+6,x
 sta playfield+2,x
 lda playfield+7,x
 sta playfield+3,x
 endif
 txa
 sbx #252
 ifconst pfres
 cpx #(pfres-1)*4
 else
 cpx #44
 endif
 bne up2

 lda temp4
 
 ifconst superchip
 ifconst pfres
 sta playfield+pfres*4-129
 lda temp3
 sta playfield+pfres*4-130
 lda temp2
 sta playfield+pfres*4-131
 lda temp1
 sta playfield+pfres*4-132
 else
 sta playfield+47-128
 lda temp3
 sta playfield+46-128
 lda temp2
 sta playfield+45-128
 lda temp1
 sta playfield+44-128
 endif
 else
 ifconst pfres
 sta playfield+pfres*4-1
 lda temp3
 sta playfield+pfres*4-2
 lda temp2
 sta playfield+pfres*4-3
 lda temp1
 sta playfield+pfres*4-4
 else
 sta playfield+47
 lda temp3
 sta playfield+46
 lda temp2
 sta playfield+45
 lda temp1
 sta playfield+44
 endif
 endif
noshiftdown2
 RETURN


notup
;down
 lsr
 bcs oneincup
 inc playfieldpos
oneincup
 inc playfieldpos
 lda playfieldpos

  ifconst pfrowheight
 cmp #pfrowheight+1
 else
 ifnconst pfres
   cmp #9
 else
   cmp #(96/pfres)+1 ; try to come close to the real size
 endif
 endif

 bcc noshiftdown 
 lda #1
 sta playfieldpos

 ifconst pfres
 lda playfield+pfres*4-1
 sta temp4
 lda playfield+pfres*4-2
 sta temp3
 lda playfield+pfres*4-3
 sta temp2
 lda playfield+pfres*4-4
 else
 lda playfield+47
 sta temp4
 lda playfield+46
 sta temp3
 lda playfield+45
 sta temp2
 lda playfield+44
 endif

 sta temp1

 ifconst pfres
 ldx #(pfres-1)*4
 else
 ldx #44
 endif
down2
 lda playfield-1,x
 ifconst superchip
 sta playfield-125,x
 lda playfield-2,x
 sta playfield-126,x
 lda playfield-3,x
 sta playfield-127,x
 lda playfield-4,x
 sta playfield-128,x
 else
 sta playfield+3,x
 lda playfield-2,x
 sta playfield+2,x
 lda playfield-3,x
 sta playfield+1,x
 lda playfield-4,x
 sta playfield,x
 endif
 txa
 sbx #4
 bne down2

 lda temp4
 ifconst superchip
 sta playfield-125
 lda temp3
 sta playfield-126
 lda temp2
 sta playfield-127
 lda temp1
 sta playfield-128
 else
 sta playfield+3
 lda temp3
 sta playfield+2
 lda temp2
 sta playfield+1
 lda temp1
 sta playfield
 endif
noshiftdown
 RETURN
; Provided under the CC0 license. See the included LICENSE.txt for details.

;standard routines needed for pretty much all games
; just the random number generator is left - maybe we should remove this asm file altogether?
; repositioning code and score pointer setup moved to overscan
; read switches, joysticks now compiler generated (more efficient)

randomize
	lda rand
	lsr
 ifconst rand16
	rol rand16
 endif
	bcc noeor
	eor #$B4
noeor
	sta rand
 ifconst rand16
	eor rand16
 endif
	RETURN
; Provided under the CC0 license. See the included LICENSE.txt for details.

drawscreen
     ifconst debugscore
         ldx #14
         lda INTIM ; display # cycles left in the score

         ifconst mincycles
             lda mincycles 
             cmp INTIM
             lda mincycles
             bcc nochange
             lda INTIM
             sta mincycles
nochange
         endif

         ; cmp #$2B
         ; bcs no_cycles_left
         bmi cycles_left
         ldx #64
         eor #$ff ;make negative
cycles_left
         stx scorecolor
         and #$7f ; clear sign bit
         tax
         lda scorebcd,x
         sta score+2
         lda scorebcd1,x
         sta score+1
         jmp done_debugscore 
scorebcd
         .byte $00, $64, $28, $92, $56, $20, $84, $48, $12, $76, $40
         .byte $04, $68, $32, $96, $60, $24, $88, $52, $16, $80, $44
         .byte $08, $72, $36, $00, $64, $28, $92, $56, $20, $84, $48
         .byte $12, $76, $40, $04, $68, $32, $96, $60, $24, $88
scorebcd1
         .byte 0, 0, 1, 1, 2, 3, 3, 4, 5, 5, 6
         .byte 7, 7, 8, 8, 9, $10, $10, $11, $12, $12, $13
         .byte $14, $14, $15, $16, $16, $17, $17, $18, $19, $19, $20
         .byte $21, $21, $22, $23, $23, $24, $24, $25, $26, $26
done_debugscore
     endif

     ifconst debugcycles
         lda INTIM ; if we go over, it mucks up the background color
         ; cmp #$2B
         ; BCC overscan
         bmi overscan
         sta COLUBK
         bcs doneoverscan
     endif

overscan
     ifconst interlaced
         PHP
         PLA 
         EOR #4 ; flip interrupt bit
         PHA
         PLP
         AND #4 ; isolate the interrupt bit
         TAX ; save it for later
     endif

overscanloop
     lda INTIM ;wait for sync
     bmi overscanloop
doneoverscan

     ;do VSYNC

     ifconst interlaced
         CPX #4
         BNE oddframevsync
     endif

     lda #2
     sta WSYNC
     sta VSYNC
     STA WSYNC
     STA WSYNC
     lsr
     STA WSYNC
     STA VSYNC
     sta VBLANK
     ifnconst overscan_time
         lda #37+128
     else
         lda #overscan_time+128
     endif
     sta TIM64T

     ifconst interlaced
         jmp postsync 

oddframevsync
         sta WSYNC

         LDA ($80,X) ; 11 waste
         LDA ($80,X) ; 11 waste
         LDA ($80,X) ; 11 waste

         lda #2
         sta VSYNC
         sta WSYNC
         sta WSYNC
         sta WSYNC

         LDA ($80,X) ; 11 waste
         LDA ($80,X) ; 11 waste
         LDA ($80,X) ; 11 waste

         lda #0
         sta VSYNC
         sta VBLANK
         ifnconst overscan_time
             lda #37+128
         else
             lda #overscan_time+128
         endif
         sta TIM64T

postsync
     endif

     ifconst legacy
         if legacy < 100
             ldx #4
adjustloop
             lda player0x,x
             sec
             sbc #14 ;?
             sta player0x,x
             dex
             bpl adjustloop
         endif
     endif
     if ((<*)>$e9)&&((<*)<$fa)
         repeat ($fa-(<*))
         nop
         repend
     endif
     sta WSYNC
     ldx #4
     SLEEP 3
HorPosLoop     ; 5
     lda player0x,X ;+4 9
     sec ;+2 11
DivideLoop
     sbc #15
     bcs DivideLoop;+4 15
     sta temp1,X ;+4 19
     sta RESP0,X ;+4 23
     sta WSYNC
     dex
     bpl HorPosLoop;+5 5
     ; 4

     ldx #4
     ldy temp1,X
     lda repostable-256,Y
     sta HMP0,X ;+14 18

     dex
     ldy temp1,X
     lda repostable-256,Y
     sta HMP0,X ;+14 32

     dex
     ldy temp1,X
     lda repostable-256,Y
     sta HMP0,X ;+14 46

     dex
     ldy temp1,X
     lda repostable-256,Y
     sta HMP0,X ;+14 60

     dex
     ldy temp1,X
     lda repostable-256,Y
     sta HMP0,X ;+14 74

     sta WSYNC
     
     sta HMOVE ;+3 3


     ifconst legacy
         if legacy < 100
             ldx #4
adjustloop2
             lda player0x,x
             clc
             adc #14 ;?
             sta player0x,x
             dex
             bpl adjustloop2
         endif
     endif




     ;set score pointers
     lax score+2
     jsr scorepointerset
     sty scorepointers+5
     stx scorepointers+2
     lax score+1
     jsr scorepointerset
     sty scorepointers+4
     stx scorepointers+1
     lax score
     jsr scorepointerset
     sty scorepointers+3
     stx scorepointers

vblk
     ; run possible vblank bB code
     ifconst vblank_bB_code
         jsr vblank_bB_code
     endif
vblk2
     LDA INTIM
     bmi vblk2
     jmp kernel
     

     .byte $80,$70,$60,$50,$40,$30,$20,$10,$00
     .byte $F0,$E0,$D0,$C0,$B0,$A0,$90
repostable

scorepointerset
     and #$0F
     asl
     asl
     asl
     adc #<scoretable
     tay 
     txa
     ; and #$F0
     ; lsr
     asr #$F0
     adc #<scoretable
     tax
     rts
;bB.asm
; bB.asm file is split here
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Thwomp
 ; __Thwomp

.
 ; 

.L01506 ;  gosub __ThwompC

 jsr .__ThwompC

.
 ; 

.L01507 ;  if _Enemy_Type  =  _Thwomp then NUSIZ1  =  $15

	LDA _Enemy_Type
	CMP #_Thwomp
     BNE .skipL01507
.condpart666
	LDA #$15
	STA NUSIZ1
.skipL01507
.
 ; 

.L01508 ;  if _Bit3_Enemy_Direction{3} then goto __T2

	LDA _Bit3_Enemy_Direction
	AND #8
	BEQ .skipL01508
.condpart667
 jmp .__T2

.skipL01508
.
 ; 

.L01509 ;  if player0x  <  player1x then x  =  player1x  -  player0x

	LDA player0x
	CMP player1x
     BCS .skipL01509
.condpart668
	LDA player1x
	SEC
	SBC player0x
	STA x
.skipL01509
.
 ; 

.L01510 ;  if player0x  >  player1x then x  =  player0x  -  player1x

	LDA player1x
	CMP player0x
     BCS .skipL01510
.condpart669
	LDA player0x
	SEC
	SBC player1x
	STA x
.skipL01510
.
 ; 

.L01511 ;  if x  <  32 then _Bit3_Enemy_Direction{3}  =  1

	LDA x
	CMP #32
     BCS .skipL01511
.condpart670
	LDA _Bit3_Enemy_Direction
	ORA #8
	STA _Bit3_Enemy_Direction
.skipL01511
.
 ; 

.L01512 ;  gosub __Thwomp1

 jsr .__Thwomp1

.
 ; 

.L01513 ;  goto __Main_Loop bank1

 sta temp7
 lda #>(.__Main_Loop-1)
 pha
 lda #<(.__Main_Loop-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
.
 ; 

.
 ; 

.__T2
 ; __T2

.
 ; 

.L01514 ;  if _Enemy_Momentum  =  0 then player1y  =  player1y  +  8  :  gosub __Thwomp2

	LDA _Enemy_Momentum
	CMP #0
     BNE .skipL01514
.condpart671
	LDA player1y
	CLC
	ADC #8
	STA player1y
 jsr .__Thwomp2

.skipL01514
.
 ; 

.L01515 ;  if _Enemy_Momentum  >  0  &&  _Enemy_Momentum  <  16 then _Enemy_Momentum  =  _Enemy_Momentum  +  1  :  gosub __Thwomp2

	LDA #0
	CMP _Enemy_Momentum
     BCS .skipL01515
.condpart672
	LDA _Enemy_Momentum
	CMP #16
     BCS .skip672then
.condpart673
	INC _Enemy_Momentum
 jsr .__Thwomp2

.skip672then
.skipL01515
.
 ; 

.L01516 ;  if _Enemy_Momentum  =  2  ||  _Enemy_Momentum  =  4 then player1y  =  player1y  -  1

	LDA _Enemy_Momentum
	CMP #2
     BNE .skipL01516
.condpart674
 jmp .condpart675
.skipL01516
	LDA _Enemy_Momentum
	CMP #4
     BNE .skip175OR
.condpart675
	DEC player1y
.skip175OR
.
 ; 

.L01517 ;  if _Enemy_Momentum  =  3  ||  _Enemy_Momentum  =  5 then player1y  =  player1y  +  1

	LDA _Enemy_Momentum
	CMP #3
     BNE .skipL01517
.condpart676
 jmp .condpart677
.skipL01517
	LDA _Enemy_Momentum
	CMP #5
     BNE .skip176OR
.condpart677
	INC player1y
.skip176OR
.
 ; 

.L01518 ;  if _Enemy_Momentum  =  16 then player1y  =  player1y  -  4  :  gosub __Thwomp1

	LDA _Enemy_Momentum
	CMP #16
     BNE .skipL01518
.condpart678
	LDA player1y
	SEC
	SBC #4
	STA player1y
 jsr .__Thwomp1

.skipL01518
.
 ; 

.L01519 ;  x  =   ( player1x  -  9 )  / 4

; complex statement detected
	LDA player1x
	SEC
	SBC #9
	lsr
	lsr
	STA x
.
 ; 

.L01520 ;  if _Enemy_Momentum  =  16 then y  =   ( player1y  -  12 )  / 8 else y  =   ( player1y / 8 ) 

	LDA _Enemy_Momentum
	CMP #16
     BNE .skipL01520
.condpart679
; complex statement detected
	LDA player1y
	SEC
	SBC #12
	lsr
	lsr
	lsr
	STA y
 jmp .skipelse87
.skipL01520
; complex statement detected
	LDA player1y
	lsr
	lsr
	lsr
	STA y
.skipelse87
.
 ; 

.L01521 ;  if !pfread ( x , y )  then goto __Main_Loop bank1

	LDA x
	LDY y
 jsr pfread
	BEQ .skipL01521
.condpart680
 sta temp7
 lda #>(.__Main_Loop-1)
 pha
 lda #<(.__Main_Loop-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
.skipL01521
.
 ; 

.L01522 ;  if _Enemy_Momentum  =  0 then _Enemy_Momentum  =  1  :  player1y  =   ( y  *  8 )   -  1  :  AUDV0  =  10  :  AUDC0  =  7  :  AUDF0  =  22

	LDA _Enemy_Momentum
	CMP #0
     BNE .skipL01522
.condpart681
	LDA #1
	STA _Enemy_Momentum
; complex statement detected
	LDA y
	asl
	asl
	asl
	SEC
	SBC #1
	STA player1y
	LDA #10
	STA AUDV0
	LDA #7
	STA AUDC0
	LDA #22
	STA AUDF0
.skipL01522
.
 ; 

.L01523 ;  if _Enemy_Momentum  =  16 then _Enemy_Momentum  =  0  :  player1y  =  24  :  _Bit3_Enemy_Direction{3}  =  0

	LDA _Enemy_Momentum
	CMP #16
     BNE .skipL01523
.condpart682
	LDA #0
	STA _Enemy_Momentum
	LDA #24
	STA player1y
	LDA _Bit3_Enemy_Direction
	AND #247
	STA _Bit3_Enemy_Direction
.skipL01523
.
 ; 

.L01524 ;  goto __Main_Loop bank1

 sta temp7
 lda #>(.__Main_Loop-1)
 pha
 lda #<(.__Main_Loop-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
.
 ; 

.__ThwompC
 ; __ThwompC

.L01525 ;  player1color:

	LDX #<playercolorL01525_1
	STX player1color
	LDA #>playercolorL01525_1
	STA player1color+1
.L01526 ;  return thisbank

	RTS
.
 ; 

.__Thwomp1
 ; __Thwomp1

.L01527 ;  player1:

	LDX #<playerL01527_1
	STX player1pointerlo
	LDA #>playerL01527_1
	STA player1pointerhi
	LDA #15
	STA player1height
.L01528 ;  return thisbank

	RTS
.
 ; 

.__Thwomp2
 ; __Thwomp2

.L01529 ;  player1:

	LDX #<playerL01529_1
	STX player1pointerlo
	LDA #>playerL01529_1
	STA player1pointerhi
	LDA #15
	STA player1height
.L01530 ;  return thisbank

	RTS
.
 ; 

.
 ; 

.
 ; 

.__Final
 ; __Final

.
 ; 

.L01531 ;  y  =  30  :  gosub __Pause_B8

	LDA #30
	STA y
 jsr .__Pause_B8

.
 ; 

.L01532 ;  for z  =  1 to 8

	LDA #1
	STA z
.L01532forz
.
 ; 

.L01533 ;  pfclear

	LDA #0
 jsr pfclear
.
 ; 

.L01534 ;  y  =  4  :  gosub __Pause_B8

	LDA #4
	STA y
 jsr .__Pause_B8

.
 ; 

.L01535 ;  gosub __Boss_PF_Setup_4 bank6

 sta temp7
 lda #>(ret_point96-1)
 pha
 lda #<(ret_point96-1)
 pha
 lda #>(.__Boss_PF_Setup_4-1)
 pha
 lda #<(.__Boss_PF_Setup_4-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #6
 jmp BS_jsr
ret_point96
.
 ; 

.L01536 ;  gosub __Pause_B8

 jsr .__Pause_B8

.
 ; 

.L01537 ;  next z

	LDA z
	CMP #8

	INC z
 if ((* - .L01532forz) < 127) && ((* - .L01532forz) > -128)
	bcc .L01532forz
 else
	bcs .18skipL01532forz
	jmp .L01532forz
.18skipL01532forz
 endif
.
 ; 

.L01538 ;  pfclear

	LDA #0
 jsr pfclear
.
 ; 

.L01539 ;  y  =  30  :  gosub __Pause_B8

	LDA #30
	STA y
 jsr .__Pause_B8

.
 ; 

.
 ; 

.__Final2
 ; __Final2

.
 ; 

.L01540 ;  if player1x  >  0 then player1x  =  player1x  -  1 else player1y  =  150  :  goto __Final3

	LDA #0
	CMP player1x
     BCS .skipL01540
.condpart683
	DEC player1x
 jmp .skipelse88
.skipL01540
	LDA #150
	STA player1y
 jmp .__Final3

.skipelse88
.
 ; 

.L01541 ;  if player0x  >  0 then player0x  =  player0x  -  1 else player0y  =  150

	LDA #0
	CMP player0x
     BCS .skipL01541
.condpart684
	DEC player0x
 jmp .skipelse89
.skipL01541
	LDA #150
	STA player0y
.skipelse89
.
 ; 

.L01542 ;  NUSIZ1  =  $15

	LDA #$15
	STA NUSIZ1
.
 ; 

.L01543 ;  drawscreen

 jsr drawscreen
.
 ; 

.L01544 ;  goto __Final2

 jmp .__Final2

.
 ; 

.
 ; 

.__Final3
 ; __Final3

.
 ; 

.L01545 ;  _Enemy_Type  =  _Goomba  :  gosub __Pause_B8

	LDA #_Goomba
	STA _Enemy_Type
 jsr .__Pause_B8

.
 ; 

.L01546 ;  gosub __PrincessC  :  gosub __PB

 jsr .__PrincessC
 jsr .__PB

.
 ; 

.L01547 ;  player1y  =  80

	LDA #80
	STA player1y
.
 ; 

.L01548 ;  for x  =  150 to 100 step -1

	LDA #150
	STA x
.L01548forx
.
 ; 

.L01549 ;  player1x  =  x

	LDA x
	STA player1x
.
 ; 

.L01550 ;  REFP1  =  8

	LDA #8
	STA REFP1
.
 ; 

.L01551 ;  drawscreen

 jsr drawscreen
.
 ; 

.L01552 ;  next x

	LDA x
	CLC
	ADC #-1

	STA x
	CMP #100
 if ((* - .L01548forx) < 127) && ((* - .L01548forx) > -128)
	bcs .L01548forx
 else
	bcc .19skipL01548forx
	jmp .L01548forx
.19skipL01548forx
 endif
.
 ; 

.L01553 ;  gosub __Pause_B8

 jsr .__Pause_B8

.
 ; 

.L01554 ;  _Animation_Timer  =  0  :  _Bit6_Regular_Mario{6}  =  0  :  _Bit3_Super_Mario_Power{3}  =  1  :  _Momentum_Left_Right  =  1  :  player0y  =  80

	LDA #0
	STA _Animation_Timer
	LDA _Bit6_Regular_Mario
	AND #191
	STA _Bit6_Regular_Mario
	LDA _Bit3_Super_Mario_Power
	ORA #8
	STA _Bit3_Super_Mario_Power
	LDA #1
	STA _Momentum_Left_Right
	LDA #80
	STA player0y
.
 ; 

.L01555 ;  for z  =  0 to 74

	LDA #0
	STA z
.L01555forz
.
 ; 

.L01556 ;  _Animation_Timer  =  _Animation_Timer  +  1

	INC _Animation_Timer
.
 ; 

.L01557 ;  if _Animation_Timer  >  6 then _Animation_Timer  =  0

	LDA #6
	CMP _Animation_Timer
     BCS .skipL01557
.condpart685
	LDA #0
	STA _Animation_Timer
.skipL01557
.
 ; 

.L01558 ;  gosub __Set_Up_Mario bank1

 sta temp7
 lda #>(ret_point97-1)
 pha
 lda #<(ret_point97-1)
 pha
 lda #>(.__Set_Up_Mario-1)
 pha
 lda #<(.__Set_Up_Mario-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
ret_point97
.
 ; 

.L01559 ;  player0x  =  z

	LDA z
	STA player0x
.
 ; 

.L01560 ;  y  =  3  :  gosub __Pause_B8

	LDA #3
	STA y
 jsr .__Pause_B8

.
 ; 

.L01561 ;  next z

	LDA z
	CMP #74

	INC z
 if ((* - .L01555forz) < 127) && ((* - .L01555forz) > -128)
	bcc .L01555forz
 else
	bcs .20skipL01555forz
	jmp .L01555forz
.20skipL01555forz
 endif
.
 ; 

.L01562 ;  _Animation_Timer  =  0  :  gosub __Set_Up_Mario bank1

	LDA #0
	STA _Animation_Timer
 sta temp7
 lda #>(ret_point98-1)
 pha
 lda #<(ret_point98-1)
 pha
 lda #>(.__Set_Up_Mario-1)
 pha
 lda #<(.__Set_Up_Mario-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #1
 jmp BS_jsr
ret_point98
.
 ; 

.L01563 ;  y  =  30  :  gosub __Pause_B8

	LDA #30
	STA y
 jsr .__Pause_B8

.
 ; 

.L01564 ;  gosub __PA

 jsr .__PA

.
 ; 

.L01565 ;  y  =  40  :  gosub __Pause_B8

	LDA #40
	STA y
 jsr .__Pause_B8

.
 ; 

.L01566 ;  _Enemy_Type  =  1

	LDA #1
	STA _Enemy_Type
.
 ; 

.L01567 ;  y  =  120  :  gosub __Pause_B8

	LDA #120
	STA y
 jsr .__Pause_B8

.
 ; 

.L01568 ;  for z  =  100 to 84 step -1

	LDA #100
	STA z
.L01568forz
.
 ; 

.L01569 ;  player1x  =  z

	LDA z
	STA player1x
.
 ; 

.L01570 ;  y  =  3  :  gosub __Pause_B8

	LDA #3
	STA y
 jsr .__Pause_B8

.
 ; 

.L01571 ;  next z

	LDA z
	CLC
	ADC #-1

	STA z
	CMP #84
 if ((* - .L01568forz) < 127) && ((* - .L01568forz) > -128)
	bcs .L01568forz
 else
	bcc .21skipL01568forz
	jmp .L01568forz
.21skipL01568forz
 endif
.
 ; 

.L01572 ;  gosub __Final_Music bank7

 sta temp7
 lda #>(ret_point99-1)
 pha
 lda #<(ret_point99-1)
 pha
 lda #>(.__Final_Music-1)
 pha
 lda #<(.__Final_Music-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #7
 jmp BS_jsr
ret_point99
.
 ; 

.L01573 ;  _Music_Duration  =  1

	LDA #1
	STA _Music_Duration
.
 ; 

.L01574 ;  pfcolors:

 lda # $46
 sta COLUPF
 ifconst pfres
 lda #>(pfcolorlabel1194-129+pfres*pfwidth)
 else
 lda #>(pfcolorlabel1194-81)
 endif
 sta pfcolortable+1
 ifconst pfres
 lda #<(pfcolorlabel1194-129+pfres*pfwidth)
 else
 lda #<(pfcolorlabel1194-81)
 endif
 sta pfcolortable
.
 ; 

.L01575 ;  playfield:

  ifconst pfres
	  ldx #(11>pfres)*(pfres*pfwidth-1)+(11<=pfres)*43
  else
	  ldx #((11*pfwidth-1)*((11*pfwidth-1)<47))+(47*((11*pfwidth-1)>=47))
  endif
	jmp pflabel5
PF_data5
	.byte %00000000, %11000000
	if (pfwidth>2)
	.byte %01100000, %00000000
 endif
	.byte %00000000, %11100000
	if (pfwidth>2)
	.byte %11110000, %00000000
 endif
	.byte %00000000, %11100000
	if (pfwidth>2)
	.byte %11110000, %00000000
 endif
	.byte %00000000, %11000000
	if (pfwidth>2)
	.byte %11100000, %00000000
 endif
	.byte %00000000, %10000000
	if (pfwidth>2)
	.byte %11000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %10000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
	.byte %00000000, %00000000
	if (pfwidth>2)
	.byte %00000000, %00000000
 endif
pflabel5
	lda PF_data5,x
	sta playfield,x
	dex
	bpl pflabel5
.
 ; 

.__Final4
 ; __Final4

.
 ; 

.L01576 ;  gosub __Play_Final_Music bank7

 sta temp7
 lda #>(ret_point100-1)
 pha
 lda #<(ret_point100-1)
 pha
 lda #>(.__Play_Final_Music-1)
 pha
 lda #<(.__Play_Final_Music-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #7
 jmp BS_jsr
ret_point100
.
 ; 

.L01577 ;  if _Music_Duration  =  255 then goto __Final5

	LDA _Music_Duration
	CMP #255
     BNE .skipL01577
.condpart686
 jmp .__Final5

.skipL01577
.
 ; 

.L01578 ;  y  =  4  :  gosub __Pause_B8

	LDA #4
	STA y
 jsr .__Pause_B8

.
 ; 

.L01579 ;  goto __Final4

 jmp .__Final4

.
 ; 

.__Final5
 ; __Final5

.
 ; 

.L01580 ;  _World  =  1  :  _Level  =  1

	LDA #1
	STA _World
	STA _Level
.
 ; 

.L01581 ;  _Coin_Counter  =  0  :  _Bit3_Super_Mario_Power{3}  =  0  :  _Bit4_Firey_Mario_Power{4}  =  0  :  g  =  0  :  pfscore2  =  0

	LDA #0
	STA _Coin_Counter
	LDA _Bit3_Super_Mario_Power
	AND #247
	STA _Bit3_Super_Mario_Power
	LDA _Bit4_Firey_Mario_Power
	AND #239
	STA _Bit4_Firey_Mario_Power
	LDA #0
	STA g
	STA pfscore2
.
 ; 

.L01582 ;  _Bit6_Regular_Mario{6}  =  1  :  _Bit7_2nd_Quest{7}  =  1

	LDA _Bit6_Regular_Mario
	ORA #64
	STA _Bit6_Regular_Mario
	LDA _Bit7_2nd_Quest
	ORA #128
	STA _Bit7_2nd_Quest
.
 ; 

.L01583 ;  if joy0fire then score  =  0  :  goto __Gm_Ovr_Scrn_4 bank4

 bit INPT4
	BMI .skipL01583
.condpart687
	LDA #$00
	STA score+2
	LDA #$00
	STA score+1
	LDA #$00
	STA score
 sta temp7
 lda #>(.__Gm_Ovr_Scrn_4-1)
 pha
 lda #<(.__Gm_Ovr_Scrn_4-1)
 pha
 lda temp7
 pha
 txa
 pha
 ldx #4
 jmp BS_jsr
.skipL01583
.
 ; 

.L01584 ;  COLUPF  =  $46

	LDA #$46
	STA COLUPF
.
 ; 

.L01585 ;  drawscreen

 jsr drawscreen
.
 ; 

.L01586 ;  goto __Final5

 jmp .__Final5

.
 ; 

.__Pause_B8
 ; __Pause_B8

.
 ; 

.L01587 ;  for x  =  1 to y

	LDA #1
	STA x
.L01587forx
.
 ; 

.L01588 ;  COLUPF  =  $46

	LDA #$46
	STA COLUPF
.
 ; 

.L01589 ;  if _Enemy_Type  =  _Bowser_Jr then NUSIZ1  =  $15  :  COLUPF  =  $04

	LDA _Enemy_Type
	CMP #_Bowser_Jr
     BNE .skipL01589
.condpart688
	LDA #$15
	STA NUSIZ1
	LDA #$04
	STA COLUPF
.skipL01589
.
 ; 

.L01590 ;  if _Enemy_Type  =  _Goomba then REFP1  =  8

	LDA _Enemy_Type
	CMP #_Goomba
     BNE .skipL01590
.condpart689
	LDA #8
	STA REFP1
.skipL01590
.
 ; 

.L01591 ;  drawscreen

 jsr drawscreen
.
 ; 

.L01592 ;  next x

	LDA x
	CMP y

	INC x
 if ((* - .L01587forx) < 127) && ((* - .L01587forx) > -128)
	bcc .L01587forx
 else
	bcs .22skipL01587forx
	jmp .L01587forx
.22skipL01587forx
 endif
.
 ; 

.L01593 ;  return thisbank

	RTS
.
 ; 

.__PrincessC
 ; __PrincessC

.L01594 ;  player1color:

	LDX #<playercolorL01594_1
	STX player1color
	LDA #>playercolorL01594_1
	STA player1color+1
.L01595 ;  return thisbank

	RTS
.
 ; 

.__PA
 ; __PA

.L01596 ;  player1:

	LDX #<playerL01596_1
	STX player1pointerlo
	LDA #>playerL01596_1
	STA player1pointerhi
	LDA #23
	STA player1height
.L01597 ;  return thisbank

	RTS
.
 ; 

.__PB
 ; __PB

.L01598 ;  player1:

	LDX #<playerL01598_1
	STX player1pointerlo
	LDA #>playerL01598_1
	STA player1pointerhi
	LDA #23
	STA player1height
.L01599 ;  return thisbank
	RTS
 if (<*) > (<(*+12))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playercolorL0318_0
	.byte   $44
	.byte   $44
	.byte   $3E
	.byte   $44
	.byte   $44
	.byte   $44
	.byte   $3E
	.byte   $3E
	.byte   $3E
	.byte   $3E
	.byte   $3E
	.byte   $44
	.byte   $44
 if (<*) > (<(*+14))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playercolorL0320_0
	.byte   $44
	.byte   $44
	.byte   $44
	.byte   $3E
	.byte   $44
	.byte   $44
	.byte   $3E
	.byte   $3E
	.byte   $3E
	.byte   $3E
	.byte   $3E
	.byte   $44
	.byte   $44
	.byte   $3E
	.byte   $3E
 if (<*) > (<(*+12))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0322_0
	.byte   %01111100
	.byte   %01111000
	.byte   %01100100
	.byte   %11110000
	.byte   %11110110
	.byte   %01101100
	.byte   %00111110
	.byte   %01110000
	.byte   %11011011
	.byte   %10010111
	.byte   %00110100
	.byte   %11111111
	.byte   %01111100
 if (<*) > (<(*+12))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0324_0
	.byte   %11100110
	.byte   %11000011
	.byte   %11001010
	.byte   %11100000
	.byte   %11110110
	.byte   %01101100
	.byte   %00111110
	.byte   %01110000
	.byte   %11011011
	.byte   %10010111
	.byte   %00110100
	.byte   %11111111
	.byte   %01111100
 if (<*) > (<(*+14))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0326_0
	.byte   %10000110
	.byte   %11000011
	.byte   %11000011
	.byte   %11001010
	.byte   %11100101
	.byte   %01101010
	.byte   %00111110
	.byte   %01110000
	.byte   %11011011
	.byte   %10010111
	.byte   %00110100
	.byte   %11111111
	.byte   %01111100
	.byte   %00000011
	.byte   %00000111
 if (<*) > (<(*+23))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playercolorL0328_0
	.byte   $44
	.byte   $44
	.byte   $44
	.byte   $44
	.byte   $3E
	.byte   $3E
	.byte   $44
	.byte   $44
	.byte   $44
	.byte   $44
	.byte   $44
	.byte   $44
	.byte   $3E
	.byte   $3E
	.byte   $3E
	.byte   $3E
	.byte   $3E
	.byte   $3E
	.byte   $3E
	.byte   $3E
	.byte   $44
	.byte   $44
	.byte   $44
	.byte   $44
 if (<*) > (<(*+23))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0330_0
	.byte   %01111111
	.byte   %01111110
	.byte   %00111000
	.byte   %00000000
	.byte   %11000010
	.byte   %11100010
	.byte   %11110000
	.byte   %11110111
	.byte   %11110111
	.byte   %11100111
	.byte   %11101110
	.byte   %01100000
	.byte   %00111110
	.byte   %01111000
	.byte   %11100011
	.byte   %10110111
	.byte   %00111111
	.byte   %00110100
	.byte   %01110100
	.byte   %00111100
	.byte   %11000000
	.byte   %11111111
	.byte   %01111100
	.byte   %00111100
 if (<*) > (<(*+23))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playercolorL0332_0
	.byte   $3A
	.byte   $38
	.byte   $36
	.byte   $16
	.byte   $3E
	.byte   $3E
	.byte   $16
	.byte   $1E
	.byte   $1C
	.byte   $1A
	.byte   $18
	.byte   $16
	.byte   $3E
	.byte   $3E
	.byte   $3E
	.byte   $3E
	.byte   $3E
	.byte   $3E
	.byte   $3E
	.byte   $3E
	.byte   $36
	.byte   $38
	.byte   $3A
	.byte   $3C
 if (<*) > (<(*+25))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playercolorL0334_0
	.byte   $3A
	.byte   $38
	.byte   $36
	.byte   $16
	.byte   $3E
	.byte   $3E
	.byte   $1E
	.byte   $1E
	.byte   $1C
	.byte   $1A
	.byte   $18
	.byte   $16
	.byte   $3E
	.byte   $3E
	.byte   $3E
	.byte   $3E
	.byte   $3E
	.byte   $3E
	.byte   $3E
	.byte   $3E
	.byte   $36
	.byte   $38
	.byte   $3A
	.byte   $3C
	.byte   $3E
	.byte   $3E
 if (<*) > (<(*+23))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0336_0
	.byte   %01100110
	.byte   %11000111
	.byte   %11000011
	.byte   %00000000
	.byte   %00011010
	.byte   %00011010
	.byte   %00111000
	.byte   %01110111
	.byte   %11110111
	.byte   %11101111
	.byte   %11101110
	.byte   %01000000
	.byte   %00111110
	.byte   %01111000
	.byte   %11100011
	.byte   %10110111
	.byte   %00111111
	.byte   %00110100
	.byte   %01110100
	.byte   %00111100
	.byte   %11000000
	.byte   %11111111
	.byte   %01111100
	.byte   %00111100
 if (<*) > (<(*+25))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playercolorL0338_0
	.byte   $44
	.byte   $44
	.byte   $44
	.byte   $44
	.byte   $3E
	.byte   $3E
	.byte   $44
	.byte   $44
	.byte   $44
	.byte   $44
	.byte   $44
	.byte   $44
	.byte   $3E
	.byte   $3E
	.byte   $3E
	.byte   $3E
	.byte   $3E
	.byte   $3E
	.byte   $3E
	.byte   $3E
	.byte   $44
	.byte   $44
	.byte   $44
	.byte   $44
	.byte   $3E
	.byte   $3E
 if (<*) > (<(*+25))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0340_0
	.byte   %11000110
	.byte   %11000111
	.byte   %01000111
	.byte   %01100011
	.byte   %11001001
	.byte   %11101001
	.byte   %11100000
	.byte   %11110110
	.byte   %11110110
	.byte   %11100101
	.byte   %11101101
	.byte   %01100000
	.byte   %00111110
	.byte   %01110000
	.byte   %11000011
	.byte   %01101111
	.byte   %00111111
	.byte   %01101010
	.byte   %01101010
	.byte   %00111100
	.byte   %11000001
	.byte   %11111111
	.byte   %01111101
	.byte   %00111101
	.byte   %00000011
	.byte   %00000111
 if (<*) > (<(*+12))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playercolorL0342_0
	.byte   $44
	.byte   $44
	.byte   $44
	.byte   $44
	.byte   $44
	.byte   $44
	.byte   $44
	.byte   $3E
	.byte   $3E
	.byte   $44
	.byte   $44
	.byte   $44
	.byte   $44
 if (<*) > (<(*+12))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playercolorL0344_0
	.byte   $3A
	.byte   $38
	.byte   $1C
	.byte   $1A
	.byte   $1A
	.byte   $18
	.byte   $16
	.byte   $3E
	.byte   $3E
	.byte   $36
	.byte   $38
	.byte   $3A
	.byte   $3C
 if (<*) > (<(*+12))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0346_0
	.byte   %00111100
	.byte   %01111000
	.byte   %00000110
	.byte   %01110110
	.byte   %11110000
	.byte   %11111100
	.byte   %01101100
	.byte   %01101101
	.byte   %00101100
	.byte   %11111011
	.byte   %01110110
	.byte   %00110110
	.byte   %00011100
 if (<*) > (<(*+0))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0348_0
	.byte   %11100111
 ifconst pfres
 if (<*) > (254-pfres*pfwidth)
	align 256
	endif
 if (<*) < (136-pfres*pfwidth)
	repeat ((136-pfres*pfwidth)-(<*))
	.byte 0
	repend
	endif
 else
 if (<*) > 206
	align 256
	endif
 if (<*) < 88
	repeat (88-(<*))
	.byte 0
	repend
	endif
 endif
pfcolorlabel360
 .byte  $0C, $00, $18, $34
 .byte  $08, $00, $32, $DA
 .byte  $0A, $00, $32, $DA
 .byte  $0A, $00, $32, $DA
 .byte  $0C, $00, $32, $D8
 .byte  $08, $00, $18, $D8
 .byte  $0A, $00, $32, $D8
 .byte  $0A, $00, $C6, $D8
 .byte  $0A, $00, $C6, $C6
 .byte  $D4, $00, $24, $C6
 if (<*) > (<(*+10))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playercolorL0578_1
	.byte   $06
	.byte   $06
	.byte   $2E
	.byte   $2E
	.byte   $36
	.byte   $36
	.byte   $36
	.byte   $36
	.byte   $36
	.byte   $36
	.byte   $36
 if (<*) > (<(*+10))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0580_1
	.byte   %11100110
	.byte   %01000011
	.byte   %00111100
	.byte   %00111100
	.byte   %01111110
	.byte   %11111111
	.byte   %11011011
	.byte   %11000011
	.byte   %10111101
	.byte   %01111110
	.byte   %00111100
 if (<*) > (<(*+10))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0582_1
	.byte   %01100111
	.byte   %11000010
	.byte   %00111100
	.byte   %00111100
	.byte   %01111110
	.byte   %11111111
	.byte   %11011011
	.byte   %11000011
	.byte   %10111101
	.byte   %01111110
	.byte   %00111100
 if (<*) > (<(*+9))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playercolorL0584_1
	.byte   $2E
	.byte   $2E
	.byte   $36
	.byte   $28
	.byte   $2A
	.byte   $2A
	.byte   $36
	.byte   $36
	.byte   $36
	.byte   $38
 if (<*) > (<(*+9))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0586_1
	.byte   %01100011
	.byte   %00110110
	.byte   %00111111
	.byte   %11110101
	.byte   %11010101
	.byte   %01110101
	.byte   %10001001
	.byte   %01110001
	.byte   %00100010
	.byte   %00011100
 if (<*) > (<(*+9))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0588_1
	.byte   %00110110
	.byte   %00110110
	.byte   %00111111
	.byte   %11110101
	.byte   %11010101
	.byte   %01110101
	.byte   %10001001
	.byte   %01110001
	.byte   %00100010
	.byte   %00011100
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playercolorL0590_1
	.byte   $0A
	.byte   $08
	.byte   $0A
	.byte   $0C
	.byte   $0E
	.byte   $0E
	.byte   $0C
	.byte   $0A
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0591_1
	.byte   %00111101
	.byte   %01111101
	.byte   %01111101
	.byte   %11111101
	.byte   %11011101
	.byte   %01011101
	.byte   %01101101
	.byte   %00111101
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playercolorL0593_1
	.byte   $44
	.byte   $46
	.byte   $38
	.byte   $3A
	.byte   $3A
	.byte   $38
	.byte   $46
	.byte   $44
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0595_1
	.byte   %00111010
	.byte   %01110100
	.byte   %11110001
	.byte   %11111100
	.byte   %11011110
	.byte   %11101110
	.byte   %01111110
	.byte   %00111100
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0597_1
	.byte   %00111100
	.byte   %01111110
	.byte   %01110111
	.byte   %01111011
	.byte   %00111111
	.byte   %10001111
	.byte   %00101110
	.byte   %01011100
 if (<*) > (<(*+12))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playercolorL0599_1
	.byte   $2E
	.byte   $2E
	.byte   $C4
	.byte   $C6
	.byte   $C8
	.byte   $C8
	.byte   $C6
	.byte   $2E
	.byte   $2E
	.byte   $2E
	.byte   $2E
	.byte   $2E
	.byte   $2E
 if (<*) > (<(*+12))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playercolorL0601_1
	.byte   $2E
	.byte   $2E
	.byte   $48
	.byte   $4A
	.byte   $4A
	.byte   $48
	.byte   $46
	.byte   $2E
	.byte   $2E
	.byte   $2E
	.byte   $2E
	.byte   $2E
	.byte   $2E
 if (<*) > (<(*+12))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0603_1
	.byte   %01110111
	.byte   %00100010
	.byte   %00111110
	.byte   %01101011
	.byte   %01010101
	.byte   %00101010
	.byte   %00011100
	.byte   %11100010
	.byte   %00110101
	.byte   %11010110
	.byte   %10110111
	.byte   %10100011
	.byte   %01100001
 if (<*) > (<(*+12))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0605_1
	.byte   %00110110
	.byte   %00110110
	.byte   %00111110
	.byte   %01101011
	.byte   %01010101
	.byte   %00101010
	.byte   %00011100
	.byte   %11100010
	.byte   %00110111
	.byte   %11010011
	.byte   %10110000
	.byte   %10100000
	.byte   %01100000
 if (<*) > (<(*+12))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0607_1
	.byte   %01110111
	.byte   %00100010
	.byte   %00111110
	.byte   %01101011
	.byte   %01010101
	.byte   %00101010
	.byte   %00011100
	.byte   %11100000
	.byte   %00110000
	.byte   %11010000
	.byte   %10110000
	.byte   %10100000
	.byte   %01100000
 if (<*) > (<(*+12))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0609_1
	.byte   %00110110
	.byte   %00110110
	.byte   %00111110
	.byte   %01101011
	.byte   %01010101
	.byte   %00101010
	.byte   %00011100
	.byte   %11100000
	.byte   %00110000
	.byte   %11010000
	.byte   %10110000
	.byte   %10100000
	.byte   %01100000
 if (<*) > (<(*+8))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playercolorL0611_1
	.byte   $1E
	.byte   $48
	.byte   $48
	.byte   $46
	.byte   $44
	.byte   $44
	.byte   $46
	.byte   $48
	.byte   $1E
 if (<*) > (<(*+8))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0613_1
	.byte   %01010100
	.byte   %00111100
	.byte   %01101110
	.byte   %11011111
	.byte   %11111111
	.byte   %11111011
	.byte   %01110110
	.byte   %00111100
	.byte   %00101010
 if (<*) > (<(*+8))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0615_1
	.byte   %00101010
	.byte   %00111100
	.byte   %01110110
	.byte   %11111011
	.byte   %11111111
	.byte   %11011111
	.byte   %01101110
	.byte   %00111100
	.byte   %01010100
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playercolorL0617_1
	.byte   $36
	.byte   $26
	.byte   $2A
	.byte   $2A
	.byte   $36
	.byte   $36
	.byte   $36
	.byte   $38
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0619_1
	.byte   %00111100
	.byte   %01100110
	.byte   %10000001
	.byte   %10000001
	.byte   %01001010
	.byte   %01000010
	.byte   %00100100
	.byte   %00011000
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playercolorL0621_1
	.byte   $2E
	.byte   $2E
	.byte   $C8
	.byte   $CA
	.byte   $CA
	.byte   $C8
	.byte   $C8
	.byte   $C6
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playercolorL0623_1
	.byte   $2E
	.byte   $2E
	.byte   $48
	.byte   $4A
	.byte   $4A
	.byte   $48
	.byte   $48
	.byte   $46
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0625_1
	.byte   %00100100
	.byte   %01011010
	.byte   %10111101
	.byte   %11011011
	.byte   %01100110
	.byte   %01011010
	.byte   %00111100
	.byte   %00011000
 if (<*) > (<(*+8))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playercolorL0627_1
	.byte   $2E
	.byte   $2E
	.byte   $46
	.byte   $44
	.byte   $44
	.byte   $48
	.byte   $1A
	.byte   $1C
	.byte   $1E
 if (<*) > (<(*+8))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0629_1
	.byte   %01110111
	.byte   %00100010
	.byte   %01111111
	.byte   %10110101
	.byte   %11101011
	.byte   %00110110
	.byte   %00101010
	.byte   %00101010
	.byte   %00001000
 if (<*) > (<(*+8))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0631_1
	.byte   %00110110
	.byte   %00110110
	.byte   %01111111
	.byte   %10110101
	.byte   %11101011
	.byte   %00110110
	.byte   %00101010
	.byte   %00101010
	.byte   %00001000
 if (<*) > (<(*+31))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playercolorL0633_1
	.byte   $0A
	.byte   $08
	.byte   $C4
	.byte   $C8
	.byte   $C8
	.byte   $C8
	.byte   $C8
	.byte   $C8
	.byte   $C8
	.byte   $C8
	.byte   $C8
	.byte   $C8
	.byte   $C8
	.byte   $C8
	.byte   $C8
	.byte   $C8
	.byte   $C8
	.byte   $C8
	.byte   $C8
	.byte   $C8
	.byte   $C8
	.byte   $C8
	.byte   $C8
	.byte   $C4
	.byte   $0A
	.byte   $0C
	.byte   $0E
	.byte   $0E
	.byte   $0E
	.byte   $0C
	.byte   $0A
	.byte   $CA
 if (<*) > (<(*+31))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0634_1
	.byte   %00000111
	.byte   %00000011
	.byte   %00000001
	.byte   %00000001
	.byte   %00000001
	.byte   %00000001
	.byte   %00000001
	.byte   %00000001
	.byte   %00000001
	.byte   %00000001
	.byte   %00000001
	.byte   %00000001
	.byte   %00000001
	.byte   %00000001
	.byte   %00000001
	.byte   %00000001
	.byte   %00000001
	.byte   %00000001
	.byte   %00000001
	.byte   %00000001
	.byte   %00000001
	.byte   %00000001
	.byte   %00000001
	.byte   %00000001
	.byte   %00001110
	.byte   %00111110
	.byte   %11101010
	.byte   %11110110
	.byte   %11110110
	.byte   %00111110
	.byte   %00001110
	.byte   %00000001
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playercolorL0636_1
	.byte   $2A
	.byte   $2A
	.byte   $D8
	.byte   $C6
	.byte   $0C
	.byte   $0C
	.byte   $C6
	.byte   $C8
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0638_1
	.byte   %00110100
	.byte   %00111100
	.byte   %11111111
	.byte   %11111111
	.byte   %11001111
	.byte   %01010110
	.byte   %00100100
	.byte   %00011000
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playercolorL0640_1
	.byte   $08
	.byte   $0A
	.byte   $0C
	.byte   $0C
	.byte   $0C
	.byte   $0C
	.byte   $0A
	.byte   $08
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0642_1
	.byte   %00011000
	.byte   %00100100
	.byte   %01011010
	.byte   %01011010
	.byte   %01011010
	.byte   %01011010
	.byte   %00100100
	.byte   %00011000
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0644_1
	.byte   %00011000
	.byte   %00011000
	.byte   %00011000
	.byte   %00011000
	.byte   %00011000
	.byte   %00011000
	.byte   %00011000
	.byte   %00011000
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playercolorL0646_1
	.byte   $1E
	.byte   $1E
	.byte   $1E
	.byte   $1E
	.byte   $1E
	.byte   $1E
	.byte   $1E
	.byte   $1E
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playercolorL0648_1
	.byte   $1E
	.byte   $28
	.byte   $28
	.byte   $28
	.byte   $28
	.byte   $28
	.byte   $28
	.byte   $28
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0650_1
	.byte   %00000000
	.byte   %11000110
	.byte   %01101100
	.byte   %00111000
	.byte   %01111100
	.byte   %11010110
	.byte   %00111000
	.byte   %00010000
 if (<*) > (<(*+14))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playercolorL0652_1
	.byte   $2A
	.byte   $2A
	.byte   $2A
	.byte   $2A
	.byte   $2A
	.byte   $2E
	.byte   $2E
	.byte   $C8
	.byte   $C8
	.byte   $CA
	.byte   $CA
	.byte   $CA
	.byte   $C8
	.byte   $C8
	.byte   $C6
 if (<*) > (<(*+14))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0654_1
	.byte   %00011000
	.byte   %00111100
	.byte   %01011010
	.byte   %10111101
	.byte   %11011011
	.byte   %00011000
	.byte   %00011000
	.byte   %00111100
	.byte   %01110110
	.byte   %11011111
	.byte   %11111101
	.byte   %10100111
	.byte   %11000011
	.byte   %11000011
	.byte   %10000001
 if (<*) > (<(*+14))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0656_1
	.byte   %00011000
	.byte   %00111100
	.byte   %01011010
	.byte   %10111101
	.byte   %11011011
	.byte   %00011000
	.byte   %00011000
	.byte   %00111100
	.byte   %01110110
	.byte   %11011111
	.byte   %11111101
	.byte   %10100111
	.byte   %11100111
	.byte   %01100110
	.byte   %00100100
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playercolorL0658_1
	.byte   $44
	.byte   $38
	.byte   $38
	.byte   $3A
	.byte   $3A
	.byte   $38
	.byte   $44
	.byte   $3E
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0660_1
	.byte   %11111111
	.byte   %11111111
	.byte   %10111101
	.byte   %10011001
	.byte   %10011001
	.byte   %10111101
	.byte   %11111111
	.byte   %11111111
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playercolorL0662_1
	.byte   $4A
	.byte   $0A
	.byte   $0C
	.byte   $0E
	.byte   $0E
	.byte   $0C
	.byte   $0A
	.byte   $46
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0664_1
	.byte   %11111111
	.byte   %00111100
	.byte   %01100110
	.byte   %11000011
	.byte   %11000011
	.byte   %01100110
	.byte   %00111100
	.byte   %11111111
 if (<*) > (<(*+14))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playercolorL0981_0
	.byte   $44
	.byte   $44
	.byte   $3E
	.byte   $44
	.byte   $44
	.byte   $3E
	.byte   $3E
	.byte   $3E
	.byte   $3E
	.byte   $3E
	.byte   $3E
	.byte   $44
	.byte   $44
	.byte   $3E
	.byte   $3E
 if (<*) > (<(*+14))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0982_0
	.byte   %11011011
	.byte   %10111101
	.byte   %00100100
	.byte   %01000010
	.byte   %11011011
	.byte   %00111100
	.byte   %01000010
	.byte   %10011001
	.byte   %00111100
	.byte   %11011011
	.byte   %01011010
	.byte   %10111101
	.byte   %11011011
	.byte   %11000011
	.byte   %01000010
 if (<*) > (<(*+31))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playercolorL0984_1
	.byte   $0A
	.byte   $08
	.byte   $C4
	.byte   $0A
	.byte   $0C
	.byte   $0E
	.byte   $0E
	.byte   $0E
	.byte   $0C
	.byte   $0A
	.byte   $C6
	.byte   $C8
	.byte   $C8
	.byte   $C8
	.byte   $C8
	.byte   $C8
	.byte   $C8
	.byte   $C8
	.byte   $C8
	.byte   $C8
	.byte   $C8
	.byte   $C8
	.byte   $C8
	.byte   $C8
	.byte   $C8
	.byte   $C8
	.byte   $C8
	.byte   $C8
	.byte   $C8
	.byte   $C8
	.byte   $C8
	.byte   $CA
 if (<*) > (<(*+31))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0985_1
	.byte   %00000111
	.byte   %00000011
	.byte   %00000001
	.byte   %00001110
	.byte   %00111110
	.byte   %11101010
	.byte   %11110110
	.byte   %11110110
	.byte   %00111110
	.byte   %00001110
	.byte   %00000001
	.byte   %00000001
	.byte   %00000001
	.byte   %00000001
	.byte   %00000001
	.byte   %00000001
	.byte   %00000001
	.byte   %00000001
	.byte   %00000001
	.byte   %00000001
	.byte   %00000001
	.byte   %00000001
	.byte   %00000001
	.byte   %00000001
	.byte   %00000001
	.byte   %00000001
	.byte   %00000001
	.byte   %00000001
	.byte   %00000001
	.byte   %00000001
	.byte   %00000001
	.byte   %00000001
 if (<*) > (<(*+15))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playercolorL0987_1
	.byte   $4A
	.byte   $0A
	.byte   $0C
	.byte   $0E
	.byte   $0E
	.byte   $0E
	.byte   $0E
	.byte   $0E
	.byte   $0E
	.byte   $0E
	.byte   $0E
	.byte   $0E
	.byte   $0E
	.byte   $0C
	.byte   $0A
	.byte   $46
 if (<*) > (<(*+15))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0988_1
	.byte   %11111111
	.byte   %00011000
	.byte   %00100100
	.byte   %00100100
	.byte   %00100100
	.byte   %01000010
	.byte   %01000010
	.byte   %01000010
	.byte   %01000010
	.byte   %01000010
	.byte   %01000010
	.byte   %00100100
	.byte   %00100100
	.byte   %00100100
	.byte   %00011000
	.byte   %11111111
 ifconst pfres
 if (<*) > (254-pfres*pfwidth)
	align 256
	endif
 if (<*) < (136-pfres*pfwidth)
	repeat ((136-pfres*pfwidth)-(<*))
	.byte 0
	repend
	endif
 else
 if (<*) > 206
	align 256
	endif
 if (<*) < 88
	repeat (88-(<*))
	.byte 0
	repend
	endif
 endif
pfcolorlabel1194
 .byte  $A4, $06, $04, $48
 .byte  $A4, $06, $06, $4A
 .byte  $A4, $06, $06, $4A
 .byte  $A4, $06, $08, $4A
 .byte  $A4, $06, $08, $48
 .byte  $18, $06, $0A, $48
 .byte  $A4, $06, $0A, $00
 .byte  $C6, $C6, $0C, $00
 .byte  $C6, $C6, $0C, $00
 .byte  $A2, $0A, $0E, $0A
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playercolorL01088_0
	.byte   $0E
	.byte   $0E
	.byte   $0E
	.byte   $0E
	.byte   $0E
	.byte   $0E
	.byte   $0E
	.byte   $0E
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playercolorL01090_1
	.byte   $0E
	.byte   $0E
	.byte   $0E
	.byte   $0E
	.byte   $0E
	.byte   $0E
	.byte   $0E
	.byte   $0E
 if (<*) > (<(*+17))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playercolorL01150_1
	.byte   $1A
	.byte   $1C
	.byte   $1E
	.byte   $2A
	.byte   $2E
	.byte   $2A
	.byte   $2E
	.byte   $0C
	.byte   $2E
	.byte   $2E
	.byte   $2E
	.byte   $2E
	.byte   $C6
	.byte   $C6
	.byte   $44
	.byte   $44
	.byte   $46
	.byte   $46
 if (<*) > (<(*+17))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL01151_1
	.byte   %11010111
	.byte   %11111011
	.byte   %10111000
	.byte   %00001011
	.byte   %00001011
	.byte   %00010111
	.byte   %00001110
	.byte   %00010100
	.byte   %01111100
	.byte   %01010110
	.byte   %10101111
	.byte   %11111110
	.byte   %01101100
	.byte   %00111000
	.byte   %01110010
	.byte   %01010100
	.byte   %00000110
	.byte   %00001100
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL01233_0
	.byte   %01111000
	.byte   %00110000
	.byte   %00110000
	.byte   %00110011
	.byte   %00110000
	.byte   %00110000
	.byte   %01110000
	.byte   %00110000
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL01235_0
	.byte   %01111000
	.byte   %01111000
	.byte   %01100000
	.byte   %01110011
	.byte   %00111000
	.byte   %00011000
	.byte   %01111000
	.byte   %01110000
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL01237_0
	.byte   %01110000
	.byte   %01111000
	.byte   %00011000
	.byte   %01111011
	.byte   %01111000
	.byte   %00011000
	.byte   %01111000
	.byte   %01110000
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL01239_0
	.byte   %00011000
	.byte   %00011000
	.byte   %00011000
	.byte   %00111011
	.byte   %01111000
	.byte   %01101000
	.byte   %01101000
	.byte   %01101000
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL01241_1
	.byte   %01111000
	.byte   %00110000
	.byte   %00110000
	.byte   %00110000
	.byte   %00110000
	.byte   %00110000
	.byte   %01110000
	.byte   %00110000
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL01243_1
	.byte   %01111000
	.byte   %01111000
	.byte   %01100000
	.byte   %01110000
	.byte   %00111000
	.byte   %00011000
	.byte   %01111000
	.byte   %01110000
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL01245_1
	.byte   %01110000
	.byte   %01111000
	.byte   %00011000
	.byte   %01111000
	.byte   %01111000
	.byte   %00011000
	.byte   %01111000
	.byte   %01110000
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL01247_1
	.byte   %00011000
	.byte   %00011000
	.byte   %00011000
	.byte   %00111000
	.byte   %01111000
	.byte   %01101000
	.byte   %01101000
	.byte   %01101000
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL01249_1
	.byte   %00001111
	.byte   %00000110
	.byte   %00000110
	.byte   %10100110
	.byte   %01000110
	.byte   %10100110
	.byte   %00001110
	.byte   %00000110
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL01251_1
	.byte   %00001111
	.byte   %00001111
	.byte   %00001100
	.byte   %10101110
	.byte   %01000111
	.byte   %10100011
	.byte   %00001111
	.byte   %00001110
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL01253_1
	.byte   %00001110
	.byte   %00001111
	.byte   %00000011
	.byte   %10101111
	.byte   %01001111
	.byte   %10100011
	.byte   %00001111
	.byte   %00001110
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL01255_1
	.byte   %00000011
	.byte   %00000011
	.byte   %00000011
	.byte   %10100111
	.byte   %01001111
	.byte   %10101101
	.byte   %00001101
	.byte   %00001101
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL01257_1
	.byte   %00001110
	.byte   %00001111
	.byte   %00000011
	.byte   %10100111
	.byte   %01001110
	.byte   %10101100
	.byte   %00001111
	.byte   %00001111
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL01259_1
	.byte   %00001111
	.byte   %00001101
	.byte   %00001101
	.byte   %10101111
	.byte   %01001111
	.byte   %10101100
	.byte   %00001111
	.byte   %00000111
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL01261_1
	.byte   %00000110
	.byte   %00000110
	.byte   %00000110
	.byte   %10100111
	.byte   %01000011
	.byte   %10100011
	.byte   %00001111
	.byte   %00001111
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL01263_1
	.byte   %00001111
	.byte   %00001111
	.byte   %00001001
	.byte   %10101111
	.byte   %01001111
	.byte   %10101001
	.byte   %00001111
	.byte   %00001111
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL01265_1
	.byte   %00000110
	.byte   %00000111
	.byte   %00000011
	.byte   %10100111
	.byte   %01001101
	.byte   %10101001
	.byte   %00001111
	.byte   %00000110
 if (<*) > (<(*+12))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playercolorL01267_0
	.byte   $44
	.byte   $44
	.byte   $3E
	.byte   $44
	.byte   $44
	.byte   $44
	.byte   $3E
	.byte   $3E
	.byte   $3E
	.byte   $3E
	.byte   $3E
	.byte   $44
	.byte   $44
 if (<*) > (<(*+12))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL01268_0
	.byte   %01111100
	.byte   %01111000
	.byte   %01100100
	.byte   %11110000
	.byte   %11110110
	.byte   %01101100
	.byte   %00111110
	.byte   %01110000
	.byte   %11011011
	.byte   %10010111
	.byte   %00110100
	.byte   %11111111
	.byte   %01111100
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL01270_0
	.byte   %11001000
	.byte   %10101010
	.byte   %10101010
	.byte   %10101010
	.byte   %10001110
	.byte   %10001010
	.byte   %10001010
	.byte   %01100110
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL01272_1
	.byte   %10010011
	.byte   %10001010
	.byte   %10001010
	.byte   %10001010
	.byte   %10101011
	.byte   %10101010
	.byte   %11111010
	.byte   %01111001
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL01274_0
	.byte   %11001100
	.byte   %10101010
	.byte   %10101010
	.byte   %10101010
	.byte   %10101010
	.byte   %10101010
	.byte   %10101010
	.byte   %01100010
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL01276_1
	.byte   %11001000
	.byte   %10001010
	.byte   %10001010
	.byte   %10001010
	.byte   %11101100
	.byte   %10001010
	.byte   %10001010
	.byte   %01101110
 if (<*) > (<(*+23))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playercolorL01278_1
	.byte   $1A
	.byte   $1E
	.byte   $1E
	.byte   $0E
	.byte   $2A
	.byte   $1E
	.byte   $1E
	.byte   $2A
	.byte   $2E
	.byte   $2A
	.byte   $2E
	.byte   $2A
	.byte   $0C
	.byte   $2E
	.byte   $2E
	.byte   $2E
	.byte   $2E
	.byte   $C6
	.byte   $C6
	.byte   $44
	.byte   $44
	.byte   $46
	.byte   $46
	.byte   $46
 if (<*) > (<(*+20))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playercolorL01280_1
	.byte   $1A
	.byte   $1C
	.byte   $1E
	.byte   $0E
	.byte   $C2
	.byte   $C4
	.byte   $C6
	.byte   $C6
	.byte   $C6
	.byte   $C6
	.byte   $C8
	.byte   $C8
	.byte   $C6
	.byte   $C6
	.byte   $C6
	.byte   $C6
	.byte   $C4
	.byte   $C2
	.byte   $42
	.byte   $44
	.byte   $46
 if (<*) > (<(*+23))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL01282_1
	.byte   %01110111
	.byte   %00110110
	.byte   %00010100
	.byte   %00010100
	.byte   %00111000
	.byte   %01100010
	.byte   %01100110
	.byte   %01110110
	.byte   %01110110
	.byte   %01110110
	.byte   %00111010
	.byte   %00111100
	.byte   %00010100
	.byte   %01111100
	.byte   %00010110
	.byte   %11100111
	.byte   %11111110
	.byte   %01101100
	.byte   %00101000
	.byte   %01110110
	.byte   %01010111
	.byte   %00000110
	.byte   %00000011
	.byte   %00000010
 if (<*) > (<(*+23))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL01284_1
	.byte   %01100110
	.byte   %11100111
	.byte   %11000011
	.byte   %00100010
	.byte   %00011000
	.byte   %10110001
	.byte   %10110011
	.byte   %01110011
	.byte   %01110111
	.byte   %01110110
	.byte   %00111010
	.byte   %00111100
	.byte   %00101000
	.byte   %01111100
	.byte   %00010110
	.byte   %11100111
	.byte   %11111110
	.byte   %01101100
	.byte   %00101000
	.byte   %01110111
	.byte   %01010110
	.byte   %00000011
	.byte   %00000010
	.byte   %00000001
 if (<*) > (<(*+19))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playercolorL01286_1
	.byte   $1A
	.byte   $1C
	.byte   $1E
	.byte   $0C
	.byte   $1E
	.byte   $2A
	.byte   $2E
	.byte   $2A
	.byte   $2E
	.byte   $0C
	.byte   $2E
	.byte   $2E
	.byte   $2E
	.byte   $2E
	.byte   $C6
	.byte   $C6
	.byte   $44
	.byte   $44
	.byte   $46
	.byte   $46
 if (<*) > (<(*+19))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL01288_1
	.byte   %11101111
	.byte   %11110111
	.byte   %01100110
	.byte   %00100100
	.byte   %10101100
	.byte   %01110110
	.byte   %01110110
	.byte   %01111011
	.byte   %00111011
	.byte   %00010100
	.byte   %01111100
	.byte   %00010110
	.byte   %11101111
	.byte   %11111110
	.byte   %01101100
	.byte   %00111100
	.byte   %01110110
	.byte   %01010100
	.byte   %00000110
	.byte   %00001100
 if (<*) > (<(*+24))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playercolorL01290_1
	.byte   $1E
	.byte   $1A
	.byte   $1E
	.byte   $1E
	.byte   $0E
	.byte   $2A
	.byte   $1E
	.byte   $1E
	.byte   $2E
	.byte   $2A
	.byte   $2E
	.byte   $2A
	.byte   $D6
	.byte   $0C
	.byte   $2E
	.byte   $2E
	.byte   $2E
	.byte   $2E
	.byte   $C6
	.byte   $C6
	.byte   $44
	.byte   $44
	.byte   $2E
	.byte   $1E
	.byte   $1E
 if (<*) > (<(*+24))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL01292_1
	.byte   %00011011
	.byte   %00011011
	.byte   %00011011
	.byte   %00110110
	.byte   %00100100
	.byte   %00111100
	.byte   %00111001
	.byte   %00111011
	.byte   %01111011
	.byte   %01111011
	.byte   %01110110
	.byte   %01110110
	.byte   %00111100
	.byte   %00010100
	.byte   %00111110
	.byte   %00010111
	.byte   %01101111
	.byte   %01111111
	.byte   %00110110
	.byte   %00010101
	.byte   %00111011
	.byte   %00101011
	.byte   %11000000
	.byte   %11000000
	.byte   %11100000
 if (<*) > (<(*+20))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playercolorL01294_1
	.byte   $1A
	.byte   $1C
	.byte   $1E
	.byte   $0E
	.byte   $C2
	.byte   $C4
	.byte   $C6
	.byte   $C6
	.byte   $C6
	.byte   $C6
	.byte   $C8
	.byte   $C8
	.byte   $C6
	.byte   $C6
	.byte   $C6
	.byte   $C6
	.byte   $C4
	.byte   $C2
	.byte   $42
	.byte   $44
	.byte   $46
 if (<*) > (<(*+20))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL01296_1
	.byte   %00101011
	.byte   %00110110
	.byte   %00010100
	.byte   %00011010
	.byte   %00011100
	.byte   %00101010
	.byte   %01010110
	.byte   %01010101
	.byte   %10101011
	.byte   %10101011
	.byte   %01010101
	.byte   %01010101
	.byte   %10101011
	.byte   %10101011
	.byte   %01010101
	.byte   %01010110
	.byte   %00101010
	.byte   %00011100
	.byte   %00001111
	.byte   %00000110
	.byte   %00001100
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playercolorL01298_1
	.byte   $2E
	.byte   $2E
	.byte   $C8
	.byte   $CA
	.byte   $CA
	.byte   $C8
	.byte   $C8
	.byte   $C6
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL01300_1
	.byte   %00100100
	.byte   %01011010
	.byte   %10111101
	.byte   %11011011
	.byte   %01100110
	.byte   %01011010
	.byte   %00111100
	.byte   %00011000
 if (<*) > (<(*+15))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playercolorL01525_1
	.byte   $0E
	.byte   $0C
	.byte   $0A
	.byte   $04
	.byte   $06
	.byte   $08
	.byte   $08
	.byte   $08
	.byte   $08
	.byte   $06
	.byte   $0A
	.byte   $0E
	.byte   $0E
	.byte   $0A
	.byte   $0C
	.byte   $0E
 if (<*) > (<(*+15))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL01527_1
	.byte   %11011011
	.byte   %11011011
	.byte   %10000001
	.byte   %01111110
	.byte   %11111111
	.byte   %01011010
	.byte   %11100111
	.byte   %01111110
	.byte   %01111110
	.byte   %10011001
	.byte   %01111110
	.byte   %11111111
	.byte   %01100110
	.byte   %10011001
	.byte   %11011011
	.byte   %11011011
 if (<*) > (<(*+15))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL01529_1
	.byte   %11011011
	.byte   %11011011
	.byte   %10000001
	.byte   %01111110
	.byte   %10111101
	.byte   %10111101
	.byte   %11000011
	.byte   %01111110
	.byte   %01011010
	.byte   %11000011
	.byte   %00011000
	.byte   %11111111
	.byte   %01100110
	.byte   %10011001
	.byte   %11011011
	.byte   %11011011
 if (<*) > (<(*+23))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playercolorL01594_1
	.byte   $0C
	.byte   $0C
	.byte   $4A
	.byte   $4A
	.byte   $4A
	.byte   $48
	.byte   $0C
	.byte   $0C
	.byte   $0A
	.byte   $4A
	.byte   $4A
	.byte   $48
	.byte   $28
	.byte   $3C
	.byte   $3C
	.byte   $3C
	.byte   $3C
	.byte   $3C
	.byte   $3C
	.byte   $2C
	.byte   $2A
	.byte   $28
	.byte   $1C
	.byte   $1E
 if (<*) > (<(*+23))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL01596_1
	.byte   %11111111
	.byte   %00111100
	.byte   %11000011
	.byte   %11111111
	.byte   %01111110
	.byte   %01111110
	.byte   %10110000
	.byte   %01011100
	.byte   %00001100
	.byte   %00110010
	.byte   %01111110
	.byte   %00111100
	.byte   %00000110
	.byte   %00110011
	.byte   %01011011
	.byte   %01111101
	.byte   %00101101
	.byte   %00101011
	.byte   %01011011
	.byte   %10100111
	.byte   %11111111
	.byte   %01111110
	.byte   %01101100
	.byte   %01010100
 if (<*) > (<(*+23))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL01598_1
	.byte   %11111111
	.byte   %00111100
	.byte   %11000011
	.byte   %11111111
	.byte   %01111110
	.byte   %01111110
	.byte   %00000000
	.byte   %01011100
	.byte   %10101100
	.byte   %00110010
	.byte   %01111110
	.byte   %00111100
	.byte   %00000110
	.byte   %00111011
	.byte   %01111011
	.byte   %01110101
	.byte   %00100101
	.byte   %01011011
	.byte   %10100111
	.byte   %11111111
	.byte   %11111111
	.byte   %01111110
	.byte   %01101100
	.byte   %01010100
 if ECHOFIRST
       echo "    ",[(scoretable - *)]d , "bytes of ROM space left in bank 8")
 endif 
ECHOFIRST = 1
 
 
; Provided under the CC0 license. See the included LICENSE.txt for details.

; feel free to modify the score graphics - just keep each digit 8 high
; and keep the conditional compilation stuff intact
 ifconst ROM2k
   ORG $F7AC-8
 else
   ifconst bankswitch
     if bankswitch == 8
       ORG $2F94-bscode_length
       RORG $FF94-bscode_length
     endif
     if bankswitch == 16
       ORG $4F94-bscode_length
       RORG $FF94-bscode_length
     endif
     if bankswitch == 32
       ORG $8F94-bscode_length
       RORG $FF94-bscode_length
     endif
     if bankswitch == 64
       ORG  $10F80-bscode_length
       RORG $1FF80-bscode_length
     endif
   else
     ORG $FF9C
   endif
 endif

; font equates
.21stcentury = 1
alarmclock = 2     
handwritten = 3    
interrupted = 4    
retroputer = 5    
whimsey = 6
tiny = 7
hex = 8

 ifconst font
   if font == hex
     ORG . - 48
   endif
 endif

scoretable

 ifconst font
  if font == .21stcentury
    include "score_graphics.asm.21stcentury"
  endif
  if font == alarmclock
    include "score_graphics.asm.alarmclock"
  endif
  if font == handwritten
    include "score_graphics.asm.handwritten"
  endif
  if font == interrupted
    include "score_graphics.asm.interrupted"
  endif
  if font == retroputer
    include "score_graphics.asm.retroputer"
  endif
  if font == whimsey
    include "score_graphics.asm.whimsey"
  endif
  if font == tiny
    include "score_graphics.asm.tiny"
  endif
  if font == hex
    include "score_graphics.asm.hex"
  endif
 else ; default font

       .byte %00111100
       .byte %01100110
       .byte %01100110
       .byte %01100110
       .byte %01100110
       .byte %01100110
       .byte %01100110
       .byte %00111100

       .byte %01111110
       .byte %00011000
       .byte %00011000
       .byte %00011000
       .byte %00011000
       .byte %00111000
       .byte %00011000
       .byte %00001000

       .byte %01111110
       .byte %01100000
       .byte %01100000
       .byte %00111100
       .byte %00000110
       .byte %00000110
       .byte %01000110
       .byte %00111100

       .byte %00111100
       .byte %01000110
       .byte %00000110
       .byte %00000110
       .byte %00011100
       .byte %00000110
       .byte %01000110
       .byte %00111100

       .byte %00001100
       .byte %00001100
       .byte %01111110
       .byte %01001100
       .byte %01001100
       .byte %00101100
       .byte %00011100
       .byte %00001100

       .byte %00111100
       .byte %01000110
       .byte %00000110
       .byte %00000110
       .byte %00111100
       .byte %01100000
       .byte %01100000
       .byte %01111110

       .byte %00111100
       .byte %01100110
       .byte %01100110
       .byte %01100110
       .byte %01111100
       .byte %01100000
       .byte %01100010
       .byte %00111100

       .byte %00110000
       .byte %00110000
       .byte %00110000
       .byte %00011000
       .byte %00001100
       .byte %00000110
       .byte %01000010
       .byte %00111110

       .byte %00111100
       .byte %01100110
       .byte %01100110
       .byte %01100110
       .byte %00111100
       .byte %01100110
       .byte %01100110
       .byte %00111100

       .byte %00111100
       .byte %01000110
       .byte %00000110
       .byte %00111110
       .byte %01100110
       .byte %01100110
       .byte %01100110
       .byte %00111100 

       ifnconst DPC_kernel_options
 
         .byte %00000000
         .byte %00000000
         .byte %00000000
         .byte %00000000
         .byte %00000000
         .byte %00000000
         .byte %00000000
         .byte %00000000 

       endif

 endif

 ifconst ROM2k
   ORG $F7FC
 else
   ifconst bankswitch
     if bankswitch == 8
       ORG $2FF4-bscode_length
       RORG $FFF4-bscode_length
     endif
     if bankswitch == 16
       ORG $4FF4-bscode_length
       RORG $FFF4-bscode_length
     endif
     if bankswitch == 32
       ORG $8FF4-bscode_length
       RORG $FFF4-bscode_length
     endif
     if bankswitch == 64
       ORG  $10FE0-bscode_length
       RORG $1FFE0-bscode_length
     endif
   else
     ORG $FFFC
   endif
 endif
; Provided under the CC0 license. See the included LICENSE.txt for details.

; every bank has this stuff at the same place
; this code can switch to/from any bank at any entry point
; and can preserve register values
; note: lines not starting with a space are not placed in all banks
;
; line below tells the compiler how long this is - do not remove
;size=32

begin_bscode
 ldx #$ff
 ifconst FASTFETCH ; using DPC+
 stx FASTFETCH
 endif 
 txs
 if bankswitch == 64
   lda #(((>(start-1)) & $0F) | $F0)
 else
   lda #>(start-1)
 endif
 pha
 lda #<(start-1)
 pha

BS_return
 pha
 txa
 pha
 tsx

 if bankswitch != 64
   lda 4,x ; get high byte of return address

   rol
   rol
   rol
   rol
   and #bs_mask ;1 3 or 7 for F8/F6/F4
   tax
   inx
 else
   lda 4,x ; get high byte of return address
   tay
   ora #$10 ; change our bank nibble into a valid rom mirror
   sta 4,x
   tya
   lsr 
   lsr 
   lsr 
   lsr 
   tax
   inx
 endif

BS_jsr
 lda bankswitch_hotspot-1,x
 pla
 tax
 pla
 rts
 if ((* & $1FFF) > ((bankswitch_hotspot & $1FFF) - 1))
   echo "WARNING: size parameter in banksw.asm too small - the program probably will not work."
   echo "Change to",[(*-begin_bscode+1)&$FF]d,"and try again."
 endif
; Provided under the CC0 license. See the included LICENSE.txt for details.

 ifconst bankswitch
   if bankswitch == 8
     ORG $2FFC
     RORG $FFFC
   endif
   if bankswitch == 16
     ORG $4FFC
     RORG $FFFC
   endif
   if bankswitch == 32
     ORG $8FFC
     RORG $FFFC
   endif
   if bankswitch == 64
     ORG  $10FF0
     RORG $1FFF0
     lda $ffe0 ; we use wasted space to assist stella with EF format auto-detection
     ORG  $10FF8
     RORG $1FFF8
     ifconst superchip 
       .byte "E","F","S","C"
     else
       .byte "E","F","E","F"
     endif
     ORG  $10FFC
     RORG $1FFFC
   endif
 else
   ifconst ROM2k
     ORG $F7FC
   else
     ORG $FFFC
   endif
 endif
 .word (start & $ffff)
 .word (start & $ffff)
