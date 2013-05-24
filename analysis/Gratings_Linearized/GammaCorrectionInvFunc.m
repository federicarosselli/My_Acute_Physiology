function y=GammaCorrectionInvFunc(x)
       a =    0.0005322 ;
       b =       2.328  ;
       h=x/a;
       y = h.^(1/b);
%% gamma correctio for brightness ? black level 12 and gamma 1.8
%Pixel Value=0:15:255
%Absolute luminance cd/m2=[0.24 0.25 0.26 0.64 2.58 5.34 10.3 19.2 30.8 44.8 61.9 80.8 101.1 121.1 141.9 163.2 183.6 202.2]