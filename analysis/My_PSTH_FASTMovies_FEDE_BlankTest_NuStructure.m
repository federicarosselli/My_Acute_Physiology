function My_PSTH_FASTMovies_FEDE_BlankTest_NuStructure 

%load Fede_STIM.mat

clear all
close all
clc

% cd /zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_18_3_2013/ANALYSED/BlockS-67/TEST/BL_2/My_Structure/25
% cd /zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_18_3_2013/ANALYSED/BlockS-67/BL_2/My_Structure/STEST/25
% cd /zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_15_8_2013/ANALYSED/Block-2/My_Structure/25

cd /zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_05_07_2013/ANALYSED/BlockS-56/BL_2/My_Structure/25

%% note: 29_5_2013: no conditions 35 and 36 were presented for this session

files = dir(fullfile('*.mat'));
neuronS = (numel(files))/2;

mkdir ('PSTHS_FASTMovies');

        % bb = 1:size(PsthAndRaster.Psth{BIT_Number,nn},2);   % bb = bin number;
        % tr = 1:length(Trials{1,1})        % tr = trial number;
      

%COLORSET=varycolor(length(Fede_STIM));


COLORSET=varycolor(neuronS);

for nn = 1:neuronS
    countolo = 0;
    
        
    load(['PSTH_RASTER_', num2str(nn),'.mat'])
    load(['NEURON_', num2str(nn),'.mat'])
    
    cucu = My_Neurons.MeanFiringRate;
    MFR = cucu*(1000/25);
    bitcodes = PsthAndRaster.BitCodes;
    
    B_fastmovies = [];
    B_fastmovies_All = [];
    B_fastmovies_Blanks = [];
    B_fastmovies_Blanks_All = [];
    B_fastmovies_WBlanks = [];
    B_fastmovies_WBlanks_All = [];
    % Blanks
    
   for BIT_Number = 1:3 %bitcodes for white blanks %1:2 old experiment
        
        
        
        %% n.b. for the first session (19_12_12) some bitcodes were overwritten (137:156). 
            % such overwriting made possible the computation of only 156 codes (instead
            % of 174) for this session. codes from 137 (included) to 156 were therefore
            % excluded from this analysis

                
            %% to get the pres_time in that condition

            a = PsthAndRaster.Trials{BIT_Number,nn}(1);
            stim_pres_time = (STIM_STOP(a)-STIM_START(a))*1000;
            
            % %% Uncomment for test hist
            % if STIM_STOP(1) > STIM_START(1)
            % stim_pres_times = abs(STIM_START - STIM_STOP);
            % end
            % figure;
            % hist (stim_pres_times)
            
            if stim_pres_time > 500 && stim_pres_time < 1000
            countolo = countolo+1;
%                      for bb=1:size(PsthAndRaster.Psth{BIT_Number,nn},2);
%                         if numel(PsthAndRaster.Psth{BIT_Number,nn})~=0
%                         for tr=1:numel(PsthAndRaster.Trials{BIT_Number,nn})
%                         B_movies_Blanks(tr,bb)=PsthAndRaster.Psth{BIT_Number,nn}(PsthAndRaster.Trials{BIT_Number,nn}(tr),bb);
%                         end
%                         end
%                      end
                    ps=PsthAndRaster.Psth{BIT_Number,nn};
                    trr=PsthAndRaster.Trials{BIT_Number,nn};
                    B_fastmovies_WBlanks=ps(trr,:);

                c = mean(B_fastmovies_WBlanks);
                d = c*(1000/25);
                
                B_fastmovies_WBlanks_All = vertcat(B_fastmovies_WBlanks_All, d);
                
                
            end
    end 
    
    for BIT_Number = 4:6 %bitcodes for black blanks %3:4 old experiment
        
        
        
        %% n.b. for the first session (19_12_12) some bitcodes were overwritten (137:156). 
            % such overwriting made possible the computation of only 156 codes (instead
            % of 174) for this session. codes from 137 (included) to 156 were therefore
            % excluded from this analysis

                
            %% to get the pres_time in that condition

            a = PsthAndRaster.Trials{BIT_Number,nn}(1);
            stim_pres_time = (STIM_STOP(a)-STIM_START(a))*1000;
            
            %% Uncomment for test hist
%             if STIM_STOP(1) > STIM_START(1)
%             stim_pres_times = abs(STIM_START - STIM_STOP);
%             end
%             figure;
%             hist (stim_pres_times)
            
            if stim_pres_time > 500 && stim_pres_time < 1000
            countolo = countolo+1;
%                      for bb=1:size(PsthAndRaster.Psth{BIT_Number,nn},2);
%                         if numel(PsthAndRaster.Psth{BIT_Number,nn})~=0
%                         for tr=1:numel(PsthAndRaster.Trials{BIT_Number,nn})
%                         B_movies_Blanks(tr,bb)=PsthAndRaster.Psth{BIT_Number,nn}(PsthAndRaster.Trials{BIT_Number,nn}(tr),bb);
%                         end
%                         end
%                      end
                    ps=PsthAndRaster.Psth{BIT_Number,nn};
                    trr=PsthAndRaster.Trials{BIT_Number,nn};
                    B_fastmovies_Blanks=ps(trr,:);

                c = mean(B_fastmovies_Blanks);
                d = c*(1000/25);
                B_fastmovies_Blanks_All = vertcat(B_fastmovies_Blanks_All, d);
                
                
            end
    end
    
    
    lulu = [7:bitcodes];

%     lulu_29_5_2013=[5:34, 37:bitcodes];
% lulu_15_7_2013 = [7:166, 168, 170, 172, 174, 176, 178,];  %% note: no
% slow movies for gratings n dots for this session
                
    for BIT_Number = lulu %lulu_29_5_2013
        
        %% n.b. for the first session (19_12_12) some bitcodes were overwritten (137:156). 
            % such overwriting made possible the computation of only 156 codes (instead
            % of 174) for this session. codes from 137 (included) to 156 were therefore
            % excluded from this analysis

                
            %% to get the pres_time in that condition
            a = PsthAndRaster.Trials{BIT_Number,nn}(1);
            stim_pres_time = (STIM_STOP(a)-STIM_START(a))*1000;
            
            % %% Uncomment for test hist
%             if STIM_STOP(1) > STIM_START(1)
%             stim_pres_times = abs(STIM_START - STIM_STOP);
%             stim_pres_all = [stim_pres_all, stim_pres_times];
%             end
%             figure;
%             hist (stim_pres_all, 50)
            
            if stim_pres_time > 500 && stim_pres_time < 1000
            countolo = countolo+1;
%                     for bb=1:size(PsthAndRaster.Psth{BIT_Number,nn},2);  
%                         if numel(PsthAndRaster.Psth{BIT_Number,nn})~=0
%                         for tr=1:numel(PsthAndRaster.Trials{BIT_Number,nn})         
%                         B_movies(tr,bb)=PsthAndRaster.Psth{BIT_Number,nn}(PsthAndRaster.Trials{BIT_Number,nn}(tr),bb);
%                         end
%                         end
%                     end
            ps2=PsthAndRaster.Psth{BIT_Number,nn};
            trr2=PsthAndRaster.Trials{BIT_Number,nn};
            B_fastmovies=ps2(trr2,:);
            
                figure(nn)                
                alla = mean(B_fastmovies);
                b = alla*(1000/25);
               
                B_fastmovies_All = vertcat(B_fastmovies_All, b);
                T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
                [int tm]=min(abs(T-1000));
                plot(T(1:tm),b(1:tm), 'Color', COLORSET(nn,:))
%                 plot(T,b, 'Color', COLORSET(nn,:))
                title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', All FAST Moving Conditions, n= ', num2str(countolo), '/', num2str(PsthAndRaster.BitCodes)]) 
                xlabel(['Area ', char(My_Neurons.Area)])
                axis tight
                %xlim([-200 stim_pres_time+200])
%                 ylim([-20 300])
                hold on;
                
            end
            
            
            
    end
  
      uuu = mean(B_fastmovies_All)
      
           T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
           [int tm]=min(abs(T-1000));
%            bubu = mean(B_Movies_All,1);
           bubublank = mean(B_fastmovies_Blanks_All,1);
           bubublank2 = mean(B_fastmovies_WBlanks_All,1);
           grey=[0.5, 0.5, 0.5];
           plot(T(1:tm),bubublank(1:tm), '-k', 'LineWidth',2, 'Color', grey)
           hold on;
           grey2=[0.65, 0.65, 0.65];
           plot(T(1:tm),bubublank2(1:tm), '-k', 'LineWidth',2, 'Color', grey2)
%            
    ww = cd;
    saveas(figure(nn),[ww,'/PSTHS_FASTMovies/PSTH_',num2str(nn),'.jpeg']) 
    saveas(figure(nn),[ww,'/PSTHS_FASTMovies/PSTH_',num2str(nn),'.fig'])  
    
    close all
    
    clear B_fastmovies B_fastmovies_All B_fastmovies_Blanks B_fastmovies_Blanks_All cucu MFR
    
    
% Uncomment for Each Neuron for that Condition
% for z = 1:length(B_Static_All);
    
% end
  

% %% Uncomment for All Neurons for that Condition
% T=linspace(-200,stim_pres_time+200,length(PSTH{BIT_Number}(1,1,:)));
% alla = mean(B);
% plot(T,mean(B), 'Color', COLORSET(nn,:))
% title(['Condition Number ', num2str(BIT_Number)])
% xlabel(['AllNeurons, n=', num2str(nn)])
% %set (gca, 'ylim', [0 1000])
% axis tight
% hold on; 
    
end

            

                

cd ..

cd ..

cd ..

