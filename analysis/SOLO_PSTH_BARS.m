clear all
close all
clc
w=cd;
blocks=[3];
%bin=50/1000;

%FOLDER_FROM=['/zocconasphys2/acute_objects/Sina_Acute_Rec_6_07_2012/ANALYSED'];
FOLDER_FROM12=['/zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_2_7_2013/ANALYSED'];

bin=25/1000;

POST_TIME=500/1000; 
PRE_TIME=250/1000;

shift_bin=10/1000;  

for  BLOCK_NUM1=blocks
 BLOCK_NUM1   
%FOLDER_FROM=['/zocconasphys2/acute_objects/Sina_Acute_Rec_13_07_2012/ANALYSED'];

%FOLDER_FROM=['/zocconasphys2/acute_objects/Recording_21_6_2012/ANALYSED'];
    
load([FOLDER_FROM12,'/Block-',num2str(BLOCK_NUM1),'/SPIKE.mat'])
% FOLDER_FROM=['/zocconasphys2/acute_objects/Sina_Acute_Rec_13_07_201   2/ANALYSED'];
% load([	,'/Block-',num2str(23),'/23.mat'])

%FOLDER_FROM=['/zocconasphys2/acute_objects/Sina_Acute_Rec_13_07_2012/ANALYSED'];
FOLDER_FROM=FOLDER_FROM12;

mkdir([FOLDER_FROM,'/Block-',num2str(BLOCK_NUM1),'/PSTH'])

mkdir([FOLDER_FROM,'/Block-',num2str(BLOCK_NUM1),'/PSTH/',num2str(bin*1000)])

%FOLDER_FROM=['/zocconasphys2/acute_objects/Recording_21_6_2012/ANALYSED'];

% load(['SPIKE.mat'])
cd(FOLDER_FROM)
TSTART=1; %1sec

num_bin=floor((POST_TIME+PRE_TIME-bin)/shift_bin);
% PSTH=zeros(size(SPIKES.spikes,2),max(BCODE),num_bin);
% PSTH_STE=zeros(size(SPIKES.spikes,2),max(BCODE),num_bin);

BITCODE=BCODE(TBCOD>TSTART);
TBC=TBCOD(TBCOD>TSTART);

ind_start=find(diff(BITCODE)>=1);
STIM_START=TBC(ind_start);
BIT_START=BITCODE(ind_start+1);

ind_stop=find(diff(BITCODE)<=-1);
STIM_STOP=TBC(ind_stop);
BIT_STOP=BITCODE(ind_stop); % should be equal to BIT_START

%BIT_START=BIT_START(1:13813)

%%% note: for session 7_6_2013, block 5, the bitcode in position 1959 of
%%% BIT_STOP was misaligned:

% BIT_STOP(BIT_STOP(1, 1))=[];


if unique(BIT_START-BIT_STOP)~=0
    error('check the BIT convertion')
end

clear BITCODE TBC BCODE TBCOD

% no_noise=0;
% for channel=1:size(SPIKES.channel,2)
% if SPIKES.noise{channel}==0
%     no_noise=no_noise+1;
% end
% end
    

for i=unique(sort(BIT_START))%1:max(BIT_START)
% if chan==1
% PSTH{i}=zeros(no_noise,num_bin,Trial_Spike_Period{channel}(2)-Trial_Spike_Period{channel}(1)+1);
% end
chan=0;

for channel=1:size(SPIKES.channel,2)
    
    %PSTH{chan}=zeros(numel(STIM_START),size(SPIKES.channel),num_bin);

%if SPIKES.noise{channel}==0
chan=chan+1;

% cl_psth = str2num(input('Which Cluster to proceed?  ', 's'));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   PSTH
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   computing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

TIMES=SPIKES.spikes{channel};
Spike_Time_Period{chan}(1)=min(SPIKES.spikes{channel});
Spike_Time_Period{chan}(2)=max(SPIKES.spikes{channel});
[TT Trial_Spike_Period{chan}(1)]=min(abs(Spike_Time_Period{chan}(1)-STIM_START));
[TT Trial_Spike_Period{chan}(2)]=min(abs(Spike_Time_Period{chan}(2)-STIM_STOP));

   stimulus_bitcode=i;
   disp([num2str(chan),' , ',num2str(i),'/',num2str(max(BIT_START))])

   STIM_TI=STIM_START(BIT_START==stimulus_bitcode); 
   TRIAL_TI=find(BIT_START==stimulus_bitcode);

trial_num=0;
%Trial_Spike_Num{chan,i}=0;
tt0=0;
RASTER{1}=-1;
Trial_Spike_Num{chan,i}=[];
for tt=1:numel(STIM_TI)

if (TRIAL_TI(tt)>=Trial_Spike_Period{chan}(1) & TRIAL_TI(tt)<=Trial_Spike_Period{chan}(2))
tt0=tt0+1;
Trial_Spike_Num{chan,i}(tt0)=TRIAL_TI(tt);%Trial_Spike_Num{chan,i}+1;
end

%trial_num=TRIAL_TI(tt);

  TIME_START=STIM_TI(tt)-PRE_TIME;
  TIME_END=STIM_TI(tt)+POST_TIME;

SPIKES_TAKEN=TIMES(TIMES<TIME_END & TIMES>TIME_START)-TIME_START;

if (TRIAL_TI(tt)>=Trial_Spike_Period{chan}(1) & TRIAL_TI(tt)<=Trial_Spike_Period{chan}(2))
RASTER{tt0}=SPIKES_TAKEN;

trial_num=trial_num+1;

for b=1:num_bin+1   
PSTH{chan}(trial_num,b)=sum(SPIKES_TAKEN>shift_bin*(b-1) & SPIKES_TAKEN<(shift_bin*(b-1)+bin));
end

end
% end

end

        
%end
[i chan]
w=cd;
save([w,'/Block-',num2str(BLOCK_NUM1),'/PSTH/',num2str(bin*1000),'/RASTER_',num2str(i),'_',num2str(chan),'.mat'],'RASTER')
clear RASTER
end
CHANNELS=SPIKES.channel;
save([w,'/Block-',num2str(BLOCK_NUM1),'/PSTH/',num2str(bin*1000),'/',num2str(i),'.mat'],'PSTH','Spike_Time_Period','STIM_START','STIM_STOP','TRIAL_TI','Trial_Spike_Num','Trial_Spike_Period','bin','PRE_TIME','POST_TIME','shift_bin','CHANNELS','-v7.3')
clear PSTH RASTER
end
end
% clearvars -except PSTH


% save(['PSTH.mat'])
