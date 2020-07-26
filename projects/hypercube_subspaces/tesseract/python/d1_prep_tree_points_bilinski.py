from sympy import sqrt
import numpy as np
from math import isclose

from c2_store_tree_to_tess import tree_to_tess


phi = (1 + sqrt(5)) / 2
phi2 = phi**2

# https://commons.wikimedia.org/wiki/File:Bilinski_dodecahedron_(gray),_numbers.png
tess_points_bilinski_jumbled = [
    (0, -phi2, 0), (0, phi2, 0),
    (0, -1, -1), (0, -1, 1), (0, 1, -1), (0, 1, 1),
    (-phi, -phi, 0), (phi, -phi, 0), (-phi, phi, 0), (phi, phi, 0),
    (-phi, 0, -1), (-phi, 0, 1), (phi, 0, -1), (phi, 0, 1),
    (0, -2 * phi + phi2, 0), (0, 2 * phi - phi2, 0)
]
unjumble = [0, 6, 2, 10,   3, 11, 15, 8,   7, 14, 12, 4,   13, 5, 9, 1]
tess_points_bilinski = [tess_points_bilinski_jumbled[index] for index in unjumble]

tree_points_bilinski_dirty = {}
for tree_index, list_of_tess_indices in tree_to_tess.items():
    sum_array = np.array((0, 0, phi-phi))  # change type to allow addition
    for tess_index in list_of_tess_indices:
        tess_point_bilinski = tess_points_bilinski[tess_index]
        tess_point_bilinski_array = np.array(tess_point_bilinski)
        sum_array += np.array(tess_point_bilinski)
    tree_point_bilinski = tuple(
        sum_array / len(list_of_tess_indices)
    )
    tree_points_bilinski_dirty[tree_index] = tree_point_bilinski

abs_values_dirty = []
for triple in tree_points_bilinski_dirty.values():
    for val in triple:
        abs_values_dirty.append(abs(val))

abs_values_dirty = set(abs_values_dirty)
# This set contains unsimplified expressions and duplicates.
# The simplification below was created with Wolfram Alpha, but `sympy.simplify` would have worked as well.
# These are the 12 different positive values:
abs_values = [
    3/4 - sqrt(5)/4,   # 0.190983
    -1/4 + sqrt(5)/4,  # 0.309017
    1/2,               # 0.5
    -1/2 + sqrt(5)/2,  # 0.618034
    1/4 + sqrt(5)/4,   # 0.809017
    1,                 # 1
    sqrt(5)/2,         # 1.118034
    sqrt(5)/4 + 3/4,   # 1.309017
    1/2 + sqrt(5)/2,   # 1.618034
    sqrt(5)/4 + 5/4,   # 1.809017
    1 + sqrt(5)/2,     # 2.118034
    sqrt(5)/2 + 3/2    # 2.618034
]

for tree_index, triple_dirty in tree_points_bilinski_dirty.items():
    triple_strings = []
    for dirtval in triple_dirty:
        if dirtval == 0:
            triple_strings.append('0')
        else:
            sign_string = '-' if dirtval < 0 else ''
            for key, val in enumerate(abs_values):
                if isclose(val, abs(dirtval)):
                    triple_strings.append('{s}a[{k}]'.format(s=sign_string, k=key))
    s = '{i}: ({x}, {y}, {z}),'.format(i=tree_index, x=triple_strings[0], y=triple_strings[1], z=triple_strings[2])
    print(s)
