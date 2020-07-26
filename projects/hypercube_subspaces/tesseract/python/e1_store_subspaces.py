# This is the part of https://pastebin.com/fWt41syt that is relevant for the tesseract.


# The number of face centers of the tesseract is 3^4 = 81.
# In the following list only half of the non-origin points are shown. The rest can be created by inverting the signs.
# The shown tuples have non-negative values as (little-endian) balanced ternary numbers.
points4 = [
    (0, 0, 0, 0), (1, 0, 0, 0),  # 0, 1
    (-1, 1, 0, 0), (0, 1, 0, 0), (1, 1, 0, 0),  # 2, 3, 4

    (-1, -1, 1, 0), (0, -1, 1, 0), (1, -1, 1, 0),  # 5, 6, 7
    (-1, 0, 1, 0), (0, 0, 1, 0), (1, 0, 1, 0),  # 8, 9, 10
    (-1, 1, 1, 0), (0, 1, 1, 0), (1, 1, 1, 0),  # 11, 12, 13


    (-1, -1, -1, 1), (0, -1, -1, 1), (1, -1, -1, 1),  # 14, 15, 16
    (-1, 0, -1, 1), (0, 0, -1, 1), (1, 0, -1, 1),  # 17, 18, 19
    (-1, 1, -1, 1), (0, 1, -1, 1), (1, 1, -1, 1),  # 20, 21, 22

    (-1, -1, 0, 1), (0, -1, 0, 1), (1, -1, 0, 1),  # 23, 24, 25
    (-1, 0, 0, 1), (0, 0, 0, 1), (1, 0, 0, 1),  # 26, 27, 28
    (-1, 1, 0, 1), (0, 1, 0, 1), (1, 1, 0, 1),  # 29, 30, 31

    (-1, -1, 1, 1), (0, -1, 1, 1), (1, -1, 1, 1),  # 32, 33, 34
    (-1, 0, 1, 1), (0, 0, 1, 1), (1, 0, 1, 1),  # 35, 36, 37
    (-1, 1, 1, 1), (0, 1, 1, 1), (1, 1, 1, 1)  # 38, 39, 40
]


# These are the places of non-zero entries in the tuples above.
secondary_weights_as_tuples = [
    (), (0,),  # 0, 1
    (0, 1), (1,), (0, 1),  # 2, 3, 4

    (0, 1, 2), (1, 2), (0, 1, 2),  # 5, 6, 7
    (0, 2), (2,), (0, 2),  # 8, 9, 10
    (0, 1, 2), (1, 2), (0, 1, 2),  # 11, 12, 13


    (0, 1, 2, 3), (1, 2, 3), (0, 1, 2, 3),  # 14, 15, 16
    (0, 2, 3), (2, 3), (0, 2, 3),  # 17, 18, 19
    (0, 1, 2, 3), (1, 2, 3), (0, 1, 2, 3),  # 20, 21, 22

    (0, 1, 3), (1, 3), (0, 1, 3),  # 23, 24, 25
    (0, 3), (3,), (0, 3),  # 26, 27, 28
    (0, 1, 3), (1, 3), (0, 1, 3),  # 29, 30, 31

    (0, 1, 2, 3), (1, 2, 3), (0, 1, 2, 3),  # 32, 33, 34
    (0, 2, 3), (2, 3), (0, 2, 3),  # 35, 36, 37
    (0, 1, 2, 3), (1, 2, 3), (0, 1, 2, 3)  # 38, 39, 40
]

# Here these tuples (a, b, c...) are converted to integers 2**a + 2**b + 2**c...
secondary_weights = [
                       0,  1,    3,  2,  3,
     7,  6,  7,    5,  4,  5,    7,  6,  7,

    15, 14, 15,   13, 12, 13,   15, 14, 15,
    11, 10, 11,    9,  8,  9,   11, 10, 11,
    15, 14, 15,   13, 12, 13,   15, 14, 15
]

# These are simply the total numbers of non-zero digits in each tuple (A005812).
# E.g. the origin has weight 0, a cube corner has weight 3, and a tesseract corner has weight 4.
primary_weights = [
                  0, 1,   2, 1, 2,
    3, 2, 3,   2, 1, 2,   3, 2, 3,

    4, 3, 4,   3, 2, 3,   4, 3, 4,
    3, 2, 3,   2, 1, 2,   3, 2, 3,
    4, 3, 4,   3, 2, 3,   4, 3, 4
]

# Indices to the weight arrays:
#                    0,  1,    2,  3,  4,
#  5,  6,  7,    8,  9, 10,   11, 12, 13,

# 14, 15, 16,   17, 18, 19,   20, 21, 22,
# 23, 24, 25,   26, 27, 28,   29, 30, 31,
# 32, 33, 34,   35, 36, 37,   38, 39, 40


# The nested dict below shows the possible sets of fixed points (SFP) of permutations of the tesseract.
# (Examples of SFP are rotation axes and mirror planes.)
# Each SFP is defined by a list of positive indices to the sequence of points defined above.
# Below such a list is called 'bundle'. (The origin is in every SFP, so its index 0 is not shown in the lists.)

# The most obvious property of an SFP is its dimension, i.e. 1 for an axis or 2 for a mirror plane.
# Here it is called rank, and it is the first key in these dicts.

# But there are different kinds of SFP with the same dimension, e.g. diagonals of a square and of a cube.
# This property is expressed in the weight pattern:
# It is a vector v with indices i = 1..n where v[i] is the number of points in the bundle that have weight i.
# E.g. fixed4[2][(1, 1, 2, 0)] contains the bundle (1, 6, 5, 7) (representing a plane between opposite cube edges).
# Its weight pattern is [primary_weights[p] for p in (1, 6, 5, 7)] = [1, 2, 3, 3].
# This is shortened to (1, 1, 2, 0) for 1 one, 1 two, 2 threes and no four. (For higher ranks it is actually shorter.)

# The weight patterns are listed in the order of their weight sum. (E.g. 9 for the example above.)
# (The two with weight sum 12 are shown in colex order, which in this case happens to be the same as lex order.)

# The points in the bundles and the bundles in their list are ordered by (primary) weight and then by secondary weight.
# Primary weight is the reason that 3 is before 2 (because pw(3)= 1 and pw(2)=2),
# and secondary weight is the reason that the 8 is before 6 (because sw(8)=5 and sw(6)=6).
# Two example bundles (representing the whole square and the whole cube) and their weights:

# bundle               ( 1, 3,  2, 4 )                 ( 1,  3,  9,   2,  4,  8, 10,  6, 12,   5,  7, 11, 13 )
# primary and sum      ( 1, 1,  2, 2 )   (6)           ( 1,  1,  1,   2,  2,  2,  2,  2,  2,   3,  3,  3,  3 )   (27)
# secondary            ( 1, 2,  3, 3 )                 ( 1,  2,  4,   3,  3,  5,  5,  6,  6,   7,  7,  7,  7 )

#                       1  2  3  4                      1  2  3  4
# primary short        (2, 2, 0, 0)                    (3, 6, 4, 0)

# Number of SFP per rank are B-analogs of Sterling2: A039755(n, rank), e.g. A039755(3, 0..3) = 1, 13, 9, 1
# Total number of SFP per dimension are Dowling numbers: A007405(2, 3, 4) = 6, 24, 116

fixed4 = {
    0: {
        (0, 0, 0, 0): [  # weight sum 0 (origin)
            ()
        ]
    },
    1: {
        (1, 0, 0, 0): [  # weight sum 1 (coordinate axes)
            (1,), (3,), (9,), (27,)  # 1a0 ... 1a3
        ],
        (0, 1, 0, 0): [  # weight sum 2 (square diagonals)
            (2,), (4,), (8,), (10,), (6,), (12,), (26,), (28,), (24,), (30,), (18,), (36,)  # 1b00..1b11
        ],
        (0, 0, 1, 0): [  # weight sum 3 (cube diagonals)
            (5,), (7,), (11,), (13,), (23,), (25,), (29,), (31,), (17,), (19,), (35,), (37,), (15,), (21,), (33,), (39,)  # 1c00..1c15
        ],
        (0, 0, 0, 1): [  # weight sum 4 (tesseract diagonals)
            (14,), (16,), (20,), (22,), (32,), (34,), (38,), (40,)  # 1d0..1d7
        ]
    },
    2: {
        (2, 2, 0, 0): [  # weight sum 6 (squares with area 1)
            (1, 3, 2, 4), (1, 9, 8, 10), (3, 9, 6, 12), (1, 27, 26, 28), (3, 27, 24, 30), (9, 27, 18, 36)  # 2a0..2a5
        ],
        (1, 1, 2, 0): [  # weight sum 9 (rectangles between opposite cube edges)
            (1, 6, 5, 7), (3, 8, 5, 11), (9, 2, 7, 11), (9, 4, 5, 13), (3, 10, 7, 13), (1, 12, 11, 13),  # 2b00..2b05
            (1, 24, 23, 25), (3, 26, 23, 29), (27, 2, 25, 29), (27, 4, 23, 31), (3, 28, 25, 31), (1, 30, 29, 31),  # 2b06..2b11
            (1, 18, 17, 19), (9, 26, 17, 35), (27, 8, 19, 35), (27, 10, 17, 37), (9, 28, 19, 37), (1, 36, 35, 37),  # 2b12..2b17
            (3, 18, 15, 21), (9, 24, 15, 33), (27, 6, 21, 33), (27, 12, 15, 39), (9, 30, 21, 39), (3, 36, 33, 39)  # 2b18..2b23
        ],
        (0, 2, 0, 2): [  # weight sum 12 (squares with area 2)
            (2, 18, 16, 20), (4, 18, 14, 22), (8, 24, 16, 32), (6, 26, 20, 32), (10, 24, 14, 34), (6, 28, 22, 34),  # 2c00..2c05
            (12, 26, 14, 38), (8, 30, 22, 38), (2, 36, 34, 38), (12, 28, 16, 40), (10, 30, 20, 40), (4, 36, 32, 40)  # 2c06..2c11
        ],
        (1, 0, 1, 2): [  # weight sum 12 (rectangles between opposite tesseract edges)
            (1, 15, 14, 16), (3, 17, 14, 20), (3, 19, 16, 22), (1, 21, 20, 22),  # 2d00..2d03
            (9, 23, 14, 32), (27, 5, 22, 32), (9, 25, 16, 34), (27, 7, 20, 34),  # 2d04..2d07
            (1, 33, 32, 34), (27, 11, 16, 38), (9, 29, 20, 38), (3, 35, 32, 38),  # 2d08..2d11
            (27, 13, 14, 40), (9, 31, 22, 40), (3, 37, 34, 40), (1, 39, 38, 40)  # 2d12..2d15
        ]
    },
    3: {
        (3, 6, 4, 0): [  # weight sum 27 (cubes)
            (1, 3, 9, 2, 4, 8, 10, 6, 12, 5, 7, 11, 13), (1, 3, 27, 2, 4, 26, 28, 24, 30, 23, 25, 29, 31),  # 3a0, 3a1
            (1, 9, 27, 8, 10, 26, 28, 18, 36, 17, 19, 35, 37), (3, 9, 27, 6, 12, 24, 30, 18, 36, 15, 21, 33, 39)  # 3a2, 3a3
        ],
        (2, 3, 4, 4): [  # weight sum 36 (cuboids)
            (1, 3, 2, 4, 18, 17, 19, 15, 21, 14, 16, 20, 22), (1, 9, 8, 10, 24, 23, 25, 15, 33, 14, 16, 32, 34),  # 3b00, 3b01
            (1, 27, 6, 26, 28, 5, 7, 21, 33, 20, 22, 32, 34), (3, 9, 6, 12, 26, 23, 29, 17, 35, 14, 20, 32, 38),  # 3b02, 3b03
            (3, 27, 8, 24, 30, 5, 11, 19, 35, 16, 22, 32, 38), (9, 27, 2, 18, 36, 7, 11, 25, 29, 16, 20, 34, 38),  # 3b04, 3b05
            (9, 27, 4, 18, 36, 5, 13, 23, 31, 14, 22, 32, 40), (3, 27, 10, 24, 30, 7, 13, 17, 37, 14, 20, 34, 40),  # 3b06, 3b07
            (3, 9, 6, 12, 28, 25, 31, 19, 37, 16, 22, 34, 40), (1, 27, 12, 26, 28, 11, 13, 15, 39, 14, 16, 38, 40),  # 3b08, 3b09
            (1, 9, 8, 10, 30, 29, 31, 21, 39, 20, 22, 38, 40), (1, 3, 2, 4, 36, 35, 37, 33, 39, 32, 34, 38, 40)  # 3b10, 3b11
        ]
    },
    4: {
        (4, 12, 16, 8): [  # weight sum 108 (tesseract)
            (
                1, 3, 9, 27,
                2, 4, 8, 10, 6, 12, 26, 28, 24, 30, 18, 36,
                5, 7, 11, 13, 23, 25, 29, 31, 17, 19, 35, 37, 15, 21, 33, 39,
                14, 16, 20, 22, 32, 34, 38, 40
            )
        ]
    }
}

# The lists above are in colex order. The following lists of indices to the lists above define lex order.
lex4 = {
    0: {
        (0, 0, 0, 0): [0]
    },
    1: {
        (1, 0, 0, 0): range(4),
        (0, 1, 0, 0): range(12),
        (0, 0, 1, 0): range(16),
        (0, 0, 0, 1): range(8)
    },
    2: {
        (2, 2, 0, 0): range(6),
        (1, 1, 2, 0): [0, 5, 6, 11, 12, 17, 1, 4, 7, 10, 18, 23, 2, 3, 13, 16, 19, 22, 8, 9, 14, 15, 20, 21],
        (0, 2, 0, 2): [3, 6, 5, 9, 2, 4, 7, 10, 0, 1, 8, 11],
        (1, 0, 1, 2): [0, 3, 8, 15, 1, 2, 11, 14, 4, 6, 10, 13, 5, 7, 9, 12]
    },
    3: {
        (3, 6, 4, 0): range(4),
        (2, 3, 4, 4): [0, 11, 1, 10, 3, 8, 2, 9, 4, 7, 5, 6]
    },
    4: {
        (4, 12, 16, 8): [0]
    }
}
