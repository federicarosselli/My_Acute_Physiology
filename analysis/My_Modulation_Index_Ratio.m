%%%%%%% My_Modulation_Index_Ratio 

clear all
clc
close all

%% only not-V1 sessions:
% DaySOfRecording = {'19_07_2013', '20_08_2013', '23_08_2013', '27_08_2013', '29_08_2013'...
%     '29_11_2013', '03_12_2013', '10_12_2013'};

%% only V1 sessions:
DaySOfRecording = {'02_07_2013', '05_07_2013', '08_07_2013', '10_07_2013', '15_08_2013', '19_11_2013', '22_11_2013'};
% DaySOfRecording = {'22_11_2013'};




addpath /zocconasphys1/chronic_inv_rec/codes/
load My_StimS_NUANGLE_NUCONDITIONS


conta1 = 0;
conta2 = 0;



%% Bcodes for moving gratings
my_bcodes = [167:230];

objectS = [111,222,333,444];


F0 = cell(zeros());
F1 = cell(zeros());
Fmax = cell(zeros());
Fmean = cell(zeros());
Fstd = cell(zeros());
Fbg = cell(zeros());
% F0_noabs = cell(zeros());
% F1_noabs = cell(zeros());

% Bcodes_slow = [2, 5, 167, 169, 171, 173, 175, 177, 179, 181, 183, 185, 187, 189, 191, 193, 195, 197, 199, 201, 203, 205, ...
%     207, 209, 211, 213, 215, 217, 219, 221, 223, 225, 227, 229, 231:238, 247, 249, 251, 253, 255, 257, 259, 261, ...
%     263, 265, 267, 269, 271, 273, 275, 277, 279, 281, 283, 285, 287, 289, 291, 293, 295, 297, 299, 301, 303, 305, 307, 309, ...
%     311, 313, 315, 317, 319, 321, 323, 325, 327, 329, 331, 333, 335, 337, 339, 341];
% Bcodes_fast = [3, 6, 168, 170, 172, 174, 176, 178, 180, 182, 184, 186, 188, 190, 192, 194, 196, 198, 200, 202, 204, 206, ...
%     208, 210, 212, 214, 216, 218, 220, 222, 224, 226, 228, 230, 239:246, 248, 250, 252, 254, 256, 258, 260, 262, ...
%     264, 266, 268, 270, 272, 274, 276, 278, 280, 282, 284, 286, 288, 290, 292, 294, 296, 298, 300, 302, 304, 306, 308, 310, ...
%     312, 314, 316, 318, 320, 322, 324, 326, 328, 330, 332, 334, 336, 338, 340, 342];

Bcodes_fast_gr = [168, 170, 172, 174, 176, 178, 180, 182, 184, 186, 188, 190, 192, 194, 196, 198, 200, 202, 204, 206, ...
    208, 210, 212, 214, 216, 218, 220, 222, 224, 226, 228, 230];




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
    end
    
    
    for j = BlockS
        
        
%         my_folder_1 = ['/zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_', char(k), '/ANALYSED/BlockS-', num2str(j), '/BL_2/My_Structure/25/FOURIER'];
        my_folder_1 = ['/zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_', char(k), '/ANALYSED/BlockS-', num2str(j), '/BL_2/My_Structure/1/FOURIER'];

        cd(my_folder_1)
        load Coefficients_NU        
%         load Coefficients_NU
        cd ..
%         load Coefficients_noabs
        my_neurons = size(my_fft_coefficients_NU,2);
        wii = my_fft_coefficients_NU;
%         my_neurons = size(my_fft_coefficients_noabs,2);
%         wii = my_fft_coefficients_noabs;


%         files = dir(fullfile('*.mat'));
%         neuronS = (numel(files))/2;

        for nn = 1:my_neurons
            conta1 = conta1+1;
            conta2 = 0;
            
            load(['PSTH_RASTER_', num2str(nn),'.mat'])
            
            for ob = objectS
                conta2 = conta2+1;
                conta3 = 0;
            
                    for bb = Bcodes_fast_gr      %my_bcodes  
             
                        conta3 = conta3+1;
                                      
                            if ob == 111
                                F1{conta1,conta3}(conta2) = my_fft_coefficients_NU{bb,nn}(1);                            
                            elseif ob == 222                                
                                F1{conta1,conta3}(conta2) = my_fft_coefficients_NU{bb,nn}(2);                                 
                            elseif ob == 333
                                F1{conta1,conta3}(conta2) = my_fft_coefficients_NU{bb,nn}(4); 
                            else
                                F1{conta1,conta3}(conta2) = my_fft_coefficients_NU{bb,nn}(16); 
                            end
                            
                            F0{conta1,conta3}(conta2) = my_F0s_NU{bb,nn};
                            Fmax{conta1,conta3}(conta2) = max(my_fft_coefficients_NU{bb,nn});
                            Fmean{conta1,conta3}(conta2) = mean(my_fft_coefficients_NU{bb,nn});
                            Fstd{conta1,conta3}(conta2) = std(my_fft_coefficients_NU{bb,nn});

%             
                    end
                    
                    bb
                    
            end
            
            ob
            
            clear PsthAndRaster STIM_START STIM_STOP
            
        end
        
        nn
        clear Coefficients my_neurons
%         clear Coefficients_noabs my_neurons 
        
    end
    
    j
    
    
end

k

% save(['/zocconasphys1/chronic_inv_rec/Tanks/AREAS/Coefficients_Ratio_noabs.mat'], 'F0_noabs', 'F1_noabs', '-v7.3') %'LMFR', 'LIFR', 'LLFR', 'LLbFR', '-v7.3')
save(['/zocconasphys1/chronic_inv_rec/Tanks/AREAS/Coefficients_Ratio.mat'], 'F0', 'Fbg', 'F1', 'Fmax', 'Fmean', 'Fstd', '-v7.3') %'LMFR', 'LIFR', 'LLFR', 'LLbFR', '-v7.3')

