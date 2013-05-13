clc
close all
clear all
ss=0;
FILE_TOO='TEST_REV';
BLOCK_NUM_SET=[5 6]
sub_block=0; %0=full block,1=first half block, 2=second half block

DateOfRecording = '10_4_2013'

for BLOCK_NUM=1%BLOCK_NUM_SET

%FOLDER_FROM12=['/zocconasphys1/acute_objects/Sina_Acute1_Rec_20_12_2012/ANALYSED/Block-', num2str(BLOCK_NUM)];
FOLDER_FROM12=['/zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_', char(DateOfRecording), '/ANALYSED/Block-', num2str(1)];
load([FOLDER_FROM12,'/MATLAB_DATA.mat']);
TIMES_1=TIMES;
Yeneu_1=Yeneu;
Block_1_ST=TIMES_1{1}(1);
Block_1_EN=TIMES_1{1}(end);
BCODE_1=BCODE;
TBCOD_1=TBCOD;

FOLDER_FROM12=['/zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_', char(DateOfRecording), '/ANALYSED/Block-', num2str(2)];
load([FOLDER_FROM12,'/MATLAB_DATA.mat']);
TIMES_2=TIMES;
Yeneu_2=Yeneu;
Block_2_ST=TIMES_2{1}(1);
Block_2_EN=TIMES_2{1}(end);
BCODE_2=BCODE;
TBCOD_2=TBCOD;

BCODE=[BCODE_1 BCODE_2];
TBCOD=[TBCOD_1 TBCOD_2+TBCOD_1(end)];
TB_1_end=TBCOD_1(end);

for ch=1:32
TIMES{ch}=[TIMES_1{ch} TIMES_2{ch}+TIMES_1{ch}(end)];
Yeneu{ch}=[Yeneu_1{ch} Yeneu_2{ch}];
end

FOLDER_FROM_REV=['/zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_', char(DateOfRecording), '/ANALYSED/BlockS-', num2str(12)];
FOLDER_TO=FOLDER_FROM_REV;

for channel=1:32

clearvars -except TB_1_end Block_1_ST Block_1_EN Block_2_ST Block_2_EN FOLDER_FROM_REV FILE_TOO TIMES Yeneu sub_block M SPIKES ss channel BCODE TBCOD TIME_CU BLOCK_NUM FOLDER_FROM FILE_TO FOLDER_TO BLOCK_NUM_SET sub_block TEND ST

channel

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%Do_clustering_OFFLINE
%%%%%%%%%%%%%%%%%%%

Ch=channel;

FULL=0;
clear spikes index
if FULL==0
if numel(TIMES{Ch})>100%30
    
SPIKE_SIZE=34;
% for ii=1:numel(Yeneu{Ch})/SPIKE_SIZE
% spikes(ii,:)=Yeneu{Ch}((ii-1)*34+1:ii*34);%%%%reshape(Yeneu{Ch},numel(Yeneu{Ch})/SPIKE_SIZE,SPIKE_SIZE);
% end

spikes=reshape(Yeneu{Ch},SPIKE_SIZE,numel(Yeneu{Ch})/SPIKE_SIZE)';

index=TIMES{Ch}';
FILE_TO=FILE_TOO;
FOLDER_FROM=FOLDER_FROM_REV;
delete([FOLDER_FROM_REV,'/',FILE_TOO])
save([FOLDER_FROM_REV,'/',FILE_TOO],'spikes','index')
Do_clustering_OFFLINE

end
% else
% data=pYeneu{Ch};
% Get_spikes_OFFLINE
% Do_clustering_OFFLINE
end

% reply = input('Do you want to KEEP? y/n [y]: ', 's');
% if isempty(reply)
%     reply = 'y';
% end
reply='y';

if numel(TIMES{Ch})>200    
for i=1:max(cluster(:,1))

if numel(cluster(cluster(:,1)==i,2))>100
ss=ss+1;
SPIKES.spikes{ss}=cluster(cluster(:,1)==i,2);
SPIKES.channel{ss}=channel;
if size(SS,2)>100
    endfile=100;
else
    endfile=size(SS,2);
end
SPIKES.shape{ss}=SS(cluster(:,1)==i,1:endfile);
M{channel,ss,BLOCK_NUM}=mean(SS(cluster(:,1)==i,:),1);

end

end


% if min(cluster(:,1))==0 & sum(cluster(:,1)==0)>1000
% spikes=SS(cluster(:,1)==0,1:endfile);
% index=cluster(cluster(:,1)==0,2);
% FILE_TO=FILE_TOO;
% FOLDER_FROM=FOLDER_FROM_REV;
% delete([FOLDER_FROM_REV,'\',FILE_TOO])
% save([FOLDER_FROM_REV,'\',FILE_TOO],'spikes','index')
% clear cluster classes class
% Do_clustering_OFFLINE
% for i=1:max(cluster(:,1))
% if numel(cluster(cluster(:,1)==i,2))>100
% ss=ss+1;
% SPIKES.spikes{ss}=cluster(cluster(:,1)==i,2);
% SPIKES.channel{ss}=channel;
% if size(SS,2)>100
%     endfile=100;
% else
%     endfile=size(SS,2);
% end
% SPIKES.shape{ss}=SS(cluster(:,1)==i,1:endfile);
% M{channel,ss,BLOCK_NUM}=mean(SS(cluster(:,1)==i,:),1);
% end
% end
% end


end


end

clearvars -except TB_1_end SPIKES BCODE TBCOD FOLDER_TO M sub_block BLOCK_NUM FILE_TOO Block_1_ST Block_1_EN Block_2_ST Block_2_EN
save([FOLDER_TO '/SPIKE.mat'],'-v7.3')


end




