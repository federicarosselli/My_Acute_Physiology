 function My_Raster_NEW (DayOfRecording, Block, object)

% DayOfRecording = '2_7_2013'
% 
% Block = 12

% object = 0 %(bblank)
% object = 9 %(wblank)
% object = -1 %(bar)
% object = 1 %(ent)
% object = 2 %(bun)
% object = 3 %(orca)
% object = 4 %(pingu)
% object = 111 %(0.03 grating)
% object = 222 %(0.05 grating)
% object = 333 %(0.1 grating)
% object = 444 %(0.4 grating)
% object = 11 (dots pattern 1)
% object = 22 (dots pattern 2)


my_folder = ['/zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_', char(DayOfRecording), '/ANALYSED/BlockS-', num2str(Block), '/BL_2/My_Structure/25'];
% my_folder = ['/zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_', , char(DayOfRecording), '/ANALYSED/Block-' , num2str(Block), '/My_Structure/25'];

addpath /zocconasphys1/chronic_inv_rec/codes/
load My_StimS_NUANGLE_NUCONDITIONS

% Cool_Psths
% neuronS = BlockS_67;   %%% >>>>>>> optimize!!!


cd (my_folder)

files = dir(fullfile('*.mat'));
neuronS = (numel(files))/2;

COLORSET=varycolor(neuronS);
% all_peaks = cell(zeros());
% all_time_series = cell(zeros());

for nn = 1:neuronS
    countolo=0;
        
    load(['PSTH_RASTER_', num2str(nn),'.mat'])
    load(['NEURON_', num2str(nn),'.mat'])
%     bitcodes = PsthAndRaster.BitCodes;
    bin=PsthAndRaster.BinSize; 
    
    ww = cd;
    

    
    %%%% Black BLANKS
    %%%%%%%%%%%%%%%%
    
        if object == 0
        
        stringBB=strcat('RASTERS/', num2str(nn), '/BBlanks/');
        mkdir(stringBB);
        [a z]=ind2sub(size(Fede_STIM_NU), find(Fede_STIM_NU(1:342,2)==0));
        selected_bits = a';
        
            for BIT_Number = selected_bits

            a = PsthAndRaster.Trials{BIT_Number,nn}(1);
            stim_pres_time = (STIM_STOP(a)-STIM_START(a))*1000;
            
            if stim_pres_time > 500 && stim_pres_time < 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                ps=PsthAndRaster.Psth{BIT_Number,nn};
                trr=PsthAndRaster.Trials{BIT_Number,nn};
                M=ps(trr,:);
                M_PSTH{BIT_Number,nn}=mean(M);
                S_PSTH{BIT_Number,nn}=std(M)/sqrt(size(M,1));
                T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
                [int tm]=min(abs(T-1000));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)

                    subplot(2,1,2)
                    b = M_PSTH{BIT_Number,nn}*(1000/25);
                    Tlin = T(1:tm);
                    blin = b(1:tm);
                    maxb = max(blin);
                    % % all_peaks{BIT_Number, nn}=maxb;
                    % all_time_series{BIT_Number, nn}=b;
                    %aku = find(blin==maxb);
                    aku = find(blin==maxb);
                    plot(Tlin, blin,'Color', COLORSET(nn,:), 'linewidth',1)  
                    text(Tlin(aku(1)), maxb, num2str(maxb));  
                    xlim([-200 1000])
                    subplot(2,1,1)
                    plot(PsthAndRaster.MySpikes{BIT_Number,trl}*1000-PRE_TIME*1000,ones(size(PsthAndRaster.MySpikes{BIT_Number,trl}),1)*trl,'.', 'Color', COLORSET(nn,:))
                    xlim([-200 1000])
                    [BIT_Number nn trl]
                    hold on
                    line([0 0], [0 trl], 'Color', 'k','linewidth',2);
                    hold on
                    line([800 800], [0 trl], 'Color', 'k','linewidth',2);
                    xlim([-200 1000])
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);
                    xlabel(['Fast BBlank ', ', BitCode ', num2str(BIT_Number)]);

                    end

            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/BBlanks/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/BBlanks/R_',num2str(BIT_Number),'.fig'])   
            
            close
            
            end
            
                
            if stim_pres_time > 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                ps=PsthAndRaster.Psth{BIT_Number,nn};
                trr=PsthAndRaster.Trials{BIT_Number,nn};
                M=ps(trr,:);
                M_PSTH{BIT_Number,nn}=mean(M);
                S_PSTH{BIT_Number,nn}=std(M)/sqrt(size(M,1));
                T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
                
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)
                    
                    subplot(2,1,2)
                    b = M_PSTH{BIT_Number,nn}*(1000/25);
                    maxb = max(b);
                    % all_peaks{BIT_Number, nn}=maxb;
                    % all_time_series{BIT_Number, nn}=b;
%                     aku = {max(b)}
                    aku = find(b==maxb);
                    plot(T, b,'Color', COLORSET(nn,:), 'linewidth',1)  
                    text(T(aku(1)), maxb, num2str(maxb));  
                    xlim([-200 2200])
                    subplot(2,1,1)
                    plot(PsthAndRaster.MySpikes{BIT_Number,trl}*1000-PRE_TIME*1000,ones(size(PsthAndRaster.MySpikes{BIT_Number,trl}),1)*trl,'.', 'Color', COLORSET(nn,:))
                    xlim([-200 2200])
                    [BIT_Number nn trl]
                    hold on
                    line([0 0], [0 trl], 'Color', 'k','linewidth',2);
                    hold on
                    line([2000 2000], [0 trl], 'Color', 'k','linewidth',2);
                    xlim([-200 2200])
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);
                    xlabel(['Slow BBlank ', ', BitCode ', num2str(BIT_Number)]);

                    end

            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/BBlanks/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/BBlanks/R_',num2str(BIT_Number),'.fig'])   
            close
            
            end
            
            if stim_pres_time < 500
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};
                
            ps=PsthAndRaster.Psth{BIT_Number,nn};
            trr=PsthAndRaster.Trials{BIT_Number,nn};
            M=ps(trr,:);
            M_PSTH{BIT_Number,nn}=mean(M);
            S_PSTH{BIT_Number,nn}=std(M)/sqrt(size(M,1));
            T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));             
            [int tm]=min(abs(T-450));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)

                    subplot(2,1,2)
                    b = M_PSTH{BIT_Number,nn}*(1000/25);
                    Tlin = T(1:tm);
                    blin = b(1:tm);
                    maxb = max(blin);
                    % all_peaks{BIT_Number, nn}=maxb;
                    % all_time_series{BIT_Number, nn}=b;
%                     aku = {max(blin)}
                    aku = find(blin==maxb);
                    plot(Tlin, blin,'Color', COLORSET(nn,:), 'linewidth',1)  
                    text(Tlin(aku(1)), maxb, num2str(maxb));  
                    xlim([-200 450])
                    subplot(2,1,1)
                    plot(PsthAndRaster.MySpikes{BIT_Number,trl}*1000-PRE_TIME*1000,ones(size(PsthAndRaster.MySpikes{BIT_Number,trl}),1)*trl,'.', 'Color', COLORSET(nn,:))
                    xlim([-200 450])
                    [BIT_Number nn trl]
                    hold on
                    line([0 0],[0 trl], 'Color', 'k','linewidth',2)
                    hold on
                    line([250 250], [0 trl], 'Color', 'k','linewidth',2);
                    xlim([-200 450])
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);
                    xlabel(['Static BBlank ', ', BitCode ', num2str(BIT_Number)]);

                    end


            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/BBlanks/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/BBlanks/R_',num2str(BIT_Number),'.fig'])   
            close
            
            end
            
            end
            
            
    %%%% White BLANKS
    %%%%%%%%%%%%%%%%
    
        elseif object == 9
         
        
        stringWB=strcat('RASTERS/', num2str(nn), '/WBlanks/');
        mkdir(stringWB);
        [a z]=ind2sub(size(Fede_STIM_NU), find(Fede_STIM_NU(1:342,2)==9));
        selected_bits = a';
        
            for BIT_Number = selected_bits

            a = PsthAndRaster.Trials{BIT_Number,nn}(1);
            stim_pres_time = (STIM_STOP(a)-STIM_START(a))*1000;
            
            if stim_pres_time > 500 && stim_pres_time < 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                ps=PsthAndRaster.Psth{BIT_Number,nn};
                trr=PsthAndRaster.Trials{BIT_Number,nn};
                M=ps(trr,:);
                M_PSTH{BIT_Number,nn}=mean(M);
                S_PSTH{BIT_Number,nn}=std(M)/sqrt(size(M,1));
                T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
                [int tm]=min(abs(T-1000));
                
                    for trl=1:size(PsthAndRaster.MySpikes, 2)
                  
                    subplot(2,1,2)
                    b = M_PSTH{BIT_Number,nn}*(1000/25);
                    Tlin = T(1:tm);
                    blin = b(1:tm);
                    maxb = max(blin);
                    % all_peaks{BIT_Number, nn}=maxb;
                    % all_time_series{BIT_Number, nn}=b;
                    aku = find(blin==maxb);
                    plot(Tlin, blin,'Color', COLORSET(nn,:), 'linewidth',1)  
                    text(Tlin(aku(1)), maxb, num2str(maxb));    
                    xlim([-200 1000])
                    subplot(2,1,1)
                    plot(PsthAndRaster.MySpikes{BIT_Number,trl}*1000-PRE_TIME*1000,ones(size(PsthAndRaster.MySpikes{BIT_Number,trl}),1)*trl,'.', 'Color', COLORSET(nn,:))
                    xlim([-200 1000])
                    [BIT_Number nn trl]
                    hold on
                    line([0 0], [0 trl], 'Color', 'k','linewidth',2);
                    hold on
                    line([800 800], [0 trl], 'Color', 'k','linewidth',2);
                    xlim([-200 1000])
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);
                    xlabel(['Fast WBlank ', ', BitCode ', num2str(BIT_Number)]);

                    end


            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/WBlanks/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/WBlanks/R_',num2str(BIT_Number),'.fig'])   
            close
            
            end
            
            
            if stim_pres_time > 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                ps=PsthAndRaster.Psth{BIT_Number,nn};
                trr=PsthAndRaster.Trials{BIT_Number,nn};
                M=ps(trr,:);
                M_PSTH{BIT_Number,nn}=mean(M);
                S_PSTH{BIT_Number,nn}=std(M)/sqrt(size(M,1));
                T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)
                    
                    subplot(2,1,2)
                    b = M_PSTH{BIT_Number,nn}*(1000/25);
                    maxb = max(b);
                    % all_peaks{BIT_Number, nn}=maxb;
                    % all_time_series{BIT_Number, nn}=b;
                    aku = find(b==maxb);
                    plot(T,b,'Color', COLORSET(nn,:), 'linewidth',1) 
                    text(T(aku(1)), maxb, num2str(maxb));  
                    xlim([-200 2200])
                    subplot(2,1,1)
                    plot(PsthAndRaster.MySpikes{BIT_Number,trl}*1000-PRE_TIME*1000,ones(size(PsthAndRaster.MySpikes{BIT_Number,trl}),1)*trl,'.', 'Color', COLORSET(nn,:))
                    xlim([-200 2200])
                    [BIT_Number nn trl]
                    hold on
                    line([0 0], [0 trl], 'Color', 'k','linewidth',2);
                    hold on
                    line([2000 2000], [0 trl], 'Color', 'k','linewidth',2);
                    xlim([-200 2200])
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);
                    xlabel(['Slow WBlank ', ', BitCode ', num2str(BIT_Number)]);

                    end


            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/WBlanks/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/WBlanks/R_',num2str(BIT_Number),'.fig']) 
            close
            
            end
            
            if stim_pres_time < 500
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};


            ps=PsthAndRaster.Psth{BIT_Number,nn};
            trr=PsthAndRaster.Trials{BIT_Number,nn};
            M=ps(trr,:);
            M_PSTH{BIT_Number,nn}=mean(M);
            S_PSTH{BIT_Number,nn}=std(M)/sqrt(size(M,1));
                
            T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));             
            [int tm]=min(abs(T-450));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)

                    subplot(2,1,2)
                    b = M_PSTH{BIT_Number,nn}*(1000/25);    
                    Tlin = T(1:tm);
                    blin = b(1:tm);
                    maxb = max(blin);
                    % all_peaks{BIT_Number, nn}=maxb;
                    % all_time_series{BIT_Number, nn}=b;
                    aku = find(blin==maxb);
                    plot(Tlin, blin,'Color', COLORSET(nn,:), 'linewidth',1)  
                    text(Tlin(aku(1)), maxb, num2str(maxb));      
                    xlim([-200 450])
                    subplot(2,1,1)
                    plot(PsthAndRaster.MySpikes{BIT_Number,trl}*1000-PRE_TIME*1000,ones(size(PsthAndRaster.MySpikes{BIT_Number,trl}),1)*trl,'.', 'Color', COLORSET(nn,:))
                    xlim([-200 450])
                    [BIT_Number nn trl]
                    hold on
                    line([0 0],[0 trl], 'Color', 'k','linewidth',2)
                    hold on
                    line([250 250], [0 trl], 'Color', 'k','linewidth',2);
                    xlim([-200 450])
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);
                    xlabel(['Static WBlank ', ', BitCode ', num2str(BIT_Number)]);

                    end


            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/WBlanks/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/WBlanks/R_',num2str(BIT_Number),'.fig'])   
            close
            
            end
            
            end
            
            
            
     
    %%%% BARS
    %%%%%%%%%%%%%%%%
    
        elseif object == -1
            
        stringB=strcat('RASTERS/', num2str(nn), '/Bars/');
        mkdir(stringB);
        
        [a z]=ind2sub(size(Fede_STIM_NU), find(Fede_STIM_NU(1:342,2)==-1));
        selected_bits = a';
        
            for BIT_Number = selected_bits;
                
            isz = Fede_STIM_NU(BIT_Number, 3); 
            fsz = Fede_STIM_NU(BIT_Number, 4); 
            iposx = Fede_STIM_NU(BIT_Number, 5); 
            fposx = Fede_STIM_NU(BIT_Number, 6); 
            iposy = Fede_STIM_NU(BIT_Number, 7); 
            fposy = Fede_STIM_NU(BIT_Number, 8); 
            inp = Fede_STIM_NU(BIT_Number, 9); 
            az = Fede_STIM_NU(BIT_Number, 10); 
            ori = Fede_STIM_NU(BIT_Number, 11); 

            a = PsthAndRaster.Trials{BIT_Number,nn}(1);
            stim_pres_time = (STIM_STOP(a)-STIM_START(a))*1000;
            
            if stim_pres_time > 500 && stim_pres_time < 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};
 

            ps=PsthAndRaster.Psth{BIT_Number,nn};
            trr=PsthAndRaster.Trials{BIT_Number,nn};
            M=ps(trr,:);
            M_PSTH{BIT_Number,nn}=mean(M);
            S_PSTH{BIT_Number,nn}=std(M)/sqrt(size(M,1));
            T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
            [int tm]=min(abs(T-1000)); 
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)
                        
                    subplot(2,1,2)
                    b = M_PSTH{BIT_Number,nn}*(1000/25);
                    Tlin = T(1:tm);
                    blin = b(1:tm);
                    maxb = max(blin);
                    % all_peaks{BIT_Number, nn}=maxb;
                    % all_time_series{BIT_Number, nn}=b;
                    aku = find(blin==maxb);
                    plot(Tlin, blin,'Color', COLORSET(nn,:), 'linewidth',1)  
                    text(Tlin(aku(1)), maxb, num2str(maxb));    
                    xlim([-200 1000])  
                    subplot(2,1,1)
                    plot(PsthAndRaster.MySpikes{BIT_Number,trl}*1000-PRE_TIME*1000,ones(size(PsthAndRaster.MySpikes{BIT_Number,trl}),1)*trl,'.', 'Color', COLORSET(nn,:))
                    xlim([-200 1000])
                    [BIT_Number nn trl]
                    hold on
                    line([0 0], [0 trl], 'Color', 'k','linewidth',2);
                    hold on
                    line([800 800], [0 trl], 'Color', 'k','linewidth',2);
                    xlim([-200 1000])
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);
                    
                        if iposx == 15 && iposy == 0 && inp == 0
                        xlabel(['FAST RightLeft Moving Bar ', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -15 && iposy == 0 && inp == 0
                        xlabel(['FAST LeftRight Moving Bar ', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 0 && iposy == 15 && inp == 0
                        xlabel(['FAST UpDown Moving Bar', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 0 && iposy == -15 && inp == 0
                        xlabel(['FAST DownUp Moving Bar', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -10.6 && iposy == -10.6 && inp == 0
                        xlabel(['FAST UpRight Moving Bar', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -10.6 && iposy == 10.6 && inp == 0
                        xlabel(['FAST DownRight Moving Bar', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 10.6 && iposy == -10.6 && inp == 0
                        xlabel(['FAST UpLeft Moving Bar', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 10.6 && iposy == 10.6 && inp == 0  
                        xlabel(['FAST DownLeft Moving Bar', ', BitCode ', num2str(BIT_Number)]);
                        end
                        
                        
                    end


            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/Bars/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/Bars/R_',num2str(BIT_Number),'.fig'])   
            close
            
            end
            
            if stim_pres_time > 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};
 

            ps=PsthAndRaster.Psth{BIT_Number,nn};
            trr=PsthAndRaster.Trials{BIT_Number,nn};
            M=ps(trr,:);
            M_PSTH{BIT_Number,nn}=mean(M);
            S_PSTH{BIT_Number,nn}=std(M)/sqrt(size(M,1));

            
                T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)
                        
                    subplot(2,1,2)
                    b = M_PSTH{BIT_Number,nn}*(1000/25);
                    maxb = max(b);
                    % all_peaks{BIT_Number, nn}=maxb;
                    % all_time_series{BIT_Number, nn}=b;
                    aku = find(b==maxb);
                    plot(T,b,'Color', COLORSET(nn,:), 'linewidth',1)  
                    text(T(aku(1)), maxb, num2str(maxb));    
                    xlim([-200 2200])
                    subplot(2,1,1)
                    plot(PsthAndRaster.MySpikes{BIT_Number,trl}*1000-PRE_TIME*1000,ones(size(PsthAndRaster.MySpikes{BIT_Number,trl}),1)*trl,'.', 'Color', COLORSET(nn,:))
                    xlim([-200 2200])
                    [BIT_Number nn trl]
                    hold on
                    line([0 0], [0 trl], 'Color', 'k','linewidth',2);
                    hold on
                    line([2000 2000], [0 trl], 'Color', 'k','linewidth',2);
                    xlim([-200 2200])
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);
                    
                        if iposx == 15 && iposy == 0 && inp == 0
                        xlabel(['SLOW RightLeft Moving Bar ', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -15 && iposy == 0 && inp == 0
                        xlabel(['SLOW LeftRight Moving Bar ', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 0 && iposy == 15 && inp == 0
                        xlabel(['SLOW UpDown Moving Bar', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 0 && iposy == -15 && inp == 0
                        xlabel(['SLOW DownUp Moving Bar', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -10.6 && iposy == -10.6 && inp == 0
                        xlabel(['SLOW UpRight Moving Bar', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -10.6 && iposy == 10.6 && inp == 0
                        xlabel(['SLOW DownRight Moving Bar', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 10.6 && iposy == -10.6 && inp == 0
                        xlabel(['SLOW UpLeft Moving Bar', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 10.6 && iposy == 10.6 && inp == 0  
                        xlabel(['SLOW DownLeft Moving Bar', ', BitCode ', num2str(BIT_Number)]);
                        end
                        
                        
                    end


            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/Bars/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/Bars/R_',num2str(BIT_Number),'.fig'])  
            close
            
            end
            
            if stim_pres_time < 500
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};
 

            ps=PsthAndRaster.Psth{BIT_Number,nn};
            trr=PsthAndRaster.Trials{BIT_Number,nn};
            M=ps(trr,:);
            M_PSTH{BIT_Number,nn}=mean(M);
            S_PSTH{BIT_Number,nn}=std(M)/sqrt(size(M,1));
            T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2)); %-200,2200,
            [int tm]=min(abs(T-450));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)

                    subplot(2,1,2)
                    b = M_PSTH{BIT_Number,nn}*(1000/25);
                    Tlin = T(1:tm);
                    blin = b(1:tm);
                    maxb = max(blin);
                    % all_peaks{BIT_Number, nn}=maxb;
                    % all_time_series{BIT_Number, nn}=b;
                    aku = find(blin==maxb);
                    plot(Tlin, blin,'Color', COLORSET(nn,:), 'linewidth',1)  
                    text(Tlin(aku(1)), maxb, num2str(maxb));       
                    xlim([-200 450])
                    subplot(2,1,1)
                    plot(PsthAndRaster.MySpikes{BIT_Number,trl}*1000-PRE_TIME*1000,ones(size(PsthAndRaster.MySpikes{BIT_Number,trl}),1)*trl,'.', 'Color', COLORSET(nn,:))
                    xlim([-200 450])
                    [BIT_Number nn trl]
                    hold on
                    line([0 0],[0 trl], 'Color', 'k','linewidth',2)
                    hold on
                    line([250 250], [0 trl], 'Color', 'k','linewidth',2);
                    xlim([-200 450])
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);
                    xlabel(['Static Bar ', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', Posx ', num2str(iposx), ', Posy ', num2str(iposy), ', InPlane ', num2str(inp)]);

                    end

            
            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/Bars/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/Bars/R_',num2str(BIT_Number),'.fig'])  
            close
            
            end
            end       
    
            
    %%%% ENTERPRISE
    %%%%%%%%%%%%%%%%
    
    
        elseif object == 1
            
        stringO=strcat('RASTERS/', num2str(nn), '/Objects/');
        mkdir(stringO);
        
        [a z]=ind2sub(size(Fede_STIM_NU), find(Fede_STIM_NU(1:342,2)==1));
        selected_bits = a';
        
            for BIT_Number = selected_bits;
                
            isz = Fede_STIM_NU(BIT_Number, 3); 
            fsz = Fede_STIM_NU(BIT_Number, 4); 
            iposx = Fede_STIM_NU(BIT_Number, 5); 
            fposx = Fede_STIM_NU(BIT_Number, 6); 
            iposy = Fede_STIM_NU(BIT_Number, 7); 
            fposy = Fede_STIM_NU(BIT_Number, 8); 
            inp = Fede_STIM_NU(BIT_Number, 9); 
            az = Fede_STIM_NU(BIT_Number, 10); 
            ori = Fede_STIM_NU(BIT_Number, 11); 

            a = PsthAndRaster.Trials{BIT_Number,nn}(1);
            stim_pres_time = (STIM_STOP(a)-STIM_START(a))*1000;
            
            if stim_pres_time > 500 && stim_pres_time < 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};
 

            ps=PsthAndRaster.Psth{BIT_Number,nn};
            trr=PsthAndRaster.Trials{BIT_Number,nn};
            M=ps(trr,:);
            M_PSTH{BIT_Number,nn}=mean(M);
            S_PSTH{BIT_Number,nn}=std(M)/sqrt(size(M,1));
            T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
            [int tm]=min(abs(T-1000));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)
                        
                    subplot(2,1,2)
                    b = M_PSTH{BIT_Number,nn}*(1000/25);
                    Tlin = T(1:tm);
                    blin = b(1:tm);
                    maxb = max(blin);
                    % all_peaks{BIT_Number, nn}=maxb;
                    % all_time_series{BIT_Number, nn}=b;
                    aku = find(blin==maxb);
                    plot(Tlin, blin,'Color', COLORSET(nn,:), 'linewidth',1)  
                    text(Tlin(aku(1)), maxb, num2str(maxb));          
                    xlim([-200 1000])
                    subplot(2,1,1)
                    plot(PsthAndRaster.MySpikes{BIT_Number,trl}*1000-PRE_TIME*1000,ones(size(PsthAndRaster.MySpikes{BIT_Number,trl}),1)*trl,'.', 'Color', COLORSET(nn,:))
                    xlim([-200 1000])
                    [BIT_Number nn trl]
                    hold on
                    line([0 0], [0 trl], 'Color', 'k','linewidth',2);
                    hold on
                    line([800 800], [0 trl], 'Color', 'k','linewidth',2);
                    xlim([-200 1000])
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);
                    
                        if iposx == 15 && iposy == 0 && inp == 0
                        xlabel(['FAST RightLeft Moving Ent ', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -15 && iposy == 0 && inp == 0
                        xlabel(['FAST LeftRight Moving Ent ', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 0 && iposy == 15 && inp == 0
                        xlabel(['FAST UpDown Moving Ent', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 0 && iposy == -15 && inp == 0
                        xlabel(['FAST DownUp Moving Ent', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -10.6 && iposy == -10.6 && inp == 0
                        xlabel(['FAST UpRight Moving Ent', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -10.6 && iposy == 10.6 && inp == 0
                        xlabel(['FAST DownRight Moving Ent', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 10.6 && iposy == -10.6 && inp == 0
                        xlabel(['FAST UpLeft Moving Ent', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 10.6 && iposy == 10.6 && inp == 0  
                        xlabel(['FAST DownLeft Moving Ent', ', BitCode ', num2str(BIT_Number)]);
                        end
                        
                        
                    end


            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/Objects/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/Objects/R_',num2str(BIT_Number),'.fig'])
            close
            
            end
            
            if stim_pres_time > 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};
 

            ps=PsthAndRaster.Psth{BIT_Number,nn};
            trr=PsthAndRaster.Trials{BIT_Number,nn};
            M=ps(trr,:);
            M_PSTH{BIT_Number,nn}=mean(M);
            S_PSTH{BIT_Number,nn}=std(M)/sqrt(size(M,1));
            T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)
                        
                    subplot(2,1,2)
                    b = M_PSTH{BIT_Number,nn}*(1000/25);
                    maxb = max(b);
                    % all_peaks{BIT_Number, nn}=maxb;
                    % all_time_series{BIT_Number, nn}=b;
                    aku = find(b==maxb);
                    plot(T,b,'Color', COLORSET(nn,:), 'linewidth',1)  
                    text(T(aku(1)), maxb, num2str(maxb));     
                    xlim([-200 2200])
                    subplot(2,1,1)
                    plot(PsthAndRaster.MySpikes{BIT_Number,trl}*1000-PRE_TIME*1000,ones(size(PsthAndRaster.MySpikes{BIT_Number,trl}),1)*trl,'.', 'Color', COLORSET(nn,:))
                    xlim([-200 2200])
                    [BIT_Number nn trl]
                    hold on
                    line([0 0], [0 trl], 'Color', 'k','linewidth',2);
                    hold on
                    line([2000 2000], [0 trl], 'Color', 'k','linewidth',2);
                    xlim([-200 2200])
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);
                    
                        if iposx == 15 && iposy == 0 && inp == 0
                        xlabel(['SLOW RightLeft Moving Ent ', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -15 && iposy == 0 && inp == 0
                        xlabel(['SLOW LeftRight Moving Ent ', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 0 && iposy == 15 && inp == 0
                        xlabel(['SLOW UpDown Moving Ent', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 0 && iposy == -15 && inp == 0
                        xlabel(['SLOW DownUp Moving Ent', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -10.6 && iposy == -10.6 && inp == 0
                        xlabel(['SLOW UpRight Moving Ent', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -10.6 && iposy == 10.6 && inp == 0
                        xlabel(['SLOW DownRight Moving Ent', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 10.6 && iposy == -10.6 && inp == 0
                        xlabel(['SLOW UpLeft Moving Ent', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 10.6 && iposy == 10.6 && inp == 0  
                        xlabel(['SLOW DownLeft Moving Ent', ', BitCode ', num2str(BIT_Number)]);
                        end
                        
                        
                    end


            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/Objects/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/Objects/R_',num2str(BIT_Number),'.fig'])
            close
            
            end
            
            if stim_pres_time < 500
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};
 

            ps=PsthAndRaster.Psth{BIT_Number,nn};
            trr=PsthAndRaster.Trials{BIT_Number,nn};
            M=ps(trr,:);
            M_PSTH{BIT_Number,nn}=mean(M);
            S_PSTH{BIT_Number,nn}=std(M)/sqrt(size(M,1));
            T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2)); %-200,2200,
            [int tm]=min(abs(T-450));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)

                    subplot(2,1,2)
                    b = M_PSTH{BIT_Number,nn}*(1000/25);
                    Tlin = T(1:tm);
                    blin = b(1:tm);
                    maxb = max(blin);
                    % all_peaks{BIT_Number, nn}=maxb;
                    % all_time_series{BIT_Number, nn}=b;
                    aku = find(blin==maxb);
                    plot(Tlin, blin,'Color', COLORSET(nn,:), 'linewidth',1)  
                    text(Tlin(aku(1)), maxb, num2str(maxb));         
                    xlim([-200 450])
                    subplot(2,1,1)
                    plot(PsthAndRaster.MySpikes{BIT_Number,trl}*1000-PRE_TIME*1000,ones(size(PsthAndRaster.MySpikes{BIT_Number,trl}),1)*trl,'.', 'Color', COLORSET(nn,:))
                    xlim([-200 450])
                    [BIT_Number nn trl]
                    hold on
                    line([0 0],[0 trl], 'Color', 'k','linewidth',2)
                    hold on
                    line([250 250], [0 trl], 'Color', 'k','linewidth',2);
                    xlim([-200 450])
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);
                    xlabel(['Static Ent ', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', Posx ', num2str(iposx), ', Posy ', num2str(iposy), ', InPlane ', num2str(inp), ', InDepth ', num2str(az)]);

                    end

            
            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/Objects/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/Objects/R_',num2str(BIT_Number),'.fig']) 
            close
            
            end
            end       
            
            
            
            
                   
    %%%% BUNNY
    %%%%%%%%%%%%%%%%
    
    
        elseif object == 2
            
%         stringO=strcat('RASTERS/Objects/', num2str(nn));
%         mkdir(stringO);
        
        [a z]=ind2sub(size(Fede_STIM_NU), find(Fede_STIM_NU(1:342,2)==2));
        selected_bits = a';
        
            for BIT_Number = selected_bits;
                
            isz = Fede_STIM_NU(BIT_Number, 3); 
            fsz = Fede_STIM_NU(BIT_Number, 4); 
            iposx = Fede_STIM_NU(BIT_Number, 5); 
            fposx = Fede_STIM_NU(BIT_Number, 6); 
            iposy = Fede_STIM_NU(BIT_Number, 7); 
            fposy = Fede_STIM_NU(BIT_Number, 8); 
            inp = Fede_STIM_NU(BIT_Number, 9); 
            az = Fede_STIM_NU(BIT_Number, 10); 
            ori = Fede_STIM_NU(BIT_Number, 11); 

            a = PsthAndRaster.Trials{BIT_Number,nn}(1);
            stim_pres_time = (STIM_STOP(a)-STIM_START(a))*1000;
            
            if stim_pres_time > 500 && stim_pres_time < 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};
 

            ps=PsthAndRaster.Psth{BIT_Number,nn};
            trr=PsthAndRaster.Trials{BIT_Number,nn};
            M=ps(trr,:);
            M_PSTH{BIT_Number,nn}=mean(M);
            S_PSTH{BIT_Number,nn}=std(M)/sqrt(size(M,1));
            T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
            [int tm]=min(abs(T-1000))
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)
                        
                    subplot(2,1,2)
                    b = M_PSTH{BIT_Number,nn}*(1000/25);
                    Tlin = T(1:tm);
                    blin = b(1:tm);
                    maxb = max(blin);
                    % all_peaks{BIT_Number, nn}=maxb;
                    % all_time_series{BIT_Number, nn}=b;
                    aku = find(blin==maxb);
                    plot(Tlin, blin,'Color', COLORSET(nn,:), 'linewidth',1)  
                    text(Tlin(aku(1)), maxb, num2str(maxb));          
                    xlim([-200 1000])
                    subplot(2,1,1)
                    plot(PsthAndRaster.MySpikes{BIT_Number,trl}*1000-PRE_TIME*1000,ones(size(PsthAndRaster.MySpikes{BIT_Number,trl}),1)*trl,'.', 'Color', COLORSET(nn,:))
                    xlim([-200 1000])
                    [BIT_Number nn trl]
                    hold on
                    line([0 0], [0 trl], 'Color', 'k','linewidth',2);
                    hold on
                    line([800 800], [0 trl], 'Color', 'k','linewidth',2);
                    xlim([-200 1000])
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);
                    
                        if iposx == 15 && iposy == 0 && inp == 0
                        xlabel(['FAST RightLeft Moving Bunny ', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -15 && iposy == 0 && inp == 0
                        xlabel(['FAST LeftRight Moving Bunny ', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 0 && iposy == 15 && inp == 0
                        xlabel(['FAST UpDown Moving Bunny', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 0 && iposy == -15 && inp == 0
                        xlabel(['FAST DownUp Moving Bunny', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -10.6 && iposy == -10.6 && inp == 0
                        xlabel(['FAST UpRight Moving Bunny', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -10.6 && iposy == 10.6 && inp == 0
                        xlabel(['FAST DownRight Moving Bunny', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 10.6 && iposy == -10.6 && inp == 0
                        xlabel(['FAST UpLeft Moving Bunny', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 10.6 && iposy == 10.6 && inp == 0  
                        xlabel(['FAST DownLeft Moving Bunny', ', BitCode ', num2str(BIT_Number)]);
                        end
                        
                        
                    end


            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/Objects/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/Objects/R_',num2str(BIT_Number),'.fig'])
            close
            
            end
            
            if stim_pres_time > 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};
 

            ps=PsthAndRaster.Psth{BIT_Number,nn};
            trr=PsthAndRaster.Trials{BIT_Number,nn};
            M=ps(trr,:);
            M_PSTH{BIT_Number,nn}=mean(M);
            S_PSTH{BIT_Number,nn}=std(M)/sqrt(size(M,1));
            T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)
                        
                    subplot(2,1,2)
                    b = M_PSTH{BIT_Number,nn}*(1000/25);
                    maxb = max(b);
                    % all_peaks{BIT_Number, nn}=maxb;
                    % all_time_series{BIT_Number, nn}=b;
                    aku = find(b==maxb);
                    plot(T,b,'Color', COLORSET(nn,:), 'linewidth',1)  
                    text(T(aku(1)), maxb, num2str(maxb));     
                    xlim([-200 2200])
                    subplot(2,1,1)
                    plot(PsthAndRaster.MySpikes{BIT_Number,trl}*1000-PRE_TIME*1000,ones(size(PsthAndRaster.MySpikes{BIT_Number,trl}),1)*trl,'.', 'Color', COLORSET(nn,:))
                    xlim([-200 2200])
                    [BIT_Number nn trl]
                    hold on
                    line([0 0], [0 trl], 'Color', 'k','linewidth',2);
                    hold on
                    line([2000 2000], [0 trl], 'Color', 'k','linewidth',2);
                    xlim([-200 2200])
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);
                    
                        if iposx == 15 && iposy == 0 && inp == 0
                        xlabel(['SLOW RightLeft Moving Bunny ', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -15 && iposy == 0 && inp == 0
                        xlabel(['SLOW LeftRight Moving Bunny ', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 0 && iposy == 15 && inp == 0
                        xlabel(['SLOW UpDown Moving Bunny', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 0 && iposy == -15 && inp == 0
                        xlabel(['SLOW DownUp Moving Bunny', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -10.6 && iposy == -10.6 && inp == 0
                        xlabel(['SLOW UpRight Moving Bunny', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -10.6 && iposy == 10.6 && inp == 0
                        xlabel(['SLOW DownRight Moving Bunny', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 10.6 && iposy == -10.6 && inp == 0
                        xlabel(['SLOW UpLeft Moving Bunny', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 10.6 && iposy == 10.6 && inp == 0  
                        xlabel(['SLOW DownLeft Moving Bunny', ', BitCode ', num2str(BIT_Number)]);
                        end
                        
                        
                    end


            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/Objects/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/Objects/R_',num2str(BIT_Number),'.fig'])
            close
            
            end
            
            if stim_pres_time < 500
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};
 

            ps=PsthAndRaster.Psth{BIT_Number,nn};
            trr=PsthAndRaster.Trials{BIT_Number,nn};
            M=ps(trr,:);
            M_PSTH{BIT_Number,nn}=mean(M);
            S_PSTH{BIT_Number,nn}=std(M)/sqrt(size(M,1));
            T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2)); %-200,2200,
            [int tm]=min(abs(T-450));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)

                    subplot(2,1,2)
                    b = M_PSTH{BIT_Number,nn}*(1000/25);
                    Tlin = T(1:tm);
                    blin = b(1:tm);
                    maxb = max(blin);
                    % all_peaks{BIT_Number, nn}=maxb;
                    % all_time_series{BIT_Number, nn}=b;
                    aku = find(blin==maxb);
                    plot(Tlin, blin,'Color', COLORSET(nn,:), 'linewidth',1)  
                    text(Tlin(aku(1)), maxb, num2str(maxb));          
                    xlim([-200 450])
                    subplot(2,1,1)
                    plot(PsthAndRaster.MySpikes{BIT_Number,trl}*1000-PRE_TIME*1000,ones(size(PsthAndRaster.MySpikes{BIT_Number,trl}),1)*trl,'.', 'Color', COLORSET(nn,:))
                    xlim([-200 450])
                    [BIT_Number nn trl]
                    hold on
                    line([0 0],[0 trl], 'Color', 'k','linewidth',2)
                    hold on
                    line([250 250], [0 trl], 'Color', 'k','linewidth',2);
                    xlim([-200 450])
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);
                    xlabel(['Static Bunny ', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', Posx ', num2str(iposx), ', Posy ', num2str(iposy), ', InPlane ', num2str(inp), ', InDepth ', num2str(az)]);

                    end

            
            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/Objects/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/Objects/R_',num2str(BIT_Number),'.fig'])
            close
            
            end
            end    
            
            
            
    %%%% ORCA
    %%%%%%%%%%%%%%%%
    
    
        elseif object == 3
            
%         stringO=strcat('RASTERS/Objects/', num2str(nn));
%         mkdir(stringO);
        
        [a z]=ind2sub(size(Fede_STIM_NU), find(Fede_STIM_NU(1:342,2)==3));
        selected_bits = a';
        
            for BIT_Number = selected_bits;
                
            isz = Fede_STIM_NU(BIT_Number, 3); 
            fsz = Fede_STIM_NU(BIT_Number, 4); 
            iposx = Fede_STIM_NU(BIT_Number, 5); 
            fposx = Fede_STIM_NU(BIT_Number, 6); 
            iposy = Fede_STIM_NU(BIT_Number, 7); 
            fposy = Fede_STIM_NU(BIT_Number, 8); 
            inp = Fede_STIM_NU(BIT_Number, 9); 
            az = Fede_STIM_NU(BIT_Number, 10); 
            ori = Fede_STIM_NU(BIT_Number, 11); 

            a = PsthAndRaster.Trials{BIT_Number,nn}(1);
            stim_pres_time = (STIM_STOP(a)-STIM_START(a))*1000;
            
            if stim_pres_time > 500 && stim_pres_time < 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};
 

            ps=PsthAndRaster.Psth{BIT_Number,nn};
            trr=PsthAndRaster.Trials{BIT_Number,nn};
            M=ps(trr,:);
            M_PSTH{BIT_Number,nn}=mean(M);
            S_PSTH{BIT_Number,nn}=std(M)/sqrt(size(M,1));
            T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
            [int tm]=min(abs(T-1000))
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)
                        
                    subplot(2,1,2)
                    b = M_PSTH{BIT_Number,nn}*(1000/25);
                    Tlin = T(1:tm);
                    blin = b(1:tm);
                    maxb = max(blin);
                    % all_peaks{BIT_Number, nn}=maxb;
                    % all_time_series{BIT_Number, nn}=b;
                    aku = find(blin==maxb);
                    plot(Tlin, blin,'Color', COLORSET(nn,:), 'linewidth',1)  
                    text(Tlin(aku(1)), maxb, num2str(maxb));          
                    xlim([-200 1000])
                    subplot(2,1,1)
                    plot(PsthAndRaster.MySpikes{BIT_Number,trl}*1000-PRE_TIME*1000,ones(size(PsthAndRaster.MySpikes{BIT_Number,trl}),1)*trl,'.', 'Color', COLORSET(nn,:))
                    xlim([-200 1000])
                    [BIT_Number nn trl]
                    hold on
                    line([0 0], [0 trl], 'Color', 'k','linewidth',2);
                    hold on
                    line([800 800], [0 trl], 'Color', 'k','linewidth',2);
                    xlim([-200 1000])
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);
                    
                        if iposx == 15 && iposy == 0 && inp == 0
                        xlabel(['FAST RightLeft Moving Orca ', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -15 && iposy == 0 && inp == 0
                        xlabel(['FAST LeftRight Moving Orca ', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 0 && iposy == 15 && inp == 0
                        xlabel(['FAST UpDown Moving Orca', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 0 && iposy == -15 && inp == 0
                        xlabel(['FAST DownUp Moving Orca', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -10.6 && iposy == -10.6 && inp == 0
                        xlabel(['FAST UpRight Moving Orca', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -10.6 && iposy == 10.6 && inp == 0
                        xlabel(['FAST DownRight Moving Orca', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 10.6 && iposy == -10.6 && inp == 0
                        xlabel(['FAST UpLeft Moving Orca', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 10.6 && iposy == 10.6 && inp == 0  
                        xlabel(['FAST DownLeft Moving Orca', ', BitCode ', num2str(BIT_Number)]);
                        end
                        
                        
                    end


            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/Objects/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/Objects/R_',num2str(BIT_Number),'.fig'])
            close
            
            end
            
            if stim_pres_time > 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};
 

            ps=PsthAndRaster.Psth{BIT_Number,nn};
            trr=PsthAndRaster.Trials{BIT_Number,nn};
            M=ps(trr,:);
            M_PSTH{BIT_Number,nn}=mean(M);
            S_PSTH{BIT_Number,nn}=std(M)/sqrt(size(M,1));

            
                T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)
                        
                    subplot(2,1,2)
                    b = M_PSTH{BIT_Number,nn}*(1000/25);
                    maxb = max(b);
                    % all_peaks{BIT_Number, nn}=maxb;
                    % all_time_series{BIT_Number, nn}=b;
                    aku = find(b==maxb);
                    plot(T,b,'Color', COLORSET(nn,:), 'linewidth',1) 
                    text(T(aku(1)), maxb, num2str(maxb));    
                    xlim([-200 2200])
                    subplot(2,1,1)
                    plot(PsthAndRaster.MySpikes{BIT_Number,trl}*1000-PRE_TIME*1000,ones(size(PsthAndRaster.MySpikes{BIT_Number,trl}),1)*trl,'.', 'Color', COLORSET(nn,:))
                    xlim([-200 2200])
                    [BIT_Number nn trl]
                    hold on
                    line([0 0], [0 trl], 'Color', 'k','linewidth',2);
                    hold on
                    line([2000 2000], [0 trl], 'Color', 'k','linewidth',2);
                    xlim([-200 2200])
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);
                    
                        if iposx == 15 && iposy == 0 && inp == 0
                        xlabel(['SLOW RightLeft Moving Orca ', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -15 && iposy == 0 && inp == 0
                        xlabel(['SLOW LeftRight Moving Orca ', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 0 && iposy == 15 && inp == 0
                        xlabel(['SLOW UpDown Moving Orca', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 0 && iposy == -15 && inp == 0
                        xlabel(['SLOW DownUp Moving Orca', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -10.6 && iposy == -10.6 && inp == 0
                        xlabel(['SLOW UpRight Moving Orca', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -10.6 && iposy == 10.6 && inp == 0
                        xlabel(['SLOW DownRight Moving Orca', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 10.6 && iposy == -10.6 && inp == 0
                        xlabel(['SLOW UpLeft Moving Orca', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 10.6 && iposy == 10.6 && inp == 0  
                        xlabel(['SLOW DownLeft Moving Orca', ', BitCode ', num2str(BIT_Number)]);
                        end
                        
                        
                    end


            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/Objects/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/Objects/R_',num2str(BIT_Number),'.fig'])
            close
            
            end
            
            if stim_pres_time < 500
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};
 

            ps=PsthAndRaster.Psth{BIT_Number,nn};
            trr=PsthAndRaster.Trials{BIT_Number,nn};
            M=ps(trr,:);
            M_PSTH{BIT_Number,nn}=mean(M);
            S_PSTH{BIT_Number,nn}=std(M)/sqrt(size(M,1));
            T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2)); %-200,2200,
            [int tm]=min(abs(T-450));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)

                    subplot(2,1,2)
                    b = M_PSTH{BIT_Number,nn}*(1000/25);
                    Tlin = T(1:tm);
                    blin = b(1:tm);
                    maxb = max(blin);
                    % all_peaks{BIT_Number, nn}=maxb;
                    % all_time_series{BIT_Number, nn}=b;
                    aku = find(blin==maxb);
                    plot(Tlin, blin,'Color', COLORSET(nn,:), 'linewidth',1)  
                    text(Tlin(aku(1)), maxb, num2str(maxb));          
                    xlim([-200 450])
                    subplot(2,1,1)
                    plot(PsthAndRaster.MySpikes{BIT_Number,trl}*1000-PRE_TIME*1000,ones(size(PsthAndRaster.MySpikes{BIT_Number,trl}),1)*trl,'.', 'Color', COLORSET(nn,:))
                    xlim([-200 450])
                    [BIT_Number nn trl]
                    hold on
                    line([0 0],[0 trl], 'Color', 'k','linewidth',2)
                    hold on
                    line([250 250], [0 trl], 'Color', 'k','linewidth',2);
                    xlim([-200 450])
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);
                    xlabel(['Static Orca ', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', Posx ', num2str(iposx), ', Posy ', num2str(iposy), ', InPlane ', num2str(inp), ', InDepth ', num2str(az)]);

                    end

            
            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/Objects/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/Objects/R_',num2str(BIT_Number),'.fig']) 
            close
            
            end
            end   
            
            
    %%%% PINGU
    %%%%%%%%%%%%%%%%
    
    
        elseif object == 4
            
%         stringO=strcat('RASTERS/Objects/', num2str(nn));
%         mkdir(stringO);
        
        [a z]=ind2sub(size(Fede_STIM_NU), find(Fede_STIM_NU(1:342,2)==4));
        selected_bits = a';
        
            for BIT_Number = selected_bits;
                
            isz = Fede_STIM_NU(BIT_Number, 3); 
            fsz = Fede_STIM_NU(BIT_Number, 4); 
            iposx = Fede_STIM_NU(BIT_Number, 5); 
            fposx = Fede_STIM_NU(BIT_Number, 6); 
            iposy = Fede_STIM_NU(BIT_Number, 7); 
            fposy = Fede_STIM_NU(BIT_Number, 8); 
            inp = Fede_STIM_NU(BIT_Number, 9); 
            az = Fede_STIM_NU(BIT_Number, 10); 
            ori = Fede_STIM_NU(BIT_Number, 11); 

            a = PsthAndRaster.Trials{BIT_Number,nn}(1);
            stim_pres_time = (STIM_STOP(a)-STIM_START(a))*1000;
            
            if stim_pres_time > 500 && stim_pres_time < 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};
 

            ps=PsthAndRaster.Psth{BIT_Number,nn};
            trr=PsthAndRaster.Trials{BIT_Number,nn};
            M=ps(trr,:);
            M_PSTH{BIT_Number,nn}=mean(M);
            S_PSTH{BIT_Number,nn}=std(M)/sqrt(size(M,1));
            T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
            [int tm]=min(abs(T-1000));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)
                        
                    subplot(2,1,2)
                    b = M_PSTH{BIT_Number,nn}*(1000/25);
                    Tlin = T(1:tm);
                    blin = b(1:tm);
                    maxb = max(blin);
                    % all_peaks{BIT_Number, nn}=maxb;
                    % all_time_series{BIT_Number, nn}=b;
                    aku = find(blin==maxb);
                    plot(Tlin, blin,'Color', COLORSET(nn,:), 'linewidth',1)  
                    text(Tlin(aku(1)), maxb, num2str(maxb));          
                    xlim([-200 1000])
                    subplot(2,1,1)
                    plot(PsthAndRaster.MySpikes{BIT_Number,trl}*1000-PRE_TIME*1000,ones(size(PsthAndRaster.MySpikes{BIT_Number,trl}),1)*trl,'.', 'Color', COLORSET(nn,:))
                    xlim([-200 1000])
                    [BIT_Number nn trl]
                    hold on
                    line([0 0], [0 trl], 'Color', 'k','linewidth',2);
                    hold on
                    line([800 800], [0 trl], 'Color', 'k','linewidth',2);
                    xlim([-200 1000])
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);
                    
                        if iposx == 15 && iposy == 0 && inp == 0
                        xlabel(['FAST RightLeft Moving Pingu ', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -15 && iposy == 0 && inp == 0
                        xlabel(['FAST LeftRight Moving Pingu ', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 0 && iposy == 15 && inp == 0
                        xlabel(['FAST UpDown Moving Pingu', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 0 && iposy == -15 && inp == 0
                        xlabel(['FAST DownUp Moving Pingu', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -10.6 && iposy == -10.6 && inp == 0
                        xlabel(['FAST UpRight Moving Pingu', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -10.6 && iposy == 10.6 && inp == 0
                        xlabel(['FAST DownRight Moving Pingu', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 10.6 && iposy == -10.6 && inp == 0
                        xlabel(['FAST UpLeft Moving Pingu', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 10.6 && iposy == 10.6 && inp == 0  
                        xlabel(['FAST DownLeft Moving Pingu', ', BitCode ', num2str(BIT_Number)]);
                        end
                        
                        
                    end


            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/Objects/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/Objects/R_',num2str(BIT_Number),'.fig'])
            close
            
            end
            
            if stim_pres_time > 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};
 

            ps=PsthAndRaster.Psth{BIT_Number,nn};
            trr=PsthAndRaster.Trials{BIT_Number,nn};
            M=ps(trr,:);
            M_PSTH{BIT_Number,nn}=mean(M);
            S_PSTH{BIT_Number,nn}=std(M)/sqrt(size(M,1));

            
                T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)
                        
                    subplot(2,1,2)
                    b = M_PSTH{BIT_Number,nn}*(1000/25);
                    maxb = max(b);
                    % all_peaks{BIT_Number, nn}=maxb;
                    % all_time_series{BIT_Number, nn}=b;
                    aku = find(b==maxb);
                    plot(T,b,'Color', COLORSET(nn,:), 'linewidth',1) 
                    text(T(aku(1)), maxb, num2str(maxb));    
                    xlim([-200 2200])
                    subplot(2,1,1)
                    plot(PsthAndRaster.MySpikes{BIT_Number,trl}*1000-PRE_TIME*1000,ones(size(PsthAndRaster.MySpikes{BIT_Number,trl}),1)*trl,'.', 'Color', COLORSET(nn,:))
                    xlim([-200 2200])
                    [BIT_Number nn trl]
                    hold on
                    line([0 0], [0 trl], 'Color', 'k','linewidth',2);
                    hold on
                    line([2000 2000], [0 trl], 'Color', 'k','linewidth',2);
                    xlim([-200 2200])
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);
                    
                        if iposx == 15 && iposy == 0 && inp == 0
                        xlabel(['SLOW RightLeft Moving Pingu ', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -15 && iposy == 0 && inp == 0
                        xlabel(['SLOW LeftRight Moving Pingu ', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 0 && iposy == 15 && inp == 0
                        xlabel(['SLOW UpDown Moving Pingu', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 0 && iposy == -15 && inp == 0
                        xlabel(['SLOW DownUp Moving Pingu', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -10.6 && iposy == -10.6 && inp == 0
                        xlabel(['SLOW UpRight Moving Pingu', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -10.6 && iposy == 10.6 && inp == 0
                        xlabel(['SLOW DownRight Moving Pingu', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 10.6 && iposy == -10.6 && inp == 0
                        xlabel(['SLOW UpLeft Moving Pingu', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 10.6 && iposy == 10.6 && inp == 0  
                        xlabel(['SLOW DownLeft Moving Pingu', ', BitCode ', num2str(BIT_Number)]);
                        end
                        
                        
                    end


            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/Objects/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/Objects/R_',num2str(BIT_Number),'.fig'])
            close
            
            end
            
            if stim_pres_time < 500
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};
 

            ps=PsthAndRaster.Psth{BIT_Number,nn};
            trr=PsthAndRaster.Trials{BIT_Number,nn};
            M=ps(trr,:);
            M_PSTH{BIT_Number,nn}=mean(M);
            S_PSTH{BIT_Number,nn}=std(M)/sqrt(size(M,1));
            T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2)); %-200,2200,
            [int tm]=min(abs(T-450));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)

                    subplot(2,1,2)
                    b = M_PSTH{BIT_Number,nn}*(1000/25);
                    Tlin = T(1:tm);
                    blin = b(1:tm);
                    maxb = max(blin);
                    % all_peaks{BIT_Number, nn}=maxb;
                    % all_time_series{BIT_Number, nn}=b;
                    aku = find(blin==maxb);
                    plot(Tlin, blin,'Color', COLORSET(nn,:), 'linewidth',1)  
                    text(Tlin(aku(1)), maxb, num2str(maxb));          
                    xlim([-200 450])
                    subplot(2,1,1)
                    plot(PsthAndRaster.MySpikes{BIT_Number,trl}*1000-PRE_TIME*1000,ones(size(PsthAndRaster.MySpikes{BIT_Number,trl}),1)*trl,'.', 'Color', COLORSET(nn,:))
                    xlim([-200 450])
                    [BIT_Number nn trl]
                    hold on
                    line([0 0],[0 trl], 'Color', 'k','linewidth',2)
                    hold on
                    line([250 250], [0 trl], 'Color', 'k','linewidth',2);
                    xlim([-200 450])
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);
                    xlabel(['Static Pingu ', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', Posx ', num2str(iposx), ', Posy ', num2str(iposy), ', InPlane ', num2str(inp), ', InDepth ', num2str(az)]);

                    end

            
            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/Objects/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/Objects/R_',num2str(BIT_Number),'.fig'])
            close
            
            end
            end   
            
    
            
            
   %%%% 0.03 GRATINGS
   %%%%%%%%%%%%%%%%%%
    
    elseif object == 111
        

        stringG=strcat('RASTERS/', num2str(nn), '/Gratings/');
        mkdir(stringG);
        [a z]=ind2sub(size(Fede_STIM_NU), find(Fede_STIM_NU(1:342,2)==111));
        selected_bits = a';
        
            for BIT_Number = selected_bits;
            
            isz = Fede_STIM_NU(BIT_Number, 3); 
            fsz = Fede_STIM_NU(BIT_Number, 4); 
            iposx = Fede_STIM_NU(BIT_Number, 5); 
            fposx = Fede_STIM_NU(BIT_Number, 6); 
            iposy = Fede_STIM_NU(BIT_Number, 7); 
            fposy = Fede_STIM_NU(BIT_Number, 8); 
            ori = Fede_STIM_NU(BIT_Number, 11); 

            
            a = PsthAndRaster.Trials{BIT_Number,nn}(1);
            stim_pres_time = (STIM_STOP(a)-STIM_START(a))*1000;
            
            if stim_pres_time > 500 && stim_pres_time < 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                ps=PsthAndRaster.Psth{BIT_Number,nn};
                trr=PsthAndRaster.Trials{BIT_Number,nn};
                M=ps(trr,:);
                M_PSTH{BIT_Number,nn}=mean(M);
                S_PSTH{BIT_Number,nn}=std(M)/sqrt(size(M,1));
                T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
                [int tm]=min(abs(T-1000))
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)

                    subplot(2,1,2)
                    b = M_PSTH{BIT_Number,nn}*(1000/25);
                    Tlin = T(1:tm);
                    blin = b(1:tm);
                    maxb = max(blin);
                    % all_peaks{BIT_Number, nn}=maxb;
                    % all_time_series{BIT_Number, nn}=b;
                    aku = find(blin==maxb);
                    plot(Tlin, blin,'Color', COLORSET(nn,:), 'linewidth',1)  
                    text(Tlin(aku(1)), maxb, num2str(maxb));          
                    xlim([-200 1000])
                    subplot(2,1,1)
                    plot(PsthAndRaster.MySpikes{BIT_Number,trl}*1000-PRE_TIME*1000,ones(size(PsthAndRaster.MySpikes{BIT_Number,trl}),1)*trl,'.', 'Color', COLORSET(nn,:))
                    xlim([-200 1000])
                    [BIT_Number nn trl]
                    hold on
                    line([0 0], [0 trl], 'Color', 'k','linewidth',2);
                    hold on
                    line([800 800], [0 trl], 'Color', 'k','linewidth',2);
                    xlim([-200 1000])
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);

                    
                    if iposx == 15 && iposy == 0  
                        xlabel(['FAST RightLeft Moving Grating, SF 0.03, OR ', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -15 && iposy == 0 
                        xlabel(['FAST LeftRight Moving Grating, SF 0.03, OR ', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 0 && iposy == 15 
                        xlabel(['FAST UpDown Moving Grating, SF 0.03, OR', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 0 && iposy == -15 
                        xlabel(['FAST DownUp Moving Grating, SF 0.03, OR', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -10.6 && iposy == -10.6 
                        xlabel(['FAST UpRight Moving Grating, SF 0.03, OR', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -10.6 && iposy == 10.6
                        xlabel(['FAST DownRight Moving Grating, SF 0.03, OR', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 10.6 && iposy == -10.6 
                        xlabel(['FAST UpLeft Moving Grating, SF 0.03, OR', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 10.6 && iposy == 10.6 
                        xlabel(['FAST DownLeft Moving Grating, SF 0.03, OR', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        
                    end
                    
                    end

          
            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/Gratings/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/Gratings/R_',num2str(BIT_Number),'.fig'])
            close
            
            end
                
                
            if stim_pres_time > 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                ps=PsthAndRaster.Psth{BIT_Number,nn};
                trr=PsthAndRaster.Trials{BIT_Number,nn};
                M=ps(trr,:);
                M_PSTH{BIT_Number,nn}=mean(M);
                S_PSTH{BIT_Number,nn}=std(M)/sqrt(size(M,1));
                T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)

                    subplot(2,1,2)
                    b = M_PSTH{BIT_Number,nn}*(1000/25);
                    maxb = max(b);
                    % all_peaks{BIT_Number, nn}=maxb;
                    % all_time_series{BIT_Number, nn}=b;
                    aku = find(b==maxb);
                    plot(T,b,'Color', COLORSET(nn,:), 'linewidth',1) 
                    text(T(aku(1)), maxb, num2str(maxb));     
                    xlim([-200 2200])
                    subplot(2,1,1)
                    plot(PsthAndRaster.MySpikes{BIT_Number,trl}*1000-PRE_TIME*1000,ones(size(PsthAndRaster.MySpikes{BIT_Number,trl}),1)*trl,'.', 'Color', COLORSET(nn,:))
                    xlim([-200 2200])
                    [BIT_Number nn trl]
                    hold on
                    line([0 0], [0 trl], 'Color', 'k','linewidth',2);
                    hold on
                    line([2000 2000], [0 trl], 'Color', 'k','linewidth',2);
                    xlim([-200 2200])
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);

                    
                    if iposx == 15 && iposy == 0  
                        xlabel(['SLOW RightLeft Moving Grating, SF 0.03, OR ', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -15 && iposy == 0 
                        xlabel(['SLOW LeftRight Moving Grating, SF 0.03, OR ', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 0 && iposy == 15 
                        xlabel(['SLOW UpDown Moving Grating, SF 0.03, OR', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 0 && iposy == -15 
                        xlabel(['SLOW DownUp Moving Grating, SF 0.03, OR', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -10.6 && iposy == -10.6 
                        xlabel(['SLOW UpRight Moving Grating, SF 0.03, OR', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -10.6 && iposy == 10.6
                        xlabel(['SLOW DownRight Moving Grating, SF 0.03, OR', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 10.6 && iposy == -10.6 
                        xlabel(['SLOW UpLeft Moving Grating, SF 0.03, OR', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 10.6 && iposy == 10.6 
                        xlabel(['SLOW DownLeft Moving Grating, SF 0.03, OR', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        
                    end
                    
                    end

            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/Gratings/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/Gratings/R_',num2str(BIT_Number),'.fig'])
            close
            
            end
            
            if stim_pres_time < 500
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

 
            ps=PsthAndRaster.Psth{BIT_Number,nn};
            trr=PsthAndRaster.Trials{BIT_Number,nn};
            M=ps(trr,:);
            M_PSTH{BIT_Number,nn}=mean(M);
            S_PSTH{BIT_Number,nn}=std(M)/sqrt(size(M,1));    
            T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2)); %-200,2200,
            [int tm]=min(abs(T-450));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)
                        
                    subplot(2,1,2)
                    b = M_PSTH{BIT_Number,nn}*(1000/25);
                    Tlin = T(1:tm);
                    blin = b(1:tm);
                    maxb = max(blin);
                    % all_peaks{BIT_Number, nn}=maxb;
                    % all_time_series{BIT_Number, nn}=b;
                    aku = find(blin==maxb);
                    plot(Tlin, blin,'Color', COLORSET(nn,:), 'linewidth',1)  
                    text(Tlin(aku(1)), maxb, num2str(maxb));          
                    xlim([-200 450])
                    subplot(2,1,1)
                    plot(PsthAndRaster.MySpikes{BIT_Number,trl}*1000-PRE_TIME*1000,ones(size(PsthAndRaster.MySpikes{BIT_Number,trl}),1)*trl,'.', 'Color', COLORSET(nn,:))
                    xlim([-200 450])
                    [BIT_Number nn trl]
                    hold on
                    line([0 0],[0 trl], 'Color', 'k','linewidth',2)
                    hold on
                    line([250 250], [0 trl], 'Color', 'k','linewidth',2);
                    xlim([-200 450])
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);
                    xlabel(['Static Grating, SF 0.03, OR ', num2str(ori), ', BitCode ', num2str(BIT_Number)]);

                    end


            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/Gratings/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/Gratings/R_',num2str(BIT_Number),'.fig'])  
            close
            
            end
            end
            
                    
            
   %%%% 0.05 GRATINGS
   %%%%%%%%%%%%%%%%%%
    
    elseif object == 222
        
% 
%         stringG=strcat('RASTERS/Gratings/', num2str(nn));
%         mkdir(stringG);
        [a z]=ind2sub(size(Fede_STIM_NU), find(Fede_STIM_NU(1:342,2)==222));
        selected_bits = a';
        
            for BIT_Number = selected_bits;
            
            isz = Fede_STIM_NU(BIT_Number, 3); 
            fsz = Fede_STIM_NU(BIT_Number, 4); 
            iposx = Fede_STIM_NU(BIT_Number, 5); 
            fposx = Fede_STIM_NU(BIT_Number, 6); 
            iposy = Fede_STIM_NU(BIT_Number, 7); 
            fposy = Fede_STIM_NU(BIT_Number, 8); 
            ori = Fede_STIM_NU(BIT_Number, 11); 

            
            a = PsthAndRaster.Trials{BIT_Number,nn}(1);
            stim_pres_time = (STIM_STOP(a)-STIM_START(a))*1000;
            
            if stim_pres_time > 500 && stim_pres_time < 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                ps=PsthAndRaster.Psth{BIT_Number,nn};
                trr=PsthAndRaster.Trials{BIT_Number,nn};
                M=ps(trr,:);
                M_PSTH{BIT_Number,nn}=mean(M);
                S_PSTH{BIT_Number,nn}=std(M)/sqrt(size(M,1));
                T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
                [int tm]=min(abs(T-1000));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)

                    subplot(2,1,2)
                    b = M_PSTH{BIT_Number,nn}*(1000/25);
                    Tlin = T(1:tm);
                    blin = b(1:tm);
                    maxb = max(blin);
                    % all_peaks{BIT_Number, nn}=maxb;
                    % all_time_series{BIT_Number, nn}=b;
                    aku = find(blin==maxb);
                    plot(Tlin, blin,'Color', COLORSET(nn,:), 'linewidth',1)  
                    text(Tlin(aku(1)), maxb, num2str(maxb));          
                    xlim([-200 1000])
                    subplot(2,1,1)
                    plot(PsthAndRaster.MySpikes{BIT_Number,trl}*1000-PRE_TIME*1000,ones(size(PsthAndRaster.MySpikes{BIT_Number,trl}),1)*trl,'.', 'Color', COLORSET(nn,:))
                    xlim([-200 1000])
                    [BIT_Number nn trl]
                    hold on
                    line([0 0], [0 trl], 'Color', 'k','linewidth',2);
                    hold on
                    line([800 800], [0 trl], 'Color', 'k','linewidth',2);
                    xlim([-200 1000])
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);

                    
                    if iposx == 15 && iposy == 0  
                        xlabel(['FAST RightLeft Moving Grating, SF 0.05, OR ', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -15 && iposy == 0 
                        xlabel(['FAST LeftRight Moving Grating, SF 0.05, OR ', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 0 && iposy == 15 
                        xlabel(['FAST UpDown Moving Grating, SF 0.05, OR', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 0 && iposy == -15 
                        xlabel(['FAST DownUp Moving Grating, SF 0.05, OR', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -10.6 && iposy == -10.6 
                        xlabel(['FAST UpRight Moving Grating, SF 0.05, OR', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -10.6 && iposy == 10.6
                        xlabel(['FAST DownRight Moving Grating, SF 0.05, OR', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 10.6 && iposy == -10.6 
                        xlabel(['FAST UpLeft Moving Grating, SF 0.05, OR', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 10.6 && iposy == 10.6 
                        xlabel(['FAST DownLeft Moving Grating, SF 0.05, OR', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        
                    end
                    
                    end

          
            saveas(gcf,[ww,'/RASTERS/Gratings/', num2str(nn), '/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/Gratings/', num2str(nn), '/R_',num2str(BIT_Number),'.fig'])  
            close
            
            end
                
                
            if stim_pres_time > 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                ps=PsthAndRaster.Psth{BIT_Number,nn};
                trr=PsthAndRaster.Trials{BIT_Number,nn};
                M=ps(trr,:);
                M_PSTH{BIT_Number,nn}=mean(M);
                S_PSTH{BIT_Number,nn}=std(M)/sqrt(size(M,1));
                T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)

                    subplot(2,1,2)
                    b = M_PSTH{BIT_Number,nn}*(1000/25);
                    maxb = max(b);
                    % all_peaks{BIT_Number, nn}=maxb;
                    % all_time_series{BIT_Number, nn}=b;
                    aku = find(b==maxb);
                    plot(T,b,'Color', COLORSET(nn,:), 'linewidth',1)  
                    text(T(aku(1)), maxb, num2str(maxb));    
                    xlim([-200 2200])
                    subplot(2,1,1)
                    plot(PsthAndRaster.MySpikes{BIT_Number,trl}*1000-PRE_TIME*1000,ones(size(PsthAndRaster.MySpikes{BIT_Number,trl}),1)*trl,'.', 'Color', COLORSET(nn,:))
                    xlim([-200 2200])
                    [BIT_Number nn trl]
                    hold on
                    line([0 0], [0 trl], 'Color', 'k','linewidth',2);
                    hold on
                    line([2000 2000], [0 trl], 'Color', 'k','linewidth',2);
                    xlim([-200 2200])
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);

                    
                    if iposx == 15 && iposy == 0  
                        xlabel(['SLOW RightLeft Moving Grating, SF 0.05, OR ', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -15 && iposy == 0 
                        xlabel(['SLOW LeftRight Moving Grating, SF 0.05, OR ', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 0 && iposy == 15 
                        xlabel(['SLOW UpDown Moving Grating, SF 0.05, OR', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 0 && iposy == -15 
                        xlabel(['SLOW DownUp Moving Grating, SF 0.05, OR', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -10.6 && iposy == -10.6 
                        xlabel(['SLOW UpRight Moving Grating, SF 0.05, OR', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -10.6 && iposy == 10.6
                        xlabel(['SLOW DownRight Moving Grating, SF 0.05, OR', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 10.6 && iposy == -10.6 
                        xlabel(['SLOW UpLeft Moving Grating, SF 0.05, OR', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 10.6 && iposy == 10.6 
                        xlabel(['SLOW DownLeft Moving Grating, SF 0.05, OR', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        
                    end
                    
                    end

            saveas(gcf,[ww,'/RASTERS/Gratings/', num2str(nn), '/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/Gratings/', num2str(nn), '/R_',num2str(BIT_Number),'.fig'])  
            close
            
            end
            
            if stim_pres_time < 500
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

 
            ps=PsthAndRaster.Psth{BIT_Number,nn};
            trr=PsthAndRaster.Trials{BIT_Number,nn};
            M=ps(trr,:);
            M_PSTH{BIT_Number,nn}=mean(M);
            S_PSTH{BIT_Number,nn}=std(M)/sqrt(size(M,1));    
            T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2)); %-200,2200,
            [int tm]=min(abs(T-450));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)
                        
                    subplot(2,1,2)
                    b = M_PSTH{BIT_Number,nn}*(1000/25);
                    Tlin = T(1:tm);
                    blin = b(1:tm);
                    maxb = max(blin);
                    % all_peaks{BIT_Number, nn}=maxb;
                    % all_time_series{BIT_Number, nn}=b;
                    aku = find(blin==maxb);
                    plot(Tlin, blin,'Color', COLORSET(nn,:), 'linewidth',1)  
                    text(Tlin(aku(1)), maxb, num2str(maxb));          
                    xlim([-200 450])
                    subplot(2,1,1)
                    plot(PsthAndRaster.MySpikes{BIT_Number,trl}*1000-PRE_TIME*1000,ones(size(PsthAndRaster.MySpikes{BIT_Number,trl}),1)*trl,'.', 'Color', COLORSET(nn,:))
                    xlim([-200 450])
                    [BIT_Number nn trl]
                    hold on
                    line([0 0],[0 trl], 'Color', 'k','linewidth',2)
                    hold on
                    line([250 250], [0 trl], 'Color', 'k','linewidth',2);
                    xlim([-200 450])
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);
                    xlabel(['Static Grating, SF 0.05, OR ', num2str(ori), ', BitCode ', num2str(BIT_Number)]);

                    end


            saveas(gcf,[ww,'/RASTERS/Gratings/', num2str(nn), '/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/Gratings/', num2str(nn), '/R_',num2str(BIT_Number),'.fig'])  
            close
            
            end
            end            
            
            
            
            
   %%%% 0.1 GRATINGS
   %%%%%%%%%%%%%%%%%%
    
    elseif object == 333
        
% 
%         stringG=strcat('RASTERS/Gratings/', num2str(nn));
%         mkdir(stringG);
        [a z]=ind2sub(size(Fede_STIM_NU), find(Fede_STIM_NU(1:342,2)==333));
        selected_bits = a';
        
            for BIT_Number = selected_bits;
            
            isz = Fede_STIM_NU(BIT_Number, 3); 
            fsz = Fede_STIM_NU(BIT_Number, 4); 
            iposx = Fede_STIM_NU(BIT_Number, 5); 
            fposx = Fede_STIM_NU(BIT_Number, 6); 
            iposy = Fede_STIM_NU(BIT_Number, 7); 
            fposy = Fede_STIM_NU(BIT_Number, 8); 
            ori = Fede_STIM_NU(BIT_Number, 11); 

            
            a = PsthAndRaster.Trials{BIT_Number,nn}(1);
            stim_pres_time = (STIM_STOP(a)-STIM_START(a))*1000;
            
            if stim_pres_time > 500 && stim_pres_time < 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                ps=PsthAndRaster.Psth{BIT_Number,nn};
                trr=PsthAndRaster.Trials{BIT_Number,nn};
                M=ps(trr,:);
                M_PSTH{BIT_Number,nn}=mean(M);
                S_PSTH{BIT_Number,nn}=std(M)/sqrt(size(M,1));
                T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
                [int tm]=min(abs(T-1000));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)

                    subplot(2,1,2)
                    b = M_PSTH{BIT_Number,nn}*(1000/25);
                    Tlin = T(1:tm);
                    blin = b(1:tm);
                    maxb = max(blin);
                    % all_peaks{BIT_Number, nn}=maxb;
                    % all_time_series{BIT_Number, nn}=b;
                    aku = find(blin==maxb);
                    plot(Tlin, blin,'Color', COLORSET(nn,:), 'linewidth',1)  
                    text(Tlin(aku(1)), maxb, num2str(maxb));          
                    xlim([-200 1000])
                    subplot(2,1,1)
                    plot(PsthAndRaster.MySpikes{BIT_Number,trl}*1000-PRE_TIME*1000,ones(size(PsthAndRaster.MySpikes{BIT_Number,trl}),1)*trl,'.', 'Color', COLORSET(nn,:))
                    xlim([-200 1000])
                    [BIT_Number nn trl]
                    hold on
                    line([0 0], [0 trl], 'Color', 'k','linewidth',2);
                    hold on
                    line([800 800], [0 trl], 'Color', 'k','linewidth',2);
                    xlim([-200 1000])
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);

                    
                    if iposx == 15 && iposy == 0  
                        xlabel(['FAST RightLeft Moving Grating, SF 0.1, OR ', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -15 && iposy == 0 
                        xlabel(['FAST LeftRight Moving Grating, SF 0.1, OR ', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 0 && iposy == 15 
                        xlabel(['FAST UpDown Moving Grating, SF 0.1, OR', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 0 && iposy == -15 
                        xlabel(['FAST DownUp Moving Grating, SF 0.1, OR', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -10.6 && iposy == -10.6 
                        xlabel(['FAST UpRight Moving Grating, SF 0.1, OR', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -10.6 && iposy == 10.6
                        xlabel(['FAST DownRight Moving Grating, SF 0.1, OR', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 10.6 && iposy == -10.6 
                        xlabel(['FAST UpLeft Moving Grating, SF 0.1, OR', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 10.6 && iposy == 10.6 
                        xlabel(['FAST DownLeft Moving Grating, SF 0.1, OR', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        
                    end
                    
                    end

          
            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/Gratings/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/Gratings/R_',num2str(BIT_Number),'.fig'])
            close
            
            end
                
                
            if stim_pres_time > 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                ps=PsthAndRaster.Psth{BIT_Number,nn};
                trr=PsthAndRaster.Trials{BIT_Number,nn};
                M=ps(trr,:);
                M_PSTH{BIT_Number,nn}=mean(M);
                S_PSTH{BIT_Number,nn}=std(M)/sqrt(size(M,1));
                T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)

                    subplot(2,1,2)
                    b = M_PSTH{BIT_Number,nn}*(1000/25);
                    maxb = max(b);
                    % all_peaks{BIT_Number, nn}=maxb;
                    % all_time_series{BIT_Number, nn}=b;
                    aku = find(b==maxb);
                    plot(T,b,'Color', COLORSET(nn,:), 'linewidth',1)   
                    text(T(aku(1)), maxb, num2str(maxb));      
                    xlim([-200 2200])
                    subplot(2,1,1)
                    plot(PsthAndRaster.MySpikes{BIT_Number,trl}*1000-PRE_TIME*1000,ones(size(PsthAndRaster.MySpikes{BIT_Number,trl}),1)*trl,'.', 'Color', COLORSET(nn,:))
                    xlim([-200 2200])
                    [BIT_Number nn trl]
                    hold on
                    line([0 0], [0 trl], 'Color', 'k','linewidth',2);
                    hold on
                    line([2000 2000], [0 trl], 'Color', 'k','linewidth',2);
                    xlim([-200 2200])
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);

                    
                    if iposx == 15 && iposy == 0  
                        xlabel(['SLOW RightLeft Moving Grating, SF 0.1, OR ', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -15 && iposy == 0 
                        xlabel(['SLOW LeftRight Moving Grating, SF 0.1, OR ', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 0 && iposy == 15 
                        xlabel(['SLOW UpDown Moving Grating, SF 0.1, OR', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 0 && iposy == -15 
                        xlabel(['SLOW DownUp Moving Grating, SF 0.1, OR', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -10.6 && iposy == -10.6 
                        xlabel(['SLOW UpRight Moving Grating, SF 0.1, OR', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -10.6 && iposy == 10.6
                        xlabel(['SLOW DownRight Moving Grating, SF 0.1, OR', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 10.6 && iposy == -10.6 
                        xlabel(['SLOW UpLeft Moving Grating, SF 0.1, OR', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 10.6 && iposy == 10.6 
                        xlabel(['SLOW DownLeft Moving Grating, SF 0.1, OR', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        
                    end
                    
                    end

            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/Gratings/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/Gratings/R_',num2str(BIT_Number),'.fig'])
            close
            
            end
            
            if stim_pres_time < 500
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

 
            ps=PsthAndRaster.Psth{BIT_Number,nn};
            trr=PsthAndRaster.Trials{BIT_Number,nn};
            M=ps(trr,:);
            M_PSTH{BIT_Number,nn}=mean(M);
            S_PSTH{BIT_Number,nn}=std(M)/sqrt(size(M,1));    
            T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2)); %-200,2200,
            [int tm]=min(abs(T-450));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)
                        
                    subplot(2,1,2)
                    b = M_PSTH{BIT_Number,nn}*(1000/25);
                    Tlin = T(1:tm);
                    blin = b(1:tm);
                    maxb = max(blin);
                    % all_peaks{BIT_Number, nn}=maxb;
                    % all_time_series{BIT_Number, nn}=b;
                    aku = find(blin==maxb);
                    plot(Tlin, blin,'Color', COLORSET(nn,:), 'linewidth',1)  
                    text(Tlin(aku(1)), maxb, num2str(maxb));          
                    xlim([-200 450])
                    subplot(2,1,1)
                    plot(PsthAndRaster.MySpikes{BIT_Number,trl}*1000-PRE_TIME*1000,ones(size(PsthAndRaster.MySpikes{BIT_Number,trl}),1)*trl,'.', 'Color', COLORSET(nn,:))
                    xlim([-200 450])
                    [BIT_Number nn trl]
                    hold on
                    line([0 0],[0 trl], 'Color', 'k','linewidth',2)
                    hold on
                    line([250 250], [0 trl], 'Color', 'k','linewidth',2);
                    xlim([-200 450])
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);
                    xlabel(['Static Grating, SF 0.1, OR ', num2str(ori), ', BitCode ', num2str(BIT_Number)]);

                    end


            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/Gratings/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/Gratings/R_',num2str(BIT_Number),'.fig'])
            close
            
            end
            end              
            
            
            
   %%%% 0.4 GRATINGS
   %%%%%%%%%%%%%%%%%%
    
    elseif object == 444
        
% 
%         stringG=strcat('RASTERS/Gratings/', num2str(nn));
%         mkdir(stringG);
        [a z]=ind2sub(size(Fede_STIM_NU), find(Fede_STIM_NU(1:342,2)==444));
        selected_bits = a';
        
            for BIT_Number = selected_bits;
            
            isz = Fede_STIM_NU(BIT_Number, 3); 
            fsz = Fede_STIM_NU(BIT_Number, 4); 
            iposx = Fede_STIM_NU(BIT_Number, 5); 
            fposx = Fede_STIM_NU(BIT_Number, 6); 
            iposy = Fede_STIM_NU(BIT_Number, 7); 
            fposy = Fede_STIM_NU(BIT_Number, 8); 
            ori = Fede_STIM_NU(BIT_Number, 11); 

            
            a = PsthAndRaster.Trials{BIT_Number,nn}(1);
            stim_pres_time = (STIM_STOP(a)-STIM_START(a))*1000;
            
            if stim_pres_time > 500 && stim_pres_time < 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                ps=PsthAndRaster.Psth{BIT_Number,nn};
                trr=PsthAndRaster.Trials{BIT_Number,nn};
                M=ps(trr,:);
                M_PSTH{BIT_Number,nn}=mean(M);
                S_PSTH{BIT_Number,nn}=std(M)/sqrt(size(M,1));
                T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
                [int tm]=min(abs(T-1000));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)

                    subplot(2,1,2)
                    b = M_PSTH{BIT_Number,nn}*(1000/25);
                    Tlin = T(1:tm);
                    blin = b(1:tm);
                    maxb = max(blin);
                    % all_time_series{BIT_Number, nn}=b;
                    % all_peaks{BIT_Number, nn}=maxb;
                    aku = find(blin==maxb);
                    plot(Tlin, blin,'Color', COLORSET(nn,:), 'linewidth',1)  
                    text(Tlin(aku(1)), maxb, num2str(maxb));          
                    xlim([-200 1000])
                    subplot(2,1,1)
                    plot(PsthAndRaster.MySpikes{BIT_Number,trl}*1000-PRE_TIME*1000,ones(size(PsthAndRaster.MySpikes{BIT_Number,trl}),1)*trl,'.', 'Color', COLORSET(nn,:))
                    xlim([-200 1000])
                    [BIT_Number nn trl]
                    hold on
                    line([0 0], [0 trl], 'Color', 'k','linewidth',2);
                    hold on
                    line([800 800], [0 trl], 'Color', 'k','linewidth',2);
                    xlim([-200 1000])
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);

                    
                    if iposx == 15 && iposy == 0  
                        xlabel(['FAST RightLeft Moving Grating, SF 0.4, OR ', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -15 && iposy == 0 
                        xlabel(['FAST LeftRight Moving Grating, SF 0.4, OR ', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 0 && iposy == 15 
                        xlabel(['FAST UpDown Moving Grating, SF 0.4, OR', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 0 && iposy == -15 
                        xlabel(['FAST DownUp Moving Grating, SF 0.4, OR', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -10.6 && iposy == -10.6 
                        xlabel(['FAST UpRight Moving Grating, SF 0.4, OR', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -10.6 && iposy == 10.6
                        xlabel(['FAST DownRight Moving Grating, SF 0.4, OR', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 10.6 && iposy == -10.6 
                        xlabel(['FAST UpLeft Moving Grating, SF 0.4, OR', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 10.6 && iposy == 10.6 
                        xlabel(['FAST DownLeft Moving Grating, SF 0.4, OR', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        
                    end
                    
                    end

          
            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/Gratings/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/Gratings/R_',num2str(BIT_Number),'.fig'])
            close
            
            end
                
                
            if stim_pres_time > 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                ps=PsthAndRaster.Psth{BIT_Number,nn};
                trr=PsthAndRaster.Trials{BIT_Number,nn};
                M=ps(trr,:);
                M_PSTH{BIT_Number,nn}=mean(M);
                S_PSTH{BIT_Number,nn}=std(M)/sqrt(size(M,1));
                T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)

                    subplot(2,1,2)
                    b = M_PSTH{BIT_Number,nn}*(1000/25);
                    maxb = max(b);
                    % all_time_series{BIT_Number, nn}=b;
                    % all_peaks{BIT_Number, nn}=maxb;
                    aku = find(b==maxb);                   
                    plot(T,b,'Color', COLORSET(nn,:), 'linewidth',1)
                    text(T(aku(1)), maxb, num2str(maxb));    
                    xlim([-200 2200])
                    subplot(2,1,1)
                    plot(PsthAndRaster.MySpikes{BIT_Number,trl}*1000-PRE_TIME*1000,ones(size(PsthAndRaster.MySpikes{BIT_Number,trl}),1)*trl,'.', 'Color', COLORSET(nn,:))
                    xlim([-200 2200])
                    [BIT_Number nn trl]
                    hold on
                    line([0 0], [0 trl], 'Color', 'k','linewidth',2);
                    hold on
                    line([2000 2000], [0 trl], 'Color', 'k','linewidth',2);
                    xlim([-200 2200])
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);

                    
                    if iposx == 15 && iposy == 0  
                        xlabel(['SLOW RightLeft Moving Grating, SF 0.4, OR ', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -15 && iposy == 0 
                        xlabel(['SLOW LeftRight Moving Grating, SF 0.4, OR ', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 0 && iposy == 15 
                        xlabel(['SLOW UpDown Moving Grating, SF 0.4, OR', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 0 && iposy == -15 
                        xlabel(['SLOW DownUp Moving Grating, SF 0.4, OR', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -10.6 && iposy == -10.6 
                        xlabel(['SLOW UpRight Moving Grating, SF 0.4, OR', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -10.6 && iposy == 10.6
                        xlabel(['SLOW DownRight Moving Grating, SF 0.4, OR', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 10.6 && iposy == -10.6 
                        xlabel(['SLOW UpLeft Moving Grating, SF 0.4, OR', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 10.6 && iposy == 10.6 
                        xlabel(['SLOW DownLeft Moving Grating, SF 0.4, OR', num2str(ori), ', BitCode ', num2str(BIT_Number)]);
                        
                    end
                    
                    end

            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/Gratings/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/Gratings/R_',num2str(BIT_Number),'.fig'])
            close
            
            end
            
            if stim_pres_time < 500
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

 
            ps=PsthAndRaster.Psth{BIT_Number,nn};
            trr=PsthAndRaster.Trials{BIT_Number,nn};
            M=ps(trr,:);
            M_PSTH{BIT_Number,nn}=mean(M);
            S_PSTH{BIT_Number,nn}=std(M)/sqrt(size(M,1));    
            T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2)); %-200,2200,
            [int tm]=min(abs(T-450));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)
                        
                    subplot(2,1,2)
                    b = M_PSTH{BIT_Number,nn}*(1000/25);
                    Tlin = T(1:tm);
                    blin = b(1:tm);
                    maxb = max(blin);
                    % all_peaks{BIT_Number, nn}=maxb;
                    % all_time_series{BIT_Number, nn}=b;
                    aku = find(blin==maxb);
                    plot(Tlin, blin,'Color', COLORSET(nn,:), 'linewidth',1)  
                    text(Tlin(aku(1)), maxb, num2str(maxb));          
                    xlim([-200 450])
                    subplot(2,1,1)
                    plot(PsthAndRaster.MySpikes{BIT_Number,trl}*1000-PRE_TIME*1000,ones(size(PsthAndRaster.MySpikes{BIT_Number,trl}),1)*trl,'.', 'Color', COLORSET(nn,:))
                    xlim([-200 450])
                    [BIT_Number nn trl]
                    hold on
                    line([0 0],[0 trl], 'Color', 'k','linewidth',2)
                    hold on
                    line([250 250], [0 trl], 'Color', 'k','linewidth',2);
                    xlim([-200 450])
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);
                    xlabel(['Static Grating, SF 0.4, OR ', num2str(ori), ', BitCode ', num2str(BIT_Number)]);

                    end


            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/Gratings/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/Gratings/R_',num2str(BIT_Number),'.fig'])
            close
            
            end
            end            
            
            
            
            
    %%%% MOVING DOTS PATTERN 1
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    
    elseif object == 11

    
        stringD=strcat('RASTERS/', num2str(nn), '/Dots/');
        mkdir(stringD);
        [a z]=ind2sub(size(Fede_STIM_NU), find(Fede_STIM_NU(1:342,2)==11));
        selected_bits = a';
        
            for BIT_Number = selected_bits;

            isz = Fede_STIM_NU(BIT_Number, 3); 
            fsz = Fede_STIM_NU(BIT_Number, 4); 
            iposx = Fede_STIM_NU(BIT_Number, 5); 
            fposx = Fede_STIM_NU(BIT_Number, 6); 
            iposy = Fede_STIM_NU(BIT_Number, 7); 
            fposy = Fede_STIM_NU(BIT_Number, 8); 
            ori = Fede_STIM_NU(BIT_Number, 11); 
            
            a = PsthAndRaster.Trials{BIT_Number,nn}(1);
            stim_pres_time = (STIM_STOP(a)-STIM_START(a))*1000;
            
            if stim_pres_time > 500 && stim_pres_time < 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};


                ps=PsthAndRaster.Psth{BIT_Number,nn};
                trr=PsthAndRaster.Trials{BIT_Number,nn};
                M=ps(trr,:);
                M_PSTH{BIT_Number,nn}=mean(M);
                S_PSTH{BIT_Number,nn}=std(M)/sqrt(size(M,1));
                T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
                [int tm]=min(abs(T-1000));
                
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)

                    subplot(2,1,2)
                    b = M_PSTH{BIT_Number,nn}*(1000/25);
                    Tlin = T(1:tm);
                    blin = b(1:tm);
                    maxb = max(blin);
                    % all_peaks{BIT_Number, nn}=maxb;
                    % all_time_series{BIT_Number, nn}=b;
                    aku = find(blin==maxb);
                    plot(Tlin, blin,'Color', COLORSET(nn,:), 'linewidth',1)  
                    text(Tlin(aku(1)), maxb, num2str(maxb));   
                    xlim([-200 1000])
                    subplot(2,1,1)
                    plot(PsthAndRaster.MySpikes{BIT_Number,trl}*1000-PRE_TIME*1000,ones(size(PsthAndRaster.MySpikes{BIT_Number,trl}),1)*trl,'.', 'Color', COLORSET(nn,:))
                    xlim([-200 1000])
                    [BIT_Number nn trl]
                    hold on
                    line([0 0], [0 trl], 'Color', 'k','linewidth',2);
                    hold on
                    line([800 800], [0 trl], 'Color', 'k','linewidth',2);
                    xlim([-200 1000])
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);

                    
                    if iposx == 15 && iposy == 0 && isz == 210.8
                        xlabel(['FAST RightLeft Moving Dots, Pattern 1', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -15 && iposy == 0 &&isz == 210.8
                        xlabel(['FAST LeftRight Moving Dots, Pattern 1', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 0 && iposy == 15 && isz == 210.8 
                        xlabel(['FAST UpDown Moving Dots, Pattern 1', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 0 && iposy == -15 && isz == 210.8
                        xlabel(['FAST DownUp Moving Dots, Pattern 1', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -10.6 && iposy == -10.6 && isz == 210.8
                        xlabel(['FAST UpRight Moving Dots, Pattern 1', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -10.6 && iposy == 10.6 && isz == 210.8
                        xlabel(['FAST DownRight Moving Dots, Pattern 1', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 10.6 && iposy == -10.6 && isz == 210.8 
                        xlabel(['FAST UpLeft Moving Dots, Pattern 1', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 10.6 && iposy == 10.6 && isz == 210.8
                        xlabel(['FAST DownLeft Moving Dots, Pattern 1', ', BitCode ', num2str(BIT_Number)]);
                       
                    end
                    
                    end


            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/Dots/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/Dots/R_',num2str(BIT_Number),'.fig'])
            close
            
            end
            
            
            if stim_pres_time > 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};


                ps=PsthAndRaster.Psth{BIT_Number,nn};
                trr=PsthAndRaster.Trials{BIT_Number,nn};
                M=ps(trr,:);
                M_PSTH{BIT_Number,nn}=mean(M);
                S_PSTH{BIT_Number,nn}=std(M)/sqrt(size(M,1));
                T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
                
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)

                    subplot(2,1,2)
                    b = M_PSTH{BIT_Number,nn}*(1000/25);
                    maxb = max(b);
                    % all_peaks{BIT_Number, nn}=maxb;
                    % all_time_series{BIT_Number, nn}=b;
                    aku = find(b==maxb);
                    plot(T,b,'Color', COLORSET(nn,:), 'linewidth',1)
                    text(T(aku(1)), maxb, num2str(maxb));     
                    xlim([-200 2200])
                    subplot(2,1,1)
                    plot(PsthAndRaster.MySpikes{BIT_Number,trl}*1000-PRE_TIME*1000,ones(size(PsthAndRaster.MySpikes{BIT_Number,trl}),1)*trl,'.', 'Color', COLORSET(nn,:))
                    xlim([-200 2200])
                    [BIT_Number nn trl]
                    hold on
                    line([0 0], [0 trl], 'Color', 'k','linewidth',2);
                    hold on
                    line([2000 2000], [0 trl], 'Color', 'k','linewidth',2);
                    xlim([-200 2200])
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);

                    
                    if iposx == 15 && iposy == 0 && isz == 210.8
                        xlabel(['SLOW RightLeft Moving Dots, Pattern 1', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -15 && iposy == 0 &&isz == 210.8
                        xlabel(['SLOW LeftRight Moving Dots, Pattern 1', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 0 && iposy == 15 && isz == 210.8 
                        xlabel(['SLOW UpDown Moving Dots, Pattern 1', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 0 && iposy == -15 && isz == 210.8
                        xlabel(['SLOW DownUp Moving Dots, Pattern 1', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -10.6 && iposy == -10.6 && isz == 210.8
                        xlabel(['SLOW UpRight Moving Dots, Pattern 1', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -10.6 && iposy == 10.6 && isz == 210.8
                        xlabel(['SLOW DownRight Moving Dots, Pattern 1', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 10.6 && iposy == -10.6 && isz == 210.8 
                        xlabel(['SLOW UpLeft Moving Dots, Pattern 1', ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 10.6 && iposy == 10.6 && isz == 210.8
                        xlabel(['SLOW DownLeft Moving Dots, Pattern 1', ', BitCode ', num2str(BIT_Number)]);
                       
                    end
                    
                    end


            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/Dots/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '/Dots/R_',num2str(BIT_Number),'.fig']) 
            close
            
            end
            end
            

        end

%         save([ww,'/RASTERS/PeaksnTimes.mat'], '% all_peaks', '% all_time_series', '-v7.3');
        clearvars -except COLORSET Fede_STIM_NU files neuronS nn object % all_peaks % all_time_series 

end
  

    
        
end