function y=GammaCorrectionFuncPoly(x)
        p1 =  -1.121e-07   ;
       p2 =   4.891e-05   ;
       p3 =   -0.002066  ;
       p4 =   -0.008323  ;
       p5 =      0.6728  ;
       y = p5+p1*x.^4 + p2*x.^3 + p3*x.^2 + p4*x ;

%% gamma correctio for brightness 6 black level 12 and gamma 1.8
%Pixel Value=0:15:255
%Absulute Luminance cd/m2=[0.14 0.13 0.13 0.32 1.37 2.75 5.16 10 16.3 22.9 42.6 52.9 64.4 75 85.6 96.8 106.5]

%% Gamma Correction for brightness 13 black level 12 and gamma 1.8
%Absolute luminance cd/m2=[0.24 0.25 0.26 0.64 2.58 5.34 10.3 19.2 30.8 44.8 61.9 80.8 101.1 121.1 141.9 163.2 183.6 202.2]