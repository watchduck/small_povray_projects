import numpy as np

from a2_store_points import tree_points, tree_point_weights
from e1_store_subspaces import points4, fixed4, primary_weights
from e2_helpers import pairs_to_sequences, povray_array


# Sage 9.1 installed globally, run as:
# (env) foo@bar:~/Code/small_povray_projects/projects/hypercube_subspaces/tesseract/python$ ~/SageMath/sage e3_prep_subspace_faces.sage


pattern_letters = ['a', 'b', 'c', 'd']

patterns = [
    'dummy',
    'dummy',
    [(2, 2, 0, 0), (1, 1, 2, 0), (0, 2, 0, 2), (1, 0, 1, 2)],
    [(3, 6, 4, 0), (2, 3, 4, 4)],
    [(4, 12, 16, 8)]
]

subspace_dicts = {}

for rank in [2, 3]:
    rank_dict = fixed4[rank]
    for pattern_short, list_of_bundles in rank_dict.items():
        pattern_index = patterns[rank].index(pattern_short)
        pattern_letter = pattern_letters[pattern_index]
        bundle_index_length = 1 if len(list_of_bundles) <= 10 else 2
        for bundle_index, bundle in enumerate(list_of_bundles):
            bundle_string = str(rank) + pattern_letter + str(bundle_index).zfill(bundle_index_length)

            highest_weight = 0
            for point_index in bundle:
                point_weight = primary_weights[point_index]
                if point_weight > highest_weight:
                    highest_weight = point_weight

            vertex_incides = []  # points in the bundle that have the highest weight
            for point_index in bundle:
                point_weight = primary_weights[point_index]
                if point_weight == highest_weight:
                    vertex_incides.append(point_index)

            vertices = []
            for vertex_index in vertex_incides:
                vertex = points4[vertex_index]
                minus_vertex = tuple(-np.array(vertex))
                vertices += [vertex, minus_vertex]

            # SAGE variables start with an underscore.
            _subspace = LatticePolytope(vertices)

            _tuples_of_faces = _subspace.faces()  # 4 or 5 tuples containing polytopes of dimensions -1 to 2 or 3

            lists_of_edge_vertices = []
            weights_of_edges = []
            lists_of_2face_vertices = []
            weights_of_2faces = []
            for dim in [1, 2]:
                _tuple_of_faces = _tuples_of_faces[dim+1]

                for _face in _tuple_of_faces:
                    sum_array = np.array((0, 0, 0, 0))
                    face_vertex_indices = []  # Face as in n-face. Contains non-negative indices to `tree_points`.
                    _face_vertices = _face.faces()[1]

                    for _wrapped_vertex in _face_vertices:
                        _vertex = _wrapped_vertex.points()[0]  # something like M(-1, 1, -1, -1)
                        vertex_array = np.array(_vertex)
                        sum_array += vertex_array
                        vertex_tuple = tuple(_vertex)
                        vertex_index = tree_points.index(vertex_tuple)
                        face_vertex_indices.append(vertex_index)

                        face_center_array = sum_array / len(_face_vertices)
                        face_center_tuple = tuple(face_center_array)
                        face_center_index = tree_points.index(face_center_tuple)  # something wrong here
                        face_weight = tree_point_weights[face_center_index]

                    if dim == 1:
                        lists_of_edge_vertices.append(face_vertex_indices)
                        weights_of_edges.append(face_weight)
                    else:  # dim == 2
                        lists_of_2face_vertices.append(face_vertex_indices)
                        weights_of_2faces.append(face_weight)

            # bring rectangle vertices in circular order
            lists_of_2face_vertices_circular = []
            for face in lists_of_2face_vertices:
                face_edges = []
                for a, b in lists_of_edge_vertices:
                    if a in face and b in face:
                        face_edges.append((a, b))
                face_circular = pairs_to_sequences(face_edges)[0]
                lists_of_2face_vertices_circular.append(face_circular)

            subspace_dicts[bundle_string] = {
                'vertices_positive': vertex_incides,
                'vertex_weight': highest_weight,
                'edges': [[el-40 for el in li] for li in lists_of_edge_vertices],
                'edge_weights': weights_of_edges,
                'faces': [[el - 40 for el in li] for li in lists_of_2face_vertices_circular],
                'face_weights': weights_of_2faces
            }

bundle_strings = sorted(subspace_dicts.keys())
print(bundle_strings)

variant = 'povray'

if variant == 'python':
    for bundle_string in bundle_strings:
        subspace_dict = subspace_dicts[bundle_string]
        print("'{key}': {{".format(key=bundle_string))
        print("    'vertices_positive': {val},".format(val=subspace_dict['vertices_positive']))
        print("    'vertex_weight': {val},".format(val=subspace_dict['vertex_weight']))
        print("    'edges': {val},".format(val=subspace_dict['edges']))
        print("    'edge_weights': {val},".format(val=subspace_dict['edge_weights']))
        print("    'faces': {val},".format(val=subspace_dict['faces']))
        print("    'face_weights': {val},".format(val=subspace_dict['face_weights']))
        print("},")

if variant == 'povray':
    count = -1
    for bundle_string in bundle_strings:
        subspace_dict = subspace_dicts[bundle_string]
        count += 1

        print("#if (clock={c})  // {s}".format(c=count, s=bundle_string))
        print("    #declare SubspaceVerticesPositive = {val};".format(val=povray_array(subspace_dict['vertices_positive'])))
        print("    #declare SubspaceVertexWeight = {val};".format(val=subspace_dict['vertex_weight']))
        print("    #declare SubspaceEdges = {val};".format(val=povray_array(subspace_dict['edges'])))
        print("    #declare SubspaceEdgeWeights = {val};".format(val=povray_array(subspace_dict['edge_weights'])))
        print("    #declare SubspaceFaces = {val};".format(val=povray_array(subspace_dict['faces'])))
        print("    #declare SubspaceFaceWeights = {val};".format(val=povray_array(subspace_dict['face_weights'])))
        print("#end")
