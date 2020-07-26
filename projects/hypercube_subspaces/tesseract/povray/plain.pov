#version 3.6;
global_settings { assumed_gamma 1.0 }
global_settings { charset utf8 }
#default{ finish{ ambient 0.1 diffuse 0.9 conserve_energy } }

#include "colors.inc"


/*
for i in $(seq 0 9); do povray plain.pov +ua +fn -D -k$i -Oplain_$i; done

https://commons.wikimedia.org/wiki/Category:Tesseract_subspaces_(image_set);_plain
*/


#declare MyBlack = <.22,.22,.22>;
#declare MyBlue = <0,83,255>/255;
#declare MyGreen = <0,194,0>/255;
#declare MyYellow = <255,162,0>/255;
#declare MyRed = <1,0,0>;

#declare Unit = 4;
#declare Rad = .15;

// camera and light

#declare PerspCameraLocation = 30 * vnormalize( <23, 20, -50> );

camera{
    orthographic
    location <1, 1, 0> * Unit - 30 * z
    look_at  <1, 1, 0> * Unit
    right    x*image_width/image_height
    angle    20
}

light_source{ <-400, 500, -300> color White*0.9 shadowless}
light_source{ <400, 200, 100> color White*0.4 shadowless}
light_source{ PerspCameraLocation  color rgb<0.9,0.9,1>*0.2 shadowless}
sky_sphere{ pigment{ White } }

/////////////////////////////////////////////////////////////////

#if (clock=0)  // 1a
    #declare A = <0,0,0>;
    #declare B = A + Unit*x;
    cylinder{A, B, Rad  pigment{color MyBlack}}
    union{
        sphere{A, 2*Rad}
        sphere{B, 2*Rad}
        pigment{color MyBlue}
    }
#end
#if (clock=1)  // 1b
    #declare A = <0,0,0>;
    #declare B = A + Unit*sqrt(2)*x;
    cylinder{A, B, Rad  pigment{color MyBlack}}
    union{
        sphere{A, 2*Rad}
        sphere{B, 2*Rad}
        pigment{color MyGreen}
    }
#end
#if (clock=2)  // 1c
    #declare A = <0,0,0>;
    #declare B = A + Unit*sqrt(3)*x;
    cylinder{A, B, Rad  pigment{color MyBlack}}
    union{
        sphere{A, 2*Rad}
        sphere{B, 2*Rad}
        pigment{color MyYellow}
    }
#end
#if (clock=3)  // 1d
    #declare A = <0,0,0>;
    #declare B = A + Unit*2*x;
    cylinder{A, B, Rad  pigment{color MyBlack}}
    union{
        sphere{A, 2*Rad}
        sphere{B, 2*Rad}
        pigment{color MyRed}
    }
#end
#if (clock=4)  // 2a
    #declare A = <0,0,0>;
    #declare B = A + Unit*x;
    #declare C = A + Unit*y;
    #declare D = B + Unit*y;
    union{
        cylinder{A, B, Rad} cylinder{C, D, Rad} cylinder{A, C, Rad} cylinder{B, D, Rad}
        pigment{color MyBlue}
    }
    union{
        sphere{A, 2*Rad} sphere{B, 2*Rad} sphere{C, 2*Rad} sphere{D, 2*Rad}
        pigment{color MyGreen}
    }
    polygon{4, A, B, D, C  pigment{color MyBlack}}
#end
#if (clock=5)  // 2b
    #declare A = <0,0,0>;
    #declare B = A + Unit*sqrt(2)*x;
    #declare C = A + Unit*y;
    #declare D = B + Unit*y;
    union{
        cylinder{A, B, Rad} cylinder{C, D, Rad}
        pigment{color MyBlue}
    }
    union{
        cylinder{A, C, Rad} cylinder{B, D, Rad}
        pigment{color MyGreen}
    }
    union{
        sphere{A, 2*Rad} sphere{B, 2*Rad} sphere{C, 2*Rad} sphere{D, 2*Rad}
        pigment{color MyYellow}
    }
    polygon{4, A, B, D, C  pigment{color MyBlack}}
#end
#if (clock=6)  // 2c
    #declare A = <0,0,0>;
    #declare B = A + sqrt(2)*Unit*x;
    #declare C = A + sqrt(2)*Unit*y;
    #declare D = B + sqrt(2)*Unit*y;
    union{
        cylinder{A, B, Rad} cylinder{C, D, Rad} cylinder{A, C, Rad} cylinder{B, D, Rad}
        pigment{color MyGreen}
    }
    union{
        sphere{A, 2*Rad} sphere{B, 2*Rad} sphere{C, 2*Rad} sphere{D, 2*Rad}
        pigment{color MyRed}
    }
    polygon{4, A, B, D, C  pigment{color MyBlack}}
#end
#if (clock=7)  // 2d
    #declare A = <0,0,0>;
    #declare B = A + Unit*sqrt(3)*x;
    #declare C = A + Unit*y;
    #declare D = B + Unit*y;
    union{
        cylinder{A, B, Rad} cylinder{C, D, Rad}
        pigment{color MyBlue}
    }
    union{
        cylinder{A, C, Rad} cylinder{B, D, Rad}
        pigment{color MyYellow}
    }
    union{
        sphere{A, 2*Rad} sphere{B, 2*Rad} sphere{C, 2*Rad} sphere{D, 2*Rad}
        pigment{color MyRed}
    }
    polygon{4, A, B, D, C  pigment{color MyBlack}}
#end
#if (clock=8)  // 3a
    #declare A = <0,0,0>;
    #declare B = A + Unit*x;
    #declare C = A + Unit*y;
    #declare D = B + Unit*y;
    #declare E = A + Unit*z;
    #declare F = B + Unit*z;
    #declare G = C + Unit*z;
    #declare H = D + Unit*z;
    union{
        cylinder{A, B, Rad} cylinder{C, D, Rad} cylinder{A, C, Rad} cylinder{B, D, Rad}
        cylinder{E, F, Rad} cylinder{G, H, Rad} cylinder{E, G, Rad} cylinder{F, H, Rad}
        cylinder{A, E, Rad} cylinder{B, F, Rad} cylinder{C, G, Rad} cylinder{D, H, Rad}
        pigment{color MyGreen}
    }
    union{
        sphere{A, 2*Rad} sphere{B, 2*Rad} sphere{C, 2*Rad} sphere{D, 2*Rad}
        sphere{E, 2*Rad} sphere{F, 2*Rad} sphere{G, 2*Rad} sphere{H, 2*Rad}
        pigment{color MyYellow}
    }
    union{
        polygon{4, A, B, D, C} polygon{4, C, D, H, G} polygon{4, B, D, H, F}
        pigment{color MyBlue}
    }
#end
#if (clock=9)  // 3b
    #declare A = <0,0,0>;
    #declare B = A + sqrt(2)*Unit*x;
    #declare C = A + Unit*y;
    #declare D = B + Unit*y;
    #declare E = A + Unit*z;
    #declare F = B + Unit*z;
    #declare G = C + Unit*z;
    #declare H = D + Unit*z;
    union{
        cylinder{A, B, Rad} cylinder{C, D, Rad} cylinder{E, F, Rad} cylinder{G, H, Rad}
        pigment{color MyGreen}
    }
    union{
        cylinder{A, C, Rad} cylinder{B, D, Rad}
        cylinder{E, G, Rad} cylinder{F, H, Rad}
        cylinder{A, E, Rad} cylinder{B, F, Rad} cylinder{C, G, Rad} cylinder{D, H, Rad}
        pigment{color MyYellow}
    }
    union{
        sphere{A, 2*Rad} sphere{B, 2*Rad} sphere{C, 2*Rad} sphere{D, 2*Rad}
        sphere{E, 2*Rad} sphere{F, 2*Rad} sphere{G, 2*Rad} sphere{H, 2*Rad}
        pigment{color MyRed}
    }
    union{
        polygon{4, A, B, D, C} polygon{4, C, D, H, G}
        pigment{color MyBlue}
    }
    polygon{4, B, D, H, F  pigment{color MyGreen}}

#end