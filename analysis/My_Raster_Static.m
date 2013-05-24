clear all
close all
clc

% cd /zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_18_3_2013/ANALYSED/BlockS-67/TEST/BL_2/My_Structure/25
% cd /zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_18_3_2013/ANALYSED/BlockS-67/BL_2/My_Structure/STEST/25
% cd /zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_12_4_2013/ANALYSED/Block-3/My_Structure/25
cd /zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_12_4_2013/ANALYSED/BlockS-56/BL_2/My_Structure/25

files = dir(fullfile('*.mat'));
neuronS = (numel(files))/2;

        % bb = 1:size(PsthAndRaster.Psth{BIT_Number,nn},2);   % bb = bin number;
        % tr = 1:length(Trials{1,1})        % tr = trial number;
      


COLORSET=varycolor(neuronS);

for nn = 3  %:neuronS
    countolo=0;
        
    load(['PSTH_RASTER_', num2str(nn),'.mat'])
    load(['NEURON_', num2str(nn),'.mat'])
    bitcodes = PsthAndRaster.BitCodes;
    bin=PsthAndRaster.BinSize;

     for BIT_Number = 1:bitcodes;

            T=linspace(-200,2200,size(PsthAndRaster.Psth{BIT_Number,nn},2));
            a = PsthAndRaster.Trials{BIT_Number,nn}(1);
            stim_pres_time = (STIM_STOP(a)-STIM_START(a))*1000;
            
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
            title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Moving Condition ', num2str(BIT_Number)]) 
            
            end

            ww = cd;
            mkdir ('RasterS_Movies/Neuron', num2str(nn));
            saveas(gcf,[ww,'/RasterS_Movies/Neuron/', num2str(nn), '/R_',num2str(BIT_Number),'.png']) 
            saveas(gcf,[ww,'/RasterS_Movies/Neuron/', num2str(nn), '/R_',num2str(BIT_Number),'.fig'])  
            close
            end
     end

%     ww = cd;
%     mkdir ('RasterS_Movies/Neuron', num2str(nn));
%     saveas(figure(nn),[ww,'/RasterS_Movies/Neuron', num2str(nn), '/R_',num2str(BIT_Number),'.jpeg']) 
%     saveas(figure(nn),[ww,'/RasterS_Movies/Neuron', num2str(nn), '/R_',num2str(BIT_Number),'.fig'])  
    
end
    
