#include "basics.inc"


#macro Ring(RingIndex, ColorIndex)
    torus {
        1.814, .05
        rotate -45*x
        translate x
        
        #if (RingIndex = 0)
            rotate 90*z  scale -z
        #end
        #if (RingIndex = 1)
            scale -x  scale -z  rotate 90*y  scale -y
        #end
        #if (RingIndex = 2)
            scale -x  scale -z
        #end
        #if (RingIndex = 4)
            rotate 90*y  scale -y
        #end
        #if (RingIndex = 5)
            scale -x  scale -z  rotate 90*z  scale -z
        #end
        
        pigment{Colors[ColorIndex][0]}
    }
#end


// for each set the indices of the three rings on its surface (see `rings_colored.inc` for the indices)
#declare RingIndexTriples = array[4]{
    array[3]{0, 1, 2},
    array[3]{0, 3, 4},
    array[3]{1, 3, 5},
    array[3]{2, 4, 5},
};

#declare OtherSphereIndexTriples = array[4]{
    array[3]{1, 2, 3},
    array[3]{0, 2, 3},
    array[3]{0, 1, 3},
    array[3]{0, 1, 2}
};

#declare InverseTriples = array[8]{
    array[3]{0, 0, 0},
    array[3]{1, 0, 0},
    array[3]{0, 1, 0},
    array[3]{1, 1, 0},
    array[3]{0, 0, 1},
    array[3]{1, 0, 1},
    array[3]{0, 1, 1},
    array[3]{1, 1, 1},
};

#declare MainSphereIndices = array[32]{0, 1, 2, 3, 1, 2, 3, 0, 2, 3, 2, 3, 0, 1, 3, 1, 3, 0, 3, 3, 0, 1, 2, 1, 2, 0, 2, 2, 0, 1, 1, 0};

#declare InverseTriplesAsIntegers = array[32]{0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 3, 3, 2, 2, 4, 3, 5, 3, 6, 7, 4, 4, 4, 5, 5, 5, 6, 7, 6, 6, 7, 7};


#declare TriangleIndex = clock;

#declare InverseTriple = InverseTriples[InverseTriplesAsIntegers[TriangleIndex]];

#declare MainSphereIndex = MainSphereIndices[TriangleIndex];

#declare RingIndices = RingIndexTriples[MainSphereIndex];

#declare OtherSphereIndices = OtherSphereIndexTriples[MainSphereIndex];



#declare Rings = union{
    difference{
        Ring(RingIndices[0], OtherSphereIndices[0])
        union{
            Sphere(OtherSphereIndices[1], InverseTriple[1], 0, 0)
            Sphere(OtherSphereIndices[2], InverseTriple[2], 0, 0)
        }
    }
    difference{
        Ring(RingIndices[1], OtherSphereIndices[1])
        union{
            Sphere(OtherSphereIndices[0], InverseTriple[0], 0, 0)
            Sphere(OtherSphereIndices[2], InverseTriple[2], 0, 0)
        }
    }
    difference{
        Ring(RingIndices[2], OtherSphereIndices[2])
        union{
            Sphere(OtherSphereIndices[0], InverseTriple[0], 0, 0)
            Sphere(OtherSphereIndices[1], InverseTriple[1], 0, 0)
        }
    }
}



#declare CutUnion = union{
    Sphere(OtherSphereIndices[0], InverseTriple[0], 0, 3)
    Sphere(OtherSphereIndices[1], InverseTriple[1], 0, 3)
    Sphere(OtherSphereIndices[2], InverseTriple[2], 0, 3)
}

#declare CutIntersection = intersection{
    Sphere(OtherSphereIndices[0], InverseTriple[0], pow(-1,InverseTriple[0])*.3, 0)
    Sphere(OtherSphereIndices[1], InverseTriple[1], pow(-1,InverseTriple[1])*.3, 0)
    Sphere(OtherSphereIndices[2], InverseTriple[2], pow(-1,InverseTriple[2])*.3, 0)
}



#declare BigBlackSpheres = difference{
    BlackSpheres(.11)
    object{CutIntersection}
}


#declare Triangle = difference{
    Sphere(MainSphereIndex, 0, 0, 2)
    object{CutUnion}
}


#declare TriangleUnion = union{
    object{Triangle}
    object{Rings}
    object{BigBlackSpheres}
}


/*

declare -a strings=('00_01' '00_02' '00_04' '00_08' '01_03' '01_05' '01_09' '02_03' '02_06' '02_10' '03_07' '03_11' '04_05' '04_06' '04_12' '05_07' '05_13' '06_07' '06_14' '07_15' '08_09' '08_10' '08_12' '09_11' '09_13' '10_11' '10_14' '11_15' '12_13' '12_14' '13_15' '14_15')

for i in `seq 0 31`; do povray SCENE.pov +ua +fn +W4000 +H4416 -D -k$i -O${strings[$i]}; done

*/
