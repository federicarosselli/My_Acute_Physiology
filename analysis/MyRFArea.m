%%%%%% MY RECEPTIVE FIELDS BY AREA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%% builds structure with rf values for each area

clear all
clc
close all

DaySOfRecording = {'2_7_2013', '5_7_2013', '8_7_2013', '10_7_2013', '19_7_2013', '15_8_2013', '20_8_2013', '23_8_2013', '27_8_2013', '29_8_2013', '12_11_2013'...
    '19_11_2013', '22_11_2013', '29_11_2013', '3_12_2013', '10_12_2013', '13_12_2013'};

addpath /zocconasphys1/chronic_inv_rec/codes/
addpath /zocconasphys1/chronic_inv_rec/codes/ReceptiveField   

conta1 = 0;
conta2 = 0;
conta3 = 0;
conta4 = 0;
conta5 = 0;
conta6 = 0;


for k = DaySOfRecording
    flagghina = 0;
    if strcmp(k,'2_7_2013')
        flagghina = 1;
        BlockS=[12, 45, 67];        
    elseif strcmp(k,'5_7_2013')
        flagghina = 2;
        BlockS=[12, 34, 56];
    elseif strcmp(k,'8_7_2013')
        flagghina = 3;
        BlockS=[12, 34, 56];
    elseif strcmp(k,'10_7_2013')
        flagghina = 4;
        BlockS=[12, 34, 56];
    elseif strcmp(k,'19_7_2013')
        flagghina = 5;
        BlockS=[12];
    elseif strcmp(k,'15_8_2013')
        flagghina = 6;
        BlockS=[12, 45];
    elseif strcmp(k,'20_8_2013')
        flagghina = 7;
        BlockS=[12, 34];
    elseif strcmp(k,'23_8_2013')
        flagghina = 8;
        BlockS=[12, 34];
    elseif strcmp(k,'27_8_2013')
        flagghina = 9;
        BlockS=[34, 56, 78];
    elseif strcmp(k,'29_8_2013')
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
    elseif strcmp(k,'3_12_2013')
        flagghina = 15;
        BlockS=[56, 1011, 1213]; 
    elseif strcmp(k,'10_12_2013')
        flagghina = 16;
        BlockS=[56, 89, 1011]; 
    elseif strcmp(k,'13_12_2013')
        flagghina = 17;
        BlockS=[56];    
    end
        
    for j = BlockS

        if flagghina == 1
           if j==12
               CoolRfs=[1, 2, 3, 5, 10, 11, 14, 15, 18, 19, 20, 22, 24, 25, 26, 27, 28, 29, 30, 32, 33, 34];
           elseif j==45
               CoolRfs=[1, 2, 3, 5, 6, 7, 8, 10, 11, 12, 13, 14, 17, 18, 22, 23, 24, 25, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 41, 42, 43];
           elseif j==67
               CoolRfs=[6, 7, 11, 12, 14, 15, 16, 17, 21, 22, 24, 31, 34, 35, 36, 37, 39, 40, 41];
           end
        elseif flagghina == 2
            if j==12
               CoolRfs=[1, 2, 3, 5, 6, 8, 9, 10, 12, 13, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32];
           elseif j==34
               CoolRfs=[1, 2, 5, 9, 10, 11, 13, 14, 15, 18, 19, 20, 22, 23, 24, 25, 26, 27, 28, 29, 30, 32, 33, 34];
           elseif j==56
               CoolRfs=[3, 18, 22, 23, 24, 30, 32, 40, 43, 46, 48, 49, 50, 51, 52, 53, 54, 55, 56, 60, 62, 64];
           end
        elseif flagghina == 3
           if j==12
               CoolRfs=[1, 2, 5, 9, 10, 12, 13, 16, 17, 18, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 31];
           elseif j==34
               CoolRfs=[1, 2, 5, 9, 10, 11, 13, 14, 17, 18, 19, 21, 22, 23, 24, 25, 27, 28, 29, 30, 32, 33, 34];
           elseif j==56
               CoolRfs=[1, 2, 3, 6, 10, 13, 14, 17, 22, 23, 24, 25, 26, 27, 28, 29, 31, 32, 33];
           end
        elseif flagghina == 4
           if j==12
               CoolRfs=[1, 2, 5, 9, 10, 11, 13, 17, 18, 19, 21, 22, 23, 24, 25, 26, 27, 28, 29, 31, 32, 33];
           elseif j==34
               CoolRfs=[1, 2, 10, 11, 12, 14, 15, 18, 22, 23, 24, 25, 26, 27, 33];
           elseif j==56
               CoolRfs=[1, 2, 3, 6, 7, 8, 10, 11, 12, 13, 15, 16, 21, 23, 24, 25, 26, 29, 30, 31, 32, 34, 35];
           end
        elseif flagghina == 5
               CoolRfs=[14, 21, 27, 28, 29, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42];         
        elseif flagghina == 6
           if j==12
               CoolRfs=[1, 2, 6, 7, 9, 10, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 35, 36];
           elseif j==45
               CoolRfs=[16, 17, 18, 19, 20, 21, 22, 24, 25, 26, 27, 29, 30, 32, 34, 35, 36, 37, 38, 39, 40 ,41];
           end
        elseif flagghina == 7
           if j==12
               CoolRfs=[1, 2, 3, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 30, 31, 32, 33];
           elseif j==34
               CoolRfs=[2, 3, 5, 6, 7, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36];
           end
        elseif flagghina == 8
           if j==12
               CoolRfs=[1, 2, 3, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 20, 23, 24];
           elseif j==34
               CoolRfs=[12, 13, 14, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34];
           end
        elseif flagghina == 9
           if j==34
               CoolRfs=[1, 2, 3, 5, 12, 13, 14, 19, 20, 21, 22, 23, 24, 26, 30, 32, 35, 36];
           elseif j==56
               CoolRfs=[4, 6, 7, 8, 10, 13, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 39];
           elseif j==78
               CoolRfs=[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 14, 15, 16, 17, 18, 19, 20, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39];
           end   
        elseif flagghina == 10
           if j==34
               CoolRfs=[3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 20, 21, 22, 23, 24, 30, 34, 35];
           elseif j==56
               CoolRfs=[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 13, 14, 17, 18, 19, 25, 26, 27, 28, 29, 32, 33, 34, 35, 36, 37, 38, 39];
           elseif j==78
               CoolRfs=[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 15, 16, 17, 19, 20, 21, 22, 23, 24, 25, 26, 28, 29, 30, 31, 32, 33, 34, 35, 36];
           end   
         elseif flagghina == 11
           if j==67
               CoolRfs=[2, 3, 8, 9, 10, 13, 15, 17, 20, 25, 31, 34];
           elseif j==89
               CoolRfs=[4, 5, 8, 12, 15, 18, 19, 20, 23, 24, 27, 30, 34, 36];
           end
         elseif flagghina == 12
           if j==23
               CoolRfs=[2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 26, 27, 28, 30, 31, 32];           
           end
         elseif flagghina == 13
           if j==12
               CoolRfs=[1, 2, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 19, 20, 21, 24, 25, 27, 28, 29, 30, 32];
           elseif j==56
               CoolRfs=[1, 2, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 21, 22, 24, 28];
           end
         elseif flagghina == 14
           if j==12
               CoolRfs=[2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33];
           elseif j==56
               CoolRfs=[2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34];
           elseif j==89
               CoolRfs=[2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32];    
           end
         elseif flagghina == 15
           if j==56
               CoolRfs=[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 32, 33];
           elseif j==1011
               CoolRfs=[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 32, 33];
           elseif j==1213
               CoolRfs=[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 34, 35];    
           end   
         elseif flagghina == 16
           if j==56
               CoolRfs=[2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 32, 33];
           elseif j==89
               CoolRfs=[2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 32, 33];
           elseif j==1011
               CoolRfs=[3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33];    
           end 
          elseif flagghina == 17 
           if j==56
               CoolRfs=[2, 3, 5, 6, 8, 9, 10, 11, 12, 13, 24, 28, 29, 30, 31, 32, 33];
           end     
        end
            
        mkdir(['/zocconasphys1/chronic_inv_rec/Tanks/AREAS/'])   
        my_folder = ['/zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_', char(k), '/ANALYSED/BlockS-', num2str(j), '/BL_2/My_Structure/25'];
        cd(my_folder)

%         files = dir(fullfile('*.mat'));
%         neuronS = (numel(files))/2;

            for nn = CoolRfs  %1:neuronS        

            load (['NEURON_', num2str(nn), '.mat'])
    
                if strcmp(My_Neurons.Area,'V1b')
                conta1 = conta1+1;
                V1b{conta1}.RF.coeffa = My_Neurons.RF.coeffa;
                V1b{conta1}.RF.coeffb = My_Neurons.RF.coeffb;
                V1b{conta1}.RF.posx = My_Neurons.RF.posx;
                V1b{conta1}.RF.posy = My_Neurons.RF.posy;
                V1b{conta1}.RF.devx = My_Neurons.RF.devx;
                V1b{conta1}.RF.devy = My_Neurons.RF.devy;
                V1b{conta1}.RF.size = My_Neurons.RF.size;
       
                elseif strcmp(My_Neurons.Area,'AL')
                conta2 = conta2+1;
                AL{conta2}.RF.coeffa = My_Neurons.RF.coeffa;
                AL{conta2}.RF.coeffb = My_Neurons.RF.coeffb;
                AL{conta2}.RF.posx = My_Neurons.RF.posx;
                AL{conta2}.RF.posy = My_Neurons.RF.posy;
                AL{conta2}.RF.devx = My_Neurons.RF.devx;
                AL{conta2}.RF.devy = My_Neurons.RF.devy;
                AL{conta2}.RF.size = My_Neurons.RF.size;
                
                elseif strcmp(My_Neurons.Area,'LM')
                conta3 = conta3+1;
                LM{conta3}.RF.coeffa = My_Neurons.RF.coeffa;
                LM{conta3}.RF.coeffb = My_Neurons.RF.coeffb;
                LM{conta3}.RF.posx = My_Neurons.RF.posx;
                LM{conta3}.RF.posy = My_Neurons.RF.posy;
                LM{conta3}.RF.devx = My_Neurons.RF.devx;
                LM{conta3}.RF.devy = My_Neurons.RF.devy;
                LM{conta3}.RF.size = My_Neurons.RF.size;
                
                elseif strcmp(My_Neurons.Area,'LI')
                conta4 = conta4+1;
                LI{conta4}.RF.coeffa = My_Neurons.RF.coeffa;
                LI{conta4}.RF.coeffb = My_Neurons.RF.coeffb;
                LI{conta4}.RF.posx = My_Neurons.RF.posx;
                LI{conta4}.RF.posy = My_Neurons.RF.posy;
                LI{conta4}.RF.devx = My_Neurons.RF.devx;
                LI{conta4}.RF.devy = My_Neurons.RF.devy;
                LI{conta4}.RF.size = My_Neurons.RF.size;
                
                elseif strcmp(My_Neurons.Area,'LL')
                conta5 = conta5+1;
                LL{conta5}.RF.coeffa = My_Neurons.RF.coeffa;
                LL{conta5}.RF.coeffb = My_Neurons.RF.coeffb;
                LL{conta5}.RF.posx = My_Neurons.RF.posx;
                LL{conta5}.RF.posy = My_Neurons.RF.posy;
                LL{conta5}.RF.devx = My_Neurons.RF.devx;
                LL{conta5}.RF.devy = My_Neurons.RF.devy;
                LL{conta5}.RF.size = My_Neurons.RF.size;
                
                elseif strcmp(My_Neurons.Area,'LLb')
                conta6 = conta6+1;
                LLb{conta6}.RF.coeffa = My_Neurons.RF.coeffa;
                LLb{conta6}.RF.coeffb = My_Neurons.RF.coeffb;
                LLb{conta6}.RF.posx = My_Neurons.RF.posx;
                LLb{conta6}.RF.posy = My_Neurons.RF.posy;
                LLb{conta6}.RF.devx = My_Neurons.RF.devx;
                LLb{conta6}.RF.devy = My_Neurons.RF.devy;
                LLb{conta6}.RF.size = My_Neurons.RF.size;
       
                end

            end

            
    end
    


end

save(['/zocconasphys1/chronic_inv_rec/Tanks/AREAS/MyAreas.mat'], 'V1b', 'AL', 'LM', 'LI', 'LL', 'LLb', '-v7.3')





            
            