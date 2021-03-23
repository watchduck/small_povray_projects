#include "colors.inc"

#version 3.6;
global_settings { assumed_gamma 1.0 } 
#default{ finish{ ambient 0.1 diffuse 0.9 conserve_energy}}


////////////////////////////////////////////////////////////////////////

#declare Camera_Position = <4, 7, -30>;
camera{
    location Camera_Position
    right    x*image_width/image_height
    angle    10.5
    look_at  <-.16, -.2, 0>
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


////////////////////////////////////////////////////////////////////////

#declare RadEdge = .01;
#declare RadVert = .05;
#declare RadScale = .6;

#declare VertexRankParities = array[16]{ 0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0 }

#declare Scale = .47;
#declare P = array[16]{ 
	<-1,-1,-1>, <-1,1,-1>, <-1,-1,1>, <-1,1,1>, <1,-1,-1>, <1,1,-1>, <1,-1,1>, <1,1,1>,
	<-1,-1,-1>*Scale, <-1,1,-1>*Scale, <-1,-1,1>*Scale, <-1,1,1>*Scale, <1,-1,-1>*Scale, <1,1,-1>*Scale, <1,-1,1>*Scale, <1,1,1>*Scale
};

#declare Edges = array[32]{ array[2]{0, 1}, array[2]{0, 2}, array[2]{1, 3}, array[2]{2, 3}, array[2]{0, 4}, array[2]{1, 5}, array[2]{4, 5}, array[2]{2, 6}, array[2]{4, 6}, array[2]{3, 7}, array[2]{5, 7}, array[2]{6, 7}, array[2]{0, 8}, array[2]{1, 9}, array[2]{8, 9}, array[2]{2, 10}, array[2]{8, 10}, array[2]{3, 11}, array[2]{9, 11}, array[2]{10, 11}, array[2]{4, 12}, array[2]{8, 12}, array[2]{5, 13}, array[2]{9, 13}, array[2]{12, 13}, array[2]{6, 14}, array[2]{10, 14}, array[2]{12, 14}, array[2]{7, 15}, array[2]{11, 15}, array[2]{13, 15}, array[2]{14, 15} };

#declare EdgeColors = array[32]{ 0, 1, 1, 0, 2, 2, 0, 2, 1, 2, 1, 0, 3, 3, 0, 3, 1, 3, 1, 0, 3, 2, 3, 2, 0, 3, 2, 1, 3, 2, 1, 0 };


#declare Faces = array[24]{ array[4]{0, 1, 2, 3}, array[4]{0, 1, 4, 5}, array[4]{0, 2, 4, 6}, array[4]{1, 3, 5, 7}, array[4]{2, 3, 6, 7}, array[4]{4, 5, 6, 7}, array[4]{0, 1, 8, 9}, array[4]{0, 2, 8, 10}, array[4]{1, 3, 9, 11}, array[4]{2, 3, 10, 11}, array[4]{8, 9, 10, 11}, array[4]{0, 4, 8, 12}, array[4]{1, 5, 9, 13}, array[4]{4, 5, 12, 13}, array[4]{8, 9, 12, 13}, array[4]{2, 6, 10, 14}, array[4]{4, 6, 12, 14}, array[4]{8, 10, 12, 14}, array[4]{3, 7, 11, 15}, array[4]{5, 7, 13, 15}, array[4]{9, 11, 13, 15}, array[4]{6, 7, 14, 15}, array[4]{10, 11, 14, 15}, array[4]{12, 13, 14, 15} };


////////////////////////////////////////////////////////////////////////

union{

	// VERTICES
	union{
		#for( Index, 0, 15 )
			#if(Index<8)   #local R = RadVert;   #else   #local R = RadVert*RadScale;   #end
			sphere{ 
				P[Index], R
				#if(VertexRankParities[Index])
				    pigment{color rgb<1,0.8,0.65>*.2}
				#else
				    pigment{color rgb<1,0.8,0.65>*.5}
				#end
 			}
		#end
	}

	// EDGES
	#for( Index, 0, 31 )
	    #local EdgeArray = Edges[Index];
		#local A = EdgeArray[0];
		#local B = EdgeArray[1];
		#if(A<8)   #local RadA = RadEdge;   #else   #local RadA = RadEdge*RadScale;   #end
		#if(B<8)   #local RadB = RadEdge;   #else   #local RadB = RadEdge*RadScale;   #end
		cone{ 
            P[A], RadA, P[B], RadB
            pigment{Colors[EdgeColors[Index]]}
        }
	#end

	// FACES
	union{
		#for( Index, 0, 23 )
		    #local FaceArray = Faces[Index];
		    polygon{ 5, P[FaceArray[0]], P[FaceArray[1]], P[FaceArray[3]], P[FaceArray[2]], P[FaceArray[0]] }
		#end
		pigment{color rgbt<1, 1, 1, .8>}
	}
    
    rotate 90*z  scale -x  // change into right-handed system (cube permutation 0 5)
	scale 2.25

}

/*

povray tesseract.pov +ua +fn +W1000 +H1060
povray tesseract.pov +ua +fn +W4000 +H4240 -D

*/
