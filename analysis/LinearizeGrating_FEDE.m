%%% this script linearizes the gratings stimulus
%Absolute luminance cd/m2=[0.24 0.25 0.26 0.64 2.58 5.34 10.3 19.2 30.8 44.8 61.9 80.8 101.1 121.1 141.9 163.2 183.6 202.2]
% build the line that passes through 0 and 255
  p1 =  -1.121e-07   ;
       p2 =   4.891e-05   ;
       p3 =   -0.002066  ;
       p4 =   -0.008323  ;
       p5 =      0.6728;
       
cd blanks

for i=1:2
         %I=double(imread([num2str(i) '.jpg'],'jpg'));
        I=double((imread([num2str(i) '.png'],'png')));
          Ip=LinEstimBrigh13(I);
         Ig=GammaCorrectionFunc(I);
         ILinv=GammaCorrectionInvFunc(Ip);
%    IL=zeros(size(I));
%     for j=1:size(I,1)*size(I,2)
%         r=roots([p1 p2 p3 p4 p5-Ip(j)]);
%         IL(j) =r(2) ;  
%     end
    
         figure(i)
         colormap(gray(255))
         subplot(131)
         image(I)
         axis off
         axis equal
         subplot(132)
         image(ILinv)
         axis off 
         axis equal 
         subplot(133)
         image(Ig)
         axis off
         axis equal
         imwrite(uint8(ILinv),[num2str(i) '.png'])
end
