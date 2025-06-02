; 36 character mock-up demo for 2 cycle loading with CDF or DPC+ (Interlaced Display)
; By Omegamatrix

; last update May 20, 2018

      processor 6502
    LIST OFF
      include vcs.h
      include macro.h
    LIST ON

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;      CONSTANTS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TOP_LINES            = 93
BOTTOM_LINES         = 100

TIME_VBLANK          = 46
TIME_OVERSCAN        = 25

BORDER_SHAPE         = $30

P0_POS_ODD_KERNEL    = 151
P1_POS_ODD_KERNEL    = 72-8

P0_POS_EVEN_KERNEL   = 3
P1_POS_EVEN_KERNEL   = 72-8

BALL_POS             = 12

COL_TEXT             = $0E
COL_SCREEN           = $00


;74 cycle HMxx
LEFT74_15            = $70
LEFT74_14            = $60
LEFT74_13            = $50
LEFT74_12            = $40
LEFT74_11            = $30
LEFT74_10            = $20
LEFT74_9             = $10
LEFT74_8             = $00
LEFT74_7             = $F0
LEFT74_6             = $E0
LEFT74_5             = $D0
LEFT74_4             = $C0
LEFT74_3             = $B0
LEFT74_2             = $A0
LEFT74_1             = $90
NO_MO_74             = $80

;HMxx
LEFT_7               = $70
LEFT_6               = $60
LEFT_5               = $50
LEFT_4               = $40
LEFT_3               = $30
LEFT_2               = $20
LEFT_1               = $10
NO_MOTION            = $00
RIGHT_1              = $F0
RIGHT_2              = $E0
RIGHT_3              = $D0
RIGHT_4              = $C0
RIGHT_5              = $B0
RIGHT_6              = $A0
RIGHT_7              = $90
RIGHT_8              = $80

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;      MACROS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;---------------------------------------
;  Macros to draw the display
;---------------------------------------

  MAC KERNEL_A
    sta    HMOVE                 ;3  @3
    tax                          ;2  @5
    txs                          ;2  @7
    lda    #{1}                  ;2  @9
    sta    GRP0                  ;3  @12
    lda    #{4}                  ;2  @14
    sta    GRP1                  ;3  @17
    lda    #{5}                  ;2  @19
    tay                          ;2  @21
    lda    #{2}                  ;2  @23
    sta    RESP0                 ;3  @26
    ldx    #LEFT74_8             ;2  @28
    sta    GRP0                  ;3  @31
    lda    #{3}                  ;2  @33
    sta    GRP0                  ;3  @36
    stx    HMP1                  ;3  @39
    lda    #{7}                  ;2  @41
    sta    GRP0                  ;3  @44
    lda    #{6}                  ;2  @46
    sty    GRP1                  ;3  @49
    sta    RESP0                 ;3  @52
    sta    GRP1                  ;3  @55
    sta    RESP0                 ;3  @58
    lda    #{8}                  ;2  @60
    sta.w  GRP0                  ;4  @64
    lda    #{9}                  ;2  @66
    sta    GRP0                  ;3  @69
    sta.w  HMOVE                 ;4  @73
    sta    RESP0                 ;3  @76
  ENDM

  MAC KERNEL_B
    SLEEP 3                      ;3  @3
    lda    #{1}                  ;2  @5
    sta    GRP0                  ;3  @8
    lda    #{5}                  ;2  @10
    sta    GRP1                  ;3  @13
    lda    #{2}                  ;2  @15
    tay                          ;2  @17
    lda    #{3}                  ;2  @19
    tax                          ;2  @21
    lda    #{10}                 ;2  @23
    sta    GRP0                  ;3  @26  early! still drawing the gfx_A...
    sta    RESP0                 ;3  @29
    sty    GRP0                  ;3  @32
    stx    GRP0                  ;3  @35
    lda    #{4}                  ;2  @37
    sta    GRP0                  ;3  @40
    tsx                          ;2  @42
    lda    #{6}                  ;2  @44
    sta    GRP1                  ;3  @47
    lda    #{7}                  ;2  @49
    sta    GRP1                  ;3  @52
    sta    RESP0                 ;3  @55
    stx    GRP0                  ;3  @58
    sta    RESP0                 ;3  @61
    lda    #{9}                  ;2  @63
    sta    GRP0                  ;3  @66
    ldx    #RIGHT_8              ;2  @68
    stx    HMP1                  ;3  @71
    lda    #{8}                  ;2  @73  for next line
    sta    RESP0                 ;3  @76
  ENDM


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
    sta    COLUPF
    lda    #COL_TEXT
    sta    COLUP0
    sta    COLUP1
    lda    #THREE_COPIES_CLOSE
    sta    NUSIZ0
    sta    NUSIZ1

    lda    #BORDER_SHAPE
    sta    PF0

    lda    #BALL_1_CLK | PF_PRIORITY | PF_REFLECT
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

    lda    #BALL_POS
    ldx    #4
    jsr    Positioning

    sta    WSYNC
;---------------------------------------
    sta    HMOVE

    sta    WSYNC
;---------------------------------------
    lda    #LEFT74_12
    sta    HMP0
    lda    #RIGHT_8
    sta    HMP1
    lda    #LEFT74_4    ; LEFT74_4 and RIGHT_4
    sta    HMBL

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

    jsr    DrawRow


    ldy    #BOTTOM_LINES
.loopBottom:
    sta    WSYNC
;---------------------------------------
    dey
    bne    .loopBottom

;------------------------------------------------------------------------------
;                                 OVERSCAN
;------------------------------------------------------------------------------

    lda    #2
    sta    VBLANK
    lda    #TIME_OVERSCAN
    sta    TIM64T

    inc    frameCounter



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


DrawRow: SUBROUTINE
    lda    frameCounter
    lsr
    lda    #ENABLE
    sta    ENABL
    bcc    .evenFrameDraw
    jmp    .oddFrameDraw

.evenFrameDraw:
    lda    #_ST_L1
    tax
    txs
    sta    WSYNC
;---------------------------------------
    KERNEL_B  _01_L1, _45_L1, _89_L1, _CD_L1, _EF_L1, _IJ_L1, _MN_L1, _ST_L3, _WX_L1, MORPH_01_45_L1
    KERNEL_A  _23_L2, _67_L2, _AB_L2, _GH_L2, _KL_L2, _OP_L2, _QR_L2, _UV_L2, _YZ_L2
    KERNEL_B  _01_L3, _45_L3, _89_L3, _CD_L3, _EF_L3, _IJ_L3, _MN_L3, _ST_L5, _WX_L3, MORPH_01_45_L3
    KERNEL_A  _23_L4, _67_L4, _AB_L4, _GH_L4, _KL_L4, _OP_L4, _QR_L4, _UV_L4, _YZ_L4
    KERNEL_B  _01_L5, _45_L5, _89_L5, _CD_L5, _EF_L5, _IJ_L5, _MN_L5,      0, _WX_L5, MORPH_01_45_L5

    jmp    .finishRow


.oddFrameDraw:
    lda    #_ST_L2
    sta    WSYNC
;---------------------------------------
    KERNEL_A  _23_L1, _67_L1, _AB_L1, _GH_L1, _KL_L1, _OP_L1, _QR_L1, _UV_L1, _YZ_L1
    KERNEL_B  _01_L2, _45_L2, _89_L2, _CD_L2, _EF_L2, _IJ_L2, _MN_L2, _ST_L4, _WX_L2, MORPH_01_45_L2
    KERNEL_A  _23_L3, _67_L3, _AB_L3, _GH_L3, _KL_L3, _OP_L3, _QR_L3, _UV_L3, _YZ_L3
    KERNEL_B  _01_L4, _45_L4, _89_L4, _CD_L4, _EF_L4, _IJ_L4, _MN_L4,      0, _WX_L4, MORPH_01_45_L4
    KERNEL_A  _23_L5, _67_L5, _AB_L5, _GH_L5, _KL_L5, _OP_L5, _QR_L5, _UV_L5, _YZ_L5

.finishRow:
    lda    #0                  ; clear all
    sta    GRP0
    sta    GRP1
    sta    ENABL
    ldx    #$FD                ; restore stack
    txs
    rts


;------------------------------------------------------------------------------
;                               GFX AND DATA
;------------------------------------------------------------------------------

P0_Tab:
    .byte P0_POS_ODD_KERNEL
    .byte P0_POS_EVEN_KERNEL

P1_Tab:
    .byte P1_POS_ODD_KERNEL
    .byte P1_POS_EVEN_KERNEL


_01_L1 = $72
_01_L2 = $56
_01_L3 = $52
_01_L4 = $52
_01_L5 = $77

_23_L1 = $77
_23_L2 = $11
_23_L3 = $73
_23_L4 = $41
_23_L5 = $77

_45_L1 = $AE
_45_L2 = $A8
_45_L3 = $EE
_45_L4 = $22
_45_L5 = $2E

_67_L1 = $77
_67_L2 = $41
_67_L3 = $71
_67_L4 = $52
_67_L5 = $72

_89_L1 = $EE
_89_L2 = $AA
_89_L3 = $EE
_89_L4 = $A2
_89_L5 = $E2

_AB_L1 = $26
_AB_L2 = $55
_AB_L3 = $76
_AB_L4 = $55
_AB_L5 = $56

_CD_L1 = $6C
_CD_L2 = $8A
_CD_L3 = $8A
_CD_L4 = $8A
_CD_L5 = $6C

_EF_L1 = $6E
_EF_L2 = $88
_EF_L3 = $CC
_EF_L4 = $88
_EF_L5 = $68

_GH_L1 = $6A
_GH_L2 = $8A
_GH_L3 = $AE
_GH_L4 = $AA
_GH_L5 = $6A

_IJ_L1 = $EE
_IJ_L2 = $44
_IJ_L3 = $44
_IJ_L4 = $44
_IJ_L5 = $EC

_KL_L1 = $A8
_KL_L2 = $A8
_KL_L3 = $C8
_KL_L4 = $A8
_KL_L5 = $AE

_MN_L1 = $AC
_MN_L2 = $EA
_MN_L3 = $AA
_MN_L4 = $AA
_MN_L5 = $AA

_OP_L1 = $4C
_OP_L2 = $AA
_OP_L3 = $AC
_OP_L4 = $A8
_OP_L5 = $48

_QR_L1 = $66
_QR_L2 = $55
_QR_L3 = $56
_QR_L4 = $65
_QR_L5 = $35

_ST_L1 = $6E
_ST_L2 = $84
_ST_L3 = $44
_ST_L4 = $24
_ST_L5 = $C4

_UV_L1 = $55
_UV_L2 = $55
_UV_L3 = $55
_UV_L4 = $55
_UV_L5 = $72

_WX_L1 = $AA
_WX_L2 = $AA
_WX_L3 = $A4
_WX_L4 = $EA
_WX_L5 = $AA

_YZ_L1 = $57
_YZ_L2 = $51
_YZ_L3 = $22
_YZ_L4 = $24
_YZ_L5 = $27

MORPH_01_45_L1 = (_01_L1 & $07) | (_45_L1 & $F8)
MORPH_01_45_L2 = (_01_L2 & $07) | (_45_L2 & $F8)
MORPH_01_45_L3 = (_01_L3 & $07) | (_45_L3 & $F8)
MORPH_01_45_L4 = (_01_L4 & $07) | (_45_L4 & $F8)
MORPH_01_45_L5 = (_01_L5 & $07) | (_45_L5 & $F8)


        ORG $FFFC

    .word START
    .word START

