 include fixed_point_math.asm
 include div_mul.asm
 set kernel_options no_blank_lines

	dim _sc1 = score
	dim _sc2 = score+1
	dim _sc3 = score+2

	rem Setup 8.8 fixed point variables for smooth movement
	dim _player0x=player0x.a
	dim _player1x=player1x.b
	dim _missile0x= missile0x.c 
	dim _missile1x= missile1x.d
	dim _ballx=ballx.e

	dim _player0shift=f.g
 	dim _player1shift=h.i
	dim _ballShift=j.k
	dim _missile0shift=l.m
 	dim _missile1shift=n.o 
 	dim moveAmount=p.q  


	dim buttonPressed=x
	dim editing=y
	dim currentPreview=z
	

	gosub getPlayers
	rem This is the smallest amount that a fraction of 8.8 can be moved
	moveAmount=0.003921

	rem The 2 data arrays hold the visual preset positions
	rem Even numbers are the whole and odd the fractions
	data shiftPostions0
	1,
	16,
	17,
	238,
	239,
	240,
	255	
end



 rem 
 rem  player0:
 rem  %00011000
 rem  %01100110
 rem  %01100110
 rem  %00111100
 rem  %00111100
 rem  %01011010
 rem  %01100110
 rem  %00011000
 rem end

resetPoint
	rem Read data for movement
	f=shiftPostions0[currentPreview]
	h=shiftPostions0[currentPreview]
	j=shiftPostions0[currentPreview]
	l=shiftPostions0[currentPreview]
	n=shiftPostions0[currentPreview]
	temp3=currentPreview+1

	g=0
	i=50
	k=100
	m=150
	o=200
	currentPreview=temp3

	if currentPreview=shiftPostions0_length then currentPreview=0

	editing=4
	gosub changeEdit
main
	ENAM0=2
	missile1height=0
 	ballheight=255

 	CTRLPF=$01


 	player0height=255
 	player1height=255

	missile0height=10
	rem By making missile1height 255 it was able to wrap around the whole screen

 	COLUP0=196
 	COLUP1 = 64
 	COLUBK = 00 
 	COLUPF=132

	rem Changes whether you're editing the green or red missile
	if joy0fire && buttonPressed=0 then gosub changeEdit
	if editing=0 then goto checkInput0
	if editing=1 then goto checkInput1
	if editing=2 then goto checkInput2
	if editing=3 then goto checkInput3
	if editing=4 then goto checkInput4
checkedInput
	rem Update positions and check limits
	_player0x=_player0x+_player0shift
	_player1x=_player1x+_player1shift
	_ballx=_ballx+_ballShift
	_missile0x=_missile0x+_missile0shift
	_missile1x=_missile1x+_missile1shift

 	if player0x>200 then player0x=player0x+160
 	if player0x>159 then player0x=player0x-160

 	if player1x>200 then player1x=player1x+160
 	if player1x>159 then player1x=player1x-160


 	if missile0x>200 then missile0x=missile0x+160
	if missile0x>159 then missile0x=missile0x-160

 	if missile1x>200 then missile1x=missile1x+160
	if missile1x>159 then missile1x=missile1x-160

 	if ballx>200 then ballx=ballx+160
 	if ballx>159 then ballx=ballx-160 

	gosub trace
 drawscreen

	rem When reset it will pick the next preset visual
 	if switchreset && buttonPressed=0 then buttonPressed=1: goto resetPoint
 	if !joy0fire && !switchreset then buttonPressed=0

 goto main

changeEdit
	rem Picks what colour you're editing
	buttonPressed=1
	editing=editing+1: if editing>4 then editing=0
	if editing=0 then scorecolor=196 
	if editing=1 then scorecolor=64
	if editing=2 then scorecolor=132
	if editing=3 then scorecolor=196 
	if editing=4 then scorecolor=64
	return

	rem Up and down control the whole number and left and right the fraction

checkInput0
	if joy0up then _player0shift=_player0shift+1
	if joy0down then _player0shift=_player0shift-1
	if joy0right then _player0shift=_player0shift +moveAmount
	if joy0left then _player0shift=_player0shift -moveAmount
	goto checkedInput

checkInput1
	if joy0up then _player1shift=_player1shift+1
	if joy0down then _player1shift=_player1shift-1
	if joy0right then _player1shift=_player1shift +moveAmount
	if joy0left then _player1shift=_player1shift -moveAmount
	goto checkedInput

checkInput2
	if joy0up then _ballShift=_ballShift+1
	if joy0down then _ballShift=_ballShift-1
	if joy0right then _ballShift=_ballShift+moveAmount
	if joy0left then _ballShift=_ballShift-moveAmount
	goto checkedInput

checkInput3
	if joy0up then _missile0shift=_missile0shift+1
	if joy0down then _missile0shift=_missile0shift-1
	if joy0right then _missile0shift=_missile0shift +moveAmount
	if joy0left then _missile0shift=_missile0shift -moveAmount
	goto checkedInput

checkInput4
	if joy0up then _missile1shift=_missile1shift+1
	if joy0down then _missile1shift=_missile1shift-1
	if joy0right then _missile1shift=_missile1shift +moveAmount
	if joy0left then _missile1shift=_missile1shift -moveAmount
	goto checkedInput



 rem Original code by Random Terrain from ex_multisprite_9_objects.bas
 rem Uses score to display an 8.8 fixed point variable 
 rem First 3 digits are the whole number and the second 3 digits the fraction 
 
trace
	if editing=0 then temp4=f: temp5=g
 	if editing=1 then temp4=h: temp5=i
 	if editing=2 then temp4=j: temp5=k
 	if editing=3 then temp4=l: temp5=m
 	if editing=4 then temp4=n: temp5=o 

   	_sc1 = 0 : _sc2 = _sc2 & 15
   	if temp4 >= 100 then _sc1 = _sc1 + 16 : temp4 = temp4 - 100
   	if temp4 >= 100 then _sc1 = _sc1 + 16 : temp4 = temp4 - 100
   	if temp4 >= 50 then _sc1 = _sc1 + 5 : temp4 = temp4 - 50
   	if temp4 >= 30 then _sc1 = _sc1 + 3 : temp4 = temp4 - 30
   	if temp4 >= 20 then _sc1 = _sc1 + 2 : temp4 = temp4 - 20
   	if temp4 >= 10 then _sc1 = _sc1 + 1 : temp4 = temp4 - 10
   	_sc2 = (temp4 * 4 * 4) | _sc2

   	_sc2 = _sc2 & 240 : _sc3 = 0
   	if temp5 >= 100 then _sc2 = _sc2 + 1 : temp5 = temp5 - 100
   	if temp5 >= 100 then _sc2 = _sc2 + 1 : temp5 = temp5 - 100
   	if temp5 >= 50 then _sc3 = _sc3 + 80 : temp5 = temp5 - 50
   	if temp5 >= 30 then _sc3 = _sc3 + 48 : temp5 = temp5 - 30
   	if temp5 >= 20 then _sc3 = _sc3 + 32 : temp5 = temp5 - 20
   	if temp5 >= 10 then _sc3 = _sc3 + 16 : temp5 = temp5 - 10
   	_sc3 = _sc3 | temp5
 return

  rem Enable the TIA bug


 vblank

	HMP0=255: HMP1=255: HMM0 = 255: HMM1 = 100: HMBL=100

	WSYNC=255
 	HMOVE = 255 

	HMP0 =144: HMP1 =144: HMM0 = 144: HMM1=255: HMBL = 255 

	return





 rem order top ball-m0-m1
 rem order bottom m1-m0-ball


getPlayers
 player0:
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
end

 player1:
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
 %10
end


 return




