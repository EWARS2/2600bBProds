; 160 bitmap kernel created by ZackAttack for Bus Stuffing:
;
; http://atariage.com/forums/topic/278667-36-character-demo/?p=4031676
;
; This testrom of the kernel written by Omegamatrix
; last update May 22, 2018

      processor 6502
    LIST OFF
      include vcs.h
      include macro.h
    LIST ON

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;      CONSTANTS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TOP_LINES            = 93
BOTTOM_LINES         = 85
KERNEL_LINES         = 10

START_POS            = 0
LAST_POS             = 159

TIME_VBLANK          = 46
TIME_OVERSCAN        = 25


P0_POS_EVEN_KERNEL   = 150
P1_POS_EVEN_KERNEL   = 37
M1_POS_EVEN_KERNEL   = 125+1
BL_POS_EVEN_KERNEL   = 154+1

P0_POS_ODD_KERNEL    = 126
P1_POS_ODD_KERNEL    = 14
M1_POS_ODD_KERNEL    = 141+1
BL_POS_ODD_KERNEL    = 130+1


COL_TEXT             = $0E
COL_SCREEN           = $AC

SPEED_MASK           = $07

;NUSIZx
ONE_COPY             = $00
TWO_COPIES_CLOSE     = $01
TWO_COPIES_MED       = $02
THREE_COPIES_CLOSE   = $03
TWO_COPIES_WIDE      = $04
DOUBLE_SIZE          = $05
THREE_COPIES_MED     = $06
QUAD_SIZE            = $07

;CTRLPF bits
PF_REFLECT           = $01
PF_SCORE             = $02
PF_PRIORITY          = $04
BALL_8_CLKS          = $30
BALL_4_CLKS          = $20
BALL_2_CLKS          = $10
BALL_1_CLK           = $00

ENABLE               = 2
DISABLE              = 0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;      RAM
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

        SEG.U variables
        ORG $80

frameCounter   ds 1
loopCount      ds 1
bitIndex       ds 1
decHundreds    ds 1
decTens        ds 1
decOnes        ds 1
hundredsPtr    ds 2
tensPtr        ds 2
onesPtr        ds 2
ramKernel      ds 55




;------------------------------------------------------------------------------
;                                 MAIN PROGRAM
;------------------------------------------------------------------------------

        SEG code
        ORG $F000

START:
    cld
.splshLoopClear:
    ldx    #$0A                  ; ASL opcode = $0A
    inx
    txs
    pha
    bne    .splshLoopClear+1     ; jump between operator and operand to do ASL

;------------------------------------------------------------------------------
;                               VSYNC AND VBLANK
;------------------------------------------------------------------------------

LoopMain:
    lda    #$0E
.loopVsync:
    sta    WSYNC
;---------------------------------------
    sta    VSYNC
    lsr
    bne    .loopVsync

    lda    #TIME_VBLANK
    sta    TIM64T


    lda    #COL_SCREEN
    sta    COLUBK
    lda    #COL_TEXT
    sta    COLUP0
    sta    COLUP1
    lda    #THREE_COPIES_CLOSE
    sta    NUSIZ0
    lda    #TWO_COPIES_WIDE
    sta    NUSIZ1


    lda    #BALL_1_CLK | PF_PRIORITY
    sta    CTRLPF

;---------------------------------------
;  Do Positioning
;---------------------------------------

    lda    frameCounter
    and    #$01
    tay

    lda    P0_Tab,Y
    ldx    #0
    jsr    Positioning

    lda    P1_Tab,Y
    inx                        ; X=1
    jsr    Positioning

    lda    M1_Tab,Y
    ldx    #3
    jsr    Positioning

    lda    BL_Tab,Y
    inx                        ; X=4
    jsr    Positioning

    sta    WSYNC
;---------------------------------------
    sta    HMOVE



    lda    frameCounter
    lsr
    bcs    .prepKernelB


    ldx    #EndKernelA-StartKernelA
.loopLoadRamKernelA:
    lda    StartKernelA,X
    sta    ramKernel,X
    dex
    bpl    .loopLoadRamKernelA
    jmp    EndKernelPrep


.prepKernelB:
    ldx    #EndKernelB-StartKernelB
.loopLoadRamKernelB:
    lda    StartKernelB,X
    sta    ramKernel,X
    dex
    bpl    .loopLoadRamKernelB

EndKernelPrep:

    ldy    bitIndex
    lda    KernelTab,Y
    eor    frameCounter
    and    #$01
    bne    .finishKernelMod

    ldx    IndexTab,Y
    lda    #$85                ; STA
    sta    ramKernel,X
.finishKernelMod:



.waitVblank:
    lda    INTIM
    bne    .waitVblank
    sta    WSYNC
;---------------------------------------
    sta    VBLANK


;------------------------------------------------------------------------------
;                                 KERNEL
;------------------------------------------------------------------------------

    ldy    #TOP_LINES
.loopTop:
    sta    WSYNC
;---------------------------------------
    dey
    bne    .loopTop

    lda    #KERNEL_LINES
    sta    loopCount
    lda    frameCounter
    lsr

    ldy    bitIndex
    lda    HideBitValueTab,Y
    ldy    #$FF

    bcc    .evenFrameDraw
    jmp    .oddFrameDraw

.evenFrameDraw:
    sta    WSYNC
;---------------------------------------
    ldx    #14
.loopDelayA:
    dex
    bne    .loopDelayA
    ldx    #$FE
    sty    ENABL
    SLEEP 3
    jmp    ramKernel + EnterKernelA-StartKernelA


.oddFrameDraw:
    sta    WSYNC
;---------------------------------------
    ldx    #14
.loopDelayB:
    dex
    bne    .loopDelayB
    ldx    #$FE
    sty    ENABL
    SLEEP 3
    jmp    ramKernel + EnterKernelB-StartKernelB

FinishKernel:
    lda    #0                  ; clear all
    sta    GRP0
    sta    GRP1
    sta    ENABL
    sta    ENAM1


    ldy    #BOTTOM_LINES
.loopBottom:
    sta    WSYNC
;---------------------------------------
    dey
    bne    .loopBottom

    lda    #TWO_COPIES_CLOSE
    sta    NUSIZ0
    lda    #ONE_COPY
    sta    NUSIZ1

;set pointers
    lda    decHundreds
    asl
    asl
    asl
    sta    hundredsPtr
    lda    decTens
    asl
    asl
    asl
    sta    tensPtr
    lda    decOnes
    sta    RESP0
    sta    RESP1
    asl
    asl
    asl
    sta    onesPtr
    lda    #>Zero
    sta    hundredsPtr+1
    sta    tensPtr+1
    sta    onesPtr+1

    ldy     #7
.loopDigits:
    sta    WSYNC
;---------------------------------------
    lda    (hundredsPtr),Y
    sta    GRP0
    lda    (tensPtr),Y
    asl
    sta    GRP1
    SLEEP  23
    lda    (onesPtr),Y
    sta    GRP0
    dey
    bpl    .loopDigits

;------------------------------------------------------------------------------
;                                 OVERSCAN
;------------------------------------------------------------------------------

    sta    WSYNC
;---------------------------------------
    lda    #2
    sta    VBLANK
    lda    #TIME_OVERSCAN
    sta    TIM64T

    inc    frameCounter

    lda    frameCounter
    and    #SPEED_MASK
    bne    .skipJoyCheck

.checkJoy:
    lda    SWCHA  ; RLDU
    asl
    bcs    .checkLeft
    inc    bitIndex
.checkLeft:
    asl
    bcs    .finishJoy
    dec    bitIndex
.finishJoy:
    lda    bitIndex
    cmp    #LAST_POS+1
    bne    .checkLeftBoundary
    lda    #START_POS          ; roll around
.checkLeftBoundary:
    cmp    #START_POS-1
    bne    .storeIndexPos
    lda    #LAST_POS
.storeIndexPos:
    sta    bitIndex

.skipJoyCheck:


    lda    bitIndex
    sec
    ldx    #-1
.loopHundreds:
    sbc    #100
    inx
    bcs    .loopHundreds
    adc    #100
    stx    decHundreds

    sec
    ldx    #-1
.loopTens:
    sbc    #10
    inx
    bcs    .loopTens
    adc    #10
    stx    decTens

    sec
    ldx    #-1
.loopOnes:
    sbc    #1
    inx
    bcs    .loopOnes
    stx    decOnes


.waitOverscan:
    lda    INTIM
    bne    .waitOverscan
    jmp    LoopMain


       ALIGN 256

;------------------------------------------------------------------------------
;                                 SUBROUTINES
;------------------------------------------------------------------------------


Positioning: SUBROUTINE
    sec
    sta    WSYNC
;---------------------------------------
.divide15:
    sbc    #15
    bcs    .divide15
    eor    #7
    asl
    asl
    asl
    asl
    sta.wx HMP0,X
    sta    RESP0,X
    rts


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;







;------------------------------------------------------------------------------
;                               GFX AND DATA
;------------------------------------------------------------------------------

P0_Tab:
    .byte P0_POS_ODD_KERNEL
    .byte P0_POS_EVEN_KERNEL

P1_Tab:
    .byte P1_POS_ODD_KERNEL
    .byte P1_POS_EVEN_KERNEL

M1_Tab:
    .byte M1_POS_ODD_KERNEL
    .byte M1_POS_EVEN_KERNEL

BL_Tab:
    .byte BL_POS_ODD_KERNEL
    .byte BL_POS_EVEN_KERNEL



  IF ECHO_TEXT
     ECHO "Kernel A", [EndKernelA-*]d, "Bytes"
  ENDIF

StartKernelA:

.loopKernelA:
    ldx    #$FE
EnterKernelA:
.a_1:
    sty    GRP0
.a_2:
    sty    GRP1
    ldy    #COL_TEXT
.a_bit2:
    sty    COLUPF
    ldy    #$FF
.a_bit1:
    sty    ENAM1
    sta    RESP0  ;25
.a_3:
    stx    GRP0
    sta    RESP0  ;31
.a_6:
    sty    GRP1
.a_4:
    sty    GRP0
.a_bit3:
    sty    ENAM1
.a_5:
    sty    GRP0
    sta    RESP0  ;46
.a_7:
    sty    GRP0
    sta    RESP0  ;52
    ldx    #$FE
.a_8:
    sty    GRP0
.a_9:
    sty    GRP0
    sta    RESP0  ;63
.a_10:
    stx    GRP0
.a_11:
    sty    GRP0
.a_12:
    sty    GRP0
    dec    loopCount
    bne    .loopKernelA
    jmp    FinishKernel

EndKernelA:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  IF ECHO_TEXT
     ECHO "Kernel B", [EndKernelB-*]d, "Bytes"
  ENDIF

StartKernelB:
EnterKernelB:
.loopKernelB:
.b_1:
    sty    GRP0
.b_3:
    sty    GRP1
    ldy    #0
    sty    ENAM1
    ldy    #COL_TEXT
.b_bit2:
    sty    COLUPF
    ldy    #$FF
    ldx    #$FE
.b_2:
    sty    GRP0
    sta.w  RESP0  ;33
.b_4:
    sty    GRP0
    sta    RESP0  ;39
.b_7:
    sty    GRP1
.b_5:
    sty    GRP0
.b_bit1:
    sty    ENAM1
.b_6:
    stx    GRP0
    sta    RESP0  ;54
.b_8:
    sty    GRP0
    sta    RESP0  ;60
    NOP
.b_9:
    sty    GRP0
.b_10:
    sty    GRP0
    sta    RESP0  ;71
.b_11:
    sty    GRP0
    dec    loopCount
    bne    .loopKernelB
    jmp    FinishKernel

EndKernelB:



KernelTab:
    .byte 0    ; 0
    .byte 0    ; 1
    .byte 0    ; 2
    .byte 0    ; 3
    .byte 0    ; 4
    .byte 0    ; 5
    .byte 1    ; 6
    .byte 1    ; 7

    .byte 1    ; 8
    .byte 1    ; 9
    .byte 1    ; 10
    .byte 1    ; 11
    .byte 1    ; 12
    .byte 1    ; 13
    .byte 0    ; 14
    .byte 0    ; 15

    .byte 0    ; 16
    .byte 0    ; 17
    .byte 0    ; 18
    .byte 0    ; 19
    .byte 0    ; 20
    .byte 0    ; 21
    .byte 1    ; 22
    .byte 1    ; 23

    .byte 1    ; 24
    .byte 1    ; 25
    .byte 1    ; 26
    .byte 1    ; 27
    .byte 1    ; 28
    .byte 1    ; 29
    .byte 0    ; 30
    .byte 0    ; 31

    .byte 0    ; 32
    .byte 0    ; 33
    .byte 0    ; 34
    .byte 0    ; 35
    .byte 0    ; 36
    .byte 1    ; 37
    .byte 1    ; 38
    .byte 1    ; 39

    .byte 1    ; 40
    .byte 1    ; 41
    .byte 1    ; 42
    .byte 1    ; 43
    .byte 1    ; 44
    .byte 0    ; 45
    .byte 0    ; 46
    .byte 0    ; 47

    .byte 0    ; 48
    .byte 0    ; 49
    .byte 0    ; 50
    .byte 0    ; 51
    .byte 0    ; 52
    .byte 0    ; 53
    .byte 1    ; 54
    .byte 1    ; 55

    .byte 1    ; 56
    .byte 1    ; 57
    .byte 1    ; 58
    .byte 1    ; 59
    .byte 1    ; 60
    .byte 1    ; 61
    .byte 0    ; 62
    .byte 0    ; 63

    .byte 0    ; 64
    .byte 0    ; 65
    .byte 0    ; 66
    .byte 0    ; 67
    .byte 0    ; 68
    .byte 0    ; 69
    .byte 1    ; 70
    .byte 1    ; 71

    .byte 1    ; 72
    .byte 1    ; 73
    .byte 1    ; 74
    .byte 1    ; 75
    .byte 1    ; 76
    .byte 1    ; 77
    .byte 0    ; 78
    .byte 0    ; 79

    .byte 0    ; 80
    .byte 0    ; 81
    .byte 0    ; 82
    .byte 0    ; 83
    .byte 0    ; 84
    .byte 0    ; 85
    .byte 1    ; 86
    .byte 1    ; 87

    .byte 1    ; 88
    .byte 1    ; 89
    .byte 1    ; 90
    .byte 1    ; 91
    .byte 1    ; 92
    .byte 0    ; 93
    .byte 0    ; 94
    .byte 0    ; 95

    .byte 0    ; 96
    .byte 0    ; 97
    .byte 0    ; 98
    .byte 0    ; 99
    .byte 0    ; 100
    .byte 1    ; 101
    .byte 1    ; 102
    .byte 1    ; 103

    .byte 1    ; 104
    .byte 1    ; 105
    .byte 1    ; 106
    .byte 1    ; 107
    .byte 1    ; 108
    .byte 0    ; 109
    .byte 0    ; 110
    .byte 0    ; 111

    .byte 0    ; 112
    .byte 0    ; 113
    .byte 0    ; 114
    .byte 0    ; 115
    .byte 0    ; 116
    .byte 1    ; 117
    .byte 1    ; 118
    .byte 1    ; 119

    .byte 1    ; 120
    .byte 1    ; 121
    .byte 1    ; 122
    .byte 1    ; 123
    .byte 1    ; 124
    .byte 1    ; 125
    .byte 0    ; 126
    .byte 0    ; 127

    .byte 0    ; 128
    .byte 0    ; 129
    .byte 0    ; 130
    .byte 0    ; 131
    .byte 0    ; 132
    .byte 1    ; 133
    .byte 1    ; 134
    .byte 1    ; 135

    .byte 1    ; 136
    .byte 1    ; 137
    .byte 1    ; 138
    .byte 1    ; 139
    .byte 1    ; 140
    .byte 0    ; 141
    .byte 0    ; 142
    .byte 0    ; 143

    .byte 0    ; 144
    .byte 0    ; 145
    .byte 0    ; 146
    .byte 0    ; 147
    .byte 0    ; 148
    .byte 0    ; 149
    .byte 1    ; 150
    .byte 1    ; 151

    .byte 1    ; 152
    .byte 1    ; 153
    .byte 1    ; 154
    .byte 1    ; 155
    .byte 1    ; 156
    .byte 1    ; 157
    .byte 0    ; 158
    .byte 0    ; 159

HideBitValueTab:
    .byte $1F    ; 0
    .byte $2F    ; 1
    .byte $37    ; 2
    .byte $3B    ; 3
    .byte $3D    ; 4
    .byte $3E    ; 5
    .byte $7F    ; 6
    .byte $BF    ; 7

    .byte $DF    ; 8
    .byte $EF    ; 9
    .byte $F7    ; 10
    .byte $FB    ; 11
    .byte $FD    ; 12
    .byte $FE    ; 13
    .byte $7F    ; 14
    .byte $BF    ; 15

    .byte $DF    ; 16
    .byte $EF    ; 17
    .byte $F7    ; 18
    .byte $FB    ; 19
    .byte $FD    ; 20
    .byte $FE    ; 21
    .byte $7F    ; 22
    .byte $BF    ; 23

    .byte $DF    ; 24
    .byte $EF    ; 25
    .byte $F7    ; 26
    .byte $FB    ; 27
    .byte $FD    ; 28
    .byte $FE    ; 29
    .byte $7E    ; 30
    .byte $BE    ; 31

    .byte $DE    ; 32
    .byte $EE    ; 33
    .byte $F6    ; 34
    .byte $FA    ; 35
    .byte $FC    ; 36
    .byte $7F    ; 37
    .byte $BF    ; 38
    .byte $DF    ; 39

    .byte $EF    ; 40
    .byte $F7    ; 41
    .byte $FB    ; 42
    .byte $FD    ; 43
    .byte $FE    ; 44
    .byte DISABLE  ; 45  (.a_bit1)  Disable M1 to hide pixel
    .byte $7F    ; 46
    .byte $BF    ; 47

    .byte $DF    ; 48
    .byte $EF    ; 49
    .byte $F7    ; 50
    .byte $FB    ; 51
    .byte $FD    ; 52
    .byte $FE    ; 53
    .byte $7F    ; 54
    .byte $BF    ; 55

    .byte $DF    ; 56
    .byte $EF    ; 57
    .byte $F7    ; 58
    .byte $FB    ; 59
    .byte $FD    ; 60
    .byte $FE    ; 61
    .byte $7F    ; 62
    .byte $BF    ; 63

    .byte $DF    ; 64
    .byte $EF    ; 65
    .byte $F7    ; 66
    .byte $FB    ; 67
    .byte $FD    ; 68
    .byte $FE    ; 69
    .byte $7F    ; 70
    .byte $BF    ; 71

    .byte $DF    ; 72
    .byte $EF    ; 73
    .byte $F7    ; 74
    .byte $FB    ; 75
    .byte $FD    ; 76
    .byte $FE    ; 77
    .byte $7F    ; 78
    .byte $BF    ; 79

    .byte $DF    ; 80
    .byte $EF    ; 81
    .byte $F7    ; 82
    .byte $FB    ; 83
    .byte $FD    ; 84
    .byte $FE    ; 85
    .byte $7E    ; 86
    .byte $BE    ; 87

    .byte $DE    ; 88
    .byte $EE    ; 89
    .byte $F6    ; 90
    .byte $FA    ; 91
    .byte $FC    ; 92
    .byte $7F    ; 93
    .byte $BF    ; 94
    .byte $DF    ; 95

    .byte $EF    ; 96
    .byte $F7    ; 97
    .byte $FB    ; 98
    .byte $FD    ; 99
    .byte $FE    ; 100
    .byte $7F    ; 101
    .byte $BF    ; 102
    .byte $DF    ; 103

    .byte $EF    ; 104
    .byte $F7    ; 105
    .byte $FB    ; 106
    .byte $FD    ; 107
    .byte $FE    ; 108
    .byte $7F    ; 109
    .byte $BF    ; 110
    .byte $DF    ; 111

    .byte $EF    ; 112
    .byte $F7    ; 113
    .byte $FB    ; 114
    .byte $FD    ; 115
    .byte $FE    ; 116
    .byte $7F    ; 117
    .byte $BF    ; 118
    .byte $DF    ; 119

    .byte $EF    ; 120
    .byte $F7    ; 121
    .byte $FB    ; 122
    .byte $FD    ; 123
    .byte $FE    ; 124
    .byte DISABLE  ; 125  (.b_bit1)  Disable M1 to hide pixel
    .byte $7F    ; 126
    .byte $BF    ; 127

    .byte $DF    ; 128
    .byte $EF    ; 129
    .byte COL_SCREEN ; 130 (.a_bit2)  Color the ball to hide pixel. The ball is always enabled here.
    .byte $0A    ; 131
    .byte $0C    ; 132
    .byte $7F    ; 133
    .byte $BF    ; 134
    .byte $DF    ; 135

    .byte $EF    ; 136
    .byte $F7    ; 137
    .byte $FB    ; 138
    .byte $FD    ; 139
    .byte $FE    ; 140
    .byte DISABLE   ; 141  (.a_bit3)  Disable M1 to hide pixel
    .byte $7F    ; 142
    .byte $BF    ; 143

    .byte $DF    ; 144
    .byte $EF    ; 145
    .byte $F7    ; 146
    .byte $FB    ; 147
    .byte $FD    ; 148
    .byte $FE    ; 149
    .byte $7F    ; 150
    .byte $BF    ; 151

    .byte $DF    ; 152
    .byte $EF    ; 153
    .byte COL_SCREEN ; 154 (.b_bit2)  Color the ball to hide pixel. The ball is always enabled here.
    .byte $FB    ; 155
    .byte $FD    ; 156
    .byte $FE    ; 157
    .byte $7F    ; 158
    .byte $BF    ; 159

IndexTab:
    .byte .a_1 - StartKernelA     ; 0
    .byte .a_1 - StartKernelA     ; 1
    .byte .a_1 - StartKernelA     ; 2
    .byte .a_1 - StartKernelA     ; 3
    .byte .a_1 - StartKernelA     ; 4
    .byte .a_1 - StartKernelA     ; 5
    .byte .b_1 - StartKernelB     ; 6
    .byte .b_1 - StartKernelB     ; 7

    .byte .b_1 - StartKernelB     ; 8
    .byte .b_1 - StartKernelB     ; 9
    .byte .b_1 - StartKernelB     ; 10
    .byte .b_1 - StartKernelB     ; 11
    .byte .b_1 - StartKernelB     ; 12
    .byte .b_1 - StartKernelB     ; 13
    .byte .a_2 - StartKernelA     ; 14
    .byte .a_2 - StartKernelA     ; 15

    .byte .a_2 - StartKernelA     ; 16
    .byte .a_2 - StartKernelA     ; 17
    .byte .a_2 - StartKernelA     ; 18
    .byte .a_2 - StartKernelA     ; 19
    .byte .a_2 - StartKernelA     ; 20
    .byte .a_2 - StartKernelA     ; 21
    .byte .b_2 - StartKernelB     ; 22
    .byte .b_2 - StartKernelB     ; 23

    .byte .b_2 - StartKernelB     ; 24
    .byte .b_2 - StartKernelB     ; 25
    .byte .b_2 - StartKernelB     ; 26
    .byte .b_2 - StartKernelB     ; 27
    .byte .b_2 - StartKernelB     ; 28
    .byte .b_2 - StartKernelB     ; 29
    .byte .a_3 - StartKernelA     ; 30
    .byte .a_3 - StartKernelA     ; 31

    .byte .a_3 - StartKernelA     ; 32
    .byte .a_3 - StartKernelA     ; 33
    .byte .a_3 - StartKernelA     ; 34
    .byte .a_3 - StartKernelA     ; 35
    .byte .a_3 - StartKernelA     ; 36
    .byte .b_3 - StartKernelB     ; 37
    .byte .b_3 - StartKernelB     ; 38
    .byte .b_3 - StartKernelB     ; 39

    .byte .b_3 - StartKernelB     ; 40
    .byte .b_3 - StartKernelB     ; 41
    .byte .b_3 - StartKernelB     ; 42
    .byte .b_3 - StartKernelB     ; 43
    .byte .b_3 - StartKernelB     ; 44
    .byte .a_bit1 - StartKernelA  ; 45
    .byte .a_4 - StartKernelA     ; 46
    .byte .a_4 - StartKernelA     ; 47

    .byte .a_4 - StartKernelA     ; 48
    .byte .a_4 - StartKernelA     ; 49
    .byte .a_4 - StartKernelA     ; 50
    .byte .a_4 - StartKernelA     ; 51
    .byte .a_4 - StartKernelA     ; 52
    .byte .a_4 - StartKernelA     ; 53
    .byte .b_4 - StartKernelB     ; 54
    .byte .b_4 - StartKernelB     ; 55

    .byte .b_4 - StartKernelB     ; 56
    .byte .b_4 - StartKernelB     ; 57
    .byte .b_4 - StartKernelB     ; 58
    .byte .b_4 - StartKernelB     ; 59
    .byte .b_4 - StartKernelB     ; 60
    .byte .b_4 - StartKernelB     ; 61
    .byte .a_5 - StartKernelA     ; 62
    .byte .a_5 - StartKernelA     ; 63

    .byte .a_5 - StartKernelA     ; 64
    .byte .a_5 - StartKernelA     ; 65
    .byte .a_5 - StartKernelA     ; 66
    .byte .a_5 - StartKernelA     ; 67
    .byte .a_5 - StartKernelA     ; 68
    .byte .a_5 - StartKernelA     ; 69
    .byte .b_5 - StartKernelB     ; 70
    .byte .b_5 - StartKernelB     ; 71

    .byte .b_5 - StartKernelB     ; 72
    .byte .b_5 - StartKernelB     ; 73
    .byte .b_5 - StartKernelB     ; 74
    .byte .b_5 - StartKernelB     ; 75
    .byte .b_5 - StartKernelB     ; 76
    .byte .b_5 - StartKernelB     ; 77
    .byte .a_6 - StartKernelA     ; 78
    .byte .a_6 - StartKernelA     ; 79

    .byte .a_6 - StartKernelA     ; 80
    .byte .a_6 - StartKernelA     ; 81
    .byte .a_6 - StartKernelA     ; 82
    .byte .a_6 - StartKernelA     ; 83
    .byte .a_6 - StartKernelA     ; 84
    .byte .a_6 - StartKernelA     ; 85
    .byte .b_6 - StartKernelB     ; 86
    .byte .b_6 - StartKernelB     ; 87

    .byte .b_6 - StartKernelB     ; 88
    .byte .b_6 - StartKernelB     ; 89
    .byte .b_6 - StartKernelB     ; 90
    .byte .b_6 - StartKernelB     ; 91
    .byte .b_6 - StartKernelB     ; 92
    .byte .a_7 - StartKernelA     ; 93
    .byte .a_7 - StartKernelA     ; 94
    .byte .a_7 - StartKernelA     ; 95

    .byte .a_7 - StartKernelA     ; 96
    .byte .a_7 - StartKernelA     ; 97
    .byte .a_7 - StartKernelA     ; 98
    .byte .a_7 - StartKernelA     ; 99
    .byte .a_7 - StartKernelA     ; 100
    .byte .b_7 - StartKernelB     ; 101
    .byte .b_7 - StartKernelB     ; 102
    .byte .b_7 - StartKernelB     ; 103

    .byte .b_7 - StartKernelB     ; 104
    .byte .b_7 - StartKernelB     ; 105
    .byte .b_7 - StartKernelB     ; 106
    .byte .b_7 - StartKernelB     ; 107
    .byte .b_7 - StartKernelB     ; 108
    .byte .a_8 - StartKernelA     ; 109
    .byte .a_8 - StartKernelA     ; 110
    .byte .a_8 - StartKernelA     ; 111

    .byte .a_8 - StartKernelA     ; 112
    .byte .a_9 - StartKernelA     ; 113
    .byte .a_9 - StartKernelA     ; 114
    .byte .a_9 - StartKernelA     ; 115
    .byte .a_9 - StartKernelA     ; 116
    .byte .b_8 - StartKernelB     ; 117
    .byte .b_8 - StartKernelB     ; 118
    .byte .b_8 - StartKernelB     ; 119

    .byte .b_8 - StartKernelB     ; 120
    .byte .b_8 - StartKernelB     ; 121
    .byte .b_8 - StartKernelB     ; 122
    .byte .b_8 - StartKernelB     ; 123
    .byte .b_8 - StartKernelB     ; 124
    .byte .b_bit1 - StartKernelB  ; 125
    .byte .a_9 - StartKernelA     ; 126
    .byte .a_9 - StartKernelA     ; 127

    .byte .a_9 - StartKernelA     ; 128
    .byte .a_9 - StartKernelA     ; 129
    .byte .a_bit2 - StartKernelA  ; 130
    .byte .a_10 - StartKernelA    ; 131
    .byte .a_10 - StartKernelA    ; 132
    .byte .b_9 - StartKernelB     ; 133
    .byte .b_9 - StartKernelB     ; 134
    .byte .b_9 - StartKernelB     ; 135

    .byte .b_9 - StartKernelB     ; 136
    .byte .b_10 - StartKernelB    ; 137
    .byte .b_10 - StartKernelB    ; 138
    .byte .b_10 - StartKernelB    ; 139
    .byte .b_10 - StartKernelB    ; 140
    .byte .a_bit3 - StartKernelA  ; 141
    .byte .a_11 - StartKernelA    ; 142
    .byte .a_11 - StartKernelA    ; 143

    .byte .a_11 - StartKernelA    ; 144
    .byte .a_11 - StartKernelA    ; 145
    .byte .a_11 - StartKernelA    ; 146
    .byte .a_11 - StartKernelA    ; 147
    .byte .a_11 - StartKernelA    ; 148
    .byte .a_12 - StartKernelA    ; 149
    .byte .b_10 - StartKernelB    ; 150
    .byte .b_10 - StartKernelB    ; 151

    .byte .b_10 - StartKernelB    ; 152
    .byte .b_10 - StartKernelB    ; 153
    .byte .b_bit2 - StartKernelB  ; 154
    .byte .b_11 - StartKernelB    ; 155
    .byte .b_11 - StartKernelB    ; 156
    .byte .b_11 - StartKernelB    ; 157
    .byte .a_12 - StartKernelA    ; 158
    .byte .a_12 - StartKernelA    ; 159

EndKernelIndex:

      ALIGN 256
Zero:
    .byte $00 ; |        |
    .byte $3C ; |  XXXX  |
    .byte $66 ; | XX  XX |
    .byte $66 ; | XX  XX |
    .byte $66 ; | XX  XX |
    .byte $66 ; | XX  XX |
    .byte $66 ; | XX  XX |
    .byte $3C ; |  XXXX  |
One:
    .byte $00 ; |        |
    .byte $3C ; |  XXXX  |
    .byte $18 ; |   XX   |
    .byte $18 ; |   XX   |
    .byte $18 ; |   XX   |
    .byte $18 ; |   XX   |
    .byte $38 ; |  XXX   |
    .byte $18 ; |   XX   |
Two:
    .byte $00 ; |        |
    .byte $7E ; | XXXXXX |
    .byte $60 ; | XX     |
    .byte $60 ; | XX     |
    .byte $3C ; |  XXXX  |
    .byte $06 ; |     XX |
    .byte $46 ; | X   XX |
    .byte $3C ; |  XXXX  |
Three:
    .byte $00 ; |        |
    .byte $3C ; |  XXXX  |
    .byte $46 ; | X   XX |
    .byte $06 ; |     XX |
    .byte $0C ; |    XX  |
    .byte $06 ; |     XX |
    .byte $46 ; | X   XX |
    .byte $3C ; |  XXXX  |
Four:
    .byte $00 ; |        |
    .byte $0C ; |    XX  |
    .byte $0C ; |    XX  |
    .byte $0C ; |    XX  |
    .byte $7E ; | XXXXXX |
    .byte $4C ; | X  XX  |
    .byte $4C ; | X  XX  |
    .byte $4C ; | X  XX  |
Five:
    .byte $00 ; |        |
    .byte $7C ; | XXXXX  |
    .byte $06 ; |     XX |
    .byte $06 ; |     XX |
    .byte $7C ; | XXXXX  |
    .byte $60 ; | XX     |
    .byte $60 ; | XX     |
    .byte $7E ; | XXXXXX |
Six:
    .byte $00 ; |        |
    .byte $3C ; |  XXXX  |
    .byte $66 ; | XX  XX |
    .byte $66 ; | XX  XX |
    .byte $7C ; | XXXXX  |
    .byte $60 ; | XX     |
    .byte $62 ; | XX   X |
    .byte $3C ; |  XXXX  |
Seven:
    .byte $00 ; |        |
    .byte $18 ; |   XX   |
    .byte $18 ; |   XX   |
    .byte $18 ; |   XX   |
    .byte $0C ; |    XX  |
    .byte $06 ; |     XX |
    .byte $02 ; |      X |
    .byte $7E ; | XXXXXX |
Eight:
    .byte $00 ; |        |
    .byte $3C ; |  XXXX  |
    .byte $66 ; | XX  XX |
    .byte $66 ; | XX  XX |
    .byte $3C ; |  XXXX  |
    .byte $66 ; | XX  XX |
    .byte $66 ; | XX  XX |
    .byte $3C ; |  XXXX  |
Nine:
    .byte $00 ; |        |
    .byte $3C ; |  XXXX  |
    .byte $46 ; | X   XX |
    .byte $06 ; |     XX |
    .byte $3E ; |  XXXXX |
    .byte $66 ; | XX  XX |
    .byte $66 ; | XX  XX |
    .byte $3C ; |  XXXX  |
Blank_Digit:
    .byte $00 ; |        |
    .byte $00 ; |        |
    .byte $00 ; |        |
    .byte $00 ; |        |
    .byte $00 ; |        |
    .byte $00 ; |        |
    .byte $00 ; |        |
    .byte $00 ; |        |


        ORG $FFFC

    .word START
    .word START


ECHO_TEXT = 1


