from e1_store_subspaces import fixed4, primary_weights

indices_by_weight = [
    [0],  # dummy
    [1, 3, 9, 27],
    [2, 4, 8, 10, 6, 12, 26, 28, 24, 30, 18, 36],
    [5, 7, 11, 13, 23, 25, 29, 31, 17, 19, 35, 37, 15, 21, 33, 39],
    [14, 16, 20, 22, 32, 34, 38, 40]
]

for weight in [1, 2, 3, 4]:
    weight_dict = fixed4[weight]

    for pattern_short, list_of_bundles in weight_dict.items():

        print('#################################', pattern_short)

        list_of_bundles_with_sorting_tuples = []

        for colex_bundle_index, bundle in enumerate(list_of_bundles):

            sorting_list = [0, 0, 0, 0, 0]

            for vertex in bundle:
                vertex_weight = primary_weights[vertex]
                list_index_of_vertex = indices_by_weight[vertex_weight].index(vertex)
                sorting_list[vertex_weight] += 2**list_index_of_vertex

            list_of_bundles_with_sorting_tuples.append((
                tuple(sorting_list),
                colex_bundle_index,
                bundle
            ))

        list_of_bundles_with_sorting_tuples = sorted(list_of_bundles_with_sorting_tuples)

        list_of_colex_indices = [index for dummy1, index, dummy2 in list_of_bundles_with_sorting_tuples]
        print(list_of_colex_indices)

# moved to `lex4` in e1_store_subspaces.py
