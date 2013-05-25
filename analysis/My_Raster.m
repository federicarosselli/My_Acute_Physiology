function My_Raster (object)

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

cd /zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_12_4_2013/ANALYSED/BlockS-56/BL_2/My_Structure/25

addpath /zocconasphys1/chronic_inv_rec/codes/
load My_StimS

files = dir(fullfile('*.mat'));
neuronS = (numel(files))/2;

        % bb = 1:size(PsthAndRaster.Psth{BIT_Number,nn},2);   % bb = bin number;
        % tr = 1:length(Trials{1,1})        % tr = trial number;
      
COLORSET=varycolor(neuronS);

for nn = 3  %:neuronS
    countolo=0;
        
    load(['PSTH_RASTER_', num2str(nn),'.mat'])
    load(['NEURON_', num2str(nn),'.mat'])
%     bitcodes = PsthAndRaster.BitCodes;
    bin=PsthAndRaster.BinSize;

    if object == -1
        
        [a b]=ind2sub(size(Fede_STIM), find(Fede_STIM(1:270,2)==-1));
        selected_bits = a';
        
     for BIT_Number = selected_bits; %1:bitcodes;

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
            line([0 0],[0 trl],'linewidth',2)
            xlim([-200 2200])
            title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Moving Bar =', num2str(BIT_Number)]) 
            
            end

            ww = cd;
            mkdir ('RASTERS_Movies/Neuron', num2str(nn));
            saveas(gcf,[ww,'/RASTERS_Movies/Neuron/', num2str(nn), '/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS_Movies/Neuron/', num2str(nn), '/R_',num2str(BIT_Number),'.fig'])  
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
            line([0 0],[0 trl],'linewidth',2)
            xlim([-200 450])
            title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Static Bar =', num2str(BIT_Number)]) 
            
            end

            ww = cd;
            mkdir ('RASTERS_Static/Neuron', num2str(nn));
            saveas(gcf,[ww,'/RASTERS_Static/Neuron/', num2str(nn), '/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RASTERS_Static/Neuron/', num2str(nn), '/R_',num2str(BIT_Number),'.fig'])  
            close
            end
     end
     
    end

%     ww = cd;
%     mkdir ('RasterS_Movies/Neuron', num2str(nn));
%     saveas(figure(nn),[ww,'/RasterS_Movies/Neuron', num2str(nn), '/R_',num2str(BIT_Number),'.jpeg']) 
%     saveas(figure(nn),[ww,'/RasterS_Movies/Neuron', num2str(nn), '/R_',num2str(BIT_Number),'.fig'])  
    
end
    
