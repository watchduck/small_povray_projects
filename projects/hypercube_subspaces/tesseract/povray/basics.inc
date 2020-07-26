#version 3.6;
global_settings { assumed_gamma 1.0 }
global_settings { charset utf8 }
#default{ finish{ ambient 0.1 diffuse 0.9 conserve_energy } }

#include "colors.inc"
#include "math.inc"


#declare Variant = "subspaces";

#if (Variant = "tree")
    // +H3600 +W2592
    #declare Angle = 9.2;
    #declare MyBlack = <0,0,0>;
#end
#if (Variant = "subspaces")
    // +H3600 +W2596
    #declare Angle = 9.35;
    #declare MyBlack = <.22,.22,.22>;
#end


// camera and light

#declare PerspCameraLocation = 37 * vnormalize(<13.2, 3, -45>);

camera{
    location PerspCameraLocation
    look_at  <-0.06, 0.03, 0>
    right    x*image_width/image_height
    angle    Angle
}

light_source{ <-400, 500, -300> color White*0.9 shadowless}
light_source{ <400, 200, 100> color White*0.4 shadowless}
light_source{ PerspCameraLocation  color rgb<0.9,0.9,1>*0.2 shadowless}
sky_sphere{ pigment{ White } }

/////////////////////////////////////////////////////////////////

#declare Factor = 1.5;

#declare Abs = array[12]{
    ( 3/4 - sqrt(5)/4 )*Factor,   // 0.190983
    ( -1/4 + sqrt(5)/4 )*Factor,  // 0.309017
    ( 1/2 )*Factor,               // 0.5
    ( -1/2 + sqrt(5)/2 )*Factor,  // 0.618034
    ( 1/4 + sqrt(5)/4 )*Factor,   // 0.809017
    Factor,                       // 1
    ( sqrt(5)/2 )*Factor,         // 1.118034
    ( sqrt(5)/4 + 3/4 )*Factor,   // 1.309017
    ( 1/2 + sqrt(5)/2 )*Factor,   // 1.618034
    ( sqrt(5)/4 + 5/4 )*Factor,   // 1.809017
    ( 1 + sqrt(5)/2 )*Factor,     // 2.118034
    ( sqrt(5)/2 + 3/2 )*Factor
}

#declare P = array[81]{ <0, -Abs[11], 0>, <-Abs[4], -Abs[10], 0>, <-Abs[8], -Abs[8], 0>, <0, -Abs[9], -Abs[2]>, <-Abs[4], -Abs[7], -Abs[2]>, <-Abs[8], -Abs[4], -Abs[2]>, <0, -Abs[5], -Abs[5]>, <-Abs[4], -Abs[2], -Abs[5]>, <-Abs[8], 0, -Abs[5]>, <0, -Abs[9], Abs[2]>, <-Abs[4], -Abs[7], Abs[2]>, <-Abs[8], -Abs[4], Abs[2]>, <0, -Abs[5], 0>, <-Abs[4], -Abs[2], 0>, <-Abs[8], 0, 0>, <0, -Abs[0], -Abs[2]>, <-Abs[4], Abs[1], -Abs[2]>, <-Abs[8], Abs[4], -Abs[2]>, <0, -Abs[5], Abs[5]>, <-Abs[4], -Abs[2], Abs[5]>, <-Abs[8], 0, Abs[5]>, <0, -Abs[0], Abs[2]>, <-Abs[4], Abs[1], Abs[2]>, <-Abs[8], Abs[4], Abs[2]>, <0, Abs[3], 0>, <-Abs[4], Abs[6], 0>, <-Abs[8], Abs[8], 0>, <Abs[4], -Abs[10], 0>, <0, -Abs[8], 0>, <-Abs[4], -Abs[6], 0>, <Abs[4], -Abs[7], -Abs[2]>, <0, -Abs[4], -Abs[2]>, <-Abs[4], -Abs[1], -Abs[2]>, <Abs[4], -Abs[2], -Abs[5]>, <0, 0, -Abs[5]>, <-Abs[4], Abs[2], -Abs[5]>, <Abs[4], -Abs[7], Abs[2]>, <0, -Abs[4], Abs[2]>, <-Abs[4], -Abs[1], Abs[2]>, <Abs[4], -Abs[2], 0>, <0, 0, 0>, <-Abs[4], Abs[2], 0>, <Abs[4], Abs[1], -Abs[2]>, <0, Abs[4], -Abs[2]>, <-Abs[4], Abs[7], -Abs[2]>, <Abs[4], -Abs[2], Abs[5]>, <0, 0, Abs[5]>, <-Abs[4], Abs[2], Abs[5]>, <Abs[4], Abs[1], Abs[2]>, <0, Abs[4], Abs[2]>, <-Abs[4], Abs[7], Abs[2]>, <Abs[4], Abs[6], 0>, <0, Abs[8], 0>, <-Abs[4], Abs[10], 0>, <Abs[8], -Abs[8], 0>, <Abs[4], -Abs[6], 0>, <0, -Abs[3], 0>, <Abs[8], -Abs[4], -Abs[2]>, <Abs[4], -Abs[1], -Abs[2]>, <0, Abs[0], -Abs[2]>, <Abs[8], 0, -Abs[5]>, <Abs[4], Abs[2], -Abs[5]>, <0, Abs[5], -Abs[5]>, <Abs[8], -Abs[4], Abs[2]>, <Abs[4], -Abs[1], Abs[2]>, <0, Abs[0], Abs[2]>, <Abs[8], 0, 0>, <Abs[4], Abs[2], 0>, <0, Abs[5], 0>, <Abs[8], Abs[4], -Abs[2]>, <Abs[4], Abs[7], -Abs[2]>, <0, Abs[9], -Abs[2]>, <Abs[8], 0, Abs[5]>, <Abs[4], Abs[2], Abs[5]>, <0, Abs[5], Abs[5]>, <Abs[8], Abs[4], Abs[2]>, <Abs[4], Abs[7], Abs[2]>, <0, Abs[9], Abs[2]>, <Abs[8], Abs[8], 0>, <Abs[4], Abs[10], 0>, <0, Abs[11], 0> }

#declare PointWeights = array[81]{
    4, 3, 4,   3, 2, 3,   4, 3, 4,
    3, 2, 3,   2, 1, 2,   3, 2, 3,
    4, 3, 4,   3, 2, 3,   4, 3, 4,

    3, 2, 3,   2, 1, 2,   3, 2, 3,
    2, 1, 2,   1, 0, 1,   2, 1, 2,
    3, 2, 3,   2, 1, 2,   3, 2, 3,

    4, 3, 4,   3, 2, 3,   4, 3, 4,
    3, 2, 3,   2, 1, 2,   3, 2, 3,
    4, 3, 4,   3, 2, 3,   4, 3, 4
}

#declare EdgeArrays = array[216]{
    array[2]{0, -27}, array[2]{0, -9}, array[2]{0, -3}, array[2]{0, -1}, array[2]{0, 1}, array[2]{0, 3}, array[2]{0, 9}, array[2]{0, 27},
    array[2]{-27, -36}, array[2]{-27, -30}, array[2]{-27, -28}, array[2]{-27, -26}, array[2]{-27, -24}, array[2]{-27, -18}, array[2]{-9, -36}, array[2]{-9, -12}, array[2]{-9, -10}, array[2]{-9, -8}, array[2]{-9, -6}, array[2]{-9, 18}, array[2]{-3, -30}, array[2]{-3, -12}, array[2]{-3, -4}, array[2]{-3, -2}, array[2]{-3, 6}, array[2]{-3, 24}, array[2]{-1, -28}, array[2]{-1, -10}, array[2]{-1, -4}, array[2]{-1, 2}, array[2]{-1, 8}, array[2]{-1, 26}, array[2]{1, -26}, array[2]{1, -8}, array[2]{1, -2}, array[2]{1, 4}, array[2]{1, 10}, array[2]{1, 28}, array[2]{3, -24}, array[2]{3, -6}, array[2]{3, 2}, array[2]{3, 4}, array[2]{3, 12}, array[2]{3, 30}, array[2]{9, -18}, array[2]{9, 6}, array[2]{9, 8}, array[2]{9, 10}, array[2]{9, 12}, array[2]{9, 36}, array[2]{27, 18}, array[2]{27, 24}, array[2]{27, 26}, array[2]{27, 28}, array[2]{27, 30}, array[2]{27, 36},
    array[2]{-36, -39}, array[2]{-36, -37}, array[2]{-36, -35}, array[2]{-36, -33}, array[2]{-30, -39}, array[2]{-30, -31}, array[2]{-30, -29}, array[2]{-30, -21}, array[2]{-28, -37}, array[2]{-28, -31}, array[2]{-28, -25}, array[2]{-28, -19}, array[2]{-26, -35}, array[2]{-26, -29}, array[2]{-26, -23}, array[2]{-26, -17}, array[2]{-24, -33}, array[2]{-24, -25}, array[2]{-24, -23}, array[2]{-24, -15}, array[2]{-18, -21}, array[2]{-18, -19}, array[2]{-18, -17}, array[2]{-18, -15}, array[2]{-12, -39}, array[2]{-12, -13}, array[2]{-12, -11}, array[2]{-12, 15}, array[2]{-10, -37}, array[2]{-10, -13}, array[2]{-10, -7}, array[2]{-10, 17}, array[2]{-8, -35}, array[2]{-8, -11}, array[2]{-8, -5}, array[2]{-8, 19}, array[2]{-6, -33}, array[2]{-6, -7}, array[2]{-6, -5}, array[2]{-6, 21}, array[2]{-4, -31}, array[2]{-4, -13}, array[2]{-4, 5}, array[2]{-4, 23}, array[2]{-2, -29}, array[2]{-2, -11}, array[2]{-2, 7}, array[2]{-2, 25}, array[2]{2, -25}, array[2]{2, -7}, array[2]{2, 11}, array[2]{2, 29}, array[2]{4, -23}, array[2]{4, -5}, array[2]{4, 13}, array[2]{4, 31}, array[2]{6, -21}, array[2]{6, 5}, array[2]{6, 7}, array[2]{6, 33}, array[2]{8, -19}, array[2]{8, 5}, array[2]{8, 11}, array[2]{8, 35}, array[2]{10, -17}, array[2]{10, 7}, array[2]{10, 13}, array[2]{10, 37}, array[2]{12, -15}, array[2]{12, 11}, array[2]{12, 13}, array[2]{12, 39}, array[2]{18, 15}, array[2]{18, 17}, array[2]{18, 19}, array[2]{18, 21}, array[2]{24, 15}, array[2]{24, 23}, array[2]{24, 25}, array[2]{24, 33}, array[2]{26, 17}, array[2]{26, 23}, array[2]{26, 29}, array[2]{26, 35}, array[2]{28, 19}, array[2]{28, 25}, array[2]{28, 31}, array[2]{28, 37}, array[2]{30, 21}, array[2]{30, 29}, array[2]{30, 31}, array[2]{30, 39}, array[2]{36, 33}, array[2]{36, 35}, array[2]{36, 37}, array[2]{36, 39},
    array[2]{-39, -40}, array[2]{-39, -38}, array[2]{-37, -40}, array[2]{-37, -34}, array[2]{-35, -38}, array[2]{-35, -32}, array[2]{-33, -34}, array[2]{-33, -32}, array[2]{-31, -40}, array[2]{-31, -22}, array[2]{-29, -38}, array[2]{-29, -20}, array[2]{-25, -34}, array[2]{-25, -16}, array[2]{-23, -32}, array[2]{-23, -14}, array[2]{-21, -22}, array[2]{-21, -20}, array[2]{-19, -22}, array[2]{-19, -16}, array[2]{-17, -20}, array[2]{-17, -14}, array[2]{-15, -16}, array[2]{-15, -14}, array[2]{-13, -40}, array[2]{-13, 14}, array[2]{-11, -38}, array[2]{-11, 16}, array[2]{-7, -34}, array[2]{-7, 20}, array[2]{-5, -32}, array[2]{-5, 22}, array[2]{5, -22}, array[2]{5, 32}, array[2]{7, -20}, array[2]{7, 34}, array[2]{11, -16}, array[2]{11, 38}, array[2]{13, -14}, array[2]{13, 40}, array[2]{15, 14}, array[2]{15, 16}, array[2]{17, 14}, array[2]{17, 20}, array[2]{19, 16}, array[2]{19, 22}, array[2]{21, 20}, array[2]{21, 22}, array[2]{23, 14}, array[2]{23, 32}, array[2]{25, 16}, array[2]{25, 34}, array[2]{29, 20}, array[2]{29, 38}, array[2]{31, 22}, array[2]{31, 40}, array[2]{33, 32}, array[2]{33, 34}, array[2]{35, 32}, array[2]{35, 38}, array[2]{37, 34}, array[2]{37, 40}, array[2]{39, 38}, array[2]{39, 40}
}

#declare EdgeWeights = array[216]{
    0, 0, 0, 0, 0, 0, 0, 0,
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
    2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
    3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3
}

// tesseract points and edges
#declare TessPoints = array[16]{P[0] , P[2] , P[6] , P[8] , P[18] , P[20] , P[24] , P[26] , P[54] , P[56] , P[60] , P[62] , P[72] , P[74] , P[78] , P[80]};
#declare TessEdgeArrays = array[32]{ array[2]{0, 1}, array[2]{0, 2}, array[2]{1, 3}, array[2]{2, 3}, array[2]{0, 4}, array[2]{1, 5}, array[2]{4, 5}, array[2]{2, 6}, array[2]{4, 6}, array[2]{3, 7}, array[2]{5, 7}, array[2]{6, 7}, array[2]{0, 8}, array[2]{1, 9}, array[2]{8, 9}, array[2]{2, 10}, array[2]{8, 10}, array[2]{3, 11}, array[2]{9, 11}, array[2]{10, 11}, array[2]{4, 12}, array[2]{8, 12}, array[2]{5, 13}, array[2]{9, 13}, array[2]{12, 13}, array[2]{6, 14}, array[2]{10, 14}, array[2]{12, 14}, array[2]{7, 15}, array[2]{11, 15}, array[2]{13, 15}, array[2]{14, 15} };


#declare PureColors = array[5]{ MyBlack, <0,83,255>/255, <0,194,0>/255, <255,162,0>/255, <1,0,0> }
#declare MixedColors = array[4]{ <142,155,181>/255, <142,184,181>/255, <181,196,142>/255, <220,167,142>/255 }

#declare SkeletonRad = .03 * 1.4;
#declare SubspaceRad = .09 * 1.4;