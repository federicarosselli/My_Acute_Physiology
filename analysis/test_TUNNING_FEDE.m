close all
clear all
block=1;
BINN=25;

% cd C:\Houman\Davide\Objects_New\Recording_21_06_2012%
cd '/zocconasphys1/chronic_inv_rec/Tanks/Fede_AcuteTest_19_12_12/ANALYSED'
w=cd;
load Fede_STIM.mat
cd([w,'/Block-',num2str(block),'/PSTH'])
ww=cd;

% 1:4 azimuth movies
% 5:20 azimuth static
% 21:60 position movies
% 61:96 position movies
% 97:116 bar movies
% 117:135 bar static

%%%do not include
% 136:156 bar static
% 157:160 size movies
% 161:166 size static
% 167:174 InPlane static


load([ww,'/',num2str(BINN),'/',num2str(1)])   % num2str(5) ?? maybe cuz its the first bitcode in the old code?

if STIM_STOP(1) > STIM_START(1)
stim_pres_times = abs(STIM_START - STIM_STOP);
end

% test plot
figure;
hist (stim_pres_times)

% DEFAULT_PSTH_0=1;
% SIZE_TUNNING_0=0;
% POSITION_TUNNING=0;
% INPLANE_TUNNING_0=0;
% AZIMUTH_TUNNING_0=0;

AZ_MOVIES_TUNING = 1;

% load([ww,'/',num2str(BINN),'/',num2str(5)])  why load twice??

% SPST=size(PSTH{1},2); ??

cd ..
ww=cd;

%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Az_Movies PSTH's
%%%%%%%%%%%%%%%%%%%%%%%%

BIT_SET=Fede_STIM(1:136,1);  %% n.b. for the first session (19_12_12) some bitcodes were overwritten (137:156), so I excluded them 

BIT_SET_AZ_MOV = Fede_STIM(1:4,1);

COLORSET=varycolor(numel(BIT_SET_AZ_MOV));


if  AZ_MOVIES_TUNING==1        % DEFAULT_PSTH_0==1
    
    for obb=BIT_SET_AZ_MOV' %[1 2 3 4]
        ob1=ob1+1;
        obb
    load([ww,'/PSTH/',num2str(BINN),'/',num2str(obb)])

% PP=reshape(sum(PSTH{ob}),size(PSTH{ob},2),[]);
% SS=reshape(std(PSTH{ob}),size(PSTH{ob},2),[]);
        for NE=1:length(SPIKES.spikes)        %% NE=1:size(PSTH{obb},2)  old code: num neurons

        N_PSTH=reshape(PSTH{obb}(Trial_Spike_Num{NE,obb},NE,:),[],size(PSTH{obb},3));
        %ORI_PSTH{NE}{ob1}=reshape(PSTH{ob}(Trial_Spike_Num{NE,ob},NE,:),[],size(PSTH{ob},3));
        O_PSTH=reshape(PSTH{obb}(Trial_Spike_Num{NE,obb},NE,:),size(PSTH{obb},3),[]);   
        OR_PSTH{NE}=[OR_PSTH{NE} mean(O_PSTH(20:40,:))/(bin)];
        GR_PSTH{NE}=[GR_PSTH{NE} obb*ones(1,numel(Trial_Spike_Num{NE,obb}))];

    %     if isempty(Trial_Spike_Num{NE,obb})==0
            for bb=1:size(PSTH{obb},3)
            M_PSTH{obb,NE}(bb)=mean(N_PSTH(:,bb))/(bin);
            S_PSTH{obb,NE}(bb)=std(N_PSTH(:,bb))/(sqrt(numel(Trial_Spike_Num{NE,obb}))*bin);
            end
            
        end
        
    end
    
    for NE=1:size(PSTH{5},2)    %% in the old code = PSTH{5},2 num of neurons for the first bitcode (5)
    OR_PSTH{NE}=[];
    GR_PSTH{NE}=[];
    end  

    ob1=0;
    T=linspace(-210,490,63);
    % BIT_SET=Fede_STIM(:,1);

    
    
        
end





%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%   SIZE TUNNING at 0
%%%%%%%%%%%%%%%%%%%%%%%%%

if SIZE_TUNNING_0==1
clear bbb sss

for NE=1:SPST
OR_PSTH{NE}=[];
GR_PSTH{NE}=[];
end 

size_set=sort(unique(STIM_CODE(1:530,4)));

STIM_ST=STIM_CODE(STIM_CODE(1:530,3)==0 & STIM_CODE(1:530,5)==0 & STIM_CODE(1:530,6)==0 & STIM_CODE(1:530,7)==0 & STIM_CODE(1:530,8)==0 & STIM_CODE(1:530,9)==0 & STIM_CODE(1:530,10)==0);

ob1=0;
T=linspace(-250,250,26);
for OB=[783 1:10]
    for obn=1:numel(STIM_ST)
if STIM_CODE(STIM_ST(obn),2)==OB
   
    ob1=ob1+1;
    obb=STIM_ST(obn);

    SIZ=find(size_set==STIM_CODE(STIM_ST(obn),4));

load([ww,'/PSTH/',num2str(obb)])

for NE=1:size(PSTH{obb},2)
N_PSTH=reshape(PSTH{obb}(Trial_Spike_Num{NE,obb},NE,:),[],size(PSTH{obb},3));
%ORI_PSTH{NE}{ob1}=reshape(PSTH{ob}(Trial_Spike_Num{NE,ob},NE,:),[],size(PSTH{ob},3));
O_PSTH=reshape(PSTH{obb}(Trial_Spike_Num{NE,obb},NE,:),size(PSTH{obb},3),[]);
OR_PSTH{NE}=[OR_PSTH{NE} mean(O_PSTH(20:40,:))/(bin)];
GR_PSTH{NE}=[GR_PSTH{NE} SIZ*ones(1,numel(Trial_Spike_Num{NE,obb}))];

end

end
    end

    
for NE=1:SPST

[n m s]=kruskalwallis(OR_PSTH{NE},GR_PSTH{NE},'off');
n=1

if n<30000
for i=1:numel(size_set)
bbb(i)=mean(OR_PSTH{NE}(GR_PSTH{NE}==i));
sss(i)=std(OR_PSTH{NE}(GR_PSTH{NE}==i))/sqrt(numel(OR_PSTH{NE}(GR_PSTH{NE}==i)));
end
bbb(i+1)=BBB(NE);%mean(OR_PSTH{NE}(GR_PSTH{NE}==783));
sss(i+1)=SSS(NE);%std(OR_PSTH{NE}(GR_PSTH{NE}==783))/sqrt(numel(OR_PSTH{NE}(GR_PSTH{NE}==783)));



h(NE)=figure(NE);
% sf{NE}=sprintf('%s%g',['p-val=',num2str(n)]);
set(gcf,'Visible', 'off'); 
if OB<11
hold on
errorbar([size_set;60],bbb(1:numel(size_set)+1),sss(1:numel(size_set)+1),'-O','linewidth',2,'color',COLORSET(OB,:))
end

% for rt=1:numel(size_set)
%     hold on
%     errorbar(size_set(rt),bbb(rt),sss(rt),'O','linewidth',2)
% end
% hold on
%     errorbar(size_set(rt)+10,bbb(numel(size_set)+1),sss(numel(size_set)+1),'O','color',[0.5 0.5 0.5],'linewidth',2)

%line([size_set(1) size_set(end)],[bbb(i+1) bbb(i+1)],'linewidth',2,'color',[0.5 0.5 0.5])
% line([-200 500],[max(M_PSTH{783,NE}) max(M_PSTH{783,NE})],'linewidth',2,'color',[0.5 0.5 0.5])
title(['Size tunning, neuron=',num2str(NE),' ,p-val=',num2str(n)])
if NE==SPST
        for NEe=1:SPST
            h(NEe)=figure(NEe)
%             legend(h,sf)
            set(gcf,'Visible', 'off');
saveas(h(NEe),[ww,'/Results/Size_Tun_0/Size_TUN_',num2str(NEe),'.jpeg']) 
saveas(h(NEe),[ww,'/Results/Size_Tun_0/Size_TUN_',num2str(NEe),'.fig']) 
        end
end

end
end
end
    
end
close all



%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%   POSITION TUNNING
%%%%%%%%%%%%%%%%%%%%%%%%%

if POSITION_TUNNING==1
clear bbb sss

for NE=1:SPST
OR_PSTH{NE}=[];
GR_PSTH{NE}=[];
end 

pos_set=sort(unique(STIM_CODE(1:530,3)));

STIM_ST=STIM_CODE(STIM_CODE(1:530,4)==25 & STIM_CODE(1:530,5)==0 & STIM_CODE(1:530,6)==0 & STIM_CODE(1:530,7)==0 & STIM_CODE(1:530,8)==0 & STIM_CODE(1:530,9)==0 & STIM_CODE(1:530,10)==0);

ob1=0;
T=linspace(-250,250,26);
for OB=[783 1:10]
    for obn=1:numel(STIM_ST)
if STIM_CODE(STIM_ST(obn),2)==OB
   
    ob1=ob1+1;
    obb=STIM_ST(obn);

    POS=find(pos_set==STIM_CODE(STIM_ST(obn),3));

load([ww,'/PSTH/',num2str(obb)])

for NE=1:SPST
N_PSTH=reshape(PSTH{obb}(Trial_Spike_Num{NE,obb},NE,:),[],size(PSTH{obb},3));
%ORI_PSTH{NE}{ob1}=reshape(PSTH{ob}(Trial_Spike_Num{NE,ob},NE,:),[],size(PSTH{ob},3));
O_PSTH=reshape(PSTH{obb}(Trial_Spike_Num{NE,obb},NE,:),size(PSTH{obb},3),[]);
OR_PSTH{NE}=[OR_PSTH{NE} mean(O_PSTH(20:40,:))/(bin)];
GR_PSTH{NE}=[GR_PSTH{NE} POS*ones(1,numel(Trial_Spike_Num{NE,obb}))];

end

end
    end

    
for NE=1:SPST

[n m s]=kruskalwallis(OR_PSTH{NE},GR_PSTH{NE},'off')
n=1

if n<30000
for i=1:numel(pos_set)
bbb(i)=mean(OR_PSTH{NE}(GR_PSTH{NE}==i));
sss(i)=std(OR_PSTH{NE}(GR_PSTH{NE}==i))/sqrt(numel(OR_PSTH{NE}(GR_PSTH{NE}==i)));
end
bbb(i+1)=BBB(NE);%mean(OR_PSTH{NE}(GR_PSTH{NE}==783));
sss(i+1)=SSS(NE);%std(OR_PSTH{NE}(GR_PSTH{NE}==783))/sqrt(numel(OR_PSTH{NE}(GR_PSTH{NE}==783)));

h(NE)=figure(NE)
set(gcf,'Visible', 'off'); 
hold on
if OB<11
hold on
errorbar([pos_set;60],bbb(1:numel(size_set)+1),sss(1:numel(size_set)+1),'-O','linewidth',2,'color',COLORSET(OB,:))
end
% for rt=1:numel(pos_set)
%     hold on
%     errorbar(pos_set(rt),bbb(rt),sss(rt),'O','linewidth',2)
% end
% hold on
%     errorbar(pos_set(rt)+1,bbb(rt+1+1),sss(rt),'color',[0.5 0.5 0.5],'O','linewidth',2)

%line([pos_set(1) pos_set(end)],[bbb(i+1) bbb(i+1)],'linewidth',2,'color',[0.5 0.5 0.5])
title(['Position Tunning, neuron=',num2str(NE),' ,p-val=',num2str(n)])
if NE==SPST
        for NEe=1:SPST
            h(NEe)=figure(NEe)
            set(gcf,'Visible', 'off');
saveas(h(NEe),[ww,'/Results/Position_Tun/Pos_TUN_',num2str(NEe),'.jpeg']) 
saveas(h(NEe),[ww,'/Results/Position_Tun/Pos_TUN_',num2str(NEe),'.fig']) 
        end
end

end
end
end
    
end
close all


%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%   Inplane TUNNING at 0
%%%%%%%%%%%%%%%%%%%%%%%%%

if INPLANE_TUNNING_0==1
clear bbb sss

for NE=1:SPST
OR_PSTH{NE}=[];
GR_PSTH{NE}=[];
end 

inplane_set=sort(unique(STIM_CODE(1:530,5)));

STIM_ST=STIM_CODE(STIM_CODE(1:530,3)==0 & STIM_CODE(1:530,4)==25 & STIM_CODE(1:530,6)==0 & STIM_CODE(1:530,7)==0 & STIM_CODE(1:530,8)==0 & STIM_CODE(1:530,9)==0 & STIM_CODE(1:530,10)==0);

ob1=0;
T=linspace(-250,250,26);
for OB=1:10
    for obn=1:numel(STIM_ST)
if STIM_CODE(STIM_ST(obn),2)==OB
   
    ob1=ob1+1;
    obb=STIM_ST(obn);

    INP=find(inplane_set==STIM_CODE(STIM_ST(obn),5));

load([ww,'/PSTH/',num2str(obb)])

for NE=1:size(PSTH{obb},2)
N_PSTH=reshape(PSTH{obb}(Trial_Spike_Num{NE,obb},NE,:),[],size(PSTH{obb},3));
%ORI_PSTH{NE}{ob1}=reshape(PSTH{ob}(Trial_Spike_Num{NE,ob},NE,:),[],size(PSTH{ob},3));
O_PSTH=reshape(PSTH{obb}(Trial_Spike_Num{NE,obb},NE,:),size(PSTH{obb},3),[]);
OR_PSTH{NE}=[OR_PSTH{NE} mean(O_PSTH(20:40,:))/(bin)];
GR_PSTH{NE}=[GR_PSTH{NE} INP*ones(1,numel(Trial_Spike_Num{NE,obb}))];

end

end
    end

    
for NE=1:size(PSTH{obb},2)

[n m s]=kruskalwallis(OR_PSTH{NE},GR_PSTH{NE},'off')
n=1

if n<30000
for i=1:numel(inplane_set)
bbb(i)=mean(OR_PSTH{NE}(GR_PSTH{NE}==i));
sss(i)=std(OR_PSTH{NE}(GR_PSTH{NE}==i))/sqrt(numel(OR_PSTH{NE}(GR_PSTH{NE}==i)));
end
bbb(i+1)=mean(OR_PSTH{NE}(GR_PSTH{NE}==783));
sss(i+1)=std(OR_PSTH{NE}(GR_PSTH{NE}==783))/sqrt(numel(OR_PSTH{NE}(GR_PSTH{NE}==783)));

h(NE)=figure(NE)
set(gcf,'Visible', 'off'); 
hold on
for rt=1:numel(inplane_set)+1
    hold on
    errorbar(inplane_set(rt),bbb(rt),sss(rt),'color',COLORSET(rt,:))
end
hold on
% line([-200 500],[max(M_PSTH{783,NE}) max(M_PSTH{783,NE})],'linewidth',2,'color',[0.5 0.5 0.5])
title(['Inplane tunning, neuron=',num2str(NE),' ,p-val=',num2str(n)])
if NE==size(PSTH{obb},2)
        for NEe=1:size(PSTH{obb},2)
            h(NEe)=figure(NEe)
            set(gcf,'Visible', 'off');
saveas(h(NEe),[ww,'/Results/Inplane_Tun_0/INP_TUN_',num2str(NEe),'.jpg']) 
saveas(h(NEe),[ww,'/Results/Inplane_Tun_0/INP_TUN_',num2str(NEe),'.fig']) 
        end
end
end
end
end
    
end
close all


%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%   Aimuth TUNNING at 0
%%%%%%%%%%%%%%%%%%%%%%%%%

if AZIMUTH_TUNNING_0==1
clear bbb sss

for NE=1:SPST
OR_PSTH{NE}=[];
GR_PSTH{NE}=[];
end 

azimuth_set=sort(unique(STIM_CODE(1:530,6)));

STIM_ST=STIM_CODE(STIM_CODE(1:530,3)==0 & STIM_CODE(1:530,4)==25 & STIM_CODE(1:530,5)==0 & STIM_CODE(1:530,7)==0 & STIM_CODE(1:530,8)==0 & STIM_CODE(1:530,9)==0 & STIM_CODE(1:530,10)==0);

ob1=0;
T=linspace(-250,250,26);
for OB=1:10
    for obn=1:numel(STIM_ST)
if STIM_CODE(STIM_ST(obn),2)==OB
   
    ob1=ob1+1;
    obb=STIM_ST(obn);

    AZM=find(azimuth_set==STIM_CODE(STIM_ST(obn),6));

load([ww,'/PSTH/',num2str(obb)])

for NE=1:size(PSTH{obb},2)
N_PSTH=reshape(PSTH{obb}(Trial_Spike_Num{NE,obb},NE,:),[],size(PSTH{obb},3));
%ORI_PSTH{NE}{ob1}=reshape(PSTH{ob}(Trial_Spike_Num{NE,ob},NE,:),[],size(PSTH{ob},3));
O_PSTH=reshape(PSTH{obb}(Trial_Spike_Num{NE,obb},NE,:),size(PSTH{obb},3),[]);
OR_PSTH{NE}=[OR_PSTH{NE} mean(O_PSTH(20:40,:))/(bin)];
GR_PSTH{NE}=[GR_PSTH{NE} AZM*ones(1,numel(Trial_Spike_Num{NE,obb}))];

end

end
    end

    
for NE=1:size(PSTH{obb},2)

[n m s]=kruskalwallis(OR_PSTH{NE},GR_PSTH{NE},'off')
n=1

if n<30000
for i=1:numel(azimuth_set)
bbb(i)=mean(OR_PSTH{NE}(GR_PSTH{NE}==i));
sss(i)=std(OR_PSTH{NE}(GR_PSTH{NE}==i))/sqrt(numel(OR_PSTH{NE}(GR_PSTH{NE}==i)));
end

h(NE)=figure(NE)
set(gcf,'Visible', 'off'); 
hold on
for rt=1:numel(azimuth_set)
    hold on
    errorbar(azimuth_set(rt),bbb(rt),sss(rt),'color',COLORSET(rt,:))
end
hold on
line([-200 500],[max(M_PSTH{783,NE}) max(M_PSTH{783,NE})],'linewidth',2,'color',[0.5 0.5 0.5])
title(['Azimuth tunning, neuron=',num2str(NE),' ,p-val=',num2str(n)])
if NE==size(PSTH{obb},2)
        for NEe=1:size(PSTH{obb},2)
            h(NEe)=figure(NEe)
            set(gcf,'Visible', 'off');
saveas(h(NEe),[ww,'/Results/Azimuth_Tun_0/AZM_TUN_',num2str(NEe),'.jpg']) 
saveas(h(NEe),[ww,'/Results/Azimuth_Tun_0/AZM_TUN_',num2str(NEe),'.fig']) 
        end
end
end
end
end
    
end
close all
    