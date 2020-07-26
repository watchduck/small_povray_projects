#version 3.6;
global_settings { assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 conserve_energy}}

#include "colors.inc"


// https://commons.wikimedia.org/wiki/File:Permutohedron_in_simplex_of_order_3_(plain).png


////////////////////// camera and light

#declare Camera_Position = <12, 12, -50>;
camera{
    location Camera_Position
    right    x*image_width/image_height
    angle    7.5
    look_at  <.4, .4, -0.07>
}


light_source{ <-400, 500, -300> color White*0.9 shadowless}

light_source{ Camera_Position  color rgb<0.9,0.9,1>*0.1 shadowless}
sky_sphere{ pigment{ White } }


////////////////////// hexagon

#declare HexP0 = <0,1,2>;
#declare HexP1 = <1,0,2>;
#declare HexP2 = <0,2,1>;
#declare HexP3 = <2,0,1>;
#declare HexP4 = <1,2,0>;
#declare HexP5 = <2,1,0>;

#declare Hexagon = union{
    union{
        sphere{HexP0, 0.1}
        sphere{HexP1, 0.1}
        sphere{HexP2, 0.1}
        sphere{HexP3, 0.1}
        sphere{HexP4, 0.1}
        sphere{HexP5, 0.1}
        cylinder{HexP0, HexP1, 0.03}
        cylinder{HexP1, HexP3, 0.03}
        cylinder{HexP3, HexP5, 0.03}
        cylinder{HexP5, HexP4, 0.03}
        cylinder{HexP4, HexP2, 0.03}
        cylinder{HexP2, HexP0, 0.03}
        pigment{color rgb .05}
    }

    polygon{
        6, HexP0, HexP1, HexP3, HexP5, HexP4, HexP2
        pigment{color rgbt<0.5,0.5,0.5,0.5>}
    }
}


////////////////////// cube

#declare CubeP0 = <0,0,0>;
#declare CubeP1 = <2,0,0>;
#declare CubeP2 = <0,2,0>;
#declare CubeP3 = <2,2,0>;
#declare CubeP4 = <0,0,2>;
#declare CubeP5 = <2,0,2>;
#declare CubeP6 = <0,2,2>;
#declare CubeP7 = <2,2,2>;

#declare Cube = union{
    sphere{CubeP0, 0.1}
    sphere{CubeP1, 0.1}
    sphere{CubeP2, 0.1}
    sphere{CubeP3, 0.1}
    sphere{CubeP4, 0.1}
    sphere{CubeP5, 0.1}
    sphere{CubeP6, 0.1}
    sphere{CubeP7, 0.1}
    cylinder{CubeP0, CubeP1, 0.02}
    cylinder{CubeP2, CubeP3, 0.02}
    cylinder{CubeP4, CubeP5, 0.02}
    cylinder{CubeP6, CubeP7, 0.02}
    cylinder{CubeP0, CubeP2, 0.02}
    cylinder{CubeP1, CubeP3, 0.02}
    cylinder{CubeP4, CubeP6, 0.02}
    cylinder{CubeP5, CubeP7, 0.02}
    cylinder{CubeP0, CubeP4, 0.02}
    cylinder{CubeP1, CubeP5, 0.02}
    cylinder{CubeP2, CubeP6, 0.02}
    cylinder{CubeP3, CubeP7, 0.02}
    pigment{color rgb<0.8,0.8,0.8>}
}


////////////////////// triangle

#declare Triangle = union{
    sphere{
        <1,1,1>, 0.1
        pigment{color srgb<255,165,0>/255}
    }

    union{
        sphere{<3,0,0>, 0.1}
        sphere{<0,3,0>, 0.1}
        sphere{<0,0,3>, 0.1}
        pigment{color Red}
    }

    union{
        cylinder{<3,0,0>, <0,3,0>, 0.02}
        cylinder{<0,3,0>, <0,0,3>, 0.02}
        cylinder{<0,0,3>, <3,0,0>, 0.02}
        pigment{color srgbt<255,0,0,80>/255}
    }
}


////////////////////// adaptions, e.g. change to right-hand coordinate system

union{
    object{Hexagon}
    object{Cube}
    object{Triangle}
    translate <-1,-1,-1>
    scale -1*y
    rotate -90*x
    scale 1.7
}
