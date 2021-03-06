% load Fede_STIM.mat

cd /zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_18_3_2013/ANALYSED/Block-7/PSTH/25

mkdir ('Results_Static');

close all

        % bb = 1:length(PSTH{BIT_Number}(1,1,:));    % bb = bin number;
        % tr = 1:length(Trial_Spike_Num{1,1})        % tr = trial number;
        % nn = 1:length(PSTH{BIT_Number}(1,:,1));    % nn = neuron number;

%COLORSET=varycolor(length(Fede_STIM));


for nn = 1:37
    countolo = 0;
    B_static_All = [];
    for BIT_Number = 1:270
        load([num2str(BIT_Number),'.mat'])
        
        COLORSET=varycolor(length(PSTH{BIT_Number}(1,:,1)));
        
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
            
            if stim_pres_time <= 1000 
            
            countolo = countolo+1;

                for bb=1:length(PSTH{BIT_Number}(1,1,:));   
                    for tr=1:numel(Trial_Spike_Num{nn,BIT_Number})
                    B_static(tr,bb)=PSTH{BIT_Number}(Trial_Spike_Num{nn,BIT_Number}(tr),nn,bb); 
                    end
                end
                
                figure(nn)                
                a = mean(B_static);
                b = a*(1000/25);
                B_static_All = vertcat(B_static_All, b);
                T=linspace(-100,2100,length(PSTH{BIT_Number}(1,1,:)));
                [int tm]=min(abs(T-700));
                plot(T(1:tm),b(1:tm), 'Color', COLORSET(nn,:))
                title(['All Static Conditions, n= ', num2str(countolo)])
                xlabel(['Neuron', num2str(nn)])
                axis tight
                %xlim([-200 stim_pres_time+200])
                ylim([0 100])
                hold on;
                 
            end
           
            
    end
    
           T=linspace(-100,2100,length(PSTH{BIT_Number}(1,1,:)));
           [int tm]=min(abs(T-700));
           bubu = mean(B_static_All,1);
           grey=[0.5, 0.5, 0.5];
           plot(T(1:tm),bubu(1:tm), 'LineWidth',3, 'Color', grey)
    
            ww = cd;
            saveas(figure(nn),[ww,'/Results_Static/PSTH_',num2str(nn),'.jpeg']) 
            saveas(figure(nn),[ww,'/Results_Static/PSTH_',num2str(nn),'.fig'])  
    
            close all
    
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