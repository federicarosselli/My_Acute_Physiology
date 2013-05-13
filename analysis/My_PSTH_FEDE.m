function My_PSTH_FEDE %(BIT_Number)

%load Fede_STIM.mat

cd /zocconasphys1/chronic_inv_rec/Tanks/Fede_AcuteTest_19_12_12/ANALYSED/Block-1/PSTH/25


for BIT_Number = 1:270
    load([num2str(BIT_Number),'.mat'])
    COLORSET=varycolor(length(PSTH{BIT_Number}(1,:,1)));
    figure;

        %% n.b. for the first session (19_12_12) some bitcodes were overwritten (137:156). 
        % such overwriting made possible the computation of only 156 codes (instead
        % of 174) for this session. codes from 137 (included) to 156 were therefore
        % excluded from this analysis


        % bb = 1:length(PSTH{BIT_Number}(1,1,:));    % bb = bin number;
        % tr = 1:length(Trial_Spike_Num{1,1})        % tr = trial number;
        % nn = 1:length(PSTH{BIT_Number}(1,:,1));    % nn = neuron number;


        % %% Uncomment for test hist
        % if STIM_STOP(1) > STIM_START(1)
        % stim_pres_times = abs(STIM_START - STIM_STOP);
        % end
        % figure;
        % hist (stim_pres_times)

        %% to get the pres_time in that condition

        a = Trial_Spike_Num{1,BIT_Number}(1);
        stim_pres_time = (STIM_STOP(a)-STIM_START(a))*1000


        for nn = 1:37      
        % for nn = 1:length(PSTH{BIT_Number}(1,:,1));      
            for bb=1:length(PSTH{BIT_Number}(1,1,:));   
                for tr=1:numel(Trial_Spike_Num{nn,BIT_Number})
                B(tr,bb)=PSTH{BIT_Number}(Trial_Spike_Num{nn,BIT_Number}(tr),nn,bb);
                end
            end

                % % Uncomment Each Neurons for that Conndition
                % T=linspace(-200,2200,length(PSTH{BIT_Number}(1,1,:)));
                % figure;
                % plot(T,mean(B), 'Color', COLORSET(nn,:))
                % title(['Condition Number ', num2str(BIT_Number)])
                % xlabel(['Neuron', num2str(nn)])
                % axis tight

                %% Uncomment for All Neurons for that Condition
                T=linspace(-100,stim_pres_time+100,length(PSTH{BIT_Number}(1,1,:)));
                plot(T,mean(B), 'Color', COLORSET(nn,:))
                title(['Condition Number ', num2str(BIT_Number)])
                xlabel(['AllNeurons, n=', num2str(nn)])
                axis tight
                hold on;

        end

end

cd ..

cd ..

cd ..




