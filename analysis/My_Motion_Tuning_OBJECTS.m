
%%%%%% OBJECTS TUNING
%%%%%%%%%%%%%%%%%%%%%

clear all
clc
close all

DayOfRecording = '19_7_2013';
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
    T2 = 200;
        
    load(['PSTH_RASTER_', num2str(nn),'.mat'])
    load(['NEURON_', num2str(nn),'.mat'])

contami = 0;

%% Fast Motion Tuning

for ob = object
    
    
        COLORSET=varycolor(numel(object));

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
        motion_values = Fede_STIM_NU(selected_bits,13);
%         motion_set=sort(unique(Fede_STIM_NU(selected_bits,13)));   %%% 13th column = direction of motion
 
        for z = 1:numel(motion_values)  
            
        I=motion_values(z);
        stim = selected_bits(z);
        sp_tr=[];

            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{stim,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{stim,oi}<(T2/1000+PRE_TIME));
            end
            sp_tr
            TUN.Fast.Me{nn}(z)=mean(sp_tr)/(T2-T1)*1000;
            TUN.Fast.St{nn}(z)=std(sp_tr)/(T2-T1)*1000;
            TUN.Fast.Se{nn}(z)=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;

                bbb(find(motion_values==I))=TUN.Fast.Me{nn}(z);
                sss(find(motion_values==I))=TUN.Fast.Se{nn}(z);
                %sp_tr
        end
        

                
            %% black blanks (bitcode 6 for short bblank)
            sp_tr=[];
            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{6,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{6,oi}<(T2/1000+PRE_TIME));
            end
            
            TUN_BBl.Fast.Me{nn}=mean(sp_tr)/(T2-T1)*1000;
            TUN_BBl.Fast.St{nn}=std(sp_tr)/(T2-T1)*1000;
            TUN_BBl.Fast.Se{nn}=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
                bbb(find(motion_values==I)+1)=TUN_BBl.Fast.Me{nn};
                sss(find(motion_values==I)+1)=TUN_BBl.Fast.Se{nn};

                h(nn)=figure(nn)
                
           %% white blanks (bitcode 3 for short wblank)
            sp_tr=[];
            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{3,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{3,oi}<(T2/1000+PRE_TIME));
            end
            
            TUN_WBl.Fast.Me{nn}=mean(sp_tr)/(T2-T1)*1000;
            TUN_WBl.Fast.St{nn}=std(sp_tr)/(T2-T1)*1000;
            TUN_WBl.Fast.Se{nn}=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
                bbb(find(motion_values==I)+2)=TUN_WBl.Fast.Me{nn};
                sss(find(motion_values==I)+2)=TUN_WBl.Fast.Se{nn};

                h(nn)=figure(nn)
                
                
                
                
           bbl = [bbb(end-1), bbb(end-1), bbb(end-1), bbb(end-1), bbb(end-1), bbb(end-1), bbb(end-1), bbb(end-1)];
           wbl = [bbb(end), bbb(end), bbb(end), bbb(end), bbb(end), bbb(end), bbb(end), bbb(end)]; 
           
           
       %% plot    

%             subplot(2,1,1) 
            %figure(objs)
%             title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);
%             xlabel(['Fast Motion Tuning'])
%             hold on;
%             Y=[];
%             ordered_values=sortGivenOrder(motion_values);
%             for iu=1:numel(ordered_values)
%                 Y=[Y;bbb(end-1)-sss(end-1)/2 sss(end-1)/2 sss(end-1)/2];
%             end
%             
%             h = area(ordered_values,Y,-5); % Set BaseValue via argument
%             set(h(1),'FaceColor',[.5 0.5 0.5])
%             set(h(2),'FaceColor',[.5 0.5 0.5])
%             set(h(3),'FaceColor',[.5 0.5 0.5])
%             set(h,'LineStyle',':','LineWidth',0.1) % Set all to same value.
%             set(h,'basevalue',bbb(end-1)-sss(end-1)/2)
%             hold on
%             line([ordered_values(1) ordered_values(end)],[bbb(end-1) bbb(end-1)],'color','k','linewidth',2)
%             hold on
%             ordered_bbb=sortGivenOrder(bbb(1:numel(motion_values)));
%             ordered_sss=sortGivenOrder(sss(1:numel(motion_values)));
%             her{ob}=errorbar(ordered_values,ordered_bbb,ordered_sss,'-O','color',COLORSET(contami,:), 'linewidth', 1.5)
% %             her{ob}=errorbar(motion_values,bbb(1:numel(motion_values)),sss(1:numel(motion_values)),'-O','color',COLORSET(contami,:)) %,)
%             xlim([min(motion_values)-3 max(motion_values)+3])
%             set(gca, 'XTick', [motion_set'])
             
              ordered_values=sortGivenOrder(motion_values);
              ordered_bbb{ob}=sortGivenOrder(bbb(1:numel(motion_values)));
              ordered_sss{ob}=sortGivenOrder(sss(1:numel(motion_values)));
              rad_ordered_values = ordered_values .* pi/180;
              
              
end


for i=1:4
              contami = contami+1;
              grey=[0.4, 0.4, 0.4];
              grey2=[0.65, 0.65, 0.65];
              all_bbs = [ordered_bbb{1,:}, bbl, wbl];
              my_ref = max(all_bbs);
              my_ref_vect = [my_ref, my_ref, my_ref, my_ref, my_ref, my_ref, my_ref, my_ref];
              ra = polar(rad_ordered_values, my_ref_vect);
              set(ra, 'color', 'w', 'linewidth', .1)   
              hold on;
              ha{i} = polar(rad_ordered_values, ordered_bbb{i});
              set(ha{i}, 'color', COLORSET(contami,:), 'linewidth', 3)              
              hold on;
              wa = polar(rad_ordered_values, wbl);
              set(wa, 'color', grey2, 'linewidth', 2)
              hold on;
              
              ja = polar(rad_ordered_values, bbl);
              set(ja, 'color', grey, 'linewidth', 2)
%               hold on;
              view(90, -90);
              
              title(['Fast Motion Tuning', 'Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);

              clear all_bbs my_ref my_ref_vect ra ja wa
           
            
        
end

            legend([ha{1},ha{2},ha{3},ha{4}],{'Ent','Bunny','Orca','Pingu'})
 
            saveas(gcf,[ww,'/TUNING/', num2str(nn), '/', char(stimidentity), '/fT_', char(stimidentity),'.png']) 
            saveas(gcf,[ww,'/TUNING/', num2str(nn), '/', char(stimidentity), '/fT_', char(stimidentity),'.fig'])  
            close

            clear ha bbb sss selected_bits Y bbl wbl ordered_values ordered_bbb ordered_sss


%% Slow Motion Tuning

contami = 0;

for ob = object
    
    
        COLORSET=varycolor(numel(object));

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
        
 
        for z = 1:numel(motion_values)  
            
        I=motion_values(z);
        stim = selected_bits(z);
        sp_tr=[];

            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{stim,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{stim,oi}<(T2/1000+PRE_TIME));
            end
            sp_tr
            TUN.Slow.Me{nn}(z)=mean(sp_tr)/(T2-T1)*1000;
            TUN.Slow.St{nn}(z)=std(sp_tr)/(T2-T1)*1000;
            TUN.Slow.Se{nn}(z)=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;

                bbb(find(motion_values==I))=TUN.Slow.Me{nn}(z);
                sss(find(motion_values==I))=TUN.Slow.Se{nn}(z);
                %sp_tr
        end
        

                
            %% blanks (bitcode 5 for long bblank)
            sp_tr=[];
            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{5,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{5,oi}<(T2/1000+PRE_TIME));
            end
            
            TUN_Bl.Slow.Me{nn}=mean(sp_tr)/(T2-T1)*1000;
            TUN_Bl.Slow.St{nn}=std(sp_tr)/(T2-T1)*1000;
            TUN_Bl.Slow.Se{nn}=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
                bbb(find(motion_values==I)+1)=TUN_Bl.Slow.Me{nn};
                sss(find(motion_values==I)+1)=TUN_Bl.Slow.Se{nn};

                h(nn)=figure(nn)
                
                
            %% white blanks (bitcode 2 for long wblank)
            sp_tr=[];
            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{2,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{2,oi}<(T2/1000+PRE_TIME));
            end
            
            TUN_WBl.Fast.Me{nn}=mean(sp_tr)/(T2-T1)*1000;
            TUN_WBl.Fast.St{nn}=std(sp_tr)/(T2-T1)*1000;
            TUN_WBl.Fast.Se{nn}=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
                bbb(find(motion_values==I)+2)=TUN_WBl.Fast.Me{nn};
                sss(find(motion_values==I)+2)=TUN_WBl.Fast.Se{nn};

                h(nn)=figure(nn)    
        
              
           bbl = [bbb(end-1), bbb(end-1), bbb(end-1), bbb(end-1), bbb(end-1), bbb(end-1), bbb(end-1), bbb(end-1)];
           wbl = [bbb(end), bbb(end), bbb(end), bbb(end), bbb(end), bbb(end), bbb(end), bbb(end)];        
                
       %% plot    

% %             subplot(2,1,1) 
%             %figure(objs)
%             title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);
%             xlabel(['Slow Motion Tuning'])
%             hold on;
%             Y=[];
%             ordered_values=sortGivenOrder(motion_values);
%             for iu=1:numel(ordered_values)
%                 Y=[Y;bbb(end-1)-sss(end-1)/2 sss(end-1)/2 sss(end-1)/2];
%             end
%             
%             h = area(ordered_values,Y,-5); % Set BaseValue via argument
%             set(h(1),'FaceColor',[.5 0.5 0.5])
%             set(h(2),'FaceColor',[.5 0.5 0.5])
%             set(h(3),'FaceColor',[.5 0.5 0.5])
%             set(h,'LineStyle',':','LineWidth',0.1) % Set all to same value.
%             set(h,'basevalue',bbb(end-1)-sss(end-1)/2)
%             hold on
%             line([ordered_values(1) ordered_values(end)],[bbb(end-1) bbb(end-1)],'color','k','linewidth',2)
%             hold on
%             ordered_bbb=sortGivenOrder(bbb(1:numel(motion_values)));
%             ordered_sss=sortGivenOrder(sss(1:numel(motion_values)));
%             her{ob}=errorbar(ordered_values,ordered_bbb,ordered_sss,'-O','color',COLORSET(contami,:), 'linewidth', 1.5)
% %             her{ob}=errorbar(motion_values,bbb(1:numel(motion_values)),sss(1:numel(motion_values)),'-O','color',COLORSET(contami,:)) %,)
%             xlim([min(motion_values)-3 max(motion_values)+3])
%             set(gca, 'XTick', [motion_set'])

              ordered_values=sortGivenOrder(motion_values);
              ordered_bbb{ob}=sortGivenOrder(bbb(1:numel(motion_values)));
              ordered_sss{ob}=sortGivenOrder(sss(1:numel(motion_values)));
              rad_ordered_values = ordered_values .* pi/180;
              
end
              
for i=1:4
              contami = contami+1;
              grey=[0.4, 0.4, 0.4];
              grey2=[0.65, 0.65, 0.65];
              all_bbs = [ordered_bbb{1,:}, bbl, wbl];
              my_ref = max(all_bbs);
              my_ref_vect = [my_ref, my_ref, my_ref, my_ref, my_ref, my_ref, my_ref, my_ref];
              ra = polar(rad_ordered_values, my_ref_vect);
              set(ra, 'color', 'w', 'linewidth', .1)   
              hold on;
              ha{i} = polar(rad_ordered_values, ordered_bbb{i});
              set(ha{i}, 'color', COLORSET(contami,:), 'linewidth', 3)              
              hold on;
              wa = polar(rad_ordered_values, wbl);
              set(wa, 'color', grey2, 'linewidth', 2)
              hold on;
              
              ja = polar(rad_ordered_values, bbl);
              set(ja, 'color', grey, 'linewidth', 2)
%               hold on;
              view(90, -90);
              
              title(['Slow Motion Tuning', 'Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);

              clear all_bbs my_ref my_ref_vect ra ja wa
           
            
        
end
              


            legend([ha{1},ha{2},ha{3},ha{4}],{'Ent','Bunny','Orca','Pingu'})
 
            saveas(gcf,[ww,'/TUNING/', num2str(nn), '/', char(stimidentity), '/slT_', char(stimidentity),'.png']) 
            saveas(gcf,[ww,'/TUNING/', num2str(nn), '/', char(stimidentity), '/slT_', char(stimidentity),'.fig'])  
            close

            
            clear ha bbb sss selected_bits Y bbl wbl ordered_values ordered_bbb ordered_sss
            
            
            
end

            

save([ww,'/TUNING/Objects_Tuning.mat'], 'TUN', 'TUN_BBl', 'TUN_WBl', '-v7.3');
