#include "basics.inc"
#include "skeleton.inc"

#include "subspaces_1.inc"
//#include "subspaces_2_3.inc"
//#include "subspaces_4.inc"


/*
DIMENSION 1 (`subspaces_1.inc`)
https://commons.wikimedia.org/wiki/Category:Tesseract_subspaces_(image_set);_1_(line_segments);_Bilinski

declare -a strings=('1a0' '1a1' '1a2' '1a3' '1b00' '1b01' '1b02' '1b03' '1b04' '1b05' '1b06' '1b07' '1b08' '1b09' '1b10' '1b11' '1c00' '1c01' '1c02' '1c03' '1c04' '1c05' '1c06' '1c07' '1c08' '1c09' '1c10' '1c11' '1c12' '1c13' '1c14' '1c15' '1d0' '1d1' '1d2' '1d3' '1d4' '1d5' '1d6' '1d7')
for i in $(seq 0 39); do povray subspaces.pov +ua +fn +H3600 +W2596 -D -k$i -O${strings[$i]}; done


DIMENSIONS 2 AND 3 (`subspaces_2_3.inc`)
https://commons.wikimedia.org/wiki/Category:Tesseract_subspaces_(image_set);_2_(rectangles);_Bilinski
https://commons.wikimedia.org/wiki/Category:Tesseract_subspaces_(image_set);_3_(cuboids);_Bilinski

declare -a strings=('2a0' '2a1' '2a2' '2a3' '2a4' '2a5' '2b00' '2b01' '2b02' '2b03' '2b04' '2b05' '2b06' '2b07' '2b08' '2b09' '2b10' '2b11' '2b12' '2b13' '2b14' '2b15' '2b16' '2b17' '2b18' '2b19' '2b20' '2b21' '2b22' '2b23' '2c00' '2c01' '2c02' '2c03' '2c04' '2c05' '2c06' '2c07' '2c08' '2c09' '2c10' '2c11' '2d00' '2d01' '2d02' '2d03' '2d04' '2d05' '2d06' '2d07' '2d08' '2d09' '2d10' '2d11' '2d12' '2d13' '2d14' '2d15' '3a0' '3a1' '3a2' '3a3' '3b00' '3b01' '3b02' '3b03' '3b04' '3b05' '3b06' '3b07' '3b08' '3b09' '3b10' '3b11')
for i in $(seq 0 73); do povray subspaces.pov +ua +fn +H3600 +W2596 -D -k$i -O${strings[$i]}; done


DIMENSION 4 (`subspaces_4.inc`)
https://commons.wikimedia.org/wiki/File:Tesseract_subspace_4.png

povray subspaces.pov +ua +fn +H3600 +W2596
*/


#declare ShowFaces = false;

#declare ShowNumbers = true;
#declare TextTranslate = <-.01, -.035, -SubspaceRad*2>;
#declare TextScale = .1;


#for( Index, 0, dimension_size(SubspaceVerticesPositive, 1) - 1 )
    #declare VertexIndex = SubspaceVerticesPositive[Index];
    union{
        sphere{ P[VertexIndex+40], SubspaceRad*2 }
        sphere{ P[-VertexIndex+40], SubspaceRad*2 }
        pigment{ color srgb PureColors[SubspaceVertexWeight] }
    }
    #if (ShowNumbers)
        #declare PlusText = text {
            ttf "/usr/share/fonts/truetype/msttcorefonts/Arial.ttf",  str(VertexIndex,0,0) ,  0.075, 0
            scale TextScale  translate TextTranslate  translate P[VertexIndex+40]
        }
        #declare MinusText = text {
            ttf "/usr/share/fonts/truetype/msttcorefonts/Arial.ttf",  concat("−", str(VertexIndex,0,0)) ,  0.075, 0
            scale TextScale  translate TextTranslate  translate P[-VertexIndex+40]
        }
        union{
            object{ PlusText   translate -x * ( max_extent(PlusText).x - min_extent(PlusText).x ) / 2 }
            object{ MinusText   translate -x * ( max_extent(MinusText).x - min_extent(MinusText).x ) / 2 }
            pigment{color White}
        }

    #end
#end


#for( Index, 0, dimension_size(SubspaceEdges, 1) - 1 )
    #declare Weight = SubspaceEdgeWeights[Index];
    #local EdgeArray = SubspaceEdges[Index];
    cylinder{
        P[EdgeArray[0]+40], P[EdgeArray[1]+40], SubspaceRad
        pigment{ color srgb PureColors[Weight] }
    }
#end


#if (ShowFaces)
    union{
        #for( Index, 0, dimension_size(SubspaceFaces, 1) - 1 )
            #declare Weight = SubspaceFaceWeights[Index];
            #local FaceArray = SubspaceFaces[Index];
            polygon{ 4,
                #for(VertexIndexInFace, 0, 3)
                    P[FaceArray[VertexIndexInFace]+40]
                #end
                pigment{ color srgb PureColors[Weight] }
            }
        #end
    }
#end