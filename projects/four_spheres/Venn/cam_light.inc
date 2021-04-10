#include "colors.inc"
#include "cases.inc"

#version 3.6;  // needed for "+ua +fn" to work
global_settings { assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 conserve_energy}}


camera{
    location Camera_Position
    right    x*image_width/image_height
    angle    20
    look_at  LookAt
}


light_source{ <-400, 500, -300>*.3 color White shadowless}

light_source{ Camera_Position  color rgb<0.9,0.9,1>*0.1 shadowless}
sky_sphere{ pigment{ White } }

