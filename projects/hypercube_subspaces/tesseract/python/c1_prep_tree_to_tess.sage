import numpy as np

from a2_store_points import tess_points, tree_points


# Sage 9.1 installed globally, run as:
# (env) foo@bar:~/Code/small_povray_projects/projects/hypercube_subspaces/tesseract/python$ ~/SageMath/sage c1_prep_tree_to_tess.sage


# SAGE variables start with an underscore.
_tesseract = LatticePolytope(tess_points)

_tuples_of_faces = _tesseract.faces()  # 6 tuples containing polytopes of dimensions -1 to 4.

# index       0  1  2  3  4  5
# dimension  -1  0  1  2  3  4
# rank           4  3  2  1  0

tree_to_tess = {}  # indices of tree points to lists of indices of tess points
for rank in range(4):
    dim = 4 - rank
    _tuple_of_faces = _tuples_of_faces[dim+1]
    for _face in _tuple_of_faces:
        sum_array = np.array((0, 0, 0, 0))
        face_vertex_indices = []
        _face_vertices = _face.faces()[1]
        for _wrapped_vertex in _face_vertices:
            _vertex = _wrapped_vertex.points()[0]  # something like M(-1, 1, -1, -1)
            vertex_array = np.array(_vertex)
            sum_array += vertex_array
            vertex_tuple = tuple(_vertex)
            vertex_index = tess_points.index(vertex_tuple)
            face_vertex_indices.append(vertex_index)

        face_center_array = sum_array / len(_face_vertices)
        face_center_tuple = tuple(face_center_array)
        face_center_index = tree_points.index(face_center_tuple) - 40
        tree_to_tess[face_center_index] = face_vertex_indices

tree_indices_of_tess_points = [-40, -38, -34, -32, -22, -20, -16, -14, 14, 16, 20, 22, 32, 34, 38, 40]  # A147991
for i in tree_indices_of_tess_points:
    tess_point = tree_points[i + 40]
    tess_point_index = tess_points.index(tess_point)
    tree_to_tess[i] = [tess_point_index]

for i in range(-40, 41):
    s = '{i}: {val},'.format(i=i, val=tree_to_tess[i])
    print(s)
