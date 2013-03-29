       clear  ,close all    
       Xp=[1:11];Xpp=[1:0.1:11];
       Yp=[1:6];Ypp=[1:.1:6]; 
       [X,Y]=meshgrid(Xp,Yp) ;   
       [Xp,Yp]=meshgrid(Xpp,Ypp);   
       addpath /u/shared/CODES/Acu_Obj/Analysis/2dgaussianfit
       load /u/shared/CODES/Acu_Obj/DataFiles/tempdata.mat
       Area=AreaV1;
       RFdata=squeeze(mean(Area.RFmapping,3));

    for NN=1:size(Area.RFmapping,4)
        RF=RFdata(:,:,NN);
        RFcut=zeros(size(RF));
        RFcut(find((RF>0*max(RF(:)))))=RF(find((RF>0*max(RF(:)))));
        F{NN}=autoGaussianSurf(X,Y,RFcut);
        [MaxRF_I MaxRF_J]=ind2sub(size(RF),find(RF==max(max(RF))));
        X0=F{NN}.x0;
        Y0=F{NN}.y0;
        sigmax=F{NN}.sigmax;
        sigmay=F{NN}.sigmay;
        radius=mean([sigmax sigmay])/2;
    
%     xip = (Xp-F{NN}.x0)*cos(F{NN}.theta) + (Yp-F{NN}.y0)*sin(F{NN}.theta);
%     yip =-(Xp-F{NN}.x0)*sin(F{NN}.theta) + (Yp-F{NN}.y0)*cos(F{NN}.theta);
%     
% 
%     Z = F{NN}.a*exp(-(xip.^2+yip.^2)/2/F{NN}.sigma^2)*cos(2*pi*xip./F{NN}.lambda + F{NN}.phase) + F{NN}.b;
%     im=zeros(size(Z));
%     %im(Z>0.9*max(max(Z)))=Z(Z>0.9*max(max(Z)));
%     im=Z;
     % F{NN}=autoGaussianCurve(1:11,RF(MaxRF_I,:));
     
      figure(NN)
      subplot(121)     
      imagesc(RFcut)
      set(gca,'YDir','normal')
      hold on
      circle([X0 Y0],radius,1000,'--')
      xlim([1 11])   
      ylim([1 6])
      axis equal
      subplot(122)
      imagesc((F{NN}.G))
        set(gca,'YDir','normal')
        hold on
      circle([X0 Y0],radius,1000,'--')
      xlim([1 11])
      ylim([1 6])
      axis equal
      title(['sx:' num2str(F{NN}.sigmax) ' sy:' num2str(F{NN}.sigmay)])
    %  pause
    end
 