clear all
close all
clc
w=cd;
BLOCK_NUM1=3;
bin=25/1000;
%bin=50/1000;

POST_TIME=2200/1000; 
PRE_TIME=200/1000;

%POST_TIME=450/1000; 
%PRE_TIME=200/1000;

%OBJECT_SINGLE=10;

shift_bin=10/1000;

%FOLDER_FROM=['/zocconasphys2/acute_objects/Sina_Acute_Rec_6_07_2012/ANALYSED'];
FOLDER_FROM12=['/zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_18_3_2013/ANALYSED'];

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
TSTART=0; %sec

num_bin=floor((POST_TIME+PRE_TIME-bin)/shift_bin);
% PSTH=zeros(size(SPIKES.spikes,2),max(BCODE),num_bin);
% PSTH_STE=zeros(size(SPIKES.spikes,2),max(BCODE),num_bin);

BITCODE=BCODE(TBCOD>TSTART);
TBC=TBCOD(TBCOD>TSTART);

ind_start=find(diff(BITCODE)>=1);
STIM_START=TBC(ind_start);   %%% vector of all the trial starts in a session 
BIT_START=BITCODE(ind_start+1);  %%% vector of all the bitcodes in a session

ind_stop=find(diff(BITCODE)<=-1);
STIM_STOP=TBC(ind_stop);  %%% vector of all the trial stops in a session
BIT_STOP=BITCODE(ind_stop); % should be equal to BIT_START

%BIT_START=BIT_START(1:13813)

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
    PSTH{i}=zeros(numel(STIM_START),size(SPIKES.channel),num_bin);

for channel=1:size(SPIKES.channel,2)

%if SPIKES.noise{channel}==0
chan=chan+1;

% cl_psth = str2num(input('Which Cluster to proceed?  ', 's'));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   PSTH
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   computing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

TIMES=SPIKES.spikes{channel};
Spike_Time_Period{chan}(1)=min(SPIKES.spikes{channel});  %% first spike time of the channel
Spike_Time_Period{chan}(2)=max(SPIKES.spikes{channel});  %% last spike time of the channel
[TT Trial_Spike_Period{chan}(1)]=min(abs(Spike_Time_Period{chan}(1)-STIM_START));  %% first trial associated to first spike
[TT Trial_Spike_Period{chan}(2)]=min(abs(Spike_Time_Period{chan}(2)-STIM_STOP));   %% last trial associated to last spike

   stimulus_bitcode=i;
   disp([num2str(chan),' , ',num2str(i),'/',num2str(max(BIT_START))])

   STIM_TI=STIM_START(BIT_START==stimulus_bitcode); %% all times at which stim i was presented
   TRIAL_TI=find(BIT_START==stimulus_bitcode);  %% all trials at which stim i was presented

trial_num=0;
%Trial_Spike_Num{chan,i}=0;
tt0=0;
Trial_Spike_Num{chan,i}=[];
for tt=1:numel(STIM_TI)

if (TRIAL_TI(tt)>=Trial_Spike_Period{chan}(1) & TRIAL_TI(tt)<=Trial_Spike_Period{chan}(2))
tt0=tt0+1;
Trial_Spike_Num{chan,i}(tt0)=TRIAL_TI(tt);%Trial_Spike_Num{chan,i}+1;
end

%trial_num=trial_num+1;

trial_num=TRIAL_TI(tt);

  TIME_START=STIM_TI(tt)-PRE_TIME;
  TIME_END=STIM_TI(tt)+POST_TIME;

SPIKES_TAKEN=TIMES(TIMES<TIME_END & TIMES>TIME_START)-TIME_START;

if (TRIAL_TI(tt)>=Trial_Spike_Period{chan}(1) & TRIAL_TI(tt)<=Trial_Spike_Period{chan}(2))
RASTER{i,chan,tt0}=SPIKES_TAKEN;

for b=1:num_bin+1
PSTH{i}(trial_num,chan,b)=sum(SPIKES_TAKEN>shift_bin*(b-1) & SPIKES_TAKEN<(shift_bin*(b-1)+bin));  %% chan = neuron
end

end
% end

end

        
%end

end
w=cd;
save([w,'/Block-',num2str(BLOCK_NUM1),'/PSTH/',num2str(bin*1000),'/RASTER_',num2str(i),'.mat'],'RASTER')
save([w,'/Block-',num2str(BLOCK_NUM1),'/PSTH/',num2str(bin*1000),'/',num2str(i),'.mat'],'PSTH','Spike_Time_Period','STIM_START','STIM_STOP','TRIAL_TI','Trial_Spike_Num','Trial_Spike_Period','bin','PRE_TIME','POST_TIME','shift_bin','SPIKES','-v7.3')
clear PSTH RASTER
end

% clearvars -except PSTH


% save(['PSTH.mat'])
