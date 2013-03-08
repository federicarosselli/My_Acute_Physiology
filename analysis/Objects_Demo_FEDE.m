clc
clear TUN TUN_Bl size_set Fano

NER=NE;
cd([Fold_IN,'/'])
w=cd;
%load STIM.mat
cd([w,'/',Block,'/PSTH/',num2str(BIN)])
ww=cd;
% 1-530 objects
% 532-747 bar 
% 749-782 graging
% 783 blanck
load([ww,'/',num2str(5)])

COLORSET=varycolor(10); 

SPST=size(PSTH{5},2);

cd ..
cd ..
ww=cd;
%load([ww,'/PSTH/',num2str(BIN),'/TUNNING.mat'])

if exist([w,'/',Block,'/TMP'])
rmdir([w,'/',Block,'/TMP'],'s')
end
mkdir([w,'/',Block,'/TMP'])

%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% Defaul PSTH's
%%%%%%%%%%%%%%%%%%%%%%%%
BBB(NE)=-1;
SSS(NE)=-1;


if (Fun==1 | Fun==1)
OR_PSTH{NER}=[];
GR_PSTH{NER}=[];

ob1=0;
if OB==-1
    OB=unique(sort(STIM(:,1)))';
end
for obb=OB;%unique(sort(STIM(:,1)))'
    ob1=ob1+1;
    obb
    ww
load([ww,'/PSTH/',num2str(BIN),'/',num2str(obb),'.mat'])
T=linspace(-200,2200,size(PSTH{obb},3));

N_PSTH=reshape(PSTH{obb}(Trial_Spike_Num{NER,obb},NER,:),[],size(PSTH{obb},3));

for bb=1:size(PSTH{obb},3)
    if numel(Trial_Spike_Num{NE,obb})~=0
M_PSTH{obb,NER}(bb)=mean(N_PSTH(:,bb))/(bin);
S_PSTH{obb,NER}(bb)=std(N_PSTH(:,bb))/(sqrt(numel(Trial_Spike_Num{NER,obb}))*bin);
    else
M_PSTH{obb,NER}(bb)=0;
S_PSTH{obb,NER}(bb)=0;
    end
end

    figure(NER)
%     set(gcf,'Visible', 'off'); 
    title(['Neuron=',num2str(NER)])
hold on
if ob1>10
    COLORSET(ob1,:)=[0 0 0];
end
if obb~=111
plot(T,M_PSTH{obb,NER},'color',COLORSET(ob1,:),'linewidth',1)
else
plot(T,M_PSTH{obb,NER},'linewidth',3,'color',[0.5 0.5 0.5])
hold on
    hold on
line([0 0],[0 max(M_PSTH{obb,NER}+S_PSTH{obb,NER})],'linewidth',2)
line([250 250],[0 max(M_PSTH{obb,NER}+S_PSTH{obb,NER})],'linewidth',2)
end
xlabel(['Object=',num2str(obb)])
axis tight

end


% figure(200)
% title('z-score wrt blanck')
% for obb=[OB]
% Q=(M_PSTH{obb,NER}-M_PSTH{111,NER})./S_PSTH{111,NER};
% Q(isnan(Q) | Q==Inf)=0;
% hold on
% plot(T,Q,'color',COLORSET(obb,:),'linewidth',2)
% hold on
% line([0 0],[min(Q) max(Q)],'linewidth',2)
% line([250 250],[min(Q) max(Q)],'linewidth',2)
% end

for i=OB
bbb(OB==i)=TUN.Me(i,NER);
sss(OB==i)=TUN.Se(i,NER);
end
bbb(end+1)=TUN.Me(111,NER);
sss(end+1)=TUN.Se(111,NER);

h=figure(130)
errorbar(1:numel(OB),bbb(1:numel(OB)),sss(1:numel(OB)),'-O','linewidth',2)
for rt=1:numel(OB)
    hold on
    errorbar(rt,bbb(rt),sss(rt),'O','color',COLORSET(rt,:),'linewidth',2)
end


hold on
    errorbar(numel(OB)+1,bbb(numel(OB)+1),sss(numel(OB)+1),'O','color',[0.5 0.5 0.5],'linewidth',2)

end
% figure;
% plot(PP(1,:))

% figure;plot(PP')

%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%   RASTER
%%%%%%%%%%%%%%%%%%%%%%%%%
if Fun==6
% if numel(OB)~=1
%     error('Give ONE object')
% end
if OB==0
STIM_NM=STIM(STIM(1:30,2)==OBJ & STIM(1:30,3)==SIZ & STIM(1:30,4)==POS & STIM(1:30,5)==INP & STIM(1:30,6)==AZM,1);
else
STIM_NM=(STIM(OB,1));    
end

for OB1=[STIM_NM]
    obb=OB1
load([ww,'/PSTH/',num2str(BIN),'/',num2str(obb),'.mat'])
T=linspace(-200,800,size(PSTH{obb},3));

N_PSTH=reshape(PSTH{obb}(Trial_Spike_Num{NER,obb},NER,:),[],size(PSTH{obb},3));

for bb=1:size(PSTH{obb},3)
    if numel(Trial_Spike_Num{NE,obb})~=0
M_PSTH{obb,NER}(bb)=mean(N_PSTH(:,bb))/(bin);
S_PSTH{obb,NER}(bb)=std(N_PSTH(:,bb))/(sqrt(numel(Trial_Spike_Num{NER,obb}))*bin);
    else
M_PSTH{obb,NER}(bb)=0;
S_PSTH{obb,NER}(bb)=0;
    end
end   
load([ww,'/PSTH/',num2str(BIN),'/RASTER_',num2str(obb),'.mat'])
figure(1000+100*OB1+10*POS+SIZ)
%T=linspace(-200,450,63);

%subplot(2,1,find([OB1 783]==obb))
for trl=1:size(RASTER,3)
hold on
subplot(2,1,2)
plot(T,M_PSTH{obb,NER},'linewidth',1)   
xlim([-200 800])
if OB==0
title(['object=',num2str(OBJ),' ,size=',num2str(SIZ),' ,pos=',num2str(POS),' ,inp=',num2str(INP),' ,azi=',num2str(AZM)])
else
title(['object=',num2str(STIM(OB,2)),' ,size=',num2str(STIM(OB,3)),' ,pos=',num2str(STIM(OB,4)),' ,inp=',num2str(STIM(OB,5)),' ,azi=',num2str(STIM(OB,6))])
end

%plot(RASTER{obb,NER,trl}*1000-PRE_TIME*1000,ones(size(RASTER{obb,NER,trl}),1)*trl,'.','color',[0.5 0.5 0.5])
subplot(2,1,1)
plot(RASTER{obb,NER,trl}*1000-PRE_TIME*1000,ones(size(RASTER{obb,NER,trl}),1)*trl,'.')
xlim([-200 800])
[OB NER trl]

end

hold on
line([0 0],[0 trl],'linewidth',2)
%line([250 250],[0 trl],'linewidth',2)
xlim([-200 800])


end
end



%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%   SIZE TUNNING
%%%%%%%%%%%%%%%%%%%%%%%%%

if Fun==2
    clear bbb sss

  

    size_set=sort(unique(STIM(1:30,3)));

    STIM_ST=STIM(STIM(1:30,2)==OBJ & STIM(1:30,4)==0 & STIM(1:30,5)==0 & STIM(1:30,6)==0);

    ob1=0;

    n=1
    Fano=[];

    for i=1:numel(size_set)
        I=size_set(i);
    STIM_NM=STIM(STIM(1:30,2)==OBJ & STIM(1:30,3)==I & STIM(1:30,4)==0 & STIM(1:30,5)==0 & STIM(1:30,6)==0,1)
    load([ww,'/PSTH/',num2str(BIN),'/RASTER_',num2str(STIM_NM),'.mat'])
    sp_tr=[];

for oi=1:size(RASTER,3)
sp_tr(oi)=sum(RASTER{STIM_NM,NER,oi}>(T1/1000+PRE_TIME) & RASTER{STIM_NM,NER,oi}<(T2/1000+PRE_TIME));
end
sp_tr
TUN.Me(i)=mean(sp_tr)/(T2-T1)*1000;
TUN.St(i)=std(sp_tr)/(T2-T1)*1000;
TUN.Se(i)=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;

Fano(i)=var(sp_tr)/mean(sp_tr);

    bbb(find(size_set==I))=TUN.Me(i);
    sss(find(size_set==I))=TUN.Se(i);
    %sp_tr
    end
    
load([ww,'/PSTH/',num2str(BIN),'/RASTER_',num2str(111),'.mat'])
sp_tr=[];
for oi=1:size(RASTER,3)
sp_tr(oi)=sum(RASTER{111,NER,oi}>(T1/1000+PRE_TIME) & RASTER{111,NER,oi}<(T2/1000+PRE_TIME));
end
TUN_Bl.Me=mean(sp_tr)/(T2-T1)*1000;
TUN_Bl.St=std(sp_tr)/(T2-T1)*1000;
TUN_Bl.Se=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
    bbb(find(size_set==I)+1)=TUN_Bl.Me;
    sss(find(size_set==I)+1)=TUN_Bl.Se;
    
    h(NER)=figure(NER)

subplot(2,1,1) 
xlabel(['Size tuning, neuron=',num2str(NER),' ,channel=',num2str(SPIKES.channel{NER})])
Y=[];
for iu=1:numel(size_set)
    Y=[Y;bbb(end)-sss(end)/2 sss(end)/2 sss(end)/2];
end
h = area(size_set,Y,-5); % Set BaseValue via argument
set(h(1),'FaceColor',[.5 0.5 0.5])
set(h(2),'FaceColor',[.5 0.5 0.5])
set(h(3),'FaceColor',[.5 0.5 0.5])
set(h,'LineStyle',':','LineWidth',0.1) % Set all to same value.
set(h,'basevalue',bbb(end)-sss(end)/2)
hold on
line([size_set(1) size_set(end)],[bbb(end) bbb(end)],'color','k','linewidth',2)
hold on
her=errorbar(size_set,bbb(1:numel(size_set))',sss(1:numel(size_set))','-O','linewidth',2,'color',COLORSET(OBJ,:))
xlim([size_set(1)-3 size_set(end)+3])
legend(her,['object ',num2str(OBJ)])

subplot(2,1,2) 
title(['Fano factor'])
her=plot(size_set,Fano,'-O','linewidth',2,'color',COLORSET(OBJ,:))
xlim([size_set(1)-3 size_set(end)+3])
legend(her,['object ',num2str(OBJ)])

save([w,'/',Block,'/TMP/tun.mat'],'TUN','TUN_Bl','size_set','Fano')

    end


    %%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%   POSITION TUNNING
    %%%%%%%%%%%%%%%%%%%%%%%%%
if Fun==3
       clear bbb sss

  

    size_set=sort(unique(STIM(1:30,4)));


    ob1=0;

    n=1
Fano=[];

    for i=1:numel(size_set)
        I=size_set(i);
   STIM_NM=STIM(STIM(1:30,2)==OBJ & STIM(1:30,4)==I & STIM(1:30,5)==0 & STIM(1:30,6)==0 & STIM(1:30,3)==35,1)
load([ww,'/PSTH/',num2str(BIN),'/RASTER_',num2str(STIM_NM),'.mat'])
sp_tr=[];

for oi=1:size(RASTER,3)
sp_tr(oi)=sum(RASTER{STIM_NM,NER,oi}>(T1/1000+PRE_TIME) & RASTER{STIM_NM,NER,oi}<(T2/1000+PRE_TIME));
end
sp_tr
TUN.Me(i)=mean(sp_tr)/(T2-T1)*1000;
TUN.St(i)=std(sp_tr)/(T2-T1)*1000;
TUN.Se(i)=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;

Fano(i)=var(sp_tr)/mean(sp_tr);

    bbb(find(size_set==I))=TUN.Me(i);
    sss(find(size_set==I))=TUN.Se(i);
    end
        load([ww,'/PSTH/',num2str(BIN),'/RASTER_',num2str(111),'.mat'])
       sp_tr=[]; 
for oi=1:size(RASTER,3)
sp_tr(oi)=sum(RASTER{111,NER,oi}>(T1/1000+PRE_TIME) & RASTER{111,NER,oi}<(T2/1000+PRE_TIME));
end
TUN_Bl.Me=mean(sp_tr)/(T2-T1)*1000;
TUN_Bl.St=std(sp_tr)/(T2-T1)*1000;
TUN_Bl.Se=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
    bbb(find(size_set==I)+1)=TUN_Bl.Me;
    sss(find(size_set==I)+1)=TUN_Bl.Se;
    


 
    h(NER)=figure(NER);
  

subplot(2,1,1) 
xlabel(['Position tuning, neuron=',num2str(NER),' ,channel=',num2str(SPIKES.channel{NER})])
Y=[];
for iu=1:numel(size_set)
    Y=[Y;bbb(end)-sss(end)/2 sss(end)/2 sss(end)/2];
end
h = area(size_set,Y,-5); % Set BaseValue via argument
set(h(1),'FaceColor',[.5 0.5 0.5])
set(h(2),'FaceColor',[.5 0.5 0.5])
set(h(3),'FaceColor',[.5 0.5 0.5])
set(h,'LineStyle',':','LineWidth',0.1) % Set all to same value.
set(h,'basevalue',bbb(end)-sss(end)/2)
hold on
line([size_set(1) size_set(end)],[bbb(end) bbb(end)],'color','k','linewidth',2)
hold on
her=errorbar(size_set,bbb(1:numel(size_set))',sss(1:numel(size_set))','-O','linewidth',2,'color',COLORSET(OBJ,:))
xlim([size_set(1)-3 size_set(end)+3])
legend(her,['object ',num2str(OBJ)])

subplot(2,1,2) 
title(['Fano factor'])
her=plot(size_set,Fano,'-O','linewidth',2,'color',COLORSET(OBJ,:))
xlim([size_set(1)-3 size_set(end)+3])
legend(her,['object ',num2str(OBJ)])



save([w,'/',Block,'/TMP/tun.mat'],'TUN','TUN_Bl','size_set','Fano')

    end
    %%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%   AZIMUTH TUNNING
    %%%%%%%%%%%%%%%%%%%%%%%%%
if Fun==4
        clear bbb sss

  

    size_set=sort(unique(STIM(1:30,6)));


    ob1=0;

    n=1
Fano=[];

    for i=1:numel(size_set)
        I=size_set(i);
    STIM_NM=STIM(STIM(1:30,6)==I & STIM(1:30,2)==OBJ & STIM(1:30,3)==35  & STIM(1:30,4)==0 & STIM(1:30,5)==0,1);
load([ww,'/PSTH/',num2str(BIN),'/RASTER_',num2str(STIM_NM),'.mat'])
sp_tr=[];

for oi=1:size(RASTER,3)
sp_tr(oi)=sum(RASTER{STIM_NM,NER,oi}>(T1/1000+PRE_TIME) & RASTER{STIM_NM,NER,oi}<(T2/1000+PRE_TIME));
end

TUN.Me(i)=mean(sp_tr)/(T2-T1)*1000;
TUN.St(i)=std(sp_tr)/(T2-T1)*1000;
TUN.Se(i)=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;

Fano(i)=var(sp_tr)/mean(sp_tr);

    bbb(find(size_set==I))=TUN.Me(i);
    sss(find(size_set==I))=TUN.Se(i);
    end
        load([ww,'/PSTH/',num2str(BIN),'/RASTER_',num2str(111),'.mat'])
        sp_tr=[];
for oi=1:size(RASTER,3)
sp_tr(oi)=sum(RASTER{111,NER,oi}>(T1/1000+PRE_TIME) & RASTER{111,NER,oi}<(T2/1000+PRE_TIME));
end
TUN_Bl.Me=mean(sp_tr)/(T2-T1)*1000;
TUN_Bl.St=std(sp_tr)/(T2-T1)*1000;
TUN_Bl.Se=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
    bbb(find(size_set==I)+1)=TUN_Bl.Me;
    sss(find(size_set==I)+1)=TUN_Bl.Se;
    


 
    h(NER)=figure(NER);
  

subplot(2,1,1) 
xlabel(['Azimuth tuning, neuron=',num2str(NER),' ,channel=',num2str(SPIKES.channel{NER})])
Y=[];
for iu=1:numel(size_set)
    Y=[Y;bbb(end)-sss(end)/2 sss(end)/2 sss(end)/2];
end
h = area(size_set,Y,-5); % Set BaseValue via argument
set(h(1),'FaceColor',[.5 0.5 0.5])
set(h(2),'FaceColor',[.5 0.5 0.5])
set(h(3),'FaceColor',[.5 0.5 0.5])
set(h,'LineStyle',':','LineWidth',0.1) % Set all to same value.
set(h,'basevalue',bbb(end)-sss(end)/2)
hold on
line([size_set(1) size_set(end)],[bbb(end) bbb(end)],'color','k','linewidth',2)
hold on
her=errorbar(size_set,bbb(1:numel(size_set))',sss(1:numel(size_set))','-O','linewidth',2,'color',COLORSET(OBJ,:))
xlim([size_set(1)-3 size_set(end)+3])
legend(her,['object ',num2str(OBJ)])

subplot(2,1,2) 
title(['Fano factor'])
her=plot(size_set,Fano,'-O','linewidth',2,'color',COLORSET(OBJ,:))
xlim([size_set(1)-3 size_set(end)+3])
legend(her,['object ',num2str(OBJ)])

save([w,'/',Block,'/TMP/tun.mat'],'TUN','TUN_Bl','size_set','Fano')


    end
    %%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%   INPLANE TUNNING
    %%%%%%%%%%%%%%%%%%%%%%%%%
if Fun==5
           clear bbb sss

  

    size_set=sort(unique(STIM(1:30,5)));


    ob1=0;

    n=1
Fano=[];

    for i=1:numel(size_set)
        I=size_set(i);
    STIM_NM=STIM(STIM(1:30,5)==I & STIM(1:30,2)==OBJ & STIM(1:30,3)==35  & STIM(1:30,4)==0 & STIM(1:30,6)==0,1);
load([ww,'/PSTH/',num2str(BIN),'/RASTER_',num2str(STIM_NM),'.mat'])
sp_tr=[];

for oi=1:size(RASTER,3)
sp_tr(oi)=sum(RASTER{STIM_NM,NER,oi}>(T1/1000+PRE_TIME) & RASTER{STIM_NM,NER,oi}<(T2/1000+PRE_TIME));
end

TUN.Me(i)=mean(sp_tr)/(T2-T1)*1000;
TUN.St(i)=std(sp_tr)/(T2-T1)*1000;
TUN.Se(i)=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;

Fano(i)=var(sp_tr)/mean(sp_tr);

    bbb(find(size_set==I))=TUN.Me(i);
    sss(find(size_set==I))=TUN.Se(i);
    end
        load([ww,'/PSTH/',num2str(BIN),'/RASTER_',num2str(111),'.mat'])
        sp_tr=[];
for oi=1:size(RASTER,3)
sp_tr(oi)=sum(RASTER{111,NER,oi}>(T1/1000+PRE_TIME) & RASTER{111,NER,oi}<(T2/1000+PRE_TIME));
end
TUN_Bl.Me=mean(sp_tr)/(T2-T1)*1000;
TUN_Bl.St=std(sp_tr)/(T2-T1)*1000;
TUN_Bl.Se=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
    bbb(find(size_set==I)+1)=TUN_Bl.Me;
    sss(find(size_set==I)+1)=TUN_Bl.Se;
    


 
    h(NER)=figure(NER);
  

subplot(2,1,1) 
xlabel(['Inplane tuning, neuron=',num2str(NER),' ,channel=',num2str(SPIKES.channel{NER})])
Y=[];
for iu=1:numel(size_set)
    Y=[Y;bbb(end)-sss(end)/2 sss(end)/2 sss(end)/2];
end
h = area(size_set,Y,-5); % Set BaseValue via argument
set(h(1),'FaceColor',[.5 0.5 0.5])
set(h(2),'FaceColor',[.5 0.5 0.5])
set(h(3),'FaceColor',[.5 0.5 0.5])
set(h,'LineStyle',':','LineWidth',0.1) % Set all to same value.
set(h,'basevalue',bbb(end)-sss(end)/2)
hold on
line([size_set(1) size_set(end)],[bbb(end) bbb(end)],'color','k','linewidth',2)
hold on
her=errorbar(size_set,bbb(1:numel(size_set))',sss(1:numel(size_set))','-O','linewidth',2,'color',COLORSET(OBJ,:))
xlim([size_set(1)-3 size_set(end)+3])
legend(her,['object ',num2str(OBJ)])

subplot(2,1,2) 
title(['Fano factor'])
her=plot(size_set,Fano,'-O','linewidth',2,'color',COLORSET(OBJ,:))
xlim([size_set(1)-3 size_set(end)+3])
legend(her,['object ',num2str(OBJ)])


save([w,'/',Block,'/TMP/tun.mat'],'TUN','TUN_Bl','size_set','Fano')

    end
    