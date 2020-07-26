#version 3.6;
global_settings { assumed_gamma 1.0 }
global_settings { charset utf8 }
#default{ finish{ ambient 0.1 diffuse 0.9 conserve_energy } }

#include "colors.inc"
#include "math.inc"


/*
povray labels.pov +ua +fn +H3600 +W2592

https://commons.wikimedia.org/wiki/File:Face_lattice_of_the_tesseract,_labels.png
*/


// camera and light

#declare PerspCameraLocation = 37 * vnormalize(<13.2, 3, -45>);

camera{
    location PerspCameraLocation
    look_at  <-0.06, 0.03, 0>
    right    x*image_width/image_height
    angle    9.2
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

#declare Weights = array[41]{
                  0, 1,   2, 1, 2,
    3, 2, 3,   2, 1, 2,   3, 2, 3,

    4, 3, 4,   3, 2, 3,   4, 3, 4,
    3, 2, 3,   2, 1, 2,   3, 2, 3,
    4, 3, 4,   3, 2, 3,   4, 3, 4
}

// tree points
#declare P = array[81]{ <0, -Abs[11], 0>, <-Abs[4], -Abs[10], 0>, <-Abs[8], -Abs[8], 0>, <0, -Abs[9], -Abs[2]>, <-Abs[4], -Abs[7], -Abs[2]>, <-Abs[8], -Abs[4], -Abs[2]>, <0, -Abs[5], -Abs[5]>, <-Abs[4], -Abs[2], -Abs[5]>, <-Abs[8], 0, -Abs[5]>, <0, -Abs[9], Abs[2]>, <-Abs[4], -Abs[7], Abs[2]>, <-Abs[8], -Abs[4], Abs[2]>, <0, -Abs[5], 0>, <-Abs[4], -Abs[2], 0>, <-Abs[8], 0, 0>, <0, -Abs[0], -Abs[2]>, <-Abs[4], Abs[1], -Abs[2]>, <-Abs[8], Abs[4], -Abs[2]>, <0, -Abs[5], Abs[5]>, <-Abs[4], -Abs[2], Abs[5]>, <-Abs[8], 0, Abs[5]>, <0, -Abs[0], Abs[2]>, <-Abs[4], Abs[1], Abs[2]>, <-Abs[8], Abs[4], Abs[2]>, <0, Abs[3], 0>, <-Abs[4], Abs[6], 0>, <-Abs[8], Abs[8], 0>, <Abs[4], -Abs[10], 0>, <0, -Abs[8], 0>, <-Abs[4], -Abs[6], 0>, <Abs[4], -Abs[7], -Abs[2]>, <0, -Abs[4], -Abs[2]>, <-Abs[4], -Abs[1], -Abs[2]>, <Abs[4], -Abs[2], -Abs[5]>, <0, 0, -Abs[5]>, <-Abs[4], Abs[2], -Abs[5]>, <Abs[4], -Abs[7], Abs[2]>, <0, -Abs[4], Abs[2]>, <-Abs[4], -Abs[1], Abs[2]>, <Abs[4], -Abs[2], 0>, <0, 0, 0>, <-Abs[4], Abs[2], 0>, <Abs[4], Abs[1], -Abs[2]>, <0, Abs[4], -Abs[2]>, <-Abs[4], Abs[7], -Abs[2]>, <Abs[4], -Abs[2], Abs[5]>, <0, 0, Abs[5]>, <-Abs[4], Abs[2], Abs[5]>, <Abs[4], Abs[1], Abs[2]>, <0, Abs[4], Abs[2]>, <-Abs[4], Abs[7], Abs[2]>, <Abs[4], Abs[6], 0>, <0, Abs[8], 0>, <-Abs[4], Abs[10], 0>, <Abs[8], -Abs[8], 0>, <Abs[4], -Abs[6], 0>, <0, -Abs[3], 0>, <Abs[8], -Abs[4], -Abs[2]>, <Abs[4], -Abs[1], -Abs[2]>, <0, Abs[0], -Abs[2]>, <Abs[8], 0, -Abs[5]>, <Abs[4], Abs[2], -Abs[5]>, <0, Abs[5], -Abs[5]>, <Abs[8], -Abs[4], Abs[2]>, <Abs[4], -Abs[1], Abs[2]>, <0, Abs[0], Abs[2]>, <Abs[8], 0, 0>, <Abs[4], Abs[2], 0>, <0, Abs[5], 0>, <Abs[8], Abs[4], -Abs[2]>, <Abs[4], Abs[7], -Abs[2]>, <0, Abs[9], -Abs[2]>, <Abs[8], 0, Abs[5]>, <Abs[4], Abs[2], Abs[5]>, <0, Abs[5], Abs[5]>, <Abs[8], Abs[4], Abs[2]>, <Abs[4], Abs[7], Abs[2]>, <0, Abs[9], Abs[2]>, <Abs[8], Abs[8], 0>, <Abs[4], Abs[10], 0>, <0, Abs[11], 0> }

// tesseract points
#declare T = array[16]{P[0] , P[2] , P[6] , P[8] , P[18] , P[20] , P[24] , P[26] , P[54] , P[56] , P[60] , P[62] , P[72] , P[74] , P[78] , P[80]};

#declare EdgeArrays = array[32]{array[2]{8, 9}, array[2]{6, 7}, array[2]{8, 10}, array[2]{5, 7}, array[2]{9, 11}, array[2]{10, 11}, array[2]{4, 6}, array[2]{4, 5}, array[2]{8, 12}, array[2]{4, 12}, array[2]{3, 7}, array[2]{3, 11}, array[2]{9, 13}, array[2]{5, 13}, array[2]{12, 13}, array[2]{2, 3}, array[2]{2, 6}, array[2]{2, 10}, array[2]{6, 14}, array[2]{10, 14}, array[2]{12, 14}, array[2]{1, 3}, array[2]{1, 9}, array[2]{1, 5}, array[2]{13, 15}, array[2]{14, 15}, array[2]{11, 15}, array[2]{7, 15}, array[2]{0, 8}, array[2]{0, 2}, array[2]{0, 1}, array[2]{0, 4}}

#declare FaceArrays = array[24]{array[4]{9, 8, 10, 11}, array[4]{6, 7, 5, 4}, array[4]{5, 4, 12, 13}, array[4]{9, 8, 12, 13}, array[4]{3, 7, 6, 2}, array[4]{3, 11, 10, 2}, array[4]{6, 2, 10, 14}, array[4]{6, 4, 12, 14}, array[4]{10, 8, 12, 14}, array[4]{3, 11, 9, 1}, array[4]{3, 7, 5, 1}, array[4]{9, 13, 5, 1}, array[4]{13, 12, 14, 15}, array[4]{14, 10, 11, 15}, array[4]{13, 9, 11, 15}, array[4]{13, 5, 7, 15}, array[4]{14, 6, 7, 15}, array[4]{11, 3, 7, 15}, array[4]{8, 10, 2, 0}, array[4]{2, 3, 1, 0}, array[4]{8, 9, 1, 0}, array[4]{2, 6, 4, 0}, array[4]{1, 5, 4, 0}, array[4]{8, 12, 4, 0}}

#declare FacesAsEdgeArrays = array[24]{array[4]{array[2]{8, 9}, array[2]{8, 10}, array[2]{9, 11}, array[2]{10, 11}}, array[4]{array[2]{6, 7}, array[2]{5, 7}, array[2]{4, 6}, array[2]{4, 5}}, array[4]{array[2]{4, 5}, array[2]{4, 12}, array[2]{5, 13}, array[2]{12, 13}}, array[4]{array[2]{8, 9}, array[2]{8, 12}, array[2]{9, 13}, array[2]{12, 13}}, array[4]{array[2]{6, 7}, array[2]{3, 7}, array[2]{2, 3}, array[2]{2, 6}}, array[4]{array[2]{10, 11}, array[2]{3, 11}, array[2]{2, 3}, array[2]{2, 10}}, array[4]{array[2]{2, 6}, array[2]{2, 10}, array[2]{6, 14}, array[2]{10, 14}}, array[4]{array[2]{4, 6}, array[2]{4, 12}, array[2]{6, 14}, array[2]{12, 14}}, array[4]{array[2]{8, 10}, array[2]{8, 12}, array[2]{10, 14}, array[2]{12, 14}}, array[4]{array[2]{9, 11}, array[2]{3, 11}, array[2]{1, 3}, array[2]{1, 9}}, array[4]{array[2]{5, 7}, array[2]{3, 7}, array[2]{1, 3}, array[2]{1, 5}}, array[4]{array[2]{9, 13}, array[2]{5, 13}, array[2]{1, 9}, array[2]{1, 5}}, array[4]{array[2]{12, 13}, array[2]{12, 14}, array[2]{13, 15}, array[2]{14, 15}}, array[4]{array[2]{10, 11}, array[2]{10, 14}, array[2]{14, 15}, array[2]{11, 15}}, array[4]{array[2]{9, 11}, array[2]{9, 13}, array[2]{13, 15}, array[2]{11, 15}}, array[4]{array[2]{5, 7}, array[2]{5, 13}, array[2]{13, 15}, array[2]{7, 15}}, array[4]{array[2]{6, 7}, array[2]{6, 14}, array[2]{14, 15}, array[2]{7, 15}}, array[4]{array[2]{3, 7}, array[2]{3, 11}, array[2]{11, 15}, array[2]{7, 15}}, array[4]{array[2]{8, 10}, array[2]{2, 10}, array[2]{0, 8}, array[2]{0, 2}}, array[4]{array[2]{2, 3}, array[2]{1, 3}, array[2]{0, 2}, array[2]{0, 1}}, array[4]{array[2]{8, 9}, array[2]{1, 9}, array[2]{0, 8}, array[2]{0, 1}}, array[4]{array[2]{4, 6}, array[2]{2, 6}, array[2]{0, 2}, array[2]{0, 4}}, array[4]{array[2]{4, 5}, array[2]{1, 5}, array[2]{0, 1}, array[2]{0, 4}}, array[4]{array[2]{8, 12}, array[2]{4, 12}, array[2]{0, 8}, array[2]{0, 4}}}

#declare CellsAsEdgeArrays = array[8]{
    array[12]{array[2]{6, 7}, array[2]{5, 7}, array[2]{4, 6}, array[2]{4, 5}, array[2]{3, 7}, array[2]{2, 3}, array[2]{2, 6}, array[2]{1, 3}, array[2]{1, 5}, array[2]{0, 2}, array[2]{0, 1}, array[2]{0, 4}},
    array[12]{array[2]{8, 9}, array[2]{8, 10}, array[2]{9, 11}, array[2]{10, 11}, array[2]{3, 11}, array[2]{2, 3}, array[2]{2, 10}, array[2]{1, 3}, array[2]{1, 9}, array[2]{0, 8}, array[2]{0, 2}, array[2]{0, 1}},
    array[12]{array[2]{8, 9}, array[2]{4, 5}, array[2]{8, 12}, array[2]{4, 12}, array[2]{9, 13}, array[2]{5, 13}, array[2]{12, 13}, array[2]{1, 9}, array[2]{1, 5}, array[2]{0, 8}, array[2]{0, 1}, array[2]{0, 4}},
    array[12]{array[2]{8, 10}, array[2]{4, 6}, array[2]{8, 12}, array[2]{4, 12}, array[2]{2, 6}, array[2]{2, 10}, array[2]{6, 14}, array[2]{10, 14}, array[2]{12, 14}, array[2]{0, 8}, array[2]{0, 2}, array[2]{0, 4}},
    array[12]{array[2]{5, 7}, array[2]{9, 11}, array[2]{3, 7}, array[2]{3, 11}, array[2]{9, 13}, array[2]{5, 13}, array[2]{1, 3}, array[2]{1, 9}, array[2]{1, 5}, array[2]{13, 15}, array[2]{11, 15}, array[2]{7, 15}},
    array[12]{array[2]{6, 7}, array[2]{10, 11}, array[2]{3, 7}, array[2]{3, 11}, array[2]{2, 3}, array[2]{2, 6}, array[2]{2, 10}, array[2]{6, 14}, array[2]{10, 14}, array[2]{14, 15}, array[2]{11, 15}, array[2]{7, 15}},
    array[12]{array[2]{6, 7}, array[2]{5, 7}, array[2]{4, 6}, array[2]{4, 5}, array[2]{4, 12}, array[2]{5, 13}, array[2]{12, 13}, array[2]{6, 14}, array[2]{12, 14}, array[2]{13, 15}, array[2]{14, 15}, array[2]{7, 15}},
    array[12]{array[2]{8, 9}, array[2]{8, 10}, array[2]{9, 11}, array[2]{10, 11}, array[2]{8, 12}, array[2]{9, 13}, array[2]{12, 13}, array[2]{10, 14}, array[2]{12, 14}, array[2]{13, 15}, array[2]{14, 15}, array[2]{11, 15}}
}

#declare CellsAsFaceArrays = array[8]{
    array[6]{array[4]{6, 7, 5, 4}, array[4]{3, 7, 6, 2}, array[4]{3, 7, 5, 1}, array[4]{2, 3, 1, 0}, array[4]{2, 6, 4, 0}, array[4]{1, 5, 4, 0}},
    array[6]{array[4]{9, 8, 10, 11}, array[4]{3, 11, 10, 2}, array[4]{3, 11, 9, 1}, array[4]{8, 10, 2, 0}, array[4]{2, 3, 1, 0}, array[4]{8, 9, 1, 0}},
    array[6]{array[4]{5, 4, 12, 13}, array[4]{9, 8, 12, 13}, array[4]{9, 13, 5, 1}, array[4]{8, 9, 1, 0}, array[4]{1, 5, 4, 0}, array[4]{8, 12, 4, 0}},
    array[6]{array[4]{6, 2, 10, 14}, array[4]{6, 4, 12, 14}, array[4]{10, 8, 12, 14}, array[4]{8, 10, 2, 0}, array[4]{2, 6, 4, 0}, array[4]{8, 12, 4, 0}},
    array[6]{array[4]{3, 11, 9, 1}, array[4]{3, 7, 5, 1}, array[4]{9, 13, 5, 1}, array[4]{13, 9, 11, 15}, array[4]{13, 5, 7, 15}, array[4]{11, 3, 7, 15}},
    array[6]{array[4]{3, 7, 6, 2}, array[4]{3, 11, 10, 2}, array[4]{6, 2, 10, 14}, array[4]{14, 10, 11, 15}, array[4]{14, 6, 7, 15}, array[4]{11, 3, 7, 15}},
    array[6]{array[4]{6, 7, 5, 4}, array[4]{5, 4, 12, 13}, array[4]{6, 4, 12, 14}, array[4]{13, 12, 14, 15}, array[4]{13, 5, 7, 15}, array[4]{14, 6, 7, 15}},
    array[6]{array[4]{9, 8, 10, 11}, array[4]{9, 8, 12, 13}, array[4]{10, 8, 12, 14}, array[4]{13, 12, 14, 15}, array[4]{14, 10, 11, 15}, array[4]{13, 9, 11, 15}}
}


#declare CellCenterIndices = array[8]{-27, -9, -3, -1, 1, 3, 9, 27};

#declare PureColors = array[5]{ <.22,.22,.22>, <0,83,255>/255, <0,194,0>/255, <255,162,0>/255, <1,0,0> }

#declare Rad = 0.012;
#declare ScaleFactor = .2;


/////////////////////////////////////////////////////////////////

// vertices
union{
    #for(Index, 0, 15)
        sphere{ T[Index],  4*Rad }
    #end
    pigment{ color srgb PureColors[4] }
}

// edges
union{
    #for(Index, 0, 31)
        #declare EdgeArray = EdgeArrays[Index];
        cylinder{ T[EdgeArray[0]], T[EdgeArray[1]],  2*Rad }
    #end
    pigment{ color srgbt PureColors[3] }
}

// faces
union{
    #for(FaceIndex, 0, 23)
        #declare FaceEdgeArrays = FacesAsEdgeArrays[FaceIndex];
        #declare FaceArray = FaceArrays[FaceIndex];
        #declare FaceCenter = ( T[FaceArray[0]] + T[FaceArray[1]] + T[FaceArray[2]] + T[FaceArray[3]] ) / 4;
        union{
            #for(EdgeIndex, 0, 3)
                #declare EdgeArray = FaceEdgeArrays[EdgeIndex];
                sphere{ T[EdgeArray[0]],  Rad/ScaleFactor }
                sphere{ T[EdgeArray[1]],  Rad/ScaleFactor }
                cylinder{ T[EdgeArray[0]], T[EdgeArray[1]],  Rad/ScaleFactor }
            #end
            translate -FaceCenter  scale ScaleFactor  translate FaceCenter
        }
    #end
    pigment{ color srgbt PureColors[2] }
}

// cells
#declare CellRad = 0.5 * Rad / ScaleFactor;
#for(CellIndex, 0, 7)
    #declare CellCenter = P[CellCenterIndices[CellIndex]+40];
        union{
        // cell edges
        #declare CellEdgeArrays = CellsAsEdgeArrays[CellIndex];
        union{
            #for(EdgeIndex, 0, 11)
                #declare EdgeArray = CellEdgeArrays[EdgeIndex];
                sphere{ T[EdgeArray[0]],  CellRad }
                sphere{ T[EdgeArray[1]],  CellRad }
                cylinder{ T[EdgeArray[0]], T[EdgeArray[1]],  CellRad }
            #end
            pigment{ color srgbt PureColors[1] }
        }
        // cell faces
        #declare CellFaceArrays = CellsAsFaceArrays[CellIndex];
        union{
            #for(FaceIndex, 0, 5)
                #declare FaceArray = CellFaceArrays[FaceIndex];
                polygon{ 4,
                    #for(VertexIndexInFace, 0, 3)
                        T[FaceArray[VertexIndexInFace]]
                    #end
                }
            #end
            pigment{ color rgbt <0,0,1,.9> }
        }
        translate -CellCenter  scale ScaleFactor  translate CellCenter
    }
#end



// labels
#declare TextScale = .28;
#for(Index, 0, 40)
    #declare Weight = Weights[Index];
    #declare PlusText = text {
        ttf "/usr/share/fonts/truetype/msttcorefonts/Arial.ttf",  str(Index,0,0) ,  0.075, 0
        scale TextScale  translate P[Index+40]
    }
    #declare MinusText = text {
        ttf "/usr/share/fonts/truetype/msttcorefonts/Arial.ttf",  concat("−", str(Index,0,0)) ,  0.075, 0
        scale TextScale  translate P[-Index+40]
    }
    union{
        object{ PlusText   translate -x * ( max_extent(PlusText).x - min_extent(PlusText).x ) / 2 }
//        #if (Index > 0)
//            object{ MinusText   translate -x * ( max_extent(MinusText).x - min_extent(MinusText).x ) / 2 }
//        #end
        pigment{ color srgbt PureColors[Weight] * 2/3 }
        translate -.09*y
        #if (Weight > 2)
            translate -.1*z
        #end
    }
#end