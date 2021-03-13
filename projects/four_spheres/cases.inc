#include "RotateDirOnDir.inc"


#declare Motive = "rings";  // "rings" or "cells"

#declare Presentation = "usual";  // "usual", "vertical", "yellow", "front" or "flower"

#declare Solid = 0;  // wider gap and bigger frame (only for Motive "rings")

#declare Small = 0;  // wide margins based on weight


#declare UsualCamPoint = <7.7, 14, -40>;   



#if (Presentation = "usual")
    #macro Transforms()
        //rotate (clock/2)*y
        RotateDirOnDir(Points[0], <0, -1, 0>)
        rotate -25*y
        rotate 63*x
        rotate 5*y
    #end
#end



#if (Small)


    #declare BeamWidth = .05;
    #declare GapWidth = 0;
    #declare Camera_Position = vnormalize(UsualCamPoint) * 18;
    #declare LookAt = <-.05, -.15, 0>;


#else


    #declare BeamWidth = .17;


    #if (Solid)  // (only for Motive "cells")
        // +W1000 +H1080     +W4000 +H4320
        #declare GapWidth = .23;
        #declare Camera_Position = vnormalize(UsualCamPoint) * 21.7;
        #declare LookAt = <.15, .135, 0>;
    #else  // also for Motive "rings"
        // +W1000 +H926     +W4000 +H3704
        #declare GapWidth = .07;
        #declare Camera_Position = vnormalize(UsualCamPoint) * 16.5;
        #declare LookAt = <-.05, -.15, 0>;
    #end


    #if (Motive = "rings")

        #declare GapWidth = 0;  // not used in this case

        #if (Presentation = "vertical")
            #macro Transforms()
                RotateDirOnDir(Points[2], <0, -1, 0>)
                rotate -40*y
                //rotate (clock/2)*y
            #end
            // +W1000 +H1020     +W4000 +H4080
            #declare Camera_Position = vnormalize(UsualCamPoint) * 15.6;
            #declare LookAt = <-.23, 0, 0>;
        #end

        #if (Presentation = "yellow")  // 3-fold
            #macro Transforms()
                RotateDirOnDir(Points[3], <0, 0, -1>)
                rotate -5*x
            #end
            // +W1000 +H1008     +W4000 +H4032
            #declare Camera_Position = vnormalize(<0, 0, -1>) * 15.6;
            #declare LookAt = <0, -.02, 0>;
        #end

        #if (Presentation = "front")  // 2-fold
            #macro Transforms()
                RotateDirOnDir(Points[0] + Points[3], <0, 0, -1>)
                rotate 180*z  rotate -45*z
            #end
            // +W1000 +H900     +W4000 +H3600
            #declare Camera_Position = vnormalize(<0, 0, -1>) * 15;
            #declare LookAt = <0, 0, 0>;
        #end

        #if (Presentation = "flower")
            // needs changes in `cam_light.inc`: orthographic, angle from 20 to 19
            #macro Transforms()
                RotateDirOnDir(Points[0] + Points[3], <0, 0, -1>)
                rotate 180*z  rotate -45*z
                rotate 90*x
            #end
            // +W1000 +H1215     +W3000 +H3645
            #declare Camera_Position = vnormalize(<0, 0, -1>) * 15;
            #declare LookAt = <0, 0, 0>;
        #end

    #end


#end

/*

solid cells:
for i in `seq -f "%02g" 1 15`; do povray SCENE.pov +ua +fn +W4000 +H4320 -D -k$i -O$i; done

hollow cells:
for i in `seq -f "%02g" 0 15`; do povray SCENE.pov +ua +fn +W4000 +H3704 -D -k$i -O$i; done

*/
