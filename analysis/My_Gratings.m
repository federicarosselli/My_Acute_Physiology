function My_Gratings %(sf)


x=linspace(0, 2, 1.6142);
sf=1; % spatial freq in cycles per image
sinewave=sin(x*sf); 
ScreenSize = [725,1280];
%plot(x, sinewave);  

onematrix=ones(size(ScreenSize));
sinewave2D=(onematrix'*sinewave);
colormap(gray)
imagesc(sinewave2D)
axis off; 

end

