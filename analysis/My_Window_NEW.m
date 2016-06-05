%%% MY_WINDOWS
%%%%%%%%%%%%%%

clc
clear all
close all

DayOfRecording = '13_12_2013';
Block = 56;

% my_folder = ['/zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_', char(DayOfRecording), '/ANALYSED/BlockS-', num2str(Block), '/BL_2/My_Structure/50'];
my_folder = ['/zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_', char(DayOfRecording), '/ANALYSED/BlockS-', num2str(Block), '/BL_2/My_Structure/25'];

addpath /zocconasphys1/chronic_inv_rec/codes/
cd (my_folder)
mkdir(['WINDOWS/']);
ww = cd;

%%
            
alpha = 1.5; %number of st.dev that define a threshold
n = 3; %smoothing parameter
time_baseline = 150;
t_fast = 800;
t_slow = 2000;
t_static = 250;
tolerance = 0.7; %tolerance for the peaks near the maximum

%%
my_times = cell(zeros());
my_folder = ['/zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_', char(DayOfRecording), '/ANALYSED/BlockS-', num2str(Block), '/BL_2/My_Structure/25/RASTERS'];
% my_folder = ['/zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_', char(DayOfRecording), '/ANALYSED/BlockS-', num2str(Block), '/BL_2/My_Structure/50/RASTERS'];
cd (my_folder)
file = 'PeaksnTimes.mat';
A =load(file);
cd ..
%%

Onset = [];
Offset = [];
Duration = [];
iterator = 0;



[my_bits, nn] = size(A.all_time_series);
for i= 1:nn
    
    load(['PSTH_RASTER_', num2str(i),'.mat'])
    load(['NEURON_', num2str(i),'.mat'])
    
    for j=1:my_bits
        iterator = iterator + 1
        
        flag_1 = 0; %no peaks
        flag_2 = 0; %max peak lower than threshold
        flag_3 = 0; %the part of the trace on the left of the max peak
                    %never reaches the threshold
        flag_4 = 0; %the part of the trace on the right of the max peak
                    %never reaches the threshold
           
        
        %%
        trace = A.all_time_series{j,i};
        
        T=linspace(-200,2200,size(PsthAndRaster.Psth{j,i},2));
        a = PsthAndRaster.Trials{j,i}(1);
        stim_pres_time = (STIM_STOP(a)-STIM_START(a))*1000;
        
        if stim_pres_time > 500 && stim_pres_time < 1000
            class = 'fast';
            
        elseif stim_pres_time > 1000
            class = 'slow';
            
        elseif stim_pres_time < 500
            class = 'static';
           
        end
             
        switch class
          case 'fast'
            [int tm]=min(abs(T-t_fast));
            blank_trace = A.all_time_series{6,i};
          case 'slow'
            [int tm]=min(abs(T-t_slow));
            blank_trace = A.all_time_series{5,i};
          case 'static'
            [int tm]=min(abs(T-t_static));  
            blank_trace = A.all_time_series{4,i};
          otherwise
            disp('Error: unknown class');
            break
        end
 
        
        [int0 t0]=min(abs(T-0));          
        time_crop = T(t0:tm);
        trace_crop = trace(t0:tm);
            
        %if the crop starts from 1 it is not necessary to add t0
        [pks,locs] = findpeaks(trace_crop); 
        
        if isempty(pks)
            onset = 0;
            offset = 250;
            flag_1 = 1;
                       
            [int0 t0]=min(abs(T-0));   
            [int0 tm]=min(abs(T-250));   
            onset_L = t0;
            onset_R = t0;
            offset_L = tm;
            offset_R = tm;
                       
        else
            locs = locs + t0;
        end
        
     
        i
        j
        
        %%
%         figure;
%         plot(time_crop,trace_crop); hold on;        
%         title(['Spike Counting Window, Neuron ', num2str(i), ', BitCode ', num2str(j)])
%         xlabel(['Stim Time ', num2str(stim_pres_time)])
        
%         superimpose smoothed curve
%         smoothed_trace = my_loess(trace,n);
%         smoothed_trace_crop = smoothed_trace(t0:tm);
%         plot(time,smoothed_trace_crop,'Color','magenta')

        if(flag_1 == 0)
            plot(time_crop(locs - t0),pks+0.05,'k^','markerfacecolor',[1 0 0]); hold on;
        end
        %%

        %define threshold from blank
        baseline = mean(blank_trace);
        std_baseline = std(blank_trace);
        threshold = baseline + std_baseline*alpha;
        
        
        %%
        %define window module

        %find interesting peaks
        index = find(pks > max(pks)*tolerance);         
        if length(index) > 1
            index_L = index(1);
            index_R = index(end);
        else
            index_L = index;
            index_R = index;
        end
        
        T_max = T(locs(index));
        max_peak_L = pks(index_L);
        max_peak_R = pks(index_R);
        
        %if the maximal peak is subthreshold
        if max(pks) <= threshold 
            onset = 0;
            offset = 250;
            flag_2 = 1;
            
            [int0 t0]=min(abs(T-0));   
            [int0 tm]=min(abs(T-250));   
            onset_L = t0;
            onset_R = t0;
            offset_L = tm;
            offset_R = tm;
        end
             
        %%      
        
        %if there is a maximum and is over suprathreshold
        if flag_1 == 0 && flag_2 == 0
        
            %%
            %find onset
            current_value = pks(index_L);
            current_index = locs(index_L);

            while (current_value > threshold && current_index > 1)
                current_value = trace(current_index - 1);
                current_index = current_index - 1;
                %current_index
                
                if(current_value <= threshold)
                    flag_3 = 1;
                end

            end
            
            %if the trace on the left of the maximal peak never reaches
            %the threshold
            if flag_3 == 0
                onset_L = t0;
                onset_R = t0 + 1;
            else
                onset_L = current_index;
                onset_R = current_index + 1;
                
                
            end         
            
            
            
            delta_x = T(onset_R) - T(onset_L);
            delta_y = trace(onset_R) - trace(onset_L);
            
            if(abs(delta_y) > 0 )
                tg_beta = delta_x/delta_y;
            else
                tg_beta = 0;
            end

            delta = threshold - trace(onset_L);
            delta_t = delta*tg_beta;

            onset = T(onset_L) + delta_t;
            if onset < 0 
                onset = 0;
            end


            %find offset

            current_value = pks(index_R);
            current_index = locs(index_R);



            while ( (current_value > threshold) && (current_index < length(trace)) ) 
                current_value = trace(current_index + 1);
                current_index = current_index + 1;              
                %current_index
                if(current_value < threshold)
                    flag_4 = 1;
                end
            end
            %if the trace at the right of the last max_peak never
            %reaches the threshold
            if flag_4 == 0
                offset_R = tm;
                offset_L = tm - 1;     

            else
                offset_R = current_index;
                offset_L = current_index - 1;
            end

            delta_x = T(offset_R) - T(offset_L);
            delta_y = trace(offset_R) - trace(offset_L);
            
            
            if(abs(delta_y) > 0 )
                tg_beta = delta_x/delta_y;
            else
                tg_beta = 0;
            end
            
            delta = threshold - trace(offset_L);
            delta_t = delta*tg_beta;

            offset = T(offset_L) + delta_t;

        end
        %%
        
        
        tempi = [onset, offset];
        my_times{j, i}=tempi;
        
        
        m_const = max(trace_crop);

%         line([time_crop(1) time_crop(end)], [threshold threshold ], 'Color', 'green','linewidth',2); hold on;
%         line([onset onset], [0 m_const], 'Color', 'r','linewidth',2);hold on;
%         line([offset offset], [0 m_const], 'Color', 'r','linewidth',2);hold on;
        
        duration = offset - onset;
        Onset(iterator) = onset;
        Offset(iterator) = offset;
        Duration(iterator) = duration;
        
        attivazione_media = mean(trace(onset_L+1:offset_R-1));
        attivazione_media_2 = mean(trace(onset_L:offset_R));
        
        
%         text(offset_R,m_const,num2str(attivazione_media));
%         text(offset_R,max(pks) - 10,num2str(attivazione_media_2));
        
%         saveas(gcf,[ww,'/WINDOWS/', num2str(i), '_', num2str(j),'.png']) 
%         pause(4)
%         close;
    
        
        clear onset offset threshold trace
        
        
    end
    
    save([ww,'/WINDOWS/Windows.mat'], 'my_times', '-v7.3');
    
end
    

