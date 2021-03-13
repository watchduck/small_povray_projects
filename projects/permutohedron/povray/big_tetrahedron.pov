#version 3.6;
global_settings { assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 conserve_energy}}

#include "colors.inc"


/*
povray big_tetrahedron_2.pov +W3740 +H4000 +ua +fn
https://commons.wikimedia.org/wiki/File:Permutohedron_in_simplex_of_order_4,_with_truncated_tetrahedron.png
*/


#declare ShowBrownEdges = 0;
#declare PermOneBased = 0;


////////////////////// camera and light

#declare Camera_Position = <-7.5, 15, -40> * .88 ;
camera{
    location Camera_Position
    right    x*image_width/image_height
    angle    11.7
    look_at  <.27, -.37, 0>
}


light_source{ <-400, 500, -300>*.3 color White shadowless}

light_source{ Camera_Position  color rgb<0.9,0.9,1>*0.1 shadowless}
sky_sphere{ pigment{ White } }


// variables

#declare VertexRadius = .18;
#declare TextTranslate = <-.1, .007, -1*VertexRadius>;
#declare TextScale = .13;

// These points refer to Povrays left-hand coordinate system.
#declare Points = array[84]{<-3, 3, 3>, <-2, 3, 2>, <-1, 3, 1>, <0, 3, 0>, <1, 3, -1>, <2, 3, -2>, <3, 3, -3>, <-2, 2, 3>, <-1, 2, 2>, <0, 2, 1>, <1, 2, 0>, <2, 2, -1>, <3, 2, -2>, <-1, 1, 3>, <0, 1, 2>, <1, 1, 1>, <2, 1, 0>, <3, 1, -1>, <0, 0, 3>, <1, 0, 2>, <2, 0, 1>, <3, 0, 0>, <1, -1, 3>, <2, -1, 2>, <3, -1, 1>, <2, -2, 3>, <3, -2, 2>, <3, -3, 3>, <-3, 2, 2>, <-2, 2, 1>, <-1, 2, 0>, <0, 2, -1>, <1, 2, -2>, <2, 2, -3>, <-2, 1, 2>, <-1, 1, 1>, <0, 1, 0>, <1, 1, -1>, <2, 1, -2>, <-1, 0, 2>, <0, 0, 1>, <1, 0, 0>, <2, 0, -1>, <0, -1, 2>, <1, -1, 1>, <2, -1, 0>, <1, -2, 2>, <2, -2, 1>, <2, -3, 2>, <-3, 1, 1>, <-2, 1, 0>, <-1, 1, -1>, <0, 1, -2>, <1, 1, -3>, <-2, 0, 1>, <-1, 0, 0>, <0, 0, -1>, <1, 0, -2>, <-1, -1, 1>, <0, -1, 0>, <1, -1, -1>, <0, -2, 1>, <1, -2, 0>, <1, -3, 1>, <-3, 0, 0>, <-2, 0, -1>, <-1, 0, -2>, <0, 0, -3>, <-2, -1, 0>, <-1, -1, -1>, <0, -1, -2>, <-1, -2, 0>, <0, -2, -1>, <0, -3, 0>, <-3, -1, -1>, <-2, -1, -2>, <-1, -1, -3>, <-2, -2, -1>, <-1, -2, -2>, <-1, -3, -1>, <-3, -2, -2>, <-2, -2, -3>, <-2, -3, -2>, <-3, -3, -3>}

#declare Coordinates = array[84]{array[4]{6, 0, 0, 0}, array[4]{5, 1, 0, 0}, array[4]{4, 2, 0, 0}, array[4]{3, 3, 0, 0}, array[4]{2, 4, 0, 0}, array[4]{1, 5, 0, 0}, array[4]{0, 6, 0, 0}, array[4]{5, 0, 1, 0}, array[4]{4, 1, 1, 0}, array[4]{3, 2, 1, 0}, array[4]{2, 3, 1, 0}, array[4]{1, 4, 1, 0}, array[4]{0, 5, 1, 0}, array[4]{4, 0, 2, 0}, array[4]{3, 1, 2, 0}, array[4]{2, 2, 2, 0}, array[4]{1, 3, 2, 0}, array[4]{0, 4, 2, 0}, array[4]{3, 0, 3, 0}, array[4]{2, 1, 3, 0}, array[4]{1, 2, 3, 0}, array[4]{0, 3, 3, 0}, array[4]{2, 0, 4, 0}, array[4]{1, 1, 4, 0}, array[4]{0, 2, 4, 0}, array[4]{1, 0, 5, 0}, array[4]{0, 1, 5, 0}, array[4]{0, 0, 6, 0}, array[4]{5, 0, 0, 1}, array[4]{4, 1, 0, 1}, array[4]{3, 2, 0, 1}, array[4]{2, 3, 0, 1}, array[4]{1, 4, 0, 1}, array[4]{0, 5, 0, 1}, array[4]{4, 0, 1, 1}, array[4]{3, 1, 1, 1}, array[4]{2, 2, 1, 1}, array[4]{1, 3, 1, 1}, array[4]{0, 4, 1, 1}, array[4]{3, 0, 2, 1}, array[4]{2, 1, 2, 1}, array[4]{1, 2, 2, 1}, array[4]{0, 3, 2, 1}, array[4]{2, 0, 3, 1}, array[4]{1, 1, 3, 1}, array[4]{0, 2, 3, 1}, array[4]{1, 0, 4, 1}, array[4]{0, 1, 4, 1}, array[4]{0, 0, 5, 1}, array[4]{4, 0, 0, 2}, array[4]{3, 1, 0, 2}, array[4]{2, 2, 0, 2}, array[4]{1, 3, 0, 2}, array[4]{0, 4, 0, 2}, array[4]{3, 0, 1, 2}, array[4]{2, 1, 1, 2}, array[4]{1, 2, 1, 2}, array[4]{0, 3, 1, 2}, array[4]{2, 0, 2, 2}, array[4]{1, 1, 2, 2}, array[4]{0, 2, 2, 2}, array[4]{1, 0, 3, 2}, array[4]{0, 1, 3, 2}, array[4]{0, 0, 4, 2}, array[4]{3, 0, 0, 3}, array[4]{2, 1, 0, 3}, array[4]{1, 2, 0, 3}, array[4]{0, 3, 0, 3}, array[4]{2, 0, 1, 3}, array[4]{1, 1, 1, 3}, array[4]{0, 2, 1, 3}, array[4]{1, 0, 2, 3}, array[4]{0, 1, 2, 3}, array[4]{0, 0, 3, 3}, array[4]{2, 0, 0, 4}, array[4]{1, 1, 0, 4}, array[4]{0, 2, 0, 4}, array[4]{1, 0, 1, 4}, array[4]{0, 1, 1, 4}, array[4]{0, 0, 2, 4}, array[4]{1, 0, 0, 5}, array[4]{0, 1, 0, 5}, array[4]{0, 0, 1, 5}, array[4]{0, 0, 0, 6}};

#declare TypeIndices = array[84]{8, 7, 6, 4, 6, 7, 8, 7, 5, 3, 3, 5, 7, 6, 3, 1, 3, 6, 4, 3, 3, 4, 6, 5, 6, 7, 7, 8, 7, 5, 3, 3, 5, 7, 5, 2, 0, 2, 5, 3, 0, 0, 3, 3, 2, 3, 5, 5, 7, 6, 3, 1, 3, 6, 3, 0, 0, 3, 1, 0, 1, 3, 3, 6, 4, 3, 3, 4, 3, 2, 3, 3, 3, 4, 6, 5, 6, 5, 5, 6, 7, 7, 7, 8};

#declare TypeColors = array[9]{
    White,

    srgb<255,215,0>/255,    // yellow
    srgb<255,165,0>/255,    // orange

    rgb .07,  // black

    Red,
    srgb<228,196,161>/255,  // light brown

    srgb<165,104,42>/255,   // dark brown
    srgb<178,204,178>/255,  // light green
    srgb<56,180,56>/255     // dark green
}

#declare TypeTextColors = array[9]{ Black,  Black, Black,  White,  Black, Black,  Black, Black, Black }

#declare TetrahedronPoints = array[4]{ <-3, -3, -3>, <-3, 3, 3>, <3, -3, 3>, <3, 3, -3> }
#declare TetrahedronEdges = array[6]{array[2]{0, 2}, array[2]{1, 3}, array[2]{1, 2}, array[2]{0, 1}, array[2]{2, 3}, array[2]{0, 3}};

#declare OctahedronPoints = array[6]{ <-3, 0, 0>, <0, -3, 0>, <0, 0, -3>, <0, 0, 3>, <0, 3, 0>, <3, 0, 0> }
#declare OctahedronEdges = array[12]{array[2]{1, 5}, array[2]{1, 3}, array[2]{3, 5}, array[2]{4, 5}, array[2]{0, 1}, array[2]{1, 2}, array[2]{0, 4}, array[2]{3, 4}, array[2]{0, 2}, array[2]{2, 5}, array[2]{2, 4}, array[2]{0, 3}};

#declare PermutohedronPoints = array[24]{ <-2,-1,0>, <-2,0,-1>, <-2,0,1>, <-2,1,0>, <-1,-2,0>, <-1,0,-2>, <-1,0,2>, <-1,2,0>, <0,-2,-1>, <0,-2,1>, <0,-1,-2>, <0,-1,2>, <0,1,-2>, <0,1,2>, <0,2,-1>, <0,2,1>, <1,-2,0>, <1,0,-2>, <1,0,2>, <1,2,0>, <2,-1,0>, <2,0,-1>, <2,0,1>, <2,1,0>, }
#declare PermutohedronEdges = array[36]{array[2]{0, 4}, array[2]{9, 11}, array[2]{18, 22}, array[2]{17, 21}, array[2]{3, 7}, array[2]{1, 5}, array[2]{12, 14}, array[2]{19, 23}, array[2]{8, 10}, array[2]{13, 15}, array[2]{2, 6}, array[2]{16, 20}, array[2]{7, 14}, array[2]{12, 17}, array[2]{4, 9}, array[2]{21, 23}, array[2]{5, 12}, array[2]{10, 17}, array[2]{20, 21}, array[2]{20, 22}, array[2]{0, 1}, array[2]{2, 3}, array[2]{15, 19}, array[2]{0, 2}, array[2]{7, 15}, array[2]{22, 23}, array[2]{1, 3}, array[2]{13, 18}, array[2]{6, 11}, array[2]{9, 16}, array[2]{8, 16}, array[2]{11, 18}, array[2]{4, 8}, array[2]{5, 10}, array[2]{6, 13}, array[2]{14, 19}};
#declare PermutohedronFaces = array[14]{ array[5]{7, 15, 19, 14, 7}, array[5]{22, 23, 21, 20, 22}, array[5]{4, 8, 16, 9, 4}, array[5]{5, 12, 17, 10, 5}, array[5]{1, 0, 2, 3, 1}, array[5]{6, 11, 18, 13, 6}, array[7]{13, 15, 7, 3, 2, 6, 13}, array[7]{4, 8, 10, 5, 1, 0, 4}, array[7]{17, 12, 14, 19, 23, 21, 17}, array[7]{15, 19, 23, 22, 18, 13, 15}, array[7]{2, 6, 11, 9, 4, 0, 2}, array[7]{5, 1, 3, 7, 14, 12, 5}, array[7]{16, 8, 10, 17, 21, 20, 16}, array[7]{11, 9, 16, 20, 22, 18, 11} };

#declare TruncTetraPoints = array[12]{ <-3,-1,-1>, <-3,1,1>, <-1,-3,-1>, <-1,-1,-3>, <-1,1,3>, <-1,3,1>, <1,-3,1>, <1,-1,3>, <1,1,-3>, <1,3,-1>, <3,-1,1>, <3,1,-1>, }
#declare TruncTetraEdges = array[18]{array[2]{5, 9}, array[2]{4, 7}, array[2]{3, 8}, array[2]{0, 1}, array[2]{10, 11}, array[2]{2, 6}, array[2]{1, 5}, array[2]{6, 7}, array[2]{4, 5}, array[2]{1, 4}, array[2]{7, 10}, array[2]{2, 3}, array[2]{6, 10}, array[2]{0, 3}, array[2]{8, 11}, array[2]{9, 11}, array[2]{0, 2}, array[2]{8, 9}};

union{

    // vertices
    #for( Index, 0, 83 )
        #declare TypeColor = TypeColors[TypeIndices[Index]];
        sphere{
            Points[Index], VertexRadius
            pigment{color TypeColor}
        }
    #end


    // edges
    union{
        #for( Index, 0, 5 )
            #local EdgeArray = TetrahedronEdges[Index];
            cylinder{ TetrahedronPoints[EdgeArray[0]], TetrahedronPoints[EdgeArray[1]], .03 }
        #end
        pigment{color srgbt<56,180,56,80>/255}
    }

    union{
        #for( Index, 0, 11 )
            #local EdgeArray = OctahedronEdges[Index];
            cylinder{ OctahedronPoints[EdgeArray[0]], OctahedronPoints[EdgeArray[1]], .03 }
        #end
        pigment{color srgbt<255,0,0,80>/255}
    }

    union{
        #for( Index, 0, 11 )
            #local EdgeArray = OctahedronEdges[Index];
            cylinder{ OctahedronPoints[EdgeArray[0]]/3, OctahedronPoints[EdgeArray[1]]/3, .02 }
        #end
        pigment{color White}
    }

    union{
        #for( Index, 0, 35 )
            #local EdgeArray = PermutohedronEdges[Index];
            cylinder{ PermutohedronPoints[EdgeArray[0]], PermutohedronPoints[EdgeArray[1]], .04 }
        #end
        pigment{color rgb .07}
    }

	#if (ShowBrownEdges)
		union{
		    #for( Index, 0, 17 )
		        #local EdgeArray = TruncTetraEdges[Index];
		        cylinder{ TruncTetraPoints[EdgeArray[0]], TruncTetraPoints[EdgeArray[1]], .04 }
		    #end
		    pigment{color srgb<165,104,42>/255}
		}
	#end

    // faces
    union{
        #for( Index, 0, 13 )
            #local FaceArray = PermutohedronFaces[Index];
            #local LenOfFaceArray = dimension_size(FaceArray, 1);
            polygon{ LenOfFaceArray,
                #for(VertexIndexInFace, 0, LenOfFaceArray-1)
                    PermutohedronPoints[FaceArray[VertexIndexInFace]]
                #end
            }
        #end
        pigment{color rgbt<1, 1, 1, .75>}
    }


    // text
    #for( PointIndex, 0, 83 )
        #for( DigitIndex, 0, 3 )
			#declare DigitInt = Coordinates[PointIndex][DigitIndex] + PermOneBased;
            union{
                #declare Text = text {
                    ttf "/usr/share/fonts/truetype/msttcorefonts/Arial_Bold.ttf",
                    str(DigitInt, 0, 0) ,  0.075, 0
                    scale TextScale  translate TextTranslate
                    translate DigitIndex * .07 * x
                }
                object{
                    Text
                    translate -x * ( max_extent(Text).x - min_extent(Text).x ) / 2
                    pigment{color TypeTextColors[TypeIndices[PointIndex]]}
                }
                rotate 10 * x
                rotate 9 * y
                translate Points[PointIndex]
            }
        #end
    #end

    rotate -1 * z

}
