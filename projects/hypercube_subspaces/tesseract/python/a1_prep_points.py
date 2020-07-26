from itertools import product
import numpy as np


range_hollow = (-1, 1)
ranges_hollow = 4 * [range_hollow]
tess_points_lex = product(*ranges_hollow)
tess_points = [p[::-1] for p in tess_points_lex]
print(tess_points, '\n')

range_full = (-1, 0, 1)
ranges_full = 4 * [range_full]
tree_points_lex = product(*ranges_full)
tree_points = [p[::-1] for p in tree_points_lex]
print(tree_points, '\n')

tree_point_weights = []
for point in tree_points:
    count = np.count_nonzero(point)
    tree_point_weights.append(count)
print(tree_point_weights)