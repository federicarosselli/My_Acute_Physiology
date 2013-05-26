function My_Raster (DayOfRecording, Block, object)

% DayOfRecording = '12_4_2012'

% Block = 56

% object = 0 %(blank)
% object = -1 %(bar)
% object = 1 %(ent)
% object = 2 %(bun)
% object = 3 %(orca)
% object = 4 %(pingu)
% object = 111 %(0 deg 0.03 grating)
% object = 121 %(0 deg 0.05 grating)
% object = 131 %(0 deg 0.1 grating)
% object = 141 %(0 deg 0.4 grating)
% object = 112 %(45 deg 0.03 grating)
% object = 122 %(45 deg 0.05 grating)
% object = 132 %(45 deg 0.1 grating)
% object = 142 %(45 deg 0.4 grating)
% object = 113 %(90 deg 0.03 grating)
% object = 123 %(90 deg 0.05 grating)
% object = 133 %(90 deg 0.1 grating)
% object = 143 %(90 deg 0.4 grating)
% object = 114 %(135 deg 0.03 grating)
% object = 124 %(135 deg 0.05 grating)
% object = 134 %(135 deg 0.1 grating)
% object = 144 %(135 deg 0.4 grating)
% object = 21 %(dots pattern 1)
% object = 22 %(dots pattern 2)
% object = 23 %(dots pattern 3)
% object = 24 %(dots pattern 4)

my_folder = ['/zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_', char(DayOfRecording), '/ANALYSED/BlockS-', num2str(Block), '/BL_2/My_Structure/25'];
% my_folder = ['/zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_', , char(DayOfRecording), '/ANALYSED/Block-' , num2str(Block), '/My_Structure/25'];

addpath /zocconasphys1/chronic_inv_rec/codes/
load My_StimS

Cool_Psths
neuronS = BlockS_56_Movies;   %%% >>>>>>> optimize!!!


cd (my_folder)


COLORSET=varycolor(length(neuronS));


for nn = neuronS
    countolo=0;
        
    load(['PSTH_RASTER_', num2str(nn),'.mat'])
    load(['NEURON_', num2str(nn),'.mat'])
%     bitcodes = PsthAndRaster.BitCodes;
    bin=PsthAndRaster.BinSize;

    
    %%%% BLANKS
    %%%%%%%%%%%%%%%%
    
        if object == 0
        
        [a b]=ind2sub(size(Fede_STIM), find(Fede_STIM(1:270,2)==0));
        selected_bits = a';
        
            for BIT_Number = selected_bits

            a = PsthAndRaster.Trials{BIT_Number,nn}(1);
            stim_pres_time = (STIM_STOP(a)-STIM_START(a))*1000;
            
            if stim_pres_time >= 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                for bb=1:size(PsthAndRaster.Psth{BIT_Number,nn},2);   
                    if numel(PsthAndRaster.Trials{BIT_Number,nn})~=0
                    M_PSTH{BIT_Number,nn}(bb)=mean(N_PSTH(:,bb))/(bin);
                    S_PSTH{BIT_Number,nn}(bb)=std(N_PSTH(:,bb))/(sqrt(numel(PsthAndRaster.Trials{BIT_Number,nn}))*bin);
                    else
                    M_PSTH{BIT_Number,nn}(bb)=0;
                    S_PSTH{BIT_Number,nn}(bb)=0;
                    end
                end   
            
                T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)
                    
                    subplot(2,1,2)
                    plot(T,M_PSTH{BIT_Number,nn},'Color', COLORSET(nn,:), 'linewidth',1)   
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
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), 'Area ', char(My_Neurons.Area)]);
                    xlabel(['Long Blank ', num2str(BIT_Number)]);

                    end

            ww = cd;
            stringM=strcat('RASTERS/Blanks/', num2str(nn), '/Movies');
            mkdir(stringM);
            saveas(gcf,[ww,'/RASTERS/Blanks/', num2str(nn), '/Movies/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/Blanks/', num2str(nn), '/Movies/R_',num2str(BIT_Number),'.fig'])  
            close
            
            end
            
            if stim_pres_time < 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                for bb=1:size(PsthAndRaster.Psth{BIT_Number,nn},2);   
                    if numel(PsthAndRaster.Trials{BIT_Number,nn})~=0
                    M_PSTH{BIT_Number,nn}(bb)=mean(N_PSTH(:,bb))/(bin);
                    S_PSTH{BIT_Number,nn}(bb)=std(N_PSTH(:,bb))/(sqrt(numel(PsthAndRaster.Trials{BIT_Number,nn}))*bin);
                    else
                    M_PSTH{BIT_Number,nn}(bb)=0;
                    S_PSTH{BIT_Number,nn}(bb)=0;
                    end
                end   
                
            T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));             
            [int tm]=min(abs(T-450));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)

                    subplot(2,1,2)
                    plot(T(1:tm),M_PSTH{BIT_Number,nn}(1:tm),'Color', COLORSET(nn,:), 'linewidth',1)   
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
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), 'Area ', char(My_Neurons.Area)]);
                    xlabel(['Short Blank ', num2str(BIT_Number)]);

                    end

            ww = cd;
            stringS=strcat('RASTERS/Blanks/', num2str(nn), '/Static');
            mkdir(stringS);
            saveas(gcf,[ww,'/RASTERS/Blanks/', num2str(nn), '/Static/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/Blanks/', num2str(nn), '/Static/R_',num2str(BIT_Number),'.fig'])  
            close
            
            end
            
            end
     
     
    

    
    %%%% MOVING BARS
    %%%%%%%%%%%%%%%%
    
        elseif object == -1
        
        [a b]=ind2sub(size(Fede_STIM), find(Fede_STIM(1:270,2)==-1));
        selected_bits = a';
        
            for BIT_Number = selected_bits;
                
            isz = Fede_STIM(BIT_Number, 3); 
            fsz = Fede_STIM(BIT_Number, 4); 
            iposx = Fede_STIM(BIT_Number, 5); 
            fposx = Fede_STIM(BIT_Number, 6); 
            iposy = Fede_STIM(BIT_Number, 7); 
            fposy = Fede_STIM(BIT_Number, 8); 
            iinp = Fede_STIM(BIT_Number, 9); 
            finp = Fede_STIM(BIT_Number, 10); 

            a = PsthAndRaster.Trials{BIT_Number,nn}(1);
            stim_pres_time = (STIM_STOP(a)-STIM_START(a))*1000;
            
            if stim_pres_time >= 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                for bb=1:size(PsthAndRaster.Psth{BIT_Number,nn},2);   
                    if numel(PsthAndRaster.Trials{BIT_Number,nn})~=0
                    M_PSTH{BIT_Number,nn}(bb)=mean(N_PSTH(:,bb))/(bin);
                    S_PSTH{BIT_Number,nn}(bb)=std(N_PSTH(:,bb))/(sqrt(numel(PsthAndRaster.Trials{BIT_Number,nn}))*bin);
                    else
                    M_PSTH{BIT_Number,nn}(bb)=0;
                    S_PSTH{BIT_Number,nn}(bb)=0;
                    end
                end   

            
                T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)
                        
                    subplot(2,1,2)
                    plot(T,M_PSTH{BIT_Number,nn},'Color', COLORSET(nn,:), 'linewidth',1)   
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
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), 'Area ', char(My_Neurons.Area)]);
                    
                        if iposx == 15 && iposy == 0 && iinp == 0
                        xlabel(['RightLeft Moving Bar ', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx)]);
                        elseif iposx == -15 && iposy == 0 && iinp == 0
                        xlabel(['LeftRight Moving Bar ', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx)]);
                        elseif iposx == 0 && iposy == 15 && iinp == 0
                        xlabel(['UpDown Moving Bar', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 0 && iposy == -15 && iinp == 0
                        xlabel(['DownUp Moving Bar', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == -15 && iposy == -7.5 && iinp == 0
                        xlabel(['UpRight Moving Bar', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == -15 && iposy == 7.5 && iinp == 0
                        xlabel(['DownRight Moving Bar', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 15 && iposy == -7.5 && iinp == 0
                        xlabel(['UpLeft Moving Bar', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 15 && iposy == 7.5 && iinp == 0  
                        xlabel(['DownLeft Moving Bar', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 0 && iposy == 0 && iinp == -60  
                        xlabel(['Anti-Clockwise Moving Bar', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialInPlane ', num2str(iinp), ', FinalInPlane ', num2str(finp)]);
                        elseif iposx == 0 && iposy == 0 && iinp == 60 
                        xlabel(['Clockwise Moving Bar', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialInPlane ', num2str(iinp), ', FinalInPlane ', num2str(finp)]);
                        end
                        
                        
                    end

            ww = cd;
            stringM=strcat('RASTERS/Bars/', num2str(nn), '/Movies');
            mkdir(stringM);
            saveas(gcf,[ww,'/RASTERS/Bars/', num2str(nn), '/Movies/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/Bars/', num2str(nn), '/Movies/R_',num2str(BIT_Number),'.fig'])  
            close
            
            end
            
            if stim_pres_time < 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                for bb=1:size(PsthAndRaster.Psth{BIT_Number,nn},2);   
                    if numel(PsthAndRaster.Trials{BIT_Number,nn})~=0
                    M_PSTH{BIT_Number,nn}(bb)=mean(N_PSTH(:,bb))/(bin);
                    S_PSTH{BIT_Number,nn}(bb)=std(N_PSTH(:,bb))/(sqrt(numel(PsthAndRaster.Trials{BIT_Number,nn}))*bin);
                    else
                    M_PSTH{BIT_Number,nn}(bb)=0;
                    S_PSTH{BIT_Number,nn}(bb)=0;
                    end
                end   
            T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2)); %-200,2200,
            [int tm]=min(abs(T-450));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)

                    subplot(2,1,2)
                    plot(T(1:tm),M_PSTH{BIT_Number,nn}(1:tm),'Color', COLORSET(nn,:), 'linewidth',1)   
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
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), 'Area ', char(My_Neurons.Area)]) 
                    xlabel(['Static Bar ', num2str(BIT_Number), ', Size ', num2str(isz), ', Posx ', num2str(iposx), ', Posy ', num2str(iposy), ', InPlane ', num2str(iinp)]);

                    end

            ww = cd;
            stringS=strcat('RASTERS/Bars/', num2str(nn), '/Static');
            mkdir(stringS);
            saveas(gcf,[ww,'/RASTERS/Bars/', num2str(nn), '/Static/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/Bars/', num2str(nn), '/Static/R_',num2str(BIT_Number),'.fig'])  
            close
            
            end
            end
     
     
    
    
    %%%% ENTERPRISE
    %%%%%%%%%%%%%%%%
    
    elseif object == 1
        
        [a b]=ind2sub(size(Fede_STIM), find(Fede_STIM(1:270,2)==1));
        selected_bits = a';
        
            for BIT_Number = selected_bits;

            isz = Fede_STIM(BIT_Number, 3); 
            fsz = Fede_STIM(BIT_Number, 4); 
            iposx = Fede_STIM(BIT_Number, 5); 
            fposx = Fede_STIM(BIT_Number, 6); 
            iposy = Fede_STIM(BIT_Number, 7); 
            fposy = Fede_STIM(BIT_Number, 8); 
            iinp = Fede_STIM(BIT_Number, 9); 
            finp = Fede_STIM(BIT_Number, 10); 
            iaz = Fede_STIM(BIT_Number, 11); 
            faz = Fede_STIM(BIT_Number, 12); 
            
            
            a = PsthAndRaster.Trials{BIT_Number,nn}(1);
            stim_pres_time = (STIM_STOP(a)-STIM_START(a))*1000;
            
            if stim_pres_time >= 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                for bb=1:size(PsthAndRaster.Psth{BIT_Number,nn},2);   
                    if numel(PsthAndRaster.Trials{BIT_Number,nn})~=0
                    M_PSTH{BIT_Number,nn}(bb)=mean(N_PSTH(:,bb))/(bin);
                    S_PSTH{BIT_Number,nn}(bb)=std(N_PSTH(:,bb))/(sqrt(numel(PsthAndRaster.Trials{BIT_Number,nn}))*bin);
                    else
                    M_PSTH{BIT_Number,nn}(bb)=0;
                    S_PSTH{BIT_Number,nn}(bb)=0;
                    end
                end   

                T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)

                    subplot(2,1,2)
                    plot(T,M_PSTH{BIT_Number,nn},'Color', COLORSET(nn,:), 'linewidth',1)   
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
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), 'Area ', char(My_Neurons.Area)]);
                    
                        if iposx == 15 && iposy == 0 && iinp == 0 && iaz ==0 && isz == 35 && fsz == 35
                        xlabel(['RightLeft Moving Ent ', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx)]);
                        elseif iposx == -15 && iposy == 0 && iinp == 0 && iaz ==0 && isz == 35 && fsz == 35
                        xlabel(['LeftRight Moving Ent ', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx)]);
                        elseif iposx == 0 && iposy == 15 && iinp == 0 && iaz ==0 && isz == 35 && fsz == 35
                        xlabel(['UpDown Moving Ent', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 0 && iposy == -15 && iinp == 0 && iaz ==0 && isz == 35 && fsz == 35
                        xlabel(['DownUp Moving Ent', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == -15 && iposy == -7.5 && iinp == 0 && iaz ==0 && isz == 35 && fsz == 35
                        xlabel(['UpRight Moving Ent', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == -15 && iposy == 7.5 && iinp == 0 && iaz ==0 && isz == 35 && fsz == 35
                        xlabel(['DownRight Moving Ent', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 15 && iposy == -7.5 && iinp == 0 && iaz ==0 && isz == 35 && fsz == 35
                        xlabel(['UpLeft Moving Ent', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 15 && iposy == 7.5 && iinp == 0 && iaz ==0 && isz == 35 && fsz == 35
                        xlabel(['DownLeft Moving Ent', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 0 && iposy == 0 && iinp == -60 && iaz ==0 && isz == 35 && fsz == 35
                        xlabel(['Anti-Clockwise Moving Ent', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialInPlane ', num2str(iinp), ', FinalInPlane ', num2str(finp)]);
                        elseif iposx == 0 && iposy == 0 && iinp == 60 && iaz ==0 && isz == 35 && fsz == 35
                        xlabel(['Clockwise Moving Ent', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialInPlane ', num2str(iinp), ', FinalInPlane ', num2str(finp)]);
                        elseif iposx == 0 && iposy == 0 && iinp == 0 && iaz ==-60 && isz == 35 && fsz == 35
                        xlabel(['Azimuth Moving Ent', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialAzimuth ', num2str(iaz), ', FinalAzimuth ', num2str(faz)]);
                        elseif iposx == 0 && iposy == 0 && iinp == 0 && iaz ==-60 && isz == 20 && fsz == 55
                        xlabel(['Expanding Moving Ent', ', BitCode ', num2str(BIT_Number), ', InitialSize ', num2str(isz), ', FinaSize ', num2str(fsz)]);
                        elseif iposx == 0 && iposy == 0 && iinp == 0 && iaz ==-60 && isz == 55 && fsz == 20
                        xlabel(['Contracting Moving Ent', ', BitCode ', num2str(BIT_Number), ', InitialSize ', num2str(isz), ', FinaSize ', num2str(fsz)]);
                        end
                        
                    end

            ww = cd;
            stringM=strcat('RASTERS/Objects/ENT/', num2str(nn), '/Movies');
            mkdir(stringM);
            saveas(gcf,[ww,'/RASTERS/Objects/ENT/', num2str(nn), '/Movies/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/Objects/ENT/', num2str(nn), '/Movies/R_',num2str(BIT_Number),'.fig'])  
            close
            
            end
            
            if stim_pres_time < 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                for bb=1:size(PsthAndRaster.Psth{BIT_Number,nn},2);   
                    if numel(PsthAndRaster.Trials{BIT_Number,nn})~=0
                    M_PSTH{BIT_Number,nn}(bb)=mean(N_PSTH(:,bb))/(bin);
                    S_PSTH{BIT_Number,nn}(bb)=std(N_PSTH(:,bb))/(sqrt(numel(PsthAndRaster.Trials{BIT_Number,nn}))*bin);
                    else
                    M_PSTH{BIT_Number,nn}(bb)=0;
                    S_PSTH{BIT_Number,nn}(bb)=0;
                    end
                end   
                
            T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2)); %-200,2200,
            [int tm]=min(abs(T-450));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)
                        
                    subplot(2,1,2)
                    plot(T(1:tm),M_PSTH{BIT_Number,nn}(1:tm),'Color', COLORSET(nn,:), 'linewidth',1)   
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
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), 'Area ', char(My_Neurons.Area)]) 
                    xlabel(['Static Ent ', num2str(BIT_Number), ', Size ', num2str(isz), ', Posx ', num2str(iposx), ', Posy ', num2str(iposy), ', InPlane ', num2str(iinp), ', Azimuth ', num2str(iaz)]);

                    end

            ww = cd;
            stringS=strcat('RASTERS/Objects/ENT/', num2str(nn), '/Static');
            mkdir(stringS);
            saveas(gcf,[ww,'/RASTERS/Objects/ENT/', num2str(nn), '/Static/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/Objects/ENT/', num2str(nn), '/Static/R_',num2str(BIT_Number),'.fig'])  
            close
            
            end
            end
            
            
            
    %%%% BUNNY
    %%%%%%%%%%%%%%%%
    
    elseif object == 2
        
        [a b]=ind2sub(size(Fede_STIM), find(Fede_STIM(1:270,2)==2));
        selected_bits = a';
        
            for BIT_Number = selected_bits;

            isz = Fede_STIM(BIT_Number, 3); 
            fsz = Fede_STIM(BIT_Number, 4); 
            iposx = Fede_STIM(BIT_Number, 5); 
            fposx = Fede_STIM(BIT_Number, 6); 
            iposy = Fede_STIM(BIT_Number, 7); 
            fposy = Fede_STIM(BIT_Number, 8); 
            iinp = Fede_STIM(BIT_Number, 9); 
            finp = Fede_STIM(BIT_Number, 10); 
            iaz = Fede_STIM(BIT_Number, 11); 
            faz = Fede_STIM(BIT_Number, 12); 
            
            
            a = PsthAndRaster.Trials{BIT_Number,nn}(1);
            stim_pres_time = (STIM_STOP(a)-STIM_START(a))*1000;
            
            if stim_pres_time >= 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                for bb=1:size(PsthAndRaster.Psth{BIT_Number,nn},2);   
                    if numel(PsthAndRaster.Trials{BIT_Number,nn})~=0
                    M_PSTH{BIT_Number,nn}(bb)=mean(N_PSTH(:,bb))/(bin);
                    S_PSTH{BIT_Number,nn}(bb)=std(N_PSTH(:,bb))/(sqrt(numel(PsthAndRaster.Trials{BIT_Number,nn}))*bin);
                    else
                    M_PSTH{BIT_Number,nn}(bb)=0;
                    S_PSTH{BIT_Number,nn}(bb)=0;
                    end
                end   

                T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)

                    subplot(2,1,2)
                    plot(T,M_PSTH{BIT_Number,nn},'Color', COLORSET(nn,:), 'linewidth',1)   
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
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), 'Area ', char(My_Neurons.Area)]);
                    
                        if iposx == 15 && iposy == 0 && iinp == 0 && iaz ==0
                        xlabel(['RightLeft Moving Bunny ', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx)]);
                        elseif iposx == -15 && iposy == 0 && iinp == 0 && iaz ==0
                        xlabel(['LeftRight Moving Bunny ', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx)]);
                        elseif iposx == 0 && iposy == 15 && iinp == 0 && iaz ==0
                        xlabel(['UpDown Moving Bunny', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 0 && iposy == -15 && iinp == 0 && iaz ==0
                        xlabel(['DownUp Moving Bunny', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == -15 && iposy == -7.5 && iinp == 0 && iaz ==0
                        xlabel(['UpRight Moving Bunny', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == -15 && iposy == 7.5 && iinp == 0 && iaz ==0
                        xlabel(['DownRight Moving Bunny', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 15 && iposy == -7.5 && iinp == 0 && iaz ==0
                        xlabel(['UpLeft Moving Bunny', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 15 && iposy == 7.5 && iinp == 0 && iaz ==0
                        xlabel(['DownLeft Moving Bunny', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 0 && iposy == 0 && iinp == -60 && iaz ==0
                        xlabel(['Anti-Clockwise Moving Bunny', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialInPlane ', num2str(iinp), ', FinalInPlane ', num2str(finp)]);
                        elseif iposx == 0 && iposy == 0 && iinp == 60 && iaz ==0
                        xlabel(['Clockwise Moving Bunny', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialInPlane ', num2str(iinp), ', FinalInPlane ', num2str(finp)]);
                        elseif iposx == 0 && iposy == 0 && iinp == 0 && iaz ==-60
                        xlabel(['Azimuth Moving Bunny', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialAzimuth ', num2str(iaz), ', FinalAzimuth ', num2str(faz)]);
                        elseif iposx == 0 && iposy == 0 && iinp == 0 && iaz ==-60 && isz == 20 && fsz == 55
                        xlabel(['Expanding Moving Bunny', ', BitCode ', num2str(BIT_Number), ', InitialSize ', num2str(isz), ', FinaSize ', num2str(fsz)]);
                        elseif iposx == 0 && iposy == 0 && iinp == 0 && iaz ==-60 && isz == 55 && fsz == 20
                        xlabel(['Contracting Moving Bunny', ', BitCode ', num2str(BIT_Number), ', InitialSize ', num2str(isz), ', FinaSize ', num2str(fsz)]);
                        end
                    end

            ww = cd;
            stringM=strcat('RASTERS/Objects/BUN/', num2str(nn), '/Movies');
            mkdir(stringM);
            saveas(gcf,[ww,'/RASTERS/Objects/BUN/', num2str(nn), '/Movies/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/Objects/BUN/', num2str(nn), '/Movies/R_',num2str(BIT_Number),'.fig'])  
            close
            
            end
            
            if stim_pres_time < 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                for bb=1:size(PsthAndRaster.Psth{BIT_Number,nn},2);   
                    if numel(PsthAndRaster.Trials{BIT_Number,nn})~=0
                    M_PSTH{BIT_Number,nn}(bb)=mean(N_PSTH(:,bb))/(bin);
                    S_PSTH{BIT_Number,nn}(bb)=std(N_PSTH(:,bb))/(sqrt(numel(PsthAndRaster.Trials{BIT_Number,nn}))*bin);
                    else
                    M_PSTH{BIT_Number,nn}(bb)=0;
                    S_PSTH{BIT_Number,nn}(bb)=0;
                    end
                end   
                
            T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2)); %-200,2200,
            [int tm]=min(abs(T-450));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)
                        
                    subplot(2,1,2)
                    plot(T(1:tm),M_PSTH{BIT_Number,nn}(1:tm),'Color', COLORSET(nn,:), 'linewidth',1)   
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
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), 'Area ', char(My_Neurons.Area)]) 
                    xlabel(['Static Bun ', num2str(BIT_Number), ', Size ', num2str(isz), ', Posx ', num2str(iposx), ', Posy ', num2str(iposy), ', InPlane ', num2str(iinp), ', Azimuth ', num2str(iaz)]);

                    end

            ww = cd;
            stringS=strcat('RASTERS/Objects/BUN/', num2str(nn), '/Static');
            mkdir(stringS);
            saveas(gcf,[ww,'/RASTERS/Objects/BUN/', num2str(nn), '/Static/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/Objects/BUN/', num2str(nn), '/Static/R_',num2str(BIT_Number),'.fig'])  
            close
            
            end
            
        end
        
            
            
            
    %%%% ORCA
    %%%%%%%%%%%%%%%%
    
        elseif object == 3
        
        [a b]=ind2sub(size(Fede_STIM), find(Fede_STIM(1:270,2)==3));
        selected_bits = a';
        
            for BIT_Number = selected_bits;

            isz = Fede_STIM(BIT_Number, 3); 
            fsz = Fede_STIM(BIT_Number, 4); 
            iposx = Fede_STIM(BIT_Number, 5); 
            fposx = Fede_STIM(BIT_Number, 6); 
            iposy = Fede_STIM(BIT_Number, 7); 
            fposy = Fede_STIM(BIT_Number, 8); 
            iinp = Fede_STIM(BIT_Number, 9); 
            finp = Fede_STIM(BIT_Number, 10); 
            iaz = Fede_STIM(BIT_Number, 11); 
            faz = Fede_STIM(BIT_Number, 12); 
            
            
            a = PsthAndRaster.Trials{BIT_Number,nn}(1);
            stim_pres_time = (STIM_STOP(a)-STIM_START(a))*1000;
            
            if stim_pres_time >= 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                for bb=1:size(PsthAndRaster.Psth{BIT_Number,nn},2);   
                    if numel(PsthAndRaster.Trials{BIT_Number,nn})~=0
                    M_PSTH{BIT_Number,nn}(bb)=mean(N_PSTH(:,bb))/(bin);
                    S_PSTH{BIT_Number,nn}(bb)=std(N_PSTH(:,bb))/(sqrt(numel(PsthAndRaster.Trials{BIT_Number,nn}))*bin);
                    else
                    M_PSTH{BIT_Number,nn}(bb)=0;
                    S_PSTH{BIT_Number,nn}(bb)=0;
                    end
                end   

                T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)

                    subplot(2,1,2)
                    plot(T,M_PSTH{BIT_Number,nn},'Color', COLORSET(nn,:), 'linewidth',1)   
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
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), 'Area ', char(My_Neurons.Area)]);

                      if iposx == 15 && iposy == 0 && iinp == 0 && iaz ==0
                        xlabel(['RightLeft Moving Orca ', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx)]);
                        elseif iposx == -15 && iposy == 0 && iinp == 0 && iaz ==0
                        xlabel(['LeftRight Moving Orca ', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx)]);
                        elseif iposx == 0 && iposy == 15 && iinp == 0 && iaz ==0
                        xlabel(['UpDown Moving Orca', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 0 && iposy == -15 && iinp == 0 && iaz ==0
                        xlabel(['DownUp Moving Orca', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == -15 && iposy == -7.5 && iinp == 0 && iaz ==0
                        xlabel(['UpRight Moving Orca', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == -15 && iposy == 7.5 && iinp == 0 && iaz ==0
                        xlabel(['DownRight Moving Orca', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 15 && iposy == -7.5 && iinp == 0 && iaz ==0
                        xlabel(['UpLeft Moving Orca', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 15 && iposy == 7.5 && iinp == 0 && iaz ==0
                        xlabel(['DownLeft Moving Orca', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 0 && iposy == 0 && iinp == -60 && iaz ==0
                        xlabel(['Anti-Clockwise Moving Orca', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialInPlane ', num2str(iinp), ', FinalInPlane ', num2str(finp)]);
                        elseif iposx == 0 && iposy == 0 && iinp == 60 && iaz ==0
                        xlabel(['Clockwise Moving Orca', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialInPlane ', num2str(iinp), ', FinalInPlane ', num2str(finp)]);
                        elseif iposx == 0 && iposy == 0 && iinp == 0 && iaz ==-60
                        xlabel(['Azimuth Moving Orca', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialAzimuth ', num2str(iaz), ', FinalAzimuth ', num2str(faz)]);
                        elseif iposx == 0 && iposy == 0 && iinp == 0 && iaz ==-60 && isz == 20 && fsz == 55
                        xlabel(['Expanding Moving Orca', ', BitCode ', num2str(BIT_Number), ', InitialSize ', num2str(isz), ', FinaSize ', num2str(fsz)]);
                        elseif iposx == 0 && iposy == 0 && iinp == 0 && iaz ==-60 && isz == 55 && fsz == 20
                        xlabel(['Contracting Moving Orca', ', BitCode ', num2str(BIT_Number), ', InitialSize ', num2str(isz), ', FinaSize ', num2str(fsz)]);
                      end
                        
                    end

            ww = cd;
            stringM=strcat('RASTERS/Objects/ORCA/', num2str(nn), '/Movies');
            mkdir(stringM);
            saveas(gcf,[ww,'/RASTERS/Objects/ORCA/', num2str(nn), '/Movies/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/Objects/ORCA/', num2str(nn), '/Movies/R_',num2str(BIT_Number),'.fig'])  
            close
            
            end
            
            if stim_pres_time < 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                for bb=1:size(PsthAndRaster.Psth{BIT_Number,nn},2);   
                    if numel(PsthAndRaster.Trials{BIT_Number,nn})~=0
                    M_PSTH{BIT_Number,nn}(bb)=mean(N_PSTH(:,bb))/(bin);
                    S_PSTH{BIT_Number,nn}(bb)=std(N_PSTH(:,bb))/(sqrt(numel(PsthAndRaster.Trials{BIT_Number,nn}))*bin);
                    else
                    M_PSTH{BIT_Number,nn}(bb)=0;
                    S_PSTH{BIT_Number,nn}(bb)=0;
                    end
                end   
                
            T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2)); %-200,2200,
            [int tm]=min(abs(T-450));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)
                        
                    subplot(2,1,2)
                    plot(T(1:tm),M_PSTH{BIT_Number,nn}(1:tm),'Color', COLORSET(nn,:), 'linewidth',1)   
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
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), 'Area ', char(My_Neurons.Area)]) 
                    xlabel(['Static Orca ', num2str(BIT_Number), ', Size ', num2str(isz), ', Posx ', num2str(iposx), ', Posy ', num2str(iposy), ', InPlane ', num2str(iinp), ', Azimuth ', num2str(iaz)]);

                    end

            ww = cd;
            stringS=strcat('RASTERS/Objects/ORCA/', num2str(nn), '/Static');
            mkdir(stringS);
            saveas(gcf,[ww,'/RASTERS/Objects/ORCA/', num2str(nn), '/Static/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/Objects/ORCA/', num2str(nn), '/Static/R_',num2str(BIT_Number),'.fig'])  
            close
            
            end
            end
            
            
    %%%% PINGU
    %%%%%%%%%%%%%%%%
    
    elseif object == 4
        
        [a b]=ind2sub(size(Fede_STIM), find(Fede_STIM(1:270,2)==4));
        selected_bits = a';
        
            for BIT_Number = selected_bits;

            isz = Fede_STIM(BIT_Number, 3); 
            fsz = Fede_STIM(BIT_Number, 4); 
            iposx = Fede_STIM(BIT_Number, 5); 
            fposx = Fede_STIM(BIT_Number, 6); 
            iposy = Fede_STIM(BIT_Number, 7); 
            fposy = Fede_STIM(BIT_Number, 8); 
            iinp = Fede_STIM(BIT_Number, 9); 
            finp = Fede_STIM(BIT_Number, 10); 
            iaz = Fede_STIM(BIT_Number, 11); 
            faz = Fede_STIM(BIT_Number, 12); 
            
            
            a = PsthAndRaster.Trials{BIT_Number,nn}(1);
            stim_pres_time = (STIM_STOP(a)-STIM_START(a))*1000;
            
            if stim_pres_time >= 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                for bb=1:size(PsthAndRaster.Psth{BIT_Number,nn},2);   
                    if numel(PsthAndRaster.Trials{BIT_Number,nn})~=0
                    M_PSTH{BIT_Number,nn}(bb)=mean(N_PSTH(:,bb))/(bin);
                    S_PSTH{BIT_Number,nn}(bb)=std(N_PSTH(:,bb))/(sqrt(numel(PsthAndRaster.Trials{BIT_Number,nn}))*bin);
                    else
                    M_PSTH{BIT_Number,nn}(bb)=0;
                    S_PSTH{BIT_Number,nn}(bb)=0;
                    end
                end   

                T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)

                    subplot(2,1,2)
                    plot(T,M_PSTH{BIT_Number,nn},'Color', COLORSET(nn,:), 'linewidth',1)   
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
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), 'Area ', char(My_Neurons.Area)]);

                    if iposx == 15 && iposy == 0 && iinp == 0 && iaz ==0
                        xlabel(['RightLeft Moving Pingu ', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx)]);
                        elseif iposx == -15 && iposy == 0 && iinp == 0 && iaz ==0
                        xlabel(['LeftRight Moving Pingu ', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx)]);
                        elseif iposx == 0 && iposy == 15 && iinp == 0 && iaz ==0
                        xlabel(['UpDown Moving Pingu', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 0 && iposy == -15 && iinp == 0 && iaz ==0
                        xlabel(['DownUp Moving Pingu', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == -15 && iposy == -7.5 && iinp == 0 && iaz ==0
                        xlabel(['UpRight Moving Pingu', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == -15 && iposy == 7.5 && iinp == 0 && iaz ==0
                        xlabel(['DownRight Moving Pingu', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 15 && iposy == -7.5 && iinp == 0 && iaz ==0
                        xlabel(['UpLeft Moving Pingu', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 15 && iposy == 7.5 && iinp == 0 && iaz ==0
                        xlabel(['DownLeft Moving Pingu', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 0 && iposy == 0 && iinp == -60 && iaz ==0
                        xlabel(['Anti-Clockwise Moving Pingu', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialInPlane ', num2str(iinp), ', FinalInPlane ', num2str(finp)]);
                        elseif iposx == 0 && iposy == 0 && iinp == 60 && iaz ==0
                        xlabel(['Clockwise Moving Pingu', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialInPlane ', num2str(iinp), ', FinalInPlane ', num2str(finp)]);
                        elseif iposx == 0 && iposy == 0 && iinp == 0 && iaz ==-60
                        xlabel(['Azimuth Moving Pingu', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialAzimuth ', num2str(iaz), ', FinalAzimuth ', num2str(faz)]);
                        elseif iposx == 0 && iposy == 0 && iinp == 0 && iaz ==-60 && isz == 20 && fsz == 55
                        xlabel(['Expanding Moving Pingu', ', BitCode ', num2str(BIT_Number), ', InitialSize ', num2str(isz), ', FinaSize ', num2str(fsz)]);
                        elseif iposx == 0 && iposy == 0 && iinp == 0 && iaz ==-60 && isz == 55 && fsz == 20
                        xlabel(['Contracting Moving Pingu', ', BitCode ', num2str(BIT_Number), ', InitialSize ', num2str(isz), ', FinaSize ', num2str(fsz)]);
                    end
                      
                    end

            ww = cd;
            stringM=strcat('RASTERS/Objects/PINGU/', num2str(nn), '/Movies');
            mkdir(stringM);
            saveas(gcf,[ww,'/RASTERS/Objects/PINGU/', num2str(nn), '/Movies/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/Objects/PINGU/', num2str(nn), '/Movies/R_',num2str(BIT_Number),'.fig'])  
            close
            
            end
            
            if stim_pres_time < 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                for bb=1:size(PsthAndRaster.Psth{BIT_Number,nn},2);   
                    if numel(PsthAndRaster.Trials{BIT_Number,nn})~=0
                    M_PSTH{BIT_Number,nn}(bb)=mean(N_PSTH(:,bb))/(bin);
                    S_PSTH{BIT_Number,nn}(bb)=std(N_PSTH(:,bb))/(sqrt(numel(PsthAndRaster.Trials{BIT_Number,nn}))*bin);
                    else
                    M_PSTH{BIT_Number,nn}(bb)=0;
                    S_PSTH{BIT_Number,nn}(bb)=0;
                    end
                end   
                
            T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2)); %-200,2200,
            [int tm]=min(abs(T-450));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)
                        
                    subplot(2,1,2)
                    plot(T(1:tm),M_PSTH{BIT_Number,nn}(1:tm),'Color', COLORSET(nn,:), 'linewidth',1)   
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
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), 'Area ', char(My_Neurons.Area)]) 
                    xlabel(['Static Pingu ', num2str(BIT_Number), ', Size ', num2str(isz), ', Posx ', num2str(iposx), ', Posy ', num2str(iposy), ', InPlane ', num2str(iinp), ', Azimuth ', num2str(iaz)]);

                    end

            ww = cd;
            stringS=strcat('RASTERS/Objects/PINGU/', num2str(nn), '/Static');
            mkdir(stringS);
            saveas(gcf,[ww,'/RASTERS/Objects/PINGU/', num2str(nn), '/Static/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/Objects/PINGU/', num2str(nn), '/Static/R_',num2str(BIT_Number),'.fig'])  
            close
            
            end
            end
            
            
    %%%% GRATING 0.03 0 DEG
    %%%%%%%%%%%%%%%%%%%%%%%
    
    elseif object == 111
        
        [a b]=ind2sub(size(Fede_STIM), find(Fede_STIM(1:270,2)==111));
        selected_bits = a';
        
            for BIT_Number = selected_bits;

            iposx = Fede_STIM(BIT_Number, 5); 
            fposx = Fede_STIM(BIT_Number, 6); 
            iposy = Fede_STIM(BIT_Number, 7); 
            fposy = Fede_STIM(BIT_Number, 8); 
            
            a = PsthAndRaster.Trials{BIT_Number,nn}(1);
            stim_pres_time = (STIM_STOP(a)-STIM_START(a))*1000;
            
            if stim_pres_time >= 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                for bb=1:size(PsthAndRaster.Psth{BIT_Number,nn},2);   
                    if numel(PsthAndRaster.Trials{BIT_Number,nn})~=0
                    M_PSTH{BIT_Number,nn}(bb)=mean(N_PSTH(:,bb))/(bin);
                    S_PSTH{BIT_Number,nn}(bb)=std(N_PSTH(:,bb))/(sqrt(numel(PsthAndRaster.Trials{BIT_Number,nn}))*bin);
                    else
                    M_PSTH{BIT_Number,nn}(bb)=0;
                    S_PSTH{BIT_Number,nn}(bb)=0;
                    end
                end   

                T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)

                    subplot(2,1,2)
                    plot(T,M_PSTH{BIT_Number,nn},'Color', COLORSET(nn,:), 'linewidth',1)   
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
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), 'Area ', char(My_Neurons.Area)]);

                    
                    if iposx == 15 && iposy == 0 && iinp == 0 && iaz ==0
                        xlabel(['RightLeft Moving Grating, SF 0.03, OR 0', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx)]);
                        elseif iposx == -15 && iposy == 0 && iinp == 0 && iaz ==0
                        xlabel(['LeftRight Moving Grating, SF 0.03, OR 0', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx)]);
                        elseif iposx == 0 && iposy == 15 && iinp == 0 && iaz ==0
                        xlabel(['UpDown Moving Grating, SF 0.03, OR 0', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 0 && iposy == -15 && iinp == 0 && iaz ==0
                        xlabel(['DownUp Moving Grating, SF 0.03, OR 0', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == -15 && iposy == -7.5 && iinp == 0 && iaz ==0
                        xlabel(['UpRight Moving Grating, SF 0.03, OR 0', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == -15 && iposy == 7.5 && iinp == 0 && iaz ==0
                        xlabel(['DownRight Moving Grating, SF 0.03, OR 0', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 15 && iposy == -7.5 && iinp == 0 && iaz ==0
                        xlabel(['UpLeft Moving Grating, SF 0.03, OR 0', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 15 && iposy == 7.5 && iinp == 0 && iaz ==0
                        xlabel(['DownLeft Moving Grating, SF 0.03, OR 0', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        
                    end
                    
                    end

            ww = cd;
            stringM=strcat('RASTERS/Gratings/0.03/G_0.03_0/', num2str(nn), '/Movies');
            mkdir(stringM);
            saveas(gcf,[ww,'/RASTERS/Gratings/0.03/G_0.03_0/', num2str(nn), '/Movies/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/Gratings/0.03/G_0.03_0/', num2str(nn), '/Movies/R_',num2str(BIT_Number),'.fig'])  
            close
            
            end
            
            if stim_pres_time < 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                for bb=1:size(PsthAndRaster.Psth{BIT_Number,nn},2);   
                    if numel(PsthAndRaster.Trials{BIT_Number,nn})~=0
                    M_PSTH{BIT_Number,nn}(bb)=mean(N_PSTH(:,bb))/(bin);
                    S_PSTH{BIT_Number,nn}(bb)=std(N_PSTH(:,bb))/(sqrt(numel(PsthAndRaster.Trials{BIT_Number,nn}))*bin);
                    else
                    M_PSTH{BIT_Number,nn}(bb)=0;
                    S_PSTH{BIT_Number,nn}(bb)=0;
                    end
                end   
                
            T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2)); %-200,2200,
            [int tm]=min(abs(T-450));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)
                        
                    subplot(2,1,2)
                    plot(T(1:tm),M_PSTH{BIT_Number,nn}(1:tm),'Color', COLORSET(nn,:), 'linewidth',1)   
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
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), 'Area ', char(My_Neurons.Area)]) 
                    xlabel(['Static Grating, SF 0.03, OR 0 ', num2str(BIT_Number)]);

                    end

            ww = cd;
            stringS=strcat('RASTERS/Gratings/0.03/G_0.03_0/', num2str(nn), '/Static');
            mkdir(stringS);
            saveas(gcf,[ww,'/RASTERS/Gratings/0.03/G_0.03_0/', num2str(nn), '/Static/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/Gratings/0.03/G_0.03_0/', num2str(nn), '/Static/R_',num2str(BIT_Number),'.fig'])  
            close
            
            end
            end
            
            
            
    %%%% GRATING 0.05 0 DEG
    %%%%%%%%%%%%%%%%%%%%%%%
    
        elseif object == 121
        
        [a b]=ind2sub(size(Fede_STIM), find(Fede_STIM(1:270,2)==121));
        selected_bits = a';
        
            for BIT_Number = selected_bits;

            iposx = Fede_STIM(BIT_Number, 5); 
            fposx = Fede_STIM(BIT_Number, 6); 
            iposy = Fede_STIM(BIT_Number, 7); 
            fposy = Fede_STIM(BIT_Number, 8); 
            
            a = PsthAndRaster.Trials{BIT_Number,nn}(1);
            stim_pres_time = (STIM_STOP(a)-STIM_START(a))*1000;
            
            if stim_pres_time >= 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                for bb=1:size(PsthAndRaster.Psth{BIT_Number,nn},2);   
                    if numel(PsthAndRaster.Trials{BIT_Number,nn})~=0
                    M_PSTH{BIT_Number,nn}(bb)=mean(N_PSTH(:,bb))/(bin);
                    S_PSTH{BIT_Number,nn}(bb)=std(N_PSTH(:,bb))/(sqrt(numel(PsthAndRaster.Trials{BIT_Number,nn}))*bin);
                    else
                    M_PSTH{BIT_Number,nn}(bb)=0;
                    S_PSTH{BIT_Number,nn}(bb)=0;
                    end
                end   

                T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)

                    subplot(2,1,2)
                    plot(T,M_PSTH{BIT_Number,nn},'Color', COLORSET(nn,:), 'linewidth',1)   
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
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), 'Area ', char(My_Neurons.Area)]);

                    if iposx == 15 && iposy == 0 && iinp == 0 && iaz ==0
                        xlabel(['RightLeft Moving Grating, SF 0.05, OR 0', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx)]);
                        elseif iposx == -15 && iposy == 0 && iinp == 0 && iaz ==0
                        xlabel(['LeftRight Moving Grating, SF 0.05, OR 0', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx)]);
                        elseif iposx == 0 && iposy == 15 && iinp == 0 && iaz ==0
                        xlabel(['UpDown Moving Grating, SF 0.05, OR 0', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 0 && iposy == -15 && iinp == 0 && iaz ==0
                        xlabel(['DownUp Moving Grating, SF 0.05, OR 0', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == -15 && iposy == -7.5 && iinp == 0 && iaz ==0
                        xlabel(['UpRight Moving Grating, SF 0.05, OR 0', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == -15 && iposy == 7.5 && iinp == 0 && iaz ==0
                        xlabel(['DownRight Moving Grating, SF 0.05, OR 0', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 15 && iposy == -7.5 && iinp == 0 && iaz ==0
                        xlabel(['UpLeft Moving Grating, SF 0.05, OR 0', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 15 && iposy == 7.5 && iinp == 0 && iaz ==0
                        xlabel(['DownLeft Moving Grating, SF 0.05, OR 0', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        
                    end
                    end

            ww = cd;
            stringM=strcat('RASTERS/Gratings/0.05/G_0.05_0/', num2str(nn), '/Movies');
            mkdir(stringM);
            saveas(gcf,[ww,'/RASTERS/Gratings/0.05/G_0.05_0/', num2str(nn), '/Movies/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/Gratings/0.05/G_0.05_0/', num2str(nn), '/Movies/R_',num2str(BIT_Number),'.fig'])  
            close
            
            end
            
            if stim_pres_time < 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                for bb=1:size(PsthAndRaster.Psth{BIT_Number,nn},2);   
                    if numel(PsthAndRaster.Trials{BIT_Number,nn})~=0
                    M_PSTH{BIT_Number,nn}(bb)=mean(N_PSTH(:,bb))/(bin);
                    S_PSTH{BIT_Number,nn}(bb)=std(N_PSTH(:,bb))/(sqrt(numel(PsthAndRaster.Trials{BIT_Number,nn}))*bin);
                    else
                    M_PSTH{BIT_Number,nn}(bb)=0;
                    S_PSTH{BIT_Number,nn}(bb)=0;
                    end
                end   
                
            T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2)); %-200,2200,
            [int tm]=min(abs(T-450));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)
                        
                    subplot(2,1,2)
                    plot(T(1:tm),M_PSTH{BIT_Number,nn}(1:tm),'Color', COLORSET(nn,:), 'linewidth',1)   
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
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), 'Area ', char(My_Neurons.Area)]) 
                    xlabel(['Static Grating, SF 0.05, OR 0 ', num2str(BIT_Number)]);

                    end

            ww = cd;
            stringS=strcat('RASTERS/Gratings/0.05/G_0.05_0/', num2str(nn), '/Static');
            mkdir(stringS);
            saveas(gcf,[ww,'/RASTERS/Gratings/0.05/G_0.05_0/', num2str(nn), '/Static/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/Gratings/0.05/G_0.05_0/', num2str(nn), '/Static/R_',num2str(BIT_Number),'.fig'])  
            close
            
            end
            end
            
            
            
    %%%% GRATING 0.1 0 DEG
    %%%%%%%%%%%%%%%%%%%%%%%
    
        elseif object == 131
        
        [a b]=ind2sub(size(Fede_STIM), find(Fede_STIM(1:270,2)==131));
        selected_bits = a';
        
            for BIT_Number = selected_bits;

            iposx = Fede_STIM(BIT_Number, 5); 
            fposx = Fede_STIM(BIT_Number, 6); 
            iposy = Fede_STIM(BIT_Number, 7); 
            fposy = Fede_STIM(BIT_Number, 8); 
            
            a = PsthAndRaster.Trials{BIT_Number,nn}(1);
            stim_pres_time = (STIM_STOP(a)-STIM_START(a))*1000;
            
            if stim_pres_time >= 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                for bb=1:size(PsthAndRaster.Psth{BIT_Number,nn},2);   
                    if numel(PsthAndRaster.Trials{BIT_Number,nn})~=0
                    M_PSTH{BIT_Number,nn}(bb)=mean(N_PSTH(:,bb))/(bin);
                    S_PSTH{BIT_Number,nn}(bb)=std(N_PSTH(:,bb))/(sqrt(numel(PsthAndRaster.Trials{BIT_Number,nn}))*bin);
                    else
                    M_PSTH{BIT_Number,nn}(bb)=0;
                    S_PSTH{BIT_Number,nn}(bb)=0;
                    end
                end   

                T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)

                    subplot(2,1,2)
                    plot(T,M_PSTH{BIT_Number,nn},'Color', COLORSET(nn,:), 'linewidth',1)   
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
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), 'Area ', char(My_Neurons.Area)]);

                    if iposx == 15 && iposy == 0 && iinp == 0 && iaz ==0
                        xlabel(['RightLeft Moving Grating, SF 0.1, OR 0', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx)]);
                        elseif iposx == -15 && iposy == 0 && iinp == 0 && iaz ==0
                        xlabel(['LeftRight Moving Grating, SF 0.1, OR 0', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx)]);
                        elseif iposx == 0 && iposy == 15 && iinp == 0 && iaz ==0
                        xlabel(['UpDown Moving Grating, SF 0.1, OR 0', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 0 && iposy == -15 && iinp == 0 && iaz ==0
                        xlabel(['DownUp Moving Grating, SF 0.1, OR 0', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == -15 && iposy == -7.5 && iinp == 0 && iaz ==0
                        xlabel(['UpRight Moving Grating, SF 0.1, OR 0', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == -15 && iposy == 7.5 && iinp == 0 && iaz ==0
                        xlabel(['DownRight Moving Grating, SF 0.1, OR 0', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 15 && iposy == -7.5 && iinp == 0 && iaz ==0
                        xlabel(['UpLeft Moving Grating, SF 0.1, OR 0', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 15 && iposy == 7.5 && iinp == 0 && iaz ==0
                        xlabel(['DownLeft Moving Grating, SF 0.1, OR 0', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        
                    end
                    end

            ww = cd;
            stringM=strcat('RASTERS/Gratings/0.1/G_0.1_0/', num2str(nn), '/Movies');
            mkdir(stringM);
            saveas(gcf,[ww,'/RASTERS/Gratings/0.1/G_0.1_0/', num2str(nn), '/Movies/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/Gratings/0.1/G_0.1_0/', num2str(nn), '/Movies/R_',num2str(BIT_Number),'.fig'])  
            close
            
            end
            
            if stim_pres_time < 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                for bb=1:size(PsthAndRaster.Psth{BIT_Number,nn},2);   
                    if numel(PsthAndRaster.Trials{BIT_Number,nn})~=0
                    M_PSTH{BIT_Number,nn}(bb)=mean(N_PSTH(:,bb))/(bin);
                    S_PSTH{BIT_Number,nn}(bb)=std(N_PSTH(:,bb))/(sqrt(numel(PsthAndRaster.Trials{BIT_Number,nn}))*bin);
                    else
                    M_PSTH{BIT_Number,nn}(bb)=0;
                    S_PSTH{BIT_Number,nn}(bb)=0;
                    end
                end   
                
            T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2)); %-200,2200,
            [int tm]=min(abs(T-450));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)
                        
                    subplot(2,1,2)
                    plot(T(1:tm),M_PSTH{BIT_Number,nn}(1:tm),'Color', COLORSET(nn,:), 'linewidth',1)   
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
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), 'Area ', char(My_Neurons.Area)]) 
                    xlabel(['Static Grating, SF 0.1, OR 0 ', num2str(BIT_Number)]);

                    end

            ww = cd;
            stringS=strcat('RASTERS/Gratings/0.1/G_0.1_0/', num2str(nn), '/Static');
            mkdir(stringS);
            saveas(gcf,[ww,'/RASTERS/Gratings/0.1/G_0.1_0/', num2str(nn), '/Static/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/Gratings/0.1/G_0.1_0/', num2str(nn), '/Static/R_',num2str(BIT_Number),'.fig'])  
            close
            
            end
            end
            
            
    %%%% GRATING 0.4 0 DEG
    %%%%%%%%%%%%%%%%%%%%%%%
    
        elseif object == 141
        
        [a b]=ind2sub(size(Fede_STIM), find(Fede_STIM(1:270,2)==141));
        selected_bits = a';
        
            for BIT_Number = selected_bits;

            iposx = Fede_STIM(BIT_Number, 5); 
            fposx = Fede_STIM(BIT_Number, 6); 
            iposy = Fede_STIM(BIT_Number, 7); 
            fposy = Fede_STIM(BIT_Number, 8); 
            
            a = PsthAndRaster.Trials{BIT_Number,nn}(1);
            stim_pres_time = (STIM_STOP(a)-STIM_START(a))*1000;
            
            if stim_pres_time >= 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                for bb=1:size(PsthAndRaster.Psth{BIT_Number,nn},2);   
                    if numel(PsthAndRaster.Trials{BIT_Number,nn})~=0
                    M_PSTH{BIT_Number,nn}(bb)=mean(N_PSTH(:,bb))/(bin);
                    S_PSTH{BIT_Number,nn}(bb)=std(N_PSTH(:,bb))/(sqrt(numel(PsthAndRaster.Trials{BIT_Number,nn}))*bin);
                    else
                    M_PSTH{BIT_Number,nn}(bb)=0;
                    S_PSTH{BIT_Number,nn}(bb)=0;
                    end
                end   

                T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)

                    subplot(2,1,2)
                    plot(T,M_PSTH{BIT_Number,nn},'Color', COLORSET(nn,:), 'linewidth',1)   
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
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), 'Area ', char(My_Neurons.Area)]);

                    if iposx == 15 && iposy == 0 && iinp == 0 && iaz ==0
                        xlabel(['RightLeft Moving Grating, SF 0.4, OR 0', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx)]);
                        elseif iposx == -15 && iposy == 0 && iinp == 0 && iaz ==0
                        xlabel(['LeftRight Moving Grating, SF 0.4, OR 0', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx)]);
                        elseif iposx == 0 && iposy == 15 && iinp == 0 && iaz ==0
                        xlabel(['UpDown Moving Grating, SF 0.4, OR 0', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 0 && iposy == -15 && iinp == 0 && iaz ==0
                        xlabel(['DownUp Moving Grating, SF 0.4, OR 0', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == -15 && iposy == -7.5 && iinp == 0 && iaz ==0
                        xlabel(['UpRight Moving Grating, SF 0.4, OR 0', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == -15 && iposy == 7.5 && iinp == 0 && iaz ==0
                        xlabel(['DownRight Moving Grating, SF 0.4, OR 0', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 15 && iposy == -7.5 && iinp == 0 && iaz ==0
                        xlabel(['UpLeft Moving Grating, SF 0.4, OR 0', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 15 && iposy == 7.5 && iinp == 0 && iaz ==0
                        xlabel(['DownLeft Moving Grating, SF 0.4, OR 0', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        
                    end
                    end

            ww = cd;
            stringM=strcat('RASTERS/Gratings/0.4/G_0.4_0/', num2str(nn), '/Movies');
            mkdir(stringM);
            saveas(gcf,[ww,'/RASTERS/Gratings/0.4/G_0.4_0/', num2str(nn), '/Movies/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/Gratings/0.4/G_0.4_0/', num2str(nn), '/Movies/R_',num2str(BIT_Number),'.fig'])  
            close
            
            end
            
            if stim_pres_time < 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                for bb=1:size(PsthAndRaster.Psth{BIT_Number,nn},2);   
                    if numel(PsthAndRaster.Trials{BIT_Number,nn})~=0
                    M_PSTH{BIT_Number,nn}(bb)=mean(N_PSTH(:,bb))/(bin);
                    S_PSTH{BIT_Number,nn}(bb)=std(N_PSTH(:,bb))/(sqrt(numel(PsthAndRaster.Trials{BIT_Number,nn}))*bin);
                    else
                    M_PSTH{BIT_Number,nn}(bb)=0;
                    S_PSTH{BIT_Number,nn}(bb)=0;
                    end
                end   
                
            T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2)); %-200,2200,
            [int tm]=min(abs(T-450));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)
                        
                    subplot(2,1,2)
                    plot(T(1:tm),M_PSTH{BIT_Number,nn}(1:tm),'Color', COLORSET(nn,:), 'linewidth',1)   
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
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), 'Area ', char(My_Neurons.Area)]) 
                    xlabel(['Static Grating, SF 0.4, OR 0 ', num2str(BIT_Number)]);

                    end

            ww = cd;
            stringS=strcat('RASTERS/Gratings/0.4/G_0.4_0/', num2str(nn), '/Static');
            mkdir(stringS);
            saveas(gcf,[ww,'/RASTERS/Gratings/0.4/G_0.4_0/', num2str(nn), '/Static/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/Gratings/0.4/G_0.4_0/', num2str(nn), '/Static/R_',num2str(BIT_Number),'.fig'])  
            close
            
            end
            end
            
            
            
    %%%% GRATING 0.03 45 DEG
    %%%%%%%%%%%%%%%%%%%%%%%
    
    elseif object == 112
        
        [a b]=ind2sub(size(Fede_STIM), find(Fede_STIM(1:270,2)==112));
        selected_bits = a';
        
            for BIT_Number = selected_bits;

            iposx = Fede_STIM(BIT_Number, 5); 
            fposx = Fede_STIM(BIT_Number, 6); 
            iposy = Fede_STIM(BIT_Number, 7); 
            fposy = Fede_STIM(BIT_Number, 8); 
            
            a = PsthAndRaster.Trials{BIT_Number,nn}(1);
            stim_pres_time = (STIM_STOP(a)-STIM_START(a))*1000;
            
            if stim_pres_time >= 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                for bb=1:size(PsthAndRaster.Psth{BIT_Number,nn},2);   
                    if numel(PsthAndRaster.Trials{BIT_Number,nn})~=0
                    M_PSTH{BIT_Number,nn}(bb)=mean(N_PSTH(:,bb))/(bin);
                    S_PSTH{BIT_Number,nn}(bb)=std(N_PSTH(:,bb))/(sqrt(numel(PsthAndRaster.Trials{BIT_Number,nn}))*bin);
                    else
                    M_PSTH{BIT_Number,nn}(bb)=0;
                    S_PSTH{BIT_Number,nn}(bb)=0;
                    end
                end   

                T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)

                    subplot(2,1,2)
                    plot(T,M_PSTH{BIT_Number,nn},'Color', COLORSET(nn,:), 'linewidth',1)   
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
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), 'Area ', char(My_Neurons.Area)]);

                    if iposx == 15 && iposy == 0 && iinp == 0 && iaz ==0
                        xlabel(['RightLeft Moving Grating, SF 0.03, OR 45', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx)]);
                        elseif iposx == -15 && iposy == 0 && iinp == 0 && iaz ==0
                        xlabel(['LeftRight Moving Grating, SF 0.03, OR 45', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx)]);
                        elseif iposx == 0 && iposy == 15 && iinp == 0 && iaz ==0
                        xlabel(['UpDown Moving Grating, SF 0.03, OR 45', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 0 && iposy == -15 && iinp == 0 && iaz ==0
                        xlabel(['DownUp Moving Grating, SF 0.03, OR 45', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == -15 && iposy == -7.5 && iinp == 0 && iaz ==0
                        xlabel(['UpRight Moving Grating, SF 0.03, OR 45', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == -15 && iposy == 7.5 && iinp == 0 && iaz ==0
                        xlabel(['DownRight Moving Grating, SF 0.03, OR 45', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 15 && iposy == -7.5 && iinp == 0 && iaz ==0
                        xlabel(['UpLeft Moving Grating, SF 0.03, OR 45', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 15 && iposy == 7.5 && iinp == 0 && iaz ==0
                        xlabel(['DownLeft Moving Grating, SF 0.03, OR 45', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        
                    end
                    end

            ww = cd;
            stringM=strcat('RASTERS/Gratings/0.03/G_0.03_45/', num2str(nn), '/Movies');
            mkdir(stringM);
            saveas(gcf,[ww,'/RASTERS/Gratings/0.03/G_0.03_45/', num2str(nn), '/Movies/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/Gratings/0.03/G_0.03_45/', num2str(nn), '/Movies/R_',num2str(BIT_Number),'.fig'])  
            close
            
            end
            
            if stim_pres_time < 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                for bb=1:size(PsthAndRaster.Psth{BIT_Number,nn},2);   
                    if numel(PsthAndRaster.Trials{BIT_Number,nn})~=0
                    M_PSTH{BIT_Number,nn}(bb)=mean(N_PSTH(:,bb))/(bin);
                    S_PSTH{BIT_Number,nn}(bb)=std(N_PSTH(:,bb))/(sqrt(numel(PsthAndRaster.Trials{BIT_Number,nn}))*bin);
                    else
                    M_PSTH{BIT_Number,nn}(bb)=0;
                    S_PSTH{BIT_Number,nn}(bb)=0;
                    end
                end   
                
            T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2)); %-200,2200,
            [int tm]=min(abs(T-450));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)
                        
                    subplot(2,1,2)
                    plot(T(1:tm),M_PSTH{BIT_Number,nn}(1:tm),'Color', COLORSET(nn,:), 'linewidth',1)   
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
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), 'Area ', char(My_Neurons.Area)]) 
                    xlabel(['Static Grating, SF 0.03, OR 45 ', num2str(BIT_Number)]);

                    end

            ww = cd;
            stringS=strcat('RASTERS/Gratings/0.03/G_0.03_45/', num2str(nn), '/Static');
            mkdir(stringS);
            saveas(gcf,[ww,'/RASTERS/Gratings/0.03/G_0.03_45/', num2str(nn), '/Static/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/Gratings/0.03/G_0.03_45/', num2str(nn), '/Static/R_',num2str(BIT_Number),'.fig'])  
            close
            
            end
            end
            
            
            
    %%%% GRATING 0.05 45 DEG
    %%%%%%%%%%%%%%%%%%%%%%%
    
        elseif object == 122
        
        [a b]=ind2sub(size(Fede_STIM), find(Fede_STIM(1:270,2)==122));
        selected_bits = a';
        
            for BIT_Number = selected_bits;

            iposx = Fede_STIM(BIT_Number, 5); 
            fposx = Fede_STIM(BIT_Number, 6); 
            iposy = Fede_STIM(BIT_Number, 7); 
            fposy = Fede_STIM(BIT_Number, 8); 
            
            a = PsthAndRaster.Trials{BIT_Number,nn}(1);
            stim_pres_time = (STIM_STOP(a)-STIM_START(a))*1000;
            
            if stim_pres_time >= 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                for bb=1:size(PsthAndRaster.Psth{BIT_Number,nn},2);   
                    if numel(PsthAndRaster.Trials{BIT_Number,nn})~=0
                    M_PSTH{BIT_Number,nn}(bb)=mean(N_PSTH(:,bb))/(bin);
                    S_PSTH{BIT_Number,nn}(bb)=std(N_PSTH(:,bb))/(sqrt(numel(PsthAndRaster.Trials{BIT_Number,nn}))*bin);
                    else
                    M_PSTH{BIT_Number,nn}(bb)=0;
                    S_PSTH{BIT_Number,nn}(bb)=0;
                    end
                end   

                T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)

                    subplot(2,1,2)
                    plot(T,M_PSTH{BIT_Number,nn},'Color', COLORSET(nn,:), 'linewidth',1)   
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
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), 'Area ', char(My_Neurons.Area)]);

                    if iposx == 15 && iposy == 0 && iinp == 0 && iaz ==0
                        xlabel(['RightLeft Moving Grating, SF 0.05, OR 45', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx)]);
                        elseif iposx == -15 && iposy == 0 && iinp == 0 && iaz ==0
                        xlabel(['LeftRight Moving Grating, SF 0.05, OR 45', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx)]);
                        elseif iposx == 0 && iposy == 15 && iinp == 0 && iaz ==0
                        xlabel(['UpDown Moving Grating, SF 0.05, OR 45', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 0 && iposy == -15 && iinp == 0 && iaz ==0
                        xlabel(['DownUp Moving Grating, SF 0.05, OR 45', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == -15 && iposy == -7.5 && iinp == 0 && iaz ==0
                        xlabel(['UpRight Moving Grating, SF 0.05, OR 45', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == -15 && iposy == 7.5 && iinp == 0 && iaz ==0
                        xlabel(['DownRight Moving Grating, SF 0.05, OR 45', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 15 && iposy == -7.5 && iinp == 0 && iaz ==0
                        xlabel(['UpLeft Moving Grating, SF 0.05, OR 45', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 15 && iposy == 7.5 && iinp == 0 && iaz ==0
                        xlabel(['DownLeft Moving Grating, SF 0.05, OR 45', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        
                    end
                    end

            ww = cd;
            stringM=strcat('RASTERS/Gratings/0.05/G_0.05_45/', num2str(nn), '/Movies');
            mkdir(stringM);
            saveas(gcf,[ww,'/RASTERS/Gratings/0.05/G_0.05_45/', num2str(nn), '/Movies/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/Gratings/0.05/G_0.05_45/', num2str(nn), '/Movies/R_',num2str(BIT_Number),'.fig'])  
            close
            
            end
            
            if stim_pres_time < 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                for bb=1:size(PsthAndRaster.Psth{BIT_Number,nn},2);   
                    if numel(PsthAndRaster.Trials{BIT_Number,nn})~=0
                    M_PSTH{BIT_Number,nn}(bb)=mean(N_PSTH(:,bb))/(bin);
                    S_PSTH{BIT_Number,nn}(bb)=std(N_PSTH(:,bb))/(sqrt(numel(PsthAndRaster.Trials{BIT_Number,nn}))*bin);
                    else
                    M_PSTH{BIT_Number,nn}(bb)=0;
                    S_PSTH{BIT_Number,nn}(bb)=0;
                    end
                end   
                
            T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2)); %-200,2200,
            [int tm]=min(abs(T-450));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)
                        
                    subplot(2,1,2)
                    plot(T(1:tm),M_PSTH{BIT_Number,nn}(1:tm),'Color', COLORSET(nn,:), 'linewidth',1)   
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
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), 'Area ', char(My_Neurons.Area)]) 
                    xlabel(['Static Grating, SF 0.05, OR 45 ', num2str(BIT_Number)]);

                    end

            ww = cd;
            stringS=strcat('RASTERS/Gratings/0.05/G_0.05_45/', num2str(nn), '/Static');
            mkdir(stringS);
            saveas(gcf,[ww,'/RASTERS/Gratings/0.05/G_0.05_45/', num2str(nn), '/Static/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/Gratings/0.05/G_0.05_45/', num2str(nn), '/Static/R_',num2str(BIT_Number),'.fig'])  
            close
            
            end
            end
            
            
            
    %%%% GRATING 0.1 45 DEG
    %%%%%%%%%%%%%%%%%%%%%%%
    
        elseif object == 132
        
        [a b]=ind2sub(size(Fede_STIM), find(Fede_STIM(1:270,2)==132));
        selected_bits = a';
        
            for BIT_Number = selected_bits;

            iposx = Fede_STIM(BIT_Number, 5); 
            fposx = Fede_STIM(BIT_Number, 6); 
            iposy = Fede_STIM(BIT_Number, 7); 
            fposy = Fede_STIM(BIT_Number, 8); 
            
            a = PsthAndRaster.Trials{BIT_Number,nn}(1);
            stim_pres_time = (STIM_STOP(a)-STIM_START(a))*1000;
            
            if stim_pres_time >= 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                for bb=1:size(PsthAndRaster.Psth{BIT_Number,nn},2);   
                    if numel(PsthAndRaster.Trials{BIT_Number,nn})~=0
                    M_PSTH{BIT_Number,nn}(bb)=mean(N_PSTH(:,bb))/(bin);
                    S_PSTH{BIT_Number,nn}(bb)=std(N_PSTH(:,bb))/(sqrt(numel(PsthAndRaster.Trials{BIT_Number,nn}))*bin);
                    else
                    M_PSTH{BIT_Number,nn}(bb)=0;
                    S_PSTH{BIT_Number,nn}(bb)=0;
                    end
                end   

                T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)

                    subplot(2,1,2)
                    plot(T,M_PSTH{BIT_Number,nn},'Color', COLORSET(nn,:), 'linewidth',1)   
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
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), 'Area ', char(My_Neurons.Area)]);

                    if iposx == 15 && iposy == 0 && iinp == 0 && iaz ==0
                        xlabel(['RightLeft Moving Grating, SF 0.1, OR 45', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx)]);
                        elseif iposx == -15 && iposy == 0 && iinp == 0 && iaz ==0
                        xlabel(['LeftRight Moving Grating, SF 0.1, OR 45', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx)]);
                        elseif iposx == 0 && iposy == 15 && iinp == 0 && iaz ==0
                        xlabel(['UpDown Moving Grating, SF 0.1, OR 45', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 0 && iposy == -15 && iinp == 0 && iaz ==0
                        xlabel(['DownUp Moving Grating, SF 0.1, OR 45', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == -15 && iposy == -7.5 && iinp == 0 && iaz ==0
                        xlabel(['UpRight Moving Grating, SF 0.1, OR 45', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == -15 && iposy == 7.5 && iinp == 0 && iaz ==0
                        xlabel(['DownRight Moving Grating, SF 0.1, OR 45', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 15 && iposy == -7.5 && iinp == 0 && iaz ==0
                        xlabel(['UpLeft Moving Grating, SF 0.1, OR 45', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 15 && iposy == 7.5 && iinp == 0 && iaz ==0
                        xlabel(['DownLeft Moving Grating, SF 0.1, OR 45', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        
                    end
                    end

            ww = cd;
            stringM=strcat('RASTERS/Gratings/0.1/G_0.1_45/', num2str(nn), '/Movies');
            mkdir(stringM);
            saveas(gcf,[ww,'/RASTERS/Gratings/0.1/G_0.1_45/', num2str(nn), '/Movies/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/Gratings/0.1/G_0.1_45/', num2str(nn), '/Movies/R_',num2str(BIT_Number),'.fig'])  
            close
            
            end
            
            if stim_pres_time < 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                for bb=1:size(PsthAndRaster.Psth{BIT_Number,nn},2);   
                    if numel(PsthAndRaster.Trials{BIT_Number,nn})~=0
                    M_PSTH{BIT_Number,nn}(bb)=mean(N_PSTH(:,bb))/(bin);
                    S_PSTH{BIT_Number,nn}(bb)=std(N_PSTH(:,bb))/(sqrt(numel(PsthAndRaster.Trials{BIT_Number,nn}))*bin);
                    else
                    M_PSTH{BIT_Number,nn}(bb)=0;
                    S_PSTH{BIT_Number,nn}(bb)=0;
                    end
                end   
                
            T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2)); %-200,2200,
            [int tm]=min(abs(T-450));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)
                        
                    subplot(2,1,2)
                    plot(T(1:tm),M_PSTH{BIT_Number,nn}(1:tm),'Color', COLORSET(nn,:), 'linewidth',1)   
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
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), 'Area ', char(My_Neurons.Area)]) 
                    xlabel(['Static Grating, SF 0.1, OR 45 ', num2str(BIT_Number)]);

                    end

            ww = cd;
            stringS=strcat('RASTERS/Gratings/0.1/G_0.1_45/', num2str(nn), '/Static');
            mkdir(stringS);
            saveas(gcf,[ww,'/RASTERS/Gratings/0.1/G_0.1_45/', num2str(nn), '/Static/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/Gratings/0.1/G_0.1_45/', num2str(nn), '/Static/R_',num2str(BIT_Number),'.fig'])  
            close
            
            end
            end
            
            
            
    %%%% GRATING 0.4 45 DEG
    %%%%%%%%%%%%%%%%%%%%%%%
    
        elseif object == 142
        
        [a b]=ind2sub(size(Fede_STIM), find(Fede_STIM(1:270,2)==142));
        selected_bits = a';
        
            for BIT_Number = selected_bits;

            iposx = Fede_STIM(BIT_Number, 5); 
            fposx = Fede_STIM(BIT_Number, 6); 
            iposy = Fede_STIM(BIT_Number, 7); 
            fposy = Fede_STIM(BIT_Number, 8); 
            
            a = PsthAndRaster.Trials{BIT_Number,nn}(1);
            stim_pres_time = (STIM_STOP(a)-STIM_START(a))*1000;
            
            if stim_pres_time >= 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                for bb=1:size(PsthAndRaster.Psth{BIT_Number,nn},2);   
                    if numel(PsthAndRaster.Trials{BIT_Number,nn})~=0
                    M_PSTH{BIT_Number,nn}(bb)=mean(N_PSTH(:,bb))/(bin);
                    S_PSTH{BIT_Number,nn}(bb)=std(N_PSTH(:,bb))/(sqrt(numel(PsthAndRaster.Trials{BIT_Number,nn}))*bin);
                    else
                    M_PSTH{BIT_Number,nn}(bb)=0;
                    S_PSTH{BIT_Number,nn}(bb)=0;
                    end
                end   

                T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)

                    subplot(2,1,2)
                    plot(T,M_PSTH{BIT_Number,nn},'Color', COLORSET(nn,:), 'linewidth',1)   
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
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), 'Area ', char(My_Neurons.Area)]);

                    if iposx == 15 && iposy == 0 && iinp == 0 && iaz ==0
                        xlabel(['RightLeft Moving Grating, SF 0.4, OR 45', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx)]);
                        elseif iposx == -15 && iposy == 0 && iinp == 0 && iaz ==0
                        xlabel(['LeftRight Moving Grating, SF 0.4, OR 45', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx)]);
                        elseif iposx == 0 && iposy == 15 && iinp == 0 && iaz ==0
                        xlabel(['UpDown Moving Grating, SF 0.4, OR 45', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 0 && iposy == -15 && iinp == 0 && iaz ==0
                        xlabel(['DownUp Moving Grating, SF 0.4, OR 45', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == -15 && iposy == -7.5 && iinp == 0 && iaz ==0
                        xlabel(['UpRight Moving Grating, SF 0.4, OR 45', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == -15 && iposy == 7.5 && iinp == 0 && iaz ==0
                        xlabel(['DownRight Moving Grating, SF 0.4, OR 45', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 15 && iposy == -7.5 && iinp == 0 && iaz ==0
                        xlabel(['UpLeft Moving Grating, SF 0.4, OR 45', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 15 && iposy == 7.5 && iinp == 0 && iaz ==0
                        xlabel(['DownLeft Moving Grating, SF 0.4, OR 45', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        
                    end
                    end

            ww = cd;
            stringM=strcat('RASTERS/Gratings/0.4/G_0.4_45/', num2str(nn), '/Movies');
            mkdir(stringM);
            saveas(gcf,[ww,'/RASTERS/Gratings/0.4/G_0.4_45/', num2str(nn), '/Movies/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/Gratings/0.4/G_0.4_45/', num2str(nn), '/Movies/R_',num2str(BIT_Number),'.fig'])  
            close
            
            end
            
            if stim_pres_time < 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                for bb=1:size(PsthAndRaster.Psth{BIT_Number,nn},2);   
                    if numel(PsthAndRaster.Trials{BIT_Number,nn})~=0
                    M_PSTH{BIT_Number,nn}(bb)=mean(N_PSTH(:,bb))/(bin);
                    S_PSTH{BIT_Number,nn}(bb)=std(N_PSTH(:,bb))/(sqrt(numel(PsthAndRaster.Trials{BIT_Number,nn}))*bin);
                    else
                    M_PSTH{BIT_Number,nn}(bb)=0;
                    S_PSTH{BIT_Number,nn}(bb)=0;
                    end
                end   
                
            T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2)); %-200,2200,
            [int tm]=min(abs(T-450));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)
                        
                    subplot(2,1,2)
                    plot(T(1:tm),M_PSTH{BIT_Number,nn}(1:tm),'Color', COLORSET(nn,:), 'linewidth',1)   
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
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), 'Area ', char(My_Neurons.Area)]) 
                    xlabel(['Static Grating, SF 0.4, OR 45 ', num2str(BIT_Number)]);

                    end

            ww = cd;
            stringS=strcat('RASTERS/Gratings/0.4/G_0.4_45/', num2str(nn), '/Static');
            mkdir(stringS);
            saveas(gcf,[ww,'/RASTERS/Gratings/0.4/G_0.4_45/', num2str(nn), '/Static/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/Gratings/0.4/G_0.4_45/', num2str(nn), '/Static/R_',num2str(BIT_Number),'.fig'])  
            close
            
            end
            end
            
            
            
    %%%% GRATING 0.03 90 DEG
    %%%%%%%%%%%%%%%%%%%%%%%
    
    elseif object == 113
        
        [a b]=ind2sub(size(Fede_STIM), find(Fede_STIM(1:270,2)==113));
        selected_bits = a';
        
            for BIT_Number = selected_bits;

            iposx = Fede_STIM(BIT_Number, 5); 
            fposx = Fede_STIM(BIT_Number, 6); 
            iposy = Fede_STIM(BIT_Number, 7); 
            fposy = Fede_STIM(BIT_Number, 8); 
            
            a = PsthAndRaster.Trials{BIT_Number,nn}(1);
            stim_pres_time = (STIM_STOP(a)-STIM_START(a))*1000;
            
            if stim_pres_time >= 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                for bb=1:size(PsthAndRaster.Psth{BIT_Number,nn},2);   
                    if numel(PsthAndRaster.Trials{BIT_Number,nn})~=0
                    M_PSTH{BIT_Number,nn}(bb)=mean(N_PSTH(:,bb))/(bin);
                    S_PSTH{BIT_Number,nn}(bb)=std(N_PSTH(:,bb))/(sqrt(numel(PsthAndRaster.Trials{BIT_Number,nn}))*bin);
                    else
                    M_PSTH{BIT_Number,nn}(bb)=0;
                    S_PSTH{BIT_Number,nn}(bb)=0;
                    end
                end   

                T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)

                    subplot(2,1,2)
                    plot(T,M_PSTH{BIT_Number,nn},'Color', COLORSET(nn,:), 'linewidth',1)   
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
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), 'Area ', char(My_Neurons.Area)]);

                    if iposx == 15 && iposy == 0 && iinp == 0 && iaz ==0
                        xlabel(['RightLeft Moving Grating, SF 0.03, OR 90', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx)]);
                        elseif iposx == -15 && iposy == 0 && iinp == 0 && iaz ==0
                        xlabel(['LeftRight Moving Grating, SF 0.03, OR 90', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx)]);
                        elseif iposx == 0 && iposy == 15 && iinp == 0 && iaz ==0
                        xlabel(['UpDown Moving Grating, SF 0.03, OR 90', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 0 && iposy == -15 && iinp == 0 && iaz ==0
                        xlabel(['DownUp Moving Grating, SF 0.03, OR 90', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == -15 && iposy == -7.5 && iinp == 0 && iaz ==0
                        xlabel(['UpRight Moving Grating, SF 0.03, OR 90', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == -15 && iposy == 7.5 && iinp == 0 && iaz ==0
                        xlabel(['DownRight Moving Grating, SF 0.03, OR 90', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 15 && iposy == -7.5 && iinp == 0 && iaz ==0
                        xlabel(['UpLeft Moving Grating, SF 0.03, OR 90', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 15 && iposy == 7.5 && iinp == 0 && iaz ==0
                        xlabel(['DownLeft Moving Grating, SF 0.03, OR 90', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        
                    end
                    end

            ww = cd;
            stringM=strcat('RASTERS/Gratings/0.03/G_0.03_90/', num2str(nn), '/Movies');
            mkdir(stringM);
            saveas(gcf,[ww,'/RASTERS/Gratings/0.03/G_0.03_90/', num2str(nn), '/Movies/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/Gratings/0.03/G_0.03_90/', num2str(nn), '/Movies/R_',num2str(BIT_Number),'.fig'])  
            close
            
            end
            
            if stim_pres_time < 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                for bb=1:size(PsthAndRaster.Psth{BIT_Number,nn},2);   
                    if numel(PsthAndRaster.Trials{BIT_Number,nn})~=0
                    M_PSTH{BIT_Number,nn}(bb)=mean(N_PSTH(:,bb))/(bin);
                    S_PSTH{BIT_Number,nn}(bb)=std(N_PSTH(:,bb))/(sqrt(numel(PsthAndRaster.Trials{BIT_Number,nn}))*bin);
                    else
                    M_PSTH{BIT_Number,nn}(bb)=0;
                    S_PSTH{BIT_Number,nn}(bb)=0;
                    end
                end   
                
            T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2)); %-200,2200,
            [int tm]=min(abs(T-450));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)
                        
                    subplot(2,1,2)
                    plot(T(1:tm),M_PSTH{BIT_Number,nn}(1:tm),'Color', COLORSET(nn,:), 'linewidth',1)   
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
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), 'Area ', char(My_Neurons.Area)]) 
                    xlabel(['Static Grating, SF 0.03, OR 90 ', num2str(BIT_Number)]);

                    end

            ww = cd;
            stringS=strcat('RASTERS/Gratings/0.03/G_0.03_90/', num2str(nn), '/Static');
            mkdir(stringS);
            saveas(gcf,[ww,'/RASTERS/Gratings/0.03/G_0.03_90/', num2str(nn), '/Static/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/Gratings/0.03/G_0.03_90/', num2str(nn), '/Static/R_',num2str(BIT_Number),'.fig'])  
            close
            
            end
            end
            
            
            
    %%%% GRATING 0.05 90 DEG
    %%%%%%%%%%%%%%%%%%%%%%%
    
        elseif object == 123
        
        [a b]=ind2sub(size(Fede_STIM), find(Fede_STIM(1:270,2)==123));
        selected_bits = a';
        
            for BIT_Number = selected_bits;

            iposx = Fede_STIM(BIT_Number, 5); 
            fposx = Fede_STIM(BIT_Number, 6); 
            iposy = Fede_STIM(BIT_Number, 7); 
            fposy = Fede_STIM(BIT_Number, 8); 
            
            a = PsthAndRaster.Trials{BIT_Number,nn}(1);
            stim_pres_time = (STIM_STOP(a)-STIM_START(a))*1000;
            
            if stim_pres_time >= 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                for bb=1:size(PsthAndRaster.Psth{BIT_Number,nn},2);   
                    if numel(PsthAndRaster.Trials{BIT_Number,nn})~=0
                    M_PSTH{BIT_Number,nn}(bb)=mean(N_PSTH(:,bb))/(bin);
                    S_PSTH{BIT_Number,nn}(bb)=std(N_PSTH(:,bb))/(sqrt(numel(PsthAndRaster.Trials{BIT_Number,nn}))*bin);
                    else
                    M_PSTH{BIT_Number,nn}(bb)=0;
                    S_PSTH{BIT_Number,nn}(bb)=0;
                    end
                end   

                T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)

                    subplot(2,1,2)
                    plot(T,M_PSTH{BIT_Number,nn},'Color', COLORSET(nn,:), 'linewidth',1)   
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
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), 'Area ', char(My_Neurons.Area)]);

                    if iposx == 15 && iposy == 0 && iinp == 0 && iaz ==0
                        xlabel(['RightLeft Moving Grating, SF 0.05, OR 90', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx)]);
                        elseif iposx == -15 && iposy == 0 && iinp == 0 && iaz ==0
                        xlabel(['LeftRight Moving Grating, SF 0.05, OR 90', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx)]);
                        elseif iposx == 0 && iposy == 15 && iinp == 0 && iaz ==0
                        xlabel(['UpDown Moving Grating, SF 0.05, OR 90', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 0 && iposy == -15 && iinp == 0 && iaz ==0
                        xlabel(['DownUp Moving Grating, SF 0.05, OR 90', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == -15 && iposy == -7.5 && iinp == 0 && iaz ==0
                        xlabel(['UpRight Moving Grating, SF 0.05, OR 90', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == -15 && iposy == 7.5 && iinp == 0 && iaz ==0
                        xlabel(['DownRight Moving Grating, SF 0.05, OR 90', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 15 && iposy == -7.5 && iinp == 0 && iaz ==0
                        xlabel(['UpLeft Moving Grating, SF 0.05, OR 90', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 15 && iposy == 7.5 && iinp == 0 && iaz ==0
                        xlabel(['DownLeft Moving Grating, SF 0.05, OR 90', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        
                    end
                    end

            ww = cd;
            stringM=strcat('RASTERS/Gratings/0.05/G_0.05_90/', num2str(nn), '/Movies');
            mkdir(stringM);
            saveas(gcf,[ww,'/RASTERS/Gratings/0.05/G_0.05_90/', num2str(nn), '/Movies/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/Gratings/0.05/G_0.05_90/', num2str(nn), '/Movies/R_',num2str(BIT_Number),'.fig'])  
            close
            
            end
            
            if stim_pres_time < 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                for bb=1:size(PsthAndRaster.Psth{BIT_Number,nn},2);   
                    if numel(PsthAndRaster.Trials{BIT_Number,nn})~=0
                    M_PSTH{BIT_Number,nn}(bb)=mean(N_PSTH(:,bb))/(bin);
                    S_PSTH{BIT_Number,nn}(bb)=std(N_PSTH(:,bb))/(sqrt(numel(PsthAndRaster.Trials{BIT_Number,nn}))*bin);
                    else
                    M_PSTH{BIT_Number,nn}(bb)=0;
                    S_PSTH{BIT_Number,nn}(bb)=0;
                    end
                end   
                
            T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2)); %-200,2200,
            [int tm]=min(abs(T-450));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)
                        
                    subplot(2,1,2)
                    plot(T(1:tm),M_PSTH{BIT_Number,nn}(1:tm),'Color', COLORSET(nn,:), 'linewidth',1)   
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
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), 'Area ', char(My_Neurons.Area)]) 
                    xlabel(['Static Grating, SF 0.05, OR 90 ', num2str(BIT_Number)]);

                    end

            ww = cd;
            stringS=strcat('RASTERS/Gratings/0.05/G_0.05_90/', num2str(nn), '/Static');
            mkdir(stringS);
            saveas(gcf,[ww,'/RASTERS/Gratings/0.05/G_0.05_90/', num2str(nn), '/Static/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/Gratings/0.05/G_0.05_90/', num2str(nn), '/Static/R_',num2str(BIT_Number),'.fig'])  
            close
            
            end
            end
            
            
            
    %%%% GRATING 0.1 90 DEG
    %%%%%%%%%%%%%%%%%%%%%%%
    
        elseif object == 133
        
        [a b]=ind2sub(size(Fede_STIM), find(Fede_STIM(1:270,2)==133));
        selected_bits = a';
        
            for BIT_Number = selected_bits;

            iposx = Fede_STIM(BIT_Number, 5); 
            fposx = Fede_STIM(BIT_Number, 6); 
            iposy = Fede_STIM(BIT_Number, 7); 
            fposy = Fede_STIM(BIT_Number, 8); 
            
            a = PsthAndRaster.Trials{BIT_Number,nn}(1);
            stim_pres_time = (STIM_STOP(a)-STIM_START(a))*1000;
            
            if stim_pres_time >= 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                for bb=1:size(PsthAndRaster.Psth{BIT_Number,nn},2);   
                    if numel(PsthAndRaster.Trials{BIT_Number,nn})~=0
                    M_PSTH{BIT_Number,nn}(bb)=mean(N_PSTH(:,bb))/(bin);
                    S_PSTH{BIT_Number,nn}(bb)=std(N_PSTH(:,bb))/(sqrt(numel(PsthAndRaster.Trials{BIT_Number,nn}))*bin);
                    else
                    M_PSTH{BIT_Number,nn}(bb)=0;
                    S_PSTH{BIT_Number,nn}(bb)=0;
                    end
                end   

                T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)

                    subplot(2,1,2)
                    plot(T,M_PSTH{BIT_Number,nn},'Color', COLORSET(nn,:), 'linewidth',1)   
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
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), 'Area ', char(My_Neurons.Area)]);

                    if iposx == 15 && iposy == 0 && iinp == 0 && iaz ==0
                        xlabel(['RightLeft Moving Grating, SF 0.1, OR 90', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx)]);
                        elseif iposx == -15 && iposy == 0 && iinp == 0 && iaz ==0
                        xlabel(['LeftRight Moving Grating, SF 0.1, OR 90', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx)]);
                        elseif iposx == 0 && iposy == 15 && iinp == 0 && iaz ==0
                        xlabel(['UpDown Moving Grating, SF 0.1, OR 90', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 0 && iposy == -15 && iinp == 0 && iaz ==0
                        xlabel(['DownUp Moving Grating, SF 0.1, OR 90', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == -15 && iposy == -7.5 && iinp == 0 && iaz ==0
                        xlabel(['UpRight Moving Grating, SF 0.1, OR 90', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == -15 && iposy == 7.5 && iinp == 0 && iaz ==0
                        xlabel(['DownRight Moving Grating, SF 0.1, OR 90', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 15 && iposy == -7.5 && iinp == 0 && iaz ==0
                        xlabel(['UpLeft Moving Grating, SF 0.1, OR 90', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 15 && iposy == 7.5 && iinp == 0 && iaz ==0
                        xlabel(['DownLeft Moving Grating, SF 0.1, OR 90', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        
                    end
                    end

            ww = cd;
            stringM=strcat('RASTERS/Gratings/0.1/G_0.1_90/', num2str(nn), '/Movies');
            mkdir(stringM);
            saveas(gcf,[ww,'/RASTERS/Gratings/0.1/G_0.1_90/', num2str(nn), '/Movies/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/Gratings/0.1/G_0.1_90/', num2str(nn), '/Movies/R_',num2str(BIT_Number),'.fig'])  
            close
            
            end
            
            if stim_pres_time < 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                for bb=1:size(PsthAndRaster.Psth{BIT_Number,nn},2);   
                    if numel(PsthAndRaster.Trials{BIT_Number,nn})~=0
                    M_PSTH{BIT_Number,nn}(bb)=mean(N_PSTH(:,bb))/(bin);
                    S_PSTH{BIT_Number,nn}(bb)=std(N_PSTH(:,bb))/(sqrt(numel(PsthAndRaster.Trials{BIT_Number,nn}))*bin);
                    else
                    M_PSTH{BIT_Number,nn}(bb)=0;
                    S_PSTH{BIT_Number,nn}(bb)=0;
                    end
                end   
                
            T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2)); %-200,2200,
            [int tm]=min(abs(T-450));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)
                        
                    subplot(2,1,2)
                    plot(T(1:tm),M_PSTH{BIT_Number,nn}(1:tm),'Color', COLORSET(nn,:), 'linewidth',1)   
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
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), 'Area ', char(My_Neurons.Area)]) 
                    xlabel(['Static Grating, SF 0.1, OR 90 ', num2str(BIT_Number)]);

                    end

            ww = cd;
            stringS=strcat('RASTERS/Gratings/0.1/G_0.1_90/', num2str(nn), '/Static');
            mkdir(stringS);
            saveas(gcf,[ww,'/RASTERS/Gratings/0.1/G_0.1_90/', num2str(nn), '/Static/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/Gratings/0.1/G_0.1_90/', num2str(nn), '/Static/R_',num2str(BIT_Number),'.fig'])  
            close
            
            end
            end
            
            
            
    %%%% GRATING 0.4 90 DEG
    %%%%%%%%%%%%%%%%%%%%%%%
    
        elseif object == 143
        
        [a b]=ind2sub(size(Fede_STIM), find(Fede_STIM(1:270,2)==143));
        selected_bits = a';
        
            for BIT_Number = selected_bits;

            iposx = Fede_STIM(BIT_Number, 5); 
            fposx = Fede_STIM(BIT_Number, 6); 
            iposy = Fede_STIM(BIT_Number, 7); 
            fposy = Fede_STIM(BIT_Number, 8); 
            
            a = PsthAndRaster.Trials{BIT_Number,nn}(1);
            stim_pres_time = (STIM_STOP(a)-STIM_START(a))*1000;
            
            if stim_pres_time >= 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                for bb=1:size(PsthAndRaster.Psth{BIT_Number,nn},2);   
                    if numel(PsthAndRaster.Trials{BIT_Number,nn})~=0
                    M_PSTH{BIT_Number,nn}(bb)=mean(N_PSTH(:,bb))/(bin);
                    S_PSTH{BIT_Number,nn}(bb)=std(N_PSTH(:,bb))/(sqrt(numel(PsthAndRaster.Trials{BIT_Number,nn}))*bin);
                    else
                    M_PSTH{BIT_Number,nn}(bb)=0;
                    S_PSTH{BIT_Number,nn}(bb)=0;
                    end
                end   

                T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)

                    subplot(2,1,2)
                    plot(T,M_PSTH{BIT_Number,nn},'Color', COLORSET(nn,:), 'linewidth',1)   
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
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), 'Area ', char(My_Neurons.Area)]);

                    if iposx == 15 && iposy == 0 && iinp == 0 && iaz ==0
                        xlabel(['RightLeft Moving Grating, SF 0.4, OR 90', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx)]);
                        elseif iposx == -15 && iposy == 0 && iinp == 0 && iaz ==0
                        xlabel(['LeftRight Moving Grating, SF 0.4, OR 90', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx)]);
                        elseif iposx == 0 && iposy == 15 && iinp == 0 && iaz ==0
                        xlabel(['UpDown Moving Grating, SF 0.4, OR 90', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 0 && iposy == -15 && iinp == 0 && iaz ==0
                        xlabel(['DownUp Moving Grating, SF 0.4, OR 90', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == -15 && iposy == -7.5 && iinp == 0 && iaz ==0
                        xlabel(['UpRight Moving Grating, SF 0.4, OR 90', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == -15 && iposy == 7.5 && iinp == 0 && iaz ==0
                        xlabel(['DownRight Moving Grating, SF 0.4, OR 90', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 15 && iposy == -7.5 && iinp == 0 && iaz ==0
                        xlabel(['UpLeft Moving Grating, SF 0.4, OR 90', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 15 && iposy == 7.5 && iinp == 0 && iaz ==0
                        xlabel(['DownLeft Moving Grating, SF 0.4, OR 90', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        
                    end
                    end

            ww = cd;
            stringM=strcat('RASTERS/Gratings/0.4/G_0.4_90/', num2str(nn), '/Movies');
            mkdir(stringM);
            saveas(gcf,[ww,'/RASTERS/Gratings/0.4/G_0.4_90/', num2str(nn), '/Movies/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/Gratings/0.4/G_0.4_90/', num2str(nn), '/Movies/R_',num2str(BIT_Number),'.fig'])  
            close
            
            end
            
            if stim_pres_time < 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                for bb=1:size(PsthAndRaster.Psth{BIT_Number,nn},2);   
                    if numel(PsthAndRaster.Trials{BIT_Number,nn})~=0
                    M_PSTH{BIT_Number,nn}(bb)=mean(N_PSTH(:,bb))/(bin);
                    S_PSTH{BIT_Number,nn}(bb)=std(N_PSTH(:,bb))/(sqrt(numel(PsthAndRaster.Trials{BIT_Number,nn}))*bin);
                    else
                    M_PSTH{BIT_Number,nn}(bb)=0;
                    S_PSTH{BIT_Number,nn}(bb)=0;
                    end
                end   
                
            T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2)); %-200,2200,
            [int tm]=min(abs(T-450));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)
                        
                    subplot(2,1,2)
                    plot(T(1:tm),M_PSTH{BIT_Number,nn}(1:tm),'Color', COLORSET(nn,:), 'linewidth',1)   
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
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), 'Area ', char(My_Neurons.Area)]) 
                    xlabel(['Static Grating, SF 0.4, OR 90 ', num2str(BIT_Number)]);

                    end

            ww = cd;
            stringS=strcat('RASTERS/Gratings/0.4/G_0.4_90/', num2str(nn), '/Static');
            mkdir(stringS);
            saveas(gcf,[ww,'/RASTERS/Gratings/0.4/G_0.4_90/', num2str(nn), '/Static/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/Gratings/0.4/G_0.4_90/', num2str(nn), '/Static/R_',num2str(BIT_Number),'.fig'])  
            close
            
            end
            end
            
            
            
    %%%% GRATING 0.03 135 DEG
    %%%%%%%%%%%%%%%%%%%%%%%
    
    elseif object == 114
        
        [a b]=ind2sub(size(Fede_STIM), find(Fede_STIM(1:270,2)==114));
        selected_bits = a';
        
            for BIT_Number = selected_bits;

            iposx = Fede_STIM(BIT_Number, 5); 
            fposx = Fede_STIM(BIT_Number, 6); 
            iposy = Fede_STIM(BIT_Number, 7); 
            fposy = Fede_STIM(BIT_Number, 8); 
            
            a = PsthAndRaster.Trials{BIT_Number,nn}(1);
            stim_pres_time = (STIM_STOP(a)-STIM_START(a))*1000;
            
            if stim_pres_time >= 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                for bb=1:size(PsthAndRaster.Psth{BIT_Number,nn},2);   
                    if numel(PsthAndRaster.Trials{BIT_Number,nn})~=0
                    M_PSTH{BIT_Number,nn}(bb)=mean(N_PSTH(:,bb))/(bin);
                    S_PSTH{BIT_Number,nn}(bb)=std(N_PSTH(:,bb))/(sqrt(numel(PsthAndRaster.Trials{BIT_Number,nn}))*bin);
                    else
                    M_PSTH{BIT_Number,nn}(bb)=0;
                    S_PSTH{BIT_Number,nn}(bb)=0;
                    end
                end   

                T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)

                    subplot(2,1,2)
                    plot(T,M_PSTH{BIT_Number,nn},'Color', COLORSET(nn,:), 'linewidth',1)   
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
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), 'Area ', char(My_Neurons.Area)]);

                    if iposx == 15 && iposy == 0 && iinp == 0 && iaz ==0
                        xlabel(['RightLeft Moving Grating, SF 0.03, OR 135', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx)]);
                        elseif iposx == -15 && iposy == 0 && iinp == 0 && iaz ==0
                        xlabel(['LeftRight Moving Grating, SF 0.03, OR 135', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx)]);
                        elseif iposx == 0 && iposy == 15 && iinp == 0 && iaz ==0
                        xlabel(['UpDown Moving Grating, SF 0.03, OR 135', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 0 && iposy == -15 && iinp == 0 && iaz ==0
                        xlabel(['DownUp Moving Grating, SF 0.03, OR 135', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == -15 && iposy == -7.5 && iinp == 0 && iaz ==0
                        xlabel(['UpRight Moving Grating, SF 0.03, OR 135', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == -15 && iposy == 7.5 && iinp == 0 && iaz ==0
                        xlabel(['DownRight Moving Grating, SF 0.03, OR 135', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 15 && iposy == -7.5 && iinp == 0 && iaz ==0
                        xlabel(['UpLeft Moving Grating, SF 0.03, OR 135', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 15 && iposy == 7.5 && iinp == 0 && iaz ==0
                        xlabel(['DownLeft Moving Grating, SF 0.03, OR 135', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        
                    end
                    end

            ww = cd;
            stringM=strcat('RASTERS/Gratings/0.03/G_0.03_135/', num2str(nn), '/Movies');
            mkdir(stringM);
            saveas(gcf,[ww,'/RASTERS/Gratings/0.03/G_0.03_135/', num2str(nn), '/Movies/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/Gratings/0.03/G_0.03_135/', num2str(nn), '/Movies/R_',num2str(BIT_Number),'.fig'])  
            close
            
            end
            
            if stim_pres_time < 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                for bb=1:size(PsthAndRaster.Psth{BIT_Number,nn},2);   
                    if numel(PsthAndRaster.Trials{BIT_Number,nn})~=0
                    M_PSTH{BIT_Number,nn}(bb)=mean(N_PSTH(:,bb))/(bin);
                    S_PSTH{BIT_Number,nn}(bb)=std(N_PSTH(:,bb))/(sqrt(numel(PsthAndRaster.Trials{BIT_Number,nn}))*bin);
                    else
                    M_PSTH{BIT_Number,nn}(bb)=0;
                    S_PSTH{BIT_Number,nn}(bb)=0;
                    end
                end   
                
            T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2)); %-200,2200,
            [int tm]=min(abs(T-450));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)
                        
                    subplot(2,1,2)
                    plot(T(1:tm),M_PSTH{BIT_Number,nn}(1:tm),'Color', COLORSET(nn,:), 'linewidth',1)   
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
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), 'Area ', char(My_Neurons.Area)]) 
                    xlabel(['Static Grating, SF 0.03, OR 135 ', num2str(BIT_Number)]);

                    end

            ww = cd;
            stringS=strcat('RASTERS/Gratings/0.03/G_0.03_135/', num2str(nn), '/Static');
            mkdir(stringS);
            saveas(gcf,[ww,'/RASTERS/Gratings/0.03/G_0.03_135/', num2str(nn), '/Static/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/Gratings/0.03/G_0.03_135/', num2str(nn), '/Static/R_',num2str(BIT_Number),'.fig'])  
            close
            
            end
            end
            
            
            
    %%%% GRATING 0.05 135 DEG
    %%%%%%%%%%%%%%%%%%%%%%%
    
        elseif object == 124
        
        [a b]=ind2sub(size(Fede_STIM), find(Fede_STIM(1:270,2)==124));
        selected_bits = a';
        
            for BIT_Number = selected_bits;

            iposx = Fede_STIM(BIT_Number, 5); 
            fposx = Fede_STIM(BIT_Number, 6); 
            iposy = Fede_STIM(BIT_Number, 7); 
            fposy = Fede_STIM(BIT_Number, 8); 
            
            a = PsthAndRaster.Trials{BIT_Number,nn}(1);
            stim_pres_time = (STIM_STOP(a)-STIM_START(a))*1000;
            
            if stim_pres_time >= 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                for bb=1:size(PsthAndRaster.Psth{BIT_Number,nn},2);   
                    if numel(PsthAndRaster.Trials{BIT_Number,nn})~=0
                    M_PSTH{BIT_Number,nn}(bb)=mean(N_PSTH(:,bb))/(bin);
                    S_PSTH{BIT_Number,nn}(bb)=std(N_PSTH(:,bb))/(sqrt(numel(PsthAndRaster.Trials{BIT_Number,nn}))*bin);
                    else
                    M_PSTH{BIT_Number,nn}(bb)=0;
                    S_PSTH{BIT_Number,nn}(bb)=0;
                    end
                end   

                T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)

                    subplot(2,1,2)
                    plot(T,M_PSTH{BIT_Number,nn},'Color', COLORSET(nn,:), 'linewidth',1)   
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
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), 'Area ', char(My_Neurons.Area)]);

                    if iposx == 15 && iposy == 0 && iinp == 0 && iaz ==0
                        xlabel(['RightLeft Moving Grating, SF 0.05, OR 135', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx)]);
                        elseif iposx == -15 && iposy == 0 && iinp == 0 && iaz ==0
                        xlabel(['LeftRight Moving Grating, SF 0.05, OR 135', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx)]);
                        elseif iposx == 0 && iposy == 15 && iinp == 0 && iaz ==0
                        xlabel(['UpDown Moving Grating, SF 0.05, OR 135', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 0 && iposy == -15 && iinp == 0 && iaz ==0
                        xlabel(['DownUp Moving Grating, SF 0.05, OR 135', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == -15 && iposy == -7.5 && iinp == 0 && iaz ==0
                        xlabel(['UpRight Moving Grating, SF 0.05, OR 135', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == -15 && iposy == 7.5 && iinp == 0 && iaz ==0
                        xlabel(['DownRight Moving Grating, SF 0.05, OR 135', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 15 && iposy == -7.5 && iinp == 0 && iaz ==0
                        xlabel(['UpLeft Moving Grating, SF 0.05, OR 135', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 15 && iposy == 7.5 && iinp == 0 && iaz ==0
                        xlabel(['DownLeft Moving Grating, SF 0.05, OR 135', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        
                    end
                    end

            ww = cd;
            stringM=strcat('RASTERS/Gratings/0.05/G_0.05_135/', num2str(nn), '/Movies');
            mkdir(stringM);
            saveas(gcf,[ww,'/RASTERS/Gratings/0.05/G_0.05_135/', num2str(nn), '/Movies/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/Gratings/0.05/G_0.05_135/', num2str(nn), '/Movies/R_',num2str(BIT_Number),'.fig'])  
            close
            
            end
            
            if stim_pres_time < 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                for bb=1:size(PsthAndRaster.Psth{BIT_Number,nn},2);   
                    if numel(PsthAndRaster.Trials{BIT_Number,nn})~=0
                    M_PSTH{BIT_Number,nn}(bb)=mean(N_PSTH(:,bb))/(bin);
                    S_PSTH{BIT_Number,nn}(bb)=std(N_PSTH(:,bb))/(sqrt(numel(PsthAndRaster.Trials{BIT_Number,nn}))*bin);
                    else
                    M_PSTH{BIT_Number,nn}(bb)=0;
                    S_PSTH{BIT_Number,nn}(bb)=0;
                    end
                end   
                
            T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2)); %-200,2200,
            [int tm]=min(abs(T-450));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)
                        
                    subplot(2,1,2)
                    plot(T(1:tm),M_PSTH{BIT_Number,nn}(1:tm),'Color', COLORSET(nn,:), 'linewidth',1)   
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
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), 'Area ', char(My_Neurons.Area)]) 
                    xlabel(['Static Grating, SF 0.05, OR 135 ', num2str(BIT_Number)]);

                    end

            ww = cd;
            stringS=strcat('RASTERS/Gratings/0.05/G_0.05_135/', num2str(nn), '/Static');
            mkdir(stringS);
            saveas(gcf,[ww,'/RASTERS/Gratings/0.05/G_0.05_135/', num2str(nn), '/Static/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/Gratings/0.05/G_0.05_135/', num2str(nn), '/Static/R_',num2str(BIT_Number),'.fig'])  
            close
            
            end
            end
            
            
            
    %%%% GRATING 0.1 135 DEG
    %%%%%%%%%%%%%%%%%%%%%%%
    
        elseif object == 134
        
        [a b]=ind2sub(size(Fede_STIM), find(Fede_STIM(1:270,2)==134));
        selected_bits = a';
        
            for BIT_Number = selected_bits;

            iposx = Fede_STIM(BIT_Number, 5); 
            fposx = Fede_STIM(BIT_Number, 6); 
            iposy = Fede_STIM(BIT_Number, 7); 
            fposy = Fede_STIM(BIT_Number, 8); 
            
            a = PsthAndRaster.Trials{BIT_Number,nn}(1);
            stim_pres_time = (STIM_STOP(a)-STIM_START(a))*1000;
            
            if stim_pres_time >= 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                for bb=1:size(PsthAndRaster.Psth{BIT_Number,nn},2);   
                    if numel(PsthAndRaster.Trials{BIT_Number,nn})~=0
                    M_PSTH{BIT_Number,nn}(bb)=mean(N_PSTH(:,bb))/(bin);
                    S_PSTH{BIT_Number,nn}(bb)=std(N_PSTH(:,bb))/(sqrt(numel(PsthAndRaster.Trials{BIT_Number,nn}))*bin);
                    else
                    M_PSTH{BIT_Number,nn}(bb)=0;
                    S_PSTH{BIT_Number,nn}(bb)=0;
                    end
                end   

                T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)

                    subplot(2,1,2)
                    plot(T,M_PSTH{BIT_Number,nn},'Color', COLORSET(nn,:), 'linewidth',1)   
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
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), 'Area ', char(My_Neurons.Area)]);

                    if iposx == 15 && iposy == 0 && iinp == 0 && iaz ==0
                        xlabel(['RightLeft Moving Grating, SF 0.1, OR 135', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx)]);
                        elseif iposx == -15 && iposy == 0 && iinp == 0 && iaz ==0
                        xlabel(['LeftRight Moving Grating, SF 0.1, OR 135', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx)]);
                        elseif iposx == 0 && iposy == 15 && iinp == 0 && iaz ==0
                        xlabel(['UpDown Moving Grating, SF 0.1, OR 135', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 0 && iposy == -15 && iinp == 0 && iaz ==0
                        xlabel(['DownUp Moving Grating, SF 0.1, OR 135', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == -15 && iposy == -7.5 && iinp == 0 && iaz ==0
                        xlabel(['UpRight Moving Grating, SF 0.1, OR 135', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == -15 && iposy == 7.5 && iinp == 0 && iaz ==0
                        xlabel(['DownRight Moving Grating, SF 0.1, OR 135', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 15 && iposy == -7.5 && iinp == 0 && iaz ==0
                        xlabel(['UpLeft Moving Grating, SF 0.1, OR 135', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 15 && iposy == 7.5 && iinp == 0 && iaz ==0
                        xlabel(['DownLeft Moving Grating, SF 0.1, OR 135', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        
                    end
                    end

            ww = cd;
            stringM=strcat('RASTERS/Gratings/0.1/G_0.1_135/', num2str(nn), '/Movies');
            mkdir(stringM);
            saveas(gcf,[ww,'/RASTERS/Gratings/0.1/G_0.1_135/', num2str(nn), '/Movies/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/Gratings/0.1/G_0.1_135/', num2str(nn), '/Movies/R_',num2str(BIT_Number),'.fig'])  
            close
            
            end
            
            if stim_pres_time < 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                for bb=1:size(PsthAndRaster.Psth{BIT_Number,nn},2);   
                    if numel(PsthAndRaster.Trials{BIT_Number,nn})~=0
                    M_PSTH{BIT_Number,nn}(bb)=mean(N_PSTH(:,bb))/(bin);
                    S_PSTH{BIT_Number,nn}(bb)=std(N_PSTH(:,bb))/(sqrt(numel(PsthAndRaster.Trials{BIT_Number,nn}))*bin);
                    else
                    M_PSTH{BIT_Number,nn}(bb)=0;
                    S_PSTH{BIT_Number,nn}(bb)=0;
                    end
                end   
                
            T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2)); %-200,2200,
            [int tm]=min(abs(T-450));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)
                        
                    subplot(2,1,2)
                    plot(T(1:tm),M_PSTH{BIT_Number,nn}(1:tm),'Color', COLORSET(nn,:), 'linewidth',1)   
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
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), 'Area ', char(My_Neurons.Area)]) 
                    xlabel(['Static Grating, SF 0.1, OR 135 ', num2str(BIT_Number)]);

                    end

            ww = cd;
            stringS=strcat('RASTERS/Gratings/0.1/G_0.1_135/', num2str(nn), '/Static');
            mkdir(stringS);
            saveas(gcf,[ww,'/RASTERS/Gratings/0.1/G_0.1_135/', num2str(nn), '/Static/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/Gratings/0.1/G_0.1_135/', num2str(nn), '/Static/R_',num2str(BIT_Number),'.fig'])  
            close
            
            end
            end
            
            
            
    %%%% GRATING 0.4 135 DEG
    %%%%%%%%%%%%%%%%%%%%%%%
    
        elseif object == 144
        
        [a b]=ind2sub(size(Fede_STIM), find(Fede_STIM(1:270,2)==144));
        selected_bits = a';
        
            for BIT_Number = selected_bits;

            iposx = Fede_STIM(BIT_Number, 5); 
            fposx = Fede_STIM(BIT_Number, 6); 
            iposy = Fede_STIM(BIT_Number, 7); 
            fposy = Fede_STIM(BIT_Number, 8); 
            
            a = PsthAndRaster.Trials{BIT_Number,nn}(1);
            stim_pres_time = (STIM_STOP(a)-STIM_START(a))*1000;
            
            if stim_pres_time >= 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                for bb=1:size(PsthAndRaster.Psth{BIT_Number,nn},2);   
                    if numel(PsthAndRaster.Trials{BIT_Number,nn})~=0
                    M_PSTH{BIT_Number,nn}(bb)=mean(N_PSTH(:,bb))/(bin);
                    S_PSTH{BIT_Number,nn}(bb)=std(N_PSTH(:,bb))/(sqrt(numel(PsthAndRaster.Trials{BIT_Number,nn}))*bin);
                    else
                    M_PSTH{BIT_Number,nn}(bb)=0;
                    S_PSTH{BIT_Number,nn}(bb)=0;
                    end
                end   

                T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)

                    subplot(2,1,2)
                    plot(T,M_PSTH{BIT_Number,nn},'Color', COLORSET(nn,:), 'linewidth',1)   
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
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), 'Area ', char(My_Neurons.Area)]);

                    if iposx == 15 && iposy == 0 && iinp == 0 && iaz ==0
                        xlabel(['RightLeft Moving Grating, SF 0.4, OR 135', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx)]);
                        elseif iposx == -15 && iposy == 0 && iinp == 0 && iaz ==0
                        xlabel(['LeftRight Moving Grating, SF 0.4, OR 135', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx)]);
                        elseif iposx == 0 && iposy == 15 && iinp == 0 && iaz ==0
                        xlabel(['UpDown Moving Grating, SF 0.4, OR 135', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 0 && iposy == -15 && iinp == 0 && iaz ==0
                        xlabel(['DownUp Moving Grating, SF 0.4, OR 135', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == -15 && iposy == -7.5 && iinp == 0 && iaz ==0
                        xlabel(['UpRight Moving Grating, SF 0.4, OR 135', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == -15 && iposy == 7.5 && iinp == 0 && iaz ==0
                        xlabel(['DownRight Moving Grating, SF 0.4, OR 135', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 15 && iposy == -7.5 && iinp == 0 && iaz ==0
                        xlabel(['UpLeft Moving Grating, SF 0.4, OR 135', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 15 && iposy == 7.5 && iinp == 0 && iaz ==0
                        xlabel(['DownLeft Moving Grating, SF 0.4, OR 135', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        
                    end
                    end

            ww = cd;
            stringM=strcat('RASTERS/Gratings/0.4/G_0.4_135/', num2str(nn), '/Movies');
            mkdir(stringM);
            saveas(gcf,[ww,'/RASTERS/Gratings/0.4/G_0.4_135/', num2str(nn), '/Movies/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/Gratings/0.4/G_0.4_135/', num2str(nn), '/Movies/R_',num2str(BIT_Number),'.fig'])  
            close
            
            end
            
            if stim_pres_time < 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                for bb=1:size(PsthAndRaster.Psth{BIT_Number,nn},2);   
                    if numel(PsthAndRaster.Trials{BIT_Number,nn})~=0
                    M_PSTH{BIT_Number,nn}(bb)=mean(N_PSTH(:,bb))/(bin);
                    S_PSTH{BIT_Number,nn}(bb)=std(N_PSTH(:,bb))/(sqrt(numel(PsthAndRaster.Trials{BIT_Number,nn}))*bin);
                    else
                    M_PSTH{BIT_Number,nn}(bb)=0;
                    S_PSTH{BIT_Number,nn}(bb)=0;
                    end
                end   
                
            T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2)); %-200,2200,
            [int tm]=min(abs(T-450));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)
                        
                    subplot(2,1,2)
                    plot(T(1:tm),M_PSTH{BIT_Number,nn}(1:tm),'Color', COLORSET(nn,:), 'linewidth',1)   
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
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), 'Area ', char(My_Neurons.Area)]) 
                    xlabel(['Static Grating, SF 0.4, OR 135 ', num2str(BIT_Number)]);

                    end

            ww = cd;
            stringS=strcat('RASTERS/Gratings/0.4/G_0.4_135/', num2str(nn), '/Static');
            mkdir(stringS);
            saveas(gcf,[ww,'/RASTERS/Gratings/0.4/G_0.4_135/', num2str(nn), '/Static/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/Gratings/0.4/G_0.4_135/', num2str(nn), '/Static/R_',num2str(BIT_Number),'.fig'])  
            close
            
            end
            end
            
            
            
    %%%% DOTS PATTERN 1
    %%%%%%%%%%%%%%%%%%%%%%%
    
    elseif object == 21
        
        [a b]=ind2sub(size(Fede_STIM), find(Fede_STIM(1:270,2)==21));
        selected_bits = a';
        
            for BIT_Number = selected_bits;

            iposx = Fede_STIM(BIT_Number, 5); 
            fposx = Fede_STIM(BIT_Number, 6); 
            iposy = Fede_STIM(BIT_Number, 7); 
            fposy = Fede_STIM(BIT_Number, 8); 
            
            a = PsthAndRaster.Trials{BIT_Number,nn}(1);
            stim_pres_time = (STIM_STOP(a)-STIM_START(a))*1000;
            
            if stim_pres_time >= 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                for bb=1:size(PsthAndRaster.Psth{BIT_Number,nn},2);   
                    if numel(PsthAndRaster.Trials{BIT_Number,nn})~=0
                    M_PSTH{BIT_Number,nn}(bb)=mean(N_PSTH(:,bb))/(bin);
                    S_PSTH{BIT_Number,nn}(bb)=std(N_PSTH(:,bb))/(sqrt(numel(PsthAndRaster.Trials{BIT_Number,nn}))*bin);
                    else
                    M_PSTH{BIT_Number,nn}(bb)=0;
                    S_PSTH{BIT_Number,nn}(bb)=0;
                    end
                end   

                T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)

                    subplot(2,1,2)
                    plot(T,M_PSTH{BIT_Number,nn},'Color', COLORSET(nn,:), 'linewidth',1)   
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
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), 'Area ', char(My_Neurons.Area)]);

                    if iposx == 15 && iposy == 0 && iinp == 0 && iaz ==0 && isz == 210.8 && fsz == 210.8
                        xlabel(['RightLeft Moving Dots, Pattern 1', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx)]);
                        elseif iposx == -15 && iposy == 0 && iinp == 0 && iaz ==0 && isz == 210.8 && fsz == 210.8
                        xlabel(['LeftRight Moving Dots, Pattern 1', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx)]);
                        elseif iposx == 0 && iposy == 15 && iinp == 0 && iaz ==0 && isz == 210.8 && fsz == 210.8
                        xlabel(['UpDown Moving Dots, Pattern 1', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 0 && iposy == -15 && iinp == 0 && iaz ==0 && isz == 210.8 && fsz == 210.8
                        xlabel(['DownUp Moving Dots, Pattern 1', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == -15 && iposy == -7.5 && iinp == 0 && iaz ==0 && isz == 210.8 && fsz == 210.8
                        xlabel(['UpRight Moving Dots, Pattern 1', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == -15 && iposy == 7.5 && iinp == 0 && iaz ==0 && isz == 210.8 && fsz == 210.8
                        xlabel(['DownRight Moving Dots, Pattern 1', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 15 && iposy == -7.5 && iinp == 0 && iaz ==0 && isz == 210.8 && fsz == 210.8
                        xlabel(['UpLeft Moving Dots, Pattern 1', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 15 && iposy == 7.5 && iinp == 0 && iaz ==0 && isz == 210.8 && fsz == 210.8
                        xlabel(['DownLeft Moving Dots, Pattern 1', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 0 && iposy == 0 && iinp == -60 && iaz ==0 && isz == 210.8 && fsz == 210.8
                        xlabel(['Anti-Clockwise Moving Dots, Pattern 1', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialInPlane ', num2str(iinp), ', FinalInPlane ', num2str(finp)]);
                        elseif iposx == 0 && iposy == 0 && iinp == 60 && iaz ==0 && isz == 210.8 && fsz == 210.8
                        xlabel(['Clockwise Moving Dots, Pattern 1', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialInPlane ', num2str(iinp), ', FinalInPlane ', num2str(finp)]);
                        elseif iposx == 0 && iposy == 0 && iinp == 0 && iaz ==-60 && isz == 180 && fsz == 304
                        xlabel(['Expanding Moving Dots, Pattern 1', ', BitCode ', num2str(BIT_Number), ', InitialSize ', num2str(isz), ', FinaSize ', num2str(fsz)]);
                        elseif iposx == 0 && iposy == 0 && iinp == 0 && iaz ==-60 && isz == 304 && fsz == 180
                        xlabel(['Contracting Moving Dots, Pattern 1', ', BitCode ', num2str(BIT_Number), ', InitialSize ', num2str(isz), ', FinaSize ', num2str(fsz)]);
                    end
                    end

            ww = cd;
            stringM=strcat('RASTERS/Dots/D_1/', num2str(nn), '/Movies');
            mkdir(stringM);
            saveas(gcf,[ww,'/RASTERS/Dots/D_1/', num2str(nn), '/Movies/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/Dots/D_1/', num2str(nn), '/Movies/R_',num2str(BIT_Number),'.fig'])  
            close
            
            end
            end
        
            
        
        
    %%%% DOTS PATTERN 2
    %%%%%%%%%%%%%%%%%%%%%%%
    
        elseif object == 22
        
        [a b]=ind2sub(size(Fede_STIM), find(Fede_STIM(1:270,2)==22));
        selected_bits = a';
        
            for BIT_Number = selected_bits;

            iposx = Fede_STIM(BIT_Number, 5); 
            fposx = Fede_STIM(BIT_Number, 6); 
            iposy = Fede_STIM(BIT_Number, 7); 
            fposy = Fede_STIM(BIT_Number, 8); 
            
            a = PsthAndRaster.Trials{BIT_Number,nn}(1);
            stim_pres_time = (STIM_STOP(a)-STIM_START(a))*1000;
            
            if stim_pres_time >= 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                for bb=1:size(PsthAndRaster.Psth{BIT_Number,nn},2);   
                    if numel(PsthAndRaster.Trials{BIT_Number,nn})~=0
                    M_PSTH{BIT_Number,nn}(bb)=mean(N_PSTH(:,bb))/(bin);
                    S_PSTH{BIT_Number,nn}(bb)=std(N_PSTH(:,bb))/(sqrt(numel(PsthAndRaster.Trials{BIT_Number,nn}))*bin);
                    else
                    M_PSTH{BIT_Number,nn}(bb)=0;
                    S_PSTH{BIT_Number,nn}(bb)=0;
                    end
                end   

                T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)

                    subplot(2,1,2)
                    plot(T,M_PSTH{BIT_Number,nn},'Color', COLORSET(nn,:), 'linewidth',1)   
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
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), 'Area ', char(My_Neurons.Area)]);

                    if iposx == 15 && iposy == 0 && iinp == 0 && iaz ==0 && isz == 210.8 && fsz == 210.8
                        xlabel(['RightLeft Moving Dots, Pattern 2', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx)]);
                        elseif iposx == -15 && iposy == 0 && iinp == 0 && iaz ==0 && isz == 210.8 && fsz == 210.8
                        xlabel(['LeftRight Moving Dots, Pattern 2', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx)]);
                        elseif iposx == 0 && iposy == 15 && iinp == 0 && iaz ==0 && isz == 210.8 && fsz == 210.8
                        xlabel(['UpDown Moving Dots, Pattern 2', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 0 && iposy == -15 && iinp == 0 && iaz ==0 && isz == 210.8 && fsz == 210.8
                        xlabel(['DownUp Moving Dots, Pattern 2', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == -15 && iposy == -7.5 && iinp == 0 && iaz ==0 && isz == 210.8 && fsz == 210.8
                        xlabel(['UpRight Moving Dots, Pattern 2', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == -15 && iposy == 7.5 && iinp == 0 && iaz ==0 && isz == 210.8 && fsz == 210.8
                        xlabel(['DownRight Moving Dots, Pattern 2', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 15 && iposy == -7.5 && iinp == 0 && iaz ==0 && isz == 210.8 && fsz == 210.8
                        xlabel(['UpLeft Moving Dots, Pattern 2', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 15 && iposy == 7.5 && iinp == 0 && iaz ==0 && isz == 210.8 && fsz == 210.8
                        xlabel(['DownLeft Moving Dots, Pattern 2', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 0 && iposy == 0 && iinp == -60 && iaz ==0 && isz == 210.8 && fsz == 210.8
                        xlabel(['Anti-Clockwise Moving Dots, Pattern 2', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialInPlane ', num2str(iinp), ', FinalInPlane ', num2str(finp)]);
                        elseif iposx == 0 && iposy == 0 && iinp == 60 && iaz ==0 && isz == 210.8 && fsz == 210.8
                        xlabel(['Clockwise Moving Dots, Pattern 2', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialInPlane ', num2str(iinp), ', FinalInPlane ', num2str(finp)]);
                        elseif iposx == 0 && iposy == 0 && iinp == 0 && iaz ==-60 && isz == 180 && fsz == 304
                        xlabel(['Expanding Moving Dots, Pattern 2', ', BitCode ', num2str(BIT_Number), ', InitialSize ', num2str(isz), ', FinaSize ', num2str(fsz)]);
                        elseif iposx == 0 && iposy == 0 && iinp == 0 && iaz ==-60 && isz == 304 && fsz == 180
                        xlabel(['Contracting Moving Dots, Pattern 2', ', BitCode ', num2str(BIT_Number), ', InitialSize ', num2str(isz), ', FinaSize ', num2str(fsz)]);
                    end
                    end

            ww = cd;
            stringM=strcat('RASTERS/Dots/D_2/', num2str(nn), '/Movies');
            mkdir(stringM);
            saveas(gcf,[ww,'/RASTERS/Dots/D_2/', num2str(nn), '/Movies/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/Dots/D_2/', num2str(nn), '/Movies/R_',num2str(BIT_Number),'.fig'])  
            close
            
            end
            end
            
            
            
    %%%% DOTS PATTERN 3
    %%%%%%%%%%%%%%%%%%%%%%%
    
        elseif object == 23
        
        [a b]=ind2sub(size(Fede_STIM), find(Fede_STIM(1:270,2)==23));
        selected_bits = a';
        
            for BIT_Number = selected_bits;

            iposx = Fede_STIM(BIT_Number, 5); 
            fposx = Fede_STIM(BIT_Number, 6); 
            iposy = Fede_STIM(BIT_Number, 7); 
            fposy = Fede_STIM(BIT_Number, 8); 
            
            a = PsthAndRaster.Trials{BIT_Number,nn}(1);
            stim_pres_time = (STIM_STOP(a)-STIM_START(a))*1000;
            
            if stim_pres_time >= 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                for bb=1:size(PsthAndRaster.Psth{BIT_Number,nn},2);   
                    if numel(PsthAndRaster.Trials{BIT_Number,nn})~=0
                    M_PSTH{BIT_Number,nn}(bb)=mean(N_PSTH(:,bb))/(bin);
                    S_PSTH{BIT_Number,nn}(bb)=std(N_PSTH(:,bb))/(sqrt(numel(PsthAndRaster.Trials{BIT_Number,nn}))*bin);
                    else
                    M_PSTH{BIT_Number,nn}(bb)=0;
                    S_PSTH{BIT_Number,nn}(bb)=0;
                    end
                end   

                T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)

                    subplot(2,1,2)
                    plot(T,M_PSTH{BIT_Number,nn},'Color', COLORSET(nn,:), 'linewidth',1)   
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
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), 'Area ', char(My_Neurons.Area)]);

                    if iposx == 15 && iposy == 0 && iinp == 0 && iaz ==0 && isz == 210.8 && fsz == 210.8
                        xlabel(['RightLeft Moving Dots, Pattern 3', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx)]);
                        elseif iposx == -15 && iposy == 0 && iinp == 0 && iaz ==0 && isz == 210.8 && fsz == 210.8
                        xlabel(['LeftRight Moving Dots, Pattern 3', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx)]);
                        elseif iposx == 0 && iposy == 15 && iinp == 0 && iaz ==0 && isz == 210.8 && fsz == 210.8
                        xlabel(['UpDown Moving Dots, Pattern 3', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 0 && iposy == -15 && iinp == 0 && iaz ==0 && isz == 210.8 && fsz == 210.8
                        xlabel(['DownUp Moving Dots, Pattern 3', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == -15 && iposy == -7.5 && iinp == 0 && iaz ==0 && isz == 210.8 && fsz == 210.8
                        xlabel(['UpRight Moving Dots, Pattern 3', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == -15 && iposy == 7.5 && iinp == 0 && iaz ==0 && isz == 210.8 && fsz == 210.8
                        xlabel(['DownRight Moving Dots, Pattern 3', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 15 && iposy == -7.5 && iinp == 0 && iaz ==0 && isz == 210.8 && fsz == 210.8
                        xlabel(['UpLeft Moving Dots, Pattern 3', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 15 && iposy == 7.5 && iinp == 0 && iaz ==0 && isz == 210.8 && fsz == 210.8
                        xlabel(['DownLeft Moving Dots, Pattern 3', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 0 && iposy == 0 && iinp == -60 && iaz ==0 && isz == 210.8 && fsz == 210.8
                        xlabel(['Anti-Clockwise Moving Dots, Pattern 3', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialInPlane ', num2str(iinp), ', FinalInPlane ', num2str(finp)]);
                        elseif iposx == 0 && iposy == 0 && iinp == 60 && iaz ==0 && isz == 210.8 && fsz == 210.8
                        xlabel(['Clockwise Moving Dots, Pattern 3', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialInPlane ', num2str(iinp), ', FinalInPlane ', num2str(finp)]);
                        elseif iposx == 0 && iposy == 0 && iinp == 0 && iaz ==-60 && isz == 180 && fsz == 304
                        xlabel(['Expanding Moving Dots, Pattern 3', ', BitCode ', num2str(BIT_Number), ', InitialSize ', num2str(isz), ', FinaSize ', num2str(fsz)]);
                        elseif iposx == 0 && iposy == 0 && iinp == 0 && iaz ==-60 && isz == 304 && fsz == 180
                        xlabel(['Contracting Moving Dots, Pattern 3', ', BitCode ', num2str(BIT_Number), ', InitialSize ', num2str(isz), ', FinaSize ', num2str(fsz)]);
                    end
                    end

            ww = cd;
            stringM=strcat('RASTERS/Dots/D_3/', num2str(nn), '/Movies');
            mkdir(stringM);
            saveas(gcf,[ww,'/RASTERS/Dots/D_3/', num2str(nn), '/Movies/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/Dots/D_3/', num2str(nn), '/Movies/R_',num2str(BIT_Number),'.fig'])  
            close
            
            end
            end
            
            
            
    %%%% DOTS PATTERN 4
    %%%%%%%%%%%%%%%%%%%%%%%
    
    elseif object == 24

        
        [a b]=ind2sub(size(Fede_STIM), find(Fede_STIM(1:270,2)==24));
        selected_bits = a';
        
            for BIT_Number = selected_bits;

            iposx = Fede_STIM(BIT_Number, 5); 
            fposx = Fede_STIM(BIT_Number, 6); 
            iposy = Fede_STIM(BIT_Number, 7); 
            fposy = Fede_STIM(BIT_Number, 8); 
            
            a = PsthAndRaster.Trials{BIT_Number,nn}(1);
            stim_pres_time = (STIM_STOP(a)-STIM_START(a))*1000;
            
            if stim_pres_time >= 1000
            countolo=countolo+1;
            figure(countolo);
            N_PSTH=PsthAndRaster.Psth{BIT_Number,nn};

                for bb=1:size(PsthAndRaster.Psth{BIT_Number,nn},2);   
                    if numel(PsthAndRaster.Trials{BIT_Number,nn})~=0
                    M_PSTH{BIT_Number,nn}(bb)=mean(N_PSTH(:,bb))/(bin);
                    S_PSTH{BIT_Number,nn}(bb)=std(N_PSTH(:,bb))/(sqrt(numel(PsthAndRaster.Trials{BIT_Number,nn}))*bin);
                    else
                    M_PSTH{BIT_Number,nn}(bb)=0;
                    S_PSTH{BIT_Number,nn}(bb)=0;
                    end
                end   

                T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
            
                    for trl=1:size(PsthAndRaster.MySpikes, 2)

                    subplot(2,1,2)
                    plot(T,M_PSTH{BIT_Number,nn},'Color', COLORSET(nn,:), 'linewidth',1)   
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
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), 'Area ', char(My_Neurons.Area)]);

                    
                    if iposx == 15 && iposy == 0 && iinp == 0 && iaz ==0 && isz == 210.8 && fsz == 210.8
                        xlabel(['RightLeft Moving Dots, Pattern 4', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx)]);
                        elseif iposx == -15 && iposy == 0 && iinp == 0 && iaz ==0 && isz == 210.8 && fsz == 210.8
                        xlabel(['LeftRight Moving Dots, Pattern 4', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx)]);
                        elseif iposx == 0 && iposy == 15 && iinp == 0 && iaz ==0 && isz == 210.8 && fsz == 210.8
                        xlabel(['UpDown Moving Dots, Pattern 4', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 0 && iposy == -15 && iinp == 0 && iaz ==0 && isz == 210.8 && fsz == 210.8
                        xlabel(['DownUp Moving Dots, Pattern 4', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == -15 && iposy == -7.5 && iinp == 0 && iaz ==0 && isz == 210.8 && fsz == 210.8
                        xlabel(['UpRight Moving Dots, Pattern 4', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == -15 && iposy == 7.5 && iinp == 0 && iaz ==0 && isz == 210.8 && fsz == 210.8
                        xlabel(['DownRight Moving Dots, Pattern 4', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 15 && iposy == -7.5 && iinp == 0 && iaz ==0 && isz == 210.8 && fsz == 210.8
                        xlabel(['UpLeft Moving Dots, Pattern 4', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 15 && iposy == 7.5 && iinp == 0 && iaz ==0 && isz == 210.8 && fsz == 210.8
                        xlabel(['DownLeft Moving Dots, Pattern 4', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialPosx ', num2str(iposx), ', FinalPosx ', num2str(fposx), ', InitialPosy ', num2str(iposy), ', FinalPosy ', num2str(fposy)]);
                        elseif iposx == 0 && iposy == 0 && iinp == -60 && iaz ==0 && isz == 210.8 && fsz == 210.8
                        xlabel(['Anti-Clockwise Moving Dots, Pattern 4', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialInPlane ', num2str(iinp), ', FinalInPlane ', num2str(finp)]);
                        elseif iposx == 0 && iposy == 0 && iinp == 60 && iaz ==0 && isz == 210.8 && fsz == 210.8
                        xlabel(['Clockwise Moving Dots, Pattern 4', ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', InitialInPlane ', num2str(iinp), ', FinalInPlane ', num2str(finp)]);
                        elseif iposx == 0 && iposy == 0 && iinp == 0 && iaz ==-60 && isz == 180 && fsz == 304
                        xlabel(['Expanding Moving Dots, Pattern 4', ', BitCode ', num2str(BIT_Number), ', InitialSize ', num2str(isz), ', FinaSize ', num2str(fsz)]);
                        elseif iposx == 0 && iposy == 0 && iinp == 0 && iaz ==-60 && isz == 304 && fsz == 180
                        xlabel(['Contracting Moving Dots, Pattern 4', ', BitCode ', num2str(BIT_Number), ', InitialSize ', num2str(isz), ', FinaSize ', num2str(fsz)]);
                    end
                    
                    end

            ww = cd;
            stringM=strcat('RASTERS/Dots/D_4/', num2str(nn), '/Movies');
            mkdir(stringM);
            saveas(gcf,[ww,'/RASTERS/Dots/D_4/', num2str(nn), '/Movies/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/Dots/D_4/', num2str(nn), '/Movies/R_',num2str(BIT_Number),'.fig'])  
            close
            
            end
            end
            

        end
  
clearvars -except COLORSET Fede_STIM Properties files neuronS nn object

    
end
    
