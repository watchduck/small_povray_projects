union{
    #for( Index, 0, 15 )
        sphere{ TessPoints[Index], 2*SkeletonRad }
    #end

    #for( Index, 0, 31 )
        #local EdgeArray = TessEdgeArrays[Index];
        cylinder{ TessPoints[EdgeArray[0]], TessPoints[EdgeArray[1]], SkeletonRad }
    #end

    pigment{color rgb .8}
}
