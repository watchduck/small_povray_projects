#version 3.6;
global_settings { assumed_gamma 1.0 }
global_settings { charset utf8 }
#default{ finish{ ambient 0.1 diffuse 0.9 conserve_energy } }

#include "colors.inc"
#include "math.inc"


///////////////////////////// camera and light

#declare Camera_Position = <10, 15, -50>;
camera{
    location Camera_Position
    right    x*image_width/image_height
    angle    6.7
    look_at  <-0.05, -0.10, -0.07>
}

light_source{ <-400, 500, -300> color White*0.9 shadowless}

light_source{ Camera_Position  color rgb<0.9,0.9,1>*0.1 shadowless}
sky_sphere{ pigment{ White } }


///////////////////////////// skeleton

#declare SkeletonColor = rgb<.8, .8, .8>;
#declare SkeletonRad = .03;
#declare SubspaceRad = .09;

#declare A = 2.25;
#declare CC = array[8]{<-A,A,A>, <A,A,A>, <-A,-A,A>, <A,-A,A>, <-A,A,-A>, <A,A,-A>, <-A,-A,-A>, <A,-A,-A>}

#declare CubeEdgesAbstractCoordinates = array[12][2]{
    {0,1}, {2,3}, {4,5}, {6,7}, {0,2}, {1,3}, {4,6}, {5,7}, {0,4}, {1,5}, {2,6}, {3,7}
}

union{
    #for(i, 0, 7)
        sphere{CC[i], 2*SkeletonRad}
    #end
    #for(i, 0, 11)
        cylinder{
            CC[CubeEdgesAbstractCoordinates[i][0]],
            CC[CubeEdgesAbstractCoordinates[i][1]],
            SkeletonRad
        }
    #end
    pigment{color SkeletonColor}
}


///////////////////////////// variables

#declare P = array[27]{<-A, -A, -A>, <0, -A, -A>, <A, -A, -A>, <-A, -A, 0>, <0, -A, 0>, <A, -A, 0>, <-A, -A, A>, <0, -A, A>, <A, -A, A>, <-A, 0, -A>, <0, 0, -A>, <A, 0, -A>, <-A, 0, 0>, <0, 0, 0>, <A, 0, 0>, <-A, 0, A>, <0, 0, A>, <A, 0, A>, <-A, A, -A>, <0, A, -A>, <A, A, -A>, <-A, A, 0>, <0, A, 0>, <A, A, 0>, <-A, A, A>, <0, A, A>, <A, A, A>};

#declare PureColors = array[5]{ <.22,.22,.22>, <0,83,255>/255, <0,194,0>/255, <255,162,0>/255, <1,0,0> }

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