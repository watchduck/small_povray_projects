import numpy as np

from a_store_points4 import points4, points4_repr


bases4 = [[-1, 1, 1], [1, -1, 1], [1, 1, -1]]  # -++-, +-+- and ++-- without the last digit (always minus)
bases3 = [[2, 0, 0], [0, 2, 0], [0, 0, 2]]

points3 = []
repr_indices = []

for point4_raw in points4:

    point4_repr = tuple(sorted(point4_raw))
    repr_index = points4_repr.index(point4_repr)
    repr_indices.append(repr_index)

    point4 = np.array(point4_raw[:3]) - 1.5
    scalars = np.linalg.solve(bases4, point4)  # These scalars times the respecive bases give point3 or point4.

    point3 = np.zeros(3)
    for i, scalar in enumerate(scalars):
        point3 += scalar * np.array(bases3[i])
    point3 = [int(item) for item in point3]
    points3.append(tuple(point3))

print(points3)
print(repr_indices)

