
%%%%%% MY FiringRates BY AREA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%% builds structure RF values for each area, drawing from FiringRates.m
%%%% created with My_FiringRatesForScatters (n.b. only for Gratings n Dots)

clear all
clc
close all

DaySOfRecording = {'02_07_2013', '05_07_2013', '08_07_2013', '10_07_2013', '19_07_2013', '15_08_2013', '20_08_2013', '23_08_2013', '27_08_2013', '29_08_2013'...
    '19_11_2013', '22_11_2013', '29_11_2013', '03_12_2013', '10_12_2013'};

addpath /zocconasphys1/chronic_inv_rec/codes/
load My_StimS_NUANGLE_NUCONDITIONS
% addpath /zocconasphys1/chronic_inv_rec/codes/ReceptiveField   

conta1 = 0;
conta2 = 0;
conta3 = 0;
conta4 = 0;
conta5 = 0;
conta6 = 0;




for k = DaySOfRecording
    flagghina = 0;
    if strcmp(k,'02_07_2013')
        flagghina = 1;
        BlockS=[12, 45];        
    elseif strcmp(k,'05_07_2013')
        flagghina = 2;
        BlockS=[12, 34];
    elseif strcmp(k,'08_07_2013')
        flagghina = 3;
        BlockS=[12, 34, 56];
    elseif strcmp(k,'10_07_2013')
        flagghina = 4;
        BlockS=[12, 34, 56];
    elseif strcmp(k,'19_07_2013')
        flagghina = 5;
        BlockS=[12];
    elseif strcmp(k,'15_08_2013')
        flagghina = 6;
        BlockS=[12, 45];
    elseif strcmp(k,'20_08_2013')
        flagghina = 7;
        BlockS=[12, 34];
    elseif strcmp(k,'23_08_2013')
        flagghina = 8;
        BlockS=[12, 34];
    elseif strcmp(k,'27_08_2013')
        flagghina = 9;
        BlockS=[56, 78];
    elseif strcmp(k,'29_08_2013')
        flagghina = 10;
        BlockS=[34, 56, 78];
    elseif strcmp(k,'12_11_2013')
        flagghina = 11;
        BlockS=[67, 89];
    elseif strcmp(k,'19_11_2013')
        flagghina = 12;
        BlockS=[23];
    elseif strcmp(k,'22_11_2013')
        flagghina = 13;
        BlockS=[12, 56];
    elseif strcmp(k,'29_11_2013')
        flagghina = 14;
        BlockS=[12, 56, 89];
    elseif strcmp(k,'03_12_2013')
        flagghina = 15;
        BlockS=[56, 1011, 1213]; 
    elseif strcmp(k,'10_12_2013')
        flagghina = 16;
        BlockS=[56, 89, 1011]; 
    elseif strcmp(k,'13_12_2013')
        flagghina = 17;
        BlockS=[56];    
    end
        
    for j = BlockS   % CoolNNs = neurons with good RF

        if flagghina == 1   % 2.7.2013
           if j==12
               CoolNNs=[1, 2, 3, 5, 10, 11, 14, 15, 18, 19, 20, 22, 24, 25, 26, 27, 28, 29, 30, 32, 33, 34];
           elseif j==45
               CoolNNs=[1, 2, 3, 5, 6, 7, 8, 10, 11, 12, 13, 14, 17, 18, 22, 23, 24, 25, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 41, 42, 43];
           elseif j==67
               CoolNNs=[1, 2, 3, 6, 7, 11, 12, 14, 15, 16, 17, 21, 22, 24, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 39, 40, 41];
           end
        elseif flagghina == 2  % 5.7.2013
            if j==12
               CoolNNs=[1, 2, 3, 5, 6, 8, 9, 10, 12, 13, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32];
           elseif j==34
               CoolNNs=[1, 2, 5, 9, 10, 11, 13, 14, 15, 18, 19, 20, 22, 23, 24, 25, 26, 27, 28, 29, 30, 32, 33, 34];
           elseif j==56
               CoolNNs=[1, 3, 9, 16, 18, 22, 23, 24, 30, 32, 40, 43, 46, 48, 49, 50, 51, 52, 53, 54, 55, 56, 60, 62, 64];
           end
        elseif flagghina == 3   % 8.7.2013
           if j==12
               CoolNNs=[1, 2, 5, 9, 10, 12, 13, 16, 17, 18, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32];
           elseif j==34
               CoolNNs=[1, 2, 5, 9, 10, 11, 13, 14, 17, 18, 19, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 32, 33, 34];
           elseif j==56
               CoolNNs=[1, 2, 3, 6, 10, 13, 14, 17, 22, 23, 24, 25, 26, 27, 28, 29, 31, 32, 33];
           end
        elseif flagghina == 4 % 10.7.2013
           if j==12
               CoolNNs=[1, 2, 5, 9, 10, 11, 13, 14, 17, 18, 19, 21, 22, 23, 24, 25, 26, 27, 28, 29, 31, 32, 33];
           elseif j==34
               CoolNNs=[1, 2, 5, 10, 11, 12, 14, 15, 18, 19, 20, 22, 23, 24, 25, 26, 27, 29, 33];
           elseif j==56
               CoolNNs=[1, 2, 3, 6, 7, 8, 10, 11, 12, 13, 15, 16, 20, 21, 23, 24, 25, 26, 27, 29, 30, 31, 32, 34, 35];
           end
        elseif flagghina == 5 % 19.7.2013
               CoolNNs=[3, 7, 10, 14, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42];         
        elseif flagghina == 6 % 15.8.2013
           if j==12
               CoolNNs=[1, 2, 3, 4, 5, 6, 9, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 35, 36];
           elseif j==45
               CoolNNs=[1, 2, 3, 4, 5, 7, 8, 11, 12, 15, 16, 17, 18, 19, 20, 21, 22, 24, 25, 26, 27, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40 ,41];
           end
        elseif flagghina == 7 % 20.8.2013
           if j==12
               CoolNNs=[1, 2, 3, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33];
           elseif j==34
               CoolNNs=[1, 2, 3, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36];
           end
        elseif flagghina == 8 % 23.8.2013
           if j==12
               CoolNNs=[1, 2, 3, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 23, 24, 25, 26, 27, 28, 29];
           elseif j==34
               CoolNNs=[6, 7, 8, 9, 10, 11, 12, 13, 14, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34];
           end
        elseif flagghina == 9 % 27.8.2013
           if j==34
               CoolNNs=[1, 2, 3, 4, 5, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 34, 35, 36];
           elseif j==56
               CoolNNs=[1, 2, 4, 6, 7, 8, 10, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 25, 26, 27, 28, 39, 40, 41];
           elseif j==78
               CoolNNs=[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39];
           end   
        elseif flagghina == 10 % 29.8.2013
           if j==34
               CoolNNs=[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 28, 29, 30, 31, 32, 33, 34, 35];
           elseif j==56
               CoolNNs=[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 17, 18, 19, 20, 21, 22, 25, 26, 27, 28, 29, 32, 33, 34, 35, 36, 37, 38, 39];
           elseif j==78
               CoolNNs=[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36];
           end   
         elseif flagghina == 11 % 12.11.2013
           if j==67
               CoolNNs=[2, 3, 5, 8, 9, 10, 13, 15, 17, 20, 23, 24, 25, 29, 31, 32, 33, 34, 38];
           elseif j==89
               CoolNNs=[4, 5, 7, 8, 9, 12, 15, 18, 19, 20, 21, 23, 24, 27, 28, 30, 31, 32, 34, 36];
           end
         elseif flagghina == 12 % 19.11.2013
           if j==23
               CoolNNs=[2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33];           
           end
         elseif flagghina == 13 % 22.11.2013
           if j==12
               CoolNNs=[1, 2, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 19, 20, 21, 24, 25, 27, 28, 29, 30, 31];
           elseif j==56
               CoolNNs=[1, 2, 3, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 21, 22, 24, 28, 35];
           end
         elseif flagghina == 14 % 29.11.2013
           if j==12
               CoolNNs=[2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33];
           elseif j==56
               CoolNNs=[2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34];
           elseif j==89
               CoolNNs=[2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32];    
           end
         elseif flagghina == 15 % 3.12.2013
           if j==56
               CoolNNs=[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 32, 33];
           elseif j==1011
               CoolNNs=[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 32, 33];
           elseif j==1213
               CoolNNs=[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 34, 35];    
           end   
         elseif flagghina == 16 % 10.12.2013
           if j==56
               CoolNNs=[2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 32, 33];
           elseif j==89
               CoolNNs=[2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 32, 33];
           elseif j==1011
               CoolNNs=[3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33];    
           end 
          elseif flagghina == 17 % 13.12.2013
           if j==56
               CoolNNs=[2, 3, 4, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33];
           end     
        end
            
%         mkdir(['/zocconasphys1/chronic_inv_rec/Tanks/AREAS/'])   
        
        my_folder_1 = ['/zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_', char(k), '/ANALYSED/BlockS-', num2str(j), '/BL_2/My_Structure/25/SCATTERS'];
        cd(my_folder_1)
        load FiringRates
        cd ..
        
        my_folder = ['/zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_', char(k), '/ANALYSED/BlockS-', num2str(j), '/BL_2/My_Structure/25/'];
        cd(my_folder)

%         files = dir(fullfile('*.mat'));
%         neuronS = (numel(files))/2;

            for nn = CoolNNs  %1:neuronS        

            load (['NEURON_', num2str(nn), '.mat'])
    
                if strcmp(My_Neurons.Area,'V1b') | strcmp(My_Neurons.Area,'AL')
                conta1 = conta1+1;
                
                V1bFR(conta1).Gratings.Fast.SF1 = FRGratings.Fast(1,nn).Me(1); %%SF1
                V1bFR(conta1).Gratings.Fast.SF2 = FRGratings.Fast(1,nn).Me(2); %%SF2
                V1bFR(conta1).Gratings.Fast.SF3 = FRGratings.Fast(1,nn).Me(3); %%SF3
                V1bFR(conta1).Gratings.Fast.SF4 = FRGratings.Fast(1,nn).Me(4); %%SF4
                
                V1bFR(conta1).Gratings.Slow.SF1 = FRGratings.Slow(1,nn).Me(1); %%SF1
                V1bFR(conta1).Gratings.Slow.SF2 = FRGratings.Slow(1,nn).Me(2); %%SF2
                V1bFR(conta1).Gratings.Slow.SF3 = FRGratings.Slow(1,nn).Me(3); %%SF3
                V1bFR(conta1).Gratings.Slow.SF4 = FRGratings.Slow(1,nn).Me(4); %%SF4
                
                V1bFR(conta1).Dots.Fast.P1 = FRDots.Fast(1,nn).Me(1); %%P1
                V1bFR(conta1).Dots.Fast.P2 = FRDots.Fast(1,nn).Me(2); %%P2
                
                V1bFR(conta1).Dots.Slow.P1 = FRDots.Slow(1,nn).Me(1); %%P1
                V1bFR(conta1).Dots.Slow.P2 = FRDots.Slow(1,nn).Me(2); %%P2
                
                
%                 elseif strcmp(My_Neurons.Area,'AL')
%                 conta2 = conta2+1;
%                 AL{conta2}.Lat.Peak = My_Neurons.Peak;
%                 AL{conta2}.Lat.TimeSeries = My_Neurons.TimeSeries;
%                 AL{conta2}.Lat.Onset = My_Neurons.Latencies.on;
%                 AL{conta2}.Lat.Offset = My_Neurons.Latencies.off;
                

                elseif strcmp(My_Neurons.Area,'LM')
                conta3 = conta3+1;
                
                LMFR(conta3).Gratings.Fast.SF1 = FRGratings.Fast(1,nn).Me(1); %%SF1
                LMFR(conta3).Gratings.Fast.SF2 = FRGratings.Fast(1,nn).Me(2); %%SF2
                LMFR(conta3).Gratings.Fast.SF3 = FRGratings.Fast(1,nn).Me(3); %%SF3
                LMFR(conta3).Gratings.Fast.SF4 = FRGratings.Fast(1,nn).Me(4); %%SF4
                
                LMFR(conta3).Gratings.Slow.SF1 = FRGratings.Slow(1,nn).Me(1); %%SF1
                LMFR(conta3).Gratings.Slow.SF2 = FRGratings.Slow(1,nn).Me(2); %%SF2
                LMFR(conta3).Gratings.Slow.SF3 = FRGratings.Slow(1,nn).Me(3); %%SF3
                LMFR(conta3).Gratings.Slow.SF4 = FRGratings.Slow(1,nn).Me(4); %%SF4
                
                LMFR(conta3).Dots.Fast.P1 = FRDots.Fast(1,nn).Me(1); %%P1
                LMFR(conta3).Dots.Fast.P2 = FRDots.Fast(1,nn).Me(2); %%P2
                
                LMFR(conta3).Dots.Slow.P1 = FRDots.Slow(1,nn).Me(1); %%P1
                LMFR(conta3).Dots.Slow.P2 = FRDots.Slow(1,nn).Me(2); %%P2
                
                
                elseif strcmp(My_Neurons.Area,'LI')
                conta4 = conta4+1;
                
                LIFR(conta4).Gratings.Fast.SF1 = FRGratings.Fast(1,nn).Me(1); %%SF1
                LIFR(conta4).Gratings.Fast.SF2 = FRGratings.Fast(1,nn).Me(2); %%SF2
                LIFR(conta4).Gratings.Fast.SF3 = FRGratings.Fast(1,nn).Me(3); %%SF3
                LIFR(conta4).Gratings.Fast.SF4 = FRGratings.Fast(1,nn).Me(4); %%SF4
                
                LIFR(conta4).Gratings.Slow.SF1 = FRGratings.Slow(1,nn).Me(1); %%SF1
                LIFR(conta4).Gratings.Slow.SF2 = FRGratings.Slow(1,nn).Me(2); %%SF2
                LIFR(conta4).Gratings.Slow.SF3 = FRGratings.Slow(1,nn).Me(3); %%SF3
                LIFR(conta4).Gratings.Slow.SF4 = FRGratings.Slow(1,nn).Me(4); %%SF4
                
                LIFR(conta4).Dots.Fast.P1 = FRDots.Fast(1,nn).Me(1); %%P1
                LIFR(conta4).Dots.Fast.P2 = FRDots.Fast(1,nn).Me(2); %%P2
                
                LIFR(conta4).Dots.Slow.P1 = FRDots.Slow(1,nn).Me(1); %%P1
                LIFR(conta4).Dots.Slow.P2 = FRDots.Slow(1,nn).Me(2); %%P2
                
                
                elseif strcmp(My_Neurons.Area,'LL')
                conta5 = conta5+1;
                
                LLFR(conta5).Gratings.Fast.SF1 = FRGratings.Fast(1,nn).Me(1); %%SF1
                LLFR(conta5).Gratings.Fast.SF2 = FRGratings.Fast(1,nn).Me(2); %%SF2
                LLFR(conta5).Gratings.Fast.SF3 = FRGratings.Fast(1,nn).Me(3); %%SF3
                LLFR(conta5).Gratings.Fast.SF4 = FRGratings.Fast(1,nn).Me(4); %%SF4
                
                LLFR(conta5).Gratings.Slow.SF1 = FRGratings.Slow(1,nn).Me(1); %%SF1
                LLFR(conta5).Gratings.Slow.SF2 = FRGratings.Slow(1,nn).Me(2); %%SF2
                LLFR(conta5).Gratings.Slow.SF3 = FRGratings.Slow(1,nn).Me(3); %%SF3
                LLFR(conta5).Gratings.Slow.SF4 = FRGratings.Slow(1,nn).Me(4); %%SF4
                
                LLFR(conta5).Dots.Fast.P1 = FRDots.Fast(1,nn).Me(1); %%P1
                LLFR(conta5).Dots.Fast.P2 = FRDots.Fast(1,nn).Me(2); %%P2
                
                LLFR(conta5).Dots.Slow.P1 = FRDots.Slow(1,nn).Me(1); %%P1
                LLFR(conta5).Dots.Slow.P2 = FRDots.Slow(1,nn).Me(2); %%P2
                
                
                elseif strcmp(My_Neurons.Area,'LLb')
                conta6 = conta6+1;
                
                LLbFR(conta6).Gratings.Fast.SF1 = FRGratings.Fast(1,nn).Me(1); %%SF1
                LLbFR(conta6).Gratings.Fast.SF2 = FRGratings.Fast(1,nn).Me(2); %%SF2
                LLbFR(conta6).Gratings.Fast.SF3 = FRGratings.Fast(1,nn).Me(3); %%SF3
                LLbFR(conta6).Gratings.Fast.SF4 = FRGratings.Fast(1,nn).Me(4); %%SF4
                
                LLbFR(conta6).Gratings.Slow.SF1 = FRGratings.Slow(1,nn).Me(1); %%SF1
                LLbFR(conta6).Gratings.Slow.SF2 = FRGratings.Slow(1,nn).Me(2); %%SF2
                LLbFR(conta6).Gratings.Slow.SF3 = FRGratings.Slow(1,nn).Me(3); %%SF3
                LLbFR(conta6).Gratings.Slow.SF4 = FRGratings.Slow(1,nn).Me(4); %%SF4
                
                LLbFR(conta6).Dots.Fast.P1 = FRDots.Fast(1,nn).Me(1); %%P1
                LLbFR(conta6).Dots.Fast.P2 = FRDots.Fast(1,nn).Me(2); %%P2
                
                LLbFR(conta6).Dots.Slow.P1 = FRDots.Slow(1,nn).Me(1); %%P1
                LLbFR(conta6).Dots.Slow.P2 = FRDots.Slow(1,nn).Me(2); %%P2
       
                end

            end

%             clear FiringRates
    end
    


end

save(['/zocconasphys1/chronic_inv_rec/Tanks/AREAS/MyFiringRates_GD.mat'], 'V1bFR', 'LMFR', 'LIFR', 'LLFR', 'LLbFR', '-v7.3') %'LMFR', 'LIFR', 'LLFR', 'LLbFR', '-v7.3')