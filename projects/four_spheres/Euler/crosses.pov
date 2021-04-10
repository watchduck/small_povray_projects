// https://commons.wikimedia.org/wiki/Category:Studies_of_Euler_diagrams;_4-ary_22527;_crosses

#include "colors.inc"
#include "math.inc"

#version 3.6;  // needed for "+ua +fn" to work
global_settings { assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 conserve_energy}}

#declare Camera_Position = vnormalize(<10, 6, -40>) * 16.5;

camera{
    orthographic
    location Camera_Position
    right    x*image_width/image_height
    angle    29
    look_at  <-.7, .07, 0>
}


light_source{ <-400, 500, -300>*.3 color White shadowless}

light_source{ Camera_Position  color rgb<0.9,0.9,1>*0.1 shadowless}
sky_sphere{ pigment{ White } }

/////////////////////////////

#declare Invisible = pigment{color rgbt 1};
#declare LightTransGray = pigment{color rgbt <.9, .9, .9, .8>};
#declare DarkTransGray = pigment{color rgbt .6};
#declare SolidGray = pigment{color srgb .9};

#declare Case = "cells";  // "overview" or "cells"
#if (Case = "overview")
    #declare Trans = 100;
    #declare CutColor = Invisible;
#end
#if (Case = "cells")
    #declare Trans = 10;
    #declare CutColor = DarkTransGray;
#end

#declare Colors = array[4]{
    pigment{color srgbt <219,0,0,Trans>/255}
    pigment{color srgbt <0,211,0,Trans>/255}
    pigment{color srgbt <0,48,255,Trans>/255}
    pigment{color srgbt <255,158,0,Trans>/255}
}

#declare Midpoint0 = <-sqrt(3), 0, 0>;
#declare Midpoint1 = <0, 1, 0>;
#declare Midpoint2 = <0, -1, 0>;
#declare Midpoint3 = <sqrt(3), 0, 0>;

#declare AxisRad = .02;

///////////////////////////// text

#declare TextScale = .35;
#declare TextDepth = .075;
#declare FontPath = "/usr/share/fonts/truetype/msttcorefonts/Arial.ttf";
#declare TextObjects = array[13]{
    text{ ttf FontPath, str(9, 0, 0), TextDepth, 0   scale TextScale  translate -1.4*x }
    text{ ttf FontPath, str(0, 0, 0), TextDepth, 0   scale TextScale  translate 1.4*x }

    text{ ttf FontPath, str(6, 0, 0), TextDepth, 0   scale TextScale  translate 4.6*x }
    text{ ttf FontPath, str(7, 0, 0), TextDepth, 0   scale TextScale  translate 4.6*x  translate -2*y }
    text{ ttf FontPath, str(14, 0, 0), TextDepth, 0   scale TextScale  translate 4.6*x  translate 2*y }

    text{ ttf FontPath, str(1, 0, 0), TextDepth, 0   scale TextScale  translate -2*y }
    text{ ttf FontPath, str(8, 0, 0), TextDepth, 0   scale TextScale  translate 2*y }

    text{ ttf FontPath, str(2, 0, 0), TextDepth, 0   scale TextScale  translate 3*x  translate -2*z }
    text{ ttf FontPath, str(3, 0, 0), TextDepth, 0   scale TextScale  translate 3*x  translate -2*z  translate -2*y }
    text{ ttf FontPath, str(10, 0, 0), TextDepth, 0   scale TextScale  translate 3*x  translate -2*z  translate 2*y }

    text{ ttf FontPath, str(4, 0, 0), TextDepth, 0   scale TextScale  translate 3*x  translate 2*z }
    text{ ttf FontPath, str(5, 0, 0), TextDepth, 0   scale TextScale  translate 3*x  translate 2*z  translate -2*y }
    text{ ttf FontPath, str(12, 0, 0), TextDepth, 0   scale TextScale  translate 3*x  translate 2*z  translate 2*y }
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
    pigment{color srgb .5}
}

///////////////////////////// axes

// straight
#declare DefaultStraightAxis = cylinder{99*z, -99*z, AxisRad}
#declare StraightAxes = union{
    object{DefaultStraightAxis   rotate 90*z}
    object{DefaultStraightAxis   translate 3*x   rotate 90*x}
}

// wave
#declare RingSegment = intersection{
    torus{ 2, AxisRad   rotate 90*x   translate <-1, sqrt(3), 0>}
    plane{-x, 0}
    plane{y, sqrt(3)}
}
#declare HalfWaveAxis = union{
    object{RingSegment}
    cylinder{<1, sqrt(3), 0>, <1, 99, 0>, AxisRad}
}
#declare DefaultWaveAxis = union{
    object{HalfWaveAxis}
    object{HalfWaveAxis   rotate 180*z}
    rotate 90*x
}
#declare WaveAxes = union{
    object{DefaultWaveAxis   translate 3*x   translate y}
    object{DefaultWaveAxis   scale -x   translate 3*x   translate y}
    object{DefaultWaveAxis   translate 3*x   translate -y}
    object{DefaultWaveAxis   scale -x   translate 3*x   translate -y}
}

// combined
#declare Axes = union{
    object{StraightAxes}
    object{WaveAxes}
    sphere{<3, 1, 0>, .07}
    sphere{<3, -1, 0>, .07}
    pigment{SolidGray}
}

///////////////////////////// planes

// default
#declare QuarterSpace = intersection{
    plane{x, 0}
    plane{-y, 0}
}
#declare QuarterSpaces = merge{
    object{QuarterSpace}
    object{QuarterSpace  translate <1, sqrt(3), 0>}
}
#declare Corner = merge{
    object{QuarterSpaces}
    cylinder{<-1, sqrt(3), 99>, <-1, sqrt(3), -99>, 2}
}
#declare DefaultPlane = merge{
    object{Corner}
    difference{
        plane{x, 0}
        object{Corner  rotate 180*z}
    }
}

// array
#declare PlanesArray = array[4]{
    object{
        DefaultPlane
        rotate 90*z
    }
    object{
        DefaultPlane  inverse
        translate 3*x  rotate 90*x
    }
    object{
        DefaultPlane
        scale -x  translate 3*x  rotate 90*x
    }
    object{
        DefaultPlane
        scale -x  rotate 90*z
    }
}

// macro
#macro PlaneMacro(Index, Colored)
    #if (Colored)
        #local Color = Colors[Index];
    #else
        #local Color = LightTransGray;
    #end
    object{ PlanesArray[Index]  pigment{Color} }
#end

// unions
#declare GrayPlanes = union{
    PlaneMacro(0, 0)
    PlaneMacro(1, 0)
    PlaneMacro(2, 0)
    PlaneMacro(3, 0)
}
#declare ColoredPlanes = intersection{
    object{PlaneMacro(0, 1) }
    object{PlaneMacro(1, 1) inverse}
    object{PlaneMacro(2, 1) inverse}
    object{PlaneMacro(3, 1) }
}

/////////////////////////////

#declare CutBoxA = box{<-2.5,-3,-3>, <5,3,3>}
#declare CutBoxB = box{<-2.501,-3.001,-3.001>, <5.001,3.001,3.001>}
#declare CutBoxC = box{<-2.502,-3.002,-3.002>, <5.002,3.002,3.002>}

union{

    intersection{
        object{GrayPlanes}
        object{CutBoxA  pigment{Invisible}}
    }

    intersection{
        object{ColoredPlanes}
        object{CutBoxB  pigment{CutColor}}
    }

    intersection{
        object{Axes}
        object{CutBoxC  pigment{SolidGray}}
    }

    //object{Text}

    rotate -24.5*y
    translate -2*x

}


/*
povray crosses.pov +ua +fn +W1000 +H830
povray crosses.pov +ua +fn +W4000 +H3320 -D
*/

