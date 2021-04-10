#include "basics.inc"


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


#macro PutEdge(RingIndex, InverseIndex)

    #local RingPair = RingPairs[RingIndex];
    #local VennPair = RingPairs[5-RingIndex];
    #local InversePair = InversePairs[InverseIndex];

    #local Inv0 = InversePair[0];
    #local Inv1 = InversePair[1];
    #local NotInv0 = mod(Inv0+1, 2);
    #local NotInv1 = mod(Inv1+1, 2);

    intersection{
        ColorRing(RingPair[0], RingPair[1])
        intersection{
            Sphere(
                VennPair[0],                 // sphere index
                Inv0,                        // inverse
                pow(-1, NotInv0) * Offset,   // offset
                Inv0                         // light color
            )
            Sphere(
                VennPair[1],                 // sphere index
                Inv1,                        // inverse
                pow(-1, NotInv1) * Offset,   // offset
                Inv1                         // light color
            )
        }
    }
#end


#declare IndexPairs = array[24]{ array[2]{0, 0}, array[2]{0, 1}, array[2]{0, 2}, array[2]{0, 3}, array[2]{1, 0}, array[2]{1, 1}, array[2]{1, 2}, array[2]{1, 3}, array[2]{2, 0}, array[2]{2, 1}, array[2]{2, 2}, array[2]{2, 3}, array[2]{3, 0}, array[2]{3, 1}, array[2]{3, 2}, array[2]{3, 3}, array[2]{4, 0}, array[2]{4, 1}, array[2]{4, 2}, array[2]{4, 3}, array[2]{5, 0}, array[2]{5, 1}, array[2]{5, 2}, array[2]{5, 3} }

#declare IndexPair = IndexPairs[clock];


#declare EdgeCSG = PutEdge(IndexPair[0], IndexPair[1])


/*

declare -a strings=('0_1_-_in2_in3' '0_1_-_ex2_in3' '0_1_-_in2_ex3' '0_1_-_ex2_ex3' '0_2_-_in1_in3' '0_2_-_ex1_in3' '0_2_-_in1_ex3' '0_2_-_ex1_ex3' '0_3_-_in1_in2' '0_3_-_ex1_in2' '0_3_-_in1_ex2' '0_3_-_ex1_ex2' '1_2_-_in0_in3' '1_2_-_ex0_in3' '1_2_-_in0_ex3' '1_2_-_ex0_ex3' '1_3_-_in0_in2' '1_3_-_ex0_in2' '1_3_-_in0_ex2' '1_3_-_ex0_ex2' '2_3_-_in0_in1' '2_3_-_ex0_in1' '2_3_-_in0_ex1' '2_3_-_ex0_ex1')

for i in `seq 0 23`; do povray SCENE.pov +ua +fn +W4000 +H3704 -D -k$i -O${strings[$i]}; done

*/
