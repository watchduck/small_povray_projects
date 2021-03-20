#include "basics.inc"


#macro ColorRing(SphereIndexA, SphereIndexB)
    #declare Offset = .1;

    intersection{
        difference{
            Sphere(SphereIndexA, 0, Offset, 0)
            Sphere(SphereIndexA, 0, -Offset, 1)
        }
        difference{
            Sphere(SphereIndexB, 0, Offset, 0)
            Sphere(SphereIndexB, 0, -Offset, 1)
        }
    }

#end


#declare ColorRings = union{
    ColorRing(0, 1)  // 0
    ColorRing(0, 2)  // 1
    ColorRing(0, 3)  // 2
    ColorRing(1, 2)  // 3
    ColorRing(1, 3)  // 4
    ColorRing(2, 3)  // 5
}

