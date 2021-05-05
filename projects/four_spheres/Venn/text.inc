// cell numbers from 1 to 15

#declare TextScale = .55;
#declare TextDepth = .075;
#declare FontPath = "/usr/share/fonts/truetype/msttcorefonts/Arial.ttf";

#declare TextObjects = array[15]{
    text{ ttf FontPath, str(15, 0, 0), TextDepth, 0   scale TextScale }

    text{ ttf FontPath, str(14, 0, 0), TextDepth, 0   scale TextScale }
    text{ ttf FontPath, str(13, 0, 0), TextDepth, 0   scale TextScale }
    text{ ttf FontPath, str(11, 0, 0), TextDepth, 0   scale TextScale }
    text{ ttf FontPath, str(7, 0, 0), TextDepth, 0   scale TextScale }

    text{ ttf FontPath, str(1, 0, 0), TextDepth, 0   scale TextScale }
    text{ ttf FontPath, str(2, 0, 0), TextDepth, 0   scale TextScale }
    text{ ttf FontPath, str(4, 0, 0), TextDepth, 0   scale TextScale }
    text{ ttf FontPath, str(8, 0, 0), TextDepth, 0   scale TextScale }

    text{ ttf FontPath, str(12, 0, 0), TextDepth, 0   scale TextScale }
    text{ ttf FontPath, str(10, 0, 0), TextDepth, 0   scale TextScale }
    text{ ttf FontPath, str(9, 0, 0), TextDepth, 0   scale TextScale }
    text{ ttf FontPath, str(6, 0, 0), TextDepth, 0   scale TextScale }
    text{ ttf FontPath, str(5, 0, 0), TextDepth, 0   scale TextScale }
    text{ ttf FontPath, str(3, 0, 0), TextDepth, 0   scale TextScale }
}

#declare TranslatePoints = array[15]{
    <0,0,0>,

    .6*TetraPoints[0],
    .6*TetraPoints[1],
    .6*TetraPoints[2],
    .6*TetraPoints[3],

    -2.0*TetraPoints[0],
    -2.27*TetraPoints[1],
    -2.0*TetraPoints[2],
    -1.8*TetraPoints[3],

    1.7 * (TetraPoints[0]+TetraPoints[1]) / 2,
    1.7 * (TetraPoints[0]+TetraPoints[2]) / 2,
    1.7 * (TetraPoints[0]+TetraPoints[3]) / 2,
    1.7 * (TetraPoints[1]+TetraPoints[2]) / 2,
    1.7 * (TetraPoints[1]+TetraPoints[3]) / 2,
    1.7 * (TetraPoints[2]+TetraPoints[3]) / 2
}

#declare TextColors = array[15]{ .5,  .2, .2, .2, .2,  .2, .2, .2, .2,  1, 1, 1, 1, 1, 1 }

#declare Text = union{

    #for( Index, 0, dimension_size(TextObjects, 1) - 1 )
        #local TextObject = TextObjects[Index];
        object{
            TextObject

            translate -x * ( max_extent(TextObject).x - min_extent(TextObject).x ) / 2
            #if (Index=0)   translate .1*x   #end
            translate -.15*y
            rotate <90, 211.5, 90>
            translate TranslatePoints[Index]

            pigment{color srgb TextColors[Index]}
        }
    #end

}

