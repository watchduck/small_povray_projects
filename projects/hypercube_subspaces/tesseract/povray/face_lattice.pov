#include "basics.inc";


/*
for i in $(seq 0 9); do povray face_lattice.pov +ua +fn +H3600 +W2592 -D -k$i -O$i; done

https://commons.wikimedia.org/wiki/Category:Face_lattice_of_the_tesseract_(Bilinski)
*/


// variables

#declare R = .007;  // base radius
#declare D = .005;  // difference
#declare VertexRadii = array[5]{ R, R+2*D,  R+4*D, R+6*D, R+8*D };
#declare EdgeRadii = array[4]{ R+D, R+3*D, R+5*D, R+7*D };
#declare VertexRadiusFactor = 3;
#declare VertexRadiusAddend = .015;


// all vertices and edges
#if (clock = 0)
    #for( Index, 0, 80 )
        #declare Weight = PointWeights[Index];
        sphere{
            P[Index], VertexRadii[Weight]*VertexRadiusFactor+VertexRadiusAddend
            pigment{ color srgb PureColors[Weight] }
        }
    #end

    #for( Index, 0, 215 )
        #declare Weight = EdgeWeights[Index];
        #local EdgeArray = EdgeArrays[Index];
        cylinder{
            P[EdgeArray[0]+40], P[EdgeArray[1]+40], EdgeRadii[Weight]
            pigment{ color srgb MixedColors[Weight] }
        }
    #end
#end


// edges by weight
#if (1<=clock & clock<=4)
    #declare AllowedEdgeWeight = clock-1;

    #for( Index, 0, 80 )
        #declare Weight = PointWeights[Index];
        #if (Weight = AllowedEdgeWeight | Weight = AllowedEdgeWeight+1)
            sphere{
                P[Index], VertexRadii[Weight]*VertexRadiusFactor+VertexRadiusAddend
                pigment{ color srgb PureColors[Weight] }
            }
        #end
    #end

    #for( Index, 0, 215 )
        #declare Weight = EdgeWeights[Index];
        #if (Weight = AllowedEdgeWeight)
            #local EdgeArray = EdgeArrays[Index];
            cylinder{
                P[EdgeArray[0]+40], P[EdgeArray[1]+40], EdgeRadii[Weight]
                pigment{ color srgb MixedColors[Weight] }
            }
        #end
    #end
#end


// cubes and connections
#if (5<=clock & clock<=9)
    #declare LeftFirst = -40;
    #declare LeftLast = -14;
    #declare MiddleFirst = -13;
    #declare MiddleLast = 13;
    #declare RightFirst = 14;
    #declare RightLast = 40;

    #for( Index, 0, 215 )
        #local EdgeArray = EdgeArrays[Index];
        #declare From = EdgeArray[0];
        #declare To = EdgeArray[1];
        #declare Conditions = array[5]{
            (LeftFirst<=To & To<=LeftLast & LeftFirst<=From & From<=LeftLast),  // L
            (LeftFirst<=To & To<=LeftLast & MiddleFirst<=From & From<=MiddleLast),  // LM
            (MiddleFirst<=To & To<=MiddleLast & MiddleFirst<=From & From<=MiddleLast),  // M
            (MiddleFirst<=From & From<=MiddleLast & RightFirst<=To & To<=RightLast),  // MR
            (RightFirst<=To & To<=RightLast & RightFirst<=From & From<=RightLast),  // R
        }
        #if (Conditions[clock-5])
            #declare Weight = EdgeWeights[Index];
            cylinder{
                P[From+40], P[To+40], EdgeRadii[Weight]
                pigment{ color srgb MixedColors[Weight] }
            }

            #declare Weight = PointWeights[From+40];
            sphere{
                P[From+40], VertexRadii[Weight]*VertexRadiusFactor+VertexRadiusAddend
                pigment{ color srgb PureColors[Weight] }
            }

            #declare Weight = PointWeights[To+40];
            sphere{
                P[To+40], VertexRadii[Weight]*VertexRadiusFactor+VertexRadiusAddend
                pigment{ color srgb PureColors[Weight] }
            }
        #end
    #end
#end