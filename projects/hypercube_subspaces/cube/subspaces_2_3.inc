#if (clock=0)  // 2a0
    #declare SubspaceVerticesPositive = array[2]{2, 4};
    #declare SubspaceVertexWeight = 2;
    #declare SubspaceEdges = array[4]{array[2]{2, -4}, array[2]{-2, -4}, array[2]{-2, 4}, array[2]{2, 4}};
    #declare SubspaceEdgeWeights = array[4]{1, 1, 1, 1};
    #declare SubspaceFaces = array[1]{array[4]{-2, -4, 2, 4}};
    #declare SubspaceFaceWeights = array[1]{0};
#end
#if (clock=1)  // 2a1
    #declare SubspaceVerticesPositive = array[2]{8, 10};
    #declare SubspaceVertexWeight = 2;
    #declare SubspaceEdges = array[4]{array[2]{8, -10}, array[2]{-8, -10}, array[2]{-8, 10}, array[2]{8, 10}};
    #declare SubspaceEdgeWeights = array[4]{1, 1, 1, 1};
    #declare SubspaceFaces = array[1]{array[4]{-8, -10, 8, 10}};
    #declare SubspaceFaceWeights = array[1]{0};
#end
#if (clock=2)  // 2a2
    #declare SubspaceVerticesPositive = array[2]{6, 12};
    #declare SubspaceVertexWeight = 2;
    #declare SubspaceEdges = array[4]{array[2]{6, -12}, array[2]{-6, -12}, array[2]{-6, 12}, array[2]{6, 12}};
    #declare SubspaceEdgeWeights = array[4]{1, 1, 1, 1};
    #declare SubspaceFaces = array[1]{array[4]{-6, -12, 6, 12}};
    #declare SubspaceFaceWeights = array[1]{0};
#end

#if (clock=3)  // 2b00
    #declare SubspaceVerticesPositive = array[2]{5, 7};
    #declare SubspaceVertexWeight = 3;
    #declare SubspaceEdges = array[4]{array[2]{5, -7}, array[2]{5, 7}, array[2]{-5, 7}, array[2]{-5, -7}};
    #declare SubspaceEdgeWeights = array[4]{1, 2, 1, 2};
    #declare SubspaceFaces = array[1]{array[4]{-5, -7, 5, 7}};
    #declare SubspaceFaceWeights = array[1]{0};
#end
#if (clock=4)  // 2b01
    #declare SubspaceVerticesPositive = array[2]{5, 11};
    #declare SubspaceVertexWeight = 3;
    #declare SubspaceEdges = array[4]{array[2]{5, 11}, array[2]{5, -11}, array[2]{-5, -11}, array[2]{-5, 11}};
    #declare SubspaceEdgeWeights = array[4]{2, 1, 2, 1};
    #declare SubspaceFaces = array[1]{array[4]{-5, 11, 5, -11}};
    #declare SubspaceFaceWeights = array[1]{0};
#end
#if (clock=5)  // 2b02
    #declare SubspaceVerticesPositive = array[2]{7, 11};
    #declare SubspaceVertexWeight = 3;
    #declare SubspaceEdges = array[4]{array[2]{-7, 11}, array[2]{-7, -11}, array[2]{7, -11}, array[2]{7, 11}};
    #declare SubspaceEdgeWeights = array[4]{2, 1, 2, 1};
    #declare SubspaceFaces = array[1]{array[4]{7, 11, -7, -11}};
    #declare SubspaceFaceWeights = array[1]{0};
#end
#if (clock=6)  // 2b03
    #declare SubspaceVerticesPositive = array[2]{5, 13};
    #declare SubspaceVertexWeight = 3;
    #declare SubspaceEdges = array[4]{array[2]{5, -13}, array[2]{-5, -13}, array[2]{-5, 13}, array[2]{5, 13}};
    #declare SubspaceEdgeWeights = array[4]{2, 1, 2, 1};
    #declare SubspaceFaces = array[1]{array[4]{-5, -13, 5, 13}};
    #declare SubspaceFaceWeights = array[1]{0};
#end
#if (clock=7)  // 2b04
    #declare SubspaceVerticesPositive = array[2]{7, 13};
    #declare SubspaceVertexWeight = 3;
    #declare SubspaceEdges = array[4]{array[2]{-7, -13}, array[2]{7, -13}, array[2]{7, 13}, array[2]{-7, 13}};
    #declare SubspaceEdgeWeights = array[4]{2, 1, 2, 1};
    #declare SubspaceFaces = array[1]{array[4]{7, -13, -7, 13}};
    #declare SubspaceFaceWeights = array[1]{0};
#end
#if (clock=8)  // 2b05
    #declare SubspaceVerticesPositive = array[2]{11, 13};
    #declare SubspaceVertexWeight = 3;
    #declare SubspaceEdges = array[4]{array[2]{11, -13}, array[2]{-11, -13}, array[2]{-11, 13}, array[2]{11, 13}};
    #declare SubspaceEdgeWeights = array[4]{1, 2, 1, 2};
    #declare SubspaceFaces = array[1]{array[4]{-11, -13, 11, 13}};
    #declare SubspaceFaceWeights = array[1]{0};
#end

#if (clock=9)  // 3a0
    #declare SubspaceVerticesPositive = array[4]{5, 7, 11, 13};
    #declare SubspaceVertexWeight = 3;
    #declare SubspaceEdges = array[12]{array[2]{5, 7}, array[2]{-5, -7}, array[2]{5, 11}, array[2]{-7, 11}, array[2]{-5, -11}, array[2]{7, -11}, array[2]{7, 13}, array[2]{11, 13}, array[2]{-5, 13}, array[2]{5, -13}, array[2]{-7, -13}, array[2]{-11, -13}};
    #declare SubspaceEdgeWeights = array[12]{2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2};
    #declare SubspaceFaces = array[6]{array[4]{7, 5, 11, 13}, array[4]{11, -7, -5, 13}, array[4]{7, -11, -5, 13}, array[4]{5, 11, -7, -13}, array[4]{-7, -5, -11, -13}, array[4]{5, 7, -11, -13}};
    #declare SubspaceFaceWeights = array[6]{1, 1, 1, 1, 1, 1};
#end
