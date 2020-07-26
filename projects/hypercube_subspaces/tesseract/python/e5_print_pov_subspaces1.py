from e4_store_subspace_faces import subspaces1
from e2_helpers import povray_array

count = -1

strings = {}

for prefix, valdict in subspaces1.items():
    vertices = valdict['vertices_positive']
    weight = valdict['vertex_weight']
    vertex_index_length = 2 if len(vertices) >= 10 else 1
    for i, vertex in enumerate(vertices):
        count += 1
        string = prefix + str(i).zfill(vertex_index_length)
        strings[count] = string
        print("#if (clock={c})  // {s}".format(c=count, s=string))
        print("    #declare SubspaceVerticesPositive = {val};".format(val=povray_array([vertex])))
        print("    #declare SubspaceVertexWeight = {val};".format(val=weight))
        print("    #declare SubspaceEdges = {val};".format(val=povray_array([[vertex, -vertex]])))
        print("    #declare SubspaceEdgeWeights = {val};".format(val=povray_array([0])))
        print("#end")

print(
    [strings[i] for i in range(40)]
)
