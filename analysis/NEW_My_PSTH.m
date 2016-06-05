function NEW_My_PSTH 

%load Fede_STIM.mat

clear all
close all
clc

cd /zocconasphys1/chronic_inv_rec/Tanks/Giulio_Acute_Recording_2015_05_18/BlockS-34/BL_1/My_Structure/25


files = dir(fullfile('*.mat'));
neuronS = (numel(files))/2;

mkdir ('PSTHS');


COLORSET=varycolor(neuronS);

for nn = 1:neuronS
    countolo = 0;
    countolo1 = 0;
    countolo2 = 0;
    
        
    load(['PSTH_RASTER_', num2str(nn),'.mat'])
    load(['NEURON_', num2str(nn),'.mat'])
    
    cucu = My_Neurons.MeanFiringRate;
    MFR = cucu*(1000/25);
%     bitcodes = PsthAndRaster.BitCodes;
    
    B_checker = [];
    B_checker_All = [];
    B_flash = [];
    B_flash_All = [];
    B_gratings = [];
    B_gratings_All = [];
    % Blanks
    
   for BIT_Number = 1:bitcodes 
     
            %% to get the pres_time in that condition

            a = PsthAndRaster.Trials{BIT_Number,nn}(1);
            stim_pres_time = (STIM_STOP(a)-STIM_START(a))*1000;
   
            
            if stim_pres_time < 500 %flash
            countolo = countolo+1;
            
                    ps=PsthAndRaster.Psth{BIT_Number,nn};
%                     trr=PsthAndRaster.Trials{BIT_Number,nn};
%                     B_flash=ps(trr,:);
                    B_flash=ps;

                c = mean(B_flash);
                d = c*(1000/25);
                B_flash_All = vertcat(B_flash_All, d);
                               
                              
            end

            if stim_pres_time >= 2000 %checkerboard
            countolo1 = countolo1+1;
            
                    ps2=PsthAndRaster.Psth{BIT_Number,nn};
%                     trr=PsthAndRaster.Trials{BIT_Number,nn};
%                     B_checker=ps(trr,:);
                    B_checker=ps2;

                c2 = mean(B_checker);
                d2 = c2*(1000/25);
                B_checker_All = vertcat(B_checker_All, d2);
                
                
            end

            
            if stim_pres_time > 500 && stim_pres_time < 2000 % gratings 1 sec                
            countolo2 = countolo2+1;
            T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));%-200,2200,
            [int tm]=min(abs(T-1200));

            ps3=PsthAndRaster.Psth{BIT_Number,nn};
%             trr2=PsthAndRaster.Trials{BIT_Number,nn};
%             B_gratings=ps2(trr2,:);
            B_gratings=ps3;
            
                figure(nn)                
                alla = mean(B_gratings);
                b = alla*(1000/25);

                B_gratings_All = vertcat(B_gratings_All, b);
                
               
%                 B_gratings_All = vertcat(B_gratings_All, b);  
%                 plot(T(1:tm),b(1:tm), 'Color', COLORSET(nn,:))
                plot(T(1:tm),b(1:tm), 'Color', COLORSET(nn,:))
                title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', All Gratings, n= ', num2str(countolo2), '/', num2str(51)]) 
                xlabel(['Area ', char(My_Neurons.Area)])
                axis tight
                hold on;
                
            end
            
            
            
    end
  
%       uuu = mean(B_fastmovies_All)
           T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));%-200,2200,
           
           [int1 tm2]=min(abs(T-2150));
           bubublank = mean(B_flash_All,1);
           bubublank2 = mean(B_checker_All,1);
           grey=[0.5, 0.5, 0.5];
           plot(T(1:tm2),bubublank(1:tm2), '-k', 'LineWidth',2, 'Color', grey)
           hold on;
           grey2=[0.65, 0.65, 0.65];
           plot(T,bubublank2, '-k', 'LineWidth',2, 'Color', grey2)
%            
    ww = cd;
    saveas(figure(nn),[ww,'/PSTH_',num2str(nn),'.jpeg']) 
    saveas(figure(nn),[ww,'/PSTH_',num2str(nn),'.fig'])  
    
    close all
    
    clear B_flash B_flash_All B_checker B_checker_All B_gratings B_gratings_All cucu MFR
    

    
end

            

                

cd ..

cd ..

cd ..

