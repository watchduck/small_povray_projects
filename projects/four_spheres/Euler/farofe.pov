// https://commons.wikimedia.org/wiki/File:EuDi;_farofe.png

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
    angle    36.5
    look_at  <-0.26, -.22, 0>
}


light_source{ <-400, 500, -300>*.3 color White shadowless}

light_source{ Camera_Position  color rgb<0.9,0.9,1>*0.1 shadowless}
sky_sphere{ pigment{ White } }

///////////////////////////// variables

#declare Invisible = pigment{color rgbt 1};
#declare LightTransGray = pigment{color rgbt <.9, .9, .9, .8>};
#declare DarkTransGray = pigment{color rgbt .6};
#declare SolidGray = pigment{color srgb .9};

#declare CaseCells = 0;  // single cells (requires adjusting 'inverse' in ColoredPlanes)
#if (CaseCells)
    #declare Trans = 10;
    #declare CutColor = DarkTransGray;
#else
    #declare Trans = 100;
    #declare CutColor = Invisible;
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

#declare AngleOffset = sqrt(3);

///////////////////////////// text

#declare TextScale = .45;
#declare TextDepth = .075;
#declare FontPath = "/usr/share/fonts/truetype/msttcorefonts/Arial.ttf";
#declare TextObjects = array[12]{
    text{ ttf FontPath, str(0, 0, 0), TextDepth, 0   scale TextScale  translate <-3.25, 0, -.1> }
    text{ ttf FontPath, str(4, 0, 0), TextDepth, 0   scale TextScale  translate <-3.25, 2, -.1> }
    text{ ttf FontPath, str(6, 0, 0), TextDepth, 0   scale TextScale  translate <-3.25, 4, -.1> }

    text{ ttf FontPath, str(1, 0, 0), TextDepth, 0   scale TextScale  translate <-5.65, -2, -.1> }
    text{ ttf FontPath, str(5, 0, 0), TextDepth, 0   scale TextScale  translate <-5.65, 2, -.1> }
    text{ ttf FontPath, str(7, 0, 0), TextDepth, 0   scale TextScale  translate <-5.65, 4, -.1> }

    text{ ttf FontPath, str( 9, 0, 0), TextDepth, 0   scale TextScale  translate <1, -2, -2> }
    text{ ttf FontPath, str( 8, 0, 0), TextDepth, 0   scale TextScale  translate <1, 0, -2> }
    text{ ttf FontPath, str( 2, 0, 0), TextDepth, 0   scale TextScale  translate <2.4, 2, 2> }
    text{ ttf FontPath, str(10, 0, 0), TextDepth, 0   scale TextScale  translate <2.4, 2, -2> }
    text{ ttf FontPath, str(12, 0, 0), TextDepth, 0   scale TextScale  translate <-.4, 2, -2> }
    text{ ttf FontPath, str(14, 0, 0), TextDepth, 0   scale TextScale  translate <1, 4, -2> }


}

#declare Text = union{
    #for( Index, 0, dimension_size(TextObjects, 1) - 1 )
        #local TextObject = TextObjects[Index];
        object{
            TextObject
            translate -x * ( max_extent(TextObject).x - min_extent(TextObject).x ) / 2
            rotate -90*z
            rotate 90*x
        }
    #end
    translate <-.16, -1, 0>
    pigment{color srgb .5}
}

///////////////////////////// axes

// double beams (infinite straight axes)
#declare DefaultDoubleBeam = cylinder{99*z, -99*z, AxisRad}
#declare DoubleBeams = union{
    object{DefaultDoubleBeam   rotate 90*x  translate <2, 0, 2 + 2*AngleOffset>}
    object{DefaultDoubleBeam   rotate 90*x  translate <4, 0, 2 + 2*AngleOffset>}
    object{DefaultDoubleBeam   translate 3*x   rotate 90*x}
}
// single beams (straight axes with one end in the scene)
#declare DefaultSingleBeam = cylinder{0, -99*z, AxisRad}
#declare SingleBeams = union{
    object{DefaultSingleBeam  translate sqrt(3)*z}
    object{DefaultSingleBeam  rotate 90*x  translate <0, AngleOffset, 2*AngleOffset>}
    object{DefaultSingleBeam  rotate 90*x  translate <2, AngleOffset, 2*AngleOffset>}
    object{DefaultSingleBeam  rotate 90*x  translate <4, AngleOffset, 2*AngleOffset>}
    object{DefaultSingleBeam  translate <2, 0, -sqrt(3)>}
    object{DefaultSingleBeam  translate <4, 0, -sqrt(3)>}
}
// axis waves
#declare WaveRingSegment = intersection{
    torus{ 2, AxisRad   rotate 90*x   translate <-1, sqrt(3), 0>}
    plane{-x, 0}
    plane{y, sqrt(3)}
    rotate 90*x
}
#declare WaveAxes = union{
    object{WaveRingSegment}
    object{WaveRingSegment scale -x}
}
#declare WaveAxes = union{
    object{WaveAxes}
    object{WaveAxes scale -z}
    translate 3*x
}
// axis angles
#declare AngleRingSegment = intersection{
    torus{AngleOffset, AxisRad}
    plane{-x, 0}
    plane{-z, 0}
    rotate 90*z  rotate 90*x
    translate <0, AngleOffset, AngleOffset>
}
#declare AxisAngles = union{
    object{AngleRingSegment}
    object{AngleRingSegment  translate 2*x}
    object{AngleRingSegment  translate 4*x}
}
// combined
#declare Axes = union{
    object{SingleBeams}
    object{DoubleBeams}
    object{WaveAxes}
    object{AxisAngles}
    sphere{<3, 0, 0>, .07}
    pigment{SolidGray}
}


///////////////////////////// planes

// default wave plane
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
#declare DefaultWavePlane = merge{
    object{Corner}
    difference{
        plane{x, 0}
        object{Corner  rotate 180*z}
    }
}

// default angle plane
#declare QuarterSpace = intersection{
    plane{x, 0}
    plane{-y, 0}
}
#declare QuarterSpaces = merge{
    object{QuarterSpace  translate AngleOffset*y}
    object{QuarterSpace  translate AngleOffset*-x}
}
#declare DefaultAnglePlane = merge{
    object{QuarterSpaces}
    cylinder{<-AngleOffset, AngleOffset, 99>, <-AngleOffset, AngleOffset, -99>, AngleOffset}
}

// array
#declare PlanesArray = array[4]{
    object{
        DefaultAnglePlane
        rotate -90*x
        scale -x
        translate (2 + 2*AngleOffset) * z
    }
    object{
        DefaultWavePlane  inverse
        translate 3*x  rotate 90*x
    }
    object{
        DefaultWavePlane
        scale -x  translate 3*x  rotate 90*x
    }
    object{
        DefaultAnglePlane
        rotate -90*y
        translate 2*AngleOffset*z
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

// compounds of planes
#declare GrayPlanes = union{
    PlaneMacro(0, 0)
    PlaneMacro(1, 0)
    PlaneMacro(2, 0)
    PlaneMacro(3, 0)
}
#if (CaseCells)
    #declare ColoredPlanes = intersection{
#else
    #declare ColoredPlanes = union{
#end
        object{PlaneMacro(0, 1) inverse}
        object{PlaneMacro(1, 1) inverse}
        object{PlaneMacro(2, 1) inverse}
        object{PlaneMacro(3, 1) inverse}
}

///////////////////////////// show

#declare CutBoxA = box{<-3    , -5    , -3    >, <5    , 3    , 6.5  >}
#declare CutBoxB = box{<-3.001, -5.001, -3.001>, <5.001, 3.001, 6.501>}
#declare CutBoxC = box{<-3.002, -5.002, -3.002>, <5.002, 3.002, 6.502>}

#declare MoveInCutBox = <-1, -1, -1>;

union{

    #if (CaseCells)
        intersection{
            object{GrayPlanes  translate MoveInCutBox}
            object{CutBoxA  pigment{Invisible}}
        }
    #end

    intersection{
        object{ColoredPlanes  translate MoveInCutBox}
        object{CutBoxB  pigment{CutColor}}
    }

    intersection{
        object{Axes  translate MoveInCutBox}
        object{CutBoxC  pigment{SolidGray}}
    }
    
    #if (!CaseCells)
        object{Text}
    #end

    rotate 90*z
    rotate -90*y
    rotate -24.5*y
    translate -1.25*y
    translate 1.7*x
}


/*
povray farofe.pov +ua +fn +W1000 +H880
povray farofe.pov +ua +fn +W4000 +H3520 -D

Adaptations for sets and hypersplits:
  CaseCells = 0
  comment out all but the relevant plane(s)
  comment out the corresponding gray plane(s)

Hypersplits:
  Trans = 70

Sets:
  Trans = 10 (almost solid)
  Trans 100 for (manually copied) color of CutBoxB
*/

