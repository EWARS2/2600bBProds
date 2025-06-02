#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <math.h>
#include "palette.h"
#include "colTool.h"

#define NTSC
#ifdef NTSC
    #define PALETTE ntsc_palette
    #define MIN_COL 0x00
    #define MAX_COL 0x100
#else
    #define PALETTE pal_palette
    #define MIN_COL 0x10
    #define MAX_COL 0xe0
#endif

#define BMP_HEAD_SIZE   54

#define MAX_WIDTH       256
#define MAX_HEIGHT      256
#define NUM_COLORS      3

#define INT_FACT_PREV   0
#define INT_FACT_CUR    1


inline void splitRGBColor(uint32_t color, int *r, int *g, int *b)
{
    *r = color & 0xFF;
    *g = (color >> 8) & 0xFF;
    *b = (color >> 16) & 0xFF;
}

inline uint32_t mergeRGBColor(int r, int g, int b)
{
    return r + (g << 8) + (b << 16);
}

RGB uint2rgb(uint32_t irgb) {
    RGB rgb;
    
    splitRGBColor(irgb, &rgb.r, &rgb.g, &rgb.b);
    
    return rgb;
}


void interpolateSingleColors(int r0, int g0, int b0, int r1, int g1, int b1, int fact0, int fact1, int *mr, int *mg, int *mb) {
    *mr = (r0*fact0 + r1*fact1) / (fact0 + fact1);
    *mg = (g0*fact0 + g1*fact1) / (fact0 + fact1);
    *mb = (b0*fact0 + b1*fact1) / (fact0 + fact1);
}

uint32_t interpolateColors(uint32_t col0, uint32_t col1, int fact0, int fact1) {
    int r0, g0, b0, r1, g1, b1;
    int mr, mg, mb;

    splitRGBColor(col0, &r0, &g0, &b0);
    splitRGBColor(col1, &r1, &g1, &b1);

    interpolateSingleColors(r0, g0, b0, r1, g1, b1, fact0, fact1, &mr, &mg, &mb);

    return mergeRGBColor(mr, mg, mb);
}


// unused
void calcLineError(int width, int row, uint32_t *interpolatedLine, uint32_t *pal, uint32_t *prevQuantLine,
    uint8_t *quantTempPalIdx)
{
    int x, i, totalDiff = 0;
    int r, g, b;
    int mr, mg, mb;
    int bestPalIdx, bestPixelDiff;
    
    for (x = 0; x < width; x++) {
        // merged line pixel color
        splitRGBColor(interpolatedLine[x], &r, &g, &b);

        //splitRGBColor(line0[x], &r, &g, &b);

        // find best color for current pixel
        for (i = 0; i < NUM_COLORS; i++) {
            // interpolate pixel color from previous line with tested color
            if (row > 0) {
                uint32_t interpolatedColor = interpolateColors(prevQuantLine[x], pal[i], 1, 2);
                splitRGBColor(interpolatedColor, &mr, &mg, &mb);
            } else {
                splitRGBColor(pal[i], &mr, &mg, &mb);
            }

            //splitRGBColor(pal[i], &mr, &mg, &mb);
            int diff = (r - mr) * (r - mr) +
                       (g - mg) * (g - mg) +
                       (b - mb) * (b - mb);

            if (i == 0 || diff < bestPixelDiff) {
                bestPalIdx = i;
                bestPixelDiff = diff;
            }
        }
        totalDiff += bestPixelDiff;
        quantTempPalIdx[x] = bestPalIdx;
    }
}

int rErrBest[MAX_WIDTH], gErrBest[MAX_WIDTH], bErrBest[MAX_WIDTH];
RGB paletteRGB[0x100];

void initColors(const int minCol, int *color, int *pal, const int *palette) {
    int col = minCol;
    
    for (int c = 0; c < NUM_COLORS; c++) {
        color[c] = col;
        pal[c] = palette[col];
        col += 2;
    }
}

int nextColors(const int maxCol, int *color, int *pal, const int *palette) {
    int c = NUM_COLORS - 1, col;
    
    do {
        col = color[c] + 2;
        if (col < maxCol - (NUM_COLORS - 1 - c) * 2) {
            //printf("(");
            for (;c < NUM_COLORS; c++) {
                //printf("%i ", col);
                color[c] = col;
                pal[c] = palette[col];
                col += 2;
            }
            //printf(")");
            return 1;
        }
        if (c == 0)
            return 0;
        c--;
    } while (1);
}

void quantLineShiftingWindow(const uint32_t *palette, const int minCol, const int maxCol,
    const int width, const int row, const uint32_t *curLine, const uint32_t *prevLine, const uint32_t *prevQuantLine,
    uint8_t *quantPalIdx, uint32_t *quantPal, int *colOut)
{
    // 1. create new pixel colors by merging two lines (TODO: CIELab, DIN99)
    int x;
    uint32_t interpolatedLine[MAX_WIDTH];
    RGB interpolatedLineRGB[MAX_WIDTH];
    LAB interpolatedLineLab[MAX_WIDTH];
    RGB rgb;

    if (row == 0) {
        for (x = 0; x < width; x++) {
            rErrBest[x] = gErrBest[x] = bErrBest[x] = 0;
        }
    }
    int rErrLast[MAX_WIDTH], gErrLast[MAX_WIDTH], bErrLast[MAX_WIDTH];
    for (x = 0; x < width; x++) {
        // Merge RGB; TODO: use better merge algorithm
        interpolatedLine[x] = interpolateColors(prevLine[x], curLine[x], 1, 1);
        
        splitRGBColor(interpolatedLine[x], &rgb.r, &rgb.g, &rgb.r);
        interpolatedLineRGB[x] = rgb;
        //interpolatedLineLab[x] = rgb2lab(rgb);
        rErrLast[x] = rErrBest[x];
        gErrLast[x] = gErrBest[x];
        bErrLast[x] = bErrBest[x];
    }

    // 2. test all possible color combinations
    //int c0, c1, c2,
    int i, bestDiff = -1;
    uint32_t pal[NUM_COLORS];
    RGB palRGB[NUM_COLORS];
    LAB palLab[NUM_COLORS];
    int mr, mg, mb;
    int rErr[MAX_WIDTH], gErr[MAX_WIDTH], bErr[MAX_WIDTH];
    uint8_t quantTempPalIdx[MAX_WIDTH];
    
    //do {
        
    int colors[NUM_COLORS];
    //int colorsLab[NUM_COLORS];
    initColors(minCol, colors, pal, palette);
    //initColorsLab(minCol, colors, palLab, palette);

    /*for (c0 = minCol; c0 < maxCol; c0 += 2) {
        pal[0] = palette[c0];
        for (c1 = c0+2; c1 < maxCol; c1 += 2) {
            //if (c1 == c0) continue;
            pal[1] = palette[c1];
            for (c2 = c1+2; c2 < maxCol; c2 += 2) {
                //if (c2 == c0 || c2 == c1) continue;
                pal[2] = palette[c2];*/

            do {
                int totalDiff = 0;
                for (x = 0; x < width; x++) {
                    RGB rgb, irgb;
                    //int r, g, b;
                    int bestPalIdx, bestPixelDiff;
                    uint32_t interpolatedColor;

                    // merged line pixel color
                    rgb = interpolatedLineRGB[x];
                    // correct expected pixel color by previous error
                    rgb.r += rErrLast[x];
                    rgb.g += gErrLast[x];
                    rgb.b += bErrLast[x];

                    // find best color for current pixel
                    for (i = 0; i < NUM_COLORS; i++) {
                        // interpolate pixel color from previous line with tested color
                        if (row > 0) {
                            interpolatedColor = interpolateColors(prevQuantLine[x], pal[i], 1, 1);
                        } else {
                            interpolatedColor = pal[i];
                        }
                        splitRGBColor(interpolatedColor, &mr, &mg, &mb);
                        //splitRGBColor(pal[i], &mr, &mg, &mb);
                        int diff = (rgb.r - mr) * (rgb.r - mr) +
                                   (rgb.g - mg) * (rgb.g - mg) +
                                   (rgb.b - mb) * (rgb.b - mb);

                        if (i == 0 || diff < bestPixelDiff) {
                            bestPalIdx = i;  
                            bestPixelDiff = diff;
                            rErr[x] = rgb.r - mr;
                            gErr[x] = rgb.g - mg;
                            bErr[x] = rgb.b - mb;
                        }
                    }
                    totalDiff += bestPixelDiff;
                    quantTempPalIdx[x] = bestPalIdx;
                }
                if (bestDiff == -1 || totalDiff < bestDiff) {
                    bestDiff = totalDiff;
                    /*colOut[0] = c0;
                    colOut[1] = c1;
                    colOut[2] = c2;*/
                    colOut[0] = colors[0];
                    colOut[1] = colors[1];
                    colOut[2] = colors[2];
                    for (x = 0; x < width; x++) {
                        quantPalIdx[x] = quantTempPalIdx[x];
                        quantPal[x] = pal[quantTempPalIdx[x]];
                        // *0 = error compensation is disabled (doesn't work well)
                        rErrBest[x] = rErr[x]*0;
                        gErrBest[x] = gErr[x]*0;
                        bErrBest[x] = bErr[x]*0;
                    }
                }
            } while (nextColors(maxCol, colors, pal, palette));
/*        }
    }*/
    
        /*int col[NUM_COLORS];
        int c = NUM_COLORS - 1;
        do {
            col[c] += 2;
            if (col[c] < maxCol)
                break;
            if (c == 0)
                break;
            col[c] = col[--c];
        } while (1);
    } while (1);*/

}

void correctRGB(RGB *rgb, RGB err) {
    rgb->r += err.r;
    if (rgb->r > 255) rgb->r = 255;
    if (rgb->r < 0) rgb->r = 0;
    rgb->g += err.g;
    if (rgb->g > 255) rgb->g = 255;
    if (rgb->g < 0) rgb->g = 0;
    rgb->b += err.b;
    if (rgb->b > 255) rgb->b = 255;
    if (rgb->b < 0) rgb->b = 0;
}

RGB interpolateColorsRGB(const RGB col0, const RGB col1, int fact0, int fact1) {
    RGB rgb;

    rgb.r = (col0.r*fact0 + col1.r*fact1) / (fact0 + fact1);
    rgb.g = (col0.g*fact0 + col1.g*fact1) / (fact0 + fact1);
    rgb.b = (col0.b*fact0 + col1.b*fact1) / (fact0 + fact1);

    return rgb;
}

void initColorsRGB(const int minCol, int *color, RGB *palRGB, const RGB *paletteRGB) {
    int col = minCol;

    for (int c = 0; c < NUM_COLORS; c++) {
        color[c] = col;
        palRGB[c] = paletteRGB[col];
        col += 2;
    }
}

int nextColorsRGB(const int maxCol, int *color, RGB *palRGB, const RGB *paletteRGB) {
    int c = NUM_COLORS - 1, col;

    do {
        col = color[c] + 2;
        if (col < maxCol - (NUM_COLORS - 1 - c) * 2) {
            //printf("(");
            for (;c < NUM_COLORS; c++) {
                //printf("%i ", col);
                color[c] = col;
                palRGB[c] = paletteRGB[col];
                col += 2;
            }
            //printf(")");
            return 1;
        }
        if (c == 0)
            return 0;
        c--;
    } while (1);
}

void quantLineShiftingWindowRGB(const RGB *paletteRGB, const int minCol, const int maxCol,
    const int width, const int row, const uint32_t *curLine, const uint32_t *prevLine, const RGB *prevQuantLine,
    uint8_t *quantPalIdx, RGB *quantPal, int *colOut)
{
    // 1. create new pixel colors by merging two lines (TODO: CIELab, DIN99)
    int x;
    static RGB rgbErrBest[MAX_WIDTH];
    RGB interpolatedLineRGB[MAX_WIDTH];
    RGB rgb;

    if (row == 0) {
        for (x = 0; x < width; x++) {
            rgbErrBest[x].r = rgbErrBest[x].g = rgbErrBest[x].b = 0;
        }
    }
    RGB rgbErrLast[MAX_WIDTH];
    for (x = 0; x < width; x++) {
        // Merge RGB; TODO: use better merge algorithm
        uint32_t interpolatedColor = interpolateColors(prevLine[x], curLine[x], 1, 1);

        splitRGBColor(interpolatedColor, &rgb.r, &rgb.g, &rgb.b);
        interpolatedLineRGB[x] = rgb;
        rgbErrLast[x] = rgbErrBest[x];
    }

    // 2. test all possible color combinations
    int i, bestDiff = -1;
    RGB rgbErr[MAX_WIDTH];
    uint8_t quantTempPalIdx[MAX_WIDTH];
    int colors[NUM_COLORS];
    RGB palRGB[NUM_COLORS];
    initColorsRGB(minCol, colors, palRGB, paletteRGB);

    do {
        int totalDiff = 0;
        for (x = 0; x < width; x++) {
            RGB rgb, irgb;
            int bestPalIdx, bestPixelDiff;

            // merged line pixel color
            rgb = interpolatedLineRGB[x];
            // correct expected pixel color by previous error
            correctRGB(&rgb, rgbErrLast[x]);

            // find best color for current pixel
            for (i = 0; i < NUM_COLORS; i++) {
                // interpolate pixel color from previous line with tested color
                if (row > 0) {
                    irgb = mixRGB(prevQuantLine[x], palRGB[i]);
                } else {
                    irgb = palRGB[i];
                }
                int diff = (rgb.r - irgb.r) * (rgb.r - irgb.r) +
                           (rgb.g - irgb.g) * (rgb.g - irgb.g) +
                           (rgb.b - irgb.b) * (rgb.b - irgb.b);

                if (i == 0 || diff < bestPixelDiff) {
                    bestPalIdx = i;
                    bestPixelDiff = diff;
                    rgbErr[x].r = rgb.r - irgb.r;
                    rgbErr[x].g = rgb.g - irgb.g;
                    rgbErr[x].b = rgb.b - irgb.b;
                }
            }
            totalDiff += bestPixelDiff;
            quantTempPalIdx[x] = bestPalIdx;
        }
        if (bestDiff == -1 || totalDiff < bestDiff) {
            bestDiff = totalDiff;
            for (i = 0; i < NUM_COLORS; i++) {
                colOut[i] = colors[i];
            }
            for (x = 0; x < width; x++) {
                quantPalIdx[x] = quantTempPalIdx[x];
                quantPal[x] = palRGB[quantTempPalIdx[x]];
                // *0 = error compensation is disabled (doesn't work well)
                //rgbErrBest[x] = rgbErr[x];
                rgbErrBest[x].r = rgbErr[x].r/1;
                rgbErrBest[x].g = rgbErr[x].g/1;
                rgbErrBest[x].b = rgbErr[x].b/1;
            }
        }
    } while (nextColorsRGB(maxCol, colors, palRGB, paletteRGB));
}

void correctLAB(LAB *lab, LAB err) {
    lab->l += err.l;
    if (lab->l > 255) lab->l = 255;
    if (lab->l < 0) lab->l = 0;
    lab->a += err.a;
    if (lab->a > 255) lab->a = 255;
    if (lab->a < 0) lab->a = 0;
    lab->b += err.b;
    if (lab->b > 255) lab->b = 255;
    if (lab->b < 0) lab->b = 0;
}

void initColorsLCH(const int minCol, int *color, LCH *palLCH, const LCH *paletteLCH) {
    int col = minCol;

    for (int c = 0; c < NUM_COLORS; c++) {
        color[c] = col;
        palLCH[c] = paletteLCH[col];
        col += 2;
    }
}

int nextColorsLCH(const int maxCol, int *color, LCH *palLCH, const LCH *paletteLCH) {
    int c = NUM_COLORS - 1, col;

    do {
        col = color[c] + 2;
        if (col < maxCol - (NUM_COLORS - 1 - c) * 2) {
        //if (color[c] < maxCol) {
            //printf("(");
            for (;c < NUM_COLORS; c++) {
                //printf("%i ", col);
                color[c] = col;
                palLCH[c] = paletteLCH[col];
                col += 2;
            }
            //printf(")");
            return 1;
        }
        if (c == 0)
            return 0;
        c--;
    } while (1);
}

void quantLineShiftingWindowLCH(const LCH *paletteLCH, const int minCol, const int maxCol,
    const int width, const int row, const uint32_t *curLine, const uint32_t *prevLine, const LCH *prevQuantLine,
    uint8_t *quantPalIdx, LCH *quantPal, int *colOut)
{
    // 1. create new pixel colors by merging two lines (TODO: CIELab, DIN99)
    int x;
    static LAB labErrBest[MAX_WIDTH];
    LAB labErrLast[MAX_WIDTH];
    LCH interpolatedLineLCH[MAX_WIDTH];
    LAB interpolatedLineLAB[MAX_WIDTH];
    LAB lab;

    if (row == 0) {
        for (x = 0; x < width; x++) {
            labErrBest[x].l = labErrBest[x].a = labErrBest[x].b = 0;
        }
    }
    for (x = 0; x < width; x++) {
        // Merge LAB; TODO: use better merge algorithm
        LCH lch0 = rgb2lch(uint2rgb(prevLine[x]));
        LCH lch1 = rgb2lch(uint2rgb(curLine[x]));
        LCH lch = mixLCH(lch0, lch1);

        interpolatedLineLCH[x] = lch;
        interpolatedLineLAB[x] = lch2lab(lch);
        //printf("%3x: %f, %f, %f\n", x, lch.l, lch.c, lch.h);
        labErrLast[x] = labErrBest[x];
    }

    // 2. test all possible color combinations
    int i, bestDiff = -1;
    LAB labErr[MAX_WIDTH];
    uint8_t quantTempPalIdx[MAX_WIDTH];
    int colors[NUM_COLORS];
    LCH palLCH[NUM_COLORS];

    initColorsLCH(minCol, colors, palLCH, paletteLCH);
    do {
        int totalDiff = 0;
        for (x = 0; x < width; x++) {
            LCH lch, ilch;
            LAB ilab;
            int bestPalIdx;
            float bestPixelDiff;

            // merged line pixel color
            lab = interpolatedLineLAB[x];
            // correct expected pixel color by previous error
            //correctLAB(&lab, labErrLast[x]);

            // find best color for current pixel
            for (i = 0; i < NUM_COLORS; i++) {
                // interpolate pixel color from previous line with tested color
                if (row > 0) {
                    ilch = mixLCH(prevQuantLine[x], palLCH[i]);
                } else {
                    ilch = palLCH[i];
                }
                ilab = lch2lab(ilch);
                float diff = deltaE(lab, ilab);
                //printf("%3i: %f\n", x, diff);

                if (i == 0 || diff < bestPixelDiff) {
                    bestPalIdx = i;
                    bestPixelDiff = diff;
                    labErr[x].l = lab.l - ilab.l;
                    labErr[x].a = lab.a - ilab.a;
                    labErr[x].b = lab.b - ilab.b;
                }
            }
            totalDiff += bestPixelDiff * bestPixelDiff;
            //printf("%3i: %f\n", x, bestPixelDiff);
            quantTempPalIdx[x] = bestPalIdx;
        }
        if (bestDiff == -1 || totalDiff < bestDiff) {
            bestDiff = totalDiff;
            for (i = 0; i < NUM_COLORS; i++) {
                colOut[i] = colors[i];
            }
            LCH lch;
            //printf("\n");
            for (x = 0; x < width; x++) {
                quantPalIdx[x] = quantTempPalIdx[x];
                lch = palLCH[quantTempPalIdx[x]];
                quantPal[x] = lch;
                //printf("%3i: %f, %f, %f\n", x, lch.l, lch.c, lch.h);
                // *0 = error compensation is disabled (doesn't work well)
                //labErrBest[x] = labErr[x];
                labErrBest[x].l = labErr[x].l/2;
                labErrBest[x].a = labErr[x].a/2;
                labErrBest[x].b = labErr[x].b/2;
            }
        }
    } while (nextColorsLCH(maxCol, colors, palLCH, paletteLCH));
}

// old code
void quant_line(const uint32_t *palette, int min, int max, int w, uint32_t *line,
                uint8_t *quant_temp, uint8_t *quant_out, uint32_t *quant_rgb_out, int *Aout, int *Xout, int *Yout) {
    int A, X, Y, best = -1;

    /* find the three colors that best match the given line, then quantize it */
    for (A = min; A < max; A += 2)
        for (X = A + 2; X < max; X += 2)
            for (Y = A + 2; Y < max; Y += 2) {
                uint32_t pal[NUM_COLORS] = {
                    palette[A],     /* STA */
                    palette[X],     /* STX */
                    palette[Y],     /* STY */
//                    palette[A&X],   /* SAX */
                };
                int dist = 0, x, i;

                if (Y == X)
                    continue;   //pointless

                for (x = 0; x < w; x++) {
                    int r = line[x] & 0xFF;
                    int g = (line[x] >> 8) & 0xFF;
                    int b = (line[x] >> 16) & 0xFF;
                    int best2, bestdiff;

                    for (i = 0; i < NUM_COLORS; i++) {
                        int pr = pal[i] & 0xFF;
                        int pg = (pal[i] >> 8) & 0xFF;
                        int pb = (pal[i] >> 16) & 0xFF;
                        int diff = (r-pr)*(r-pr) +
                                   (g-pg)*(g-pg) +
                                   (b-pb)*(b-pb);

                        if (i == 0 || diff < bestdiff) {
                            best2 = i;
                            bestdiff = diff;
                        }
                    }

                    dist += bestdiff;
                    quant_temp[x] = best2;
                }

                if (best == -1 || dist < best) {
                    best = dist;
                    *Aout = A;
                    *Xout = X;
                    *Yout = Y;

                    for (x = 0; x < w; x++) {
                        quant_out[x] = quant_temp[x];
                        quant_rgb_out[x] = pal[quant_temp[x]];
                    }
                }
            }
}

int loadBMP(char *name, uint8_t *head, uint32_t lines[MAX_HEIGHT][MAX_WIDTH]) {
    FILE *f;
    int width, height, x, y;
    int pad;
    
    if (!(f = fopen(name, "rb"))) {
        fprintf(stderr, "Failed to open %s\n", name);
        return 1;
    }

    fread(head, sizeof(head), 1, f);

    /* 255x255 max */
    width = head[18];
    height = head[22];

    pad = (4 - ((width*3) & 3)) & 3;

    printf("BMPW equ %i\nBMPH equ %i\n", width, height);

    /* NOTE: BMP is upside-down */
    for (y = height-1; y >= 0; y--) {
        for (x = 0; x < width; x++)
            lines[y][x] = getc(f) | (getc(f) << 8) | (getc(f) << 16);

        for (x = 0; x < pad; x++)
            getc(f);
    }
    fclose(f);
    return 0;
}

int writeBMP(char *name, uint8_t *head, LCH quantLCH[MAX_HEIGHT][MAX_WIDTH]) {
    FILE *bmp;
    int pad, x, y;

    if (!(bmp = fopen(name, "wb"))) {
        fprintf(stderr, "Failed to open %s\n", name);
        return 1;
    }
    fwrite(head, BMP_HEAD_SIZE, 1, bmp);

    int width = head[18];
    int height = head[22];
    pad = (4 - ((width*3) & 3)) & 3;
    
    for (y = height-1; y >= 0; y--) {
        for (x = 0; x < width; x++) {
            /*int r, g, b;
            splitRGBColor(quantPal[y][x], &r, &g, &b);
            putc(r, bmp);
            putc(g, bmp);
            putc(b, bmp);*/
            /*putc(quantPal[y][x].r, bmp);
            putc(quantPal[y][x].g, bmp);
            putc(quantPal[y][x].b, bmp);*/

            putc(lch2rgb(quantLCH[y][x]).r, bmp);
            putc(lch2rgb(quantLCH[y][x]).g, bmp);
            putc(lch2rgb(quantLCH[y][x]).b, bmp);

        }
        for (x = 0; x < pad; x++)
            putc(0, bmp);
    }
    fclose(bmp);
    return 0;
}

int main(int argc, char **argv) {
    FILE *f;
    uint8_t head[BMP_HEAD_SIZE];
    uint32_t lines[MAX_HEIGHT][MAX_WIDTH];
    int width, height, x, y;
    LAB paletteLAB[0x100];
    LCH paletteLCH[0x100];
    uint8_t quants[MAX_HEIGHT][MAX_WIDTH];
    uint32_t quant_rgb[MAX_HEIGHT][MAX_WIDTH];
    RGB quantRGB[MAX_HEIGHT][MAX_WIDTH];
    LCH quantLCH[MAX_HEIGHT][MAX_WIDTH];
    int As[MAX_HEIGHT], Xs[MAX_HEIGHT], Ys[MAX_HEIGHT];
    int pad;

    if (argc < 3) {
        fprintf(stderr, "Usage: %s foo.bmp foo-quant.bmp > foo.asm\n", argv[0]);
        return 1;
    }
    
    loadBMP(argv[1], head, lines);

    if (!(f = fopen(argv[1], "rb"))) {
        fprintf(stderr, "Failed to open %s\n", argv[1]);
        return 1;
    }

    fread(head, sizeof(head), 1, f);

    /* 255x255 max */
    width = head[18];
    height = head[22];

    pad = (4 - ((width*3) & 3)) & 3;

    printf("BMPW equ %i\nBMPH equ %i\n", width, height);

    /* NOTE: BMP is upside-down */
    for (y = height-1; y >= 0; y--) {
        for (x = 0; x < width; x++)
            lines[y][x] = getc(f) | (getc(f) << 8) | (getc(f) << 16);

        for (x = 0; x < pad; x++)
            getc(f);
    }

    for (x = 0; x < 0x100; x +=2) {
        RGB rgb;
        splitRGBColor(PALETTE[x], &rgb.r, &rgb.g, &rgb.b);
        //printf("%3i: %3i %3i %3i\n", x, rgb.r, rgb.g, rgb.b);
        //paletteRGB[x] = rgb;
        //paletteLAB[x] = rgb2lab(rgb);
        paletteLCH[x] = rgb2lch(rgb);
        //printf("%3x: %i, %i, %i\n", x, rgb.r, rgb.g, rgb.b);
        //printf("%3x: %f, %f, %f\n", x, paletteLAB[x].l, paletteLAB[x].a, paletteLAB[x].b);
        printf("%3x: %f, %f, %f\n", x, paletteLCH[x].l, paletteLCH[x].c, paletteLCH[x].h);
        /*LAB lab = lch2lab(paletteLCH[x]);
        printf("lab: %f, %f, %f\n", lab.l, lab.a, lab.b);
        XYZ xyz = lab2xyz(lab);
        printf("xyz: %f, %f, %f\n", xyz.x, xyz.y, xyz.z);
        rgb = lch2rgb(paletteLCH[x]);
        printf("rgb: %i, %i, %i\n", rgb.r, rgb.g, rgb.b);*/
    }
    
    LCH lch0 = {10, 50, 350/180.0*PI};
    LCH lch1 = {40, 60, 210/180.0*PI};
    LCH lch = mixLCH(lch0, lch1);
    printf("lch: %f, %f, %f\n", lch.l, lch.c, lch.h*180.0/PI);
    /*RGB rgb = {50, 100, 200};
    printf("\n");
    printf("rgb: %i, %i, %i\n", rgb.r, rgb.g, rgb.b);
    XYZ xyz = rgb2xyz(rgb);
    printf("xyz: %f, %f, %f\n", xyz.x, xyz.y, xyz.z);
    LAB lab = xyz2lab(xyz);
    printf("lab: %f, %f, %f\n", lab.l, lab.a, lab.b);
    xyz = lab2xyz(lab);
    printf("xyz: %f, %f, %f\n", xyz.x, xyz.y, xyz.z);
    rgb = xyz2rgb(xyz);
    printf("rgb: %i, %i, %i\n", rgb.r, rgb.g, rgb.b);
    lab = xyz2lab(xyz);
    printf("lab: %f, %f, %f\n", lab.l, lab.a, lab.b);
    xyz = lab2xyz(lab);
    printf("xyz: %f, %f, %f\n", xyz.x, xyz.y, xyz.z);
    rgb = xyz2rgb(xyz);
    printf("rgb: %i, %i, %i\n", rgb.r, rgb.g, rgb.b);*/
    

#pragma omp parallel for schedule(dynamic,1)
    /*for (y = 0; y < height; y++) {
        uint8_t temp[256];

        fprintf(stderr, "Quantizing line %i/%i\n", y, height);
        quant_line(pal_palette, 0x10, 0xE0, width, lines[y], temp, quants[y], quant_rgb[y], &As[y], &Xs[y], &Ys[y]);
    }*/

    int colors[MAX_HEIGHT][NUM_COLORS];

    for (y = 0; y < height; y++) {
        fprintf(stderr, "Quantizing line %i/%i\n", y, height);
        /*quantLineShiftingWindow(PALETTE, MIN_COL, MAX_COL,
            width, y, lines[y], y > 0 ? lines[y-1] : lines[y], y > 0 ? quant_rgb[y-1] : NULL,
            quants[y], quant_rgb[y], colors[y]);*/
        /*quantLineShiftingWindowRGB(paletteRGB, MIN_COL, MAX_COL,
            width, y, lines[y], y > 0 ? lines[y-1] : lines[y], y > 0 ? quantRGB[y-1] : NULL,
            quants[y], quantRGB[y], colors[y]);*/
        quantLineShiftingWindowLCH(paletteLCH, MIN_COL, MAX_COL,
            width, y, lines[y], y > 0 ? lines[y-1] : lines[y], y > 0 ? quantLCH[y-1] : NULL,
            quants[y], quantLCH[y], colors[y]);
    }

    /*printf("\tMAC AS\n");
    for (y = h-1; y >= 0; y--)
        printf("\t.byte $%02x\n", As[y]);
    printf("\tENDM\n");

    printf("\tMAC XS\n");
    for (y = h-1; y >= 0; y--)
        printf("\t.byte $%02x\n", Xs[y]);
    printf("\tENDM\n");

    printf("\tMAC YS\n");
    for (y = h-1; y >= 0; y--)
        printf("\t.byte $%02x\n", Ys[y]);
    printf("\tENDM\n");

    printf("\tMAC LINES\n");
    for (y = 0; y < h; y++) {
        static const char* asmtab[NUM_COLORS] = {
            "\tsta COLUBK\n",
            "\tstx COLUBK\n",
            "\tsty COLUBK\n",
//            "\tsax COLUBK\n",
        };

        printf("Line%i\n", y);

        for (x = 0; x < w; x++)
            printf("%s", asmtab[quants[y][x]]);

        printf("\trts\n\n");
    }
    printf("\tENDM\n");

    printf(";%i bytes total\n", y * (3 + 2*w + 1));*/

    //writeBMP(argv[2], head, quant_rgb);
    //writeBMP(argv[2], head, quantRGB);
    writeBMP(argv[2], head, quantLCH);

    return 0;
}
