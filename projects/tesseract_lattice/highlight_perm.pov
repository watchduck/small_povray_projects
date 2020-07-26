#version 3.6;
global_settings { assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 conserve_energy}}

#include "colors.inc"
#include "edges.inc"
#include "cases.inc"


/*
declare -a strings=('rank_0_and_10' 'rank_1_and_9' 'rank_2_and_8' 'rank_3_and_7' 'rank_4_and_6' 'rank_5' 'conju_(even,_0)' 'conju_(even,_bold)' 'conju_(even,_white)' 'conju_(even,_green)' 'conju_(even,_orange)' 'conju_(odd,_0)' 'conju_(odd,_bold)' 'conju_(odd,_white)' 'conju_(odd,_green)' 'conju_(odd,_orange)')
for i in $(seq 0 15); do povray highlight_perm.pov +W3800 +H4000 +ua +fn -D -k$i -Operm_${strings[$i]}; done

https://commons.wikimedia.org/wiki/Category:Hexadecachoric_group;_conjugacy_classes;_lattice;_PT
https://commons.wikimedia.org/wiki/Category:Hexadecachoric_group;_lattice_rank;_lattice;_PT
*/


////////////////////// camera and light

#declare Camera_Position = <-7.5, 15, -40> * 4.3;
camera{
    location Camera_Position
    right    x*image_width/image_height
    angle    1.5
    look_at  <0, 0, 0>
}


light_source{ <-400, 200, -300> color White*.8 shadowless}
light_source{ Camera_Position  color White*0.3 shadowless}
sky_sphere{ pigment{ White } }


// variables

#declare Phi = (1 + sqrt(5)) / 2;

#declare VertexRadius = .015;
#declare CalcRadius = .03;

#declare EdgeBlue = color srgb<223,229,255>/255;
#declare EdgeGreen = color srgb<223,253,223>/255;
#declare EdgeRed = color srgb<255,223,223>/255;

#declare VertexRed = color srgb<255,0,0>/255;
#declare VertexGreen = color srgb<0,204,0>/255;
#declare VertexYellow = color srgb<255,204,0>/255;
#declare VertexBlue = color srgb<68,115,255>/255;

#declare SolidWhite = color rgb<230,230,230>/255;
#declare TranspGray = color rgbt<0,0,0,130>/255;


#declare PermPoints = array[24]{<0, -2, -1>, <-1, -2, 0>, <0, -1, -2>, <-2, -1, 0>, <-1, 0, -2>, <-2, 0, -1>, <1, -2, 0>, <0, -2, 1>, <1, 0, -2>, <-2, 0, 1>, <0, 1, -2>, <-2, 1, 0>, <2, -1, 0>, <0, -1, 2>, <2, 0, -1>, <-1, 0, 2>, <0, 2, -1>, <-1, 2, 0>, <2, 0, 1>, <1, 0, 2>, <2, 1, 0>, <0, 1, 2>, <1, 2, 0>, <0, 2, 1>}

#declare PermParities = array[24]{0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0}

#declare Permutations = array[24]{array[4]{0, 1, 2, 3}, array[4]{1, 0, 2, 3}, array[4]{0, 2, 1, 3}, array[4]{2, 0, 1, 3}, array[4]{1, 2, 0, 3}, array[4]{2, 1, 0, 3}, array[4]{0, 1, 3, 2}, array[4]{1, 0, 3, 2}, array[4]{0, 3, 1, 2}, array[4]{3, 0, 1, 2}, array[4]{1, 3, 0, 2}, array[4]{3, 1, 0, 2}, array[4]{0, 2, 3, 1}, array[4]{2, 0, 3, 1}, array[4]{0, 3, 2, 1}, array[4]{3, 0, 2, 1}, array[4]{2, 3, 0, 1}, array[4]{3, 2, 0, 1}, array[4]{1, 2, 3, 0}, array[4]{2, 1, 3, 0}, array[4]{1, 3, 2, 0}, array[4]{3, 1, 2, 0}, array[4]{2, 3, 1, 0}, array[4]{3, 2, 1, 0}}

#declare TessPoints = array[16]{<0, -Phi*Phi, 0>, <-Phi, -Phi, 0>, <0, -1, -1>, <-Phi, 0, -1>, <0, -1, 1>, <-Phi, 0, 1>, <0, 2*Phi - Phi*Phi, 0>, <-Phi,  Phi, 0>, <Phi, -Phi, 0>, <0, -2*Phi + Phi*Phi, 0>, <Phi, 0, -1>, <0, 1, -1>, <Phi, 0, 1>, <0, 1, 1>, <Phi,  Phi, 0>, <0, Phi*Phi, 0>}

#declare TessParities = array[16]{0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0}


// functions

#macro CalcPoint(TessIndex, PermIndex)
    #declare TessPoint = .1 * TessPoints[TessIndex];
    #declare TessPoint = vaxis_rotate(TessPoint, y, 45);
    #declare TessPoint = vaxis_rotate(TessPoint, x, 20);
    #declare TessPoint = vaxis_rotate(TessPoint, z, -4);
    #declare PermPoint = PermPoints[PermIndex];
    TessPoint + PermPoint
#end

#macro CalcParity(TessIndex, PermIndex)
    #declare TessParity = TessParities[TessIndex];
    #declare PermParity = PermParities[PermIndex];
    mod(TessParity + PermParity, 2)
#end

#macro EdgeColor(LM, LN, HM, HN)
    #if (LN=HN)  // within same permutohedron vertex, thus tesseract edge
        color SolidWhite
    #else  // permutohedron edge
        #declare CaseBlue = ((LN=0 & HN=1) | (LN=6 & HN=7) | (LN=16 & HN=22) | (LN=17 & HN=23) | (LN=3 & HN=5) | (LN=9 & HN=11) | (LN=12 & HN=18) | (LN=14 & HN=20) | (LN=2 & HN=4) | (LN=8 & HN=10) | (LN=13 & HN=19) | (LN=15 & HN=21));
        #declare CaseGreen = ((LN=0 & HN=2) | (LN=1 & HN=3) | (LN=6 & HN=12) | (LN=7 & HN=13) | (LN=4 & HN=5) | (LN=8 & HN=14) | (LN=9 & HN=15) | (LN=18 & HN=19) | (LN=10 & HN=16) | (LN=11 & HN=17) | (LN=20 & HN=22) | (LN=21 & HN=23));
        #declare CaseRed = ((LN=0 & HN=6) | (LN=1 & HN=7) | (LN=16 & HN=17) | (LN=22 & HN=23) | (LN=3 & HN=9) | (LN=5 & HN=11) | (LN=12 & HN=14) | (LN=18 & HN=20) | (LN=2 & HN=8) | (LN=4 & HN=10) | (LN=13 & HN=15) | (LN=19 & HN=21));
        #if (CaseBlue)    color EdgeBlue    #end
        #if (CaseGreen)   color EdgeGreen   #end
        #if (CaseRed)     color EdgeRed     #end
    #end
#end

#macro EdgeThickness(LM, LN, HM, HN)
    #if (LN=HN)  // within same permutohedron vertex, thus tesseract edge
        CalcRadius / 7
    #else  // permutohedron edge
        #if (LM=HM)  // between corresponding tesseract vertices
            CalcRadius / 40
        #else  // also changing the tesseract
            CalcRadius / 10
        #end
    #end
#end

#macro is_in(Needle, Haystack)
    #local Found = false;
    #for(Index, 0, dimension_size(Haystack,1)-1)
        #local Candidate = Haystack[Index];
        #if(Candidate[0] = Needle[0] & Candidate[1] = Needle[1])
            #local Found = true;
        #end
    #end
    Found
#end


// edges

#for( EdgeIndex, 0, 1343 )
    #declare Edge = Edges[EdgeIndex];
    #declare LM = Edge[0];
    #declare LN = Edge[1];
    #declare HM = Edge[2];
    #declare HN = Edge[3];
    #declare LowPoint = CalcPoint(LM, LN);
    #declare HighPoint = CalcPoint(HM, HN);
    cylinder{
        LowPoint, HighPoint,
        EdgeThickness(LM, LN, HM, HN)
        pigment{ EdgeColor(LM, LN, HM, HN) }
    }
#end


// small vertices

#for( PermIndex, 0, 23 )
    #for( TessIndex, 0, 15 )
        #declare Point = CalcPoint(TessIndex, PermIndex);
        #declare Parity = CalcParity(TessIndex, PermIndex);
        sphere{ Point, VertexRadius   pigment{SolidWhite} }
        #if (Parity)
            sphere{ Point, VertexRadius + .0001   pigment{TranspGray} }
        #end
    #end
#end


// big vertices

#declare ColorArrays = array[4]{PairsRed, PairsGreen, PairsYellow, PairsBlue};
#declare ColorNames = array[4]{VertexRed, VertexGreen, VertexYellow, VertexBlue};

#for( PermIndex, 0, 23 )
    #for( TessIndex, 0, 15 )
        #declare Pair = array[2]{TessIndex, PermIndex}
        #for( ColorIndex, 0, 3 )
            #declare ColorArray = ColorArrays[ColorIndex];
            #if (is_in(Pair, ColorArray))
                #declare Point = CalcPoint(TessIndex, PermIndex);
                #declare Parity = CalcParity(TessIndex, PermIndex);
                #declare ColorName = ColorNames[ColorIndex];
                sphere{ Point, VertexRadius*2   pigment{ColorName} }
                #if (Parity)
                    sphere{ Point, VertexRadius*2 + .0001   pigment{TranspGray} }
                #end
            #end
        #end
    #end
#end