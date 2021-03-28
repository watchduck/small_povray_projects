#include "cases.inc"


////////////////////// variables

#declare Radius = 2.3;

#declare BeamWidth = .17;

// `GapWidth` comes from `cases.inc`
#declare GapOffset = GapWidth / 2;
#declare CutOffset = GapOffset + BeamWidth;

#declare Points = array[4]{<-1, 1, 1>, < 1, 1,-1>, < 1,-1, 1>, <-1,-1,-1>};

#declare LightGray = pigment{color srgb .9};

#declare Dark0 = pigment{color srgb <219,0,0>/255}    // DB0000 red
#declare Dark1 = pigment{color srgb <0,211,0>/255}    // 00D300 green
#declare Dark2 = pigment{color srgb <0,48,255>/255}   // 0030FF blue
#declare Dark3 = pigment{color srgb <255,158,0>/255}  // FF9E00 yellow

#declare Light0 = pigment{color srgb <244,178,178>/255}  // F4B2B2
#declare Light1 = pigment{color srgb <178,241,178>/255}  // B2F1B2
#declare Light2 = pigment{color srgb <178,192,255>/255}  // B2C0FF
#declare Light3 = pigment{color srgb <255,225,178>/255}  // FFE1B2

#declare Trans = 155;
#declare Trans0 = pigment{color srgbt <219,0,0,Trans>/255}
#declare Trans1 = pigment{color srgbt <0,211,0,Trans>/255}
#declare Trans2 = pigment{color srgbt <0,48,255,Trans>/255}
#declare Trans3 = pigment{color srgbt <255,158,0,Trans>/255}

#declare Invis = pigment{color rgbt <1,1,1,1>}

#declare Colors = array[4]{
    array[4]{Dark0, Light0, Trans0, Invis},
    array[4]{Dark1, Light1, Trans1, Invis},
    array[4]{Dark2, Light2, Trans2, Invis},
    array[4]{Dark3, Light3, Trans3, Invis}
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


////////////////////// macros

#macro Sphere(SphereIndex, Invert, Offset, ColorType)
  // `ColorType` can be 0 (dark), 1 (light), 2 (transparent) and 3 (invisible)
    sphere{
        Points[SphereIndex],
        Radius + Offset
        #if (Invert)
            inverse
        #end
        pigment{ Colors[SphereIndex][ColorType] }
    }
#end


#macro SolidCell(CellIndex, Offset, ColorType)
    #declare CellVector = CellVectors[CellIndex];
    intersection{
        #for (SphereIndex, 0, 3)
            #if (CellVector[SphereIndex])
                Sphere(SphereIndex, 0, -Offset, ColorType)  // convex
            #else
                Sphere(SphereIndex, 1, Offset, ColorType)   // concave (complement)
            #end
        #end
    }
#end


#macro CutCells(CellIndex)
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
                        Sphere(SphereIndex, 0, -CutOffset, 1)  // convex
                    #else
                        Sphere(SphereIndex, 1, CutOffset, 1)   // concave (complement)
                    #end
                #end
            }
        #end
    }
#end


#macro Cell(CellIndex, Solid)
    #if (Solid)
        SolidCell(CellIndex, GapOffset, 0)
    #else
        difference{
            SolidCell(CellIndex, GapOffset, 0)
            CutCells(CellIndex)
        }
    #end
#end


#macro ColorRing(SphereIndexA, SphereIndexB)
    #declare Offset = .1;

    intersection{
        difference{
            Sphere(SphereIndexA, 0, Offset, 0)
            Sphere(SphereIndexA, 0, -Offset, 1)
        }
        difference{
            Sphere(SphereIndexB, 0, Offset, 0)
            Sphere(SphereIndexB, 0, -Offset, 1)
        }
    }

#end


#declare FactorPos = 1.2684;
#declare FactorNeg = -.6017;
#declare TetraPoints = array[4]{<1,1,1>, <-1,-1,1>, <-1,1,-1>, <1,-1,-1>}

#macro BlackSpheres(SphereRad)
    union{
        #for (KeyToTetraPoints, 0, 3)
            #declare TetraPoint = TetraPoints[KeyToTetraPoints];
            sphere{TetraPoint * FactorPos , SphereRad}
            sphere{TetraPoint * FactorNeg , SphereRad}
        #end
        pigment{color srgb .2}
    }
#end

