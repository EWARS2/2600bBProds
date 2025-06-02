; Provided under the CC0 license. See the included LICENSE.txt for details.

 processor 6502
 include "vcs.h"
 include "macro.h"
 include "multisprite.h"
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
   .byte 234 ; stop unexpected bankswitches
 endif
 endif
FineAdjustTableBegin
	.byte %01100000		;left 6
	.byte %01010000
	.byte %01000000
	.byte %00110000
	.byte %00100000
	.byte %00010000
	.byte %00000000		;left 0
	.byte %11110000
	.byte %11100000
	.byte %11010000
	.byte %11000000
	.byte %10110000
	.byte %10100000
	.byte %10010000
	.byte %10000000		;right 8
FineAdjustTableEnd	=	FineAdjustTableBegin - 241

PFStart
 .byte 87,43,0,21,0,0,0,10
blank_pf
 .byte 0,0,0,0,0,0,0,5
; .byte 43,21,0,10,0,0,0,5
 ifconst screenheight
pfsub
 .byte 8,4,2,2,1,0,0,1,0
 endif
	;--set initial P1 positions
multisprite_setup
 lda #15
 sta pfheight

	ldx #4
; stx temp3
SetCopyHeight
;	lda #76
;	sta NewSpriteX,X
;	lda CopyColorData,X
;	sta NewCOLUP1,X
 ;lda SpriteHeightTable,X
; sta spriteheight,x
	txa
	sta SpriteGfxIndex,X
	sta spritesort,X
	dex
	bpl SetCopyHeight



; since we can't turn off pf, point PF to zeros here
 lda #>blank_pf
 sta PF2pointer+1
 sta PF1pointer+1
 lda #<blank_pf
 sta PF2pointer
 sta PF1pointer
 rts

drawscreen
 ifconst debugscore
 jsr debugcycles
 endif

WaitForOverscanEnd
	lda INTIM
	bmi WaitForOverscanEnd

	lda #2
	sta WSYNC
	sta VSYNC
	sta WSYNC
	sta WSYNC
	lsr
	sta VDELBL
	sta VDELP0
	sta WSYNC
	sta VSYNC	;turn off VSYNC
      ifconst overscan_time
        lda #overscan_time+5+128
      else
	lda #42+128
      endif
	sta TIM64T

; run possible vblank bB code
 ifconst vblank_bB_code
   jsr vblank_bB_code
 endif

 	jsr setscorepointers
	jsr SetupP1Subroutine

	;-------------





	;--position P0, M0, M1, BL

	jsr PrePositionAllObjects

	;--set up player 0 pointer

 dec player0y
	lda player0pointer ; player0: must be run every frame!
	sec
	sbc player0y
	clc
	adc player0height
	sta player0pointer

	lda player0y
	sta P0Top
	sec
	sbc player0height
	clc
	adc #$80
	sta P0Bottom
	

	;--some final setup

 ldx #4
 lda #$80
cycle74_HMCLR
 sta HMP0,X
 dex
 bpl cycle74_HMCLR
;	sta HMCLR


	lda #0
	sta PF1
	sta PF2
	sta GRP0
	sta GRP1


	jsr KernelSetupSubroutine

WaitForVblankEnd
	lda INTIM
	bmi WaitForVblankEnd
        lda #0
	sta WSYNC
	sta VBLANK	;turn off VBLANK - it was turned on by overscan
	sta CXCLR


	jmp KernelRoutine


PositionASpriteSubroutine	;call this function with A == horizontal position (0-159)
				;and X == the object to be positioned (0=P0, 1=P1, 2=M0, etc.)
				;if you do not wish to write to P1 during this function, make
				;sure Y==0 before you call it.  This function will change Y, and A
				;will be the value put into HMxx when returned.
				;Call this function with at least 11 cycles left in the scanline 
				;(jsr + sec + sta WSYNC = 11); it will return 9 cycles
				;into the second scanline
	sec
	sta WSYNC			;begin line 1
	sta.w HMCLR			;+4	 4
DivideBy15Loop
	sbc #15
	bcs DivideBy15Loop			;+4/5	8/13.../58

	tay				;+2	10/15/...60
	lda FineAdjustTableEnd,Y	;+5	15/20/...65

			;	15
	sta HMP0,X	;+4	19/24/...69
	sta RESP0,X	;+4	23/28/33/38/43/48/53/58/63/68/73
	sta WSYNC	;+3	 0	begin line 2
	sta HMOVE	;+3
	rts		;+6	 9

;-------------------------------------------------------------------------

PrePositionAllObjects

	ldx #4
	lda ballx
	jsr PositionASpriteSubroutine
	
	dex
	lda missile1x
	jsr PositionASpriteSubroutine
	
	dex
	lda missile0x
	jsr PositionASpriteSubroutine

	dex
	dex
	lda player0x
	jsr PositionASpriteSubroutine

	rts


;-------------------------------------------------------------------------








;-------------------------------------------------------------------------


KernelSetupSubroutine

	ldx #4
AdjustYValuesUpLoop
	lda NewSpriteY,X
	clc
	adc #2
	sta NewSpriteY,X
	dex
	bpl AdjustYValuesUpLoop


	ldx temp3 ; first sprite displayed

	lda SpriteGfxIndex,x
	tay
	lda NewSpriteY,y
	sta RepoLine

	lda SpriteGfxIndex-1,x
	tay
	lda NewSpriteY,y
	sta temp6

	stx SpriteIndex



	lda #255
	sta P1Bottom

	lda player0y
 ifconst screenheight
	cmp #screenheight+1
 else
	cmp #$59
 endif
	bcc nottoohigh
	lda P0Bottom
	sta P0Top		

       

nottoohigh
	rts

;-------------------------------------------------------------------------





;*************************************************************************

;-------------------------------------------------------------------------
;-------------------------Data Below--------------------------------------
;-------------------------------------------------------------------------

MaskTable
	.byte 1,3,7,15,31

 ; shove 6-digit score routine here

sixdigscore

 ; 6 digit score routine
; lda #0
; sta PF1
; sta PF2
; tax
 lda #0
   sta WSYNC;,x

;                STA WSYNC ;first one, need one more
 sta REFP0
 sta REFP1
                STA GRP0
                STA GRP1
 sta HMCLR

 ; restore P0pointer

	lda player0pointer
	clc
	adc player0y
	sec
	sbc player0height
	sta player0pointer
 inc player0y

 ifconst vblank_time
 ifconst screenheight
 if screenheight == 84
	lda  #vblank_time+9+128+10
 else
	lda  #vblank_time+9+128+19
 endif
 else
	lda  #vblank_time+9+128
 endif
 else
 ifconst screenheight
 if screenheight == 84
	lda  #52+128+10
 else
	lda  #52+128+19
 endif
 else
	lda  #52+128
 endif
 endif

	sta  TIM64T
 ifconst minikernel
 jsr minikernel
 endif
 ifconst noscore
 jmp skipscore
 endif

; score pointers contain:
; score1-5: lo1,lo2,lo3,lo4,lo5,lo6
; swap lo2->temp1
; swap lo4->temp3
; swap lo6->temp5

 lda scorepointers+5
 sta temp5
 lda scorepointers+1
 sta temp1
 lda scorepointers+3
 sta temp3

 lda #>scoretable
 sta scorepointers+1
 sta scorepointers+3
 sta scorepointers+5
 sta temp2
 sta temp4
 sta temp6

 rts



;-------------------------------------------------------------------------
;----------------------Kernel Routine-------------------------------------
;-------------------------------------------------------------------------


;-------------------------------------------------------------------------
; repeat $f147-*
; brk
; repend
;	org $F240
 align 256
SwitchDrawP0K1				;	72
	lda P0Bottom
	sta P0Top			;+6	 2
	jmp BackFromSwitchDrawP0K1	;+3	 5

WaitDrawP0K1				;	74
	SLEEP 4				;+4	 2
	jmp BackFromSwitchDrawP0K1	;+3	 5

SkipDrawP1K1				;	11
	lda #0
	sta GRP1			;+5	16	so Ball gets drawn
	jmp BackFromSkipDrawP1		;+3	19

;-------------------------------------------------------------------------

KernelRoutine
	tsx
	stx stack1
	ldx #ENABL
	txs			;+9	 9

 ldx #0
 lda pfheight,x

 ifnconst screenheight
 sleep 6
 endif

 bpl asdhj
 .byte $24
asdhj
 tax

; ldx pfheight
 lda PFStart,x ; get pf pixel resolution for heights 15,7,3,1,0

 ifconst screenheight
  sec
 if screenheight == 84
  sbc pfsub+1,x
 else
  sbc pfsub,x
 endif
 endif
 
 sta pfpixelheight

 ifconst screenheight
        ldy #screenheight
 else
	ldy #88
 endif
 
;	lda #$02
;	sta COLUBK		;+5	18

; sleep 25

 JMP Kernel_entry ; ?? timing?
KernelLoopa			;	50
; lda temp5
; sta.w COLUBK
	SLEEP 7			;+4	54
KernelLoopb			;	54
	SLEEP 2		;+12	66
	cpy P0Top		;+3	69
	beq SwitchDrawP0K1	;+2	71
	bpl WaitDrawP0K1	;+2	73
	lda (player0pointer),Y	;+5	 2
	sta GRP0		;+3	 5	VDEL because of repokernel
BackFromSwitchDrawP0K1

	cpy P1Bottom		;+3	 8	unless we mean to draw immediately, this should be set
				;		to a value greater than maximum Y value initially
	bcc SkipDrawP1K1	;+2	10
backfrombgcolor
	lda (P1display),Y	;+5	15
	sta.w GRP1		;+4	19
BackFromSkipDrawP1

 sty temp1
 ldy pfpixelheight
	lax (PF1pointer),y
	stx PF1			;+7	26
	lda (PF2pointer),y
	sta PF2			;+7	33
 ;sleep 6
	stx PF1temp2
	sta PF2temp2
	dey
 bmi lastkernelline ; the below would wrap a page and is unnecessary
	lda (PF1pointer),y
	sta PF1temp1
	lda (PF2pointer),y
cyclebalance
	sta PF2temp1
 ldy temp1

 ldx #ENABL
 txs
	cpy bally
	php			;+6	39	VDEL ball


	cpy missile1y
	php			;+6	71

	cpy missile0y
	php			;+6	 1
	

	dey			;+2	15

	cpy RepoLine		;+3	18
	beq RepoKernel		;+2	20
;	SLEEP 20		;+23	43

newrepo ; since we have time here, store next repoline
 ldx SpriteIndex
 lda SpriteGfxIndex-1,x
 tax
 lda NewSpriteY,x
 sta temp6

	tya			;+2	45
	and pfheight			;+2	47
	bne KernelLoopx		;+2	49
	dec pfpixelheight

	bmi sKernelLoopb		;+3	54


Kernel_entry
	cpy P0Top		;+3	69
	beq aSwitchDrawP0K1	;+2	71
	bpl aWaitDrawP0K1	;+2	73
	lda (player0pointer),Y	;+5	 2
	sta GRP0		;+3	 5	VDEL because of repokernel
BackFrom1
 ldx pfpixelheight
 lda msk_bgcolor+1,x
 cpy P1Bottom		;+3	 8	unless we mean to draw immediately, this should be set
 bcc SkipDrawbgcolor	;+2	10

; sleep 4
 sta COLUBK
 jmp backfrombgcolor


BackFromRepoKernel
	tya			;+2	45
	and pfheight			;+2	47
	bne KernelLoopa		;+2	49
	dec pfpixelheight
	bpl KernelLoopb		;+3	54
;	bmi donewkernel		;+3	54
;	bne KernelLoopb+1		;+3	54

donewkernel
	jmp DoneWithKernel	;+3	56



SkipDrawbgcolor
 sleep 3
 sta COLUBK				;	11
	lda #0
	sta GRP1			;+5	16	so Ball gets drawn
	beq BackFromSkipDrawP1		; branch always




aSwitchDrawP0K1				;	72
	lda P0Bottom
	sta P0Top			;+6	 2
	jmp BackFrom1

aWaitDrawP0K1				;	74
 sleep 4
	jmp BackFrom1

sKernelLoopb
	jmp DoneWithKernel	;+3	56

KernelLoopx
 sleep 7
 JMP KernelLoopa

lastkernelline
 sleep 9
 jmp cyclebalance

SwitchDrawP0KR				;	45
	lda P0Bottom
	sta P0Top			;+6	51
	jmp BackFromSwitchDrawP0KR	;+3	54

WaitDrawP0KR				;	47
	SLEEP 4				;+4	51
	jmp BackFromSwitchDrawP0KR	;+3	54

;-----------------------------------------------------------


noUpdateXKR
 echo *
 ldx #1
 sleep 3
 JMP retXKR

RepoKernel			;	22
	tya
	and.w pfheight			;+2	26
	bne noUpdateXKR		;+2	28
        tax
	dec pfpixelheight
 bmi donewkernel
retXKR
	cpy P0Top		;+3	42
	beq SwitchDrawP0KR	;+2	44
	bpl WaitDrawP0KR	;+2	46
	lda (player0pointer),Y	;+5	51
	sta GRP0		;+3	54	VDEL
BackFromSwitchDrawP0KR
;	sec			;+2	56
 
	lda PF2temp1,X
	ldy PF1temp1,X

	ldx SpriteIndex	;+3	 2

	sta PF2			;+7	63

	lda SpriteGfxIndex,x
	sty PF1			;+7	70	too early?
	tax
 anc #0 ; clear carry, zero in GRP1
	;lda #0
	sax GRP1 ; to display P0 - MSB of X is always zero
	lda NewSpriteX,X	;+4	 6
DivideBy15LoopK				;	 6	(carry set above)
	sbc #15
	bcs DivideBy15LoopK		;+4/5	10/15.../60

	tax				;+2	12/17/...62
	lda FineAdjustTableEnd,X	;+5	17/22/...67

	sta HMP1			;+3	20/25/...70
	sta RESP1			;+3	23/28/33/38/43/48/53/58/63/68/73
	sta WSYNC			;+3	 0	begin line 2
	;sta HMOVE			;+3	 3

	ldx #ENABL
	txs			;+4	25
	ldy RepoLine ; restore y
	cpy bally
	php			;+6	 9	VDEL ball

	cpy missile1y
	php			;+6	15

	cpy missile0y
	php			;+6	21
	

 


;15 cycles
	tya
	and pfheight
 ;eor #1
	and #$FE
	bne skipthis
 tax
 sleep 4
;	sleep 2
goback

	dey
	cpy P0Top			;+3	52
	beq SwitchDrawP0KV	;+2	54
	bpl WaitDrawP0KV		;+2	56
	lda (player0pointer),Y		;+5	61
	sta GRP0			;+3	64	VDEL
BackFromSwitchDrawP0KV

; sleep 3

	lda PF2temp1,X
	sta PF2			;+7	 5
	lda PF1temp1,X
	sta PF1			;+7	74 
 sta HMOVE

	lda #0
	sta GRP1			;+5	10	to display GRP0

	ldx #ENABL
	txs			;+4	 8

	ldx SpriteIndex	;+3	13	restore index into new sprite vars
	;--now, set all new variables and return to main kernel loop


;
	lda SpriteGfxIndex,X	;+4	31
	tax				;+2	33
;



	lda NewNUSIZ,X
	sta NUSIZ1			;+7	20
 sta REFP1
	lda NewCOLUP1,X
	sta COLUP1			;+7	27

;	lda SpriteGfxIndex,X	;+4	31
;	tax				;+2	33
;fuck2
	lda NewSpriteY,X		;+4	46
	sec				;+2	38
	sbc spriteheight,X	;+4	42
	sta P1Bottom		;+3	45

 sleep 4
	lda player1pointerlo,X	;+4	49
	sbc P1Bottom		;+3	52	carry should still be set
	sta P1display		;+3	55
	lda player1pointerhi,X
	sta P1display+1		;+7	62


	cpy bally
	php			;+6	68	VDELed

	cpy missile1y
	php			;+6	74

	cpy missile0y
	php			;+6	 4


	dec SpriteIndex	;+5	13

	bpl SetNextLine
	lda #255
	jmp SetLastLine
SetNextLine
	lda.w temp6
SetLastLine
	sta RepoLine	

 tya
 and pfheight
 bne nodec
 dec pfpixelheight
 bmi DoneWithKernel
	dey			;+2	30

; 10 cycles 
 

	jmp BackFromRepoKernel	;+3	43

nodec
 sleep 6
 dey
 jmp BackFromRepoKernel

;-------------------------------------------------------------------------

skipthis
 ldx #1
 jmp goback


SwitchDrawP0KV				;	69
	lda P0Bottom
	sta P0Top			;+6	75
	jmp BackFromSwitchDrawP0KV	;+3	 2

WaitDrawP0KV				;	71
	SLEEP 4				;+4	75
	jmp BackFromSwitchDrawP0KV	;+3	 2

;-------------------------------------------------------------------------

DoneWithKernel
BottomOfKernelLoop

 ldx pfpixelheight
 lda msk_bgcolor-255,x
 ldx #0
	sta WSYNC
 sta COLUBK
	stx GRP0
	stx GRP1
	stx ENABL
	stx ENAM0
	stx ENAM1
	stx PF0
	stx PF1
	stx PF2
	;end of kernel here
 ldx stack1
 txs
 jsr sixdigscore


 sta WSYNC
 ldx #0
 sta HMCLR
                STx GRP0
                STx GRP1 ; seems to be needed because of vdel

                LDY #7
        STy VDELP0
        STy VDELP1
        LDA #$10
        STA HMP1
               LDA scorecolor 
                STA COLUP0
                STA COLUP1
 
        LDA #$01 ; changed from #$03 for different copy player for 2 or 4 digit score
        STA NUSIZ0
        STA NUSIZ1

                STA RESP0
                STA RESP1

 sleep 9
 lda  (scorepointers),y
 sta  GRP0
 ifconst pfscore
 lda pfscorecolor
 sta COLUPF
 else
 sleep 6
 endif

                STA HMOVE
 lda  (scorepointers+8),y
; sta WSYNC
 ;sleep 2
 jmp beginscore


loop2
 lda  (scorepointers),y     ;+5  68  204
 sta  GRP0            ;+3  71  213      D1     --      --     --
 ifconst pfscore
 lda.w pfscore1
 sta PF1
 else
 sleep 7
 endif
 ; cycle 0
 lda  (scorepointers+$8),y  ;+5   5   15
beginscore
 sta  GRP1            ;+3   8   24      D1     D1      D2     --
 lda  (scorepointers+$6),y  ;+5  13   39
 sta  GRP0            ;+3  16   48      D3     D1      D2     D2
 lax  (scorepointers+$2),y  ;+5  29   87
 txs
 lax  (scorepointers+$4),y  ;+5  36  108
 sleep 3
 ifconst pfscore
 lda pfscore2
 sta PF1
 else
 sleep 6
 endif
 lda  (scorepointers+$A),y  ;+5  21   63
 stx  GRP1            ;+3  44  132      D3     D3      D4     D2!
 tsx
 stx  GRP0            ;+3  47  141      D5     D3!     D4     D4
 sta  GRP1            ;+3  50  150      D5     D5      D6     D4!
 sty  GRP0            ;+3  53  159      D4*    D5!     D6     D6
 dey
 bpl  loop2           ;+2  60  180
 	ldx stack1
	txs


; lda scorepointers+1
 ldy temp1
; sta temp1
 sty scorepointers+1

                LDA #0   
               STA GRP0
                STA GRP1
 sta PF1 
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


;-------------------------------------------------------------------------
;------------------------Overscan Routine---------------------------------
;-------------------------------------------------------------------------

OverscanRoutine



skipscore
	lda #2
	sta WSYNC
	sta VBLANK	;turn on VBLANK


	


;-------------------------------------------------------------------------
;----------------------------End Main Routines----------------------------
;-------------------------------------------------------------------------


;*************************************************************************

;-------------------------------------------------------------------------
;----------------------Begin Subroutines----------------------------------
;-------------------------------------------------------------------------




KernelCleanupSubroutine

	ldx #4
AdjustYValuesDownLoop
	lda NewSpriteY,X
	sec
	sbc #2
	sta NewSpriteY,X
	dex
	bpl AdjustYValuesDownLoop

 lda #0
 sta COLUBK
 RETURN
	;rts

SetupP1Subroutine
; flickersort algorithm
; count 4-0
; table2=table1 (?)
; detect overlap of sprites in table 2
; if overlap, do regular sort in table2, then place one sprite at top of table 1, decrement # displayed
; if no overlap, do regular sort in table 2 and table 1
fsstart
 ldx #255
copytable
 inx
 lda spritesort,x
 sta SpriteGfxIndex,x
 cpx #4
 bne copytable

 stx temp3 ; highest displayed sprite
 dex
 stx temp2
sortloop
 ldx temp2
 lda spritesort,x
 tax
 lda NewSpriteY,x
 sta temp1

 ldx temp2
 lda spritesort+1,x
 tax
 lda NewSpriteY,x
 sec
 sbc temp1
 bcc largerXislower

; larger x is higher (A>=temp1)
 cmp spriteheight,x
 bcs countdown
; overlap with x+1>x
; 
; stick x at end of gfxtable, dec counter
overlapping
 dec temp3
 ldx temp2
 inx
 jsr shiftnumbers
 jmp skipswapGfxtable

largerXislower ; (temp1>A)
 tay
 ldx temp2
 lda spritesort,x
 tax
 tya
 eor #$FF
 cmp spriteheight,x
 bcs notoverlapping

 dec temp3
 ldx temp2
 inx
 jsr shiftnumbers
 jmp skipswapGfxtable 
notoverlapping
 ldx temp2 ; swap display table
 ldy SpriteGfxIndex+1,x
 lda SpriteGfxIndex,x
 sty SpriteGfxIndex,x
 sta SpriteGfxIndex+1,x 

skipswapGfxtable
 ldx temp2 ; swap sort table
 ldy spritesort+1,x
 lda spritesort,x
 sty spritesort,x
 sta spritesort+1,x 

countdown
 dec temp2
 bpl sortloop

checktoohigh
 ldx temp3
 lda SpriteGfxIndex,x
 tax
 lda NewSpriteY,x
 ifconst screenheight
 cmp #screenheight-3
 else
 cmp #$55
 endif
 bcc nonetoohigh
 dec temp3
 bne checktoohigh

nonetoohigh
 rts


shiftnumbers
 ; stick current x at end, shift others down
 ; if x=4: don't do anything
 ; if x=3: swap 3 and 4
 ; if x=2: 2=3, 3=4, 4=2
 ; if x=1: 1=2, 2=3, 3=4, 4=1
 ; if x=0: 0=1, 1=2, 2=3, 3=4, 4=0
 ldy SpriteGfxIndex,x
swaploop
 cpx #4
 beq shiftdone 
 lda SpriteGfxIndex+1,x
 sta SpriteGfxIndex,x
 inx
 jmp swaploop
shiftdone
 sty SpriteGfxIndex,x
 rts

 ifconst debugscore
debugcycles
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

;   cmp #$2B
;   bcs no_cycles_left
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
   rts
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
 endif
;-------------------------------------------------------------------------
 
 ; room here for score?

setscorepointers
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
wastetime
 rts

scorepointerset
 and #$0F
 asl
 asl
 asl
 adc #<scoretable
 tay
 txa
 and #$F0
 lsr
 adc #<scoretable
 tax
 rts


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
game
.L00 ;  set smartbranching on

.L01 ;  dim rand1 = $DA

.L02 ;  set kernel multisprite

.L03 ;  set optimization speed

.L04 ;  set romsize 4k

.L05 ;  const screenheight = 88

.L06 ;  rem const noscore=1

.
 ; 

.L07 ;  const _mouseSpeed = 7

.
 ; 

.L08 ;  dim _up = a

.L09 ;  dim _down = b

.L010 ;  dim _left = c

.L011 ;  dim _right = d

.
 ; 

.L012 ;  COLUPF = 0

	LDA #0
	STA COLUPF
.L013 ;  pfheight = 0

	LDA #0
	STA pfheight
.L014 ;  playfield:

	LDA #<PF1_data0
	STA PF1pointer
	LDA #>PF1_data0
	STA PF1pointer+1
	LDA #<PF2_data0
	STA PF2pointer
	LDA #>PF2_data0
	STA PF2pointer+1
.
 ; 

.
 ; 

.L015 ;  player0x = 76 : player0y = 51 : COLUP0 = 0

	LDA #76
	STA player0x
	LDA #51
	STA player0y
	LDA #0
	STA COLUP0
.
 ; 

.
 ; 

.L016 ;  gosub __trashOG

 jsr .__trashOG

.L017 ;  player2x = 24 : player2y = 38

	LDA #24
	STA player2x
	LDA #38
	STA player2y
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L018 ;  gosub __file

 jsr .__file

.
 ; 

.L019 ;  player3x = 24 : player3y = 70

	LDA #24
	STA player3x
	LDA #70
	STA player3y
.L020 ;  player4x = 25 : player4y = 0

	LDA #25
	STA player4x
	LDA #0
	STA player4y
.L021 ;  player5x = 50 : player5y = 1 : COLUP5 = 0

	LDA #50
	STA player5x
	LDA #1
	STA player5y
	LDA #0
	STA COLUP5
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__main
 ; __main

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L022 ;  if joy0up  &&  _up < _mouseSpeed then _up = _up + 2

 lda #$10
 bit SWCHA
	BNE .skipL022
.condpart0
	LDA _up
	CMP #_mouseSpeed
     BCS .skip0then
.condpart1
	LDA _up
	CLC
	ADC #2
	STA _up
.skip0then
.skipL022
.L023 ;  if joy0down  &&  _down < _mouseSpeed then _down = _down + 2

 lda #$20
 bit SWCHA
	BNE .skipL023
.condpart2
	LDA _down
	CMP #_mouseSpeed
     BCS .skip2then
.condpart3
	LDA _down
	CLC
	ADC #2
	STA _down
.skip2then
.skipL023
.L024 ;  if joy0left  &&  _left < _mouseSpeed then _left = _left + 2

 bit SWCHA
	BVS .skipL024
.condpart4
	LDA _left
	CMP #_mouseSpeed
     BCS .skip4then
.condpart5
	LDA _left
	CLC
	ADC #2
	STA _left
.skip4then
.skipL024
.L025 ;  if joy0right  &&  _right < _mouseSpeed then _right = _right + 2

 bit SWCHA
	BMI .skipL025
.condpart6
	LDA _right
	CMP #_mouseSpeed
     BCS .skip6then
.condpart7
	LDA _right
	CLC
	ADC #2
	STA _right
.skip6then
.skipL025
.
 ; 

.L026 ;  if _up > 0 then _up = _up - 1

	LDA #0
	CMP _up
     BCS .skipL026
.condpart8
	DEC _up
.skipL026
.L027 ;  if _down > 0 then _down = _down - 1

	LDA #0
	CMP _down
     BCS .skipL027
.condpart9
	DEC _down
.skipL027
.L028 ;  if _left > 0 then _left = _left - 1

	LDA #0
	CMP _left
     BCS .skipL028
.condpart10
	DEC _left
.skipL028
.L029 ;  if _right > 0 then _right = _right - 1

	LDA #0
	CMP _right
     BCS .skipL029
.condpart11
	DEC _right
.skipL029
.
 ; 

.L030 ;  player0x = player0x + _right / 2

; complex statement detected
	LDA player0x
	PHA
	LDA _right
	lsr
	TSX
	INX
	TXS
	CLC
	ADC $00,x
	STA player0x
.L031 ;  player0x = player0x - _left / 2

; complex statement detected
	LDA player0x
	PHA
	LDA _left
	lsr
	TAY
	PLA
	TSX
	STY $00,x
	SEC
	SBC $00,x
	STA player0x
.L032 ;  player0y = player0y + _up / 2

; complex statement detected
	LDA player0y
	PHA
	LDA _up
	lsr
	TSX
	INX
	TXS
	CLC
	ADC $00,x
	STA player0y
.L033 ;  player0y = player0y - _down / 2

; complex statement detected
	LDA player0y
	PHA
	LDA _down
	lsr
	TAY
	PLA
	TSX
	STY $00,x
	SEC
	SBC $00,x
	STA player0y
.
 ; 

.L034 ;  if player0y > 90 then player0y = 90

	LDA #90
	CMP player0y
     BCS .skipL034
.condpart12
	LDA #90
	STA player0y
.skipL034
.L035 ;  if player0y < 11 then player0y = 11

	LDA player0y
	CMP #11
     BCS .skipL035
.condpart13
	LDA #11
	STA player0y
.skipL035
.L036 ;  if player0x > 200 then player0x = 0

	LDA #200
	CMP player0x
     BCS .skipL036
.condpart14
	LDA #0
	STA player0x
.skipL036
.L037 ;  if player0x > 143 then player0x = 143

	LDA #143
	CMP player0x
     BCS .skipL037
.condpart15
	LDA #143
	STA player0x
.skipL037
.
 ; 

.
 ; 

.L038 ;  if joy0fire then gosub __cursorLoad else gosub __cursor1

 bit INPT4
	BMI .skipL038
.condpart16
 jsr .__cursorLoad
 jmp .skipelse0
.skipL038
 jsr .__cursor1

.skipelse0
.L039 ;  drawscreen

 jsr drawscreen
.L040 ;  goto __main

 jmp .__main

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__cursor1
 ; __cursor1

.L041 ;  NUSIZ0 = $30

	LDA #$30
	STA NUSIZ0
.L042 ;  player0:

	LDX #<playerL042_0
	STX player0pointerlo
	LDA #>playerL042_0
	STA player0pointerhi
	LDA #15
	STA player0height
.L043 ;  return

	RTS
.
 ; 

.__cursorLoad
 ; __cursorLoad

.L044 ;  NUSIZ0 = $35

	LDA #$35
	STA NUSIZ0
.L045 ;  player0:

	LDX #<playerL045_0
	STX player0pointerlo
	LDA #>playerL045_0
	STA player0pointerhi
	LDA #15
	STA player0height
.L046 ;  return

	RTS
.
 ; 

.__trash
 ; __trash

.L047 ;  COLUP2 = 14

	LDA #14
	STA COLUP2
.L048 ;  NUSIZ2 = $35

	LDA #$35
	STA NUSIZ2
.L049 ;  player2:

	LDX #<playerL049_2
	STX player2pointerlo
	LDA #>playerL049_2
	STA player2pointerhi
	LDA #31
	STA player2height
.L050 ;  return

	RTS
.
 ; 

.__trashOG
 ; __trashOG

.L051 ;  COLUP2 = 14

	LDA #14
	STA COLUP2
.L052 ;  NUSIZ2 = $35

	LDA #$35
	STA NUSIZ2
.L053 ;  player2:

	LDX #<playerL053_2
	STX player2pointerlo
	LDA #>playerL053_2
	STA player2pointerhi
	LDA #31
	STA player2height
.L054 ;  return

	RTS
.
 ; 

.__file
 ; __file

.L055 ;  COLUP3 = 14

	LDA #14
	STA COLUP3
.L056 ;  NUSIZ3 = $35

	LDA #$35
	STA NUSIZ3
.L057 ;  player3:

	LDX #<playerL057_3
	STX player3pointerlo
	LDA #>playerL057_3
	STA player3pointerhi
	LDA #30
	STA player3height
.L058 ;  return

	RTS
.
 ; 

.__floppyA
 ; __floppyA

.L059 ;  COLUP3 = 14

	LDA #14
	STA COLUP3
.L060 ;  player3:

	LDX #<playerL060_3
	STX player3pointerlo
	LDA #>playerL060_3
	STA player3pointerhi
	LDA #9
	STA player3height
.L061 ;  return

	RTS
.
 ; 

.__floppyB
 ; __floppyB

.L062 ;  COLUP4 = 14

	LDA #14
	STA COLUP4
.L063 ;  player4:

	LDX #<playerL063_4
	STX player4pointerlo
	LDA #>playerL063_4
	STA player4pointerhi
	LDA #9
	STA player4height
.L064 ;  return

	RTS
.
 ; 

.
 ; 

.L065 ;  data msk_bgcolor

	JMP .skipL065
msk_bgcolor
	.byte  200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200

	.byte  200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200

	.byte  200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200

	.byte  200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200

	.byte  200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 0, 14, 14, 14

	.byte  14, 14, 14, 14, 14, 14

.skipL065
.
 ; 

.
 ; 

.L066 ;  asm

minikernel

   sta WSYNC

   lda 0

   sta COLUBK

   rts

.
 ; 

 if (<*) > (<(*+14))
	repeat ($100-<*)
	.byte 0
	repend
	endif
 if (<*) < 90
	repeat (90-<*)
	.byte 0
	repend
	endif
playerL042_0
	.byte 0
	.byte  %00000110
	.byte  %00000110
	.byte  %00001100
	.byte  %10001100
	.byte  %11011000
	.byte  %11111000
	.byte  %11111111
	.byte  %11111110
	.byte  %11111100
	.byte  %11111000
	.byte  %11110000
	.byte  %11100000
	.byte  %11000000
	.byte  %10000000
 if (<*) > (<(*+14))
	repeat ($100-<*)
	.byte 0
	repend
	endif
 if (<*) < 90
	repeat (90-<*)
	.byte 0
	repend
	endif
playerL045_0
	.byte 0
	.byte  %11111111
	.byte  %01101010
	.byte  %01010110
	.byte  %01101010
	.byte  %00110100
	.byte  %00101100
	.byte  %00011000
	.byte  %00011000
	.byte  %00110100
	.byte  %00101100
	.byte  %01010110
	.byte  %01001010
	.byte  %01000010
	.byte  %11111111
 if (<*) > (<(*+29))
	repeat ($100-<*)
	.byte 0
	repend
	endif
 if (<*) < 90
	repeat (90-<*)
	.byte 0
	repend
	endif
playerL049_2
	.byte  %11000011
	.byte  %10000001
	.byte  %01111110
	.byte  %01011010
	.byte  %01011010
	.byte  %01011010
	.byte  %01011010
	.byte  %01011010
	.byte  %01011010
	.byte  %01011010
	.byte  %01011010
	.byte  %01011010
	.byte  %01011010
	.byte  %01011010
	.byte  %01011010
	.byte  %01011010
	.byte  %01011010
	.byte  %01011010
	.byte  %01011010
	.byte  %01011010
	.byte  %01111110
	.byte  %10000001
	.byte  %00000000
	.byte  %01111110
	.byte  %01111110
	.byte  %01111110
	.byte  %10000001
	.byte  %11011011
	.byte  %11000011
	.byte  %11100111
 if (<*) > (<(*+29))
	repeat ($100-<*)
	.byte 0
	repend
	endif
 if (<*) < 90
	repeat (90-<*)
	.byte 0
	repend
	endif
playerL053_2
	.byte  %11111111
	.byte  %11000011
	.byte  %10111101
	.byte  %01000100
	.byte  %00010000
	.byte  %01010100
	.byte  %01010100
	.byte  %01010100
	.byte  %01010100
	.byte  %01010100
	.byte  %01010100
	.byte  %01010100
	.byte  %01010100
	.byte  %01010100
	.byte  %01010100
	.byte  %01010000
	.byte  %01000000
	.byte  %01001000
	.byte  %01010100
	.byte  %01010100
	.byte  %01010100
	.byte  %01010100
	.byte  %01010100
	.byte  %01111110
	.byte  %10000001
	.byte  %00111100
	.byte  %01111110
	.byte  %00100100
	.byte  %10011001
	.byte  %11100111
 if (<*) > (<(*+28))
	repeat ($100-<*)
	.byte 0
	repend
	endif
 if (<*) < 90
	repeat (90-<*)
	.byte 0
	repend
	endif
playerL057_3
	.byte  %00000011
	.byte  %01111011
	.byte  %01111011
	.byte  %01111011
	.byte  %00001001
	.byte  %00101001
	.byte  %01111001
	.byte  %01111001
	.byte  %00001000
	.byte  %00101000
	.byte  %00101000
	.byte  %00001000
	.byte  %01111000
	.byte  %01111000
	.byte  %01111000
	.byte  %01111000
	.byte  %01111000
	.byte  %01111000
	.byte  %01111000
	.byte  %00000000
	.byte  %01111000
	.byte  %00001000
	.byte  %10100000
	.byte  %10000000
	.byte  %10110000
	.byte  %11010110
	.byte  %11000110
	.byte  %11110101
	.byte  %11111001
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
 if (<*) < 90
	repeat (90-<*)
	.byte 0
	repend
	endif
playerL060_3
	.byte  %01011010
	.byte  %01000010
	.byte  %01011010
	.byte  %01100110
	.byte  %00000000
	.byte  %00111100
	.byte  %00110100
	.byte  %00110101
 if (<*) > (<(*+7))
	repeat ($100-<*)
	.byte 0
	repend
	endif
 if (<*) < 90
	repeat (90-<*)
	.byte 0
	repend
	endif
playerL063_4
	.byte  %01000110
	.byte  %01011010
	.byte  %01000110
	.byte  %01011010
	.byte  %00000000
	.byte  %00111100
	.byte  %00110100
	.byte  %00110101
 if ((>(*+80)) > (>*))
 ALIGN 256
 endif
PF1_data0
 .byte %11110000
 .byte %11110000
 .byte %11110000
 .byte %11110000
 .byte %11110000
 .byte %11110000
 .byte %11110000
 .byte %11110000
 .byte %11110000
 .byte %11110000
 .byte %11110000
 .byte %11110000
 .byte %11110000
 .byte %11110000
 .byte %11110000
 .byte %11110000
 .byte %11110000
 .byte %11110000
 .byte %11110000
 .byte %11110000
 .byte %11110000
 .byte %11110000
 .byte %11110000
 .byte %11110000
 .byte %11110000
 .byte %11110000
 .byte %11110000
 .byte %11110000
 .byte %11110000
 .byte %11110000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %11111111
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %11001101
 .byte %10101000
 .byte %10101101
 .byte %10101001
 .byte %11001100
 .byte %00000000
 if ((>(*+80)) > (>*))
 ALIGN 256
 endif
PF2_data0
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00000000
 .byte %00010100
 .byte %00010101
 .byte %00001101
 .byte %00010100
 .byte %00010101
 .byte %00000000
 if ECHOFIRST
       echo "    ",[(scoretable - *)]d , "bytes of ROM space left")
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
