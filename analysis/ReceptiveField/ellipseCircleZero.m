function y=ellipseCircleZero(x,xc,yc,rc,xe,ye,a,b)
y=-1+((x-xe)/a)^2+(yc-ye+sqrt(rc^2-(x-xc)^2))/b^2;
