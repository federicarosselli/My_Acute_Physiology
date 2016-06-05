%% tests time hist for moving stimuli


clear all
close all
clc


cd /zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_10_4_2013/ANALYSED/BlockS-12/BL_2/My_Structure/25

addpath /zocconasphys1/chronic_inv_rec/codes/
load My_StimS


stim_pres_times_bars = [];
stim_pres_times_obj = [];
stim_pres_times_g = [];
stim_pres_times_d = [];

stim_pres_all_bars = [];
stim_pres_all_obj = [];
stim_pres_all_g = [];
stim_pres_all_d = [];

for nn = 1 %neuronS
    countolo = 0;
        
    load(['PSTH_RASTER_', num2str(nn),'.mat'])
    load(['NEURON_', num2str(nn),'.mat'])
    
    cucu = My_Neurons.MeanFiringRate;
%     MFR = cucu*(1000/25);
    bitcodes = PsthAndRaster.BitCodes;
    
    %% stimcodes
    % bars = -1
    % objects = 1 2 3 4
    % gratings = 111 121 131 141
    % dots = 21 22 23 24
    
    
    [a b]=ind2sub(size(Fede_STIM), find(Fede_STIM(1:270,2)==-1));
    selected_bits_bars = a';

    
    for BIT_Number = selected_bits_bars; 
        
       
            %% to get the pres_time in that condition

            k = PsthAndRaster.Trials{BIT_Number,nn}(1);
            stim_pres_time_bars = (STIM_STOP(k)-STIM_START(k))*1000;
            if stim_pres_time_bars >= 1000
                if STIM_STOP(k) > STIM_START(k)
                stim_pres_times_bars = abs(STIM_START(k) - STIM_STOP(k));
                stim_pres_all_bars = [stim_pres_all_bars, stim_pres_times_bars]
                end
            end
            
    end
    
    %% Uncomment for test hist
           
            figure;
       
            hist (stim_pres_all_bars, 10, 'k')
                title(['Bars']); 
      
      
    [c d]=ind2sub(size(Fede_STIM), find(Fede_STIM(1:270,2)==1));
    selected_bits_obj = c';

    
    for BIT_Number = selected_bits_obj; 
        

                
            %% to get the pres_time in that condition

            j = PsthAndRaster.Trials{BIT_Number,nn}(1);
            stim_pres_time_obj = (STIM_STOP(j)-STIM_START(j))*1000;
            if stim_pres_time_obj >= 1000
                if STIM_STOP(j) > STIM_START(j)
                stim_pres_times_obj = abs(STIM_START(j) - STIM_STOP(j));
                stim_pres_all_obj = [stim_pres_all_obj, stim_pres_times_obj];
                end
            end
            
    end
    
    figure;
   
    hist (stim_pres_all_obj, 10, 'g')
     title(['Object1']);
     

    [e f]=ind2sub(size(Fede_STIM), find(Fede_STIM(1:270,2)==1));
    selected_bits_g = e';

    
    for BIT_Number = selected_bits_g; 
                
            %% to get the pres_time in that condition

            z = PsthAndRaster.Trials{BIT_Number,nn}(1);
            stim_pres_time_g = (STIM_STOP(z)-STIM_START(z))*1000;
            if stim_pres_time_g >= 1000
                if STIM_STOP(z) > STIM_START(z)
                stim_pres_times_g = abs(STIM_START(z) - STIM_STOP(z));
                stim_pres_all_g = [stim_pres_all_g, stim_pres_times_g];
                end
            end
            
    end
    
    figure;
   
    hist (stim_pres_all_g, 10, 'b')
     title(['Grating1']);
     
            
    [g h]=ind2sub(size(Fede_STIM), find(Fede_STIM(1:270,2)==21));
    selected_bits_d = g';

    
    for BIT_Number = selected_bits_d; 
                
            %% to get the pres_time in that condition

            w = PsthAndRaster.Trials{BIT_Number,nn}(1);
            stim_pres_time_d = (STIM_STOP(w)-STIM_START(w))*1000;
            if stim_pres_time_d >= 1000
                if STIM_STOP(w) > STIM_START(w)
                stim_pres_times_d = abs(STIM_START(w) - STIM_STOP(w));
                stim_pres_all_d = [stim_pres_all_d, stim_pres_times_d]
                end
            end
            
    end
    
    figure;
   
    hist (stim_pres_all_d, 10, 'r')
     title(['Dot1']);
  
            
    
end