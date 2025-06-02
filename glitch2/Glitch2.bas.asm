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
; Provided under the CC0 license. See the included LICENSE.txt for details.

; Fixed point math routines - created by AtariAge member djmips
; some changes by Fred Quimby

;assignment from 8.8 to 4.4

Assign88to44:

      ; A(4.4) = A,X(8.8)

       stx temp1
       rol temp1
       asl
       rol temp1
       asl
       rol temp1
       asl
       rol temp1
       asl
       rts

;assignment from 4.4 to 8.8
;

Assign44to88:

      ; A,X(8.8) = A(4.4)

       sta temp1
       lda #0
       asl temp1
       sbc #0   ;
       eor #$ff ; do sign extend
       rol
       asl temp1
       rol
       asl temp1
       rol
       asl temp1
       rol
       ldx temp1
       rts

 ifconst bankswitch
Assign88to44bs:

      ; A(4.4) = A,X(8.8)

       stx temp1
       rol temp1
       asl
       rol temp1
       asl
       rol temp1
       asl
       rol temp1
       asl
       RETURN

;assignment from 4.4 to 8.8
;

Assign44to88bs:

      ; A,X(8.8) = A(4.4)

       sta temp1
       lda #0
       asl temp1
       sbc #0   ;
       eor #$ff ; do sign extend
       rol
       asl temp1
       rol
       asl temp1
       rol
       asl temp1
       rol
       ldx temp1
       RETURN
 endif

;
;Addition/subtraction asm procedures:

;add/sub 8.8 to/from 4.4

Add88to44:

      ; A(4.4) = A,X(8.8) + Y(4.4)

       jsr Assign88to44
       sty temp1
       clc
       adc temp1
       rts

Sub88from44:

      ; A(4.4) = A,X(8.8) - Y(4.4)

       jsr Assign88to44
       sty temp1
       sec
       sbc temp1
       rts


Add44to88:

      ; A,X(8.8) = A,X(8.8) + Y(4.4)

       sta temp2
       stx temp3
       tya
       jsr Assign44to88
       clc
       sta temp1
       txa
       adc temp3
       tax
       lda temp1
       adc temp2
       rts


Sub44from88:

      ; A,X(8.8) = A,X(8.8) - Y(4.4)

       sta temp2
       stx temp3
       tya
       jsr Assign44to88
       sec
       sta temp1
       lda temp3
       stx temp3
       sbc temp3
       tax
       lda temp2
       sbc temp1
       rts

; Provided under the CC0 license. See the included LICENSE.txt for details.

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
.L00 ;  include fixed_point_math.asm

.L01 ;  include div_mul.asm

.L02 ;  set kernel_options no_blank_lines

.
 ; 

.L03 ;  dim _sc1  =  score

.L04 ;  dim _sc2  =  score + 1

.L05 ;  dim _sc3  =  score + 2

.
 ; 

.L06 ;  rem Setup 8.8 fixed point variables for smooth movement

.L07 ;  dim _player0x = player0x.a

.L08 ;  dim _player1x = player1x.b

.L09 ;  dim _missile0x =  missile0x.c

.L010 ;  dim _missile1x =  missile1x.d

.L011 ;  dim _ballx = ballx.e

.
 ; 

.L012 ;  dim _player0shift = f.g

.L013 ;  dim _player1shift = h.i

.L014 ;  dim _ballShift = j.k

.L015 ;  dim _missile0shift = l.m

.L016 ;  dim _missile1shift = n.o

.L017 ;  dim moveAmount = p.q

.
 ; 

.
 ; 

.L018 ;  dim buttonPressed = x

.L019 ;  dim editing = y

.L020 ;  dim currentPreview = z

.
 ; 

.
 ; 

.L021 ;  gosub getPlayers

 jsr .getPlayers

.L022 ;  rem This is the smallest amount that a fraction of 8.8 can be moved

.L023 ;  moveAmount = 0.003921

	LDX #1
	STX q
	LDA #0
	STA moveAmount
.
 ; 

.L024 ;  rem The 2 data arrays hold the visual preset positions

.L025 ;  rem Even numbers are the whole and odd the fractions

.L026 ;  data shiftPostions0

	JMP .skipL026
shiftPostions0
	.byte 	1 

	.byte 	16 

	.byte 	17 

	.byte 	238 

	.byte 	239 

	.byte 	240 

	.byte 	255	

.skipL026
.
 ; 

.
 ; 

.
 ; 

.L027 ;  rem 

.L028 ;  rem  player0:

.L029 ;  rem  %00011000

.L030 ;  rem  %01100110

.L031 ;  rem  %01100110

.L032 ;  rem  %00111100

.L033 ;  rem  %00111100

.L034 ;  rem  %01011010

.L035 ;  rem  %01100110

.L036 ;  rem  %00011000

.L037 ;  rem end

.
 ; 

.resetPoint
 ; resetPoint

.L038 ;  rem Read data for movement

.L039 ;  f = shiftPostions0[currentPreview]

	LDX currentPreview
	LDA shiftPostions0,x
	STA f
.L040 ;  h = shiftPostions0[currentPreview]

	LDX currentPreview
	LDA shiftPostions0,x
	STA h
.L041 ;  j = shiftPostions0[currentPreview]

	LDX currentPreview
	LDA shiftPostions0,x
	STA j
.L042 ;  l = shiftPostions0[currentPreview]

	LDX currentPreview
	LDA shiftPostions0,x
	STA l
.L043 ;  n = shiftPostions0[currentPreview]

	LDX currentPreview
	LDA shiftPostions0,x
	STA n
.L044 ;  temp3 = currentPreview + 1

	LDA currentPreview
	CLC
	ADC #1
	STA temp3
.
 ; 

.L045 ;  g = 0

	LDA #0
	STA g
.L046 ;  i = 50

	LDA #50
	STA i
.L047 ;  k = 100

	LDA #100
	STA k
.L048 ;  m = 150

	LDA #150
	STA m
.L049 ;  o = 200

	LDA #200
	STA o
.L050 ;  currentPreview = temp3

	LDA temp3
	STA currentPreview
.
 ; 

.L051 ;  if currentPreview = shiftPostions0_length then currentPreview = 0

	LDA currentPreview
	CMP #shiftPostions0_length
     BNE .skipL051
.condpart0
	LDA #0
	STA currentPreview
.skipL051
.
 ; 

.L052 ;  editing = 4

	LDA #4
	STA editing
.L053 ;  gosub changeEdit

 jsr .changeEdit

.main
 ; main

.L054 ;  ENAM0 = 2

	LDA #2
	STA ENAM0
.L055 ;  missile1height = 0

	LDA #0
	STA missile1height
.L056 ;  ballheight = 255

	LDA #255
	STA ballheight
.
 ; 

.L057 ;  CTRLPF = $01

	LDA #$01
	STA CTRLPF
.
 ; 

.
 ; 

.L058 ;  player0height = 255

	LDA #255
	STA player0height
.L059 ;  player1height = 255

	LDA #255
	STA player1height
.
 ; 

.L060 ;  missile0height = 10

	LDA #10
	STA missile0height
.L061 ;  rem By making missile1height 255 it was able to wrap around the whole screen

.
 ; 

.L062 ;  COLUP0 = 196

	LDA #196
	STA COLUP0
.L063 ;  COLUP1  =  64

	LDA #64
	STA COLUP1
.L064 ;  COLUBK  =  00

	LDA #00
	STA COLUBK
.L065 ;  COLUPF = 132

	LDA #132
	STA COLUPF
.
 ; 

.L066 ;  rem Changes whether you're editing the green or red missile

.L067 ;  if joy0fire  &&  buttonPressed = 0 then gosub changeEdit

 bit INPT4
	BMI .skipL067
.condpart1
	LDA buttonPressed
	CMP #0
     BNE .skip1then
.condpart2
 jsr .changeEdit

.skip1then
.skipL067
.L068 ;  if editing = 0 then goto checkInput0

	LDA editing
	CMP #0
     BNE .skipL068
.condpart3
 jmp .checkInput0

.skipL068
.L069 ;  if editing = 1 then goto checkInput1

	LDA editing
	CMP #1
     BNE .skipL069
.condpart4
 jmp .checkInput1

.skipL069
.L070 ;  if editing = 2 then goto checkInput2

	LDA editing
	CMP #2
     BNE .skipL070
.condpart5
 jmp .checkInput2

.skipL070
.L071 ;  if editing = 3 then goto checkInput3

	LDA editing
	CMP #3
     BNE .skipL071
.condpart6
 jmp .checkInput3

.skipL071
.L072 ;  if editing = 4 then goto checkInput4

	LDA editing
	CMP #4
     BNE .skipL072
.condpart7
 jmp .checkInput4

.skipL072
.checkedInput
 ; checkedInput

.L073 ;  rem Update positions and check limits

.L074 ;  _player0x = _player0x + _player0shift

	LDA a
	CLC 
	ADC g
	STA a
	LDA _player0x
	ADC _player0shift
	STA _player0x
.L075 ;  _player1x = _player1x + _player1shift

	LDA b
	CLC 
	ADC i
	STA b
	LDA _player1x
	ADC _player1shift
	STA _player1x
.L076 ;  _ballx = _ballx + _ballShift

	LDA e
	CLC 
	ADC k
	STA e
	LDA _ballx
	ADC _ballShift
	STA _ballx
.L077 ;  _missile0x = _missile0x + _missile0shift

	LDA c
	CLC 
	ADC m
	STA c
	LDA _missile0x
	ADC _missile0shift
	STA _missile0x
.L078 ;  _missile1x = _missile1x + _missile1shift

	LDA d
	CLC 
	ADC o
	STA d
	LDA _missile1x
	ADC _missile1shift
	STA _missile1x
.
 ; 

.L079 ;  if player0x > 200 then player0x = player0x + 160

	LDA #200
	CMP player0x
     BCS .skipL079
.condpart8
	LDA player0x
	CLC
	ADC #160
	STA player0x
.skipL079
.L080 ;  if player0x > 159 then player0x = player0x - 160

	LDA #159
	CMP player0x
     BCS .skipL080
.condpart9
	LDA player0x
	SEC
	SBC #160
	STA player0x
.skipL080
.
 ; 

.L081 ;  if player1x > 200 then player1x = player1x + 160

	LDA #200
	CMP player1x
     BCS .skipL081
.condpart10
	LDA player1x
	CLC
	ADC #160
	STA player1x
.skipL081
.L082 ;  if player1x > 159 then player1x = player1x - 160

	LDA #159
	CMP player1x
     BCS .skipL082
.condpart11
	LDA player1x
	SEC
	SBC #160
	STA player1x
.skipL082
.
 ; 

.
 ; 

.L083 ;  if missile0x > 200 then missile0x = missile0x + 160

	LDA #200
	CMP missile0x
     BCS .skipL083
.condpart12
	LDA missile0x
	CLC
	ADC #160
	STA missile0x
.skipL083
.L084 ;  if missile0x > 159 then missile0x = missile0x - 160

	LDA #159
	CMP missile0x
     BCS .skipL084
.condpart13
	LDA missile0x
	SEC
	SBC #160
	STA missile0x
.skipL084
.
 ; 

.L085 ;  if missile1x > 200 then missile1x = missile1x + 160

	LDA #200
	CMP missile1x
     BCS .skipL085
.condpart14
	LDA missile1x
	CLC
	ADC #160
	STA missile1x
.skipL085
.L086 ;  if missile1x > 159 then missile1x = missile1x - 160

	LDA #159
	CMP missile1x
     BCS .skipL086
.condpart15
	LDA missile1x
	SEC
	SBC #160
	STA missile1x
.skipL086
.
 ; 

.L087 ;  if ballx > 200 then ballx = ballx + 160

	LDA #200
	CMP ballx
     BCS .skipL087
.condpart16
	LDA ballx
	CLC
	ADC #160
	STA ballx
.skipL087
.L088 ;  if ballx > 159 then ballx = ballx - 160

	LDA #159
	CMP ballx
     BCS .skipL088
.condpart17
	LDA ballx
	SEC
	SBC #160
	STA ballx
.skipL088
.
 ; 

.L089 ;  gosub trace

 jsr .trace

.L090 ;  drawscreen

 jsr drawscreen
.
 ; 

.L091 ;  rem When reset it will pick the next preset visual

.L092 ;  if switchreset  &&  buttonPressed = 0 then buttonPressed = 1 :  goto resetPoint

 lda #1
 bit SWCHB
	BNE .skipL092
.condpart18
	LDA buttonPressed
	CMP #0
     BNE .skip18then
.condpart19
	LDA #1
	STA buttonPressed
 jmp .resetPoint

.skip18then
.skipL092
.L093 ;  if !joy0fire  &&  !switchreset then buttonPressed = 0

 bit INPT4
	BPL .skipL093
.condpart20
 lda #1
 bit SWCHB
	BEQ .skip20then
.condpart21
	LDA #0
	STA buttonPressed
.skip20then
.skipL093
.
 ; 

.L094 ;  goto main

 jmp .main

.
 ; 

.changeEdit
 ; changeEdit

.L095 ;  rem Picks what colour you're editing

.L096 ;  buttonPressed = 1

	LDA #1
	STA buttonPressed
.L097 ;  editing = editing + 1 :  if editing > 4 then editing = 0

	INC editing
	LDA #4
	CMP editing
     BCS .skipL097
.condpart22
	LDA #0
	STA editing
.skipL097
.L098 ;  if editing = 0 then scorecolor = 196

	LDA editing
	CMP #0
     BNE .skipL098
.condpart23
	LDA #196
	STA scorecolor
.skipL098
.L099 ;  if editing = 1 then scorecolor = 64

	LDA editing
	CMP #1
     BNE .skipL099
.condpart24
	LDA #64
	STA scorecolor
.skipL099
.L0100 ;  if editing = 2 then scorecolor = 132

	LDA editing
	CMP #2
     BNE .skipL0100
.condpart25
	LDA #132
	STA scorecolor
.skipL0100
.L0101 ;  if editing = 3 then scorecolor = 196

	LDA editing
	CMP #3
     BNE .skipL0101
.condpart26
	LDA #196
	STA scorecolor
.skipL0101
.L0102 ;  if editing = 4 then scorecolor = 64

	LDA editing
	CMP #4
     BNE .skipL0102
.condpart27
	LDA #64
	STA scorecolor
.skipL0102
.L0103 ;  return

	RTS
.
 ; 

.L0104 ;  rem Up and down control the whole number and left and right the fraction

.
 ; 

.checkInput0
 ; checkInput0

.L0105 ;  if joy0up then _player0shift = _player0shift + 1

 lda #$10
 bit SWCHA
	BNE .skipL0105
.condpart28
	INC _player0shift
.skipL0105
.L0106 ;  if joy0down then _player0shift = _player0shift - 1

 lda #$20
 bit SWCHA
	BNE .skipL0106
.condpart29
	DEC _player0shift
.skipL0106
.L0107 ;  if joy0right then _player0shift = _player0shift  + moveAmount

 bit SWCHA
	BMI .skipL0107
.condpart30
	LDA g
	CLC 
	ADC q
	STA g
	LDA _player0shift
	ADC moveAmount
	STA _player0shift
.skipL0107
.L0108 ;  if joy0left then _player0shift = _player0shift  - moveAmount

 bit SWCHA
	BVS .skipL0108
.condpart31
	LDA g
	SEC 
	SBC q
	STA g
	LDA _player0shift
	SBC moveAmount
	STA _player0shift
.skipL0108
.L0109 ;  goto checkedInput

 jmp .checkedInput

.
 ; 

.checkInput1
 ; checkInput1

.L0110 ;  if joy0up then _player1shift = _player1shift + 1

 lda #$10
 bit SWCHA
	BNE .skipL0110
.condpart32
	INC _player1shift
.skipL0110
.L0111 ;  if joy0down then _player1shift = _player1shift - 1

 lda #$20
 bit SWCHA
	BNE .skipL0111
.condpart33
	DEC _player1shift
.skipL0111
.L0112 ;  if joy0right then _player1shift = _player1shift  + moveAmount

 bit SWCHA
	BMI .skipL0112
.condpart34
	LDA i
	CLC 
	ADC q
	STA i
	LDA _player1shift
	ADC moveAmount
	STA _player1shift
.skipL0112
.L0113 ;  if joy0left then _player1shift = _player1shift  - moveAmount

 bit SWCHA
	BVS .skipL0113
.condpart35
	LDA i
	SEC 
	SBC q
	STA i
	LDA _player1shift
	SBC moveAmount
	STA _player1shift
.skipL0113
.L0114 ;  goto checkedInput

 jmp .checkedInput

.
 ; 

.checkInput2
 ; checkInput2

.L0115 ;  if joy0up then _ballShift = _ballShift + 1

 lda #$10
 bit SWCHA
	BNE .skipL0115
.condpart36
	INC _ballShift
.skipL0115
.L0116 ;  if joy0down then _ballShift = _ballShift - 1

 lda #$20
 bit SWCHA
	BNE .skipL0116
.condpart37
	DEC _ballShift
.skipL0116
.L0117 ;  if joy0right then _ballShift = _ballShift + moveAmount

 bit SWCHA
	BMI .skipL0117
.condpart38
	LDA k
	CLC 
	ADC q
	STA k
	LDA _ballShift
	ADC moveAmount
	STA _ballShift
.skipL0117
.L0118 ;  if joy0left then _ballShift = _ballShift - moveAmount

 bit SWCHA
	BVS .skipL0118
.condpart39
	LDA k
	SEC 
	SBC q
	STA k
	LDA _ballShift
	SBC moveAmount
	STA _ballShift
.skipL0118
.L0119 ;  goto checkedInput

 jmp .checkedInput

.
 ; 

.checkInput3
 ; checkInput3

.L0120 ;  if joy0up then _missile0shift = _missile0shift + 1

 lda #$10
 bit SWCHA
	BNE .skipL0120
.condpart40
	INC _missile0shift
.skipL0120
.L0121 ;  if joy0down then _missile0shift = _missile0shift - 1

 lda #$20
 bit SWCHA
	BNE .skipL0121
.condpart41
	DEC _missile0shift
.skipL0121
.L0122 ;  if joy0right then _missile0shift = _missile0shift  + moveAmount

 bit SWCHA
	BMI .skipL0122
.condpart42
	LDA m
	CLC 
	ADC q
	STA m
	LDA _missile0shift
	ADC moveAmount
	STA _missile0shift
.skipL0122
.L0123 ;  if joy0left then _missile0shift = _missile0shift  - moveAmount

 bit SWCHA
	BVS .skipL0123
.condpart43
	LDA m
	SEC 
	SBC q
	STA m
	LDA _missile0shift
	SBC moveAmount
	STA _missile0shift
.skipL0123
.L0124 ;  goto checkedInput

 jmp .checkedInput

.
 ; 

.checkInput4
 ; checkInput4

.L0125 ;  if joy0up then _missile1shift = _missile1shift + 1

 lda #$10
 bit SWCHA
	BNE .skipL0125
.condpart44
	INC _missile1shift
.skipL0125
.L0126 ;  if joy0down then _missile1shift = _missile1shift - 1

 lda #$20
 bit SWCHA
	BNE .skipL0126
.condpart45
	DEC _missile1shift
.skipL0126
.L0127 ;  if joy0right then _missile1shift = _missile1shift  + moveAmount

 bit SWCHA
	BMI .skipL0127
.condpart46
	LDA o
	CLC 
	ADC q
	STA o
	LDA _missile1shift
	ADC moveAmount
	STA _missile1shift
.skipL0127
.L0128 ;  if joy0left then _missile1shift = _missile1shift  - moveAmount

 bit SWCHA
	BVS .skipL0128
.condpart47
	LDA o
	SEC 
	SBC q
	STA o
	LDA _missile1shift
	SBC moveAmount
	STA _missile1shift
.skipL0128
.L0129 ;  goto checkedInput

 jmp .checkedInput

.
 ; 

.
 ; 

.
 ; 

.L0130 ;  rem Original code by Random Terrain from ex_multisprite_9_objects.bas

.L0131 ;  rem Uses score to display an 8.8 fixed point variable 

.L0132 ;  rem First 3 digits are the whole number and the second 3 digits the fraction 

.
 ; 

.trace
 ; trace

.L0133 ;  if editing = 0 then temp4 = f :  temp5 = g

	LDA editing
	CMP #0
     BNE .skipL0133
.condpart48
	LDA f
	STA temp4
	LDA g
	STA temp5
.skipL0133
.L0134 ;  if editing = 1 then temp4 = h :  temp5 = i

	LDA editing
	CMP #1
     BNE .skipL0134
.condpart49
	LDA h
	STA temp4
	LDA i
	STA temp5
.skipL0134
.L0135 ;  if editing = 2 then temp4 = j :  temp5 = k

	LDA editing
	CMP #2
     BNE .skipL0135
.condpart50
	LDA j
	STA temp4
	LDA k
	STA temp5
.skipL0135
.L0136 ;  if editing = 3 then temp4 = l :  temp5 = m

	LDA editing
	CMP #3
     BNE .skipL0136
.condpart51
	LDA l
	STA temp4
	LDA m
	STA temp5
.skipL0136
.L0137 ;  if editing = 4 then temp4 = n :  temp5 = o

	LDA editing
	CMP #4
     BNE .skipL0137
.condpart52
	LDA n
	STA temp4
	LDA o
	STA temp5
.skipL0137
.
 ; 

.L0138 ;  _sc1  =  0  :  _sc2  =  _sc2  &  15

	LDA #0
	STA _sc1
	LDA _sc2
	AND #15
	STA _sc2
.L0139 ;  if temp4  >=  100 then _sc1  =  _sc1  +  16  :  temp4  =  temp4  -  100

	LDA temp4
	CMP #100
     BCC .skipL0139
.condpart53
	LDA _sc1
	CLC
	ADC #16
	STA _sc1
	LDA temp4
	SEC
	SBC #100
	STA temp4
.skipL0139
.L0140 ;  if temp4  >=  100 then _sc1  =  _sc1  +  16  :  temp4  =  temp4  -  100

	LDA temp4
	CMP #100
     BCC .skipL0140
.condpart54
	LDA _sc1
	CLC
	ADC #16
	STA _sc1
	LDA temp4
	SEC
	SBC #100
	STA temp4
.skipL0140
.L0141 ;  if temp4  >=  50 then _sc1  =  _sc1  +  5  :  temp4  =  temp4  -  50

	LDA temp4
	CMP #50
     BCC .skipL0141
.condpart55
	LDA _sc1
	CLC
	ADC #5
	STA _sc1
	LDA temp4
	SEC
	SBC #50
	STA temp4
.skipL0141
.L0142 ;  if temp4  >=  30 then _sc1  =  _sc1  +  3  :  temp4  =  temp4  -  30

	LDA temp4
	CMP #30
     BCC .skipL0142
.condpart56
	LDA _sc1
	CLC
	ADC #3
	STA _sc1
	LDA temp4
	SEC
	SBC #30
	STA temp4
.skipL0142
.L0143 ;  if temp4  >=  20 then _sc1  =  _sc1  +  2  :  temp4  =  temp4  -  20

	LDA temp4
	CMP #20
     BCC .skipL0143
.condpart57
	LDA _sc1
	CLC
	ADC #2
	STA _sc1
	LDA temp4
	SEC
	SBC #20
	STA temp4
.skipL0143
.L0144 ;  if temp4  >=  10 then _sc1  =  _sc1  +  1  :  temp4  =  temp4  -  10

	LDA temp4
	CMP #10
     BCC .skipL0144
.condpart58
	INC _sc1
	LDA temp4
	SEC
	SBC #10
	STA temp4
.skipL0144
.L0145 ;  _sc2  =   ( temp4  *  4  *  4 )   |  _sc2

; complex statement detected
	LDA temp4
	asl
	asl
	asl
	asl
	ORA _sc2
	STA _sc2
.
 ; 

.L0146 ;  _sc2  =  _sc2  &  240  :  _sc3  =  0

	LDA _sc2
	AND #240
	STA _sc2
	LDA #0
	STA _sc3
.L0147 ;  if temp5  >=  100 then _sc2  =  _sc2  +  1  :  temp5  =  temp5  -  100

	LDA temp5
	CMP #100
     BCC .skipL0147
.condpart59
	INC _sc2
	LDA temp5
	SEC
	SBC #100
	STA temp5
.skipL0147
.L0148 ;  if temp5  >=  100 then _sc2  =  _sc2  +  1  :  temp5  =  temp5  -  100

	LDA temp5
	CMP #100
     BCC .skipL0148
.condpart60
	INC _sc2
	LDA temp5
	SEC
	SBC #100
	STA temp5
.skipL0148
.L0149 ;  if temp5  >=  50 then _sc3  =  _sc3  +  80  :  temp5  =  temp5  -  50

	LDA temp5
	CMP #50
     BCC .skipL0149
.condpart61
	LDA _sc3
	CLC
	ADC #80
	STA _sc3
	LDA temp5
	SEC
	SBC #50
	STA temp5
.skipL0149
.L0150 ;  if temp5  >=  30 then _sc3  =  _sc3  +  48  :  temp5  =  temp5  -  30

	LDA temp5
	CMP #30
     BCC .skipL0150
.condpart62
	LDA _sc3
	CLC
	ADC #48
	STA _sc3
	LDA temp5
	SEC
	SBC #30
	STA temp5
.skipL0150
.L0151 ;  if temp5  >=  20 then _sc3  =  _sc3  +  32  :  temp5  =  temp5  -  20

	LDA temp5
	CMP #20
     BCC .skipL0151
.condpart63
	LDA _sc3
	CLC
	ADC #32
	STA _sc3
	LDA temp5
	SEC
	SBC #20
	STA temp5
.skipL0151
.L0152 ;  if temp5  >=  10 then _sc3  =  _sc3  +  16  :  temp5  =  temp5  -  10

	LDA temp5
	CMP #10
     BCC .skipL0152
.condpart64
	LDA _sc3
	CLC
	ADC #16
	STA _sc3
	LDA temp5
	SEC
	SBC #10
	STA temp5
.skipL0152
.L0153 ;  _sc3  =  _sc3  |  temp5

	LDA _sc3
	ORA temp5
	STA _sc3
.L0154 ;  return

	RTS
.
 ; 

.L0155 ;  rem Enable the TIA bug

.
 ; 

.
 ; 

.L0156 ;  vblank

vblank_bB_code
.
 ; 

.L0157 ;  HMP0 = 255 :  HMP1 = 255 :  HMM0  =  255 :  HMM1  =  100 :  HMBL = 100

	LDA #255
	STA HMP0
	STA HMP1
	STA HMM0
	LDA #100
	STA HMM1
	STA HMBL
.
 ; 

.L0158 ;  WSYNC = 255

	LDA #255
	STA WSYNC
.L0159 ;  HMOVE  =  255

	LDA #255
	STA HMOVE
.
 ; 

.L0160 ;  HMP0  = 144 :  HMP1  = 144 :  HMM0  =  144 :  HMM1 = 255 :  HMBL  =  255

	LDA #144
	STA HMP0
	STA HMP1
	STA HMM0
	LDA #255
	STA HMM1
	STA HMBL
.
 ; 

.L0161 ;  return

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

.L0162 ;  rem order top ball-m0-m1

.L0163 ;  rem order bottom m1-m0-ball

.
 ; 

.
 ; 

.getPlayers
 ; getPlayers

.L0164 ;  player0:

	LDX #<playerL0164_0
	STX player0pointerlo
	LDA #>playerL0164_0
	STA player0pointerhi
	LDA #254
	STA player0height
.
 ; 

.L0165 ;  player1:

	LDX #<playerL0165_1
	STX player1pointerlo
	LDA #>playerL0165_1
	STA player1pointerhi
	LDA #254
	STA player1height
.
 ; 

.
 ; 

.L0166 ;  return

	RTS
.
 ; 

.
 ; 

.
 ; 

.
 ; 

 if (<*) > (<(*+254))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0164_0
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
 if (<*) > (<(*+254))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0165_1
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
	.byte  %10
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
