#include "RotateDirOnDir.inc"


#declare Case = 0;

/*

0: rings usual               // +W1000 +H926      +W4000 +H3704
1: rings vertical            // +W1000 +H1020     +W4000 +H4080
2: rings 2-fold (front)      // +W1000 +H900      +W4000 +H3600
3: rings 3-fold (yellow)     // +W1000 +H1008     +W4000 +H4032
4: rings flower              // +W1000 +H1215     +W3000 +H3645

5: cells solid               // +W1000 +H1080     +W4000 +H4320
6: cells hollow              // +W1000 +H926      +W4000 +H3704

7: triangles                 // +W1000 +H1104     +W4000 +H4416

*/


#declare UsualCamPoint = <7.7, 14, -40>;   


// not always used
#declare GapWidth = 0;  
#declare Solid = 1;


#if (Case=0 | Case=5 | Case=6 | Case=7)  // usual orientation
    #macro Transforms()
        //rotate (clock/2)*y
        RotateDirOnDir(Points[0], <0, -1, 0>)
        rotate -25*y
        rotate 63*x
        rotate 5*y
    #end
#end


#if (Case = 0)  // rings usual
    #declare Camera_Position = vnormalize(UsualCamPoint) * 16.5;
    #declare LookAt = <-.05, -.15, 0>;
#end

#if (Case = 1)  // rings vertical
    #macro Transforms()
        RotateDirOnDir(Points[2], <0, -1, 0>)
        rotate -40*y
        //rotate (clock/2)*y
    #end
    #declare Camera_Position = vnormalize(UsualCamPoint) * 15.6;
    #declare LookAt = <-.23, 0, 0>;
#end

#if (Case = 2)  // rings 2-fold
    #macro Transforms()
        RotateDirOnDir(Points[0] + Points[3], <0, 0, -1>)
        rotate 180*z  rotate -45*z
    #end
    #declare Camera_Position = vnormalize(<0, 0, -1>) * 15;
    #declare LookAt = <0, 0, 0>;
#end

#if (Case = 3)  // rings 3-fold
    #macro Transforms()
        RotateDirOnDir(Points[3], <0, 0, -1>)
        rotate -15*z
    #end
    #declare Camera_Position = vnormalize(<0, 0, -1>) * 15.6;
    #declare LookAt = <0, -.02, 0>;
#end

#if (Case = 4)  // rings flower (needs changes in `cam_light.inc`: orthographic, angle from 20 to 19)
    #macro Transforms()
        RotateDirOnDir(Points[0] + Points[3], <0, 0, -1>)
        rotate 180*z  rotate -45*z
        rotate 90*x
    #end
    #declare Camera_Position = vnormalize(<0, 0, -1>) * 15;
    #declare LookAt = <0, 0, 0>;
#end

#if (Case = 5)  // cells solid
    #declare GapWidth = .23;
    #declare Camera_Position = vnormalize(UsualCamPoint) * 21.7;
    #declare LookAt = <.15, .135, 0>;
#end

#if (Case = 6)  // cells hollow
    #declare Solid = 0;
    #declare GapWidth = .07;
    #declare Camera_Position = vnormalize(UsualCamPoint) * 16.5;
    #declare LookAt = <-.05, -.15, 0>;
#end

#if (Case = 7)  // triangles
    #declare GapWidth = .23;
    #declare Camera_Position = vnormalize(UsualCamPoint) * 20.1;
    #declare LookAt = <.13, .13, 0>;
#end

