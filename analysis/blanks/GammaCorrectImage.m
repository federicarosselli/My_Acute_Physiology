for i=1:70 
    I=double(imread(['Condition_' num2str(i) '.png']));
    Ic=GammaCorrectionFuncPoly(I);
%     figure(i)
%     colormap(gray(255))
%     image(Ic)
    MeanLuminPoly(i)=sum(sum(Ic(I~=0)))/length(find(I~=0));
end