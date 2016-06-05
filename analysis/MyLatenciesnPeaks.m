%%%%%% MY LATENCIESNPEAKS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%% adds LATENCIES N PEAKS VALUES to the structure 'NEURON'

clear all
clc
close all

DayOfRecording = '13_12_2013';
Block=[56];
addpath /zocconasphys1/chronic_inv_rec/codes/
load My_StimS_NUANGLE_NUCONDITIONS

[a z]=ind2sub(size(Fede_STIM_NU), find (Fede_STIM_NU(1:342,11)==0.250000000000000));       
selected_bits = a';

for w = Block

% my_folder = ['/zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_', char(DayOfRecording), '/ANALYSED/BlockS-', num2str(Block), '/BL_2/My_Structure/25'];
my_folder_1 = ['/zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_', char(DayOfRecording), '/ANALYSED/BlockS-', num2str(w), '/BL_2/My_Structure/25/WINDOWS'];
my_folder_2 = ['/zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_', char(DayOfRecording), '/ANALYSED/BlockS-', num2str(w), '/BL_2/My_Structure/25/RASTERS'];

cd(my_folder_1)
            
load Windows

cd ..

cd(my_folder_2)

load PeaksnTimes

cd ..



files = dir(fullfile('*.mat'));
neuronS = (numel(files))/2;

for nn = 1:neuronS
    
    for bb = selected_bits
    
    load (['NEURON_', num2str(nn), '.mat'])
    
            a = all_peaks{bb,nn};
            My_Neurons.Peak = a; 
            b=all_time_series{bb,nn};
            My_Neurons.TimeSeries = b;
            c=my_times{bb,nn};
            My_Neurons.Latencies.on = c(1);
            My_Neurons.Latencies.off = c(2);
            
    end
    
    save (['NEURON_', num2str(nn), '.mat'], 'My_Neurons')
    
    
end

         
end
            