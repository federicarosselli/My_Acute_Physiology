%%% MY_WINDOWS
%%%%%%%%%%%%%%

clc
clear all
close all

DayOfRecording = '2_7_2013';
Block = 12;

my_folder = ['/zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_', char(DayOfRecording), '/ANALYSED/BlockS-', num2str(Block), '/BL_2/My_Structure/25'];
% my_folder = ['/zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_', , char(DayOfRecording), '/ANALYSED/Block-' , num2str(Block), '/My_Structure/25'];

addpath /zocconasphys1/chronic_inv_rec/codes/
cd (my_folder)
mkdir(['WINDOWS/']);
ww = cd;

%%
            
alpha = 2; %number of st.dev that define a threshold
n = 3; %smoothing parameter
time_baseline = 150;
t_fast = 800;
t_slow = 2000;
t_static = 250;

% T=linspace(-200,2200,238);


%%

my_times = cell(zeros());

my_folder = ['/zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_', char(DayOfRecording), '/ANALYSED/BlockS-', num2str(Block), '/BL_2/My_Structure/25/RASTERS'];
cd (my_folder)
file = 'PeaksnTimes.mat';
A =load(file);
cd ..


[my_bits, nn] = size(A.all_time_series);

for i=1:nn
    
    load(['PSTH_RASTER_', num2str(i),'.mat'])
    load(['NEURON_', num2str(i),'.mat'])
    
    for j=1:my_bits
        
        flag_1 = 0; %no peaks
        flag_2 = 0; %max peak lower than threshold
        
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
        time = T(t0:tm);
        trace_crop = trace(t0:tm);
            
        %if the crop starts from 1 it is not necessary to add t0
        [pks,locs] = findpeaks(trace_crop); 
        
        if isempty(pks)
            onset = 0;
            offset = 250;
            flag_1 = 1;
        end
        
        
        if flag_1 == 0
            locs = locs + t0;
        end
        %[pks,locs] = findpeaks(trace);
        
        i
        j
        
        figure;
        %plot(T,trace); hold on;
        plot(time,trace_crop); hold on;
        
        title(['Spike Counting Window, Neuron ', num2str(i), ', BitCode ', num2str(j)])
        xlabel(['Stim Time ', num2str(stim_pres_time)])
        
        %superimpose smoothed curve
        % smoothed_trace = my_loess(trace,n);
        % plot(T,smoothed_trace,'Color','magenta')

%         offset values of peak heights for plotting
               
        %plot(T(locs),pks+0.05,'k^','markerfacecolor',[1 0 0]); hold on;
        if(flag_1 == 0)
            plot(time(locs - t0),pks+0.05,'k^','markerfacecolor',[1 0 0]); hold on;
        end
        
%         %define the baseline
%         logical_v = T > 0;
%         a = find(logical_v == 1);
%         my_zero = a(1) - 1;
%         logical_v = ( (T > - time_baseline) & (T < 0) ) ;
%         a = find(logical_v == 1);
%         my_point = a(1) - 1;
% 
%         %define threshold
%         baseline = mean(trace(my_point: my_zero));
%         std_baseline = std(trace(my_point: my_zero));
%         threshold = baseline + std_baseline*alpha;


        %define threshold from blank
        baseline = mean(blank_trace);
        std_baseline = std(blank_trace);
        threshold = baseline + std_baseline*alpha;
        
        %define window

        %find maximal peak

        index = find(pks == max(pks));       
        %check if there exist multiple maxima
        if length(index) > 1
            index = index(1);
        end
        
        %T_max = T(locs(index));
        max_peak = pks(index);
        
        if max_peak <= threshold 
            onset = 0;
            offset = 250;
            flag_2 = 1;
        end
        
        
        if flag_1 == 0 && flag_2 == 0
        
            %%
            %find onset
            current_value = pks(index);
            %current_time = T_max;
            current_index = locs(index);


            while current_value > threshold
                current_value = trace(current_index - 1);
                current_index = current_index - 1;
            end

            onset_R = current_index + 1;
            onset_L = current_index;

            delta_x = T(onset_R) - T(onset_L);
            delta_y = trace(onset_R) - trace(onset_L);
            tg_beta = delta_x/delta_y;

            delta = threshold - trace(onset_L);
            delta_t = delta*tg_beta;

            onset = T(onset_L) + delta_t;


            %find offset

            current_value = pks(index);
            %current_time = T_max;
            current_index = locs(index);



            while current_value > threshold
                current_value = trace(current_index + 1);
                current_index = current_index + 1;
            end

            offset_R = current_index;
            offset_L = current_index - 1;

            delta_x = T(offset_R) - T(offset_L);
            delta_y = trace(offset_R) - trace(offset_L);
            tg_beta = delta_x/delta_y;

            delta = threshold - trace(offset_L);
            delta_t = delta*tg_beta;

            offset = T(offset_L) + delta_t;

        end
        %%
        
        
        tempi = [onset, offset];
        my_times{j, i}=tempi;
        

        line([time(1) time(end)], [threshold threshold ], 'Color', 'green','linewidth',2); hold on;
        line([onset onset], [0 max_peak], 'Color', 'r','linewidth',2);hold on;
        line([offset offset], [0 max_peak], 'Color', 'r','linewidth',2);hold on;
        saveas(gcf,[ww,'/WINDOWS/', num2str(i), '_', num2str(j),'.png']) 
%         pause(2)
        close;
    
        
        clear onset offset
        
        
    end
    
    save([ww,'/WINDOWS/Windows.mat'], 'my_times', '-v7.3');
    
end
    

