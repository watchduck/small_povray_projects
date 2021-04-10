#include "colors.inc"
#include "math.inc"

#include "random_spheres.inc"

#version 3.6;  // needed for "+ua +fn" to work
global_settings { assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 conserve_energy}}

#declare Camera_Position = vnormalize(<-20, 14, -40>) * 16.5;

camera{
    location Camera_Position
    right    x*image_width/image_height
    angle    30
    look_at  <-.4, .1, 0>
}


light_source{ <-400, 500, -300>*.3 color White shadowless}

light_source{ Camera_Position  color rgb<0.9,0.9,1>*0.1 shadowless}
sky_sphere{ pigment{ White } }

/////////////////////////////

#declare Trans = 0;  // 100 for overview, 10 for cells
#declare Trans0 = pigment{color srgbt <219,0,0,Trans>/255}
#declare Trans1 = pigment{color srgbt <0,211,0,Trans>/255}
#declare Trans2 = pigment{color srgbt <0,48,255,Trans>/255}
#declare Trans3 = pigment{color srgbt <255,158,0,Trans>/255}

#declare Midpoint0 = <-sqrt(3), 0, 0>;
#declare Midpoint1 = <0, 1, 0>;
#declare Midpoint2 = <0, -1, 0>;
#declare Midpoint3 = <sqrt(3), 0, 0>;

#declare SphereRad = 1.42;
#declare Alpha = acosd(1/SphereRad);  // 45.233
#declare RingRad = tand(Alpha);  // 1.00816

#declare Move = 2 * (1 + sqrt(3));  // length between representations of the same point

/////////////////////////////

// rings
#declare HorizontalRing = torus{ RingRad, .02  pigment{color srgb .9} }
#declare VerticalRing = object{
    HorizontalRing
    rotate 90*z
    translate (1 + sqrt(3)) * x
}
#declare TiltedRing = object{
    HorizontalRing
    rotate 120*z
    translate (Midpoint0+Midpoint1)/2
}
#declare TiltedRings = union{
    object{TiltedRing}
    object{TiltedRing  scale -y}
}
#declare TiltedRings = union{
    object{TiltedRings}
    object{TiltedRings  scale -x}
}
#declare Rings = union{
    object{HorizontalRing}
    object{VerticalRing}
    object{TiltedRings}
}

// vertices
#declare VertexX = 1 / sqrt(3);
#declare VertexZ = sqrt( pow(RingRad,2) - pow(VertexX,2) );
#declare Vertex = sphere{ <VertexX, 0, VertexZ>, .07  pigment{color srgb .9} }
#declare Vertices = union{
    object{Vertex}
    object{Vertex  scale -z}
}
#declare Vertices = union{
    object{Vertices}
    object{Vertices  scale -x}
}

// edges (rings and vertices)
#declare Edges = union{
    object{Rings}
    object{Vertices}
}
#declare RepeatedEdges = union{
    object{Edges}
    object{Edges translate Move*x}
    object{Edges translate -Move*x}
}

/////////////////////////////

#declare Sphere0 = sphere{ Midpoint0, SphereRad  pigment{Trans0} }
#declare RepeatedSphere0 = union{
    object{Sphere0}
    object{Sphere0 translate Move*x}
    object{Sphere0 translate -Move*x}
}
#declare Sphere1 = sphere{ Midpoint1, SphereRad  pigment{Trans1} }
#declare RepeatedSphere1 = union{
    object{Sphere1}
    object{Sphere1 translate Move*x}
    object{Sphere1 translate -Move*x}
}
#declare Sphere2 = sphere{ Midpoint2, SphereRad  pigment{Trans2} }
#declare RepeatedSphere2 = union{
    object{Sphere2}
    object{Sphere2 translate Move*x}
    object{Sphere2 translate -Move*x}
}
#declare Sphere3 = sphere{ Midpoint3, SphereRad  pigment{Trans3} }
#declare RepeatedSphere3 = union{
    object{Sphere3}
    object{Sphere3 translate Move*x}
    object{Sphere3 translate -Move*x}
}

/////////////////////////////

/*
difference{
    union{
        object{RepeatedSphere0}
        object{RepeatedSphere1}
        object{RepeatedSphere2}
        object{RepeatedSphere3}
    }
    object{RandomSpheres}
}
*/

object{RepeatedEdges}


object{RandomSpheres}




/*

povray sphere_chain.pov +ua +fn +W1000 +H560
povray sphere_chain.pov +ua +fn +W4000 +H2240 -D

*/
