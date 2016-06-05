function My_FR_RASTER_PSTH (DayOfRecording, Block, neuron, category, object, dirofmotion, stimsize)

% DayOfRecording = '2_7_2013'
% 
% Block = 12
% neuron = 1
% category = {'Static', 'Fast', 'Slow'}
% dirofmotion = [0, 45, 90, 135, 180, 225, 270, 315]
% stimsize = [15, 25, 35, 45, 55];


objectS = [-1, 0, 1, 2, 3, 4, 9, 11, 22, 111, 222, 333, 444];

nn = neuron;
cc = category;
ob = object;
% cn = condition; 


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

if strcmp (category, 'Static')
    cd FIRING_RATES_STATIC
    load AFR
    cd ..
elseif strcmp (category, 'Fast')
    cd FIRING_RATES_MOTION_FAST
    load AFR
    cd ..
elseif strcmp (category, 'Slow')
    cd FIRING_RATES_MOTION_SLOW
    load AFR
    cd ..    
end


COLORSET=varycolor(neuronS);


    countolo=0;
        
    load(['PSTH_RASTER_', num2str(nn),'.mat'])
    load(['NEURON_', num2str(nn),'.mat'])
%     bitcodes = PsthAndRaster.BitCodes;
    bin=PsthAndRaster.BinSize; 
    
    ww = cd;   
    

        if ob == 0
                stimidentity = 'BBlank'; %dark grey line, black blank
            elseif ob == 9
                stimidentity = 'WBlank'; %light grey line, white blank
            elseif ob == -1
                stimidentity = 'Bar';
            elseif ob == 1 
                stimidentity = 'Object 1'; %Ent
            elseif ob == 2
                stimidentity = 'Object 2'; %Bunny
            elseif ob == 3
                stimidentity = 'Object 3'; %Pingu
            elseif ob == 4
                stimidentity = 'Object 4'; %Orca
            elseif ob == 111 
                stimidentity = 'Grating 1'; %SF 0.03
            elseif ob == 222
                stimidentity = 'Grating 2'; %SF 0.05
            elseif ob == 333
                stimidentity = 'Grating 3'; %SF 0.1
            elseif ob == 444
                stimidentity = 'Grating 4'; %SF 0.4
            elseif ob == 11 
                stimidentity = 'Dots 1'; %Pattern 1
            elseif ob == 22
                stimidentity = 'Dots 2'; %Pattern 2
        end

        
        if strcmp(cc, 'Static')
            stimprestime = 0.250000000000000;
        elseif strcmp(cc, 'Fast')
            stimprestime = 0.763100000000000 ;
        elseif strcmp(cc, 'Slow')
            stimprestime = 1.984000000000000;    
        end

%         ww = cd;   
%         stringO=strcat('RASTERS/', num2str(nn),  '/', char(stimidentity));
%         mkdir(stringO);
        
        [a z]=ind2sub(size(Fede_STIM_NU), find(Fede_STIM_NU(1:342,2)==ob & Fede_STIM_NU(1:342,11)==stimprestime & Fede_STIM_NU(1:342,12)==dirofmotion & Fede_STIM_NU(1:342,3)==stimsize));
        selected_bit = a;
        
        
            BIT_Number = selected_bit;
                
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
%             figure(countolo);
            T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
            [int tm]=min(abs(T-1000));
            Tlin = T(1:tm);
            blin = all_time_series{BIT_Number,nn}(1:tm);
            
                    
                    figure;
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
                        xlabel(['FAST RightLeft Moving ', char(stimidentity), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -15 && iposy == 0
                        xlabel(['FAST LeftRight Moving ', char(stimidentity), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 0 && iposy == 15
                        xlabel(['FAST UpDown Moving ', char(stimidentity), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 0 && iposy == -15
                        xlabel(['FAST DownUp Moving ', char(stimidentity), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -10.6 && iposy == -10.6
                        xlabel(['FAST UpRight Moving ', char(stimidentity), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -10.6 && iposy == 10.6
                        xlabel(['FAST DownRight Moving ', char(stimidentity), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 10.6 && iposy == -10.6
                        xlabel(['FAST UpLeft Moving ', char(stimidentity), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 10.6 && iposy == 10.6
                        xlabel(['FAST DownLeft Moving ', char(stimidentity), ', BitCode ', num2str(BIT_Number)]);
                        else
                        xlabel(['FAST Moving ', char(stimidentity), ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', Posx ', num2str(iposx), ', Posy ', num2str(iposy), ', Orientation ', num2str(ori), ', InDepth ', num2str(az)]);    
                        
                        end
                        
                    

%             saveas(gcf,[ww,'/RASTERS/', num2str(nn), '_', char(stimidentity), '_',num2str(BIT_Number),'.png']) 
%             saveas(gcf,[ww,'/RASTERS/', num2str(nn), '_', char(stimidentity), '_',num2str(BIT_Number),'.fig'])
%             waitforbuttonpress
%             close
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
                        xlabel(['SLOW RightLeft Moving ', char(stimidentity), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -15 && iposy == 0 
                        xlabel(['SLOW LeftRight Moving ', char(stimidentity), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 0 && iposy == 15 
                        xlabel(['SLOW UpDown Moving ', char(stimidentity), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 0 && iposy == -15 
                        xlabel(['SLOW DownUp Moving ', char(stimidentity), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -10.6 && iposy == -10.6 
                        xlabel(['SLOW UpRight Moving ', char(stimidentity), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == -10.6 && iposy == 10.6 
                        xlabel(['SLOW DownRight Moving ', char(stimidentity), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 10.6 && iposy == -10.6 
                        xlabel(['SLOW UpLeft Moving ', char(stimidentity), ', BitCode ', num2str(BIT_Number)]);
                        elseif iposx == 10.6 && iposy == 10.6 
                        xlabel(['SLOW DownLeft Moving ', char(stimidentity), ', BitCode ', num2str(BIT_Number)]);
                        else
                        xlabel(['SLOW Moving ', char(stimidentity), ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', Posx ', num2str(iposx), ', Posy ', num2str(iposy), ', Orientation ', num2str(ori), ', InDepth ', num2str(az)]);    
                        end
                        
%             waitforbuttonpress
%             close
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
                    xlabel(['Static ',char(stimidentity), ', BitCode ', num2str(BIT_Number), ', Size ', num2str(isz), ', Posx ', num2str(iposx), ', Posy ', num2str(iposy), ', Orientation ', num2str(ori), ', InDepth ', num2str(az)]);

%             saveas(gcf,[ww,'/RASTERS/', num2str(nn), '_', char(stimidentity), '_',num2str(BIT_Number),'.png']) 
%             saveas(gcf,[ww,'/RASTERS/', num2str(nn), '_', char(stimidentity), '_',num2str(BIT_Number),'.fig'])
%             waitforbuttonpress
%             close
            clear T b 
            
              end
            
            

    