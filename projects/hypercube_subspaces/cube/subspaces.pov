#include "basics.inc"

#include "subspaces_1.inc"
//#include "subspaces_2_3.inc"


/*
https://commons.wikimedia.org/wiki/Category:Cube_subspaces_(image_set)


DIMENSION 1 (`subspaces_1.inc`)

declare -a strings=('1a0' '1a1' '1a2' '1b0' '1b1' '1b2' '1b3' '1b4' '1b5' '1c0' '1c1' '1c2' '1c3')
for i in $(seq 0 12); do povray subspaces.pov +ua +fn +H2000 +W2000 -D -k$i -O${strings[$i]}; done


DIMENSIONS 2 AND 3 (`subspaces_2_3.inc`)

declare -a strings=('2a0' '2a1' '2a2' '2b0' '2b1' '2b2' '2b3' '2b4' '2b5' '3a0')
for i in $(seq 0 9); do povray subspaces.pov +ua +fn +H2000 +W2000 -D -k$i -O${strings[$i]}; done
*/


#declare ShowFaces = false;

#declare ShowNumbers = true;
#declare TextTranslate = <-.01, -.035, -SubspaceRad*2>;
#declare TextScale = .1;


#for( Index, 0, dimension_size(SubspaceVerticesPositive, 1) - 1 )
    #declare VertexIndex = SubspaceVerticesPositive[Index];
    union{
        sphere{ P[VertexIndex+13], SubspaceRad*2 }
        sphere{ P[-VertexIndex+13], SubspaceRad*2 }
        pigment{ color srgb PureColors[SubspaceVertexWeight] }
    }
    #declare PlusText = text {
        ttf "/usr/share/fonts/truetype/msttcorefonts/Arial.ttf",  str(VertexIndex,0,0) ,  0.075, 0
        scale TextScale  translate TextTranslate  translate P[VertexIndex+13]
    }
    #declare MinusText = text {
        ttf "/usr/share/fonts/truetype/msttcorefonts/Arial.ttf",  concat("−", str(VertexIndex,0,0)) ,  0.075, 0
        scale TextScale  translate TextTranslate  translate P[-VertexIndex+13]
    }
    union{
        object{
            PlusText
            translate -x * ( max_extent(PlusText).x - min_extent(PlusText).x )
        }
        object{
            MinusText
            translate -x * ( max_extent(MinusText).x - min_extent(MinusText).x )
            translate <.01,-.13,-.02>  // 2b0, 1b04, 1c1
        }
        translate <.15,.12,.02>
        pigment{color White}
    }
#end


#for( Index, 0, dimension_size(SubspaceEdges, 1) - 1 )
    #declare Weight = SubspaceEdgeWeights[Index];
    #local EdgeArray = SubspaceEdges[Index];
    cylinder{
        P[EdgeArray[0]+13], P[EdgeArray[1]+13], SubspaceRad
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
                    P[FaceArray[VertexIndexInFace]+13]
                #end
                pigment{ color srgb PureColors[Weight] }
            }
        #end
    }
#end