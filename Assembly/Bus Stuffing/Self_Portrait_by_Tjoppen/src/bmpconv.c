#include <stdio.h>
#include <stdint.h>
#include "palette.h"

void quant_line(const uint32_t *palette, int min, int max, int w, uint32_t *line,
                uint8_t *quant_temp, uint8_t *quant_out, uint32_t *quant_rgb_out, int *Aout, int *Xout, int *Yout) {
    int A, X, Y, best = -1;

    /* find the three colors that best match the given line, then quantize it */
    for (A = min; A < max; A += 2)
        for (X = A + 2; X < max; X += 2)
            for (Y = A + 2; Y < max; Y += 2) {
                uint32_t pal[4] = {
                    palette[A],     /* STA */
                    palette[X],     /* STX */
                    palette[Y],     /* STY */
                    palette[A&X],   /* SAX */
                };
                int dist = 0, x, i;

                if (Y == X)
                    continue;   //pointless

                for (x = 0; x < w; x++) {
                    int r = line[x] & 0xFF;
                    int g = (line[x] >> 8) & 0xFF;
                    int b = (line[x] >> 16) & 0xFF;
                    int best2, bestdiff;

                    for (i = 0; i < 4; i++) {
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

int main(int argc, char **argv) {
    FILE *f, *bmp;
    uint8_t head[54];
    uint32_t lines[256][256];
    int w, h, x, y;
    uint8_t quants[256][256];
    uint32_t quant_rgb[256][256];
    int As[256], Xs[256], Ys[256];
    int pad;

    if (argc < 3) {
        fprintf(stderr, "Usage: %s foo.bmp foo-quant.bmp > foo.asm\n", argv[0]);
        return 1;
    }

    if (!(f = fopen(argv[1], "rb"))) {
        fprintf(stderr, "Failed to open %s\n", argv[1]);
        return 1;
    }

    if (!(bmp = fopen(argv[2], "wb"))) {
        fprintf(stderr, "Failed to open %s\n", argv[2]);
        return 1;
    }

    fread(head, sizeof(head), 1, f);
    fwrite(head, sizeof(head), 1, bmp);

    /* 255x255 max */
    w = head[18];
    h = head[22];

    pad = (4 - ((w*3) & 3)) & 3;

    printf("BMPW equ %i\nBMPH equ %i\n", w, h);

    /* NOTE: BMP is upside-down */
    for (y = h-1; y >= 0; y--) {
        for (x = 0; x < w; x++)
            lines[y][x] = getc(f) | (getc(f) << 8) | (getc(f) << 16);

        for (x = 0; x < pad; x++)
            getc(f);
    }

#pragma omp parallel for schedule(dynamic,1)
    for (y = 0; y < h; y++) {
        uint8_t temp[256];

        fprintf(stderr, "Quantizing line %i/%i\n", y, h);
        quant_line(pal_palette, 0x10, 0xE0, w, lines[y], temp, quants[y], quant_rgb[y], &As[y], &Xs[y], &Ys[y]);
    }

    printf("\tMAC AS\n");
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
        static const char* asmtab[4] = {
            "\tsta COLUBK\n",
            "\tstx COLUBK\n",
            "\tsty COLUBK\n",
            "\tsax COLUBK\n",
        };

        printf("Line%i\n", y);

        for (x = 0; x < w; x++)
            printf("%s", asmtab[quants[y][x]]);

        printf("\trts\n\n");
    }
    printf("\tENDM\n");

    printf(";%i bytes total\n", y * (3 + 2*w + 1));

    for (y = h-1; y >= 0; y--) {
        for (x = 0; x < w; x++) {
            putc(quant_rgb[y][x], bmp);
            putc(quant_rgb[y][x] >> 8, bmp);
            putc(quant_rgb[y][x] >> 16, bmp);
        }

        for (x = 0; x < pad; x++)
            putc(0, bmp);
    }

    return 0;
}
