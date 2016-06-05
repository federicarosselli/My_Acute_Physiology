function My_Data_Structure_MultipleBlocks_TEST_NUBIN_NUFREQ (DayOfRecording, Block)


%% IMPORTANT NOTE: FOR MEMORY REASONS, THE CODE AS IT IS WRITTEN COMPUTES
%% PSTH STRUCTURES ONLY FOR FAST GRATINGS CONDITIONS

w=cd;
BLOCKS= Block; %67
bin=1/1000;
shift_bin=1/1000;
% bin=25/1000;
%bin=50/1000;



% DayOfRecording = '18_3_2013';
AreaOfRecording = 'V1b' %'LM'; %AL %AM

% shift_bin=10/1000;

FOLDER_FROM12=['/zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_', char(DayOfRecording), '/ANALYSED'];

for BLOCK_PHASE=2 %1:2
    
load([FOLDER_FROM12,'/BlockS-',num2str(BLOCKS),'/SPIKE.mat'])


%% calculate a factor to correct the spike times according to the correct samplin frequency

sf_incorr = 24000;
sf_corr = 24414.0625;
fsRatio = sf_incorr/sf_corr;



FOLDER_FROM=FOLDER_FROM12;
% 
% mkdir([FOLDER_FROM,'/BlockS-',num2str(BLOCKS),'/BL_',num2str(BLOCK_PHASE)])
%     
% mkdir([FOLDER_FROM,'/BlockS-',num2str(BLOCKS),'/BL_',num2str(BLOCK_PHASE),'/My_Structure/TEST'])

mkdir([FOLDER_FROM,'/BlockS-',num2str(BLOCKS),'/BL_',num2str(BLOCK_PHASE),'/My_Structure/', num2str(bin*1000)])


cd(FOLDER_FROM)
TSTART=0; %sec


switch BLOCK_PHASE
    case 1
POST_TIME=500/1000; 
PRE_TIME=250/1000;
num_bin=floor((POST_TIME+PRE_TIME-bin)/shift_bin);

BCODE=BCODE(TBCOD<=TB_1_end);
TBCOD=TBCOD(TBCOD<=TB_1_end);

BITCODE=BCODE(TBCOD>TSTART);
TBC=TBCOD(TBCOD>TSTART);

ind_start=find(diff(BITCODE)>=1);
STIM_START=TBC(ind_start);
BIT_START=BITCODE(ind_start+1);

ind_stop=find(diff(BITCODE)<=-1);
STIM_STOP=TBC(ind_stop);
BIT_STOP=BITCODE(ind_stop);

    case 2
        

% POST_TIME=2200/1000; 
% PRE_TIME=200/1000;
POST_TIME_slow=2200/1000; 
POST_TIME_static=450/1000; 
POST_TIME_fast=1000/1000; 
PRE_TIME=200/1000;
num_bin_static=floor((POST_TIME_static+PRE_TIME-bin)/shift_bin);
num_bin_fast=floor((POST_TIME_fast+PRE_TIME-bin)/shift_bin);
num_bin_slow=floor((POST_TIME_slow+PRE_TIME-bin)/shift_bin);
% num_bin=floor((POST_TIME+PRE_TIME-bin)/shift_bin);

BCODE=BCODE(TBCOD>T_END);
TBCOD=TBCOD(TBCOD>T_END);


BITCODE=BCODE(TBCOD>TSTART);
TBC=TBCOD(TBCOD>TSTART);

ind_start=find(diff(BITCODE)>=1);
STIM_START=TBC(ind_start);
BIT_START=BITCODE(ind_start+1);

ind_stop=find(diff(BITCODE)<=-1);
STIM_STOP=TBC(ind_stop);
BIT_STOP=BITCODE(ind_stop);

end


%%% note: for session 7_6_2013, blockS 910, the bitcode in position 1959 of
%%% BIT_STOP was misaligned:

% BIT_STOP(BIT_STOP(1, 1959))=[];



if unique(BIT_START-BIT_STOP)~=0
    error('check the BIT conversion')
end

% hist(BIT_START, 270)

clear B1 B2 T1 T2 TBC BCODE TBCOD

NeuronS = 1:size(SPIKES.channel,2);
BitCodeS = unique(sort(BIT_START));
ChannelS = SPIKES.channel;

Trial_num=cell(zeros()); 
My_Spikes=cell(zeros());
PSTH=cell(zeros());

Bcodes_static = [1, 4, 7:166];
Bcodes_slow = [2, 5, 167, 169, 171, 173, 175, 177, 179, 181, 183, 185, 187, 189, 191, 193, 195, 197, 199, 201, 203, 205, ...
    207, 209, 211, 213, 215, 217, 219, 221, 223, 225, 227, 229, 231:238, 247, 249, 251, 253, 255, 257, 259, 261, ...
    263, 265, 267, 269, 271, 273, 275, 277, 279, 281, 283, 285, 287, 289, 291, 293, 295, 297, 299, 301, 303, 305, 307, 309, ...
    311, 313, 315, 317, 319, 321, 323, 325, 327, 329, 331, 333, 335, 337, 339, 341];
Bcodes_fast = [3, 6, 168, 170, 172, 174, 176, 178, 180, 182, 184, 186, 188, 190, 192, 194, 196, 198, 200, 202, 204, 206, ...
    208, 210, 212, 214, 216, 218, 220, 222, 224, 226, 228, 230, 239:246, 248, 250, 252, 254, 256, 258, 260, 262, ...
    264, 266, 268, 270, 272, 274, 276, 278, 280, 282, 284, 286, 288, 290, 292, 294, 296, 298, 300, 302, 304, 306, 308, 310, ...
    312, 314, 316, 318, 320, 322, 324, 326, 328, 330, 332, 334, 336, 338, 340, 342];
Bcodes_fast_gr = [168, 170, 172, 174, 176, 178, 180, 182, 184, 186, 188, 190, 192, 194, 196, 198, 200, 202, 204, 206, ...
    208, 210, 212, 214, 216, 218, 220, 222, 224, 226, 228, 230];


tic

neurons=0 ;
for nn=NeuronS     
    
    
    neurons = neurons+1;
    Shape = SPIKES.shape(nn);
    Channel=GetChannel(neurons,ChannelS);
    SPIKES.spikes{nn} = SPIKES.spikes{nn}*fsRatio;
        
%     First_Spike = min(SPIKES.spikes{nn});
%     Last_Spike = max(SPIKES.spikes{nn});
        
    switch BLOCK_PHASE
        case 1
    First_Spike = min(SPIKES.spikes{nn});
    Last_Spike = max(SPIKES.spikes{nn}); 
    All_Spikes = SPIKES.spikes{nn}(SPIKES.spikes{nn}>=Block_1_ST & SPIKES.spikes{nn}<=Block_1_EN);  %TB_1_start & SPIKES.spikes{nn}<=TB_1_end);        %Block_1_ST & SPIKES.spikes{nn}<=Block_1_EN);
    n_spikes=[1:length(All_Spikes)-1,1]-1;  
    Mean_Firing_Rate = regress(All_Spikes,n_spikes');
        case 2
    First_Spike = min(SPIKES.spikes{nn});
    Last_Spike = max(SPIKES.spikes{nn});
    All_Spikes=SPIKES.spikes{nn}(SPIKES.spikes{nn}>=Block_1_EN & SPIKES.spikes{nn}<=Block_2_EN);
%     All_Spikes=SPIKES.spikes{nn}(SPIKES.spikes{nn}>max([TIMES_en]) & SPIKES.spikes{nn}<=Block_2_EN);        %Block_2_ST & SPIKES.spikes{nn}<=Block_2_EN);       %Block_1_EN)-Block_1_EN;
    n_spikes=[1:length(All_Spikes)-1,1]-1;  
    Mean_Firing_Rate = regress(All_Spikes,n_spikes');
    end

    
    for i=Bcodes_fast_gr

        if ismember(i, Bcodes_static)
            POST_TIME = POST_TIME_static;
            num_bin = num_bin_static;
        elseif ismember(i, Bcodes_slow)
            POST_TIME = POST_TIME_slow;
            num_bin = num_bin_slow;
        else
            POST_TIME = POST_TIME_fast;
            num_bin = num_bin_fast;
        end
            
        [TT First_Trial] = min(abs(First_Spike-STIM_START));
        [TT Last_Trial] = min(abs(Last_Spike-STIM_STOP));
        
        All_Trial_TimeS = STIM_START(BIT_START==i); %% all times at which stim i was presented
        All_Trial_NumberS=find(BIT_START==i);
        
        tt0=0;
        Trial_num{i,neurons}=[];
        T_num=0;
        
        
        for tt=1:numel(All_Trial_TimeS)
%             T_num=0;
            
                if (All_Trial_NumberS(tt)>=First_Trial & All_Trial_NumberS(tt)<=Last_Trial)
                tt0=tt0+1;
                Trial_num{i,neurons}(tt0)=All_Trial_NumberS(tt);   %%trials per bitcode          
                end
            
%             T_num=All_Trial_NumberS(tt);
            
           
            TIME_START=All_Trial_TimeS(tt)-PRE_TIME;
            TIME_END=All_Trial_TimeS(tt)+POST_TIME;

            SPIKES_TAKEN=All_Spikes(All_Spikes<TIME_END & All_Spikes>TIME_START)-TIME_START;
            
            if (All_Trial_NumberS(tt)>=First_Trial & All_Trial_NumberS(tt)<=Last_Trial)
            My_Spikes{i,tt0}=SPIKES_TAKEN;  %% spikes per trial (RASTER)
            T_num=T_num+1;

                for b=1:num_bin+1
                    PSTH{i,neurons}(T_num,b)=sum(SPIKES_TAKEN>shift_bin*(b-1) & SPIKES_TAKEN<(shift_bin*(b-1)+bin));  
                end
            
            end
            
        end
        
    disp([num2str(neurons),'/', num2str(max(NeuronS)),' , ',num2str(i),'/',num2str(max(BIT_START))])    

%     PsthAndRaster=struct('Trials',{Trial_num}, 'MySpikes', {My_Spikes}, 'BinSize', {bin}, 'BinShift', {shift_bin},'TrialsPerBitcode', {tt}, 'BitCodes', {max(BitCodeS)});
    My_Neurons=struct('Day', {DayOfRecording}, 'Area',{AreaOfRecording}, 'NeuronNumber',{nn},'Channel', {Channel}, 'Shape', {Shape}, 'AllSpikes', {All_Spikes}, 'FirstTrial', {First_Trial}, 'LastTrial', {Last_Trial}, 'MeanFiringRate', {Mean_Firing_Rate});
    PsthAndRaster=struct('Trials',{Trial_num}, 'MySpikes', {My_Spikes},'Psth', {PSTH}, 'BinSize', {bin}, 'BinShift', {shift_bin},'TrialsPerBitcode', {tt}, 'BitCodes', {max(BitCodeS)});
    
    end

    
    w=cd;
    save([w,'/BlockS-',num2str(BLOCKS),'/BL_', num2str(BLOCK_PHASE),'/My_Structure/', num2str(bin*1000), '/NEURON_', num2str(neurons), '.mat'],'My_Neurons', '-v7.3')
    save([w,'/BlockS-',num2str(BLOCKS),'/BL_',num2str(BLOCK_PHASE),'/My_Structure/', num2str(bin*1000), '/PSTH_RASTER_', num2str(neurons), '.mat'],'PsthAndRaster','STIM_START','STIM_STOP', 'PRE_TIME', 'POST_TIME', '-v7.3')

    clear NEURON PSTH_RASTER My_Neurons PsthAndRaster Channel First_Spike Last_Spike TT tt tt0 First_Trial Last_Trial All_Trial_TimeS All_Trial_NumberS All_Spikes Trial_num T_num TIME_START TIME_END SPIKES_TAKEN My_Spikes PSTH Shape Mean_Firing_Rate
 
end



end

end
