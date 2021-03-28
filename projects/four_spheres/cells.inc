#include "basics.inc"


#macro PutCells(CellIndices)
    #for (KeyToCellIndices, 0, dimension_size(CellIndices, 1) - 1)
        #local CellIndex = CellIndices[KeyToCellIndices];
        Cell(CellIndex, Solid)
    #end
#end


#declare Weight1 = array[4]{1, 2, 4, 8};
#declare Weight2 = array[6]{3, 5, 6, 9, 10, 12};
#declare Weight3 = array[4]{7, 11, 13, 14};

#declare Set0 = array[8]{1, 3, 5, 7, 9, 11, 13, 15};
#declare Set1 = array[8]{2, 3, 6, 7, 10, 11, 14, 15};
#declare Set2 = array[8]{4, 5, 6, 7, 12, 13, 14, 15};
#declare Set3 = array[8]{8, 9, 10, 11, 12, 13, 14, 15};

#declare Lens01 = array[4]{3, 7, 11, 15};
#declare Lens02 = array[4]{5, 7, 13, 15};
#declare Lens03 = array[4]{9, 11, 13, 15};
#declare Lens12 = array[4]{6, 7, 14, 15};
#declare Lens13 = array[4]{10, 11, 14, 15};
#declare Lens23 = array[4]{12, 13, 14, 15};


#declare Cells = union{
    PutCells(array[3]{1, 2, 3})
}

