% sf=v*tf, v=sf*tf, tf=1/t
% v = 0.25 (position shift in deg) / 0.016 (frame duration in msec) >>>
% this parameter shoul be constant

close all
clear all
coglio=0;
count=0;
N=60;
% L=1900;   %% px referring to ±120 deg (equalized for the 2 dimensions)
% W=1900;   %% px referring to ±120 deg (equalized for the 2 dimensions)
L=1080*3;
W=1920*3;
%M=1000;%5000
refresh_rate=1/(60); %1/(2*28);
spf= 0.4 %0.03 % [0.03, 0.05, 0.1, 0.4]
shift_in_pix = 1.6142; % 0.25 deg
%/u/shared/CODES
or=0;
%kx=3
%ky=3

for i=0:45:135      %30:90:300    %180:45:315   %0:45:135 %0:45:135orientation
    or=or+1;
    alberto(or)=i
% ori{1}=[0 1];%90 deg
% ori{2}=[1 1];%45 deg
% ori{3}=[1 0];%0 deg
% ori{4}=[1 -1];%-45 deg
ori{or}=[sind(i) cosd(i)];
end

% TF=[0.43 0.86 1.72 3.44 6.88 13.75 27.5];
% TF=[1/64 1/32 1/16 1/8 1/4 1/2 1]*15;

% PH(1)=0;
% PH(2)=1/2;
% PH(3)=1;

%y=input('which spf?' )
tic
NN=0;
k=(240*spf);    %%k=(120*spf);
kx=(ori{or}(1)*k);
ky=(ori{or}(2)*k);
%scrivere il valore a seconda dell'orientazione che si vuole!!!
Dphas=2*pi*0.25*spf; %Dphas=2*pi*0.25*spf;

for orientation=1:4
    mkdir(['/Users/labuser/Desktop/REALLY_NO_SPH/']) %,'orientation',num2str(alberto(orientation)),'_spatial frequency_',num2str(spf)]) 
%mkdir(['/zocconasphys2/acute_rev_core/gssdggds/REALLY_NO_SPH/','orientation',num2str(alberto(orientation)),'_spatial frequency_',num2str(spf)]) 
%mkdir(['/zocconasphys2/acute_rev_core/Test/','orientation',num2str(alberto(orientation)),'_spatial frequency_',num2str(spf)]) 
%mkdir(['/u/shared/Gratings/','orientation',num2str(alberto(orientation)),'_spatial frequency_',num2str(spf)]) 

vai=kx
a=ky
fanculo=spf
for sp=spf %spf%fliplr(spf)
for or=orientation%:size(ori,2)
coglio=0;
for tf=2
%mkdir(['\\zocconasphys2.cns.sissa.it\acute_rev_core\gratings\New_New_Original\',num2str(find(spf==sp)),'_',num2str(or),'_',num2str(find(TF==tf))])
%mkdir(['//zocconasphys2.cns.sissa.it/acute_rev_core/gratings/New_New_Original/',num2str(find(spf==sp)),'_',num2str(or),'_',num2str(find(TF==tf))])
Ti=1/tf;
nu=floor(Ti/refresh_rate);
nu=floor(pi/Dphas);
% if nu>10
%     nu=56;
% end

DP=2*spf*0.25*pi;

phn=0;
phas_SET=linspace(0,2*pi,2*(nu));
phas_SET(end)=[];
for NUM=1 %:160 %:120
    i=mod(NUM,numel(phas_SET))+1;
    PPP(NUM+1)=1*DP*NUM;%phas_SET(i);
end


for ph=PPP
    
%coglio=coglio+1;
    [find(spf==sp) or tf ph]
phn=phn+1;
k=(240*sp);        %%k=(120*spf);
kx=ori{or}(1)*k;
ky=ori{or}(2)*k;
% PHASE=pi*PH(ph);
PHASE=ph;
%H=Hartley(kx,ky,M,PHASE);
H=Hartley_REALLY_FEDE(kx,ky,L,W,PHASE);
%Inverse_Sphere_NEW

% H=1
% H=IM;
% IM=H;
% [pl ul]=size(H);
% 
% nl=round(pl/k);
% NL=ph*nl;
% 
% AAA=H(round(ul/2),:);
% rrr=find(diff(AAA)~=0);
% 
% pl=rrr(end)-rrr(1)+1;
% [inizio_rig,inizio_col]=find(IM,1,'first')
% [fine_rig,fine_col]=find(IM,1,'last')
% 
% H_CUT=IM(1:600,1:600);
% 
% %H_TRUE=H_CUT(186:414,50:550);
% H_TRUE=H_CUT(300-round(90*265/120):300+round(90*265/120),35:565);

%H_CUT=H(round(ul/2)-round(pl*57.8/103.8/2):round(ul/2)+round(pl*57.8/103.8/2)+1,1+rrr(1):pl+rrr(1));
% H_CUT=H(1:round(pl*57.8/103.8/2),1:pl);

%set(0,'DefaultFigureMenu','none');
%format compact;
%figure('Position',[50,50,pl/4.5,round(pl*57.8/103.8)/4.5],'units','pixels')

%imshow(H_CUT)
% % % % % % % %  h=pcolor(H_CUT);
% % % % % % % % set(gca,'Position',[0,0,1,1],'units','normalized')
% % % % % % % % axis off
% % % % % % % % colormap(gray)
% % % % % % % % set(h,'EdgeColor','none')
% % % % % % % % set(gca,'xtick',[],'ytick',[])
% % % % % % % % set(gca,'TickLength',[0 0])
% % % % % % % % set(gcf, 'InvertHardCopy', 'off');
% % % % % % % % count=count+1;
% % % % % % % % set(gcf,'PaperPositionMode','auto');
% % % % % % % % %saveas(h,['\\zocconasphys2.cns.sissa.it\acute_rev_core\gratings\original\',num2str(find(spf==sp)),'_',num2str(or),'_',num2str(ph),'.jpg'])
%saveas(h,['\\zocconasphys2.cns.sissa.it\acute_rev_core\gratings\New_New_Original\',num2str(find(spf==sp)),'_',num2str(or),'_',num2str(find(TF==tf)),'\',num2str(phn),'.jpg'])
% % % % % % % % saveas(h,['\\zocconasphys2.cns.sissa.it\acute_rev_core\gratings\New_New_Original','\',num2str(phn),'.jpg'])
%H_TRUE=IM;
H_TRUE=H; %imresize(H,2);
imwrite(H_TRUE,['/Users/labuser/Desktop/REALLY_NO_SPH/','orientation',num2str(alberto(orientation)),'_spatial frequency_',num2str(fanculo),'.jpg'])%'_',num2str(coglio),'.jpg'])
%imwrite(H_TRUE,['/zocconasphys2/acute_rev_core/Test/','orientation',num2str(alberto(orientation)),'_spatial frequency_',num2str(fanculo),'/',num2str(coglio),'.jpg'])
%imwrite(H_TRUE,['/u/shared/Gratings/','orientation',num2str(alberto(orientation)),'_spatial frequency_',num2str(fanculo),'/',num2str(coglio),'.jpg'])

toc
% STIM{count}=[sp or ph];

%close all

% NN=NN+1;

end

end
end
end
end