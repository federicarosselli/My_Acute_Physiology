function My_Raster_NEW_PEAKSNTIMES (DayOfRecording, Block)

% DayOfRecording = '2_7_2013'
% 
% Block = 12

% object = 0 %(bblank)
% object = 9 %(wblank)
% object = -1 %(bar)
% object = 1 %(ent)
% object = 2 %(bun)
% object = 3 %(orca)
% object = 4 %(pingu)
% object = 111 %(0.03 grating)
% object = 222 %(0.05 grating)
% object = 333 %(0.1 grating)
% object = 444 %(0.4 grating)
% object = 11 (dots pattern 1)
% object = 22 (dots pattern 2)


my_folder = ['/zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_', char(DayOfRecording), '/ANALYSED/BlockS-', num2str(Block), '/BL_2/My_Structure/50'];
% my_folder = ['/zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_', , char(DayOfRecording), '/ANALYSED/Block-' , num2str(Block), '/My_Structure/25'];

addpath /zocconasphys1/chronic_inv_rec/codes/
load My_StimS_NUANGLE_NUCONDITIONS

% Cool_Psths
% neuronS = BlockS_67;   %%% >>>>>>> optimize!!!


cd (my_folder)
mkdir(['RASTERS/'])

files = dir(fullfile('*.mat'));
neuronS = (numel(files))/2;

COLORSET=varycolor(neuronS);
all_peaks = cell(zeros());
all_time_series = cell(zeros());
object = [-1, 0, 1, 2, 3, 4, 9, 11, 22, 111, 222, 333, 444];
% object = [-1, 0, 1, 2, 3, 4, 9, 11, 22, 111, 222, 333, 444];

for nn = 1:neuronS
    countolo=0;
        
    load(['PSTH_RASTER_', num2str(nn),'.mat'])
    load(['NEURON_', num2str(nn),'.mat'])
%     bitcodes = PsthAndRaster.BitCodes;
    bin=PsthAndRaster.BinSize; 
    
    ww = cd;
    

        for ob = object
        

        [a z]=ind2sub(size(Fede_STIM_NU), find(Fede_STIM_NU(1:342,2)==ob));
        selected_bits = a';
        
            for BIT_Number = selected_bits

            a = PsthAndRaster.Trials{BIT_Number,nn}(1);
            stim_pres_time = (STIM_STOP(a)-STIM_START(a))*1000;
            
            if stim_pres_time > 500 && stim_pres_time < 1000
            countolo=countolo+1;
%             figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                ps=PsthAndRaster.Psth{BIT_Number,nn};
                trr=PsthAndRaster.Trials{BIT_Number,nn};
                M=ps(trr,:);
                M_PSTH{BIT_Number,nn}=mean(M);
                S_PSTH{BIT_Number,nn}=std(M)/sqrt(size(M,1));
                T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
                [int tm]=min(abs(T-1000));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)


                    b = M_PSTH{BIT_Number,nn}*(1000/25);
                    Tlin = T(1:tm);
                    blin = b(1:tm);
                    maxb = max(blin);
                    all_peaks{BIT_Number, nn}=maxb;
                    all_time_series{BIT_Number, nn}=b;

                    aku = find(blin==maxb);

                    end


            
            end
            
                
            if stim_pres_time > 1000
            countolo=countolo+1;
%             figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                ps=PsthAndRaster.Psth{BIT_Number,nn};
                trr=PsthAndRaster.Trials{BIT_Number,nn};
                M=ps(trr,:);
                M_PSTH{BIT_Number,nn}=mean(M);
                S_PSTH{BIT_Number,nn}=std(M)/sqrt(size(M,1));
                T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
                
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)
                    

                    b = M_PSTH{BIT_Number,nn}*(1000/25);
                    maxb = max(b);
                    all_peaks{BIT_Number, nn}=maxb;
                    all_time_series{BIT_Number, nn}=b;

                    aku = find(b==maxb);


                    end

 

            
            end
            
            if stim_pres_time < 500
            countolo=countolo+1;

            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};
                
            ps=PsthAndRaster.Psth{BIT_Number,nn};
            trr=PsthAndRaster.Trials{BIT_Number,nn};
            M=ps(trr,:);
            M_PSTH{BIT_Number,nn}=mean(M);
            S_PSTH{BIT_Number,nn}=std(M)/sqrt(size(M,1));
            T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));             
            [int tm]=min(abs(T-450));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)

                    b = M_PSTH{BIT_Number,nn}*(1000/25);
                    Tlin = T(1:tm);
                    blin = b(1:tm);
                    maxb = max(blin);
                    all_peaks{BIT_Number, nn}=maxb;
                    all_time_series{BIT_Number, nn}=b;

                    aku = find(blin==maxb);


                    end

            
            end
            
            end
            
            

        end
        
       save([ww,'/RASTERS/PeaksnTimes.mat'], 'all_peaks', 'all_time_series', '-v7.3');
       clearvars -except all_peaks all_time_series Fede_STIM_NU files neuronS nn obj object
        
end
            