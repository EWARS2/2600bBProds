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
 else
   ORG $F000
 endif
; This is a 2-line kernel!
kernel
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
 stx PF1
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
   ldx #128-44
 else
   ldx #132-pfres*4
 endif

 inc player1y

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

.kerloop ; enter at cycle 59??

continuekernel
 sleep 2
continuekernel2
 lda ballheight
 
 ifconst pfres
 ldy playfield+pfres*4-132,x
 sty PF1 ;3
 ldy playfield+pfres*4-131,x
 sty PF2 ;3
 ldy playfield+pfres*4-129,x
 sty PF1 ; 3 too early?
 ldy playfield+pfres*4-130,x
 sty PF2 ;3
 else
 ldy playfield+44-128,x ;4
 sty PF1 ;3
 ldy playfield+45-128,x ;4
 sty PF2 ;3
 ldy playfield+47-128,x ;4
 sty PF1 ; 3 too early?
 ldy playfield+46-128,x;4
 sty PF2 ;3
 endif

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
 lda playfield+pfres*4-132,x 
 sta PF1 ;3
 lda playfield+pfres*4-131,x 
 sta PF2 ;3
 lda playfield+pfres*4-129,x 
 sta PF1 ; 3 too early?
 lda playfield+pfres*4-130,x 
 sta PF2 ;3
 else
 lda playfield+44-128,x ;4
 sta PF1 ;3
 lda playfield+45-128,x ;4
 sta PF2 ;3
 lda playfield+47-128,x ;4
 sta PF1 ; 3 too early?
 lda playfield+46-128,x;4
 sta PF2 ;3
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
   sleep 12
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
   sbx #252
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
 sta PF1
 sta PF2


 ;sleep 3

 ;28 cycles to fix things
 ;minus 11=17

; lax temp4
; clc
 txa
 sbx #252

 bmi lastkernelline

 ifconst PFcolorandheight
   ldy playfieldcolorandheight-87,x
 ifnconst backgroundchange
   sty COLUPF
 else
   sty COLUBK
 endif
   lda playfieldcolorandheight-88,x
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
 sleep 4
 else
 ldx playfieldpos
 sleep 3
 endif

 jmp enterlastkernel

 else
lastkernelline
 
 ifconst PFheights
 ldx #1
 sleep 5
 else
   ldx playfieldpos
 sleep 4
 endif

   cpx #1
   bne .enterfromNBL
   jmp no_blank_lines_bailout
 endif

 if ((<*)>$d5)
 align 256
 endif
 ; this is a kludge to prevent page wrapping - fix!!!

.skipDrawlastP1
 sleep 2
 lda #0
 jmp .continuelastP1

.endkerloop ; enter at cycle 59??
 
 nop

.enterfromNBL
 ifconst pfres
 ldy.w playfield+pfres*4-4
 sty PF1 ;3
 ldy.w playfield+pfres*4-3
 sty PF2 ;3
 ldy.w playfield+pfres*4-1
 sty PF1 ; possibly too early?
 ldy.w playfield+pfres*4-2
 sty PF2 ;3
 else
 ldy.w playfield+44
 sty PF1 ;3
 ldy.w playfield+45
 sty PF2 ;3
 ldy.w playfield+47
 sty PF1 ; possibly too early?
 ldy.w playfield+46
 sty PF2 ;3
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
 ldy.w playfield+pfres*4-4
 sty PF1 ;3
 ldy.w playfield+pfres*4-3
 sty PF2 ;3
 ldy.w playfield+pfres*4-1
 sty PF1 ; possibly too early?
 ldy.w playfield+pfres*4-2
 sty PF2 ;3
 else
 ldy.w playfield+44
 sty PF1 ;3
 ldy.w playfield+45
 sty PF2 ;3
 ldy.w playfield+47
 sty PF1 ; possibly too early?
 ldy.w playfield+46
 sty PF2 ;3
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
 sleep 14
 jmp .endkerloop
 endif
 endif


;  ifconst donepaddleskip
;paddleskipread
 ; this is kind of lame, since it requires 4 cycles from a page boundary crossing
 ; plus we get a lo-res paddle read
; bmi donepaddleskip
;  endif

.skipDrawlastP0
 sleep 2
 lda #0
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

;                STA WSYNC ;first one, need one more
 sta REFP0
 sta REFP1
                STA GRP0
                STA GRP1
 ;               STA PF1
   ;             STA PF2
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

 ifconst no_blank_lines
 sta WSYNC
 endif

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
 ldx #$10
 stx HMP0

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
 sta scorepointers+5,x
 sta temp2,x
 sta temp4,x
 sta temp6,x
                LDY #7
                STA RESP0
                STA RESP1


        LDA #$03
        STA NUSIZ0
        STA NUSIZ1,x
        STA VDELP0
        STA VDELP1
        LDA #$20
        STA HMP1
               LDA scorecolor 
;               STA HMCLR
;               STA WSYNC; second one
                STA HMOVE ; cycle 73 ?

                STA COLUP0
                STA COLUP1
 lda  (scorepointers),y
 sta  GRP0
 ifconst pfscore
 lda pfscorecolor
 sta COLUPF
 endif
 lda  (scorepointers+8),y
 sta WSYNC
 sleep 2
 jmp beginscore

 if ((<*)>$d4)
 align 256 ; kludge that potentially wastes space!  should be fixed!
 endif

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
 LDA #%11000010
 sta WSYNC
 STA VBLANK
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
 ifconst pfrowheight
 lda pfrowheight
 else
 ifconst pfres
 lda #(96/pfres)
 else
 lda #8
 endif
 endif
 sta playfieldpos
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
; playfield drawing routines
; you get a 32x12 bitmapped display in a single color :)
; 0-31 and 0-11

pfclear ; clears playfield - or fill with pattern
 ifconst pfres
 ldx #pfres*4-1
 else
 ldx #47
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
 asl ; multiply y pos by 4
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
 asl ; multiply by 4
 sta temp3 ; store it
 ; Thanks to Michael Rideout for fixing a bug in this code
 ; right now, temp1=y=starting memory location, temp3=final
 ; x should equal original x value
keepgoingy
 jsr plotpoint
 iny
 iny
 iny
 iny
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
;   cmp #$2B
;   BCC overscan
   bmi overscan
   sta COLUBK
   bcs doneoverscan
 endif

 
overscan
 lda INTIM ;wait for sync
 bmi overscan
doneoverscan
;do VSYNC
 lda #2
 sta WSYNC
 sta VSYNC
 STA WSYNC
 STA WSYNC
 LDA #0
 STA WSYNC
 STA VSYNC
 sta VBLANK
 ifnconst overscan_time
 lda #37+128
 else
 lda #overscan_time+128
 endif
 sta TIM64T

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
 if (<*)>$F0
 align 256, $EA
 endif
  sta WSYNC
  ldx #4
  SLEEP 3
HorPosLoop       ;     5
  lda player0x,X  ;+4   9
  sec           ;+2  11
DivideLoop
  sbc #15
  bcs DivideLoop;+4  15
  sta temp1,X    ;+4  19
  sta RESP0,X   ;+4  23
  sta WSYNC
  dex
  bpl HorPosLoop;+5   5
                ;     4

  ldx #4
  ldy temp1,X
  lda repostable-256,Y
  sta HMP0,X    ;+14 18

  dex
  ldy temp1,X
  lda repostable-256,Y
  sta HMP0,X    ;+14 32

  dex
  ldy temp1,X
  lda repostable-256,Y
  sta HMP0,X    ;+14 46

  dex
  ldy temp1,X
  lda repostable-256,Y
  sta HMP0,X    ;+14 60

  dex
  ldy temp1,X
  lda repostable-256,Y
  sta HMP0,X    ;+14 74

  sta WSYNC
 
  sta HMOVE     ;+3   3


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
; y and a contain multiplicands, result in a

mul8
 sty temp1
 sta temp2
 lda #0
reptmul8
 lsr temp2
 bcc skipmul8
 clc
 adc temp1
;bcs donemul8 might save cycles?
skipmul8
;beq donemul8 might save cycles?
 asl temp1
 bne reptmul8
donemul8
 RETURN

div8
 ; a=numerator y=denominator, result in a
 cpy #2
 bcc div8end+1;div by 0 = bad, div by 1=no calc needed, so bail out
 sty temp1
 ldy #$ff
div8loop
 sbc temp1
 iny
 bcs div8loop
div8end
 tya
 ; result in a
 RETURN
game
.L00 ;  include div_mul.asm

.
 ; 

.L01 ;  rem ********************************

.L02 ;  rem * ZACHARY HINCHLIFFE FRESENTS: *

.L03 ;  rem *      SUPER 3D PORTALS 6      *

.L04 ;  rem ********************************

.
 ; 

.title
 ; title

.L05 ;  COLUPF  =  222

	LDA #222
	STA COLUPF
.L06 ;  playfield:

  ifconst pfres
    ldx #4*pfres-1
  else
	  ldx #47
  endif
	jmp pflabel0
PF_data0
	.byte %01101010, %01110111, %11100001, %00011001
	.byte %10001010, %00010101, %10100000, %00101010
	.byte %11101010, %00110111, %11100001, %00101011
	.byte %00101010, %00010001, %11000000, %00101010
	.byte %11001110, %01110001, %10100001, %00011001
	.byte %00000000, %00000000, %00000000, %00000000
	.byte %11101110, %01110111, %01001000, %01100011
	.byte %10101010, %00100101, %10101001, %00010000
	.byte %11101010, %00100111, %11101001, %01110011
	.byte %10001010, %00100011, %10101000, %01010010
	.byte %10001110, %00100101, %10101101, %01110001
pflabel0
	lda PF_data0,x
	sta playfield,x
	dex
	bpl pflabel0
.L07 ;  drawscreen

 jsr drawscreen
.L08 ;  if joy0fire then goto begin

 lda #$80
 bit INPT4
	BNE .skipL08
.condpart0
 jmp .begin

.skipL08
.
 ; 

.L09 ;  r  =  r  +  1

	INC r
.
 ; 

.L010 ;  if r > 0  &&  r < 8 then AUDV0  =  10  :  AUDC0  =  12  :  AUDF0  =  27

	LDA #0
	CMP r
     BCS .skipL010
.condpart1
	LDA r
	CMP #8
     BCS .skip1then
.condpart2
	LDA #10
	STA AUDV0
	LDA #12
	STA AUDC0
	LDA #27
	STA AUDF0
.skip1then
.skipL010
.L011 ;  if r > 7  &&  r < 16 then AUDV0  =  10  :  AUDC0  =  12  :  AUDF0  =  15

	LDA #7
	CMP r
     BCS .skipL011
.condpart3
	LDA r
	CMP #16
     BCS .skip3then
.condpart4
	LDA #10
	STA AUDV0
	LDA #12
	STA AUDC0
	LDA #15
	STA AUDF0
.skip3then
.skipL011
.L012 ;  if r > 15  &&  r < 24 then AUDV0  =  10  :  AUDC0  =  12  :  AUDF0  =  16

	LDA #15
	CMP r
     BCS .skipL012
.condpart5
	LDA r
	CMP #24
     BCS .skip5then
.condpart6
	LDA #10
	STA AUDV0
	LDA #12
	STA AUDC0
	LDA #16
	STA AUDF0
.skip5then
.skipL012
.L013 ;  if r > 23  &&  r < 32 then AUDV0  =  10  :  AUDC0  =  12  :  AUDF0  =  18

	LDA #23
	CMP r
     BCS .skipL013
.condpart7
	LDA r
	CMP #32
     BCS .skip7then
.condpart8
	LDA #10
	STA AUDV0
	LDA #12
	STA AUDC0
	LDA #18
	STA AUDF0
.skip7then
.skipL013
.L014 ;  if r > 31  &&  r < 40 then AUDV0  =  10  :  AUDC0  =  12  :  AUDF0  =  18

	LDA #31
	CMP r
     BCS .skipL014
.condpart9
	LDA r
	CMP #40
     BCS .skip9then
.condpart10
	LDA #10
	STA AUDV0
	LDA #12
	STA AUDC0
	LDA #18
	STA AUDF0
.skip9then
.skipL014
.L015 ;  if r > 39  &&  r < 48 then AUDV0  =  10  :  AUDC0  =  12  :  AUDF0  =  16  :  AUDV1  =  10  :  AUDC1  =  1  :  AUDF1  =  16

	LDA #39
	CMP r
     BCS .skipL015
.condpart11
	LDA r
	CMP #48
     BCS .skip11then
.condpart12
	LDA #10
	STA AUDV0
	LDA #12
	STA AUDC0
	LDA #16
	STA AUDF0
	LDA #10
	STA AUDV1
	LDA #1
	STA AUDC1
	LDA #16
	STA AUDF1
.skip11then
.skipL015
.L016 ;  if r > 47  &&  r < 120 then AUDV0  =  0

	LDA #47
	CMP r
     BCS .skipL016
.condpart13
	LDA r
	CMP #120
     BCS .skip13then
.condpart14
	LDA #0
	STA AUDV0
.skip13then
.skipL016
.L017 ;  if r > 119  &&  r < 128 then AUDV0  =  10  :  AUDC0  =  12  :  AUDF0  =  27

	LDA #119
	CMP r
     BCS .skipL017
.condpart15
	LDA r
	CMP #128
     BCS .skip15then
.condpart16
	LDA #10
	STA AUDV0
	LDA #12
	STA AUDC0
	LDA #27
	STA AUDF0
.skip15then
.skipL017
.L018 ;  if r > 127  &&  r < 136 then AUDV0  =  10  :  AUDC0  =  12  :  AUDF0  =  15

	LDA #127
	CMP r
     BCS .skipL018
.condpart17
	LDA r
	CMP #136
     BCS .skip17then
.condpart18
	LDA #10
	STA AUDV0
	LDA #12
	STA AUDC0
	LDA #15
	STA AUDF0
.skip17then
.skipL018
.L019 ;  if r > 135  &&  r < 144 then AUDV0  =  10  :  AUDC0  =  12  :  AUDF0  =  16

	LDA #135
	CMP r
     BCS .skipL019
.condpart19
	LDA r
	CMP #144
     BCS .skip19then
.condpart20
	LDA #10
	STA AUDV0
	LDA #12
	STA AUDC0
	LDA #16
	STA AUDF0
.skip19then
.skipL019
.L020 ;  if r > 143  &&  r < 152 then AUDV0  =  10  :  AUDC0  =  12  :  AUDF0  =  18

	LDA #143
	CMP r
     BCS .skipL020
.condpart21
	LDA r
	CMP #152
     BCS .skip21then
.condpart22
	LDA #10
	STA AUDV0
	LDA #12
	STA AUDC0
	LDA #18
	STA AUDF0
.skip21then
.skipL020
.L021 ;  if r > 151  &&  r < 160 then AUDV0  =  10  :  AUDC0  =  12  :  AUDF0  =  18

	LDA #151
	CMP r
     BCS .skipL021
.condpart23
	LDA r
	CMP #160
     BCS .skip23then
.condpart24
	LDA #10
	STA AUDV0
	LDA #12
	STA AUDC0
	LDA #18
	STA AUDF0
.skip23then
.skipL021
.L022 ;  if r > 159  &&  r < 168 then AUDV0  =  10  :  AUDC0  =  12  :  AUDF0  =  16

	LDA #159
	CMP r
     BCS .skipL022
.condpart25
	LDA r
	CMP #168
     BCS .skip25then
.condpart26
	LDA #10
	STA AUDV0
	LDA #12
	STA AUDC0
	LDA #16
	STA AUDF0
.skip25then
.skipL022
.L023 ;  if r > 167  &&  r < 192 then AUDV0  =  0

	LDA #167
	CMP r
     BCS .skipL023
.condpart27
	LDA r
	CMP #192
     BCS .skip27then
.condpart28
	LDA #0
	STA AUDV0
.skip27then
.skipL023
.L024 ;  if r > 191  &&  r < 208 then AUDV0  =  10  :  AUDC0  =  12  :  AUDF0  =  20

	LDA #191
	CMP r
     BCS .skipL024
.condpart29
	LDA r
	CMP #208
     BCS .skip29then
.condpart30
	LDA #10
	STA AUDV0
	LDA #12
	STA AUDC0
	LDA #20
	STA AUDF0
.skip29then
.skipL024
.L025 ;  if r > 207  &&  r < 216 then AUDV0  =  10  :  AUDC0  =  12  :  AUDF0  =  18

	LDA #207
	CMP r
     BCS .skipL025
.condpart31
	LDA r
	CMP #216
     BCS .skip31then
.condpart32
	LDA #10
	STA AUDV0
	LDA #12
	STA AUDC0
	LDA #18
	STA AUDF0
.skip31then
.skipL025
.L026 ;  if r > 215  &&  r < 224 then AUDV0  =  10  :  AUDC0  =  12  :  AUDF0  =  27  :  AUDV1  =  10  :  AUDC1  =  1  :  AUDF1  =  22

	LDA #215
	CMP r
     BCS .skipL026
.condpart33
	LDA r
	CMP #224
     BCS .skip33then
.condpart34
	LDA #10
	STA AUDV0
	LDA #12
	STA AUDC0
	LDA #27
	STA AUDF0
	LDA #10
	STA AUDV1
	LDA #1
	STA AUDC1
	LDA #22
	STA AUDF1
.skip33then
.skipL026
.L027 ;  if r > 223  &&  r < 248 then AUDV0  =  0

	LDA #223
	CMP r
     BCS .skipL027
.condpart35
	LDA r
	CMP #248
     BCS .skip35then
.condpart36
	LDA #0
	STA AUDV0
.skip35then
.skipL027
.L028 ;  if r > 247 then r  =  1

	LDA #247
	CMP r
     BCS .skipL028
.condpart37
	LDA #1
	STA r
.skipL028
.
 ; 

.L029 ;  goto title

 jmp .title

.
 ; 

.begin
 ; begin

.L030 ;  AUDV0  =  0  :  AUDV1  =  0

	LDA #0
	STA AUDV0
	STA AUDV1
.L031 ;  score  =  1

	LDA #$01
	STA score+2
	LDA #$00
	STA score+1
	LDA #$00
	STA score
.L032 ;  player0x  =  128

	LDA #128
	STA player0x
.L033 ;  player0y  =  68

	LDA #68
	STA player0y
.
 ; 

.L034 ;  missile0height  =  4

	LDA #4
	STA missile0height
.L035 ;  missile1height  =  4

	LDA #4
	STA missile1height
.
 ; 

.L036 ;  f  =  missile0x

	LDA missile0x
	STA f
.L037 ;  g  =  missile0y

	LDA missile0y
	STA g
.L038 ;  h  =  missile1x

	LDA missile1x
	STA h
.L039 ;  i  =  missile1y

	LDA missile1y
	STA i
.L040 ;  goto start

 jmp .start

.
 ; 

.
 ; 

.start
 ; start

.L041 ;  if switchreset then reboot

 lda #1
 bit SWCHB
	BNE .skipL041
.condpart38
	JMP ($FFFC)
.skipL041
.
 ; 

.L042 ;  const pfscore = 0

.
 ; 

.L043 ;  COLUP0  =  56

	LDA #56
	STA COLUP0
.L044 ;  COLUP1  =  138

	LDA #138
	STA COLUP1
.L045 ;  COLUPF  =  222

	LDA #222
	STA COLUPF
.L046 ;  scorecolor  =  222

	LDA #222
	STA scorecolor
.L047 ;  pfscorecolor  =  222

	LDA #222
	STA pfscorecolor
.L048 ;  NUSIZ0 = $20

	LDA #$20
	STA NUSIZ0
.L049 ;  NUSIZ1 = $20

	LDA #$20
	STA NUSIZ1
.
 ; 

.L050 ;  if a  >  9 then a = 0

	LDA #9
	CMP a
     BCS .skipL050
.condpart39
	LDA #0
	STA a
.skipL050
.
 ; 

.L051 ;  on a goto level1 level2 level3 level4 level5 level6 level7 level8 level9 level10

	LDX a
	LDA .L051jumptablehi,x
	PHA
	LDA .L051jumptablelo,x
	PHA
	RTS
.L051jumptablehi
	.byte >(.level1-1)
	.byte >(.level2-1)
	.byte >(.level3-1)
	.byte >(.level4-1)
	.byte >(.level5-1)
	.byte >(.level6-1)
	.byte >(.level7-1)
	.byte >(.level8-1)
	.byte >(.level9-1)
	.byte >(.level10-1)
.L051jumptablelo
	.byte <(.level1-1)
	.byte <(.level2-1)
	.byte <(.level3-1)
	.byte <(.level4-1)
	.byte <(.level5-1)
	.byte <(.level6-1)
	.byte <(.level7-1)
	.byte <(.level8-1)
	.byte <(.level9-1)
	.byte <(.level10-1)
.L052 ;  rem level11 level12 level13 level14 level15 level16

.
 ; 

.level1 ; level1 playfield:

  ifconst pfres
    ldx #4*pfres-1
  else
	  ldx #47
  endif
	jmp pflabel1
PF_data1
	.byte %11111111, %11111111, %11111111, %11111111
	.byte %10000000, %00000000, %00000000, %10000000
	.byte %11111111, %11111111, %11100000, %10000000
	.byte %11111111, %11111111, %11000000, %10000000
	.byte %10000000, %00000000, %00000001, %11111111
	.byte %10000000, %11111110, %11111111, %10000000
	.byte %10000000, %11111110, %11111110, %10000000
	.byte %10000000, %00000000, %00000000, %10000000
	.byte %11111111, %11111111, %11111110, %10000000
	.byte %11111111, %11111111, %11111110, %10000000
	.byte %11111111, %11111111, %11111111, %11111111
pflabel1
	lda PF_data1,x
	sta playfield,x
	dex
	bpl pflabel1
.L053 ;  ballx  =  24

	LDA #24
	STA ballx
.L054 ;  bally  =  13

	LDA #13
	STA bally
.L055 ;  goto main

 jmp .main

.
 ; 

.level2 ; level2 playfield:

  ifconst pfres
    ldx #4*pfres-1
  else
	  ldx #47
  endif
	jmp pflabel2
PF_data2
	.byte %11111111, %11111111, %11111111, %11111111
	.byte %10000000, %00000000, %00000000, %10000000
	.byte %11111111, %00000001, %00000000, %10000000
	.byte %11111111, %00000001, %00000000, %10000000
	.byte %11111111, %00000001, %00000000, %10000000
	.byte %11111111, %00000001, %00000000, %10000000
	.byte %11111111, %00000001, %00000000, %11100000
	.byte %11111111, %00000001, %00000000, %11100000
	.byte %11111111, %00000001, %00000000, %11100000
	.byte %11111111, %00000001, %00000000, %11100000
	.byte %11111111, %11111111, %11111111, %11111111
pflabel2
	lda PF_data2,x
	sta playfield,x
	dex
	bpl pflabel2
.L056 ;  ballx  =  135

	LDA #135
	STA ballx
.L057 ;  bally  =  42

	LDA #42
	STA bally
.L058 ;  goto main

 jmp .main

.
 ; 

.level3 ; level3 playfield:

  ifconst pfres
    ldx #4*pfres-1
  else
	  ldx #47
  endif
	jmp pflabel3
PF_data3
	.byte %11111111, %11111111, %11111111, %11111111
	.byte %10000000, %00000000, %00000000, %10011000
	.byte %11111100, %00000000, %00000000, %10011000
	.byte %11111100, %00000000, %00000000, %10011000
	.byte %10000011, %00000011, %00000000, %10011000
	.byte %10000011, %00000011, %00000000, %10011000
	.byte %10000000, %00000000, %00000000, %10011000
	.byte %10000000, %00000000, %00000000, %10011000
	.byte %11111111, %11111111, %00000000, %10011000
	.byte %11111111, %11111111, %11111110, %10000000
	.byte %11111111, %11111111, %11111111, %11111111
pflabel3
	lda PF_data3,x
	sta playfield,x
	dex
	bpl pflabel3
.L059 ;  ballx  =  24

	LDA #24
	STA ballx
.L060 ;  bally  =  13

	LDA #13
	STA bally
.L061 ;  goto main

 jmp .main

.
 ; 

.level4 ; level4 playfield:

  ifconst pfres
    ldx #4*pfres-1
  else
	  ldx #47
  endif
	jmp pflabel4
PF_data4
	.byte %11111111, %11111111, %11111111, %11111111
	.byte %10000000, %00000110, %00000000, %11111111
	.byte %11110000, %11100110, %11111100, %11111111
	.byte %11110000, %01100110, %00000000, %11111111
	.byte %11110000, %01100110, %01111111, %10000111
	.byte %11110000, %01100000, %00000100, %10000000
	.byte %11110000, %01100000, %01100100, %11100111
	.byte %11111111, %01111111, %01100100, %11100111
	.byte %11111111, %01111111, %01100100, %11111111
	.byte %11111111, %01111111, %01100000, %11111111
	.byte %11111111, %11111111, %11111111, %11111111
pflabel4
	lda PF_data4,x
	sta playfield,x
	dex
	bpl pflabel4
.L062 ;  ballx  =  135

	LDA #135
	STA ballx
.L063 ;  bally  =  42

	LDA #42
	STA bally
.L064 ;  goto main

 jmp .main

.
 ; 

.level5 ; level5 playfield:

  ifconst pfres
    ldx #4*pfres-1
  else
	  ldx #47
  endif
	jmp pflabel5
PF_data5
	.byte %11111111, %11111111, %11111111, %11111111
	.byte %10000000, %00000000, %00000000, %10000000
	.byte %11111111, %11111111, %11111110, %10000000
	.byte %11111111, %11111111, %11111110, %10000000
	.byte %10000000, %00000000, %00000000, %10000000
	.byte %10000000, %00000000, %00000000, %10000000
	.byte %10000000, %00000000, %00000000, %10000000
	.byte %10000000, %00000000, %00000000, %10000000
	.byte %10000000, %00000000, %00000000, %10000000
	.byte %10000000, %00000000, %00000000, %10000000
	.byte %11111111, %11111111, %11111111, %11111111
pflabel5
	lda PF_data5,x
	sta playfield,x
	dex
	bpl pflabel5
.L065 ;  ballx  =  24

	LDA #24
	STA ballx
.L066 ;  bally  =  13

	LDA #13
	STA bally
.L067 ;  goto main

 jmp .main

.
 ; 

.level6 ; level6 playfield:

  ifconst pfres
    ldx #4*pfres-1
  else
	  ldx #47
  endif
	jmp pflabel6
PF_data6
	.byte %11111111, %11111111, %11111111, %11111111
	.byte %10000000, %00000000, %00000000, %10000010
	.byte %10000000, %00000000, %00000000, %10000010
	.byte %10000000, %00000000, %00000000, %10000010
	.byte %11000000, %00000000, %00000000, %10000010
	.byte %11100000, %11110000, %11111000, %10000010
	.byte %11110000, %11110000, %11111000, %11100010
	.byte %11111000, %11110000, %11111000, %11100000
	.byte %11111100, %11110000, %11111000, %11100000
	.byte %11111110, %11110000, %11111000, %11100000
	.byte %11111111, %11111111, %11111111, %11111111
pflabel6
	lda PF_data6,x
	sta playfield,x
	dex
	bpl pflabel6
.L068 ;  ballx  =  135

	LDA #135
	STA ballx
.L069 ;  bally  =  42

	LDA #42
	STA bally
.L070 ;  goto main

 jmp .main

.
 ; 

.level7 ; level7 playfield:

  ifconst pfres
    ldx #4*pfres-1
  else
	  ldx #47
  endif
	jmp pflabel7
PF_data7
	.byte %11111111, %11111111, %11111111, %11111111
	.byte %10011001, %01100001, %00000110, %10011000
	.byte %10011000, %00011000, %01100110, %10011000
	.byte %10011001, %01100001, %01100110, %10011000
	.byte %10011001, %00011001, %01100000, %10011000
	.byte %10011001, %01100001, %01100110, %10011000
	.byte %10011001, %00011001, %01100110, %10011000
	.byte %10011001, %01100001, %01100110, %10011000
	.byte %10011001, %00011001, %01100110, %10011000
	.byte %10000001, %10000001, %11100110, %10000000
	.byte %11111111, %11111111, %11111111, %11111111
pflabel7
	lda PF_data7,x
	sta playfield,x
	dex
	bpl pflabel7
.L071 ;  ballx  =  24

	LDA #24
	STA ballx
.L072 ;  bally  =  13

	LDA #13
	STA bally
.L073 ;  goto main

 jmp .main

.
 ; 

.level8 ; level8 playfield:

  ifconst pfres
    ldx #4*pfres-1
  else
	  ldx #47
  endif
	jmp pflabel8
PF_data8
	.byte %11111111, %11111111, %11111111, %11111111
	.byte %10000000, %11110010, %00111100, %11011101
	.byte %11111100, %01100111, %00011001, %11000001
	.byte %11111001, %00001111, %11000011, %11011101
	.byte %11110011, %10011111, %11100111, %11011101
	.byte %11100111, %11111111, %11111111, %11011101
	.byte %11001111, %00000011, %00000000, %11000000
	.byte %10000000, %11111000, %11111111, %11111111
	.byte %11111111, %00000011, %00000000, %11000000
	.byte %11111111, %11111111, %11111111, %11111111
	.byte %11111111, %11111111, %11111111, %11111111
pflabel8
	lda PF_data8,x
	sta playfield,x
	dex
	bpl pflabel8
.L074 ;  ballx  =  135

	LDA #135
	STA ballx
.L075 ;  bally  =  42

	LDA #42
	STA bally
.L076 ;  goto main

 jmp .main

.
 ; 

.level9 ; level9 playfield:

  ifconst pfres
    ldx #4*pfres-1
  else
	  ldx #47
  endif
	jmp pflabel9
PF_data9
	.byte %11111111, %11111111, %11111111, %11111111
	.byte %10001000, %00100000, %00000000, %00110000
	.byte %10000100, %00100010, %01000000, %10011000
	.byte %11000010, %01000100, %00100000, %10011000
	.byte %11100001, %10001000, %00010000, %10011000
	.byte %11110000, %00010001, %10001000, %10011000
	.byte %11111000, %00100010, %01000100, %10011000
	.byte %11111100, %01000100, %00100010, %10011000
	.byte %11111110, %10001000, %00010001, %10011000
	.byte %11111111, %00000000, %10000000, %10000001
	.byte %11111111, %11111111, %11111111, %11111111
pflabel9
	lda PF_data9,x
	sta playfield,x
	dex
	bpl pflabel9
.L077 ;  ballx  =  24

	LDA #24
	STA ballx
.L078 ;  bally  =  13

	LDA #13
	STA bally
.L079 ;  goto main

 jmp .main

.
 ; 

.level10 ; level10 playfield:

  ifconst pfres
    ldx #4*pfres-1
  else
	  ldx #47
  endif
	jmp pflabel10
PF_data10
	.byte %11111111, %11111111, %11111111, %11111111
	.byte %10000000, %11111110, %11111111, %11111111
	.byte %11000000, %11001111, %11111111, %11111111
	.byte %11100001, %00001111, %00000000, %10000000
	.byte %11110011, %11001111, %11111111, %10011111
	.byte %11110011, %00001111, %00000000, %10011100
	.byte %11100001, %11111111, %11111111, %10011100
	.byte %11000000, %00000011, %00110000, %10011100
	.byte %10000000, %01100000, %00000011, %11111100
	.byte %11111111, %11111111, %11111111, %11111111
	.byte %11111111, %11111111, %11111111, %11111111
pflabel10
	lda PF_data10,x
	sta playfield,x
	dex
	bpl pflabel10
.L080 ;  ballx  =  135

	LDA #135
	STA ballx
.L081 ;  bally  =  42

	LDA #42
	STA bally
.L082 ;  goto main

 jmp .main

.
 ; 

.main
 ; main

.
 ; 

.L083 ;  rem playfield is 32 by 11 (128 by 88)

.L084 ;  rem screen is 160 by 88

.
 ; 

.L085 ;  b  =   ( player0x  -  13 )   /  4

; complex statement detected
	LDA player0x
	SEC
	SBC #13
	lsr
	lsr
	STA b
.L086 ;  k  =   ( player0x  -  9 )   /  4

; complex statement detected
	LDA player0x
	SEC
	SBC #9
	lsr
	lsr
	STA k
.L087 ;  n  =   ( player0x  -  17 )   /  4

; complex statement detected
	LDA player0x
	SEC
	SBC #17
	lsr
	lsr
	STA n
.L088 ;  l  =   ( player0y )   /  8

; complex statement detected
	LDA player0y
	lsr
	lsr
	lsr
	STA l
.L089 ;  m  =   ( player0y  -  4 )   /  8

; complex statement detected
	LDA player0y
	SEC
	SBC #4
	lsr
	lsr
	lsr
	STA m
.L090 ;  p  =   ( player0y  -  7 )   /  8

; complex statement detected
	LDA player0y
	SEC
	SBC #7
	lsr
	lsr
	lsr
	STA p
.
 ; 

.L091 ;  if joy0left then player0x  =  player0x  -  1

 lda #$40
 bit SWCHA
	BNE .skipL091
.condpart40
	DEC player0x
.skipL091
.L092 ;  if joy0right then player0x  =  player0x  +  1

 lda #$80
 bit SWCHA
	BNE .skipL092
.condpart41
	INC player0x
.skipL092
.
 ; 

.L093 ;  rem fall if not touching ground

.L094 ;  if !pfread ( b , l )  then player0y  =  player0y  +  1

	LDA b
	LDY l
 jsr pfread
	BEQ .skipL094
.condpart42
	INC player0y
.skipL094
.
 ; 

.L095 ;  rem push left if in right wall

.L096 ;  if pfread ( k , m )  then player0x  =  player0x  -  1

	LDA k
	LDY m
 jsr pfread
	BNE .skipL096
.condpart43
	DEC player0x
.skipL096
.
 ; 

.L097 ;  rem push right if in left wall

.L098 ;  if pfread ( n , m )  then player0x  =  player0x  +  1

	LDA n
	LDY m
 jsr pfread
	BNE .skipL098
.condpart44
	INC player0x
.skipL098
.
 ; 

.L099 ;  rem push down if in ceiling

.L0100 ;  if pfread ( b , p )  then player0y  =  player0y  +  1

	LDA b
	LDY p
 jsr pfread
	BNE .skipL0100
.condpart45
	INC player0y
.skipL0100
.
 ; 

.L0101 ;  if collision(playfield,missile0) then d  =  c

	BIT CXM0FB
	BPL .skipL0101
.condpart46
	LDA c
	STA d
.skipL0101
.L0102 ;  if missile0x = f  &&  missile0y = g then d  =  c

	LDA missile0x
	CMP f
     BNE .skipL0102
.condpart47
	LDA missile0y
	CMP g
     BNE .skip47then
.condpart48
	LDA c
	STA d
.skip47then
.skipL0102
.L0103 ;  if missile0x < 1  &&  missile0y < 1 then d  =  c

	LDA missile0x
	CMP #1
     BCS .skipL0103
.condpart49
	LDA missile0y
	CMP #1
     BCS .skip49then
.condpart50
	LDA c
	STA d
.skip49then
.skipL0103
.L0104 ;  if collision(playfield,missile1) then j  =  c

	BIT CXM1FB
	BPL .skipL0104
.condpart51
	LDA c
	STA j
.skipL0104
.L0105 ;  if missile1x = h  &&  missile1x = i then j  =  c

	LDA missile1x
	CMP h
     BNE .skipL0105
.condpart52
	LDA missile1x
	CMP i
     BNE .skip52then
.condpart53
	LDA c
	STA j
.skip52then
.skipL0105
.L0106 ;  if missile1x < 1  &&  missile1x < 1 then j  =  c  :  s  =  1 else s  =  0

	LDA missile1x
	CMP #1
     BCS .skipL0106
.condpart54
	LDA missile1x
	CMP #1
     BCS .skip54then
.condpart55
	LDA c
	STA j
	LDA #1
	STA s
 jmp .skipelse0
.skip54then
.skipL0106
	LDA #0
	STA s
.skipelse0
.L0107 ;  if !collision(playfield,missile0)  &&  d = 0 then missile0x  =  missile0x  -  1  :  missile0y  =  missile0y  +  1

	BIT CXM0FB
	BMI .skipL0107
.condpart56
	LDA d
	CMP #0
     BNE .skip56then
.condpart57
	DEC missile0x
	INC missile0y
.skip56then
.skipL0107
.L0108 ;  if !collision(playfield,missile0)  &&  d = 1 then missile0y  =  missile0y  +  1

	BIT CXM0FB
	BMI .skipL0108
.condpart58
	LDA d
	CMP #1
     BNE .skip58then
.condpart59
	INC missile0y
.skip58then
.skipL0108
.L0109 ;  if !collision(playfield,missile0)  &&  d = 2 then missile0x  =  missile0x  +  1  :  missile0y  =  missile0y  +  1

	BIT CXM0FB
	BMI .skipL0109
.condpart60
	LDA d
	CMP #2
     BNE .skip60then
.condpart61
	INC missile0x
	INC missile0y
.skip60then
.skipL0109
.L0110 ;  if !collision(playfield,missile0)  &&  d = 3 then missile0x  =  missile0x  +  1

	BIT CXM0FB
	BMI .skipL0110
.condpart62
	LDA d
	CMP #3
     BNE .skip62then
.condpart63
	INC missile0x
.skip62then
.skipL0110
.L0111 ;  if !collision(playfield,missile0)  &&  d = 4 then missile0x  =  missile0x  +  1  :  missile0y  =  missile0y  -  1

	BIT CXM0FB
	BMI .skipL0111
.condpart64
	LDA d
	CMP #4
     BNE .skip64then
.condpart65
	INC missile0x
	DEC missile0y
.skip64then
.skipL0111
.L0112 ;  if !collision(playfield,missile0)  &&  d = 5 then missile0y  =  missile0y  -  1

	BIT CXM0FB
	BMI .skipL0112
.condpart66
	LDA d
	CMP #5
     BNE .skip66then
.condpart67
	DEC missile0y
.skip66then
.skipL0112
.L0113 ;  if !collision(playfield,missile0)  &&  d = 6 then missile0x  =  missile0x  -  1  :  missile0y  =  missile0y  -  1

	BIT CXM0FB
	BMI .skipL0113
.condpart68
	LDA d
	CMP #6
     BNE .skip68then
.condpart69
	DEC missile0x
	DEC missile0y
.skip68then
.skipL0113
.L0114 ;  if !collision(playfield,missile0)  &&  d = 7 then missile0x  =  missile0x  -  1

	BIT CXM0FB
	BMI .skipL0114
.condpart70
	LDA d
	CMP #7
     BNE .skip70then
.condpart71
	DEC missile0x
.skip70then
.skipL0114
.L0115 ;  if !collision(playfield,missile1)  &&  j = 0  &&  s = 0 then missile1x  =  missile1x  -  1  :  missile1y  =  missile1y  +  1

	BIT CXM1FB
	BMI .skipL0115
.condpart72
	LDA j
	CMP #0
     BNE .skip72then
.condpart73
	LDA s
	CMP #0
     BNE .skip73then
.condpart74
	DEC missile1x
	INC missile1y
.skip73then
.skip72then
.skipL0115
.L0116 ;  if !collision(playfield,missile1)  &&  j = 1  &&  s = 0 then missile1y  =  missile1y  +  1

	BIT CXM1FB
	BMI .skipL0116
.condpart75
	LDA j
	CMP #1
     BNE .skip75then
.condpart76
	LDA s
	CMP #0
     BNE .skip76then
.condpart77
	INC missile1y
.skip76then
.skip75then
.skipL0116
.L0117 ;  if !collision(playfield,missile1)  &&  j = 2  &&  s = 0 then missile1x  =  missile1x  +  1  :  missile1y  =  missile1y  +  1

	BIT CXM1FB
	BMI .skipL0117
.condpart78
	LDA j
	CMP #2
     BNE .skip78then
.condpart79
	LDA s
	CMP #0
     BNE .skip79then
.condpart80
	INC missile1x
	INC missile1y
.skip79then
.skip78then
.skipL0117
.L0118 ;  if !collision(playfield,missile1)  &&  j = 3  &&  s = 0 then missile1x  =  missile1x  +  1

	BIT CXM1FB
	BMI .skipL0118
.condpart81
	LDA j
	CMP #3
     BNE .skip81then
.condpart82
	LDA s
	CMP #0
     BNE .skip82then
.condpart83
	INC missile1x
.skip82then
.skip81then
.skipL0118
.L0119 ;  if !collision(playfield,missile1)  &&  j = 4  &&  s = 0 then missile1x  =  missile1x  +  1  :  missile1y  =  missile1y  -  1

	BIT CXM1FB
	BMI .skipL0119
.condpart84
	LDA j
	CMP #4
     BNE .skip84then
.condpart85
	LDA s
	CMP #0
     BNE .skip85then
.condpart86
	INC missile1x
	DEC missile1y
.skip85then
.skip84then
.skipL0119
.L0120 ;  if !collision(playfield,missile1)  &&  j = 5  &&  s = 0 then missile1y  =  missile1y  -  1

	BIT CXM1FB
	BMI .skipL0120
.condpart87
	LDA j
	CMP #5
     BNE .skip87then
.condpart88
	LDA s
	CMP #0
     BNE .skip88then
.condpart89
	DEC missile1y
.skip88then
.skip87then
.skipL0120
.L0121 ;  if !collision(playfield,missile1)  &&  j = 6  &&  s = 0 then missile1x  =  missile1x  -  1  :  missile1y  =  missile1y  -  1

	BIT CXM1FB
	BMI .skipL0121
.condpart90
	LDA j
	CMP #6
     BNE .skip90then
.condpart91
	LDA s
	CMP #0
     BNE .skip91then
.condpart92
	DEC missile1x
	DEC missile1y
.skip91then
.skip90then
.skipL0121
.L0122 ;  if !collision(playfield,missile1)  &&  j = 7  &&  s = 0 then missile1x  =  missile1x  -  1

	BIT CXM1FB
	BMI .skipL0122
.condpart93
	LDA j
	CMP #7
     BNE .skip93then
.condpart94
	LDA s
	CMP #0
     BNE .skip94then
.condpart95
	DEC missile1x
.skip94then
.skip93then
.skipL0122
.
 ; 

.
 ; 

.L0123 ;  if joy1right  &&  c > 0  &&  e = 0 then c  =  c  -  1  :  e  =  1

 lda #8
 bit SWCHA
	BNE .skipL0123
.condpart96
	LDA #0
	CMP c
     BCS .skip96then
.condpart97
	LDA e
	CMP #0
     BNE .skip97then
.condpart98
	DEC c
	LDA #1
	STA e
.skip97then
.skip96then
.skipL0123
.L0124 ;  if joy1left  &&  c < 7  &&  e = 0 then c  =  c  +  1  :  e  =  1

 lda #4
 bit SWCHA
	BNE .skipL0124
.condpart99
	LDA c
	CMP #7
     BCS .skip99then
.condpart100
	LDA e
	CMP #0
     BNE .skip100then
.condpart101
	INC c
	LDA #1
	STA e
.skip100then
.skip99then
.skipL0124
.L0125 ;  if joy1right  &&  c = 0  &&  e = 0 then c  =  7  :  e  =  1

 lda #8
 bit SWCHA
	BNE .skipL0125
.condpart102
	LDA c
	CMP #0
     BNE .skip102then
.condpart103
	LDA e
	CMP #0
     BNE .skip103then
.condpart104
	LDA #7
	STA c
	LDA #1
	STA e
.skip103then
.skip102then
.skipL0125
.L0126 ;  if joy1left  &&  c = 7  &&  e = 0 then c  =  0  :  e  =  1

 lda #4
 bit SWCHA
	BNE .skipL0126
.condpart105
	LDA c
	CMP #7
     BNE .skip105then
.condpart106
	LDA e
	CMP #0
     BNE .skip106then
.condpart107
	LDA #0
	STA c
	LDA #1
	STA e
.skip106then
.skip105then
.skipL0126
.L0127 ;  if !joy1right  &&  !joy1left then e  =  0

 lda #8
 bit SWCHA
	BEQ .skipL0127
.condpart108
 lda #4
 bit SWCHA
	BEQ .skip108then
.condpart109
	LDA #0
	STA e
.skip108then
.skipL0127
.L0128 ;  if joy0fire  &&  r = 0 then missile0x  =  player0x + 2  :  missile0y  =  player0y - 2  :  AUDV0  =  10  :  AUDC0  =  3  :  AUDF0  =  6  :  q  =  1

 lda #$80
 bit INPT4
	BNE .skipL0128
.condpart110
	LDA r
	CMP #0
     BNE .skip110then
.condpart111
	LDA player0x
	CLC
	ADC #2
	STA missile0x
	LDA player0y
	SEC
	SBC #2
	STA missile0y
	LDA #10
	STA AUDV0
	LDA #3
	STA AUDC0
	LDA #6
	STA AUDF0
	LDA #1
	STA q
.skip110then
.skipL0128
.L0129 ;  if joy1fire  &&  r = 0 then missile1x  =  player0x + 2  :  missile1y  =  player0y - 2  :  AUDV0  =  10  :  AUDC0  =  3  :  AUDF0  =  6  :  q  =  1

 lda #$80
 bit INPT5
	BNE .skipL0129
.condpart112
	LDA r
	CMP #0
     BNE .skip112then
.condpart113
	LDA player0x
	CLC
	ADC #2
	STA missile1x
	LDA player0y
	SEC
	SBC #2
	STA missile1y
	LDA #10
	STA AUDV0
	LDA #3
	STA AUDC0
	LDA #6
	STA AUDF0
	LDA #1
	STA q
.skip112then
.skipL0129
.L0130 ;  if !joy0fire  &&  r <> 0 then r = 0

 lda #$80
 bit INPT4
	BEQ .skipL0130
.condpart114
	LDA r
	CMP #0
     BEQ .skip114then
.condpart115
	LDA #0
	STA r
.skip114then
.skipL0130
.
 ; 

.L0131 ;  if collision(player0,missile0)  &&  collision(playfield,missile0)  &&  collision(playfield,missile1)  &&  z = 0 then z = 1  :  player0x  =  missile1x  :  player0y  =  missile1y  :  AUDV0  =  10  :  AUDC0  =  3  :  AUDF0  =  11  :  q  =  1

	BIT CXM0P
	BVC .skipL0131
.condpart116
	BIT CXM0FB
	BPL .skip116then
.condpart117
	BIT CXM1FB
	BPL .skip117then
.condpart118
	LDA z
	CMP #0
     BNE .skip118then
.condpart119
	LDA #1
	STA z
	LDA missile1x
	STA player0x
	LDA missile1y
	STA player0y
	LDA #10
	STA AUDV0
	LDA #3
	STA AUDC0
	LDA #11
	STA AUDF0
	LDA #1
	STA q
.skip118then
.skip117then
.skip116then
.skipL0131
.L0132 ;  if collision(player0,missile1)  &&  collision(playfield,missile0)  &&  collision(playfield,missile1)  &&  z = 0 then z = 1  :  player0x  =  missile0x  :  player0y  =  missile0y  :  AUDV0  =  10  :  AUDC0  =  3  :  AUDF0  =  12  :  q  =  1

	BIT CXM1P
	BPL .skipL0132
.condpart120
	BIT CXM0FB
	BPL .skip120then
.condpart121
	BIT CXM1FB
	BPL .skip121then
.condpart122
	LDA z
	CMP #0
     BNE .skip122then
.condpart123
	LDA #1
	STA z
	LDA missile0x
	STA player0x
	LDA missile0y
	STA player0y
	LDA #10
	STA AUDV0
	LDA #3
	STA AUDC0
	LDA #12
	STA AUDF0
	LDA #1
	STA q
.skip122then
.skip121then
.skip120then
.skipL0132
.L0133 ;  if !collision(player0,missile0)  &&  !collision(player0,missile1) then z = 0

	BIT CXM0P
	BVS .skipL0133
.condpart124
	BIT CXM1P
	BMI .skip124then
.condpart125
	LDA #0
	STA z
.skip124then
.skipL0133
.
 ; 

.L0134 ;  if joy0up  &&  o = 0  &&  pfread ( b , l )  then o  =  1  :  player0y  =  player0y  -  1

 lda #$10
 bit SWCHA
	BNE .skipL0134
.condpart126
	LDA o
	CMP #0
     BNE .skip126then
.condpart127
	LDA b
	LDY l
 jsr pfread
	BNE .skip127then
.condpart128
	LDA #1
	STA o
	DEC player0y
.skip127then
.skip126then
.skipL0134
.
 ; 

.L0135 ;  if o > 0  &&  o < 11 then player0y  =  player0y  -  2  :  o  =  o  +  1

	LDA #0
	CMP o
     BCS .skipL0135
.condpart129
	LDA o
	CMP #11
     BCS .skip129then
.condpart130
	LDA player0y
	SEC
	SBC #2
	STA player0y
	INC o
.skip129then
.skipL0135
.L0136 ;  if o > 10 then o  =  0

	LDA #10
	CMP o
     BCS .skipL0136
.condpart131
	LDA #0
	STA o
.skipL0136
.
 ; 

.L0137 ;  if q > 0  &&  q < 6 then q  =  q  +  1

	LDA #0
	CMP q
     BCS .skipL0137
.condpart132
	LDA q
	CMP #6
     BCS .skip132then
.condpart133
	INC q
.skip132then
.skipL0137
.L0138 ;  if q > 5 then AUDV0  =  0  :  q  =  0

	LDA #5
	CMP q
     BCS .skipL0138
.condpart134
	LDA #0
	STA AUDV0
	STA q
.skipL0138
.
 ; 

.L0139 ;  if collision(player0,ball) then score  =  score  +  1  :  a  =  a  +  1  :  ballx  =  ballx  +  160  :  missile0x  =  0  :  missile0y  =  0  :  missile1x  =  0  :  missile1y  =  0  :  j  =  0  :  d  =  0  :  c  =  0

	BIT CXP0FB
	BVC .skipL0139
.condpart135
	SED
	CLC
	LDA score+2
	ADC #$01
	STA score+2
	LDA score+1
	ADC #$00
	STA score+1
	LDA score
	ADC #$00
	STA score
	CLD
	INC a
	LDA ballx
	CLC
	ADC #160
	STA ballx
	LDA #0
	STA missile0x
	STA missile0y
	STA missile1x
	STA missile1y
	STA j
	STA d
	STA c
.skipL0139
.
 ; 

.L0140 ;  on c goto dirdl dird dirdr dirr dirur diru dirul dirl

	LDX c
	LDA .L0140jumptablehi,x
	PHA
	LDA .L0140jumptablelo,x
	PHA
	RTS
.L0140jumptablehi
	.byte >(.dirdl-1)
	.byte >(.dird-1)
	.byte >(.dirdr-1)
	.byte >(.dirr-1)
	.byte >(.dirur-1)
	.byte >(.diru-1)
	.byte >(.dirul-1)
	.byte >(.dirl-1)
.L0140jumptablelo
	.byte <(.dirdl-1)
	.byte <(.dird-1)
	.byte <(.dirdr-1)
	.byte <(.dirr-1)
	.byte <(.dirur-1)
	.byte <(.diru-1)
	.byte <(.dirul-1)
	.byte <(.dirl-1)
.
 ; 

.dirdl ; dirdl player0:

	LDA #<playerdirdl_0

	STA player0pointerlo
	LDA #>playerdirdl_0

	STA player0pointerhi
	LDA #7
	STA player0height
.L0141 ;  goto donesetframe

 jmp .donesetframe

.
 ; 

.dird ; dird player0:

	LDA #<playerdird_0

	STA player0pointerlo
	LDA #>playerdird_0

	STA player0pointerhi
	LDA #7
	STA player0height
.L0142 ;  goto donesetframe

 jmp .donesetframe

.
 ; 

.dirdr ; dirdr player0:

	LDA #<playerdirdr_0

	STA player0pointerlo
	LDA #>playerdirdr_0

	STA player0pointerhi
	LDA #7
	STA player0height
.L0143 ;  goto donesetframe

 jmp .donesetframe

.
 ; 

.dirr ; dirr player0:

	LDA #<playerdirr_0

	STA player0pointerlo
	LDA #>playerdirr_0

	STA player0pointerhi
	LDA #7
	STA player0height
.L0144 ;  goto donesetframe

 jmp .donesetframe

.
 ; 

.dirur ; dirur player0:

	LDA #<playerdirur_0

	STA player0pointerlo
	LDA #>playerdirur_0

	STA player0pointerhi
	LDA #7
	STA player0height
.L0145 ;  goto donesetframe

 jmp .donesetframe

.
 ; 

.diru ; diru player0:

	LDA #<playerdiru_0

	STA player0pointerlo
	LDA #>playerdiru_0

	STA player0pointerhi
	LDA #7
	STA player0height
.L0146 ;  goto donesetframe

 jmp .donesetframe

.
 ; 

.dirul ; dirul player0:

	LDA #<playerdirul_0

	STA player0pointerlo
	LDA #>playerdirul_0

	STA player0pointerhi
	LDA #7
	STA player0height
.L0147 ;  goto donesetframe

 jmp .donesetframe

.
 ; 

.dirl ; dirl player0:

	LDA #<playerdirl_0

	STA player0pointerlo
	LDA #>playerdirl_0

	STA player0pointerhi
	LDA #7
	STA player0height
.L0148 ;  goto donesetframe

 jmp .donesetframe

.
 ; 

.donesetframe ; donesetframe drawscreen

 jsr drawscreen
.L0149 ;  goto start
 jmp .start
 if (<*) > (<(*+8))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerdirdl_0

	.byte 0
	.byte  %11110000
	.byte  %11100000
	.byte  %11010000
	.byte  %10001000
	.byte  %00000100
	.byte  %00000010
	.byte  %00000001
 if (<*) > (<(*+8))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerdird_0

	.byte 0
	.byte  %00011000
	.byte  %00111100
	.byte  %01111110
	.byte  %11111111
	.byte  %00011000
	.byte  %00011000
	.byte  %00011000
 if (<*) > (<(*+8))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerdirdr_0

	.byte 0
	.byte  %00001111
	.byte  %00000111
	.byte  %00001011
	.byte  %00010001
	.byte  %00100000
	.byte  %01000000
	.byte  %10000000
 if (<*) > (<(*+8))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerdirr_0

	.byte 0
	.byte  %00001000
	.byte  %00001100
	.byte  %00001110
	.byte  %11111111
	.byte  %00001110
	.byte  %00001100
	.byte  %00001000
 if (<*) > (<(*+8))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerdirur_0

	.byte 0
	.byte  %10000000
	.byte  %01000000
	.byte  %00100000
	.byte  %00010001
	.byte  %00001011
	.byte  %00000111
	.byte  %00001111
 if (<*) > (<(*+8))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerdiru_0

	.byte 0
	.byte  %00011000
	.byte  %00011000
	.byte  %00011000
	.byte  %11111111
	.byte  %01111110
	.byte  %00111100
	.byte  %00011000
 if (<*) > (<(*+8))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerdirul_0

	.byte 0
	.byte  %00000001
	.byte  %00000010
	.byte  %00000100
	.byte  %10001000
	.byte  %11010000
	.byte  %11100000
	.byte  %11110000
 if (<*) > (<(*+8))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerdirl_0

	.byte 0
	.byte  %00010000
	.byte  %00110000
	.byte  %01110000
	.byte  %11111111
	.byte  %01110000
	.byte  %00110000
	.byte  %00010000
       echo "    ",[(scoretable - *)]d , "bytes of ROM space left")
 
 
 
; feel free to modify the score graphics - just keep each digit 8 high
; and keep the conditional compilation stuff intact
 ifconst ROM2k
   ORG $F7AC
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
   else
     ORG $FF9C
   endif
 endif


scoretable
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
   else
     ORG $FFFC
   endif
 endif
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
 else
   ifconst ROM2k
     ORG $F7FC
   else
     ORG $FFFC
   endif
 endif
 .word start
 .word start
