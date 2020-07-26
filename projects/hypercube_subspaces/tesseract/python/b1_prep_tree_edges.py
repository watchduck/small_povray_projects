import numpy as np

from a2_store_points import tree_points, tree_point_weights


edges = []

for index1 in range(81):
    point1 = np.array(tree_points[index1])
    weight1 = tree_point_weights[index1]

    for index2 in range(81):
        point2 = np.array(tree_points[index2])
        weight2 = tree_point_weights[index2]

        if weight1 + 1 == weight2:
            diff = point1 - point2
            if np.count_nonzero(diff) == 1:
                edges.append((weight1, index1-40, index2-40))

print(len(edges), '\n')

print(sorted(edges))
