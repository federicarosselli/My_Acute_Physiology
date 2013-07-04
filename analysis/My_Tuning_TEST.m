%%%%%% TUNING

clear all
clc
close all

DayOfRecording = '12_4_2013';
Block=56;

my_folder = ['/zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_', char(DayOfRecording), '/ANALYSED/BlockS-', num2str(Block), '/BL_2/My_Structure/25'];
% my_folder = ['/zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_', , char(DayOfRecording), '/ANALYSED/Block-' , num2str(Block), '/My_Structure/25'];

addpath /zocconasphys1/chronic_inv_rec/codes/
load My_StimS

% Cool_Psths
% neuronS = BlockS_56;   %%% >>>>>>> optimize!!!


cd (my_folder)

files = dir(fullfile('*.mat'));
neuronS = (numel(files))/2;

COLORSET=varycolor(neuronS);


for nn = 1 %1:neuronS
    countolo=0;
    
    % spike countin window >>>>>> optimize
    T1= 50 ;
    T2 = 250;
        
    load(['PSTH_RASTER_', num2str(nn),'.mat'])
    load(['NEURON_', num2str(nn),'.mat'])

    
%     %% object 1, Size Tuning, Static:
%     
%         [a b]=ind2sub(size(Fede_STIM), find(Fede_STIM(139:166,2)==1));
%         size_bits = a+138;
%         selected_bits = size_bits';
%         
%         size_set=sort(unique(Fede_STIM(131:166,3)));
%         
%     
%         for BIT_Number = 1:numel(size_set)         
%         I=size_set(BIT_Number);
%         sp_tr=[];
% 
%             for oi=1:size(PsthAndRaster.MySpikes, 2)
%             sp_tr(oi)=sum(PsthAndRaster.MySpikes{BIT_Number,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{BIT_Number,oi}<(T2/1000+PRE_TIME));
%             end
%             sp_tr
%             TUN.Me(BIT_Number)=mean(sp_tr)/(T2-T1)*1000;
%             TUN.St(BIT_Number)=std(sp_tr)/(T2-T1)*1000;
%             TUN.Se(BIT_Number)=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
% 
% %             Fano(BIT_Number)=var(sp_tr)/mean(sp_tr);
% 
%                 bbb(find(size_set==I))=TUN.Me(BIT_Number);
%                 sss(find(size_set==I))=TUN.Se(BIT_Number);
%                 %sp_tr
%         end
%     
%      %% blanks (bitcode 3 for static black)
%             sp_tr=[];
%             for oi=1:size(PsthAndRaster.MySpikes, 2)
%             sp_tr(oi)=sum(PsthAndRaster.MySpikes{3,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{3,oi}<(T2/1000+PRE_TIME));
%             end
%             
%             TUN_Bl.Me=mean(sp_tr)/(T2-T1)*1000;
%             TUN_Bl.St=std(sp_tr)/(T2-T1)*1000;
%             TUN_Bl.Se=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
%                 bbb(find(size_set==I)+1)=TUN_Bl.Me;
%                 sss(find(size_set==I)+1)=TUN_Bl.Se;
% 
%                 h(nn)=figure(nn)
%                 
%                 
%        %% plot    
% 
%             subplot(2,1,1) 
%             title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);
%             xlabel(['Size tuning'])
%             Y=[];
%             for iu=1:numel(size_set)
%                 Y=[Y;bbb(end)-sss(end)/2 sss(end)/2 sss(end)/2];
%             end
%             h = area(size_set,Y,-5); % Set BaseValue via argument
%             set(h(1),'FaceColor',[.5 0.5 0.5])
%             set(h(2),'FaceColor',[.5 0.5 0.5])
%             set(h(3),'FaceColor',[.5 0.5 0.5])
%             set(h,'LineStyle',':','LineWidth',0.1) % Set all to same value.
%             set(h,'basevalue',bbb(end)-sss(end)/2)
%             hold on
%             line([size_set(1) size_set(end)],[bbb(end) bbb(end)],'color','k','linewidth',2)
%             hold on
%             her=errorbar(size_set,bbb(1:numel(size_set))',sss(1:numel(size_set))','-O','linewidth',2) %,'color',COLORSET(OBJ,:))
%             xlim([size_set(1)-3 size_set(end)+3])
%             legend(her,['object ',num2str(1)])
% 
% 
% end

%% object 1, Motion Tuning

for objs = 1:4
    
        [a b]=ind2sub(size(Fede_STIM), find(Fede_STIM(55:86,2)==objs));
        motion_bits = a+54;
        selected_bits = motion_bits';
        
        motion_set=sort(unique(Fede_STIM(selected_bits,13)));
 
        for z = 1:numel(motion_set)  
        I=motion_set(z);
        stim = selected_bits(z);
        sp_tr=[];

            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{stim,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{stim,oi}<(T2/1000+PRE_TIME));
            end
            sp_tr
            TUN.Me(z)=mean(sp_tr)/(T2-T1)*1000;
            TUN.St(z)=std(sp_tr)/(T2-T1)*1000;
            TUN.Se(z)=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;

%             Fano(BIT_Number)=var(sp_tr)/mean(sp_tr);

                bbb(find(motion_set==I))=TUN.Me(z);
                sss(find(motion_set==I))=TUN.Se(z);
                %sp_tr
        end
    
     %% blanks (bitcode 4 for static black)
            sp_tr=[];
            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{4,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{4,oi}<(T2/1000+PRE_TIME));
            end
            
            TUN_Bl.Me=mean(sp_tr)/(T2-T1)*1000;
            TUN_Bl.St=std(sp_tr)/(T2-T1)*1000;
            TUN_Bl.Se=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
                bbb(find(motion_set==I)+1)=TUN_Bl.Me;
                sss(find(motion_set==I)+1)=TUN_Bl.Se;

                h(nn)=figure(nn)
                
                
       %% plot    

%             subplot(2,1,1) 
            %figure(objs)
            title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);
            xlabel(['Motion tuning'])
            Y=[];
            for iu=1:numel(motion_set)
                Y=[Y;bbb(end)-sss(end)/2 sss(end)/2 sss(end)/2];
            end
            h = area(motion_set,Y,-5); % Set BaseValue via argument
            set(h(1),'FaceColor',[.5 0.5 0.5])
            set(h(2),'FaceColor',[.5 0.5 0.5])
            set(h(3),'FaceColor',[.5 0.5 0.5])
            set(h,'LineStyle',':','LineWidth',0.1) % Set all to same value.
            set(h,'basevalue',bbb(end)-sss(end)/2)
            hold on
            line([motion_set(1) motion_set(end)],[bbb(end) bbb(end)],'color','k','linewidth',2)
            hold on
            her=errorbar(motion_set,bbb(1:numel(motion_set))',sss(1:numel(motion_set))','-O','linewidth',objs,'color',COLORSET(nn,:)) %,)
            xlim([motion_set(1)-3 motion_set(end)+3])
            set(gca, 'XTick', [motion_set])
            legend(her,['object ',num2str(objs)])

            ww = cd;
            stringS=strcat('TUNING/Objects/', num2str(nn), '/Movies');
            mkdir(stringS);
            saveas(gcf,[ww,'/TUNING/Objects/', num2str(nn), '/Movies/Obj_',num2str(objs),'.png']) 
            saveas(gcf,[ww,'/TUNING/Objects/', num2str(nn), '/Movies/Obj_',num2str(objs),'.fig'])  
%             close
            
            clear a b selected_bits stim
            
end

end
