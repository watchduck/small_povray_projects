//

#declare HorizontalCut = plane{
    Points[3], .53  
    inverse
    pigment{LightGray}
}

#declare FrontCut = union{
    plane{Points[1], -1.65}
    plane{Points[2], -1.65}
    pigment{LightGray}
}

#declare HollowSpheres = difference{
    union{
        #for (SphereIndex, 0, 3)
            Sphere(SphereIndex, 0, .2, 1)
        #end
    }
    object{ Cell(0, 1) inverse}
}

#declare SurroundingSpheres = difference{
    object{HollowSpheres}
    object{HorizontalCut}  // FrontCut or HorizontalCut 
}
