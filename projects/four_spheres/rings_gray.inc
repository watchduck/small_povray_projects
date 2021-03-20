#include "basics.inc"


#declare Torus = torus {
    1.814, .017
    rotate -45*x
    translate x
    pigment{LightGray}
}

#declare TorusPair = union{
    object{Torus}
    object{Torus  scale -x  scale -z}
}

#declare AllTori = union {
    object{TorusPair}
    object{TorusPair  rotate 90*y  scale -y}
    object{TorusPair  rotate 90*z  scale -z}
}


#declare GrayRings = union {
    object{AllTori}
    BlackSpheres(.045)
}

