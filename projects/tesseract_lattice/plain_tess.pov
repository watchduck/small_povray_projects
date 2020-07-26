#version 3.6;
global_settings { assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 conserve_energy}}

#include "colors.inc"
#include "edges.inc"


/*
povray plain_tess.pov +W3000 +H4000 +ua +fn

https://commons.wikimedia.org/wiki/File:Lattice_of_the_hexadecachoric_group,_TP.png
*/


////////////////////// camera and light

#declare Camera_Position = <-7.5, 15, -40> * 4.5;
camera{
    location Camera_Position
    right    x*image_width/image_height
    angle    1.3
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


#declare PermPoints = array[24]{<0, -2, -1>, <-1, -2, 0>, <0, -1, -2>, <-2, -1, 0>, <-1, 0, -2>, <-2, 0, -1>, <1, -2, 0>, <0, -2, 1>, <1, 0, -2>, <-2, 0, 1>, <0, 1, -2>, <-2, 1, 0>, <2, -1, 0>, <0, -1, 2>, <2, 0, -1>, <-1, 0, 2>, <0, 2, -1>, <-1, 2, 0>, <2, 0, 1>, <1, 0, 2>, <2, 1, 0>, <0, 1, 2>, <1, 2, 0>, <0, 2, 1>}

#declare PermParities = array[24]{0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0}

#declare Permutations = array[24]{array[4]{0, 1, 2, 3}, array[4]{1, 0, 2, 3}, array[4]{0, 2, 1, 3}, array[4]{2, 0, 1, 3}, array[4]{1, 2, 0, 3}, array[4]{2, 1, 0, 3}, array[4]{0, 1, 3, 2}, array[4]{1, 0, 3, 2}, array[4]{0, 3, 1, 2}, array[4]{3, 0, 1, 2}, array[4]{1, 3, 0, 2}, array[4]{3, 1, 0, 2}, array[4]{0, 2, 3, 1}, array[4]{2, 0, 3, 1}, array[4]{0, 3, 2, 1}, array[4]{3, 0, 2, 1}, array[4]{2, 3, 0, 1}, array[4]{3, 2, 0, 1}, array[4]{1, 2, 3, 0}, array[4]{2, 1, 3, 0}, array[4]{1, 3, 2, 0}, array[4]{3, 1, 2, 0}, array[4]{2, 3, 1, 0}, array[4]{3, 2, 1, 0}}

#declare TessPoints = array[16]{<0, -Phi*Phi, 0>, <-Phi, -Phi, 0>, <0, -1, -1>, <-Phi, 0, -1>, <0, -1, 1>, <-Phi, 0, 1>, <0, 2*Phi - Phi*Phi, 0>, <-Phi,  Phi, 0>, <Phi, -Phi, 0>, <0, -2*Phi + Phi*Phi, 0>, <Phi, 0, -1>, <0, 1, -1>, <Phi, 0, 1>, <0, 1, 1>, <Phi,  Phi, 0>, <0, Phi*Phi, 0>}

#declare TessParities = array[16]{0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0}


// functions

#macro CalcPoint(TessIndex, PermIndex)
    #declare TessPoint = TessPoints[TessIndex];
    #declare TessPoint = vaxis_rotate(TessPoint, y, 45);
    #declare TessPoint = vaxis_rotate(TessPoint, x, 20);
    #declare TessPoint = vaxis_rotate(TessPoint, z, -4);
    #declare PermPoint = .12 * PermPoints[PermIndex];
    TessPoint + PermPoint
#end

#macro CalcParity(TessIndex, PermIndex)
    #declare TessParity = TessParities[TessIndex];
    #declare PermParity = PermParities[PermIndex];
    mod(TessParity + PermParity, 2)
#end

#macro EdgeColor(LM, LN, HM, HN)
    #if (LN=HN)  // permutohedron remains the same, thus tesseract changes
        color EdgeWhite
    #else  // permutohedron changes
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

#macro EdgeThickness(LM, LN, HM, HN)
    #if (LN=HN)  // permutohedron remains the same, thus tesseract changes
        VertexRadius / 40
    #else  // permutohedron changes
        #if (LM=HM)  // tesseract remains the same
            VertexRadius / 3
        #else  // tesseract changes as well
            VertexRadius / 7
        #end
    #end
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
    #if ((LN != HN) & (LM != HM))
        cone{
            LowPoint, EdgeThickness(LM, LN, HM, HN),
            HighPoint, EdgeThickness(LM, LN, HM, HN) / 10
            pigment{ EdgeColor(LM, LN, HM, HN) }
        }
    #else
        cylinder{
            LowPoint, HighPoint,
            EdgeThickness(LM, LN, HM, HN)
            pigment{ EdgeColor(LM, LN, HM, HN) }
        }
    #end
#end
