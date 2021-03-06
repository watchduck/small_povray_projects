#version 3.6;
global_settings { assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 conserve_energy}}

#include "colors.inc"
#include "edges.inc"
#include "black_edges.inc"


/*
declare -a strings=('(0,_1)_eq_b' 'a_after_(3,_1)_eq_b' 'a_after_(0,_2)_eq_b' 'a_after_(6,_2)_eq_b' 'a_after_(0,_6)_eq_b' 'a_after_(12,_6)_eq_b' 'a_after_(0,_5)_eq_b' 'a_after_(5,_5)_eq_b' 'a_after_(0,_14)_eq_b' 'a_after_(10,_14)_eq_b' 'a_after_(0,_21)_eq_b' 'a_after_(9,_21)_eq_b' 'a_after_(1,_0)_eq_b' 'a_after_(2,_0)_eq_b' 'a_after_(4,_0)_eq_b' 'a_after_(8,_0)' '(0,_1)_after_a_eq_b' '(0,_2)_after_a_eq_b' '(0,_6)_after_a_eq_b' '(1,_0)_after_a_eq_b' '(2,_0)_after_a_eq_b' '(4,_0)_after_a_eq_b' '(8,_0)_after_a_eq_b')
for i in $(seq 0 22); do povray black_edges_perm.pov +W3800 +H4000 +ua +fn -D -k$i -Operm_${strings[$i]}; done

https://commons.wikimedia.org/wiki/Category:Hexadecachoric_group;_lattice_edges_with_equations
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

#declare VertexRadius = .03;

#declare LightBrown = color rgb<1,0.8,0.65>*.2;
#declare DarkBrown = color rgb<1,0.8,0.65>*.5;

#declare EdgeDarkBlue = color srgb<50,91,255>/255;
#declare EdgeDarkGreen = color srgb<50,241,50>/255;
#declare EdgeDarkRed = color srgb<255,50,50>/255;
#declare EdgeLightBlue = color srgb<138,161,255>/255;
#declare EdgeLightGreen = color srgb<138,247,138>/255;
#declare EdgeLightRed = color srgb<255,138,138>/255;
#declare EdgeWhite = color rgbt<230,230,230,100>/255;
#declare EdgeBlack = color srgb<10,10,10>/255;



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
    #declare ThisEdge = array[4]{LM, LN, HM, HN};
    #if (is_in(ThisEdge, BlackEdges))
        color EdgeBlack
    #else
        #if (LN=HN)  // within same permutohedron vertex, thus tesseract edge
            color EdgeWhite
        #else  // permutohedron edge
            #declare CaseBlue = ((LN=0 & HN=1) | (LN=6 & HN=7) | (LN=16 & HN=22) | (LN=17 & HN=23) | (LN=3 & HN=5) | (LN=9 & HN=11) | (LN=12 & HN=18) | (LN=14 & HN=20) | (LN=2 & HN=4) | (LN=8 & HN=10) | (LN=13 & HN=19) | (LN=15 & HN=21));
            #declare CaseGreen = ((LN=0 & HN=2) | (LN=1 & HN=3) | (LN=6 & HN=12) | (LN=7 & HN=13) | (LN=4 & HN=5) | (LN=8 & HN=14) | (LN=9 & HN=15) | (LN=18 & HN=19) | (LN=10 & HN=16) | (LN=11 & HN=17) | (LN=20 & HN=22) | (LN=21 & HN=23));
            #declare CaseRed = ((LN=0 & HN=6) | (LN=1 & HN=7) | (LN=16 & HN=17) | (LN=22 & HN=23) | (LN=3 & HN=9) | (LN=5 & HN=11) | (LN=12 & HN=14) | (LN=18 & HN=20) | (LN=2 & HN=8) | (LN=4 & HN=10) | (LN=13 & HN=15) | (LN=19 & HN=21));
            #if (LM=HM)
                #if (CaseBlue)    color EdgeDarkBlue    #end
                #if (CaseGreen)   color EdgeDarkGreen   #end
                #if (CaseRed)     color EdgeDarkRed     #end
            #else
                #if (CaseBlue)    color EdgeLightBlue    #end
                #if (CaseGreen)   color EdgeLightGreen   #end
                #if (CaseRed)     color EdgeLightRed     #end
            #end
        #end
    #end
#end

#macro EdgeThickness(LM, LN, HM, HN)
    #declare ThisEdge = array[4]{LM, LN, HM, HN};
    #if (is_in(ThisEdge, BlackEdges))
        VertexRadius / 5
    #else
        #if (LN=HN)  // within same permutohedron vertex, thus tesseract edge
            VertexRadius / 3
        #else  // permutohedron edge
            #if (LM=HM)  // between corresponding tesseract vertices
                VertexRadius / 40
            #else  // also changing the tesseract
                VertexRadius / 10
            #end
        #end
    #end
#end

#macro is_in(Needle, Haystack)
    #local Found = false;
    #for(Index, 0, dimension_size(Haystack,1)-1)
        #local Candidate = Haystack[Index];
        #if(Candidate[0] = Needle[0] & Candidate[1] = Needle[1] & Candidate[2] = Needle[2] & Candidate[3] = Needle[3])
            #local Found = true;
        #end
    #end
    Found
#end


// vertices

#for( PermIndex, 0, 23 )
    #for( TessIndex, 0, 15 )
        #declare Point = CalcPoint(TessIndex, PermIndex);
        #declare Parity = CalcParity(TessIndex, PermIndex);
        sphere{
            Point, VertexRadius
            #if (Parity)  pigment{LightBrown}   #else   pigment{DarkBrown}   #end
        }
    #end
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