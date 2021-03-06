function My_PSTH_Movies_FEDE_BlankTest %(BIT_Number)

%load Fede_STIM.mat

clear all
close all
clc

cd /zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_18_3_2013/ANALYSED/BlockS-67/ReceptiveFieldAnalysis/BL_1/PSTH/25

mkdir ('Results_Movies_TEST');



        % bb = 1:length(PSTH{BIT_Number}(1,1,:));    % bb = bin number;
        % tr = 1:length(Trial_Spike_Num{1,1})        % tr = trial number;
        % nn = 1:length(PSTH{BIT_Number}(1,:,1));    % nn = neuron number;

%COLORSET=varycolor(length(Fede_STIM));



for nn = 1:8 %40
    countolo = 0;
    
    B_movies_All = [];
    B_movies_Blanks_All = [];

    % Blanks
    
    for BIT_Number = 3:4  
        load([num2str(BIT_Number),'.mat'])
        
        bn = 1:length(PSTH{BIT_Number}(1,1,:)); 
        tri = 1:length(Trial_Spike_Num{1,1});
        B_movies_Blanks = zeros(tri,bn); 

%         COLORSET=varycolor(length(PSTH{BIT_Number}(1,:,1)));
        
        
        %% n.b. for the first session (19_12_12) some bitcodes were overwritten (137:156). 
            % such overwriting made possible the computation of only 156 codes (instead
            % of 174) for this session. codes from 137 (included) to 156 were therefore
            % excluded from this analysis

                
            %% to get the pres_time in that condition

            a = Trial_Spike_Num{nn,BIT_Number}(1);
            stim_pres_time = (STIM_STOP(a)-STIM_START(a))*1000;
            
            % %% Uncomment for test hist
            % if STIM_STOP(1) > STIM_START(1)
            % stim_pres_times = abs(STIM_START - STIM_STOP);
            % end
            % figure;
            % hist (stim_pres_times)
            
            if stim_pres_time >= 1000
            countolo = countolo+1;
                     for bb=1:length(PSTH{BIT_Number}(1,1,:));    
                        for tr=1:numel(Trial_Spike_Num{nn,BIT_Number})
                        B_movies_Blanks(tr,bb)=PSTH{BIT_Number}(Trial_Spike_Num{nn,BIT_Number}(tr),nn,bb);
                        end
                     end
                 
                c = mean(B_movies_Blanks);
                d = c*(1000/25);
                B_movies_Blanks_All = vertcat(B_movies_Blanks_All, d);
                
                
            end
    end
    
    %%
   
   
   lulu = [1:2, 5:270];
%    lulu2=[1:255, 512:520];
          
    for BIT_Number = lulu
        load([num2str(BIT_Number),'.mat'])
        bn = 1:length(PSTH{BIT_Number}(1,1,:)); 
        tri = 1:length(Trial_Spike_Num{1,1}); 
        B_movies = zeros(tri,bn); 

        COLORSET=varycolor(length(PSTH{BIT_Number}(1,:,1)));
        
        % n.b. for the first session (19_12_12) some bitcodes were overwritten (137:156). 
%             such overwriting made possible the computation of only 156 codes (instead
%             of 174) for this session. codes from 137 (included) to 156 were therefore
%             excluded from this analysis

                
            %% to get the pres_time in that condition
            a = Trial_Spike_Num{nn,BIT_Number}(1);
            stim_pres_time = (STIM_STOP(a)-STIM_START(a))*1000;
            
            % %% Uncomment for test hist
%             if STIM_STOP(1) > STIM_START(1)
%             stim_pres_times = abs(STIM_START - STIM_STOP);
%             stim_pres_all = [stim_pres_all, stim_pres_times];
%             end
%             figure;
%             hist (stim_pres_all, 50)
            
            if stim_pres_time >= 1000  
            countolo = countolo+1;
                    for bb=1:length(PSTH{BIT_Number}(1,1,:));                      
                        for tr=1:numel(Trial_Spike_Num{nn,BIT_Number})
                        B_movies(tr,bb)=PSTH{BIT_Number}(Trial_Spike_Num{nn,BIT_Number}(tr),nn,bb);
                        end
                    end
            
                figure(nn)                
                alla = mean(B_movies);
                b = alla*(1000/25);
                B_movies_All = vertcat(B_movies_All, b);
                T=linspace(-200,2200,length(PSTH{BIT_Number}(1,1,:)));
                plot(T,b, 'Color', COLORSET(nn,:))
                title(['All Moving Conditions, n= ', num2str(countolo)]) 
                xlabel(['Neuron', num2str(nn)])
                axis tight
                %xlim([-200 stim_pres_time+200])
                ylim([-20 300])
                hold on;
                
            end
            
            
            
    end
     
    
           
           T=linspace(-200,2200,length(PSTH{BIT_Number}(1,1,:)));
           %[int tm]=min(abs(T-700));
%            bubu = mean(B_Movies_All,1);
           bubublank = mean(B_movies_Blanks_All,1);
           
           grey=[0.5, 0.5, 0.5];
%            plot(T,bubu, '-k', 'LineWidth',3, 'Color', grey)
%            hold on;
           plot(T,bubublank, '-k', 'LineWidth',3, 'Color', grey)
           
    ww = cd;
    saveas(figure(nn),[ww,'/Results_Movies_TEST/PSTH_',num2str(nn),'.jpeg']) 
    saveas(figure(nn),[ww,'/Results_Movies_TEST/PSTH_',num2str(nn),'.fig'])  
    
    close all
    
    clear B_movies B_movies_All B_movies_Blanks B_movies_Blanks_All
    
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

