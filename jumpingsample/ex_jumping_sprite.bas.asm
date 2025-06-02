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

.L00 ;  set kernel_options player1colors

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L01 ;  dim _P1_Left_Right  =  player1x.a

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L02 ;  dim _Jump_Gravity_Counter  =  b

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L03 ;  dim _Fall_Gravity_Counter  =  c

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L04 ;  dim _Master_Counter  =  d

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L05 ;  dim _Frame_Counter  =  e

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L06 ;  dim _Ch0_Sound  =  f

.L07 ;  dim _Ch0_Duration  =  g

.L08 ;  dim _Ch0_Counter  =  h

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L09 ;  dim _BitOp_01  =  y

.L010 ;  dim _Bit2_Fall_in_Progress  =  y

.L011 ;  dim _Bit3_FireB_Restrainer  =  y

.L012 ;  dim _Bit4_Flip_P1  =  y

.L013 ;  dim _Bit5_LR_Joy_Movement  =  y

.L014 ;  dim _Bit6_Duck_in_Progress  =  y

.L015 ;  dim _Bit7_Reset_Restrainer  =  y

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L016 ;  const _c_Jump_Sound  =  1

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L017 ;  const _00  =  $00

.L018 ;  const _02  =  $02

.L019 ;  const _04  =  $04

.L020 ;  const _06  =  $06

.L021 ;  const _08  =  $08

.L022 ;  const _0A  =  $0A

.L023 ;  const _0C  =  $0C

.L024 ;  const _0E  =  $0E

.L025 ;  const _10  =  $10

.L026 ;  const _12  =  $12

.L027 ;  const _14  =  $14

.L028 ;  const _16  =  $16

.L029 ;  const _18  =  $18

.L030 ;  const _1A  =  $1A

.L031 ;  const _1C  =  $1C

.L032 ;  const _1E  =  $1E

.L033 ;  const _20  =  $20

.L034 ;  const _22  =  $22

.L035 ;  const _24  =  $24

.L036 ;  const _26  =  $26

.L037 ;  const _28  =  $28

.L038 ;  const _2A  =  $2A

.L039 ;  const _2C  =  $2C

.L040 ;  const _2E  =  $2E

.L041 ;  const _30  =  $30

.L042 ;  const _32  =  $32

.L043 ;  const _34  =  $34

.L044 ;  const _36  =  $36

.L045 ;  const _38  =  $38

.L046 ;  const _3A  =  $3A

.L047 ;  const _3C  =  $3C

.L048 ;  const _3E  =  $3E

.L049 ;  const _40  =  $40

.L050 ;  const _42  =  $42

.L051 ;  const _44  =  $44

.L052 ;  const _46  =  $46

.L053 ;  const _48  =  $48

.L054 ;  const _4A  =  $4A

.L055 ;  const _4C  =  $4C

.L056 ;  const _4E  =  $4E

.L057 ;  const _50  =  $50

.L058 ;  const _52  =  $52

.L059 ;  const _54  =  $54

.L060 ;  const _56  =  $56

.L061 ;  const _58  =  $58

.L062 ;  const _5A  =  $5A

.L063 ;  const _5C  =  $5C

.L064 ;  const _5E  =  $5E

.L065 ;  const _60  =  $60

.L066 ;  const _62  =  $62

.L067 ;  const _64  =  $64

.L068 ;  const _66  =  $66

.L069 ;  const _68  =  $68

.L070 ;  const _6A  =  $6A

.L071 ;  const _6C  =  $6C

.L072 ;  const _6E  =  $6E

.L073 ;  const _70  =  $70

.L074 ;  const _72  =  $72

.L075 ;  const _74  =  $74

.L076 ;  const _76  =  $76

.L077 ;  const _78  =  $78

.L078 ;  const _7A  =  $7A

.L079 ;  const _7C  =  $7C

.L080 ;  const _7E  =  $7E

.L081 ;  const _80  =  $80

.L082 ;  const _82  =  $82

.L083 ;  const _84  =  $84

.L084 ;  const _86  =  $86

.L085 ;  const _88  =  $88

.L086 ;  const _8A  =  $8A

.L087 ;  const _8C  =  $8C

.L088 ;  const _8E  =  $8E

.L089 ;  const _90  =  $90

.L090 ;  const _92  =  $92

.L091 ;  const _94  =  $94

.L092 ;  const _96  =  $96

.L093 ;  const _98  =  $98

.L094 ;  const _9A  =  $9A

.L095 ;  const _9C  =  $9C

.L096 ;  const _9E  =  $9E

.L097 ;  const _A0  =  $A0

.L098 ;  const _A2  =  $A2

.L099 ;  const _A4  =  $A4

.L0100 ;  const _A6  =  $A6

.L0101 ;  const _A8  =  $A8

.L0102 ;  const _AA  =  $AA

.L0103 ;  const _AC  =  $AC

.L0104 ;  const _AE  =  $AE

.L0105 ;  const _B0  =  $B0

.L0106 ;  const _B2  =  $B2

.L0107 ;  const _B4  =  $B4

.L0108 ;  const _B6  =  $B6

.L0109 ;  const _B8  =  $B8

.L0110 ;  const _BA  =  $BA

.L0111 ;  const _BC  =  $BC

.L0112 ;  const _BE  =  $BE

.L0113 ;  const _C0  =  $C0

.L0114 ;  const _C2  =  $C2

.L0115 ;  const _C4  =  $C4

.L0116 ;  const _C6  =  $C6

.L0117 ;  const _C8  =  $C8

.L0118 ;  const _CA  =  $CA

.L0119 ;  const _CC  =  $CC

.L0120 ;  const _CE  =  $CE

.L0121 ;  const _D0  =  $D0

.L0122 ;  const _D2  =  $D2

.L0123 ;  const _D4  =  $D4

.L0124 ;  const _D6  =  $D6

.L0125 ;  const _D8  =  $D8

.L0126 ;  const _DA  =  $DA

.L0127 ;  const _DC  =  $DC

.L0128 ;  const _DE  =  $DE

.L0129 ;  const _E0  =  $E0

.L0130 ;  const _E2  =  $E2

.L0131 ;  const _E4  =  $E4

.L0132 ;  const _E6  =  $E6

.L0133 ;  const _E8  =  $E8

.L0134 ;  const _EA  =  $EA

.L0135 ;  const _EC  =  $EC

.L0136 ;  const _EE  =  $EE

.L0137 ;  const _F0  =  $F0

.L0138 ;  const _F2  =  $F2

.L0139 ;  const _F4  =  $F4

.L0140 ;  const _F6  =  $F6

.L0141 ;  const _F8  =  $F8

.L0142 ;  const _FA  =  $FA

.L0143 ;  const _FC  =  $FC

.L0144 ;  const _FE  =  $FE

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
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

.L0145 ;  AUDV0  =  0  :  AUDV1  =  0

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

.L0146 ;  a  =  0  :  b  =  0  :  c  =  0  :  d  =  0  :  e  =  0  :  f  =  0  :  g  =  0  :  h  =  0  :  i  =  0

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
.L0147 ;  j  =  0  :  k  =  0  :  l  =  0  :  m  =  0  :  n  =  0  :  o  =  0  :  p  =  0  :  q  =  0  :  r  =  0

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
.L0148 ;  s  =  0  :  t  =  0  :  u  =  0  :  v  =  0  :  w  =  0  :  x  =  0  :  y  =  0  :  z  =  0

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

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Main_Loop_Setup
 ; __Main_Loop_Setup

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0149 ;  player1x  =  79  :  player1y  =  79

	LDA #79
	STA player1x
	STA player1y
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0150 ;  _Bit7_Reset_Restrainer{7}  =  1

	LDA _Bit7_Reset_Restrainer
	ORA #128
	STA _Bit7_Reset_Restrainer
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0151 ;  playfield:

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

.L0152 ;  COLUPF  =  _C4  :  COLUBK  =  _00

	LDA #_C4
	STA COLUPF
	LDA #_00
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

.L0153 ;  _Master_Counter  =  _Master_Counter  +  1

	INC _Master_Counter
.
 ; 

.L0154 ;  if _Master_Counter  <  4 then goto __Skip_Frame_Counter

	LDA _Master_Counter
	CMP #4
     BCS .skipL0154
.condpart0
 jmp .__Skip_Frame_Counter

.skipL0154
.
 ; 

.L0155 ;  _Frame_Counter  =  _Frame_Counter  +  1  :  _Master_Counter  =  0

	INC _Frame_Counter
	LDA #0
	STA _Master_Counter
.
 ; 

.L0156 ;  if _Frame_Counter  =  4 then _Frame_Counter  =  0

	LDA _Frame_Counter
	CMP #4
     BNE .skipL0156
.condpart1
	LDA #0
	STA _Frame_Counter
.skipL0156
.
 ; 

.__Skip_Frame_Counter
 ; __Skip_Frame_Counter

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0157 ;  player1color:

	LDX #<playercolorL0157_1
	STX player1color
	LDA #>playercolorL0157_1
	STA player1color+1
.
 ; 

.L0158 ;  player1:

	LDX #<playerL0158_1
	STX player1pointerlo
	LDA #>playerL0158_1
	STA player1pointerhi
	LDA #9
	STA player1height
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0159 ;  if !joy0fire then _Jump_Gravity_Counter  =  0  :  _Bit3_FireB_Restrainer{3}  =  0  :  goto __Skip_Jump

 bit INPT4
	BPL .skipL0159
.condpart2
	LDA #0
	STA _Jump_Gravity_Counter
	LDA _Bit3_FireB_Restrainer
	AND #247
	STA _Bit3_FireB_Restrainer
 jmp .__Skip_Jump

.skipL0159
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0160 ;  if !_Bit3_FireB_Restrainer{3} then player1:

	LDA _Bit3_FireB_Restrainer
	AND #8
	BNE .skipL0160
.condpart3
	LDX #<player3then_1
	STX player1pointerlo
	LDA #>player3then_1
	STA player1pointerhi
	LDA #9
	STA player1height
.skipL0160
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0161 ;  if !joy0left  &&  !joy0right  &&  !_Bit3_FireB_Restrainer{3} then player1:

 bit SWCHA
	BVC .skipL0161
.condpart4
 bit SWCHA
	BPL .skip4then
.condpart5
	LDA _Bit3_FireB_Restrainer
	AND #8
	BNE .skip5then
.condpart6
	LDX #<player6then_1
	STX player1pointerlo
	LDA #>player6then_1
	STA player1pointerhi
	LDA #9
	STA player1height
.skip5then
.skip4then
.skipL0161
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0162 ;  if _Bit2_Fall_in_Progress{2} then goto __Skip_Jump

	LDA _Bit2_Fall_in_Progress
	AND #4
	BEQ .skipL0162
.condpart7
 jmp .__Skip_Jump

.skipL0162
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0163 ;  if _Bit3_FireB_Restrainer{3}  &&  !_Bit2_Fall_in_Progress{2}  &&  !_Jump_Gravity_Counter then goto __Skip_Jump

	LDA _Bit3_FireB_Restrainer
	AND #8
	BEQ .skipL0163
.condpart8
	LDA _Bit2_Fall_in_Progress
	AND #4
	BNE .skip8then
.condpart9
	LDA _Jump_Gravity_Counter
	BNE .skip9then
.condpart10
 jmp .__Skip_Jump

.skip9then
.skip8then
.skipL0163
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0164 ;  if !_Jump_Gravity_Counter then _Ch0_Sound  =  _c_Jump_Sound  :  _Ch0_Duration  =  1  :  _Ch0_Counter  =  0

	LDA _Jump_Gravity_Counter
	BNE .skipL0164
.condpart11
	LDA #_c_Jump_Sound
	STA _Ch0_Sound
	LDA #1
	STA _Ch0_Duration
	LDA #0
	STA _Ch0_Counter
.skipL0164
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0165 ;  _Bit3_FireB_Restrainer{3}  =  1

	LDA _Bit3_FireB_Restrainer
	ORA #8
	STA _Bit3_FireB_Restrainer
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0166 ;  _Jump_Gravity_Counter  =  _Jump_Gravity_Counter  +  1

	INC _Jump_Gravity_Counter
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0167 ;  if _Jump_Gravity_Counter  >  12 then _Jump_Gravity_Counter  =  0  :  _Bit2_Fall_in_Progress{2}  =  1  :  goto __Skip_Jump

	LDA #12
	CMP _Jump_Gravity_Counter
     BCS .skipL0167
.condpart12
	LDA #0
	STA _Jump_Gravity_Counter
	LDA _Bit2_Fall_in_Progress
	ORA #4
	STA _Bit2_Fall_in_Progress
 jmp .__Skip_Jump

.skipL0167
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0168 ;  if player1y  <  13 then goto __Skip_Jump

	LDA player1y
	CMP #13
     BCS .skipL0168
.condpart13
 jmp .__Skip_Jump

.skipL0168
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0169 ;  if _Jump_Gravity_Counter  <=  7 then temp6  =  3

	LDA #7
	CMP _Jump_Gravity_Counter
     BCC .skipL0169
.condpart14
	LDA #3
	STA temp6
.skipL0169
.L0170 ;  if _Jump_Gravity_Counter  >  7  &&  _Jump_Gravity_Counter  <=  10 then temp6  =  2

	LDA #7
	CMP _Jump_Gravity_Counter
     BCS .skipL0170
.condpart15
	LDA #10
	CMP _Jump_Gravity_Counter
     BCC .skip15then
.condpart16
	LDA #2
	STA temp6
.skip15then
.skipL0170
.L0171 ;  if _Jump_Gravity_Counter  >  10 then temp6  =  1

	LDA #10
	CMP _Jump_Gravity_Counter
     BCS .skipL0171
.condpart17
	LDA #1
	STA temp6
.skipL0171
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0172 ;  player1y  =  player1y  -  temp6

	LDA player1y
	SEC
	SBC temp6
	STA player1y
.
 ; 

.__Skip_Jump
 ; __Skip_Jump

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0173 ;  if _Jump_Gravity_Counter then goto __Skip_Fall_01

	LDA _Jump_Gravity_Counter
	BEQ .skipL0173
.condpart18
 jmp .__Skip_Fall_01

.skipL0173
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0174 ;  if player1y  >=  79 then player1y  =  80  :  goto __Skip_Fall_01

	LDA player1y
	CMP #79
     BCC .skipL0174
.condpart19
	LDA #80
	STA player1y
 jmp .__Skip_Fall_01

.skipL0174
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0175 ;  player1:

	LDX #<playerL0175_1
	STX player1pointerlo
	LDA #>playerL0175_1
	STA player1pointerhi
	LDA #9
	STA player1height
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0176 ;  if !joy0left  &&  !joy0right then player1:

 bit SWCHA
	BVC .skipL0176
.condpart20
 bit SWCHA
	BPL .skip20then
.condpart21
	LDX #<player21then_1
	STX player1pointerlo
	LDA #>player21then_1
	STA player1pointerhi
	LDA #9
	STA player1height
.skip20then
.skipL0176
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0177 ;  _Fall_Gravity_Counter  =  _Fall_Gravity_Counter  +  1

	INC _Fall_Gravity_Counter
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0178 ;  temp6  =  0

	LDA #0
	STA temp6
.L0179 ;  if _Fall_Gravity_Counter  >  8  &&  _Jump_Gravity_Counter  <=  16 then temp6  =  1

	LDA #8
	CMP _Fall_Gravity_Counter
     BCS .skipL0179
.condpart22
	LDA #16
	CMP _Jump_Gravity_Counter
     BCC .skip22then
.condpart23
	LDA #1
	STA temp6
.skip22then
.skipL0179
.L0180 ;  if _Fall_Gravity_Counter  >  16  &&  _Jump_Gravity_Counter  <=  24 then temp6  =  2

	LDA #16
	CMP _Fall_Gravity_Counter
     BCS .skipL0180
.condpart24
	LDA #24
	CMP _Jump_Gravity_Counter
     BCC .skip24then
.condpart25
	LDA #2
	STA temp6
.skip24then
.skipL0180
.L0181 ;  if _Fall_Gravity_Counter  >  24  &&  _Jump_Gravity_Counter  <=  32 then temp6  =  3

	LDA #24
	CMP _Fall_Gravity_Counter
     BCS .skipL0181
.condpart26
	LDA #32
	CMP _Jump_Gravity_Counter
     BCC .skip26then
.condpart27
	LDA #3
	STA temp6
.skip26then
.skipL0181
.L0182 ;  if _Fall_Gravity_Counter  >  32 then temp6  =  4

	LDA #32
	CMP _Fall_Gravity_Counter
     BCS .skipL0182
.condpart28
	LDA #4
	STA temp6
.skipL0182
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0183 ;  player1y  =  player1y  +  temp6

	LDA player1y
	CLC
	ADC temp6
	STA player1y
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0184 ;  _Bit2_Fall_in_Progress{2}  =  1

	LDA _Bit2_Fall_in_Progress
	ORA #4
	STA _Bit2_Fall_in_Progress
.
 ; 

.L0185 ;  goto __Skip_Fall_02

 jmp .__Skip_Fall_02

.
 ; 

.__Skip_Fall_01
 ; __Skip_Fall_01

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0186 ;  _Bit2_Fall_in_Progress{2}  =  0  :  _Fall_Gravity_Counter  =  0

	LDA _Bit2_Fall_in_Progress
	AND #251
	STA _Bit2_Fall_in_Progress
	LDA #0
	STA _Fall_Gravity_Counter
.
 ; 

.__Skip_Fall_02
 ; __Skip_Fall_02

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0187 ;  _Bit5_LR_Joy_Movement{5}  =  0

	LDA _Bit5_LR_Joy_Movement
	AND #223
	STA _Bit5_LR_Joy_Movement
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0188 ;  if !joy0left then goto __Skip_Joy0Left

 bit SWCHA
	BVC .skipL0188
.condpart29
 jmp .__Skip_Joy0Left

.skipL0188
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0189 ;  _Bit5_LR_Joy_Movement{5}  =  1

	LDA _Bit5_LR_Joy_Movement
	ORA #32
	STA _Bit5_LR_Joy_Movement
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0190 ;  if player1x  >  17 then _P1_Left_Right  =  _P1_Left_Right  -  1.38

	LDA #17
	CMP player1x
     BCS .skipL0190
.condpart30
	LDA a
	SEC 
	SBC #97
	STA a
	LDA _P1_Left_Right
	SBC #1
	STA _P1_Left_Right
.skipL0190
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0191 ;  _Bit4_Flip_P1{4}  =  0

	LDA _Bit4_Flip_P1
	AND #239
	STA _Bit4_Flip_P1
.
 ; 

.__Skip_Joy0Left
 ; __Skip_Joy0Left

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0192 ;  if !joy0right then goto __Skip_Joy0Right

 bit SWCHA
	BPL .skipL0192
.condpart31
 jmp .__Skip_Joy0Right

.skipL0192
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0193 ;  _Bit5_LR_Joy_Movement{5}  =  1

	LDA _Bit5_LR_Joy_Movement
	ORA #32
	STA _Bit5_LR_Joy_Movement
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0194 ;  if player1x  <  137 then _P1_Left_Right  =  _P1_Left_Right  +  1.38

	LDA player1x
	CMP #137
     BCS .skipL0194
.condpart32
	LDA a
	CLC 
	ADC #97
	STA a
	LDA _P1_Left_Right
	ADC #1
	STA _P1_Left_Right
.skipL0194
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0195 ;  _Bit4_Flip_P1{4}  =  1

	LDA _Bit4_Flip_P1
	ORA #16
	STA _Bit4_Flip_P1
.
 ; 

.__Skip_Joy0Right
 ; __Skip_Joy0Right

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0196 ;  if !_Bit5_LR_Joy_Movement{5} then goto __Done_Anim_jump

	LDA _Bit5_LR_Joy_Movement
	AND #32
	BNE .skipL0196
.condpart33
 jmp .__Done_Anim_jump

.skipL0196
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0197 ;  if _Jump_Gravity_Counter  ||  _Bit2_Fall_in_Progress{2} then goto __Done_Anim_jump

	LDA _Jump_Gravity_Counter
	BEQ .skipL0197
.condpart34
 jmp .condpart35
.skipL0197
	LDA _Bit2_Fall_in_Progress
	AND #4
	BEQ .skip9OR
.condpart35
 jmp .__Done_Anim_jump

.skip9OR
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0198 ;  if player1x  <  18  ||  player1x  >  136 then goto __Done_Anim_jump

	LDA player1x
	CMP #18
     BCS .skipL0198
.condpart36
 jmp .condpart37
.skipL0198
	LDA #136
	CMP player1x
     BCS .skip10OR
.condpart37
 jmp .__Done_Anim_jump

.skip10OR
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0199 ;  player1color:

	LDX #<playercolorL0199_1
	STX player1color
	LDA #>playercolorL0199_1
	STA player1color+1
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0200 ;  on _Frame_Counter goto __Frame0 __Frame1 __Frame0 __Frame2

	LDX _Frame_Counter
	LDA .L0200jumptablehi,x
	PHA
	LDA .L0200jumptablelo,x
	PHA
	RTS
.L0200jumptablehi
	.byte >(.__Frame0-1)
	.byte >(.__Frame1-1)
	.byte >(.__Frame0-1)
	.byte >(.__Frame2-1)
.L0200jumptablelo
	.byte <(.__Frame0-1)
	.byte <(.__Frame1-1)
	.byte <(.__Frame0-1)
	.byte <(.__Frame2-1)
.
 ; 

.__Done_Anim_jump
 ; __Done_Anim_jump

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0201 ;  if _Bit4_Flip_P1{4} then REFP1  =  8

	LDA _Bit4_Flip_P1
	AND #16
	BEQ .skipL0201
.condpart38
	LDA #8
	STA REFP1
.skipL0201
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0202 ;  if !_Ch0_Sound then goto __Skip_Ch_0

	LDA _Ch0_Sound
	BNE .skipL0202
.condpart39
 jmp .__Skip_Ch_0

.skipL0202
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0203 ;  _Ch0_Duration  =  _Ch0_Duration  -  1

	DEC _Ch0_Duration
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0204 ;  if _Ch0_Duration then goto __Skip_Ch_0

	LDA _Ch0_Duration
	BEQ .skipL0204
.condpart40
 jmp .__Skip_Ch_0

.skipL0204
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0205 ;  if _Ch0_Sound  <>  _c_Jump_Sound then goto __Skip_Ch0_Sound_001

	LDA _Ch0_Sound
	CMP #_c_Jump_Sound
     BEQ .skipL0205
.condpart41
 jmp .__Skip_Ch0_Sound_001

.skipL0205
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0206 ;  temp4  =  _SD_Jump[_Ch0_Counter]

	LDX _Ch0_Counter
	LDA _SD_Jump,x
	STA temp4
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0207 ;  if temp4  =  255 then goto __Clear_Ch_0

	LDA temp4
	CMP #255
     BNE .skipL0207
.condpart42
 jmp .__Clear_Ch_0

.skipL0207
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0208 ;  _Ch0_Counter  =  _Ch0_Counter  +  1

	INC _Ch0_Counter
.L0209 ;  temp5  =  _SD_Jump[_Ch0_Counter]  :  _Ch0_Counter  =  _Ch0_Counter  +  1

	LDX _Ch0_Counter
	LDA _SD_Jump,x
	STA temp5
	INC _Ch0_Counter
.L0210 ;  temp6  =  _SD_Jump[_Ch0_Counter]  :  _Ch0_Counter  =  _Ch0_Counter  +  1

	LDX _Ch0_Counter
	LDA _SD_Jump,x
	STA temp6
	INC _Ch0_Counter
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0211 ;  AUDV0  =  temp4

	LDA temp4
	STA AUDV0
.L0212 ;  AUDC0  =  temp5

	LDA temp5
	STA AUDC0
.L0213 ;  AUDF0  =  temp6

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

.L0214 ;  _Ch0_Duration  =  _SD_Jump[_Ch0_Counter]  :  _Ch0_Counter  =  _Ch0_Counter  +  1

	LDX _Ch0_Counter
	LDA _SD_Jump,x
	STA _Ch0_Duration
	INC _Ch0_Counter
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0215 ;  goto __Skip_Ch_0

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

.L0216 ;  goto __Skip_Ch_0

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

.L0217 ;  _Ch0_Sound  =  0  :  AUDV0  =  0

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

.L0218 ;  drawscreen

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

.L0219 ;  if !switchreset then _Bit7_Reset_Restrainer{7}  =  0  :  goto __Main_Loop

 lda #1
 bit SWCHB
	BEQ .skipL0219
.condpart43
	LDA _Bit7_Reset_Restrainer
	AND #127
	STA _Bit7_Reset_Restrainer
 jmp .__Main_Loop

.skipL0219
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0220 ;  if _Bit7_Reset_Restrainer{7} then goto __Main_Loop

	BIT _Bit7_Reset_Restrainer
	BPL .skipL0220
.condpart44
 jmp .__Main_Loop

.skipL0220
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0221 ;  goto __Start_Restart

 jmp .__Start_Restart

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.L0222 ;  data _SD_Jump

	JMP .skipL0222
_SD_Jump
	.byte    1,12,31

	.byte    1

	.byte    8,12,31

	.byte    1

	.byte    6,12,31

	.byte    1

	.byte    8,12,31

	.byte    1

	.byte    8,12,30

	.byte    1

	.byte    8,12,29

	.byte    1

	.byte    8,12,28

	.byte    1

	.byte    8,12,27

	.byte    1

	.byte    8,12,26

	.byte    1

	.byte    8,12,25

	.byte    1

	.byte    8,12,24

	.byte    1

	.byte    8,12,23

	.byte    1

	.byte    8,12,22

	.byte    1

	.byte    8,12,21

	.byte    1

	.byte    8,12,20

	.byte    1

	.byte    8,12,19

	.byte    1

	.byte    6,12,18

	.byte    1

	.byte    4,12,17

	.byte    1

	.byte    2,12,16

	.byte    2

	.byte    0,0,0

	.byte    8

	.byte    255

.skipL0222
.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.
 ; 

.__Frame0
 ; __Frame0

.L0223 ;  player1:

	LDX #<playerL0223_1
	STX player1pointerlo
	LDA #>playerL0223_1
	STA player1pointerhi
	LDA #9
	STA player1height
.
 ; 

.L0224 ;  goto __Done_Anim_jump

 jmp .__Done_Anim_jump

.
 ; 

.
 ; 

.__Frame1
 ; __Frame1

.L0225 ;  player1:

	LDX #<playerL0225_1
	STX player1pointerlo
	LDA #>playerL0225_1
	STA player1pointerhi
	LDA #9
	STA player1height
.
 ; 

.L0226 ;  goto __Done_Anim_jump

 jmp .__Done_Anim_jump

.
 ; 

.
 ; 

.__Frame2
 ; __Frame2

.L0227 ;  player1:

	LDX #<playerL0227_1
	STX player1pointerlo
	LDA #>playerL0227_1
	STA player1pointerhi
	LDA #9
	STA player1height
.
 ; 

.L0228 ;  goto __Done_Anim_jump
 jmp .__Done_Anim_jump
 if (<*) > (<(*+9))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playercolorL0157_1
	.byte    _26
	.byte    _9C
	.byte    _9C
	.byte    _9C
	.byte    _DA
	.byte    _DA
	.byte    _3C
	.byte    _3C
	.byte    _3C
	.byte    _26
 if (<*) > (<(*+9))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0158_1
	.byte    %01100110
	.byte    %00100100
	.byte    %00111100
	.byte    %00011000
	.byte    %01011010
	.byte    %00111100
	.byte    %00011000
	.byte    %00111100
	.byte    %00111100
	.byte    %00011000
 if (<*) > (<(*+9))
	repeat ($100-<*)
	.byte 0
	repend
	endif
player3then_1
	.byte    %11000011
	.byte    %01100011
	.byte    %00111110
	.byte    %00011100
	.byte    %00111101
	.byte    %01011110
	.byte    %00011000
	.byte    %00111100
	.byte    %00111100
	.byte    %00011000
 if (<*) > (<(*+9))
	repeat ($100-<*)
	.byte 0
	repend
	endif
player6then_1
	.byte    %01100110
	.byte    %00100100
	.byte    %00111100
	.byte    %00011000
	.byte    %00011000
	.byte    %01111110
	.byte    %10011001
	.byte    %00111100
	.byte    %00111100
	.byte    %00011000
 if (<*) > (<(*+9))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0175_1
	.byte    %11000011
	.byte    %01100011
	.byte    %00111110
	.byte    %00011100
	.byte    %00111101
	.byte    %01011110
	.byte    %00011000
	.byte    %00111100
	.byte    %00111100
	.byte    %00011000
 if (<*) > (<(*+9))
	repeat ($100-<*)
	.byte 0
	repend
	endif
player21then_1
	.byte    %01100110
	.byte    %00100100
	.byte    %00111100
	.byte    %00011000
	.byte    %00011000
	.byte    %01111110
	.byte    %10011001
	.byte    %00111100
	.byte    %00111100
	.byte    %00011000
 if (<*) > (<(*+9))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playercolorL0199_1
	.byte    _26
	.byte    _9C
	.byte    _9C
	.byte    _9C
	.byte    _DA
	.byte    _DA
	.byte    _3C
	.byte    _3C
	.byte    _3C
	.byte    _26
 if (<*) > (<(*+9))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0223_1
	.byte    %01100110
	.byte    %00100110
	.byte    %00111100
	.byte    %00011100
	.byte    %00111100
	.byte    %00011100
	.byte    %00011000
	.byte    %00111100
	.byte    %00111100
	.byte    %00011000
 if (<*) > (<(*+9))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0225_1
	.byte    %11000011
	.byte    %01100011
	.byte    %00111110
	.byte    %00011100
	.byte    %00111100
	.byte    %01011110
	.byte    %00011000
	.byte    %00111100
	.byte    %00111100
	.byte    %00011000
 if (<*) > (<(*+9))
	repeat ($100-<*)
	.byte 0
	repend
	endif
playerL0227_1
	.byte    %00111100
	.byte    %00011100
	.byte    %00011100
	.byte    %00011100
	.byte    %00011100
	.byte    %00011100
	.byte    %00011000
	.byte    %00111100
	.byte    %00111100
	.byte    %00011000
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
