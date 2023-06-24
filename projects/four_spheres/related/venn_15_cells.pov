#version 3.6;
global_settings { assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 conserve_energy}}

#include "colors.inc"
#include "math.inc"
#include "RotateDirOnDir.inc"



//////////////////////////////////////////////////////////// camera and light

#declare Camera_Position = <6, 6, -25>;
camera{
    location Camera_Position
    right    x*image_width/image_height
    angle    7.7
    look_at  0
}


light_source{ <-400, 500, -300> color White*0.9 shadowless}

light_source{ Camera_Position  color rgb<0.9,0.9,1>*0.1 shadowless}
sky_sphere{ pigment{ White } }



//////////////////////////////////////////////////////////// variables


#declare SphereRadius = sqrt(3);
#declare CircleOffset = .27;                                                    // distance of each circle to the origin                              
#declare CircleRadius = sqrt( pow(SphereRadius, 2) - pow(CircleOffset, 2) );

#declare Alpha = atan(1/sqrt(2));                                               // acute angle in a rectangular triangle with cathetes 1 and sqrt(2)
#declare EdgeOffset = CircleOffset / sin(Alpha);                                // distance of tetrahedron edge to origin

#declare TetrahedronCircumradius = EdgeOffset / sin(Alpha);                             // distance of tetrahedron vertex to origin
#declare TetrahedronSideLength = TetrahedronCircumradius * 4 / sqrt(6);
#declare EdgeOffsetInCircle = tand(30) * TetrahedronSideLength / 2;                     // height (inradius) of tetrahedron face
#declare HalfChordLength = sqrt( pow(CircleRadius, 2) - pow(EdgeOffsetInCircle, 2) );   // half length of dashed line (chord of circle)

#declare EdgeRadius = .007;

#declare P0 = <1,-1,-1>;
#declare P1 = <-1,-1,1>;
#declare P2 = <-1,1,-1>;
#declare P3 = <1,1,1>;



//////////////////////////////////////////////////////////// macros


#macro ColorMacro(ColorIndex, Transparency)
  #local Colors = array[4] {
    <219, 0, 0, Transparency*255> / 255,    // DB0000 red
    <0, 211, 0, Transparency*255> / 255,    // 00D300 green
    <0, 48, 255, Transparency*255> / 255,   // 0030FF blue
    <255, 158, 0, Transparency*255> / 255   // FF9E00 yellow
  }
  pigment{ color srgbt Colors[ColorIndex] }
#end


//////////////////////////////


#macro CircleMacro(Normal, ColorIndex)
  disc {
    0, Normal, CircleRadius
    translate CircleOffset * vnormalize(Normal)
    ColorMacro(ColorIndex, .73)
  }
  torus {
    CircleRadius, EdgeRadius * .5  // circle thickness
    translate CircleOffset * -y
    RotateDirOnDir(<0, -1, 0>, Normal)
    ColorMacro(ColorIndex, 0)
  }
#end


//////////////////////////////


#macro SingleEdgeMacro(ColorIndex, Offset)
  #local Factor = .13;
  intersection{
    union{
      #for (i, 1, 50)
        #local A = (Factor*(i+Offset) - 3) * z;
        #local B = (Factor*(i+Offset+.5) - 3) * z;
        cylinder{A, B, EdgeRadius}
      #end
      ColorMacro(ColorIndex, 0)
    }
    sphere{0, HalfChordLength}
  }
  union{
    sphere{ 0, EdgeRadius * 2.2   translate HalfChordLength *  z }
    sphere{ 0, EdgeRadius * 2.2   translate HalfChordLength * -z }
    pigment{color srgb .9}  // white vertices
  }
#end

#macro EdgeMacro(ColorIndex1, ColorIndex2)
  union{
    SingleEdgeMacro(ColorIndex1, 0)
    SingleEdgeMacro(ColorIndex2, .5)
    rotate 45 * x
    translate EdgeOffset * x
  }
#end



//////////////////////////////////////////////////////////// circles


#declare Circles = union {
  CircleMacro(P0, 0)
  CircleMacro(P1, 1)
  CircleMacro(P2, 2)
  CircleMacro(P3, 3)
}



//////////////////////////////////////////////////////////// dashed edges (circle intersections)


#declare Edges = union{
    object{ EdgeMacro(0, 3)                 }
    object{ EdgeMacro(1, 2)  rotate 180 * y }
    
    object{ EdgeMacro(0, 2)                  rotate 90*y  scale -y }
    object{ EdgeMacro(1, 3)  rotate 180 * y  rotate 90*y  scale -y }
    
    object{ EdgeMacro(0, 1)                  rotate 90*z  scale -y }
    object{ EdgeMacro(2, 3)  rotate 180 * y  rotate 90*z  scale -y }
}



//////////////////////////////////////////////////////////// tetrahedron vertices


#declare TetrahedronVertexRadius = EdgeRadius * 5;
#declare TetrahedronVertices = union{
  sphere{ 0, TetrahedronVertexRadius  translate -TetrahedronCircumradius*vnormalize(P0) }
  sphere{ 0, TetrahedronVertexRadius  translate -TetrahedronCircumradius*vnormalize(P1) }
  sphere{ 0, TetrahedronVertexRadius  translate -TetrahedronCircumradius*vnormalize(P2) }
  sphere{ 0, TetrahedronVertexRadius  translate -TetrahedronCircumradius*vnormalize(P3) }
  pigment {color srgb .3}  // black vertices
}



//////////////////////////////////////////////////////////// cells as intersections of half spaces (planes)

#declare Cell = intersection{
  plane{ P0, CircleOffset   ColorMacro(0, .1)   inverse }
  plane{ P1, CircleOffset   ColorMacro(1, .1)    }
  plane{ P2, CircleOffset   ColorMacro(2, .1)    }
  plane{ P3, CircleOffset   ColorMacro(3, .1)    }
  sphere{ 0, SphereRadius  pigment{color rgbt <.3, .3, .3, .7>}  }
}



//////////////////////////////////////////////////////////// sphere


#declare Sphere = sphere { 0, SphereRadius   pigment{color rgbt <.9, .9, .9, .3>} }



//////////////////////////////////////////////////////////// hidden reference points (cube vertices)


#declare HiddenPoints = union{
  sphere{ -P0, EdgeRadius*12   ColorMacro(0, 0) }
  sphere{ -P1, EdgeRadius*12   ColorMacro(1, 0) }
  sphere{ -P2, EdgeRadius*12   ColorMacro(2, 0) }
  sphere{ -P3, EdgeRadius*12   ColorMacro(3, 0) }
  
  sphere{ P0, EdgeRadius*4   ColorMacro(0, 0) }
  sphere{ P1, EdgeRadius*4   ColorMacro(1, 0) }
  sphere{ P2, EdgeRadius*4   ColorMacro(2, 0) }
  sphere{ P3, EdgeRadius*4   ColorMacro(3, 0) }
}



//////////////////////////////////////////////////////////// text


#declare TextScale = .17;
#declare TextDepth = .075;
#declare FontPath = "/usr/share/fonts/truetype/msttcorefonts/Arial.ttf";

#declare TextObjects = array[15]{
    text{ ttf FontPath, str(0, 0, 0), TextDepth, 0   scale TextScale }

    text{ ttf FontPath, str(14, 0, 0), TextDepth, 0   scale TextScale }
    text{ ttf FontPath, str(13, 0, 0), TextDepth, 0   scale TextScale }
    text{ ttf FontPath, str(11, 0, 0), TextDepth, 0   scale TextScale }
    text{ ttf FontPath, str(7, 0, 0), TextDepth, 0   scale TextScale }

    text{ ttf FontPath, str(1, 0, 0), TextDepth, 0   scale TextScale }
    text{ ttf FontPath, str(2, 0, 0), TextDepth, 0   scale TextScale }
    text{ ttf FontPath, str(4, 0, 0), TextDepth, 0   scale TextScale }
    text{ ttf FontPath, str(8, 0, 0), TextDepth, 0   scale TextScale }

    text{ ttf FontPath, str(12, 0, 0), TextDepth, 0   scale TextScale }
    text{ ttf FontPath, str(10, 0, 0), TextDepth, 0   scale TextScale }
    text{ ttf FontPath, str(9, 0, 0), TextDepth, 0   scale TextScale }
    text{ ttf FontPath, str(6, 0, 0), TextDepth, 0   scale TextScale }
    text{ ttf FontPath, str(5, 0, 0), TextDepth, 0   scale TextScale }
    text{ ttf FontPath, str(3, 0, 0), TextDepth, 0   scale TextScale }
}

#declare A = -1.07;
#declare B = -A;
#declare C = -.35;

#declare TranslatePoints = array[15]{
    <0, 0, 0>,
    A*P0, A*P1, A*P2, A*P3,
    B*P0, B*P1, B*P2, B*P3,
    C*(P0+P1), C*(P0+P2), C*(P1+P2), C*(P0+P3), C*(P1+P3), C*(P2+P3)
}

#declare W = <1, 1, 1>;
#declare R = <219, 0, 0> / 255;
#declare G = <0, 211, 0> / 255;
#declare B = <0, 48, 255> / 255;
#declare Y = <255, 158, 0> / 255;
#declare TextColors = array[15]{ <.4, .4, .4>,     R, G, B, Y,     R, G, B, Y,     W, W, W, W, W, W };

#declare Text = union{

    #for( Index, 0, 14 )
        #local TextObject = TextObjects[Index];
        object{
            TextObject
            translate <0, -.06, 0>
            translate -x * ( max_extent(TextObject).x - min_extent(TextObject).x ) / 2
            rotate -90 * z
            rotate 90 * y
            translate TranslatePoints[Index]
            pigment{color srgbt TextColors[Index]}
        }
    #end

}



//////////////////////////////////////////////////////////// rotate and show


union{
    //object{Sphere}
    object{Circles}
    object{Edges}
    object{TetrahedronVertices}
    //object{Text}
    
    //object{Cell}
    //object{HiddenPoints}
    
    rotate -90 * y
    rotate 90 * z
    
    rotate clock * y / 2
}





/*

https://commons.wikimedia.org/wiki/File:Truncated_Venn_diagram_with_15_cells.png


povray venn_15_cells.pov +ua +fn +W1000 +H1000
povray venn_15_cells.pov +ua +fn +W4000 +H4000



In some images the sphere is shown and the circle areas (discs) are hidden.
Then the factor in circle thickness (in `CircleMacro`) is 2 (rather than .5),
and the factor in the white vertex radius (in `SingleEdgeMacro`) is 5 (rather than 2.2).

The tetrahedral cell vanishes, when `CircleOffset` is 0 (rather than .27).
Then the factor in `TetrahedronVertexRadius` is 8 (rather than 5).



The following two commands are to create an animated rotation.
(Directly rendering with the desired 400px would give a lower quality.)

Render whole rotation with 720 images with 800px:
for i in $(seq -f "%03g" 0 719); do povray venn_15_cells.pov +ua +fn +H800 +W800 -D -k$i -Orotation/venn_$i; done

Scale from 800px to 400px:
for i in $(seq -f "%03g" 0 719); do convert rotation/venn_$i.png -resize 50% rotation/small/venn_$i.png; done

*/
