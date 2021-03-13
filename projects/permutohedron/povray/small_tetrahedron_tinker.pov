#version 3.6;
global_settings { assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 conserve_energy}}

#include "colors.inc"


/*
povray small_tetrahedron.pov +W3000 +H3000 +ua +fn

cropped with
267 144
2631 2859
*/


////////////////////// camera and light

#declare Camera_Position = <-7.5, 15, -40> * 0.33;
camera{
    location Camera_Position
    right    x*image_width/image_height
    angle    13
    look_at  <0, 0, 0>
}


light_source{ <-400, 500, -300>*.3 color White shadowless}

light_source{ Camera_Position  color rgb<0.9,0.9,1>*0.1 shadowless}
sky_sphere{ pigment{ White } }


// variables

#declare VertexRadius = .18;
#declare EdgeRadius = .05;


#declare Points = array[4]{ <-1,-1,-1>, <-1,1,1>, <1,-1,1>, <1,1,-1> }


union{

    union{
        #for( Index, 0, 3 )
            sphere{ Points[Index], .2 }
        #end
        pigment{color rgb .07}
    }

    cylinder{ Points[0], Points[1], EdgeRadius   pigment{color srgb<234,171,55>/255} }   // orange
    cylinder{ Points[2], Points[3], EdgeRadius   pigment{color srgb<0,229,0>/255} }      // green
    cylinder{ Points[1], Points[3], EdgeRadius   pigment{color srgb<0,0,255>/255} }   // blue
    cylinder{ Points[0], Points[2], EdgeRadius   pigment{color srgb<255,0,0>/255} }   // red
    cylinder{ Points[0], Points[3], EdgeRadius   pigment{color srgb<255,156,255>/255} }   // light red
    cylinder{ Points[1], Points[2], EdgeRadius   pigment{color srgb<170,247,245>/255} }   // light blue

    sphere{ <-1,0,0>, VertexRadius*.7   pigment{color srgb<234,171,55>/255} }   // orange
    sphere{ <1,0,0>,  VertexRadius*.7   pigment{color srgb<0,229,0>/255} }      // green
    sphere{ <0,1,0>,  VertexRadius*.7   pigment{color srgb<0,0,255>/255} }   // blue
    sphere{ <0,-1,0>, VertexRadius*.7   pigment{color srgb<255,0,0>/255} }   // red
    sphere{ <0,0,-1>, VertexRadius*.7   pigment{color srgb<255,156,255>/255} }   // light red
    sphere{ <0,0,1>,  VertexRadius*.7   pigment{color srgb<170,247,245>/255} }   // light blue
	
	sphere{ <0,0,0>,  VertexRadius*.3   pigment{color rgb .95} }   // white center

    rotate -1 * z

	scale <-1, -1, -1>

}

