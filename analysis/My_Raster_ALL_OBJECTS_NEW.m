function My_Raster_ALL_OBJECTS_NEW (DayOfRecording, Block)

% DayOfRecording = '2_7_2013'
% 
% Block = 12

% object = [1, 2, 3, 4];
object = [-1];
% object = [0, 9];
% object = [111, 222, 333, 444];
% object = [11, 22];

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

cd RASTERS
load PeaksnTimes
cd ..


COLORSET=varycolor(neuronS);



for nn = 1 %:neuronS
    countolo=0;
        
    load(['PSTH_RASTER_', num2str(nn),'.mat'])
    load(['NEURON_', num2str(nn),'.mat'])
%     bitcodes = PsthAndRaster.BitCodes;
    bin=PsthAndRaster.BinSize; 
    
    ww = cd;
    

    
    
        for ob = object
    

        if ob == 0
                stimidentity = 'BBlank';
            elseif ob == 9
                stimidentity = 'WBlank';
            elseif ob == -1
                stimidentity = 'Bars';
            elseif ob == 1 || ob==2 || ob==3 || ob==4
                stimidentity = 'Objects';
            elseif ob == 111 || ob==222 || ob==333 || ob==444
                stimidentity = 'Gratings';
            elseif ob == 11 || ob==22
                stimidentity = 'Dots';
        end


%         ww = cd;   
%         stringO=strcat('RASTERS/', num2str(nn),  '/', char(stimidentity));
%         mkdir(stringO);
        
        [a z]=ind2sub(size(Fede_STIM_NU), find(Fede_STIM_NU(1:342,2)==ob));
        selected_bits = a';
        
        
            for BIT_Number = selected_bits;
                
            isz = Fede_STIM_NU(BIT_Number, 3); 
            fsz = Fede_STIM_NU(BIT_Number, 4); 
            iposx = Fede_STIM_NU(BIT_Number, 5); 
            fposx = Fede_STIM_NU(BIT_Number, 6); 
            iposy = Fede_STIM_NU(BIT_Number, 7); 
            fposy = Fede_STIM_NU(BIT_Number, 8); 
            az = Fede_STIM_NU(BIT_Number, 9); 
            ori = Fede_STIM_NU(BIT_Number, 10); 

            te = PsthAndRaster.Trials{BIT_Number,nn}(1);
            stim_pres_time = (STIM_STOP(te)-STIM_START(te))*1000;
            
            if stim_pres_time > 500 && stim_pres_time < 1000
            countolo=countolo+1;
            figure(countolo);
            T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
            [int tm]=min(abs(T-1000));
            Tlin = T(1:tm);
            blin = all_time_series{BIT_Number,nn}(1:tm);
            
                    
                    
                    subplot(2,1,2)   
                    plot(Tlin, blin,'Color', COLORSET(nn,:), 'linewidth',1)  
                    xlim([-200 1000])
                    hold on
                    
                    for trl=1:size(PsthAndRaster.MySpikes, 2)
                    
                    subplot(2,1,1)
                    plot(PsthAndRaster.MySpikes{BIT_Number,trl}*1000-PRE_TIME*1000,ones(size(PsthAndRaster.MySpikes{BIT_Number,trl}),1)*trl,'.', 'Color', COLORSET(nn,:))                                        
                    [BIT_Number nn trl]
                    hold on
                    line([0 0], [0 trl], 'Color', 'k','linewidth',2);
                    hold on
                    line([800 800], [0 trl], 'Color', 'k','linewidth',2);
 
                    end
                    
                        xlim([-200 1000])
                        title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);

                        if iposx == 15 && iposy == 0
                        xlabel(['FAST RightLeft Moving Object ', num2str(ob), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -15 && iposy == 0
                        xlabel(['FAST LeftRight Moving Object ', num2str(ob), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 0 && iposy == 15
                        xlabel(['FAST UpDown Moving Object ', num2str(ob), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 0 && iposy == -15
                        xlabel(['FAST DownUp Moving Object ', num2str(ob), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -10.6 && iposy == -10.6
                        xlabel(['FAST UpRight Moving Object ', num2str(ob), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -10.6 && iposy == 10.6
                        xlabel(['FAST DownRight Moving Object ', num2str(ob), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 10.6 && iposy == -10.6
                        xlabel(['FAST UpLeft Moving Object ', num2str(ob), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 10.6 && iposy == 10.6
                        xlabel(['FAST DownLeft Moving Object ', num2str(ob), ', BitCode ', num2str(BIT_Number)]);
                        end
                        
                    

            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '_', char(stimidentity), '_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '_', char(stimidentity), '_',num2str(BIT_Number),'.fig'])
            close
            clear Tlin blin 
            
            end
            
            if stim_pres_time > 1000
            countolo=countolo+1;
            figure(countolo);
            
            T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
            b = all_time_series{BIT_Number,nn};
           
                       
                    
                    subplot(2,1,2)                   
                    plot(T, b,'Color', COLORSET(nn,:), 'linewidth',1)  
                    xlim([-200 2200])
                    hold on
                   
                    for trl=1:size(PsthAndRaster.MySpikes, 2)
                    
                    subplot(2,1,1)
                    plot(PsthAndRaster.MySpikes{BIT_Number,trl}*1000-PRE_TIME*1000,ones(size(PsthAndRaster.MySpikes{BIT_Number,trl}),1)*trl,'.', 'Color', COLORSET(nn,:))
                    [BIT_Number nn trl]
                    hold on
                    line([0 0], [0 trl], 'Color', 'k','linewidth',2);
                    hold on
                    line([2000 2000], [0 trl], 'Color', 'k','linewidth',2);
                    
                    end
                    
                    xlim([-200 2200])
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);
                    
                        if iposx == 15 && iposy == 0 
                        xlabel(['SLOW RightLeft Moving Object ', num2str(ob), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -15 && iposy == 0 
                        xlabel(['SLOW LeftRight Moving Object ', num2str(ob), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 0 && iposy == 15 
                        xlabel(['SLOW UpDown Moving Object ', num2str(ob), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 0 && iposy == -15 
                        xlabel(['SLOW DownUp Moving Object ', num2str(ob), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -10.6 && iposy == -10.6 
                        xlabel(['SLOW UpRight Moving Object ', num2str(ob), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -10.6 && iposy == 10.6 
                        xlabel(['SLOW DownRight Moving Object ', num2str(ob), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 10.6 && iposy == -10.6 
                        xlabel(['SLOW UpLeft Moving Object ', num2str(ob), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 10.6 && iposy == 10.6 
                        xlabel(['SLOW DownLeft Moving Object ', num2str(ob), ', BitCode ', num2str(BIT_Number)]);
                        end
                        
                    
                    


            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '_', char(stimidentity), '_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '_', char(stimidentity), '_',num2str(BIT_Number),'.fig'])
            close
            clear T b 
            
            end
            
            if stim_pres_time < 500
            countolo=countolo+1;
            figure(countolo);
            
            T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2)); %-200,2200,
            [int tm]=min(abs(T-450));
            Tlin = T(1:tm);
            blin = all_time_series{BIT_Number,nn}(1:tm);
            
                    
                    
                    subplot(2,1,2)                   
                    plot(Tlin, blin,'Color', COLORSET(nn,:), 'linewidth',1)  
                    xlim([-200 450])
                    hold on;
                    
                    for trl=1:size(PsthAndRaster.MySpikes, 2)
                    
                    subplot(2,1,1)
                    plot(PsthAndRaster.MySpikes{BIT_Number,trl}*1000-PRE_TIME*1000,ones(size(PsthAndRaster.MySpikes{BIT_Number,trl}),1)*trl,'.', 'Color', COLORSET(nn,:))                    
                    [BIT_Number nn trl]
                    hold on
                    line([0 0],[0 trl], 'Color', 'k','linewidth',2)
                    hold on
                    line([250 250], [0 trl], 'Color', 'k','linewidth',2);
                    
                    end
                    
                    xlim([-200 450])
                    title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);
                    xlabel(['Static Object ',num2str(ob), ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', Posx ', num2str(iposx), ', Posy ', num2str(iposy), ', Orientation ', num2str(ori), ', InDepth ', num2str(az)]);

                    

            
            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '_', char(stimidentity), '_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS/', num2str(nn), '_', char(stimidentity), '_',num2str(BIT_Number),'.fig'])
            close
            clear Tlin blin 
            
            end
            end  
            
        end
end
            

    