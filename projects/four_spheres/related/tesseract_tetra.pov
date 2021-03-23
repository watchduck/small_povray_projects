// https://commons.wikimedia.org/wiki/File:Tesseract_tetrahedron_shadow_rgby.png

#version 3.6;
global_settings { assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 conserve_energy}}

#include "colors.inc"


///////////////////////////// camera and light

#declare Camera_Position = <10, 16, -50>;
camera{
    location Camera_Position
    right    x*image_width/image_height
    angle    10.3
    look_at  <.96, 1.085, 0>
}

light_source{ <-400, 500, -300> color White*0.9 shadowless}
light_source{ <400, 200, 100> color White*0.4 shadowless}
light_source{ Camera_Position  color rgb<0.9,0.9,1>*0.2 shadowless}
sky_sphere{ pigment{ White } }


////////////////////////////////////////////////////////////////////////

#declare ColorR = pigment{color srgb <219,0,0>/255}    // DB0000 red
#declare ColorG = pigment{color srgb <0,211,0>/255}    // 00D300 green
#declare ColorB = pigment{color srgb <0,48,255>/255}   // 0030FF blue
#declare ColorY = pigment{color srgb <255,158,0>/255}  // FF9E00 yellow

#declare Colors = array[4]{ColorR, ColorG, ColorB, ColorY}


/////////////////////////////////////////////////////////////////////////////////////////////////


#declare Factor = 7;

#declare VertexPoints = array[15]{ <-0.7071067811865475, -0.408248290463863, -0.28867513459481287>, <0.0, 0.0, 0.8660254037844386>, <-0.35355339059327373, -0.2041241452319315, 0.28867513459481287>, <0.0, 0.816496580927726, -0.28867513459481287>, <-0.35355339059327373, 0.2041241452319315, -0.28867513459481287>, <0.0, 0.408248290463863, 0.28867513459481287>, <-0.2357022603955158, 0.13608276348795434, 0.09622504486493762>, <0.7071067811865475, -0.408248290463863, -0.28867513459481287>, <0.0, -0.408248290463863, -0.28867513459481287>, <0.35355339059327373, -0.2041241452319315, 0.28867513459481287>, <0.0, -0.2721655269759087, 0.09622504486493762>, <0.35355339059327373, 0.2041241452319315, -0.28867513459481287>, <0.0, 0.0, -0.28867513459481287>, <0.2357022603955158, 0.13608276348795434, 0.09622504486493762>, <0.0, 0.0, 0.0> }

#declare VertexRanks = array[15]{ 1, 1, 2, 1, 2, 2, 3, 1, 2, 2, 3, 2, 3, 3, 4 }

#declare FakeRanks = array[5]{0, 1, 3, 6, 10}

#declare VertexRankParities = array[15]{ 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0 }

#declare Edges = array[28]{ array[2]{2, 3}, array[2]{4, 5}, array[2]{6, 7}, array[2]{8, 9}, array[2]{10, 11}, array[2]{12, 13}, array[2]{14, 15}, array[2]{1, 3}, array[2]{4, 6}, array[2]{5, 7}, array[2]{8, 10}, array[2]{9, 11}, array[2]{12, 14}, array[2]{13, 15}, array[2]{1, 5}, array[2]{2, 6}, array[2]{3, 7}, array[2]{8, 12}, array[2]{9, 13}, array[2]{10, 14}, array[2]{11, 15}, array[2]{1, 9}, array[2]{2, 10}, array[2]{3, 11}, array[2]{4, 12}, array[2]{5, 13}, array[2]{6, 14}, array[2]{7, 15} }

#declare EdgeColors = array[28]{ 1, 1, 1, 1, 1, 1, 1, 3, 3, 3, 3, 3, 3, 3, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 2 }

#declare Faces = array[18]{ array[4]{5, 1, 3, 7}, array[4]{6, 2, 3, 7}, array[4]{6, 4, 5, 7}, array[4]{10, 8, 9, 11}, array[4]{9, 1, 3, 11}, array[4]{10, 2, 3, 11}, array[4]{12, 4, 5, 13}, array[4]{12, 8, 9, 13}, array[4]{9, 1, 5, 13}, array[4]{12, 4, 6, 14}, array[4]{12, 8, 10, 14}, array[4]{10, 2, 6, 14}, array[4]{11, 3, 7, 15}, array[4]{14, 6, 7, 15}, array[4]{14, 10, 11, 15}, array[4]{13, 9, 11, 15}, array[4]{14, 12, 13, 15}, array[4]{13, 5, 7, 15} }


/////////////////////////////////////////////////////////////////////////////////////////////////


union{

    // VERTICES
    union{
        #for( i, 0, dimension_size(VertexPoints, 1)-1 )
            #local Rank = VertexRanks[i];
            #local FakeRank = FakeRanks[Rank];
            #local Rad = .05 + pow(10-FakeRank, 2) / 600;
            sphere{ VertexPoints[i]*Factor, Rad 
                #if(VertexRankParities[i])
                    pigment{color rgb<1,0.8,0.65>*.2}
                #else
                    pigment{color rgb<1,0.8,0.65>*.5}
                #end
            }
        #end
    }

    // EDGES
    #for( i, 0, dimension_size(Edges, 1)-1 )
        #local Edge = Edges[i];
        #local Index1 = Edge[0] - 1;
        #local Index2 = Edge[1] - 1;
        #local Point1 = VertexPoints[Index1]*Factor;
        #local Point2 = VertexPoints[Index2]*Factor;
        #local Rank1 = VertexRanks[Index1];
        #local Rank2 = VertexRanks[Index2];
        #local FakeRank1 = FakeRanks[Rank1];
        #local FakeRank2 = FakeRanks[Rank2];
        #local Rad1 = (.05 + pow(10-FakeRank1, 2) / 600) / 3.5;
        #local Rad2 = (.05 + pow(10-FakeRank2, 2) / 600) / 3.5;
        cone{ 
            Point1, Rad1, Point2, Rad2
            pigment{Colors[EdgeColors[i]]}
        }
    #end


    // FACES
    union{
        #for( i, 0, dimension_size(Faces, 1)-1 )
            #local FaceArray = Faces[i];
            #local LenOfFaceArray = dimension_size(FaceArray, 1);
            polygon{ LenOfFaceArray,
                #for(VertexIndexInFace, 0, LenOfFaceArray-1)
                    #local VertexIndexInPolytope = FaceArray[VertexIndexInFace] - 1;
                    VertexPoints[VertexIndexInPolytope]*Factor
                #end
            }
        #end
        pigment{color rgbt<1, 1, 1, .8>}
    }
    
    rotate -90*x
    rotate 4*y
    rotate 4*z
}

/*

povray tesseract_tetra.pov +ua +fn +W1000 +H1096
povray tesseract_tetra.pov +ua +fn +W4000 +H4384 -D

*/
