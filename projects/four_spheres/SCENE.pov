#include "cases.inc"
#include "cam_light.inc"

#include "cells.inc"
#include "rings_colored.inc"
#include "rings_gray.inc"
#include "surrounding_spheres.inc"
#include "triangles.inc"


#declare Scene = union{

    object{GrayRings}
    //object{ColorRings}

    object{SurroundingSpheres}
    object{Cells}

    //object{TriangleUnion}

}


// rotate and show
union{
    object{Scene}
    Transforms()  // from `cases.inc`
}

