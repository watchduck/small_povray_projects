#include "basics.inc"


#declare TorusMinRad = .017;
#declare SphereRad = .045;


// black spheres

#declare FactorPos = 1.2684;
#declare FactorNeg = -.6017;
#declare TetraPoints = array[4]{<1,1,1>, <-1,-1,1>, <-1,1,-1>, <1,-1,-1>}

#declare BlackSpheres = union{
    #for (KeyToTetraPoints, 0, 3)
        #declare TetraPoint = TetraPoints[KeyToTetraPoints];
        sphere{TetraPoint * FactorPos , SphereRad}
        sphere{TetraPoint * FactorNeg , SphereRad}
    #end
    pigment{color srgb .2}
}


// gray tori

#declare Torus = torus {
    1.814, TorusMinRad
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


// result

#declare GrayRings = union {
    object{AllTori}
    object{BlackSpheres}
}
