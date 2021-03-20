#include "colors.inc"

#version 3.6;  // needed for "+ua +fn" to work
global_settings { assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 conserve_energy}}


/////////////////// camera and light

#declare Camera_Position = vnormalize(<9, 25, -40>) * 12.7;

camera{
    location Camera_Position
    right    x*image_width/image_height
    angle    20
    look_at  <0, -.16, 0>
}


light_source{ <-400, 500, -300>*.3 color White shadowless}

light_source{ Camera_Position  color rgb<0.9,0.9,1>*0.1 shadowless}
sky_sphere{ pigment{ White } }


/////////////////// variables and objects

#declare BR = 1.5;   // big torus radius
#declare SR = .6;    // small torus radius
#declare ER = .017;  // edge radius


#declare ColorT = pigment{color rgbt<1, 1, 1, .25>}    // transparent white
#declare ColorI = pigment{color rgbt<1, 1, 1, 1>}      // invisible

#declare ColorR = pigment{color srgb <219,0,0>/255}    // DB0000 red
#declare ColorG = pigment{color srgb <0,211,0>/255}    // 00D300 green
#declare ColorB = pigment{color srgb <0,48,255>/255}   // 0030FF blue
#declare ColorY = pigment{color srgb <255,158,0>/255}  // FF9E00 yellow

#declare ValueT = 20;
#declare ColorTR = pigment{color srgbt <219,0,0,ValueT>/255}
#declare ColorTG = pigment{color srgbt <0,211,0,ValueT>/255}
#declare ColorTB = pigment{color srgbt <0,48,255,ValueT>/255}
#declare ColorTY = pigment{color srgbt <255,158,0,ValueT>/255}


#declare RawTorus = torus{BR, SR}
#declare WhiteTorus = object{
    RawTorus
    pigment{ColorT}
}

#declare VerticalEdge = torus{
    SR, ER
    rotate 90*x
    translate BR*x
}
#declare VerticalEdgePair = union{
    object{VerticalEdge}
    object{VerticalEdge  rotate 180*y}
}
#declare GreenEdgePair = object{
    VerticalEdgePair
    pigment{ColorG}
}
#declare RedEdgePair = object{
    VerticalEdgePair
    rotate 90*y
    pigment{ColorR}
}

#declare BlueEdgePair = union{
    torus{BR-SR, ER}
    torus{BR+SR, ER}
    pigment{ColorB}
}

#declare YellowEdgeRaw = torus{BR, ER  pigment{ColorY}}
#declare YellowEdgePair = union{
    object{YellowEdgeRaw  translate SR*y}
    object{YellowEdgeRaw  translate -SR*y}
}


/////////////////// half colored tori

#declare Cuts = array[4]{
    plane{-x, 0  pigment{ColorI}},
    plane{-z, 0  pigment{ColorI}},
    plane{-y, 0  pigment{ColorI}},
    cylinder{-5*y, 5*y, BR  pigment{ColorI}}
}

#declare Colors = array[4]{ColorTR, ColorTG, ColorTB, ColorTY}

#macro ColoredTorus(Index)
    #local Cut = Cuts[Index];
    #local Color = Colors[Index];
    intersection{
        object{WhiteTorus}
        object{Cut inverse}
    }
    intersection{
        object{RawTorus}
        object{Cut}
        pigment{Color}
    }
#end


/////////////////// show objects

ColoredTorus(3)
//object{WhiteTorus}

object{RedEdgePair}
object{GreenEdgePair}
object{BlueEdgePair}
object{YellowEdgePair}

/*
povray torus.pov +ua +fn +W1000 +H670
povray torus.pov +ua +fn +W4000 +H2680 -D
*/
