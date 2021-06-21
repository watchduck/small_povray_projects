// https://commons.wikimedia.org/wiki/File:EuDi;_batch_2;_4_Euler_planes.png

#include "colors.inc"
#include "math.inc"

#include "LongCylinder.inc"


#version 3.6;  // needed for "+ua +fn" to work
global_settings { assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 conserve_energy}}

#declare Camera_Position = vnormalize(<9, 8, -40>) * 16.5;

camera{
    orthographic
    location Camera_Position
    right    x*image_width/image_height
    angle    25
    look_at  0
}


light_source{ <-400, 500, -300>*.2 color White shadowless}

light_source{ Camera_Position  color rgb<0.9,0.9,1>*.8 shadowless}
sky_sphere{ pigment{ White } }

/////////////////////////////

#declare Invisible = pigment{color rgbt 1};
#declare SolidGray = pigment{color srgb .9};

#declare Trans = 100;
#declare Trans0 = pigment{color srgbt <219,0,0,Trans>/255}
#declare Trans1 = pigment{color srgbt <0,211,0,Trans>/255}
#declare Trans2 = pigment{color srgbt <0,48,255,Trans>/255}
#declare Trans3 = pigment{color srgbt <255,158,0,Trans>/255}

///////////////////////////// text

#declare TextScale = .35;
#declare TextDepth = .075;
#declare FontPath = "/usr/share/fonts/truetype/msttcorefonts/Arial.ttf";
#declare TextObjects = array[12]{
    text{ ttf FontPath, str(0, 0, 0), TextDepth, 0   scale TextScale  translate -1.5*y translate -.9*z }
    text{ ttf FontPath, str(1, 0, 0), TextDepth, 0   scale TextScale  translate -1.5*y translate -.9*z translate -2*x}
    text{ ttf FontPath, str(8, 0, 0), TextDepth, 0   scale TextScale  translate -1.5*y translate -.9*z translate 2*x}

    text{ ttf FontPath, str(2, 0, 0), TextDepth, 0   scale TextScale  translate 1.5*y translate -.9*z }
    text{ ttf FontPath, str(3, 0, 0), TextDepth, 0   scale TextScale  translate 1.5*y translate -.9*z  translate -2*x}
    text{ ttf FontPath, str(10, 0, 0), TextDepth, 0   scale TextScale  translate 1.5*y translate -.9*z translate 2*x}

    text{ ttf FontPath, str(4, 0, 0), TextDepth, 0   scale TextScale  translate -1.5*y translate .9*z }
    text{ ttf FontPath, str(5, 0, 0), TextDepth, 0   scale TextScale  translate -1.5*y translate .9*z  translate -2*x}
    text{ ttf FontPath, str(12, 0, 0), TextDepth, 0   scale TextScale  translate -1.5*y translate .9*z translate 2*x}

    text{ ttf FontPath, str(6, 0, 0), TextDepth, 0   scale TextScale  translate 1.5*y translate .9*z }
    text{ ttf FontPath, str(7, 0, 0), TextDepth, 0   scale TextScale  translate 1.5*y translate .9*z  translate -2*x}
    text{ ttf FontPath, str(14, 0, 0), TextDepth, 0   scale TextScale  translate 1.5*y translate .9*z translate 2*x}
}

#declare Text = union{
    #for( Index, 0, dimension_size(TextObjects, 1) - 1 )
        #local TextObject = TextObjects[Index];
        object{
            TextObject
            translate -x * ( max_extent(TextObject).x - min_extent(TextObject).x ) / 2
            
        }
    #end
    translate -.13*y
    pigment{color srgb .3}
}

///////////////////////////// axes

#declare DefaultAxis = object{
    LongCylinder(x, -x, .02)
    pigment{color srgb .9}
}
#declare DefaultVertex = object{
    sphere{0, .07}
    pigment{color srgb .9}
}
#declare Axes = union{
    object{DefaultAxis}
    union{
        object{ DefaultAxis  rotate 90*z}
        object{ DefaultAxis  rotate 90*y}
        object{ DefaultVertex }
        translate -x
    }
    union{
        object{ DefaultAxis  rotate 90*z}
        object{ DefaultAxis  rotate 90*y}
        object{ DefaultVertex }
        translate x
    }
}

///////////////////////////// planes

#declare Planes = union{
    plane{ x, 0  pigment{Trans0} translate -x }
    plane{ y, 0  pigment{Trans1} }
    plane{ z, 0  pigment{Trans2} }
    plane{ x, 0  pigment{Trans3} translate x }
}

///////////////////////////// show

intersection{
    object{Planes}
    box{3*<-1, -1, -1>, 3*<1, 1, 1>  pigment{Invisible} }
}

intersection{
    object{Axes}
    box{3*<-1.001, -1.001, -1.001>, 3*<1.001, 1.001, 1.001>  pigment{SolidGray} }
}

object{Text}


/*
povray planes.pov +ua +fn +W1000 +H990
povray planes.pov +ua +fn +W4000 +H3960 -D
*/
