function RF_Track %(BIT_Number)

addpath /zocconasphys1/chronic_inv_rec/codes/ReceptiveField

Cool_RFs

%% 18_3_2013

cd /zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_18_3_2013/ANALYSED/

cd BlockS-67
load SPIKE
ChannelS_1 = SPIKES.channel;

cd BL_1/RFs

load ('RFo.mat')
RFo_1=RFo;
fitresulto_1=fitresulto;
files_1 = dir(fullfile('*.fig'));
neuronS_1 = (numel(files_1));
cool_RFs_1=BlockS_67; 
dim_1=length(cool_RFs_1);

[m,n]=size(RFo_1);
[j,k]=size(RFo_1{1});
margin=0.5;

labels_1={cool_RFs_1};

DayOfRec = '18/3/2013';
Session = 1;

clear RFo
clear fitresulto
clear SPIKE

cd ..

cd ..

cd ..

mkdir ('RFTrack');


dimS = [dim_1];
all_chanS.RFs = {ChannelS_1};
all_RFoS.RFs = {RFo_1};
all_fits.RFs = {fitresulto_1};
cool_RFsS.RFs = {cool_RFs_1};
all_labelS.RFs = {labels_1};



% %% 10_4_2013
% 
% cd /zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_10_4_2013/ANALYSED/
% 
% cd BlockS-12
% load SPIKE
% ChannelS_1 = SPIKES.channel;
% 
% cd BL_1/RFs
% 
% load ('RFo.mat')
% RFo_1=RFo;
% fitresulto_1=fitresulto;
% files_1 = dir(fullfile('*.fig'));
% neuronS_1 = (numel(files_1));
% cool_RFs_1=BlockS_12; 
% dim_1=length(cool_RFs_1);
% 
% [m,n]=size(RFo_1);
% [j,k]=size(RFo_1{1});
% margin=0.5;
% 
% labels_1={cool_RFs_1};
% DayOfRec = '10/4/2013';
% Session = 2;
% 
% clear RFo
% clear fitresulto
% clear SPIKE
% 
% cd ..
% 
% cd ..
% 
% cd ..
% 
% 
% 
% cd BlockS-34
% load SPIKE
% ChannelS_2 = SPIKES.channel;
% 
% cd BL_1/RFs
% 
% load ('RFo.mat')
% RFo_2=RFo;
% fitresulto_2=fitresulto;
% files_2 = dir(fullfile('*.fig'));
% neuronS_2 = (numel(files_2));
% cool_RFs_2=BlockS_34; 
% dim_2=length(cool_RFs_2);
% 
% labels_2={cool_RFs_2};
% 
% clear RFo
% clear fitresulto
% clear SPIKE
% 
% cd ..
% 
% cd ..
% 
% cd ..
% 
% 
% mkdir ('RFTrack');
% 
% 
% dimS = [dim_1, dim_2];
% all_chanS.RFs = {ChannelS_1, ChannelS_2};
% all_fits.RFs = {fitresulto_1, fitresulto_2};
% all_RFoS.RFs = {RFo_1, RFo_2};
% cool_RFsS.RFs = {cool_RFs_1, cool_RFs_2};
% all_labelS.RFs = {labels_1, labels_2};
% 
% 

% %% 12_4_2013
% % 
% cd /zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_12_4_2013/ANALYSED/
% 
% cd BlockS-12
% load SPIKE
% ChannelS_1 = SPIKES.channel;
% 
% cd BL_1/RFs
% 
% load ('RFo.mat')
% RFo_1=RFo;
% fitresulto_1=fitresulto;
% files_1 = dir(fullfile('*.fig'));
% neuronS_1 = (numel(files_1));
% cool_RFs_1=BlockS_12; 
% dim_1=length(cool_RFs_1);
% 
% [m,n]=size(RFo_1);
% [j,k]=size(RFo_1{1});
% margin=0.5;
% 
% labels_1={cool_RFs_1};
% DayOfRec = '12/4/2013';
% Session = 3;
% 
% clear RFo
% clear fitresulto
% clear SPIKE
% 
% cd ..
% 
% cd ..
% 
% cd ..
% 
% 
% 
% cd Block-3
% load SPIKE
% ChannelS_2 = SPIKES.channel;
% 
% cd RFs
% 
% load ('RFo.mat')
% RFo_2=RFo;
% fitresulto_2=fitresulto;
% files_2 = dir(fullfile('*.fig'));
% neuronS_2 = (numel(files_2));
% cool_RFs_2=Block_3; 
% dim_2=length(cool_RFs_2);
% 
% labels_2={cool_RFs_2};
% 
% clear RFo
% clear fitresulto
% clear SPIKE
% 
% cd ..
% 
% cd ..
% 
% 
% cd Block-4
% load SPIKE
% ChannelS_3 = SPIKES.channel;
% 
% cd RFs
% 
% load ('RFo.mat')
% RFo_3=RFo;
% fitresulto_3=fitresulto;
% files_3 = dir(fullfile('*.fig'));
% neuronS_3 = (numel(files_3));
% cool_RFs_3=Block_4; 
% dim_3=length(cool_RFs_3);
% 
% labels_3={cool_RFs_3};
% 
% clear RFo
% clear fitresulto
% clear SPIKE
% 
% cd ..
% 
% cd ..
% 
% 
% 
% cd BlockS-56
% load SPIKE
% ChannelS_4 = SPIKES.channel;
% 
% cd BL_1/RFs
% 
% load ('RFo.mat')
% RFo_4=RFo;
% fitresulto_4=fitresulto;
% files_4 = dir(fullfile('*.fig'));
% neuronS_4 = (numel(files_4));
% cool_RFs_4=BlockS_56; 
% dim_4=length(cool_RFs_4);
% 
% labels_4={cool_RFs_4};
% 
% clear RFo
% clear fitresulto
% clear SPIKE
% 
% cd ..
% 
% cd ..
% 
% cd ..
% 
% 
% 
% cd Block-7
% load SPIKE
% ChannelS_5 = SPIKES.channel;
% 
% cd RFs
% 
% load ('RFo.mat')
% RFo_5=RFo;
% fitresulto_5=fitresulto;
% files_5 = dir(fullfile('*.fig'));
% neuronS_5 = (numel(files_5));
% cool_RFs_5=Block_7; 
% dim_5=length(cool_RFs_5);
% 
% labels_5={cool_RFs_5};
% 
% clear RFo
% clear fitresulto
% clear SPIKE
% 
% cd ..
% 
% cd ..
% 
% 
% cd Block-8
% load SPIKE
% ChannelS_6 = SPIKES.channel;
% 
% cd RFs
% 
% load ('RFo.mat')
% RFo_6=RFo;
% fitresulto_6=fitresulto;
% files_6 = dir(fullfile('*.fig'));
% neuronS_6 = (numel(files_6));
% cool_RFs_6=Block_8; 
% dim_6=length(cool_RFs_6);
% 
% labels_6={cool_RFs_6};
% 
% clear RFo
% clear fitresulto
% clear SPIKE
% 
% cd ..
% 
% cd ..
% 
% 
% 
% 
% mkdir ('RFTrack');
% 
% 
% dimS = [dim_1, dim_2, dim_3, dim_4, dim_5, dim_6];
% all_chanS.RFs = {ChannelS_1, ChannelS_2, ChannelS_3, ChannelS_4, ChannelS_5, ChannelS_6};
% all_fits.RFs = {fitresulto_1, fitresulto_2, fitresulto_3, fitresulto_4, fitresulto_5, fitresulto_6};
% all_RFoS.RFs = {RFo_1, RFo_2, RFo_3, RFo_4, RFo_5, RFo_6};
% cool_RFsS.RFs = {cool_RFs_1, cool_RFs_2, cool_RFs_3, cool_RFs_4, cool_RFs_5, cool_RFs_6};
% all_labelS.RFs = {labels_1, labels_2, labels_3, labels_4, labels_5, labels_6};
% % 


% 
%% 29_5_2013
% cd /zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_29_5_2013/ANALYSED/
% 
% cd BlockS-12
% load SPIKE
% ChannelS_1 = SPIKES.channel;
% 
% cd BL_1/RFs
% 
% load ('RFo.mat')
% RFo_1=RFo;
% fitresulto_1=fitresulto;
% files_1 = dir(fullfile('*.fig'));
% neuronS_1 = (numel(files_1));
% cool_RFs_1=BlockS_12; 
% dim_1=length(cool_RFs_1);
% 
% [m,n]=size(RFo_1);
% [j,k]=size(RFo_1{1});
% margin=0.5;
% 
% labels_1={cool_RFs_1};
% DayOfRec = '29/5/2013';
% Session = 4;
% 
% clear RFo
% clear fitresulto
% clear SPIKE
% 
% cd ..
% 
% cd ..
% 
% cd ..
% 
% 
% 
% cd Block-3
% load SPIKE
% ChannelS_2 = SPIKES.channel;
% 
% cd RFs
% 
% load ('RFo.mat')
% RFo_2=RFo;
% fitresulto_2=fitresulto;
% files_2 = dir(fullfile('*.fig'));
% neuronS_2 = (numel(files_2));
% cool_RFs_2=Block_3; 
% dim_2=length(cool_RFs_2);
% 
% labels_2={cool_RFs_2};
% 
% clear RFo
% clear fitresulto
% clear SPIKE
% 
% cd ..
% 
% cd ..
% 
% 
% cd BlockS-45
% load SPIKE
% ChannelS_3 = SPIKES.channel;
% 
% cd BL_1/RFs
% 
% load ('RFo.mat')
% RFo_3=RFo;
% fitresulto_3=fitresulto;
% files_3 = dir(fullfile('*.fig'));
% neuronS_3 = (numel(files_3));
% cool_RFs_3=BlockS_45; 
% dim_3=length(cool_RFs_3);
% 
% labels_3={cool_RFs_3};
% 
% clear RFo
% clear fitresulto
% clear SPIKE
% 
% cd ..
% 
% cd ..
% 
% cd ..
% 
% 
% 
% cd Block-6
% load SPIKE
% ChannelS_4 = SPIKES.channel;
% 
% cd RFs
% 
% load ('RFo.mat')
% RFo_4=RFo;
% fitresulto_4=fitresulto;
% files_4 = dir(fullfile('*.fig'));
% neuronS_4 = (numel(files_4));
% cool_RFs_4=Block_6; 
% dim_4=length(cool_RFs_4);
% 
% labels_4={cool_RFs_4};
% 
% clear RFo
% clear fitresulto
% clear SPIKE
% 
% cd ..
% 
% cd ..
% 
% 
% 
% 
% 
% 
% cd BlockS-78
% load SPIKE
% ChannelS_5 = SPIKES.channel;
% 
% cd BL_1/RFs
% 
% load ('RFo.mat')
% RFo_5=RFo;
% fitresulto_5=fitresulto;
% files_5 = dir(fullfile('*.fig'));
% neuronS_5 = (numel(files_5));
% cool_RFs_5=BlockS_78; 
% dim_5=length(cool_RFs_5);
% 
% labels_5={cool_RFs_5};
% 
% clear RFo
% clear fitresulto
% clear SPIKE
% 
% cd ..
% 
% cd ..
% 
% cd ..
% 
% 
% mkdir ('RFTrack');
% 
% 
% dimS = [dim_1, dim_2, dim_3, dim_4, dim_5];
% all_chanS.RFs = {ChannelS_1, ChannelS_2, ChannelS_3, ChannelS_4, ChannelS_5};
% all_fits.RFs = {fitresulto_1, fitresulto_2, fitresulto_3, fitresulto_4, fitresulto_5};
% all_RFoS.RFs = {RFo_1, RFo_2, RFo_3, RFo_4, RFo_5};
% cool_RFsS.RFs = {cool_RFs_1, cool_RFs_2, cool_RFs_3, cool_RFs_4, cool_RFs_5};
% all_labelS.RFs = {labels_1, labels_2, labels_3, labels_4, labels_5};
% 
% 
% 
%% 31_5_2013
% 
% cd /zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_31_5_2013/ANALYSED/
% 
% cd BlockS-12
% load SPIKE
% ChannelS_1 = SPIKES.channel;
% 
% cd BL_1/RFs
% 
% load ('RFo.mat')
% RFo_1=RFo;
% fitresulto_1=fitresulto;
% files_1 = dir(fullfile('*.fig'));
% neuronS_1 = (numel(files_1));
% cool_RFs_1=BlockS_12; 
% dim_1=length(cool_RFs_1);
% 
% [m,n]=size(RFo_1);
% [j,k]=size(RFo_1{1});
% margin=0.5;
% 
% labels_1={cool_RFs_1};
% DayOfRec = '31/5/2013';
% Session = 5;
% 
% clear RFo
% clear fitresulto
% clear SPIKE
% 
% cd ..
% 
% cd ..
% 
% cd ..
% 
% 
% cd Block-3
% load SPIKE
% ChannelS_2 = SPIKES.channel;
% 
% cd RFs
% 
% load ('RFo.mat')
% RFo_2=RFo;
% fitresulto_2=fitresulto;
% files_2 = dir(fullfile('*.fig'));
% neuronS_2 = (numel(files_2));
% cool_RFs_2=Block_3; 
% dim_2=length(cool_RFs_2);
% 
% labels_2={cool_RFs_2};
% 
% clear RFo
% clear fitresulto
% clear SPIKE
% 
% cd ..
% 
% cd ..
% 
% 
% 
% cd Block-4
% load SPIKE
% ChannelS_3 = SPIKES.channel;
% 
% cd RFs
% 
% load ('RFo.mat')
% RFo_3=RFo;
% fitresulto_3=fitresulto;
% files_3 = dir(fullfile('*.fig'));
% neuronS_3 = (numel(files_3));
% cool_RFs_3=Block_4; 
% dim_3=length(cool_RFs_3);
% 
% labels_3={cool_RFs_3};
% 
% clear RFo
% clear fitresulto
% clear SPIKE
% 
% cd ..
% 
% cd ..
% 
% 
% 
% cd Block-5
% load SPIKE
% ChannelS_4 = SPIKES.channel;
% 
% cd RFs
% 
% load ('RFo.mat')
% RFo_4=RFo;
% fitresulto_4=fitresulto;
% files_4 = dir(fullfile('*.fig'));
% neuronS_4 = (numel(files_4));
% cool_RFs_4=Block_5; 
% dim_4=length(cool_RFs_4);
% 
% labels_4={cool_RFs_4};
% 
% clear RFo
% clear fitresulto
% clear SPIKE
% 
% cd ..
% 
% cd ..
% 
% 
% 
% 
% cd BlockS-67
% load SPIKE
% ChannelS_5 = SPIKES.channel;
% 
% cd BL_1/RFs
% 
% load ('RFo.mat')
% RFo_5=RFo;
% fitresulto_5=fitresulto;
% files_5 = dir(fullfile('*.fig'));
% neuronS_5 = (numel(files_5));
% cool_RFs_5=BlockS_67; 
% dim_5=length(cool_RFs_5);
% 
% labels_5={cool_RFs_5};
% 
% clear RFo
% clear fitresulto
% clear SPIKE
% 
% cd ..
% 
% cd ..
% 
% cd ..
% 
% 
% mkdir ('RFTrack');
% 
% 
% dimS = [dim_1, dim_2, dim_3, dim_4, dim_5];
% 
% all_fits.RFs = {fitresulto_1, fitresulto_2, fitresulto_3, fitresulto_4, fitresulto_5};
% all_chanS.RFs = {ChannelS_1, ChannelS_2, ChannelS_3, ChannelS_4, ChannelS_5};
% all_RFoS.RFs = {RFo_1, RFo_2, RFo_3, RFo_4, RFo_5};
% cool_RFsS.RFs = {cool_RFs_1, cool_RFs_2, cool_RFs_3, cool_RFs_4, cool_RFs_5};
% all_labelS.RFs = {labels_1, labels_2, labels_3, labels_4, labels_5};
% 


% % 7_6_2013
% 
% cd /zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_7_6_2013/ANALYSED/
% 
% cd Block-1
% load SPIKE
% ChannelS_1 = SPIKES.channel;
% 
% cd RFs
% 
% load ('RFo.mat')
% RFo_1=RFo;
% fitresulto_1=fitresulto;
% files_1 = dir(fullfile('*.fig'));
% neuronS_1 = (numel(files_1));
% cool_RFs_1=Block_1; 
% dim_1=length(cool_RFs_1);
% 
% [m,n]=size(RFo_1);
% [j,k]=size(RFo_1{1});
% margin=0.5;
% 
% labels_1={cool_RFs_1};
% DayOfRec = '7/6/2013';
% Session = 6;
% 
% clear RFo
% clear fitresulto
% clear SPIKE
% 
% cd ..
% 
% cd ..
% 
% 
% 
% cd BlockS-23
% load SPIKE
% ChannelS_2 = SPIKES.channel;
% 
% cd BL_1/RFs
% 
% load ('RFo.mat')
% RFo_2=RFo;
% fitresulto_2=fitresulto;
% files_2 = dir(fullfile('*.fig'));
% neuronS_2 = (numel(files_2));
% cool_RFs_2=BlockS_23; 
% dim_2=length(cool_RFs_2);
% 
% 
% labels_2={cool_RFs_2};
% 
% 
% clear RFo
% clear fitresulto
% clear SPIKE
% 
% cd ..
% 
% cd ..
% 
% cd ..
% 
% 
% cd Block-4
% load SPIKE
% ChannelS_3 = SPIKES.channel;
% 
% cd RFs
% 
% load ('RFo.mat')
% RFo_3=RFo;
% fitresulto_3=fitresulto;
% files_3 = dir(fullfile('*.fig'));
% neuronS_3 = (numel(files_3));
% cool_RFs_3=Block_4; 
% dim_3=length(cool_RFs_3);
% 
% labels_3={cool_RFs_3};
% 
% clear RFo
% clear fitresulto
% clear SPIKE
% 
% cd ..
% 
% cd ..
% 
% 
% 
% cd Block-5
% load SPIKE
% ChannelS_4 = SPIKES.channel;
% 
% cd RFs
% 
% load ('RFo.mat')
% RFo_4=RFo;
% fitresulto_4=fitresulto;
% files_4 = dir(fullfile('*.fig'));
% neuronS_4 = (numel(files_4));
% cool_RFs_4=Block_5; 
% dim_4=length(cool_RFs_4);
% 
% labels_4={cool_RFs_4};
% 
% clear RFo
% clear fitresulto
% clear SPIKE
% 
% cd ..
% 
% cd ..
% 
% 
% cd Block-6
% load SPIKE
% ChannelS_5 = SPIKES.channel;
% 
% 
% cd RFs
% 
% load ('RFo.mat')
% RFo_5=RFo;
% fitresulto_5=fitresulto;
% files_5 = dir(fullfile('*.fig'));
% neuronS_5 = (numel(files_5));
% cool_RFs_5=Block_6; 
% dim_5=length(cool_RFs_5);
% 
% labels_5={cool_RFs_5};
% 
% clear RFo
% clear fitresulto
% clear SPIKE
% 
% cd ..
% 
% cd ..
% 
% 
% cd BlockS-78
% load SPIKE
% ChannelS_6 = SPIKES.channel;
% 
% cd BL_1/RFs
% 
% load ('RFo.mat')
% RFo_6=RFo;
% fitresulto_6=fitresulto;
% files_6 = dir(fullfile('*.fig'));
% neuronS_6 = (numel(files_6));
% cool_RFs_6=BlockS_78; 
% dim_6=length(cool_RFs_6);
% 
% labels_6={cool_RFs_6};
% 
% clear RFo
% clear fitresulto
% clear SPIKE
% 
% cd ..
% 
% cd ..
% 
% cd ..
% 
% 
% 
% cd BlockS-910
% load SPIKE
% ChannelS_7 = SPIKES.channel;
% 
% cd BL_1/RFs
% 
% load ('RFo.mat')
% RFo_7=RFo;
% fitresulto_7=fitresulto;
% files_7 = dir(fullfile('*.fig'));
% neuronS_7 = (numel(files_7));
% cool_RFs_7=BlockS_910; 
% dim_7=length(cool_RFs_7);
% 
% labels_7={cool_RFs_7};
% 
% clear RFo
% clear fitresulto
% clear SPIKE
% 
% cd ..
% 
% cd ..
% 
% cd ..
% 
% 
% mkdir ('RFTrack');
% 
% 
% dimS = [dim_1, dim_2, dim_3, dim_4, dim_5, dim_6, dim_7];
% all_chanS.RFs = {ChannelS_1, ChannelS_2, ChannelS_3, ChannelS_4, ChannelS_5, ChannelS_6, ChannelS_7};
% all_fits.RFs = {fitresulto_1, fitresulto_2, fitresulto_3, fitresulto_4, fitresulto_5, fitresulto_6, fitresulto_7};
% all_RFoS.RFs = {RFo_1, RFo_2, RFo_3, RFo_4, RFo_5, RFo_6, RFo_7};
% cool_RFsS.RFs = {cool_RFs_1, cool_RFs_2, cool_RFs_3, cool_RFs_4, cool_RFs_5, cool_RFs_6, cool_RFs_7};
% all_labelS.RFs = {labels_1, labels_2, labels_3, labels_4, labels_5, labels_6, labels_7};
% 
% 
% % %% 12_6_2013
% cd /zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_12_6_2013/ANALYSED/
% 
% cd BlockS-12
% load SPIKE
% ChannelS_1 = SPIKES.channel;
% cd BL_1/RFs
% 
% load ('RFo.mat')
% RFo_1=RFo;
% fitresulto_1=fitresulto;
% files_1 = dir(fullfile('*.fig'));
% neuronS_1 = (numel(files_1));
% cool_RFs_1=BlockS_12; 
% dim_1=length(cool_RFs_1);
% 
% [m,n]=size(RFo_1);
% [j,k]=size(RFo_1{1});
% margin=0.5;
% 
% labels_1={cool_RFs_1};
% DayOfRec = '12/6/2013';
% Session = 7;
% 
% clear RFo
% clear fitresulto
% clear SPIKE
% 
% cd ..
% 
% cd ..
% 
% cd ..
% 
% 
% 
% cd Block-3
% load SPIKE
% ChannelS_2 = SPIKES.channel;
% cd RFs
% 
% load ('RFo.mat')
% RFo_2=RFo;
% fitresulto_2=fitresulto;
% files_2 = dir(fullfile('*.fig'));
% neuronS_2 = (numel(files_2));
% cool_RFs_2=Block_3; 
% dim_2=length(cool_RFs_2);
% 
% labels_2={cool_RFs_2};
% 
% clear RFo
% clear fitresulto
% clear SPIKE
% 
% cd ..
% 
% cd ..
% 
% 
% cd BlockS-45
% load SPIKE
% ChannelS_3 = SPIKES.channel;
% cd BL_1/RFs
% 
% load ('RFo.mat')
% RFo_3=RFo;
% fitresulto_3=fitresulto;
% files_3 = dir(fullfile('*.fig'));
% neuronS_3 = (numel(files_3));
% cool_RFs_3=BlockS_45; 
% dim_3=length(cool_RFs_3);
% 
% labels_3={cool_RFs_3};
% 
% clear RFo
% clear fitresulto
% clear SPIKE
% 
% cd ..
% 
% cd ..
% 
% cd ..
% 
% 
% 
% cd Block-6
% load SPIKE
% ChannelS_4 = SPIKES.channel;
% cd RFs
% 
% load ('RFo.mat')
% RFo_4=RFo;
% fitresulto_4=fitresulto;
% files_4 = dir(fullfile('*.fig'));
% neuronS_4 = (numel(files_4));
% cool_RFs_4=Block_6; 
% dim_4=length(cool_RFs_4);
% 
% labels_4={cool_RFs_4};
% 
% clear RFo
% clear fitresulto
% clear SPIKE
% 
% cd ..
% 
% cd ..
% 
% 
% 
% 
% 
% 
% cd BlockS-78
% load SPIKE
% ChannelS_5 = SPIKES.channel;
% cd BL_1/RFs
% 
% load ('RFo.mat')
% RFo_5=RFo;
% fitresulto_5=fitresulto;
% files_5 = dir(fullfile('*.fig'));
% neuronS_5 = (numel(files_5));
% cool_RFs_5=BlockS_78; 
% dim_5=length(cool_RFs_5);
% 
% labels_5={cool_RFs_5};
% 
% clear RFo
% clear fitresulto
% clear SPIKE
% 
% cd ..
% 
% cd ..
% 
% cd ..
% 
% 
% mkdir ('RFTrack');
% 
% all_chanS.RFs = {ChannelS_1, ChannelS_2, ChannelS_3, ChannelS_4, ChannelS_5};
% dimS = [dim_1, dim_2, dim_3, dim_4, dim_5];
% all_fits.RFs = {fitresulto_1, fitresulto_2, fitresulto_3, fitresulto_4, fitresulto_5};
% all_RFoS.RFs = {RFo_1, RFo_2, RFo_3, RFo_4, RFo_5};
% cool_RFsS.RFs = {cool_RFs_1, cool_RFs_2, cool_RFs_3, cool_RFs_4, cool_RFs_5};
% all_labelS.RFs = {labels_1, labels_2, labels_3, labels_4, labels_5};




% %% 18_6_2013
% cd /zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_18_6_2013/ANALYSED/
% 
% cd BlockS-12
% load SPIKE
% ChannelS_1 = SPIKES.channel;
% cd BL_1/RFs
% 
% load ('RFo.mat')
% RFo_1=RFo;
% fitresulto_1=fitresulto;
% files_1 = dir(fullfile('*.fig'));
% neuronS_1 = (numel(files_1));
% cool_RFs_1=BlockS_12; 
% dim_1=length(cool_RFs_1);
% 
% [m,n]=size(RFo_1);
% [j,k]=size(RFo_1{1});
% margin=0.5;
% 
% labels_1={cool_RFs_1};
% DayOfRec = '18/6/2013';
% Session = 8;
% 
% clear RFo
% clear fitresulto
% clear SPIKE
% 
% cd ..
% 
% cd ..
% 
% cd ..
% 
% 
% 
% cd Block-3
% load SPIKE
% ChannelS_2 = SPIKES.channel;
% 
% cd RFs
% 
% load ('RFo.mat')
% RFo_2=RFo;
% fitresulto_2=fitresulto;
% files_2 = dir(fullfile('*.fig'));
% neuronS_2 = (numel(files_2));
% cool_RFs_2=Block_3; 
% dim_2=length(cool_RFs_2);
% 
% labels_2={cool_RFs_2};
% 
% clear RFo
% clear fitresulto
% clear SPIKE
% 
% cd ..
% 
% cd ..
% 
% 
% cd BlockS-45
% load SPIKE
% ChannelS_3 = SPIKES.channel;
% 
% cd BL_1/RFs
% 
% load ('RFo.mat')
% RFo_3=RFo;
% fitresulto_3=fitresulto;
% files_3 = dir(fullfile('*.fig'));
% neuronS_3 = (numel(files_3));
% cool_RFs_3=BlockS_45; 
% dim_3=length(cool_RFs_3);
% 
% labels_3={cool_RFs_3};
% 
% clear RFo
% clear fitresulto
% clear SPIKE
% cd ..
% 
% cd ..
% 
% cd ..
% 
% 
% 
% cd Block-6
% load SPIKE
% ChannelS_4 = SPIKES.channel;
% cd RFs
% 
% load ('RFo.mat')
% RFo_4=RFo;
% fitresulto_4=fitresulto;
% files_4 = dir(fullfile('*.fig'));
% neuronS_4 = (numel(files_4));
% cool_RFs_4=Block_6; 
% dim_4=length(cool_RFs_4);
% 
% labels_4={cool_RFs_4};
% 
% clear RFo
% clear fitresulto
% clear SPIKE
% cd ..
% 
% cd ..
% 
% 
% 
% 
% 
% 
% cd BlockS-78
% load SPIKE
% ChannelS_5 = SPIKES.channel;
% 
% cd BL_1/RFs
% 
% load ('RFo.mat')
% RFo_5=RFo;
% fitresulto_5=fitresulto;
% files_5 = dir(fullfile('*.fig'));
% neuronS_5 = (numel(files_5));
% cool_RFs_5=BlockS_78; 
% dim_5=length(cool_RFs_5);
% 
% labels_5={cool_RFs_5};
% 
% clear RFo
% clear fitresulto
% clear SPIKE
% cd ..
% 
% cd ..
% 
% cd ..
% 
% 
% mkdir ('RFTrack');
% 
% all_chanS.RFs = {ChannelS_1, ChannelS_2, ChannelS_3, ChannelS_4, ChannelS_5};
% dimS = [dim_1, dim_2, dim_3, dim_4, dim_5];
% all_fits.RFs = {fitresulto_1, fitresulto_2, fitresulto_3, fitresulto_4, fitresulto_5};
% all_RFoS.RFs = {RFo_1, RFo_2, RFo_3, RFo_4, RFo_5};
% cool_RFsS.RFs = {cool_RFs_1, cool_RFs_2, cool_RFs_3, cool_RFs_4, cool_RFs_5};
% all_labelS.RFs = {labels_1, labels_2, labels_3, labels_4, labels_5};



COLORSET=varycolor(numel(dimS));  % number of blocks

       
cd RFTrack

for z = 1:numel(dimS) %number of blocks
    
    dim = dimS(z);
    RFo = all_RFoS.RFs{1,(z)};
    chan = all_chanS.RFs{1, (z)};
    fitresulto = all_fits.RFs{1,(z)};
    cool_RFs = cool_RFsS.RFs{1,(z)};
    label = all_labelS.RFs{1,(z)};
    labell = label{1};
    
    all_x = [];
    all_y = [];
    rfs=0;
    
    for i=1:dim    
        rfs = rfs+1;
        Ch=GetChannel(cool_RFs(i), chan);   %(rfs,chan);
        my_label{i} = Ch;
%         my_label{i} = Ch(i);
        tmpRF_x=fitresulto{cool_RFs(i)}.x0;
        tmpRF_y=fitresulto{cool_RFs(i)}.y0;
        

          all_x = [all_x, tmpRF_x];
          all_y = [all_y, tmpRF_y];
        
        
    end
        figure(z)
        plot (all_x, all_y, '-o', 'Color', COLORSET(z,:));
        set (gca, 'ylim', [-1 9], 'xlim', [-1 13]);
        figure (gcf);
        text(all_x, all_y, my_label);
        title([char(DayOfRec), ', Block ', num2str(z)]);
%         hold on;
        clear all_x all_y my_label
 
        saveas(gcf,[num2str(z), '.fig']);
        saveas(gcf,[num2str(z), '.png']);
    
end;

close all
clear all



