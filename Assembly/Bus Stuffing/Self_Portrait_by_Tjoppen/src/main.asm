    processor 6502
    include vcs.h
    include macro.h

;FPS = 50 or 60
;PAL = 0 or 1
#if FPS==50         ;PAL
VBLNK   equ 48
LINES   equ 228
OVERSCN equ 36
#else               ;NTSC
VBLNK   equ 40
LINES   equ 192
OVERSCN equ 30
#endif

VBLNK64 equ VBLNK*19/16-1   ;value to set TIM64 to for VBLNK
OVERS64 equ OVERSCN*19/16   ;ditto for overscan

    ;RAM
    SEG.U VARS
    org $80

temp    ds  1
line    ds  1
lineptr ds  2

    echo "RAM:", ($100 - *), "bytes left"

    ;ROM
    SEG CODE
    org $1000

    include build/idolbild.asm

    ;3*75 =  225 B, fits in page $10
As
    AS

Xs
    XS

Ys
    YS

    LINES

Start
    CLEAN_START

MainLoop
    VERTICAL_SYNC
    lda #VBLNK64
    sta TIM64T

    lda #<Line0
    sta lineptr
    lda #>Line0
    sta lineptr+1
    jmp WaitForVblankEnd

    align 128
WaitForVblankEnd
    align 1
    lda INTIM
    bmi WaitForVblankEnd_Overflow
    bne WaitForVblankEnd
WaitForVblankEnd_Overflow
    lda #0
    sta VBLANK
    ;NOTE: Don't set COLUBK before VBLANK has been turned off (above)
    ;      Otherwise you get ugly colors for the first few lines

    sta WSYNC

    dec temp
    dec temp
    dec temp
    dec temp
    dec temp
    nop
    nop

    lda #BMPH-1
    sta line
Kernel
    dec temp
    dec temp
    dec temp
    dec temp
    dec temp
    nop 0

    ldx line
    lda Xs,X
    sta temp
    lda As,X
    ldy Ys,X
    ldx temp

    jsr Stub

    nop 0
    nop 0

    jsr Stub

    lda #0
    sta COLUBK

    lda lineptr
    clc
    adc #BMPW*2+1
    sta lineptr
    lda lineptr+1
    adc #0
    sta lineptr+1

    dec line
    bpl Kernel
#if >Kernel - >*
    echo "Kernel not aligned"
    ERR
#endif

    ldx #LINES-BMPH*3 - 1
Burn
    sta WSYNC
    dex
    bne Burn

    lda #OVERS64
    sta TIM64T
    lda #2
    sta VBLANK
WaitForOverscanEnd
    lda INTIM
    bmi WaitForOverscanEnd_Overflow
    bne WaitForOverscanEnd
WaitForOverscanEnd_Overflow
    jmp MainLoop

Stub
    jmp (lineptr)

    echo "ROM:", ($1FFC - *), "bytes left"

    org $1FFC
    .word Start
    .word Start
