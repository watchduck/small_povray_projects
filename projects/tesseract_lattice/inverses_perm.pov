#version 3.6;
global_settings { assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 conserve_energy}}

#include "colors.inc"
#include "edges.inc"
#include "inverses.inc"
#include "CylinderWithOffset.inc"


/*
povray inverses_perm.pov +W3800 +H4000 +ua +fn

https://commons.wikimedia.org/wiki/File:Inverses_in_the_hexadecachoric_group,_PT.png
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

#declare LightBrown = color rgb<1,0.8,0.65>*.2;
#declare DarkBrown = color rgb<1,0.8,0.65>*.5;

#declare EdgeBlue = color srgbt<138,161,255,230>/255;
#declare EdgeGreen = color srgbt<138,247,138,230>/255;
#declare EdgeRed = color srgbt<255,138,138,230>/255;

#declare EdgeWhite = color rgbt<230,230,230,200>/255;


#declare PermPoints = array[24]{<0, -2, -1>, <-1, -2, 0>, <0, -1, -2>, <-2, -1, 0>, <-1, 0, -2>, <-2, 0, -1>, <1, -2, 0>, <0, -2, 1>, <1, 0, -2>, <-2, 0, 1>, <0, 1, -2>, <-2, 1, 0>, <2, -1, 0>, <0, -1, 2>, <2, 0, -1>, <-1, 0, 2>, <0, 2, -1>, <-1, 2, 0>, <2, 0, 1>, <1, 0, 2>, <2, 1, 0>, <0, 1, 2>, <1, 2, 0>, <0, 2, 1>}

#declare PermParities = array[24]{0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0}

#declare PermEdges = array[36]{array[2]{0, 1}, array[2]{0, 2}, array[2]{0, 6}, array[2]{1, 3}, array[2]{1, 7}, array[2]{2, 4}, array[2]{2, 8}, array[2]{3, 5}, array[2]{3, 9}, array[2]{4, 5}, array[2]{4, 10}, array[2]{5, 11}, array[2]{6, 7}, array[2]{6, 12}, array[2]{7, 13}, array[2]{8, 10}, array[2]{8, 14}, array[2]{9, 11}, array[2]{9, 15}, array[2]{10, 16}, array[2]{11, 17}, array[2]{12, 14}, array[2]{12, 18}, array[2]{13, 15}, array[2]{13, 19}, array[2]{14, 20}, array[2]{15, 21}, array[2]{16, 17}, array[2]{16, 22}, array[2]{17, 23}, array[2]{18, 19}, array[2]{18, 20}, array[2]{19, 21}, array[2]{20, 22}, array[2]{21, 23}, array[2]{22, 23}}

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


// tesseract edges (white)

#for( EdgeIndex, 0, 1343 )  // all edges
    #declare Edge = Edges[EdgeIndex];
    #declare LM = Edge[0];
    #declare LN = Edge[1];
    #declare HM = Edge[2];
    #declare HN = Edge[3];
    #declare LowPoint = CalcPoint(LM, LN);
    #declare HighPoint = CalcPoint(HM, HN);
    #if (LN = HN)  // show only tesseract edges
        cylinder{
            LowPoint, HighPoint,
            VertexRadius / 3
            pigment{ EdgeWhite }
        }
    #end
#end


// permutohedron edges (rgb)

#for( EdgeIndex, 0, 35 )
    #declare Edge = PermEdges[EdgeIndex];
    #declare L = Edge[0];
    #declare H = Edge[1];
    #declare LowPoint = PermPoints[L];
    #declare HighPoint = PermPoints[H];

    #declare CaseBlue = ((L=0 & H=1) | (L=6 & H=7) | (L=16 & H=22) | (L=17 & H=23) | (L=3 & H=5) | (L=9 & H=11) | (L=12 & H=18) | (L=14 & H=20) | (L=2 & H=4) | (L=8 & H=10) | (L=13 & H=19) | (L=15 & H=21));
    #declare CaseGreen = ((L=0 & H=2) | (L=1 & H=3) | (L=6 & H=12) | (L=7 & H=13) | (L=4 & H=5) | (L=8 & H=14) | (L=9 & H=15) | (L=18 & H=19) | (L=10 & H=16) | (L=11 & H=17) | (L=20 & H=22) | (L=21 & H=23));
    #declare CaseRed = ((L=0 & H=6) | (L=1 & H=7) | (L=16 & H=17) | (L=22 & H=23) | (L=3 & H=9) | (L=5 & H=11) | (L=12 & H=14) | (L=18 & H=20) | (L=2 & H=8) | (L=4 & H=10) | (L=13 & H=15) | (L=19 & H=21));

    object{
        CylinderWithOffset(LowPoint, HighPoint, .06, .3)
        pigment{
            #if (CaseBlue)    color EdgeBlue    #end
            #if (CaseGreen)   color EdgeGreen   #end
            #if (CaseRed)     color EdgeRed     #end
        }
    }
#end

// inverse edges (brown)

#for( EdgeIndex, 0, 153 )
    #declare Edge = InverseEdges[EdgeIndex];
    #declare M1 = Edge[0];
    #declare N1 = Edge[1];
    #declare M2 = Edge[2];
    #declare N2 = Edge[3];
    #declare Point1 = CalcPoint(M1, N1);
    #declare Point2 = CalcPoint(M2, N2);
    cylinder{
        Point1, Point2,
        #if (M1 = M2)   VertexRadius/25   #else   VertexRadius/4   #end
        #if (CalcParity(M1, N1))   pigment{DarkBrown}   #else   pigment{LightBrown}   #end
    }
#end


// all (small) vertices

#for( PermIndex, 0, 23 )
    #for( TessIndex, 0, 15 )
        #declare Point = CalcPoint(TessIndex, PermIndex);
        #declare Parity = CalcParity(TessIndex, PermIndex);
        sphere{
            Point, VertexRadius
            #if (Parity)  pigment{DarkBrown}   #else   pigment{LightBrown}   #end
        }

    #end
#end


// self inverse (big) vertices

#for( VertexIndex, 0, 75 )
    #declare Vertex = SelfInverseVertices[VertexIndex];
    #declare M = Vertex[0];
    #declare N = Vertex[1];
    #declare Point = CalcPoint(M, N);
    #declare Parity = CalcParity(M, N);
    sphere{
        Point, VertexRadius*2
        #if (Parity)  pigment{DarkBrown}   #else   pigment{LightBrown}   #end
    }
#end