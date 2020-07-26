# indices of tree points (tesseract face centers) to lists of indices of tess points (tesseract vertices)
tree_to_tess = {
    -40: [0],
    -39: [0, 1],
    -38: [1],
    -37: [0, 2],
    -36: [0, 1, 2, 3],
    -35: [1, 3],
    -34: [2],
    -33: [2, 3],
    -32: [3],
    -31: [0, 4],
    -30: [0, 1, 4, 5],
    -29: [1, 5],
    -28: [0, 2, 4, 6],
    -27: [0, 1, 2, 3, 4, 5, 6, 7],
    -26: [1, 3, 5, 7],
    -25: [2, 6],
    -24: [2, 3, 6, 7],
    -23: [3, 7],
    -22: [4],
    -21: [4, 5],
    -20: [5],
    -19: [4, 6],
    -18: [4, 5, 6, 7],
    -17: [5, 7],
    -16: [6],
    -15: [6, 7],
    -14: [7],
    -13: [0, 8],
    -12: [0, 1, 8, 9],
    -11: [1, 9],
    -10: [0, 2, 8, 10],
    -9: [0, 1, 2, 3, 8, 9, 10, 11],
    -8: [1, 3, 9, 11],
    -7: [2, 10],
    -6: [2, 3, 10, 11],
    -5: [3, 11],
    -4: [0, 4, 8, 12],
    -3: [0, 1, 4, 5, 8, 9, 12, 13],
    -2: [1, 5, 9, 13],
    -1: [0, 2, 4, 6, 8, 10, 12, 14],
    0: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15],
    1: [1, 3, 5, 7, 9, 11, 13, 15],
    2: [2, 6, 10, 14],
    3: [2, 3, 6, 7, 10, 11, 14, 15],
    4: [3, 7, 11, 15],
    5: [4, 12],
    6: [4, 5, 12, 13],
    7: [5, 13],
    8: [4, 6, 12, 14],
    9: [4, 5, 6, 7, 12, 13, 14, 15],
    10: [5, 7, 13, 15],
    11: [6, 14],
    12: [6, 7, 14, 15],
    13: [7, 15],
    14: [8],
    15: [8, 9],
    16: [9],
    17: [8, 10],
    18: [8, 9, 10, 11],
    19: [9, 11],
    20: [10],
    21: [10, 11],
    22: [11],
    23: [8, 12],
    24: [8, 9, 12, 13],
    25: [9, 13],
    26: [8, 10, 12, 14],
    27: [8, 9, 10, 11, 12, 13, 14, 15],
    28: [9, 11, 13, 15],
    29: [10, 14],
    30: [10, 11, 14, 15],
    31: [11, 15],
    32: [12],
    33: [12, 13],
    34: [13],
    35: [12, 14],
    36: [12, 13, 14, 15],
    37: [13, 15],
    38: [14],
    39: [14, 15],
    40: [15]
}