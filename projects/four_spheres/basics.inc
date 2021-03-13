#include "cases.inc"


////////////////////// variables

#declare Radius = 2.3;

// `GapWidth` comes from `cases.inc`
#declare GapOffset = GapWidth / 2;
#declare CutOffset = GapOffset + BeamWidth;

#declare Points = array[4]{<-1, 1, 1>, < 1, 1,-1>, < 1,-1, 1>, <-1,-1,-1>};

#declare LightGray = pigment{color srgb .9};

#declare dark0 = pigment{color srgb <219,0,0>/255}    // DB0000 red
#declare dark1 = pigment{color srgb <0,211,0>/255}    // 00D300 green
#declare dark2 = pigment{color srgb <0,48,255>/255}   // 0030FF blue
#declare dark3 = pigment{color srgb <255,158,0>/255}  // FF9E00 yellow

#declare light0 = pigment{color srgb <244,178,178>/255}  // F4B2B2
#declare light1 = pigment{color srgb <178,241,178>/255}  // B2F1B2
#declare light2 = pigment{color srgb <178,192,255>/255}  // B2C0FF
#declare light3 = pigment{color srgb <255,225,178>/255}  // FFE1B2

#declare Colors = array[4]{
    array[2]{dark0, light0},
    array[2]{dark1, light1},
    array[2]{dark2, light2},
    array[2]{dark3, light3}
};

// The binary entries of each CellVector correspond to the 4 spheres.
// 1 means, the respective sphere itself will be used in the intersection.
// 0 means, the complement will be used. (keyword "inverse")
#declare CellVectors = array[16]{
    array[4]{0, 0, 0, 0},
    array[4]{1, 0, 0, 0},
    array[4]{0, 1, 0, 0},
    array[4]{1, 1, 0, 0},
    array[4]{0, 0, 1, 0},
    array[4]{1, 0, 1, 0},
    array[4]{0, 1, 1, 0},
    array[4]{1, 1, 1, 0},
    array[4]{0, 0, 0, 1},
    array[4]{1, 0, 0, 1},
    array[4]{0, 1, 0, 1},
    array[4]{1, 1, 0, 1},
    array[4]{0, 0, 1, 1},
    array[4]{1, 0, 1, 1},
    array[4]{0, 1, 1, 1},
    array[4]{1, 1, 1, 1}
};
#declare CellWeights = array[16]{0, 1, 1, 2,  1, 2, 2, 3,  1, 2, 2, 3,  2, 3, 3, 4};
#declare OffsetByWeight = array[5]{.5, 1, .5, .4, .3};  // make those with digit sum 1 much smaller


////////////////////// macros

#macro Sphere(SphereIndex, Invert, Offset, Light)
    sphere{
        Points[SphereIndex],
        Radius + Offset
        pigment{ Colors[SphereIndex][Light] }
        #if (Invert)
            inverse
        #end
    }
#end

#macro SolidCell(CellIndex, Offset, Light)
    #declare CellVector = CellVectors[CellIndex];
    intersection{
        #for (SphereIndex, 0, 3)
            #if (CellVector[SphereIndex])
                Sphere(SphereIndex, 0, -Offset, Light)  // convex
            #else
                Sphere(SphereIndex, 1, Offset, Light)   // concave (complement)
            #end
        #end
    }
#end

#macro CutCells(CellIndex, Small)

    #if (Small)
        #local Offset = OffsetByWeight[CellWeights[CellIndex]] + BeamWidth;
    #else
        #local Offset = CutOffset;
    #end

    #declare CellVector = CellVectors[CellIndex];
    #local Triples = array[4]{
        array[3]{1, 2, 3},
        array[3]{0, 2, 3},
        array[3]{0, 1, 3},
        array[3]{0, 1, 2}
    }

    union{
        #for (KeyToTriples, 0, 3)
            #local Triple = Triples[KeyToTriples];
            intersection{
                #for (KeyToTriple, 0, 2)
                    #local SphereIndex = Triple[KeyToTriple];
                    #if (CellVector[SphereIndex])
                        Sphere(SphereIndex, 0, -Offset, 1)  // convex
                    #else
                        Sphere(SphereIndex, 1, Offset, 1)   // concave (complement)
                    #end
                #end
            }
        #end
    }

#end

#macro Cell(CellIndex, Solid, Small)
    
    #if (Small)
        #local Offset = OffsetByWeight[CellWeights[CellIndex]];
    #else
        #local Offset = GapOffset;
    #end

    #if (Solid)
        SolidCell(CellIndex, Offset, 0)
    #else
        difference{
            SolidCell(CellIndex, Offset, 0)
            CutCells(CellIndex, Small)
        }
    #end

#end

