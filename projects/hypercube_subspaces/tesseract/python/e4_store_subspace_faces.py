subspaces1 = {
    '1a': {'vertices_positive': [1, 3, 9, 27], 'vertex_weight': 1},
    '1b': {'vertices_positive': [2, 4, 8, 10, 6, 12, 26, 28, 24, 30, 18, 36], 'vertex_weight': 2},
    '1c': {'vertices_positive': [5, 7, 11, 13, 23, 25, 29, 31, 17, 19, 35, 37, 15, 21, 33, 39], 'vertex_weight': 3},
    '1d': {'vertices_positive': [14, 16, 20, 22, 32, 34, 38, 40], 'vertex_weight': 4},
}


strings = [
    '0',

    '1a0', '1a1', '1a2', '1a3',
    '1b00', '1b01', '1b02', '1b03', '1b04', '1b05', '1b06', '1b07', '1b08', '1b09', '1b10', '1b11',
    '1c00', '1c01', '1c02', '1c03', '1c04', '1c05', '1c06', '1c07', '1c08', '1c09', '1c10', '1c11', '1c12', '1c13', '1c14', '1c15',
    '1d0', '1d1', '1d2', '1d3', '1d4', '1d5', '1d6', '1d7',

    '2a0', '2a1', '2a2', '2a3', '2a4', '2a5',
    '2b00', '2b01', '2b02', '2b03', '2b04', '2b05', '2b06', '2b07', '2b08', '2b09', '2b10', '2b11', '2b12', '2b13', '2b14', '2b15', '2b16', '2b17', '2b18', '2b19', '2b20', '2b21', '2b22', '2b23',
    '2c00', '2c01', '2c02', '2c03', '2c04', '2c05', '2c06', '2c07', '2c08', '2c09', '2c10', '2c11',
    '2d00', '2d01', '2d02', '2d03', '2d04', '2d05', '2d06', '2d07', '2d08', '2d09', '2d10', '2d11', '2d12', '2d13', '2d14', '2d15',

    '3a0', '3a1', '3a2', '3a3',
    '3b00', '3b01', '3b02', '3b03', '3b04', '3b05', '3b06', '3b07', '3b08', '3b09', '3b10', '3b11',

    '4'
]


# The POV-Ray equivalent of `subspaces2` and `subspaces3` is in `subspaces_2_3.inc`.

subspaces2 = {

    '2a0': {
        'vertices_positive': [2, 4],
        'vertex_weight': 2,
        'edges': [[2, -4], [-2, -4], [-2, 4], [2, 4]],
        'edge_weights': [1, 1, 1, 1],
        'faces': [[-2, -4, 2, 4]],
        'face_weights': [0],
    },
    '2a1': {
        'vertices_positive': [8, 10],
        'vertex_weight': 2,
        'edges': [[8, -10], [-8, -10], [-8, 10], [8, 10]],
        'edge_weights': [1, 1, 1, 1],
        'faces': [[-8, -10, 8, 10]],
        'face_weights': [0],
    },
    '2a2': {
        'vertices_positive': [6, 12],
        'vertex_weight': 2,
        'edges': [[6, -12], [-6, -12], [-6, 12], [6, 12]],
        'edge_weights': [1, 1, 1, 1],
        'faces': [[-6, -12, 6, 12]],
        'face_weights': [0],
    },
    '2a3': {
        'vertices_positive': [26, 28],
        'vertex_weight': 2,
        'edges': [[26, -28], [-26, -28], [-26, 28], [26, 28]],
        'edge_weights': [1, 1, 1, 1],
        'faces': [[-26, -28, 26, 28]],
        'face_weights': [0],
    },
    '2a4': {
        'vertices_positive': [24, 30],
        'vertex_weight': 2,
        'edges': [[24, -30], [-24, -30], [-24, 30], [24, 30]],
        'edge_weights': [1, 1, 1, 1],
        'faces': [[-24, -30, 24, 30]],
        'face_weights': [0],
    },
    '2a5': {
        'vertices_positive': [18, 36],
        'vertex_weight': 2,
        'edges': [[18, -36], [-18, -36], [-18, 36], [18, 36]],
        'edge_weights': [1, 1, 1, 1],
        'faces': [[-18, -36, 18, 36]],
        'face_weights': [0],
    },

    '2b00': {
        'vertices_positive': [5, 7],
        'vertex_weight': 3,
        'edges': [[5, -7], [5, 7], [-5, 7], [-5, -7]],
        'edge_weights': [1, 2, 1, 2],
        'faces': [[-5, -7, 5, 7]],
        'face_weights': [0],
    },
    '2b01': {
        'vertices_positive': [5, 11],
        'vertex_weight': 3,
        'edges': [[5, 11], [5, -11], [-5, -11], [-5, 11]],
        'edge_weights': [2, 1, 2, 1],
        'faces': [[-5, 11, 5, -11]],
        'face_weights': [0],
    },
    '2b02': {
        'vertices_positive': [7, 11],
        'vertex_weight': 3,
        'edges': [[-7, 11], [-7, -11], [7, -11], [7, 11]],
        'edge_weights': [2, 1, 2, 1],
        'faces': [[7, 11, -7, -11]],
        'face_weights': [0],
    },
    '2b03': {
        'vertices_positive': [5, 13],
        'vertex_weight': 3,
        'edges': [[5, -13], [-5, -13], [-5, 13], [5, 13]],
        'edge_weights': [2, 1, 2, 1],
        'faces': [[-5, -13, 5, 13]],
        'face_weights': [0],
    },
    '2b04': {
        'vertices_positive': [7, 13],
        'vertex_weight': 3,
        'edges': [[-7, -13], [7, -13], [7, 13], [-7, 13]],
        'edge_weights': [2, 1, 2, 1],
        'faces': [[7, -13, -7, 13]],
        'face_weights': [0],
    },
    '2b05': {
        'vertices_positive': [11, 13],
        'vertex_weight': 3,
        'edges': [[11, -13], [-11, -13], [-11, 13], [11, 13]],
        'edge_weights': [1, 2, 1, 2],
        'faces': [[-11, -13, 11, 13]],
        'face_weights': [0],
    },
    '2b06': {
        'vertices_positive': [23, 25],
        'vertex_weight': 3,
        'edges': [[23, -25], [23, 25], [-23, 25], [-23, -25]],
        'edge_weights': [1, 2, 1, 2],
        'faces': [[-23, -25, 23, 25]],
        'face_weights': [0],
    },
    '2b07': {
        'vertices_positive': [23, 29],
        'vertex_weight': 3,
        'edges': [[23, 29], [23, -29], [-23, -29], [-23, 29]],
        'edge_weights': [2, 1, 2, 1],
        'faces': [[-23, 29, 23, -29]],
        'face_weights': [0],
    },
    '2b08': {
        'vertices_positive': [25, 29],
        'vertex_weight': 3,
        'edges': [[-25, 29], [-25, -29], [25, -29], [25, 29]],
        'edge_weights': [2, 1, 2, 1],
        'faces': [[25, 29, -25, -29]],
        'face_weights': [0],
    },
    '2b09': {
        'vertices_positive': [23, 31],
        'vertex_weight': 3,
        'edges': [[23, -31], [-23, -31], [-23, 31], [23, 31]],
        'edge_weights': [2, 1, 2, 1],
        'faces': [[-23, -31, 23, 31]],
        'face_weights': [0],
    },
    '2b10': {
        'vertices_positive': [25, 31],
        'vertex_weight': 3,
        'edges': [[-25, -31], [25, -31], [25, 31], [-25, 31]],
        'edge_weights': [2, 1, 2, 1],
        'faces': [[25, -31, -25, 31]],
        'face_weights': [0],
    },
    '2b11': {
        'vertices_positive': [29, 31],
        'vertex_weight': 3,
        'edges': [[29, -31], [-29, -31], [-29, 31], [29, 31]],
        'edge_weights': [1, 2, 1, 2],
        'faces': [[-29, -31, 29, 31]],
        'face_weights': [0],
    },
    '2b12': {
        'vertices_positive': [17, 19],
        'vertex_weight': 3,
        'edges': [[17, -19], [17, 19], [-17, 19], [-17, -19]],
        'edge_weights': [1, 2, 1, 2],
        'faces': [[-17, -19, 17, 19]],
        'face_weights': [0],
    },
    '2b13': {
        'vertices_positive': [17, 35],
        'vertex_weight': 3,
        'edges': [[17, 35], [17, -35], [-17, -35], [-17, 35]],
        'edge_weights': [2, 1, 2, 1],
        'faces': [[-17, 35, 17, -35]],
        'face_weights': [0],
    },
    '2b14': {
        'vertices_positive': [19, 35],
        'vertex_weight': 3,
        'edges': [[-19, 35], [-19, -35], [19, -35], [19, 35]],
        'edge_weights': [2, 1, 2, 1],
        'faces': [[19, 35, -19, -35]],
        'face_weights': [0],
    },
    '2b15': {
        'vertices_positive': [17, 37],
        'vertex_weight': 3,
        'edges': [[17, -37], [-17, -37], [-17, 37], [17, 37]],
        'edge_weights': [2, 1, 2, 1],
        'faces': [[-17, -37, 17, 37]],
        'face_weights': [0],
    },
    '2b16': {
        'vertices_positive': [19, 37],
        'vertex_weight': 3,
        'edges': [[-19, -37], [19, -37], [19, 37], [-19, 37]],
        'edge_weights': [2, 1, 2, 1],
        'faces': [[19, -37, -19, 37]],
        'face_weights': [0],
    },
    '2b17': {
        'vertices_positive': [35, 37],
        'vertex_weight': 3,
        'edges': [[35, -37], [-35, -37], [-35, 37], [35, 37]],
        'edge_weights': [1, 2, 1, 2],
        'faces': [[-35, -37, 35, 37]],
        'face_weights': [0],
    },
    '2b18': {
        'vertices_positive': [15, 21],
        'vertex_weight': 3,
        'edges': [[15, -21], [15, 21], [-15, 21], [-15, -21]],
        'edge_weights': [1, 2, 1, 2],
        'faces': [[-15, -21, 15, 21]],
        'face_weights': [0],
    },
    '2b19': {
        'vertices_positive': [15, 33],
        'vertex_weight': 3,
        'edges': [[15, 33], [15, -33], [-15, -33], [-15, 33]],
        'edge_weights': [2, 1, 2, 1],
        'faces': [[-15, 33, 15, -33]],
        'face_weights': [0],
    },
    '2b20': {
        'vertices_positive': [21, 33],
        'vertex_weight': 3,
        'edges': [[-21, 33], [-21, -33], [21, -33], [21, 33]],
        'edge_weights': [2, 1, 2, 1],
        'faces': [[21, 33, -21, -33]],
        'face_weights': [0],
    },
    '2b21': {
        'vertices_positive': [15, 39],
        'vertex_weight': 3,
        'edges': [[15, -39], [-15, -39], [-15, 39], [15, 39]],
        'edge_weights': [2, 1, 2, 1],
        'faces': [[-15, -39, 15, 39]],
        'face_weights': [0],
    },
    '2b22': {
        'vertices_positive': [21, 39],
        'vertex_weight': 3,
        'edges': [[-21, -39], [21, -39], [21, 39], [-21, 39]],
        'edge_weights': [2, 1, 2, 1],
        'faces': [[21, -39, -21, 39]],
        'face_weights': [0],
    },
    '2b23': {
        'vertices_positive': [33, 39],
        'vertex_weight': 3,
        'edges': [[33, -39], [-33, -39], [-33, 39], [33, 39]],
        'edge_weights': [1, 2, 1, 2],
        'faces': [[-33, -39, 33, 39]],
        'face_weights': [0],
    },

    '2c00': {
        'vertices_positive': [16, 20],
        'vertex_weight': 4,
        'edges': [[-16, 20], [16, 20], [16, -20], [-16, -20]],
        'edge_weights': [2, 2, 2, 2],
        'faces': [[16, 20, -16, -20]],
        'face_weights': [0],
    },
    '2c01': {
        'vertices_positive': [14, 22],
        'vertex_weight': 4,
        'edges': [[14, -22], [14, 22], [-14, 22], [-14, -22]],
        'edge_weights': [2, 2, 2, 2],
        'faces': [[-14, -22, 14, 22]],
        'face_weights': [0],
    },
    '2c02': {
        'vertices_positive': [16, 32],
        'vertex_weight': 4,
        'edges': [[-16, 32], [16, 32], [16, -32], [-16, -32]],
        'edge_weights': [2, 2, 2, 2],
        'faces': [[16, 32, -16, -32]],
        'face_weights': [0],
    },
    '2c03': {
        'vertices_positive': [20, 32],
        'vertex_weight': 4,
        'edges': [[20, 32], [-20, 32], [-20, -32], [20, -32]],
        'edge_weights': [2, 2, 2, 2],
        'faces': [[-20, 32, 20, -32]],
        'face_weights': [0],
    },
    '2c04': {
        'vertices_positive': [14, 34],
        'vertex_weight': 4,
        'edges': [[14, -34], [14, 34], [-14, 34], [-14, -34]],
        'edge_weights': [2, 2, 2, 2],
        'faces': [[-14, -34, 14, 34]],
        'face_weights': [0],
    },
    '2c05': {
        'vertices_positive': [22, 34],
        'vertex_weight': 4,
        'edges': [[-22, -34], [-22, 34], [22, 34], [22, -34]],
        'edge_weights': [2, 2, 2, 2],
        'faces': [[22, -34, -22, 34]],
        'face_weights': [0],
    },
    '2c06': {
        'vertices_positive': [14, 38],
        'vertex_weight': 4,
        'edges': [[14, 38], [14, -38], [-14, -38], [-14, 38]],
        'edge_weights': [2, 2, 2, 2],
        'faces': [[-14, 38, 14, -38]],
        'face_weights': [0],
    },
    '2c07': {
        'vertices_positive': [22, 38],
        'vertex_weight': 4,
        'edges': [[-22, 38], [-22, -38], [22, -38], [22, 38]],
        'edge_weights': [2, 2, 2, 2],
        'faces': [[22, 38, -22, -38]],
        'face_weights': [0],
    },
    '2c08': {
        'vertices_positive': [34, 38],
        'vertex_weight': 4,
        'edges': [[-34, 38], [-34, -38], [34, -38], [34, 38]],
        'edge_weights': [2, 2, 2, 2],
        'faces': [[34, 38, -34, -38]],
        'face_weights': [0],
    },
    '2c09': {
        'vertices_positive': [16, 40],
        'vertex_weight': 4,
        'edges': [[-16, -40], [16, -40], [16, 40], [-16, 40]],
        'edge_weights': [2, 2, 2, 2],
        'faces': [[16, -40, -16, 40]],
        'face_weights': [0],
    },
    '2c10': {
        'vertices_positive': [20, 40],
        'vertex_weight': 4,
        'edges': [[20, -40], [-20, -40], [-20, 40], [20, 40]],
        'edge_weights': [2, 2, 2, 2],
        'faces': [[-20, -40, 20, 40]],
        'face_weights': [0],
    },
    '2c11': {
        'vertices_positive': [32, 40],
        'vertex_weight': 4,
        'edges': [[32, -40], [-32, -40], [-32, 40], [32, 40]],
        'edge_weights': [2, 2, 2, 2],
        'faces': [[-32, -40, 32, 40]],
        'face_weights': [0],
    },

    '2d00': {
        'vertices_positive': [14, 16],
        'vertex_weight': 4,
        'edges': [[14, -16], [14, 16], [-14, 16], [-14, -16]],
        'edge_weights': [1, 3, 1, 3],
        'faces': [[-14, -16, 14, 16]],
        'face_weights': [0],
    },
    '2d01': {
        'vertices_positive': [14, 20],
        'vertex_weight': 4,
        'edges': [[14, 20], [14, -20], [-14, -20], [-14, 20]],
        'edge_weights': [3, 1, 3, 1],
        'faces': [[-14, 20, 14, -20]],
        'face_weights': [0],
    },
    '2d02': {
        'vertices_positive': [16, 22],
        'vertex_weight': 4,
        'edges': [[-16, -22], [16, -22], [16, 22], [-16, 22]],
        'edge_weights': [3, 1, 3, 1],
        'faces': [[16, -22, -16, 22]],
        'face_weights': [0],
    },
    '2d03': {
        'vertices_positive': [20, 22],
        'vertex_weight': 4,
        'edges': [[20, -22], [-20, -22], [-20, 22], [20, 22]],
        'edge_weights': [1, 3, 1, 3],
        'faces': [[-20, -22, 20, 22]],
        'face_weights': [0],
    },
    '2d04': {
        'vertices_positive': [14, 32],
        'vertex_weight': 4,
        'edges': [[14, 32], [14, -32], [-14, -32], [-14, 32]],
        'edge_weights': [3, 1, 3, 1],
        'faces': [[-14, 32, 14, -32]],
        'face_weights': [0],
    },
    '2d05': {
        'vertices_positive': [22, 32],
        'vertex_weight': 4,
        'edges': [[-22, 32], [-22, -32], [22, -32], [22, 32]],
        'edge_weights': [3, 1, 3, 1],
        'faces': [[22, 32, -22, -32]],
        'face_weights': [0],
    },
    '2d06': {
        'vertices_positive': [16, 34],
        'vertex_weight': 4,
        'edges': [[-16, -34], [16, -34], [16, 34], [-16, 34]],
        'edge_weights': [3, 1, 3, 1],
        'faces': [[16, -34, -16, 34]],
        'face_weights': [0],
    },
    '2d07': {
        'vertices_positive': [20, 34],
        'vertex_weight': 4,
        'edges': [[20, -34], [-20, -34], [-20, 34], [20, 34]],
        'edge_weights': [3, 1, 3, 1],
        'faces': [[-20, -34, 20, 34]],
        'face_weights': [0],
    },
    '2d08': {
        'vertices_positive': [32, 34],
        'vertex_weight': 4,
        'edges': [[32, -34], [32, 34], [-32, 34], [-32, -34]],
        'edge_weights': [1, 3, 1, 3],
        'faces': [[-32, -34, 32, 34]],
        'face_weights': [0],
    },
    '2d09': {
        'vertices_positive': [16, 38],
        'vertex_weight': 4,
        'edges': [[-16, 38], [-16, -38], [16, -38], [16, 38]],
        'edge_weights': [3, 1, 3, 1],
        'faces': [[16, 38, -16, -38]],
        'face_weights': [0],
    },
    '2d10': {
        'vertices_positive': [20, 38],
        'vertex_weight': 4,
        'edges': [[20, 38], [20, -38], [-20, -38], [-20, 38]],
        'edge_weights': [3, 1, 3, 1],
        'faces': [[-20, 38, 20, -38]],
        'face_weights': [0],
    },
    '2d11': {
        'vertices_positive': [32, 38],
        'vertex_weight': 4,
        'edges': [[32, 38], [32, -38], [-32, -38], [-32, 38]],
        'edge_weights': [3, 1, 3, 1],
        'faces': [[-32, 38, 32, -38]],
        'face_weights': [0],
    },
    '2d12': {
        'vertices_positive': [14, 40],
        'vertex_weight': 4,
        'edges': [[14, -40], [-14, -40], [-14, 40], [14, 40]],
        'edge_weights': [3, 1, 3, 1],
        'faces': [[-14, -40, 14, 40]],
        'face_weights': [0],
    },
    '2d13': {
        'vertices_positive': [22, 40],
        'vertex_weight': 4,
        'edges': [[-22, -40], [22, -40], [22, 40], [-22, 40]],
        'edge_weights': [3, 1, 3, 1],
        'faces': [[22, -40, -22, 40]],
        'face_weights': [0],
    },
    '2d14': {
        'vertices_positive': [34, 40],
        'vertex_weight': 4,
        'edges': [[-34, -40], [34, -40], [34, 40], [-34, 40]],
        'edge_weights': [3, 1, 3, 1],
        'faces': [[34, -40, -34, 40]],
        'face_weights': [0],
    },
    '2d15': {
        'vertices_positive': [38, 40],
        'vertex_weight': 4,
        'edges': [[38, -40], [-38, -40], [-38, 40], [38, 40]],
        'edge_weights': [1, 3, 1, 3],
        'faces': [[-38, -40, 38, 40]],
        'face_weights': [0],
    }

}


subspaces3 = {

    '3a0': {
        'vertices_positive': [5, 7, 11, 13],
        'vertex_weight': 3,
        'edges': [[5, 7], [-5, -7], [5, 11], [-7, 11], [-5, -11], [7, -11], [7, 13], [11, 13], [-5, 13], [5, -13], [-7, -13], [-11, -13]],
        'edge_weights': [2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2],
        'faces': [[7, 5, 11, 13], [11, -7, -5, 13], [7, -11, -5, 13], [5, 11, -7, -13], [-7, -5, -11, -13], [5, 7, -11, -13]],
        'face_weights': [1, 1, 1, 1, 1, 1],
    },
    '3a1': {
        'vertices_positive': [23, 25, 29, 31],
        'vertex_weight': 3,
        'edges': [[23, 25], [-23, -25], [23, 29], [-25, 29], [-23, -29], [25, -29], [25, 31], [29, 31], [-23, 31], [23, -31], [-25, -31], [-29, -31]],
        'edge_weights': [2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2],
        'faces': [[25, 23, 29, 31], [29, -25, -23, 31], [25, -29, -23, 31], [23, 29, -25, -31], [-25, -23, -29, -31], [23, 25, -29, -31]],
        'face_weights': [1, 1, 1, 1, 1, 1],
    },
    '3a2': {
        'vertices_positive': [17, 19, 35, 37],
        'vertex_weight': 3,
        'edges': [[17, 19], [-17, -19], [17, 35], [-19, 35], [-17, -35], [19, -35], [19, 37], [35, 37], [-17, 37], [17, -37], [-19, -37], [-35, -37]],
        'edge_weights': [2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2],
        'faces': [[19, 17, 35, 37], [35, -19, -17, 37], [19, -35, -17, 37], [17, 35, -19, -37], [-19, -17, -35, -37], [17, 19, -35, -37]],
        'face_weights': [1, 1, 1, 1, 1, 1],
    },
    '3a3': {
        'vertices_positive': [15, 21, 33, 39],
        'vertex_weight': 3,
        'edges': [[15, 21], [-15, -21], [15, 33], [-21, 33], [-15, -33], [21, -33], [21, 39], [33, 39], [-15, 39], [15, -39], [-21, -39], [-33, -39]],
        'edge_weights': [2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2],
        'faces': [[21, 15, 33, 39], [33, -21, -15, 39], [21, -33, -15, 39], [15, 33, -21, -39], [-21, -15, -33, -39], [15, 21, -33, -39]],
        'face_weights': [1, 1, 1, 1, 1, 1],
    },

    '3b00': {
        'vertices_positive': [14, 16, 20, 22],
        'vertex_weight': 4,
        'edges': [[14, 16], [-14, -16], [14, 20], [-16, 20], [-14, -20], [16, -20], [16, 22], [20, 22], [-14, 22], [14, -22], [-16, -22], [-20, -22]],
        'edge_weights': [3, 3, 3, 2, 3, 2, 3, 3, 2, 2, 3, 3],
        'faces': [[-16, -14, -20, -22], [20, -16, -14, 22], [16, -20, -14, 22], [14, 20, -16, -22], [16, 14, 20, 22], [14, 16, -20, -22]],
        'face_weights': [2, 1, 1, 1, 2, 1],
    },
    '3b01': {
        'vertices_positive': [14, 16, 32, 34],
        'vertex_weight': 4,
        'edges': [[14, 16], [-14, -16], [14, 32], [-16, 32], [-14, -32], [16, -32], [16, 34], [32, 34], [-14, 34], [14, -34], [-16, -34], [-32, -34]],
        'edge_weights': [3, 3, 3, 2, 3, 2, 3, 3, 2, 2, 3, 3],
        'faces': [[32, -16, -14, 34], [-16, -14, -32, -34], [16, -32, -14, 34], [14, 32, -16, -34], [14, 16, -32, -34], [16, 14, 32, 34]],
        'face_weights': [1, 2, 1, 1, 1, 2],
    },
    '3b02': {
        'vertices_positive': [20, 22, 32, 34],
        'vertex_weight': 4,
        'edges': [[20, 22], [-20, -22], [20, 32], [-22, 32], [-20, -32], [22, -32], [22, 34], [32, 34], [-20, 34], [20, -34], [-22, -34], [-32, -34]],
        'edge_weights': [3, 3, 2, 3, 2, 3, 2, 3, 3, 3, 2, 3],
        'faces': [[22, 20, 32, 34], [20, 22, -32, -34], [22, -32, -20, 34], [20, 32, -22, -34], [-22, -20, -32, -34], [32, -22, -20, 34]],
        'face_weights': [1, 2, 1, 1, 1, 2],
    },
    '3b03': {
        'vertices_positive': [14, 20, 32, 38],
        'vertex_weight': 4,
        'edges': [[14, 20], [-14, -20], [14, 32], [-20, 32], [-14, -32], [20, -32], [20, 38], [32, 38], [-14, 38], [14, -38], [-20, -38], [-32, -38]],
        'edge_weights': [3, 3, 3, 2, 3, 2, 3, 3, 2, 2, 3, 3],
        'faces': [[32, -20, -14, 38], [20, -32, -14, 38], [-20, -14, -32, -38], [20, 14, 32, 38], [14, 20, -32, -38], [14, 32, -20, -38]],
        'face_weights': [1, 1, 2, 2, 1, 1],
    },
    '3b04': {
        'vertices_positive': [16, 22, 32, 38],
        'vertex_weight': 4,
        'edges': [[16, 22], [-16, -22], [16, 32], [-22, 32], [-16, -32], [22, -32], [22, 38], [32, 38], [-16, 38], [16, -38], [-22, -38], [-32, -38]],
        'edge_weights': [3, 3, 2, 3, 2, 3, 2, 3, 3, 3, 2, 3],
        'faces': [[22, 16, 32, 38], [22, -32, -16, 38], [16, 22, -32, -38], [32, -22, -16, 38], [-22, -16, -32, -38], [16, 32, -22, -38]],
        'face_weights': [1, 1, 2, 2, 1, 1],
    },
    '3b05': {
        'vertices_positive': [16, 20, 34, 38],
        'vertex_weight': 4,
        'edges': [[16, 20], [-16, -20], [16, 34], [-20, 34], [-16, -34], [20, -34], [20, 38], [34, 38], [-16, 38], [16, -38], [-20, -38], [-34, -38]],
        'edge_weights': [2, 2, 3, 3, 3, 3, 3, 2, 3, 3, 3, 2],
        'faces': [[20, 16, 34, 38], [34, -20, -16, 38], [16, 34, -20, -38], [20, -34, -16, 38], [-20, -16, -34, -38], [16, 20, -34, -38]],
        'face_weights': [1, 1, 2, 2, 1, 1],
    },
    '3b06': {
        'vertices_positive': [14, 22, 32, 40],
        'vertex_weight': 4,
        'edges': [[14, 22], [-14, -22], [14, 32], [-22, 32], [-14, -32], [22, -32], [22, 40], [32, 40], [-14, 40], [14, -40], [-22, -40], [-32, -40]],
        'edge_weights': [2, 2, 3, 3, 3, 3, 3, 2, 3, 3, 3, 2],
        'faces': [[22, 14, 32, 40], [32, -22, -14, 40], [22, -32, -14, 40], [14, 32, -22, -40], [-22, -14, -32, -40], [14, 22, -32, -40]],
        'face_weights': [1, 1, 2, 2, 1, 1],
    },
    '3b07': {
        'vertices_positive': [14, 20, 34, 40],
        'vertex_weight': 4,
        'edges': [[14, 20], [-14, -20], [14, 34], [-20, 34], [-14, -34], [20, -34], [20, 40], [34, 40], [-14, 40], [14, -40], [-20, -40], [-34, -40]],
        'edge_weights': [3, 3, 2, 3, 2, 3, 2, 3, 3, 3, 2, 3],
        'faces': [[20, 14, 34, 40], [20, -34, -14, 40], [34, -20, -14, 40], [14, 20, -34, -40], [-20, -14, -34, -40], [14, 34, -20, -40]],
        'face_weights': [1, 1, 2, 2, 1, 1],
    },
    '3b08': {
        'vertices_positive': [16, 22, 34, 40],
        'vertex_weight': 4,
        'edges': [[16, 22], [-16, -22], [16, 34], [-22, 34], [-16, -34], [22, -34], [22, 40], [34, 40], [-16, 40], [16, -40], [-22, -40], [-34, -40]],
        'edge_weights': [3, 3, 3, 2, 3, 2, 3, 3, 2, 2, 3, 3],
        'faces': [[34, -22, -16, 40], [22, -34, -16, 40], [22, 16, 34, 40], [-22, -16, -34, -40], [16, 22, -34, -40], [16, 34, -22, -40]],
        'face_weights': [1, 1, 2, 2, 1, 1],
    },
    '3b09': {
        'vertices_positive': [14, 16, 38, 40],
        'vertex_weight': 4,
        'edges': [[14, 16], [-14, -16], [14, 38], [-16, 38], [-14, -38], [16, -38], [16, 40], [38, 40], [-14, 40], [14, -40], [-16, -40], [-38, -40]],
        'edge_weights': [3, 3, 2, 3, 2, 3, 2, 3, 3, 3, 2, 3],
        'faces': [[16, 14, 38, 40], [38, -16, -14, 40], [16, -38, -14, 40], [14, 38, -16, -40], [-16, -14, -38, -40], [14, 16, -38, -40]],
        'face_weights': [1, 2, 1, 1, 1, 2],
    },
    '3b10': {
        'vertices_positive': [20, 22, 38, 40],
        'vertex_weight': 4,
        'edges': [[20, 22], [-20, -22], [20, 38], [-22, 38], [-20, -38], [22, -38], [22, 40], [38, 40], [-20, 40], [20, -40], [-22, -40], [-38, -40]],
        'edge_weights': [3, 3, 3, 2, 3, 2, 3, 3, 2, 2, 3, 3],
        'faces': [[38, -22, -20, 40], [22, 20, 38, 40], [22, -38, -20, 40], [20, 38, -22, -40], [20, 22, -38, -40], [-22, -20, -38, -40]],
        'face_weights': [1, 2, 1, 1, 1, 2],
    },
    '3b11': {
        'vertices_positive': [32, 34, 38, 40],
        'vertex_weight': 4,
        'edges': [[32, 34], [-32, -34], [32, 38], [-34, 38], [-32, -38], [34, -38], [34, 40], [38, 40], [-32, 40], [32, -40], [-34, -40], [-38, -40]],
        'edge_weights': [3, 3, 3, 2, 3, 2, 3, 3, 2, 2, 3, 3],
        'faces': [[34, 32, 38, 40], [38, -34, -32, 40], [34, -38, -32, 40], [32, 38, -34, -40], [-34, -32, -38, -40], [32, 34, -38, -40]],
        'face_weights': [2, 1, 1, 1, 2, 1],
    }

}