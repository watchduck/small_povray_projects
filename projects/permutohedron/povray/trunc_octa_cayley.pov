#version 3.6;
global_settings { assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 conserve_energy}}

#include "colors.inc"


// povray trunc_octa_cayley.pov +W3900 +H4000 +ua +fn
// https://commons.wikimedia.org/wiki/File:Symmetric_group_4;_Cayley_graph_1,2,6_(0-based).png


////////////////////// camera and light

#declare Camera_Position = <-7.5, 15, -40> * 0.54;
camera{
    location Camera_Position
    right    x*image_width/image_height
    angle    11.7
    look_at  <.05, -.02, 0>
}


light_source{ <-400, 500, -300>*.3 color White shadowless}

light_source{ Camera_Position  color rgb<0.9,0.9,1>*0.1 shadowless}
sky_sphere{ pigment{ White } }


// variables

#declare VertexRadius = .18;
#declare TextTranslate = <-.12, .007, -VertexRadius>;
#declare TextScale = .13;

#declare Points = array[24]{ <-2, -1, 0>, <-2, 0, -1>, <-2, 0, 1>, <-2, 1, 0>, <-1, -2, 0>, <-1, 0, -2>, <-1, 0, 2>, <-1, 2, 0>, <0, -2, -1>, <0, -2, 1>, <0, -1, -2>, <0, -1, 2>, <0, 1, -2>, <0, 1, 2>, <0, 2, -1>, <0, 2, 1>, <1, -2, 0>, <1, 0, -2>, <1, 0, 2>, <1, 2, 0>, <2, -1, 0>, <2, 0, -1>, <2, 0, 1>, <2, 1, 0> }

#declare Coordinates = array[24]{array[4]{1, 2, 0, 3}, array[4]{2, 1, 0, 3}, array[4]{1, 2, 3, 0}, array[4]{2, 1, 3, 0}, array[4]{1, 0, 2, 3}, array[4]{2, 0, 1, 3}, array[4]{1, 3, 2, 0}, array[4]{2, 3, 1, 0}, array[4]{0, 1, 2, 3}, array[4]{1, 0, 3, 2}, array[4]{0, 2, 1, 3}, array[4]{1, 3, 0, 2}, array[4]{2, 0, 3, 1}, array[4]{3, 1, 2, 0}, array[4]{2, 3, 0, 1}, array[4]{3, 2, 1, 0}, array[4]{0, 1, 3, 2}, array[4]{0, 2, 3, 1}, array[4]{3, 1, 0, 2}, array[4]{3, 2, 0, 1}, array[4]{0, 3, 1, 2}, array[4]{0, 3, 2, 1}, array[4]{3, 0, 1, 2}, array[4]{3, 0, 2, 1}}

#declare Faces = array[14]{ array[5]{7, 15, 19, 14, 7}, array[5]{22, 23, 21, 20, 22}, array[5]{4, 8, 16, 9, 4}, array[5]{5, 12, 17, 10, 5}, array[5]{1, 0, 2, 3, 1}, array[5]{6, 11, 18, 13, 6}, array[7]{13, 15, 7, 3, 2, 6, 13}, array[7]{4, 8, 10, 5, 1, 0, 4}, array[7]{17, 12, 14, 19, 23, 21, 17}, array[7]{15, 19, 23, 22, 18, 13, 15}, array[7]{2, 6, 11, 9, 4, 0, 2}, array[7]{5, 1, 3, 7, 14, 12, 5}, array[7]{16, 8, 10, 17, 21, 20, 16}, array[7]{11, 9, 16, 20, 22, 18, 11} };

#declare GreenEdges = array[12]{array[2]{0, 4}, array[2]{9, 11}, array[2]{18, 22}, array[2]{17, 21}, array[2]{3, 7}, array[2]{1, 5}, array[2]{12, 14}, array[2]{19, 23}, array[2]{8, 10}, array[2]{13, 15}, array[2]{2, 6}, array[2]{16, 20}};
#declare BlueEdges = array[12]{array[2]{8, 4}, array[2]{16, 9}, array[2]{7, 15}, array[2]{14, 19}, array[2]{0, 1}, array[2]{2, 3}, array[2]{20, 22}, array[2]{21, 23}, array[2]{10, 5}, array[2]{17, 12}, array[2]{11, 18}, array[2]{6, 13}};

union{

    // vertices
    #for( PointIndex, 0, 23 )
        sphere{
            Points[PointIndex], VertexRadius
            pigment{color rgb .07}
        }
        union{
            #for( DigitIndex, 0, 3 )
                #declare Text = text {
                    ttf "/usr/share/fonts/truetype/msttcorefonts/Arial_Bold.ttf",
                    str(Coordinates[PointIndex][DigitIndex], 0, 0) ,  0.075, 0
                    scale TextScale  translate TextTranslate
                    translate DigitIndex * .075 * x
                }
                object{
                    Text
                    translate -x * ( max_extent(Text).x - min_extent(Text).x ) / 2
                    pigment{color White}
                }
            #end
            rotate 10 * x
            rotate 8 * y
            translate Points[PointIndex]
        }
    #end


    // faces
    union{
        #for( Index, 0, 13 )
            #local FaceArray = Faces[Index];
            #local LenOfFaceArray = dimension_size(FaceArray, 1);
            polygon{ LenOfFaceArray,
                #for(VertexIndexInFace, 0, LenOfFaceArray-1)
                    Points[FaceArray[VertexIndexInFace]]
                #end
            }
        #end
        pigment{color rgbt<1, 1, 1, .75>}
    }


    // edges
    union{
        #for( Index, 0, 11 )
            #local EdgeArray = GreenEdges[Index];
            cylinder{ Points[EdgeArray[0]], Points[EdgeArray[1]], .04 }
        #end
        pigment{color srgb<0,229,0>/255}   // green
    }

    #declare BlueEdgesUnion = union{
        #for( Index, 0, 11 )
            #local EdgeArray = BlueEdges[Index];
            cylinder{ Points[EdgeArray[0]], Points[EdgeArray[1]], .04 }
        #end
    }

    object{ BlueEdgesUnion   pigment{color srgb<0,0,255>/255} }   // blue
    object{ BlueEdgesUnion   scale -x   pigment{color srgb<255,0,0>/255} }   // red

    rotate -1 * z

}
