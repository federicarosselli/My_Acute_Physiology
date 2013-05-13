function My_Data_Structure_MultipleBlocks_ONEBLOCK(DayOfRecording, Block, SubBlock)

w=cd;
BLOCKS=Block; %67
SUBB=SubBlock; %2
bin=25/1000;
%bin=50/1000;

POST_TIME=2200/1000; 
PRE_TIME=200/1000;

% DayOfRecording = '18_3_2013';
AreaOfRecording = 'V1';

shift_bin=10/1000;

FOLDER_FROM12=['/zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_', char(DayOfRecording), '/ANALYSED'];


    
load([FOLDER_FROM12,'/BlockS-',num2str(BLOCKS),'/SPIKE.mat'])

FOLDER_FROM=FOLDER_FROM12;

mkdir([FOLDER_FROM,'/BlockS-',num2str(BLOCKS),'/BL_',num2str(SUBB),'/My_Structure/', num2str(bin*1000)])


cd(FOLDER_FROM)
TSTART=0; %sec


num_bin=floor((POST_TIME+PRE_TIME-bin)/shift_bin);

% %%% for case 1
% BCODE1=BCODE(TBCOD<=TB_1_end);
% TBCOD1=TBCOD(TBCOD<=TB_1_end);
% 
% BITCODE=BCODE1(TBCOD1>TSTART);
% TBC=TBCOD1(TBCOD1>TSTART);

%%% for case 2
BCODE2=BCODE(TBCOD>TB_1_end);
TBCOD2=TBCOD(TBCOD>TB_1_end)-TB_1_end;

BITCODE=BCODE2(TBCOD2>TSTART);
TBC=TBCOD2(TBCOD2>TSTART);

ind_start=find(diff(BITCODE)>=1);
STIM_START=TBC(ind_start);
BIT_START=BITCODE(ind_start+1);

ind_stop=find(diff(BITCODE)<=-1);
STIM_STOP=TBC(ind_stop);
BIT_STOP=BITCODE(ind_stop);


if unique(BIT_START-BIT_STOP)~=0
    error('check the BIT conversion')
end

% hist(BIT_START, 270)

clear BITCODE TBC BCODE TBCOD

NeuronS = 1:size(SPIKES.channel,2);
BitCodeS = unique(sort(BIT_START));
ChannelS = SPIKES.channel;

Trial_num=cell(zeros()); 
My_Spikes=cell(zeros());
PSTH=cell(zeros());

tic

neurons=0 ;
for nn=NeuronS     %% note: in session 10_4_2013 problems with neuron num 12?
    
    
    neurons = neurons+1;
    Shape = SPIKES.shape(nn);
    Channel=GetChannel(neurons,ChannelS);
        
    First_Spike = min(SPIKES.spikes{nn});
    Last_Spike = max(SPIKES.spikes{nn});
    
%     %%%% for case 1
%     All_Spikes = SPIKES.spikes{nn}(SPIKES.spikes{nn}>=Block_1_ST & SPIKES.spikes{nn}<=Block_1_EN);
%     n_spikes=[1:length(All_Spikes)-1,1]-1;  
%     Mean_Firing_Rate = regress(All_Spikes,n_spikes');
%         
    %%%% for case 2
    All_Spikes=SPIKES.spikes{nn}((SPIKES.spikes{nn})>=Block_1_EN)-Block_1_EN;
    n_spikes=[1:length(All_Spikes)-1,1]-1;  
    Mean_Firing_Rate = regress(All_Spikes,n_spikes');

    
    for i=BitCodeS

        
        [TT First_Trial] = min(abs(First_Spike-STIM_START));
        [TT Last_Trial] = min(abs(Last_Spike-STIM_STOP));
        
        All_Trial_TimeS = STIM_START(BIT_START==i); %% all times at which stim i was presented
        All_Trial_NumberS=find(BIT_START==i);
        
        tt0=0;
        Trial_num{i,neurons}=[];
        
        
        for tt=1:numel(All_Trial_TimeS)
            T_num=0;
            
                if (All_Trial_NumberS(tt)>=First_Trial & All_Trial_NumberS(tt)<=Last_Trial)
                tt0=tt0+1;
                Trial_num{i,neurons}(tt0)=All_Trial_NumberS(tt);   %%trials per bitcode          
                end
            
            T_num=All_Trial_NumberS(tt);
            
           
            TIME_START=All_Trial_TimeS(tt)-PRE_TIME;
            TIME_END=All_Trial_TimeS(tt)+POST_TIME;

            SPIKES_TAKEN=All_Spikes(All_Spikes<TIME_END & All_Spikes>TIME_START)-TIME_START;
            
            if (All_Trial_NumberS(tt)>=First_Trial & All_Trial_NumberS(tt)<=Last_Trial)
            My_Spikes{i,tt0}=SPIKES_TAKEN;  %% spikes per trial (RASTER)

                for b=1:num_bin+1
                    PSTH{i,neurons}(T_num,b)=sum(SPIKES_TAKEN>shift_bin*(b-1) & SPIKES_TAKEN<(shift_bin*(b-1)+bin));  
                end
            
            end
            
        end
        
    disp([num2str(neurons),'/', num2str(max(NeuronS)),' , ',num2str(i),'/',num2str(max(BIT_START))])    

    My_Neurons=struct('Day', {DayOfRecording}, 'Area',{AreaOfRecording}, 'NeuronNumber',{nn},'Channel', {Channel}, 'Shape', {Shape}, 'AllSpikes', {All_Spikes}, 'FirstTrial', {First_Trial}, 'LastTrial', {Last_Trial}, 'MeanFiringRate', {Mean_Firing_Rate});
    PsthAndRaster=struct('Trials',{Trial_num}, 'MySpikes', {My_Spikes},'Psth', {PSTH}, 'BinSize', {bin}, 'BinShift', {shift_bin},'TrialsPerBitcode', {tt}, 'BitCodes', {max(BitCodeS)});
    
    end

    
    w=cd;
    save([w,'/BlockS-',num2str(BLOCKS),'/BL_', num2str(SUBB),'/My_Structure/', num2str(bin*1000), '/NEURON_', num2str(neurons), '.mat'],'My_Neurons', '-v7.3')
    save([w,'/BlockS-',num2str(BLOCKS),'/BL_',num2str(SUBB),'/My_Structure/', num2str(bin*1000), '/PSTH_RASTER_', num2str(neurons), '.mat'],'PsthAndRaster','STIM_START','STIM_STOP', 'PRE_TIME', 'POST_TIME', '-v7.3')

    clear NEURON PSTH_RASTER My_Neurons PsthAndRaster Channel First_Spike Last_Spike TT tt tt0 First_Trial Last_Trial All_Trial_TimeS All_Trial_NumberS All_Spikes Trial_num T_num TIME_START TIME_END SPIKES_TAKEN My_Spikes PSTH Shape Mean_Firing_Rate
 
end



end


