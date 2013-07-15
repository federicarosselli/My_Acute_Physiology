
%%%%%% OBJECTS TUNING
%%%%%%%%%%%%%%%%%%%%%

clear all
clc
close all

DayOfRecording = '2_7_2013';
Block=12;

my_folder = ['/zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_', char(DayOfRecording), '/ANALYSED/BlockS-', num2str(Block), '/BL_2/My_Structure/25'];
% my_folder = ['/zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_', , char(DayOfRecording), '/ANALYSED/Block-' , num2str(Block), '/My_Structure/25'];

addpath /zocconasphys1/chronic_inv_rec/codes/
load My_StimS_NUANGLE_NUCONDITIONS

% Cool_Psths
% neuronS = BlockS_56;   %%% >>>>>>> optimize!!!


cd (my_folder)

files = dir(fullfile('*.mat'));
neuronS = (numel(files))/2;

object = [1, 2, 3, 4];
% object = [-1, 0, 1, 2, 3, 4, 9, 11, 22, 111, 222, 333, 444];
% COLORSET=varycolor(object);



for nn = 1:neuronS
    countolo=0;
    
    % spike countin window >>>>>> optimize
    T1= 50 ;
    T2 = 250;
        
    load(['PSTH_RASTER_', num2str(nn),'.mat'])
    load(['NEURON_', num2str(nn),'.mat'])

contami = 0;

%% Fast Motion Tuning

for ob = object
    
    
        COLORSET=varycolor(numel(object));
        contami = contami+1;
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
            
            ww = cd;
            stringS=strcat('TUNING/', num2str(nn), '/', char(stimidentity));
            mkdir(stringS);

        [a z]=ind2sub(size(Fede_STIM_NU), find(Fede_STIM_NU(1:342,2)==ob & Fede_STIM_NU(1:342,12)==0.763100000000000));       
        selected_bits = a';       
        motion_set=sort(unique(Fede_STIM_NU(selected_bits,13)));   %%% 13th column = direction of motion
 
        for z = 1:numel(motion_set)  
            
        I=motion_set(z);
        stim = selected_bits(z);
        sp_tr=[];

            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{stim,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{stim,oi}<(T2/1000+PRE_TIME));
            end
            sp_tr
            TUN.Fast.Me{nn}(z)=mean(sp_tr)/(T2-T1)*1000;
            TUN.Fast.St{nn}(z)=std(sp_tr)/(T2-T1)*1000;
            TUN.Fast.Se{nn}(z)=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;

                bbb(find(motion_set==I))=TUN.Fast.Me{nn}(z);
                sss(find(motion_set==I))=TUN.Fast.Se{nn}(z);
                %sp_tr
        end
        

                
            %% blanks (bitcode 6 for FastMoving bblank)
            sp_tr=[];
            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{6,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{6,oi}<(T2/1000+PRE_TIME));
            end
            
            TUN_Bl.Fast.Me{nn}=mean(sp_tr)/(T2-T1)*1000;
            TUN_Bl.Fast.St{nn}=std(sp_tr)/(T2-T1)*1000;
            TUN_Bl.Fast.Se{nn}=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
                bbb(find(motion_set==I)+1)=TUN_Bl.Fast.Me{nn};
                sss(find(motion_set==I)+1)=TUN_Bl.Fast.Se{nn};

                h(nn)=figure(nn)
                
        
                
                
       %% plot    

%             subplot(2,1,1) 
            %figure(objs)
            title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);
            xlabel(['Fast Motion Tuning'])
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
            her{ob}=errorbar(motion_set,bbb(1:numel(motion_set))',sss(1:numel(motion_set))','-O','color',COLORSET(contami,:)) %,)
            xlim([motion_set(1)-3 motion_set(end)+3])
            set(gca, 'XTick', [motion_set])
           
            
        
end
            legend([her{1},her{2},her{3},her{4}],{'Ent','Bunny','Orca','Pingu'})
 
            saveas(gcf,[ww,'/TUNING/', num2str(nn), '/', char(stimidentity), '/fT_', char(stimidentity),'.png']) 
            saveas(gcf,[ww,'/TUNING/', num2str(nn), '/', char(stimidentity), '/fT_', char(stimidentity),'.fig'])  
            close




%% Slow Motion Tuning

for ob = object
    
    
        COLORSET=varycolor(numel(object));
        contami = contami+1;
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
            
            ww = cd;
            stringS=strcat('TUNING/', num2str(nn), '/', char(stimidentity));
            mkdir(stringS);

        [a z]=ind2sub(size(Fede_STIM_NU), find(Fede_STIM_NU(1:342,2)==ob & Fede_STIM_NU(1:342,12)==1.984000000000000));       
        selected_bits = a';       
        motion_set=sort(unique(Fede_STIM_NU(selected_bits,13)));   %%% 13th column = direction of motion
 
        for z = 1:numel(motion_set)  
            
        I=motion_set(z);
        stim = selected_bits(z);
        sp_tr=[];

            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{stim,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{stim,oi}<(T2/1000+PRE_TIME));
            end
            sp_tr
            TUN.Slow.Me{nn}(z)=mean(sp_tr)/(T2-T1)*1000;
            TUN.Slow.St{nn}(z)=std(sp_tr)/(T2-T1)*1000;
            TUN.Slow.Se{nn}(z)=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;

                bbb(find(motion_set==I))=TUN.Slow.Me{nn}(z);
                sss(find(motion_set==I))=TUN.Slow.Se{nn}(z);
                %sp_tr
        end
        

                
            %% blanks (bitcode 6 for FastMoving bblank)
            sp_tr=[];
            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{6,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{6,oi}<(T2/1000+PRE_TIME));
            end
            
            TUN_Bl.Slow.Me{nn}=mean(sp_tr)/(T2-T1)*1000;
            TUN_Bl.Slow.St{nn}=std(sp_tr)/(T2-T1)*1000;
            TUN_Bl.Slow.Se{nn}=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
                bbb(find(motion_set==I)+1)=TUN_Bl.Slow.Me{nn};
                sss(find(motion_set==I)+1)=TUN_Bl.Slow.Se{nn};

                h(nn)=figure(nn)
                
        
                
                
       %% plot    

%             subplot(2,1,1) 
            %figure(objs)
            title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);
            xlabel(['Slow Motion Tuning'])
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
            her{ob}=errorbar(motion_set,bbb(1:numel(motion_set))',sss(1:numel(motion_set))','-O','color',COLORSET(contami,:)) %,)
            xlim([motion_set(1)-3 motion_set(end)+3])
            set(gca, 'XTick', [motion_set])
           
            
        
end
            legend([her{1},her{2},her{3},her{4}],{'Ent','Bunny','Orca','Pingu'})
 
            saveas(gcf,[ww,'/TUNING/', num2str(nn), '/', char(stimidentity), '/slT_', char(stimidentity),'.png']) 
            saveas(gcf,[ww,'/TUNING/', num2str(nn), '/', char(stimidentity), '/slT_', char(stimidentity),'.fig'])  
            close

            
          
            
            
            
end

            

save([ww,'/TUNING/Objects_Tuning.mat'], 'TUN', 'TUN_Bl', '-v7.3');
