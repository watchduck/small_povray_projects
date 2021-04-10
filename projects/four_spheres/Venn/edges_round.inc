#include "basics.inc"


// the 6 vertices on a sphere in the color of that sphere
#macro SphereBorderPoints(MajorSphereIndex)
    #local Triple = Triples[MajorSphereIndex];
    #for (KeyToTriple, 0, 2)
        #local MinorSphereIndex = Triple[KeyToTriple];
        union{
            sphere{TetraPoints[MinorSphereIndex] * FactorPos , .11}
            sphere{TetraPoints[MinorSphereIndex] * FactorNeg , .11}
            pigment{Colors[MajorSphereIndex][0]}
        }
    #end
#end

// create dashed torus
#declare SegmentNum = 80;  // number of segments (of both colors) in a dashed ring

#declare Cut = plane{x, 0}
#declare Cut = intersection{
    object{Cut inverse}
    object{Cut rotate y*360/SegmentNum}
}
#declare Cut = union{
    #for(Index, 0, SegmentNum/2)
        object{Cut rotate y*Index*(360*2/SegmentNum)}
    #end
}

#declare RawRing =  torus {1.814, .05}

// Ring 3 between spheres 1 (green) and 2 (blue) is the default.
#declare DashedRawRingA = intersection{
    object{Cut}
    object{RawRing}
}
#declare DashedRawRingB = intersection{
    object{Cut rotate y*360/SegmentNum}
    object{RawRing}
}

#declare DashedDefaultRingA =  object{
    DashedRawRingA
    rotate -45*x  translate x
}
#declare DashedDefaultRingB =  object{
    DashedRawRingB
    rotate -45*x  translate x
}


#declare RingPairs = array[6]{
    array[2]{0, 1},  // 0
    array[2]{0, 2},  // 1
    array[2]{0, 3},  // 2
    array[2]{1, 2},  // 3
    array[2]{1, 3},  // 4
    array[2]{2, 3}   // 5
}

#declare InversePairs = array[4]{
    array[2]{0, 0},  // 0
    array[2]{1, 0},  // 1
    array[2]{0, 1},  // 2
    array[2]{1, 1}   // 3
}


#macro DashedRing(RingIndex)
    #declare RingPair = RingPairs[RingIndex];
    union{
        object{
            DashedDefaultRingA
            pigment{Colors[RingPair[0]][0]}
        }
        object{
            DashedDefaultRingB
            pigment{Colors[RingPair[1]][0]}
        }

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

    }
#end


#declare BigOffset = .15;

#macro PutEdge(RingIndex, InverseIndex)

    #local RingPair = RingPairs[RingIndex];
    #local VennPair = RingPairs[5-RingIndex];
    #local InversePair = InversePairs[InverseIndex];

    #local Inv0 = InversePair[0];
    #local Inv1 = InversePair[1];
    #local NotInv0 = mod(Inv0+1, 2);
    #local NotInv1 = mod(Inv1+1, 2);
    
    #local CutEdge = intersection{
            difference{
                Sphere(RingPair[0], 0, BigOffset, 0)
                Sphere(RingPair[0], 0, -BigOffset, 0)
            }
            difference{
                Sphere(RingPair[1], 0, BigOffset, 0)
                Sphere(RingPair[1], 0, -BigOffset, 0)
            }
            Sphere(
                VennPair[0],                 // sphere index
                Inv0,                        // inverse
                pow(-1, Inv0) * BigOffset,   // offset
                0                            // light color
            )
            Sphere(
                VennPair[1],                 // sphere index
                Inv1,                        // inverse
                pow(-1, Inv1) * BigOffset,   // offset
                0                            // light color
            )
    }

    union{    
        // edge
        intersection{
            DashedRing(RingIndex)
            intersection{
                Sphere(
                    VennPair[0],                 // sphere index
                    Inv0,                        // inverse
                    0,                           // offset
                    Inv0                         // light color
                )
                Sphere(
                    VennPair[1],                 // sphere index
                    Inv1,                        // inverse
                    0,                           // offset
                    Inv1                         // light color
                )
            }
        }

        // vertices
        intersection{
            union{
                SphereBorderPoints(VennPair[0])
                SphereBorderPoints(VennPair[1])
            }
            object{CutEdge}
        }

    }


#end


#declare IndexPairs = array[24]{ array[2]{0, 0}, array[2]{0, 1}, array[2]{0, 2}, array[2]{0, 3}, array[2]{1, 0}, array[2]{1, 1}, array[2]{1, 2}, array[2]{1, 3}, array[2]{2, 0}, array[2]{2, 1}, array[2]{2, 2}, array[2]{2, 3}, array[2]{3, 0}, array[2]{3, 1}, array[2]{3, 2}, array[2]{3, 3}, array[2]{4, 0}, array[2]{4, 1}, array[2]{4, 2}, array[2]{4, 3}, array[2]{5, 0}, array[2]{5, 1}, array[2]{5, 2}, array[2]{5, 3} }

#declare IndexPair = IndexPairs[clock];


#declare EdgeRound = PutEdge(IndexPair[0], IndexPair[1])


/*

declare -a strings=('0_1_-_in2_in3' '0_1_-_ex2_in3' '0_1_-_in2_ex3' '0_1_-_ex2_ex3' '0_2_-_in1_in3' '0_2_-_ex1_in3' '0_2_-_in1_ex3' '0_2_-_ex1_ex3' '0_3_-_in1_in2' '0_3_-_ex1_in2' '0_3_-_in1_ex2' '0_3_-_ex1_ex2' '1_2_-_in0_in3' '1_2_-_ex0_in3' '1_2_-_in0_ex3' '1_2_-_ex0_ex3' '1_3_-_in0_in2' '1_3_-_ex0_in2' '1_3_-_in0_ex2' '1_3_-_ex0_ex2' '2_3_-_in0_in1' '2_3_-_ex0_in1' '2_3_-_in0_ex1' '2_3_-_ex0_ex1')

for i in `seq 0 23`; do povray SCENE.pov +ua +fn +W4000 +H3704 -D -k$i -O${strings[$i]}; done

*/
