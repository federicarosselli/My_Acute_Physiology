%%%% this function generates the stimulus with half of the luminance of the
%%%% defaut stimulus we have in the normal conditions. the maximum luminace
%%%% is 202 
k=1
for i=[0:0.1:0.9]
   % Pf=double(imread(['Condition_' num2str(i) '.png']));
   Pf=double(imread(['FullLuminance.png']));
    Ic=GammaCorrectionFunc(Pf);
    MeanLumin=sum(sum(Ic(Pf~=0)))/length(find(Pf~=0));
    Ic_half=floor(Ic*i);
    halfMeanLumin=sum(sum(Ic_half(Pf~=0)))/length(find(Pf~=0));
    Ph=GammaCorrectionInvFunc(Ic_half);
    
         figure(k)
         colormap(gray(255))
         subplot(121)
         image(Pf)
         axis off
         axis equal
         subplot(122)
         image(Ph)
         axis off
         axis equal
         imwrite(uint8(Ph),[num2str(i) 'FullLuminance.png'],'png')
         k=k+1;
         
end
