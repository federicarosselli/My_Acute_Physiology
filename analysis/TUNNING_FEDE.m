close all
clear all
block=1;
BINN=50;

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
% 117:156 bar static
% 157:160 size movies
% 161:166 size static
% 167:174 InPlane static

% 532-747 bar 
% 749-782 graging
% 783 blanck

load([ww,'/',num2str(BINN),'/',num2str(5)])

 

DEFAULT_PSTH_0=1;
SIZE_TUNNING_0=0;
POSITION_TUNNING=0;
INPLANE_TUNNING_0=0;
AZIMUTH_TUNNING_0=0;

load([ww,'/',num2str(BINN),'/',num2str(5)])
SPST=size(PSTH{1},2);

cd ..
ww=cd;
%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Defaul PSTH's
%%%%%%%%%%%%%%%%%%%%%%%%

if DEFAULT_PSTH_0==1
    for NE=1:size(PSTH{5},2)
    OR_PSTH{NE}=[];
    GR_PSTH{NE}=[];
    end  

    ob1=0;
    T=linspace(-210,490,63);
    % BIT_SET=Fede_STIM(:,1);

    BIT_SET=Fede_STIM(1:136,1);  %% n.b. for the first session (19_12_12) some bitcodes were overwritten (137:156), so I excluded them 


    COLORSET=varycolor(numel(BIT_SET));

    for obb=BIT_SET' %[111 77 78]
        ob1=ob1+1;
        obb
    load([ww,'/PSTH/',num2str(BINN),'/',num2str(obb)])

% PP=reshape(sum(PSTH{ob}),size(PSTH{ob},2),[]);
% SS=reshape(std(PSTH{ob}),size(PSTH{ob},2),[]);
        for NE=1:size(PSTH{obb},2)

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
        
end

%     else
% for bb=1:size(PSTH{obb},3)
% M_PSTH{obb,NE}(bb)=sum(N_PSTH(:,bb))/(bin);
% S_PSTH{obb,NE}(bb)=std(N_PSTH(N_PSTH(:,bb)~=0,bb))/(bin);
% end
    %end
    
    
    % if obb~=111
    %     figure(NE)
    %     set(gcf,'Visible', 'off'); 
    %  
    %     title(['Neuron=',num2str(NE)])
    % %     subplot(5,2,ob)
    %     hold on
    % 
    % plot(T,M_PSTH{obb,NE},'color',COLORSET(find(BIT_SET==obb),:),'linewidth',1)
    % aaa(NE)=max(M_PSTH{obb,NE});
    % end  
    % 
    % %errorbar(T,M_PSTH{obb,NE},S_PSTH{obb,NE},'color',COLORSET(obb,:))
    % if obb==111
    %     COLORSET(find(BIT_SET==obb),:)=[1 1 1];
    % hold on
    % plot(T,M_PSTH{obb,NE},'color',COLORSET(find(BIT_SET==obb),:),'linewidth',2)
    % % hold on
    % % line([0 0],[0 max(aaa)],'linewidth',2)
    % % hold on
    % % line([250 250],[0 max(aaa)],'linewidth',2)
    % xlabel(['Object=',num2str(obb)])
    % axis tight
    % 
    % end
    % 
    % 
    % end
    % 
    % if obb==111
    %     
    % for NE=1:size(PSTH{obb},2)
    %     figure(NE)
    %     set(gcf,'Visible', 'off'); 
    %     hold on
    % %line([-200 500],[max(M_PSTH{783,NE}) max(M_PSTH{783,NE})],'linewidth',2,'color',[0.5 0.5 0.5])
    % h(NE)=figure(NE)
    % set(gcf,'Visible', 'off'); 
    % title(['Default PSTH, neuron=',num2str(NE)])
    % saveas(h(NE),[ww,'/Results/Default/',num2str(NE),'.jpeg']) 
    % saveas(h(NE),[ww,'/Results/Default/',num2str(NE),'.fig']) 
    % end
    % 
    % close all
    % end
    % 
    % % if obb==78
    % % for NE=1:size(PSTH{obb},2)
    % %     figure(NE)
    % %     set(gcf,'Visible', 'off'); 
    % %     hold on
    % % %line([-200 500],[max(M_PSTH{783,NE}) max(M_PSTH{783,NE})],'linewidth',2,'color',[0.5 0.5 0.5])
    % % plot(T,M_PSTH{111,NE},'linewidth',3,'color',[0.5 0.5 0.5])
    % % 
    % % h(NE)=figure(NE)
    % % set(gcf,'Visible', 'off'); 
    % % title(['Default PSTH, neuron=',num2str(NE)])
    % % saveas(h(NE),[ww,'/Results/Default/D_',num2str(NE),'.jpeg']) 
    % % saveas(h(NE),[ww,'/Results/Default/D_',num2str(NE),'.fig']) 
    % % end
    % % 
    % % 
    % % end
    % 
    % 
    % clear PSTH
    % 
    % end
    % 
    % for NE=1:SPST
    % 
    % [n m s]=kruskalwallis(OR_PSTH{NE},GR_PSTH{NE},'off')
    % n=1
    % if n<30000
    % ij=0;
    % for i=[77 78]
    %     ij=ij+1;
    % bbb(ij)=mean(OR_PSTH{NE}(GR_PSTH{NE}==i));
    % sss(ij)=std(OR_PSTH{NE}(GR_PSTH{NE}==i))/sqrt(numel(OR_PSTH{NE}(GR_PSTH{NE}==i)));
    % end
    % 
    % bbb(ij+1)=mean(OR_PSTH{NE}(GR_PSTH{NE}==111));
    % sss(ij+1)=std(OR_PSTH{NE}(GR_PSTH{NE}==111))/sqrt(numel(OR_PSTH{NE}(GR_PSTH{NE}==111)));
    % BBB(NE)=bbb(ij+1);
    % SSS(NE)=sss(ij+1);
    % 
    % 
    % h=figure(13)
    % set(gcf,'Visible', 'off'); 
    % hold on
    % errorbar([1:2],bbb(1:2),sss(1:2),'-O','linewidth',2)
    % for rt=[1 2]
    %     hold on
    %     errorbar(rt,bbb(rt),sss(rt),'O','color',COLORSET(rt,:),'linewidth',2)
    % end
    % 
    % 
    % hold on
    %     errorbar(3,bbb(3),sss(3),'O','color',[0.5 0.5 0.5],'linewidth',2)
    % 
    % %line([1 10],[bbb(i+1) bbb(i+1)],'linewidth',2,'color',[0.5 0.5 0.5])
    % % line([1:10],[max(M_PSTH{obb,NE}) max(M_PSTH{obb,NE})],'linewidth',2,'color',[0.5 0.5 0.5])
    % title(['Default objects tunning, neuron=',num2str(NE),' ,p-val=',num2str(n)])
    % saveas(h,[ww,'/Results/Default/OBJ_TUN_',num2str(NE),'.jpeg']) 
    % saveas(h,[ww,'/Results/Default/OBJ_TUN_',num2str(NE),'.fig']) 
    % close all
    % 
    % end
    % end



% figure;
% plot(PP(1,:))

% figure;plot(PP')

%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%   Object vs Blanck
%%%%%%%%%%%%%%%%%%%%%%%%%



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
    