// color conversions methods

#define PI 3.14159265359

struct rgb {
    int r, g, b;
};
typedef struct rgb RGB;

struct xyz {
    float x, y, z;
};
typedef struct xyz XYZ;

struct lab {
    float l, a, b;
};
typedef struct lab LAB;

struct lch {
    float l, c, h;
};
typedef struct lch LCH;


// http://www.easyrgb.com/index.php?X=MATH&H=02#text2
XYZ rgb2xyz(RGB rgb) {
    float var_R = (rgb.r / 255.0);        //R from 0 to 255
    float var_G = (rgb.g / 255.0);        //G from 0 to 255
    float var_B = (rgb.b / 255.0);        //B from 0 to 255

    //printf("%i, %i, %i\n", rgb.r, rgb.g, rgb.b);
    //printf("-> %f, %f, %f\n", var_R, var_G, var_B);
    if (var_R > 0.04045)
        var_R = pow((var_R + 0.055) / 1.055, 2.4);
    else
        var_R = var_R / 12.92;
    if (var_G > 0.04045)
        var_G = pow((var_G + 0.055) / 1.055, 2.4);
    else
        var_G = var_G / 12.92;
    if (var_B > 0.04045)
        var_B = pow((var_B + 0.055) / 1.055, 2.4);
    else
        var_B = var_B / 12.92;

    var_R = var_R * 100;
    var_G = var_G * 100;
    var_B = var_B * 100;

    //Observer. = 2°, Illuminant = D65
    XYZ xyz = {
        var_R * 0.4124 + var_G * 0.3576 + var_B * 0.1805,
        var_R * 0.2126 + var_G * 0.7152 + var_B * 0.0722,
        var_R * 0.0193 + var_G * 0.1192 + var_B * 0.9505
    };
    //printf("xyz: %f, %f, %f\n", xyz.x, xyz.y, xyz.z);
    return xyz;
}

RGB xyz2rgb(XYZ xyz) {
    float var_X = xyz.x / 100.0;        //X from 0 to  95.047      (Observer = 2°, Illuminant = D65)
    float var_Y = xyz.y / 100.0;        //Y from 0 to 100.000
    float var_Z = xyz.z / 100.0;        //Z from 0 to 108.883

    float var_R = var_X *  3.2406 + var_Y * -1.5372 + var_Z * -0.4986;
    float var_G = var_X * -0.9689 + var_Y *  1.8758 + var_Z *  0.0415;
    float var_B = var_X *  0.0557 + var_Y * -0.2040 + var_Z *  1.0570;

    if (var_R > 0.0031308)
        var_R = 1.055 * pow(var_R, 1.0 / 2.4) - 0.055;
    else
        var_R = 12.92 * var_R;
    if (var_G > 0.0031308)
        var_G = 1.055 * pow(var_G, 1.0 / 2.4) - 0.055;
    else
        var_G = 12.92 * var_G;
    if (var_B > 0.0031308)
        var_B = 1.055 * pow(var_B, 1.0 / 2.4) - 0.055;
    else
        var_B = 12.92 * var_B;

    RGB rgb = {
        (int)round(var_R * 255.0),
        (int)round(var_G * 255.0),
        (int)round(var_B * 255.0)
    };
    return rgb;
}

// Observer = 2°, Illuminant = D65
#define REF_X 95.047
#define REF_Y 100.0
#define REF_Z 108.883

// http://www.easyrgb.com/index.php?X=MATH&H=07#text7
inline LAB xyz2lab(XYZ xyz) {
    float var_X = xyz.x / REF_X;
    float var_Y = xyz.y / REF_Y;
    float var_Z = xyz.z / REF_Z;

    if (var_X > 0.008856)
        var_X = pow(var_X, 1/3.0);
    else
        var_X = (7.787 * var_X) + (16 / 116.0);
    if (var_Y > 0.008856)
        var_Y = pow(var_Y, 1/3.0);
    else
        var_Y = (7.787 * var_Y) + (16 / 116.0);
    if (var_Z > 0.008856)
        var_Z = pow(var_Z, 1/3.0);
    else
        var_Z = (7.787 * var_Z) + (16 / 116.0);

    LAB lab = {
        (116.0 * var_Y) - 16,
        500.0 * (var_X - var_Y),
        200.0 * (var_Y - var_Z)
    };
    //printf("lab: %f, %f, %f\n", lab.l, lab.a, lab.b);
    return lab;
}

inline XYZ lab2xyz(LAB lab) {
    float var_Y = (lab.l + 16) / 116.0;
    float var_X = lab.a / 500.0 + var_Y;
    float var_Z = var_Y - lab.b / 200.0;

    if (pow(var_X, 3) > 0.008856)
        var_X = pow(var_X, 3.0);
    else
        var_X = (var_X - 16 / 116.0) / 7.787;
    if (pow(var_Y, 3) > 0.008856)
        var_Y = pow(var_Y, 3.0);
    else
        var_Y = (var_Y - 16 / 116.0) / 7.787;
    if (pow(var_Z, 3) > 0.008856)
        var_Z = pow(var_Z, 3.0);
    else
        var_Z = (var_Z - 16 / 116.0) / 7.787;

    XYZ xyz = {
        REF_X * var_X,
        REF_Y * var_Y,
        REF_Z * var_Z
    };
    return xyz;
}

inline LCH lab2lch(LAB lab) {
    LCH lch;

    lch.l = lab.l;
    float h = atan2(lab.b, lab.a);
    while (h < 0) h += 2*PI;
    while (h >= 2*PI) h -= 2*PI;
    lch.h = h;
    lch.c = sqrt(lab.a * lab.a + lab.b * lab.b);
    
    return lch;
}

inline LAB lch2lab(LCH lch) {
    LAB lab;

    lab.l = lch.l;
    lab.a = lch.c * cos(lch.h);
    lab.b = lch.c * sin(lch.h);

    return lab;
}

inline LAB rgb2lab(RGB rgb) {
    return xyz2lab(rgb2xyz(rgb));
}

inline RGB lab2rgb(LAB lab) {
    return xyz2rgb(lab2xyz(lab));
}

inline LCH rgb2lch(RGB rgb) {
    return lab2lch(xyz2lab(rgb2xyz(rgb)));
}

inline RGB lch2rgb(LCH lch) {
    return xyz2rgb(lab2xyz(lch2lab(lch)));
}


inline RGB mixRGB(const RGB rgb0, const RGB rgb1) {
    RGB rgb;

    rgb.r = (rgb0.r + rgb1.r) / 2;
    rgb.g = (rgb0.g + rgb1.g) / 2;
    rgb.b = (rgb0.b + rgb1.b) / 2;

    return rgb;
}

/*LAB mixLAB(const LAB lab0, const LAB lab1) {
    LAB lab;

    lab.l = (lab0.l + lab1.l) / 2;
    lab.a = (lab0.a + lab1.a) / 2;
    lab.b = (lab0.b + lab1.b) / 2;

    return lab;
}*/

inline LCH mixLCH(const LCH lch0, const LCH lch1) {
    LCH lch;
    float h;

    lch.l = (lch0.l + lch1.l) / 2.0;
    lch.c = (lch0.c + lch1.c) / 2.0;
    
    if (lch0.h > lch1.h) {
        if (lch0.h - lch1.h > PI) {
            h = (lch1.h + lch0.h + 2*PI) / 2.0;
            if (h >= 2*PI) h -= 2*PI;
        } else
            h = (lch0.h + lch1.h) / 2.0;
    } else {
        if (lch1.h - lch0.h > PI) {
            h = (lch0.h + lch1.h + 2*PI) / 2.0;
            if (h >= 2*PI) h -= 2*PI;
        } else
            h = (lch1.h + lch0.h) / 2.0;
    }
    lch.h = h;

    return lch;
}


// calculate color difference for CIE76
// http://de.wikipedia.org/wiki/Delta_E
inline float deltaE(LAB lab0, LAB lab1) {
    return sqrt(
        (lab0.l - lab1.l) * (lab0.l - lab1.l) +
        (lab0.a - lab1.a) * (lab0.a - lab1.a) +
        (lab0.b - lab1.b) * (lab0.b - lab1.b));
}

inline float l2l99(float l) {
    return 105.51 * log(1 + 0.0158 * l);
}

#define SIN_16 0.275637355
#define COS_16 0.961251695
inline void calcDin99Values(LAB lab, float *l99, float *a99, float *b99)
{
    // luminance
    *l99 = 105.51 * log(1 + 0.0158 * lab.l);
    if (lab.a == 0 && lab.b == 0) {
        *a99 = 0;
        *b99 = 0;
    } else {
        // red-green axis
        float e = lab.a * COS_16 + lab.b * SIN_16;
        // yellow-blue axis
        float f = 0.7 * (-lab.a * SIN_16 + lab.b * COS_16);
        // chroma
        float G = sqrt(e * e + f * f);
        //float k = log(1 + 0.045 * G) / 0.045 / G;
        float k = log(1 + G) / G;

        *a99 = k * e;
        *b99 = k * f;
    }
}

// http://de.wikipedia.org/wiki/DIN99-Farbraum
inline float deltaE99(LAB lab0, LAB lab1) {
    float l99_0, a99_0, b99_0, l99_1, a99_1, b99_1;

    calcDin99Values(lab0, &l99_0, &a99_0, &b99_0);
    calcDin99Values(lab1, &l99_1, &a99_1, &b99_1);
    
    return sqrt(
        (l99_0 - l99_1) * (l99_0 - l99_1) +
        (a99_0 - a99_1) * (a99_0 - a99_1) +
        (b99_0 - b99_1) * (b99_0 - b99_1));
}
