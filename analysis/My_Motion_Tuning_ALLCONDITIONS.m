
%%%%%% MOTION TUNING ALL CONDITIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
clc
close all

DayOfRecording = '22_11_2013';
Block=12;

my_folder = ['/zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_', char(DayOfRecording), '/ANALYSED/BlockS-', num2str(Block), '/BL_2/My_Structure/25'];
% my_folder = ['/zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_', , char(DayOfRecording), '/ANALYSED/Block-' , num2str(Block), '/My_Structure/25'];

addpath /zocconasphys1/chronic_inv_rec/codes/
addpath /zocconasphys1/chronic_inv_rec/codes/export_fig
load My_StimS_NUANGLE_NUCONDITIONS

% Cool_Psths
% neuronS = BlockS_56;   %%% >>>>>>> optimize!!!


cd (my_folder)

files = dir(fullfile('*.mat'));
neuronS = (numel(files))/2;

cd WINDOWS
load Windows_2
cd ..

mkdir(['TUNING_NEW/'])

my_times = Window;
clear Window

object = [1, 2, 3, 4];
object2 = [-1];
object3 = [111,222,333,444];
object4 = [11,22];

% object = [-1, 0, 1, 2, 3, 4, 9, 11, 22, 111, 222, 333, 444];
% COLORSET=varycolor(object);
T1_All = [];
T2_All = [];
% global nn
% global my_bits


for nn = 1:neuronS
    countolo=0;
    conta = 0;
    conta2 = 0;
    conta3 = 0;
    % spike countin window >>>>>> optimize
%     T1= 0 ;
%     T2 = 300;
        
    load(['PSTH_RASTER_', num2str(nn),'.mat'])
    load(['NEURON_', num2str(nn),'.mat'])

contami = 0;

PRE_TIME = 0;
POST_TIME = 0;

%% Objects
%% Fast Motion Tuning

for ob = object

        T1=[];
        T2=[];
        
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
            
%             ww = cd;
%             stringS=strcat('TUNING/', num2str(nn), '/', char(stimidentity));
%             mkdir(stringS);

        [a z]=ind2sub(size(Fede_STIM_NU), find(Fede_STIM_NU(1:342,2)==ob & Fede_STIM_NU(1:342,11)==0.763100000000000));       
        selected_bits = a';       
        motion_values = Fede_STIM_NU(selected_bits,12);
%         motion_set=sort(unique(Fede_STIM_NU(selected_bits,13)));   %%% 13th column = direction of motion
 
%         for my_bits = selected_bits;
%             [T1, T2]=My_Window_NEW;
%             T1_All = [T1_All, T1];
%             T2_All = [T2_All, T2];
%         end
        
        
        
        for z = 1:numel(motion_values)  
            
        I=motion_values(z);
        stim = selected_bits(z);
        sp_tr=[];
        
        T1=my_times{stim,nn}(1);
        T2=my_times{stim,nn}(2);

            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{stim,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{stim,oi}<(T2/1000+PRE_TIME));
            end
            sp_tr
            ObjectsTuning.Fast(ob).Me{nn}(z)=mean(sp_tr)/(T2-T1)*1000;
            ObjectsTuning.Fast(ob).St{nn}(z)=std(sp_tr)/(T2-T1)*1000;
            ObjectsTuning.Fast(ob).Se{nn}(z)=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;

                bbb_f(find(motion_values==I))=ObjectsTuning.Fast(ob).Me{nn}(z);
                sss_f(find(motion_values==I))=ObjectsTuning.Fast(ob).Se{nn}(z);
                std_f(find(motion_values==I))=ObjectsTuning.Fast(ob).St{nn}(z);
                %sp_tr
        end
        

                
            %% black blanks (bitcode 6 for short bblank)
            sp_tr=[];
            
            T1=my_times{6,nn}(1);
            T2=my_times{6,nn}(2);
            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{6,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{6,oi}<(T2/1000+PRE_TIME));
            end
            
            ObjectsTuning_BB.Fast.Me{nn}=mean(sp_tr)/(T2-T1)*1000;
            ObjectsTuning_BB.Fast.St{nn}=std(sp_tr)/(T2-T1)*1000;
            ObjectsTuning_BB.Fast.Se{nn}=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
                bbb_f(find(motion_values==I)+1)=ObjectsTuning_BB.Fast.Me{nn};
                sss_f(find(motion_values==I)+1)=ObjectsTuning_BB.Fast.Se{nn};
                std_f(find(motion_values==I)+1)=ObjectsTuning_BB.Fast.St{nn};

%                 h(nn)=figure(nn)
                
           %% white blanks (bitcode 3 for short wblank)
            sp_tr=[];
           
            T1=my_times{3,nn}(1);
            T2=my_times{3,nn}(2);
            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{3,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{3,oi}<(T2/1000+PRE_TIME));
            end
            
            ObjectsTuning_WB.Fast.Me{nn}=mean(sp_tr)/(T2-T1)*1000;
            ObjectsTuning_WB.Fast.St{nn}=std(sp_tr)/(T2-T1)*1000;
            ObjectsTuning_WB.Fast.Se{nn}=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
                bbb_f(find(motion_values==I)+2)=ObjectsTuning_WB.Fast.Me{nn};
                sss_f(find(motion_values==I)+2)=ObjectsTuning_WB.Fast.Se{nn};
                std_f(find(motion_values==I)+2)=ObjectsTuning_WB.Fast.St{nn};
                
                
                
                
                
           bbl_f = [bbb_f(end-1), bbb_f(end-1), bbb_f(end-1), bbb_f(end-1), bbb_f(end-1), bbb_f(end-1), bbb_f(end-1), bbb_f(end-1)];
           wbl_f = [bbb_f(end), bbb_f(end), bbb_f(end), bbb_f(end), bbb_f(end), bbb_f(end), bbb_f(end), bbb_f(end)]; 
           
              ordered_values=sortGivenOrder(motion_values);
              ordered_bbb_f1=sortGivenOrder(bbb_f(1:numel(motion_values)));
              ordered_sss_f1=sortGivenOrder(sss_f(1:numel(motion_values)));
              ordered_bbb_f{ob}=sortGivenOrder(bbb_f(1:numel(motion_values)));
              ordered_sss_f{ob}=sortGivenOrder(sss_f(1:numel(motion_values)));
              ordered_std_f{ob}=sortGivenOrder(std_f(1:numel(motion_values)));
              rad_ordered_values = ordered_values .* pi/180;
              
              
            ObjectsTuning.Fast(ob).Me{nn}=ordered_bbb_f{ob};
            ObjectsTuning.Fast(ob).Se{nn}=ordered_sss_f{ob};
            ObjectsTuning.Fast(ob).St{nn}=ordered_std_f{ob};
              
    
              
 %% Slow Motion Tuning

        [a z]=ind2sub(size(Fede_STIM_NU), find(Fede_STIM_NU(1:342,2)==ob & Fede_STIM_NU(1:342,11)==1.984000000000000));       
        selected_bits = a';       
        motion_values = Fede_STIM_NU(selected_bits,12);
 
        for z = 1:numel(motion_values)  
            
        I=motion_values(z);
        stim = selected_bits(z);
        sp_tr=[];
       
        T1=my_times{stim,nn}(1);
        T2=my_times{stim,nn}(2);

            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{stim,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{stim,oi}<(T2/1000+PRE_TIME));
            end
            sp_tr
            ObjectsTuning.Slow(ob).Me{nn}(z)=mean(sp_tr)/(T2-T1)*1000;
            ObjectsTuning.Slow(ob).St{nn}(z)=std(sp_tr)/(T2-T1)*1000;
            ObjectsTuning.Slow(ob).Se{nn}(z)=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;

                bbb_s(find(motion_values==I))=ObjectsTuning.Slow(ob).Me{nn}(z);
                sss_s(find(motion_values==I))=ObjectsTuning.Slow(ob).Se{nn}(z);
                std_s(find(motion_values==I))=ObjectsTuning.Slow(ob).St{nn}(z);
                %sp_tr
        end
        

                
            %% blanks (bitcode 5 for long bblank)
            sp_tr=[];
           
            T1=my_times{5,nn}(1);
            T2=my_times{5,nn}(2);
            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{5,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{5,oi}<(T2/1000+PRE_TIME));
            end
            
            ObjectsTuning_BB.Slow.Me{nn}=mean(sp_tr)/(T2-T1)*1000;
            ObjectsTuning_BB.Slow.St{nn}=std(sp_tr)/(T2-T1)*1000;
            ObjectsTuning_BB.Slow.Se{nn}=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
                bbb_s(find(motion_values==I)+1)=ObjectsTuning_BB.Slow.Me{nn};
                sss_s(find(motion_values==I)+1)=ObjectsTuning_BB.Slow.Se{nn};
                std_s(find(motion_values==I)+1)=ObjectsTuning_BB.Slow.St{nn};

%                 h(nn)=figure(nn)
                
                
            %% white blanks (bitcode 2 for long wblank)
            sp_tr=[];
          
            T1=my_times{2,nn}(1);
            T2=my_times{2,nn}(2);
            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{2,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{2,oi}<(T2/1000+PRE_TIME));
            end
            
            ObjectsTuning_WB.Slow.Me{nn}=mean(sp_tr)/(T2-T1)*1000;
            ObjectsTuning_WB.Slow.St{nn}=std(sp_tr)/(T2-T1)*1000;
            ObjectsTuning_WB.Slow.Se{nn}=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
                bbb_s(find(motion_values==I)+2)=ObjectsTuning_WB.Slow.Me{nn};
                sss_s(find(motion_values==I)+2)=ObjectsTuning_WB.Slow.Se{nn};
                std_s(find(motion_values==I)+2)=ObjectsTuning_WB.Slow.St{nn};

%                 h(nn)=figure(nn)    
%                 title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);
               
              
           bbl_s = [bbb_s(end-1), bbb_s(end-1), bbb_s(end-1), bbb_s(end-1), bbb_s(end-1), bbb_s(end-1), bbb_s(end-1), bbb_s(end-1)];
           wbl_s = [bbb_s(end), bbb_s(end), bbb_s(end), bbb_s(end), bbb_s(end), bbb_s(end), bbb_s(end), bbb_s(end)];    
           
           
%               ordered_values=sortGivenOrder(motion_values);
              ordered_bbb_s1=sortGivenOrder(bbb_s(1:numel(motion_values)));
              ordered_sss_s1=sortGivenOrder(sss_s(1:numel(motion_values)));
              ordered_bbb_s{ob}=sortGivenOrder(bbb_s(1:numel(motion_values)));
              ordered_sss_s{ob}=sortGivenOrder(sss_s(1:numel(motion_values)));
              ordered_std_s{ob}=sortGivenOrder(std_s(1:numel(motion_values)));
              
            ObjectsTuning.Slow(ob).Me{nn}=ordered_bbb_s{ob};
            ObjectsTuning.Slow(ob).Se{nn}=ordered_sss_s{ob};
            ObjectsTuning.Slow(ob).St{nn}=ordered_std_s{ob};
                            
                             
              
              
end
              
              
              
       %% plot    
            myfig = figure(nn);
            set(myfig,'Position',[10,10,1500,1000]);
            set(myfig, 'Name', ['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);
%             title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);
            sb1 = subplot(6,6,1) 
            set(gca,'Position',[.05,.8,.15,.15]);
            
for i=1:numel(object);
            conta3 = conta3+1;    
            
            
%             position=[0.03 .7 0.25 0.22];
%             set(gca, 'Position', position)


            hold on;
            her_f{i}=errorbar(ordered_values,ordered_bbb_f{i},ordered_sss_f{i},'-O','color',COLORSET(conta3,:), 'linewidth', 1.5);
            xlabel(['Fast Motion Tuning'])
            xlim([min(ordered_values)-3 max(ordered_values)+3])
%             set(gca, 'YTick', [min(ordered_values)-3 max(ordered_values)+3])
            set(gca, 'XTick', [ordered_values]) 
            hold on;
            
            Y=[];
            for iu=1:numel(ordered_values)
                Y=[Y;bbb_f(end-1)-sss_f(end-1)/2 sss_f(end-1)/2 sss_f(end-1)/2];
            end          
            h_f = area(ordered_values,Y,-5); % Set BaseValue via argument
            grey=[0.4, 0.4, 0.4];
            set(h_f(1),'FaceColor',grey)
            set(h_f(2),'FaceColor',grey)
            set(h_f(3),'FaceColor',grey)            
            set(h_f,'LineStyle',':','LineWidth',0.1) % Set all to same value.
            set(h_f,'basevalue',bbb_f(end-1)-sss_f(end-1)/2)
            hold on
            alpha(.5)
            line([ordered_values(1) ordered_values(end)],[bbb_f(end-1) bbb_f(end-1)],'color',grey,'linewidth',2);
            hold on;
            
            Y=[];
%             ordered_values=sortGivenOrder(motion_values);
            for iu=1:numel(ordered_values)
                Y=[Y;bbb_f(end)-sss_f(end)/2 sss_f(end)/2 sss_f(end)/2];
            end
            h_f = area(ordered_values,Y,-5);  
            grey2=[0.8, 0.8, 0.8];
            set(h_f(1),'FaceColor',grey2)
            set(h_f(2),'FaceColor',grey2)
            set(h_f(3),'FaceColor',grey2)            
            set(h_f,'LineStyle',':','LineWidth',0.1) % Set all to same value.
            set(h_f,'basevalue',bbb_f(end)-sss_f(end)/2)
            hold on
            alpha(.5)
            line([ordered_values(1) ordered_values(end)],[bbb_f(end) bbb_f(end)],'color',grey2,'linewidth',2);             
            hold on;
                   
end

sb2 = subplot(6,6,2);  %7);
set(gca,'Position',[.05,.58,.15,.15]);

conta3 = 0;

for i=1:numel(object);
            conta3 = conta3+1;   
            

%             position=[0.03 .3 0.25 0.22];
%             set(gca,'Position', position)
            her_s{i}=errorbar(ordered_values,ordered_bbb_s{i},ordered_sss_s{i},'-O','color',COLORSET(conta3,:), 'linewidth', 1.5);
            xlabel(['Slow Motion Tuning'])
            xlim([min(ordered_values)-3 max(ordered_values)+3])
%             ylim([0 max(ordered_bbb_s{i})+3])
            set(gca, 'XTick', [ordered_values])
            hold on;
              Y=[];
            for iu=1:numel(ordered_values)
                Y=[Y;bbb_s(end-1)-sss_s(end-1)/2 sss_s(end-1)/2 sss_s(end-1)/2];
            end          
            h_s = area(ordered_values,Y,-5); % Set BaseValue via argument
            grey=[0.4, 0.4, 0.4];
            set(h_s(1),'FaceColor',grey)
            set(h_s(2),'FaceColor',grey)
            set(h_s(3),'FaceColor',grey)            
            set(h_s,'LineStyle',':','LineWidth',0.1) % Set all to same value.
            set(h_s,'basevalue',bbb_s(end-1)-sss_s(end-1)/2)
            hold on
            alpha(.5)
            line([ordered_values(1) ordered_values(end)],[bbb_s(end-1) bbb_s(end-1)],'color',grey,'linewidth',2);
            hold on;
            
            Y=[];
%             ordered_values=sortGivenOrder(motion_values);
            for iu=1:numel(ordered_values)
                Y=[Y;bbb_s(end)-sss_s(end)/2 sss_s(end)/2 sss_s(end)/2];
            end
            h_s = area(ordered_values,Y,-5);  
            set(h_s(1),'FaceColor',grey2)
            set(h_s(2),'FaceColor',grey2)
            set(h_s(3),'FaceColor',grey2)            
            set(h_s,'LineStyle',':','LineWidth',0.1) % Set all to same value.
            set(h_s,'basevalue',bbb_s(end)-sss_s(end)/2)
            hold on
            alpha(.5)
            line([ordered_values(1) ordered_values(end)],[bbb_s(end) bbb_s(end)],'color',grey2,'linewidth',2);
            hold on;

end


%             xlim([min(ordered_values)-3 max(ordered_values)+3])
%             set(gca, 'XTick', [ordered_values])
            
sb3 = subplot(6,6,2)
set(gca,'Position',[.2,.8,.15,.15]);
conta3 = 0;
conta=0;
              
for i=1:numel(object);
            conta3 = conta3+1;   
%               set(gca,'Position', position)
              conta = conta+1;
              grey=[0.4, 0.4, 0.4];
              grey2=[0.65, 0.65, 0.65];
              all_bbs = [ordered_bbb_f{1,:}, bbl_f, wbl_f];
              my_ref = max(all_bbs);
              my_ref_vect = [my_ref, my_ref, my_ref, my_ref, my_ref, my_ref, my_ref, my_ref];
              ra = polar(rad_ordered_values, my_ref_vect);
              set(ra, 'color', 'w', 'linewidth', .1)   
              hold on;
              ha_f{i} = polar(rad_ordered_values, ordered_bbb_f{i});
              set(ha_f{i}, 'color', COLORSET(conta,:), 'linewidth', 2)              
              hold on;
              wa = polar(rad_ordered_values, wbl_f);
              set(wa, 'color', grey2, 'linewidth', 2)
              hold on;
              
              ja = polar(rad_ordered_values, bbl_f);
              set(ja, 'color', grey, 'linewidth', 2)
%               hold on;
              view(90, -90);
              
%               xlabel(['Fast Motion Tuning']); %, 'Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);

              clear all_bbs my_ref my_ref_vect ra ja wa
              hold on;
end

conta3 = 0;
conta2=0;
sb4 = subplot(6,6,14)
set(gca,'Position',[.2,.58,.15,.15]);

for i=1:numel(object);
            conta3 = conta3+1;   

%               position=[0.3 .45 0.25 0.22];
%               set(gca,'Position', position)
              conta2 = conta2+1;
              grey=[0.4, 0.4, 0.4];
              grey2=[0.65, 0.65, 0.65];
              all_bbs = [ordered_bbb_s{1,:}, bbl_s, wbl_s];
              my_ref = max(all_bbs);
              my_ref_vect = [my_ref, my_ref, my_ref, my_ref, my_ref, my_ref, my_ref, my_ref];
              ra = polar(rad_ordered_values, my_ref_vect);
              set(ra, 'color', 'w', 'linewidth', .1)   
              hold on;
              ha_s{i} = polar(rad_ordered_values, ordered_bbb_s{i});
              set(ha_s{i}, 'color', COLORSET(conta2,:), 'linewidth', 2)              
              hold on;
              wa = polar(rad_ordered_values, wbl_s);
              set(wa, 'color', grey2, 'linewidth', 2)
              hold on;
              
              ja = polar(rad_ordered_values, bbl_s);
              set(ja, 'color', grey, 'linewidth', 2)
%               hold on;
              view(90, -90);
              
%               xlabel(['Slow Motion Tuning']); %, 'Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);

              clear all_bbs my_ref my_ref_vect ra ja wa
              
              hold on;
              
end
            rect = [.35,.75,.02,.02];
            l = legend([ha_s{1},ha_s{2},ha_s{3},ha_s{4}],{'Ent','Bunny','Orca','Pingu'});
            set (l, 'Position', rect);
%             legend([ha_s{1},ha_s{2},ha_s{3},ha_s{4}],{'Ent','Bunny','Orca','Pingu'})
            hold on;
            
clear her_f her_s ha_f ha_s clear ordered_bbb_f ordered_bbb_s ordered_sss_f ordered_sss_s bbb_f sss_f bbb_s sss_s selected_bits Y ordered_values motion_values          
            
            
%             
%% Bars     
%% Fast Motion Tuning
    contami = 0;
    countolo=0;
    conta = 0;
    conta2 = 0;
    conta3 = 0;
for ob = object2

        T1=[];
        T2=[];
        
        COLORSET=varycolor(numel(object2));
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
            
%             ww = cd;
%             stringS=strcat('TUNING/', num2str(nn), '/', char(stimidentity));
%             mkdir(stringS);

        [a z]=ind2sub(size(Fede_STIM_NU), find(Fede_STIM_NU(1:342,2)==ob & Fede_STIM_NU(1:342,11)==0.763100000000000));       
        selected_bits = a';       
        motion_values = Fede_STIM_NU(selected_bits,12);
%         motion_set=sort(unique(Fede_STIM_NU(selected_bits,13)));   %%% 13th column = direction of motion
 
%         for my_bits = selected_bits;
%             [T1, T2]=My_Window_NEW;
%             T1_All = [T1_All, T1];
%             T2_All = [T2_All, T2];
%         end
        
        
        
        for z = 1:numel(motion_values)  
            
        I=motion_values(z);
        stim = selected_bits(z);
        sp_tr=[];
        
        T1=my_times{stim,nn}(1);
        T2=my_times{stim,nn}(2);

            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{stim,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{stim,oi}<(T2/1000+PRE_TIME));
            end
            sp_tr
            BarsTuning.Fast.Me{nn}(z)=mean(sp_tr)/(T2-T1)*1000;
            BarsTuning.Fast.St{nn}(z)=std(sp_tr)/(T2-T1)*1000;
            BarsTuning.Fast.Se{nn}(z)=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;

                bbb_f(find(motion_values==I))=BarsTuning.Fast.Me{nn}(z);
                sss_f(find(motion_values==I))=BarsTuning.Fast.Se{nn}(z);
                std_f(find(motion_values==I))=BarsTuning.Fast.St{nn}(z);
                %sp_tr
        end
        

                
            %% black blanks (bitcode 6 for short bblank)
            sp_tr=[];
          
            T1=my_times{6,nn}(1);
            T2=my_times{6,nn}(2);
            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{6,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{6,oi}<(T2/1000+PRE_TIME));
            end
            
            BarsTuning_BB.Fast.Me{nn}=mean(sp_tr)/(T2-T1)*1000;
            BarsTuning_BB.Fast.St{nn}=std(sp_tr)/(T2-T1)*1000;
            BarsTuning_BB.Fast.Se{nn}=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
                bbb_f(find(motion_values==I)+1)=BarsTuning_BB.Fast.Me{nn};
                sss_f(find(motion_values==I)+1)=BarsTuning_BB.Fast.Se{nn};
                std_f(find(motion_values==I)+1)=BarsTuning_BB.Fast.St{nn};

%                 h(nn)=figure(nn)
                
           %% white blanks (bitcode 3 for short wblank)
            sp_tr=[];
         
            T1=my_times{3,nn}(1);
            T2=my_times{3,nn}(2);
            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{3,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{3,oi}<(T2/1000+PRE_TIME));
            end
            
            BarsTuning_WB.Fast.Me{nn}=mean(sp_tr)/(T2-T1)*1000;
            BarsTuning_WB.Fast.St{nn}=std(sp_tr)/(T2-T1)*1000;
            BarsTuning_WB.Fast.Se{nn}=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
                bbb_f(find(motion_values==I)+2)=BarsTuning_WB.Fast.Me{nn};
                sss_f(find(motion_values==I)+2)=BarsTuning_WB.Fast.Se{nn};
                std_f(find(motion_values==I)+2)=BarsTuning_WB.Fast.St{nn};

                
                
                
                
                
           bbl_f = [bbb_f(end-1), bbb_f(end-1), bbb_f(end-1), bbb_f(end-1), bbb_f(end-1), bbb_f(end-1), bbb_f(end-1), bbb_f(end-1)];
           wbl_f = [bbb_f(end), bbb_f(end), bbb_f(end), bbb_f(end), bbb_f(end), bbb_f(end), bbb_f(end), bbb_f(end)]; 
           
              ordered_values=sortGivenOrder(motion_values);
              ordered_bbb_f1=sortGivenOrder(bbb_f(1:numel(motion_values)));
              ordered_sss_f1=sortGivenOrder(sss_f(1:numel(motion_values)));
              ordered_bbb_f{contami}=sortGivenOrder(bbb_f(1:numel(motion_values)));
              ordered_sss_f{contami}=sortGivenOrder(sss_f(1:numel(motion_values)));
              ordered_std_f{contami}=sortGivenOrder(std_f(1:numel(motion_values)));
              rad_ordered_values = ordered_values .* pi/180;
              
              
            BarsTuning.Fast.Me{nn}=ordered_bbb_f{contami};
            BarsTuning.Fast.Se{nn}=ordered_sss_f{contami};
            BarsTuning.Fast.St{nn}=ordered_std_f{contami};
    
              
 %% Slow Motion Tuning

        [a z]=ind2sub(size(Fede_STIM_NU), find(Fede_STIM_NU(1:342,2)==ob & Fede_STIM_NU(1:342,11)==1.984000000000000));       
        selected_bits = a';       
        motion_values = Fede_STIM_NU(selected_bits,12);
 
        for z = 1:numel(motion_values)  
            
        I=motion_values(z);
        stim = selected_bits(z);
        sp_tr=[];
     
        T1=my_times{stim,nn}(1);
        T2=my_times{stim,nn}(2);

            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{stim,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{stim,oi}<(T2/1000+PRE_TIME));
            end
            sp_tr
            BarsTuning.Slow.Me{nn}(z)=mean(sp_tr)/(T2-T1)*1000;
            BarsTuning.Slow.St{nn}(z)=std(sp_tr)/(T2-T1)*1000;
            BarsTuning.Slow.Se{nn}(z)=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;

                bbb_s(find(motion_values==I))=BarsTuning.Slow.Me{nn}(z);
                sss_s(find(motion_values==I))=BarsTuning.Slow.Se{nn}(z);
                std_s(find(motion_values==I))=BarsTuning.Slow.St{nn}(z);
                %sp_tr
        end
        

                
            %% blanks (bitcode 5 for long bblank)
            sp_tr=[];
       
            T1=my_times{5,nn}(1);
            T2=my_times{5,nn}(2);
            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{5,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{5,oi}<(T2/1000+PRE_TIME));
            end
            
            BarsTuning_BB.Slow.Me{nn}=mean(sp_tr)/(T2-T1)*1000;
            BarsTuning_BB.Slow.St{nn}=std(sp_tr)/(T2-T1)*1000;
            BarsTuning_BB.Slow.Se{nn}=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
                bbb_s(find(motion_values==I)+1)=BarsTuning_BB.Slow.Me{nn};
                sss_s(find(motion_values==I)+1)=BarsTuning_BB.Slow.Se{nn};
                std_s(find(motion_values==I)+1)=BarsTuning_BB.Slow.St{nn};

%                 h(nn)=figure(nn)
                
                
            %% white blanks (bitcode 2 for long wblank)
            sp_tr=[];
     
            T1=my_times{2,nn}(1);
            T2=my_times{2,nn}(2);
            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{2,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{2,oi}<(T2/1000+PRE_TIME));
            end
            
            BarsTuning_WB.Slow.Me{nn}=mean(sp_tr)/(T2-T1)*1000;
            BarsTuning_WB.Slow.St{nn}=std(sp_tr)/(T2-T1)*1000;
            BarsTuning_WB.Slow.Se{nn}=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
                bbb_s(find(motion_values==I)+2)=BarsTuning_WB.Slow.Me{nn};
                sss_s(find(motion_values==I)+2)=BarsTuning_WB.Slow.Se{nn};
                std_s(find(motion_values==I)+2)=BarsTuning_WB.Slow.St{nn};

%                 h(nn)=figure(nn)    
%                 title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);
               
              
           bbl_s = [bbb_s(end-1), bbb_s(end-1), bbb_s(end-1), bbb_s(end-1), bbb_s(end-1), bbb_s(end-1), bbb_s(end-1), bbb_s(end-1)];
           wbl_s = [bbb_s(end), bbb_s(end), bbb_s(end), bbb_s(end), bbb_s(end), bbb_s(end), bbb_s(end), bbb_s(end)];    
           
           
%               ordered_values=sortGivenOrder(motion_values);
              ordered_bbb_s1=sortGivenOrder(bbb_s(1:numel(motion_values)));
              ordered_sss_s1=sortGivenOrder(sss_s(1:numel(motion_values)));
              ordered_bbb_s{contami}=sortGivenOrder(bbb_s(1:numel(motion_values)));
              ordered_sss_s{contami}=sortGivenOrder(sss_s(1:numel(motion_values)));
              ordered_std_s{contami}=sortGivenOrder(std_s(1:numel(motion_values)));
                            
                             
            BarsTuning.Slow.Me{nn}=ordered_bbb_s{contami};
            BarsTuning.Slow.Se{nn}=ordered_sss_s{contami};
            BarsTuning.Slow.St{nn}=ordered_std_s{contami};
              
              
end
              
              
              
       %% plot    
sb5 = subplot(6,6,16)
set(gca,'Position',[.05,.36,.15,.15]);        
            
for i=1:numel(object2);
            conta3 = conta3+1;    

%             title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);
            hold on;
            her_f{i}=errorbar(ordered_values,ordered_bbb_f{i},ordered_sss_f{i},'-O','color',COLORSET(conta3,:), 'linewidth', 1.5);
            xlabel(['Fast Motion Tuning'])
            xlim([min(ordered_values)-3 max(ordered_values)+3])
%             ylim([0 max(ordered_bbb_f{i})+3])
            set(gca, 'XTick', [ordered_values])           
            hold on;
            
            Y=[];
            for iu=1:numel(ordered_values)
                Y=[Y;bbb_f(end-1)-sss_f(end-1)/2 sss_f(end-1)/2 sss_f(end-1)/2];
            end          
            h_f = area(ordered_values,Y,-5); % Set BaseValue via argument
            grey=[0.4, 0.4, 0.4];
            set(h_f(1),'FaceColor',grey)
            set(h_f(2),'FaceColor',grey)
            set(h_f(3),'FaceColor',grey)            
            set(h_f,'LineStyle',':','LineWidth',0.1) % Set all to same value.
            set(h_f,'basevalue',bbb_f(end-1)-sss_f(end-1)/2)
            hold on
            alpha(.5)
            line([ordered_values(1) ordered_values(end)],[bbb_f(end-1) bbb_f(end-1)],'color',grey,'linewidth',2);
            hold on;
            
            Y=[];
%             ordered_values=sortGivenOrder(motion_values);
            for iu=1:numel(ordered_values)
                Y=[Y;bbb_f(end)-sss_f(end)/2 sss_f(end)/2 sss_f(end)/2];
            end
            h_f = area(ordered_values,Y,-5);  
            grey2=[0.8, 0.8, 0.8];
            set(h_f(1),'FaceColor',grey2)
            set(h_f(2),'FaceColor',grey2)
            set(h_f(3),'FaceColor',grey2)            
            set(h_f,'LineStyle',':','LineWidth',0.1) % Set all to same value.
            set(h_f,'basevalue',bbb_f(end)-sss_f(end)/2)
            hold on
            alpha(.5)
            line([ordered_values(1) ordered_values(end)],[bbb_f(end) bbb_f(end)],'color',grey2,'linewidth',2);
            
end

conta3 = 0;
sb6 = subplot(5,6,22)
set(gca,'Position',[.05,.15,.15,.15]);
            
for i=1:numel(object2);
            conta3 = conta3+1;              
            
            her_s{i}=errorbar(ordered_values,ordered_bbb_s{i},ordered_sss_s{i},'-O','color',COLORSET(conta3,:), 'linewidth', 1.5);
            xlabel(['Slow Motion Tuning'])
            xlim([min(ordered_values)-3 max(ordered_values)+3])
%             ylim([0 max(ordered_bbb_s{i})+3])
            set(gca, 'XTick', [ordered_values])
            hold on;
              Y=[];
            for iu=1:numel(ordered_values)
                Y=[Y;bbb_s(end-1)-sss_s(end-1)/2 sss_s(end-1)/2 sss_s(end-1)/2];
            end          
            h_s = area(ordered_values,Y,-5); % Set BaseValue via argument
            grey=[0.4, 0.4, 0.4];
            set(h_s(1),'FaceColor',grey)
            set(h_s(2),'FaceColor',grey)
            set(h_s(3),'FaceColor',grey)            
            set(h_s,'LineStyle',':','LineWidth',0.1) % Set all to same value.
            set(h_s,'basevalue',bbb_s(end-1)-sss_s(end-1)/2)
            hold on
            alpha(.5)
            line([ordered_values(1) ordered_values(end)],[bbb_s(end-1) bbb_s(end-1)],'color',grey,'linewidth',2);
            hold on;
            
            Y=[];
%             ordered_values=sortGivenOrder(motion_values);
            for iu=1:numel(ordered_values)
                Y=[Y;bbb_s(end)-sss_s(end)/2 sss_s(end)/2 sss_s(end)/2];
            end
            h_s = area(ordered_values,Y,-5);  
            set(h_s(1),'FaceColor',grey2)
            set(h_s(2),'FaceColor',grey2)
            set(h_s(3),'FaceColor',grey2)            
            set(h_s,'LineStyle',':','LineWidth',0.1) % Set all to same value.
            set(h_s,'basevalue',bbb_s(end)-sss_s(end)/2)
            hold on
            alpha(.5)
            line([ordered_values(1) ordered_values(end)],[bbb_s(end) bbb_s(end)],'color',grey2,'linewidth',2);
            
end
            
conta3 = 0;
sb7 = subplot(5,6,22)
set(gca,'Position',[.2,.36,.15,.15]);
            
for i=1:numel(object2);
            conta3 = conta3+1;   
                       
              conta = conta+1;
              grey=[0.4, 0.4, 0.4];
              grey2=[0.65, 0.65, 0.65];
              all_bbs = [ordered_bbb_f{1,:}, bbl_f, wbl_f];
              my_ref = max(all_bbs);
              my_ref_vect = [my_ref, my_ref, my_ref, my_ref, my_ref, my_ref, my_ref, my_ref];
              ra = polar(rad_ordered_values, my_ref_vect);
              set(ra, 'color', 'w', 'linewidth', .1)   
              hold on;
              ha_f{i} = polar(rad_ordered_values, ordered_bbb_f{i});
              set(ha_f{i}, 'color', COLORSET(conta,:), 'linewidth', 2)              
              hold on;
              wa = polar(rad_ordered_values, wbl_f);
              set(wa, 'color', grey2, 'linewidth', 2)
              hold on;
              
              ja = polar(rad_ordered_values, bbl_f);
              set(ja, 'color', grey, 'linewidth', 2)
%               hold on;
              view(90, -90);
              
%               xlabel(['Fast Motion Tuning']); %, 'Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);

              clear all_bbs my_ref my_ref_vect ra ja wa
end

conta3 = 0;
sb8 = subplot(5,6,22)
set(gca,'Position',[.2,.15,.15,.15]);
            
for i=1:numel(object2);
            conta3 = conta3+1;   

              conta2 = conta2+1;
              grey=[0.4, 0.4, 0.4];
              grey2=[0.65, 0.65, 0.65];
              all_bbs = [ordered_bbb_s{1,:}, bbl_s, wbl_s];
              my_ref = max(all_bbs);
              my_ref_vect = [my_ref, my_ref, my_ref, my_ref, my_ref, my_ref, my_ref, my_ref];
              ra = polar(rad_ordered_values, my_ref_vect);
              set(ra, 'color', 'w', 'linewidth', .1)   
              hold on;
              ha_s{i} = polar(rad_ordered_values, ordered_bbb_s{i});
              set(ha_s{i}, 'color', COLORSET(conta2,:), 'linewidth', 2)              
              hold on;
              wa = polar(rad_ordered_values, wbl_s);
              set(wa, 'color', grey2, 'linewidth', 2)
              hold on;
              
              ja = polar(rad_ordered_values, bbl_s);
              set(ja, 'color', grey, 'linewidth', 2)
%               hold on;
              view(90, -90);
              
%               xlabel(['Slow Motion Tuning']); %, 'Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);

              clear all_bbs my_ref my_ref_vect ra ja wa
              
end
            rect = [.35,.32,.02,.02];
            l = legend([ha_s{i}],'Bar');
            set (l, 'Position', rect);
%             legend([ha_s{i}],{'Bar'})
            hold on;            
            
clear her_f her_s ha_f ha_s clear ordered_bbb_f ordered_bbb_s ordered_sss_f ordered_sss_s bbb_f sss_f bbb_s sss_s selected_bits Y ordered_values motion_values              
            
%             
%% Gratings 
%% Fast Motion Tuning
    contami = 0;
    countolo=0;
    conta = 0;
    conta2 = 0;
    conta3 = 0;

for ob = object3

        T1=[];
        T2=[];
        
        COLORSET=varycolor(numel(object3));
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
            
%             ww = cd;
%             stringS=strcat('TUNING/', num2str(nn), '/', char(stimidentity));
%             mkdir(stringS);

        [a z]=ind2sub(size(Fede_STIM_NU), find(Fede_STIM_NU(1:342,2)==ob & Fede_STIM_NU(1:342,11)==0.763100000000000));       
        selected_bits = a';       
        motion_values = Fede_STIM_NU(selected_bits,12);
%         motion_set=sort(unique(Fede_STIM_NU(selected_bits,13)));   %%% 13th column = direction of motion
 
%         for my_bits = selected_bits;
%             [T1, T2]=My_Window_NEW;
%             T1_All = [T1_All, T1];
%             T2_All = [T2_All, T2];
%         end
        
        
        
        for z = 1:numel(motion_values)  
            
        I=motion_values(z);
        stim = selected_bits(z);
        sp_tr=[];
     
        T1=my_times{stim,nn}(1);
        T2=my_times{stim,nn}(2);

            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{stim,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{stim,oi}<(T2/1000+PRE_TIME));
            end
            sp_tr
            GratingsTuning.Fast(contami).Me{nn}(z)=mean(sp_tr)/(T2-T1)*1000;
            GratingsTuning.Fast(contami).St{nn}(z)=std(sp_tr)/(T2-T1)*1000;
            GratingsTuning.Fast(contami).Se{nn}(z)=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;

                bbb_f(find(motion_values==I))=GratingsTuning.Fast(contami).Me{nn}(z);
                sss_f(find(motion_values==I))=GratingsTuning.Fast(contami).Se{nn}(z);
                std_f(find(motion_values==I))=GratingsTuning.Fast(contami).St{nn}(z);
                %sp_tr
        end
        

                
            %% black blanks (bitcode 6 for short bblank)
            sp_tr=[];
            T1=my_times{6,nn}(1);
            T2=my_times{6,nn}(2);
            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{6,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{6,oi}<(T2/1000+PRE_TIME));
            end
            
            GratingsTuning_BB.Fast.Me{nn}=mean(sp_tr)/(T2-T1)*1000;
            GratingsTuning_BB.Fast.St{nn}=std(sp_tr)/(T2-T1)*1000;
            GratingsTuning_BB.Fast.Se{nn}=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
                bbb_f(find(motion_values==I)+1)=GratingsTuning_BB.Fast.Me{nn};
                sss_f(find(motion_values==I)+1)=GratingsTuning_BB.Fast.Se{nn};
                std_f(find(motion_values==I)+1)=GratingsTuning_BB.Fast.St{nn};

%                 h(nn)=figure(nn)
                
           %% white blanks (bitcode 3 for short wblank)
            sp_tr=[];
            T1=my_times{3,nn}(1);
            T2=my_times{3,nn}(2);
            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{3,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{3,oi}<(T2/1000+PRE_TIME));
            end
            
            GratingsTuning_WB.Fast.Me{nn}=mean(sp_tr)/(T2-T1)*1000;
            GratingsTuning_WB.Fast.St{nn}=std(sp_tr)/(T2-T1)*1000;
            GratingsTuning_WB.Fast.Se{nn}=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
                bbb_f(find(motion_values==I)+2)=GratingsTuning_WB.Fast.Me{nn};
                sss_f(find(motion_values==I)+2)=GratingsTuning_WB.Fast.Se{nn};
                std_f(find(motion_values==I)+2)=GratingsTuning_WB.Fast.St{nn};

                
                
                
                
                
           bbl_f = [bbb_f(end-1), bbb_f(end-1), bbb_f(end-1), bbb_f(end-1), bbb_f(end-1), bbb_f(end-1), bbb_f(end-1), bbb_f(end-1)];
           wbl_f = [bbb_f(end), bbb_f(end), bbb_f(end), bbb_f(end), bbb_f(end), bbb_f(end), bbb_f(end), bbb_f(end)]; 
           
              ordered_values=sortGivenOrder(motion_values);
              ordered_bbb_f1=sortGivenOrder(bbb_f(1:numel(motion_values)));
              ordered_sss_f1=sortGivenOrder(sss_f(1:numel(motion_values)));
              ordered_bbb_f{contami}=sortGivenOrder(bbb_f(1:numel(motion_values)));
              ordered_sss_f{contami}=sortGivenOrder(sss_f(1:numel(motion_values)));
              ordered_std_f{contami}=sortGivenOrder(std_f(1:numel(motion_values)));
              rad_ordered_values = ordered_values .* pi/180;
              
    
            GratingsTuning.Fast(contami).Me{nn}=ordered_bbb_f{contami};
            GratingsTuning.Fast(contami).Se{nn}=ordered_sss_f{contami};
            GratingsTuning.Fast(contami).St{nn}=ordered_std_f{contami};
              
 %% Slow Motion Tuning

        [a z]=ind2sub(size(Fede_STIM_NU), find(Fede_STIM_NU(1:342,2)==ob & Fede_STIM_NU(1:342,11)==1.984000000000000));       
        selected_bits = a';       
        motion_values = Fede_STIM_NU(selected_bits,12);
 
        for z = 1:numel(motion_values)  
            
        I=motion_values(z);
        stim = selected_bits(z);
        sp_tr=[];
   
        T1=my_times{stim,nn}(1);
        T2=my_times{stim,nn}(2);

            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{stim,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{stim,oi}<(T2/1000+PRE_TIME));
            end
            sp_tr
            GratingsTuning.Slow(contami).Me{nn}(z)=mean(sp_tr)/(T2-T1)*1000;
            GratingsTuning.Slow(contami).St{nn}(z)=std(sp_tr)/(T2-T1)*1000;
            GratingsTuning.Slow(contami).Se{nn}(z)=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;

                bbb_s(find(motion_values==I))=GratingsTuning.Slow(contami).Me{nn}(z);
                sss_s(find(motion_values==I))=GratingsTuning.Slow(contami).Se{nn}(z);
                std_s(find(motion_values==I))=GratingsTuning.Slow(contami).St{nn}(z);
                %sp_tr
        end
        

                
            %% blanks (bitcode 5 for long bblank)
            sp_tr=[];
            T1=my_times{5,nn}(1);
            T2=my_times{5,nn}(2);
            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{5,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{5,oi}<(T2/1000+PRE_TIME));
            end
            
            GratingsTuning_BB.Slow.Me{nn}=mean(sp_tr)/(T2-T1)*1000;
            GratingsTuning_BB.Slow.St{nn}=std(sp_tr)/(T2-T1)*1000;
            GratingsTuning_BB.Slow.Se{nn}=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
                bbb_s(find(motion_values==I)+1)=GratingsTuning_BB.Slow.Me{nn};
                sss_s(find(motion_values==I)+1)=GratingsTuning_BB.Slow.Se{nn};
                std_s(find(motion_values==I)+1)=GratingsTuning_BB.Slow.St{nn};

%                 h(nn)=figure(nn)
                
                
            %% white blanks (bitcode 2 for long wblank)
            sp_tr=[];
            T1=my_times{2,nn}(1);
            T2=my_times{2,nn}(2);
            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{2,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{2,oi}<(T2/1000+PRE_TIME));
            end
            
            GratingsTuning_WB.Slow.Me{nn}=mean(sp_tr)/(T2-T1)*1000;
            GratingsTuning_WB.Slow.St{nn}=std(sp_tr)/(T2-T1)*1000;
            GratingsTuning_WB.Slow.Se{nn}=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
                bbb_s(find(motion_values==I)+2)=GratingsTuning_WB.Slow.Me{nn};
                sss_s(find(motion_values==I)+2)=GratingsTuning_WB.Slow.Se{nn};
                std_s(find(motion_values==I)+2)=GratingsTuning_WB.Slow.St{nn};

%                 h(nn)=figure(nn)    
%                 title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);
               
              
           bbl_s = [bbb_s(end-1), bbb_s(end-1), bbb_s(end-1), bbb_s(end-1), bbb_s(end-1), bbb_s(end-1), bbb_s(end-1), bbb_s(end-1)];
           wbl_s = [bbb_s(end), bbb_s(end), bbb_s(end), bbb_s(end), bbb_s(end), bbb_s(end), bbb_s(end), bbb_s(end)];    
           
           
%               ordered_values=sortGivenOrder(motion_values);
              ordered_bbb_s1=sortGivenOrder(bbb_s(1:numel(motion_values)));
              ordered_sss_s1=sortGivenOrder(sss_s(1:numel(motion_values)));
              ordered_bbb_s{contami}=sortGivenOrder(bbb_s(1:numel(motion_values)));
              ordered_sss_s{contami}=sortGivenOrder(sss_s(1:numel(motion_values)));
              ordered_std_s{contami}=sortGivenOrder(std_s(1:numel(motion_values)));
                            
                             
            GratingsTuning.Slow(contami).Me{nn}=ordered_bbb_s{contami};
            GratingsTuning.Slow(contami).Se{nn}=ordered_sss_s{contami};
            GratingsTuning.Slow(contami).St{nn}=ordered_std_s{contami};
              
              
end
              
              
              
       %% plot    
%             figure(nn);

sb9 = subplot(6,6,22) 
set(gca,'Position',[.42,.8,.15,.15]);
            
for i=1:numel(object3);
            conta3 = conta3+1;    
            
%             title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);
            hold on;
            her_f{i}=errorbar(ordered_values,ordered_bbb_f{i},ordered_sss_f{i},'-O','color',COLORSET(conta3,:), 'linewidth', 1.5);
            xlabel(['Fast Motion Tuning'])
            xlim([min(ordered_values)-3 max(ordered_values)+3])
%             ylim([0 max(ordered_bbb_f{i})+3])
            set(gca, 'XTick', [ordered_values])           
            hold on;
            
            Y=[];
            for iu=1:numel(ordered_values)
                Y=[Y;bbb_f(end-1)-sss_f(end-1)/2 sss_f(end-1)/2 sss_f(end-1)/2];
            end          
            h_f = area(ordered_values,Y,-5); % Set BaseValue via argument
            grey=[0.4, 0.4, 0.4];
            set(h_f(1),'FaceColor',grey)
            set(h_f(2),'FaceColor',grey)
            set(h_f(3),'FaceColor',grey)            
            set(h_f,'LineStyle',':','LineWidth',0.1) % Set all to same value.
            set(h_f,'basevalue',bbb_f(end-1)-sss_f(end-1)/2)
            hold on
            alpha(.5)
            line([ordered_values(1) ordered_values(end)],[bbb_f(end-1) bbb_f(end-1)],'color',grey,'linewidth',2);
            hold on;
            
            Y=[];
%             ordered_values=sortGivenOrder(motion_values);
            for iu=1:numel(ordered_values)
                Y=[Y;bbb_f(end)-sss_f(end)/2 sss_f(end)/2 sss_f(end)/2];
            end
            h_f = area(ordered_values,Y,-5);  
            grey2=[0.8, 0.8, 0.8];
            set(h_f(1),'FaceColor',grey2)
            set(h_f(2),'FaceColor',grey2)
            set(h_f(3),'FaceColor',grey2)            
            set(h_f,'LineStyle',':','LineWidth',0.1) % Set all to same value.
            set(h_f,'basevalue',bbb_f(end)-sss_f(end)/2)
            hold on
            alpha(.5)
            line([ordered_values(1) ordered_values(end)],[bbb_f(end) bbb_f(end)],'color',grey2,'linewidth',2);
            
end

sb10 = subplot(6,6,22) 
set(gca,'Position',[.42,.58,.15,.15]);
conta3 = 0;

for i=1:numel(object3);
            conta3 = conta3+1;                
            her_s{i}=errorbar(ordered_values,ordered_bbb_s{i},ordered_sss_s{i},'-O','color',COLORSET(conta3,:), 'linewidth', 1.5);
            xlabel(['Slow Motion Tuning'])
            xlim([min(ordered_values)-3 max(ordered_values)+3])
%             ylim([0 max(ordered_bbb_s{i})+3])
            set(gca, 'XTick', [ordered_values])
            hold on;
              Y=[];
            for iu=1:numel(ordered_values)
                Y=[Y;bbb_s(end-1)-sss_s(end-1)/2 sss_s(end-1)/2 sss_s(end-1)/2];
            end          
            h_s = area(ordered_values,Y,-5); % Set BaseValue via argument
            grey=[0.4, 0.4, 0.4];
            set(h_s(1),'FaceColor',grey)
            set(h_s(2),'FaceColor',grey)
            set(h_s(3),'FaceColor',grey)            
            set(h_s,'LineStyle',':','LineWidth',0.1) % Set all to same value.
            set(h_s,'basevalue',bbb_s(end-1)-sss_s(end-1)/2)
            hold on
            alpha(.5)
            line([ordered_values(1) ordered_values(end)],[bbb_s(end-1) bbb_s(end-1)],'color',grey,'linewidth',2);
            hold on;
            
            Y=[];
%             ordered_values=sortGivenOrder(motion_values);
            for iu=1:numel(ordered_values)
                Y=[Y;bbb_s(end)-sss_s(end)/2 sss_s(end)/2 sss_s(end)/2];
            end
            h_s = area(ordered_values,Y,-5);  
            set(h_s(1),'FaceColor',grey2)
            set(h_s(2),'FaceColor',grey2)
            set(h_s(3),'FaceColor',grey2)            
            set(h_s,'LineStyle',':','LineWidth',0.1) % Set all to same value.
            set(h_s,'basevalue',bbb_s(end)-sss_s(end)/2)
            hold on
            alpha(.5)
            line([ordered_values(1) ordered_values(end)],[bbb_s(end) bbb_s(end)],'color',grey2,'linewidth',2);
            
end

sb11 = subplot(6,6,22) 
set(gca,'Position',[.57,.8,.15,.15]);
conta = 0;

for i=1:numel(object3);           
              conta = conta+1;
              grey=[0.4, 0.4, 0.4];
              grey2=[0.65, 0.65, 0.65];
              all_bbs = [ordered_bbb_f{1,:}, bbl_f, wbl_f];
              my_ref = max(all_bbs);
              my_ref_vect = [my_ref, my_ref, my_ref, my_ref, my_ref, my_ref, my_ref, my_ref];
              ra = polar(rad_ordered_values, my_ref_vect);
              set(ra, 'color', 'w', 'linewidth', .1)   
              hold on;
              ha_f{i} = polar(rad_ordered_values, ordered_bbb_f{i});
              set(ha_f{i}, 'color', COLORSET(conta,:), 'linewidth', 2)              
              hold on;
              wa = polar(rad_ordered_values, wbl_f);
              set(wa, 'color', grey2, 'linewidth', 2)
              hold on;
              
              ja = polar(rad_ordered_values, bbl_f);
              set(ja, 'color', grey, 'linewidth', 2)
%               hold on;
              view(90, -90);
              
%               xlabel(['Fast Motion Tuning']); %, 'Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);

              clear all_bbs my_ref my_ref_vect ra ja wa
           
end

sb12 = subplot(6,6,22) 
set(gca,'Position',[.57,.58,.15,.15]);
conta = 0;
conta2=0;

for i=1:numel(object3);           
              conta = conta+1;

              conta2 = conta2+1;
              grey=[0.4, 0.4, 0.4];
              grey2=[0.65, 0.65, 0.65];
              all_bbs = [ordered_bbb_s{1,:}, bbl_s, wbl_s];
              my_ref = max(all_bbs);
              my_ref_vect = [my_ref, my_ref, my_ref, my_ref, my_ref, my_ref, my_ref, my_ref];
              ra = polar(rad_ordered_values, my_ref_vect);
              set(ra, 'color', 'w', 'linewidth', .1)   
              hold on;
              ha_s{i} = polar(rad_ordered_values, ordered_bbb_s{i});
              set(ha_s{i}, 'color', COLORSET(conta2,:), 'linewidth', 2)              
              hold on;
              wa = polar(rad_ordered_values, wbl_s);
              set(wa, 'color', grey2, 'linewidth', 2)
              hold on;
              
              ja = polar(rad_ordered_values, bbl_s);
              set(ja, 'color', grey, 'linewidth', 2)
%               hold on;
              view(90, -90);
              
%               xlabel(['Slow Motion Tuning']); %, 'Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);

              clear all_bbs my_ref my_ref_vect ra ja wa
              
end
            rect = [.72,.75,.02,.02];    
            l=legend([ha_s{1},ha_s{2},ha_s{3},ha_s{4}],{'SF 0.03','SF 0.05','SF 0.1','SF 0.4'})
            set (l, 'Position', rect);
%             legend([ha_s{1},ha_s{2},ha_s{3},ha_s{4}],{'SF 0.03','SF 0.05','SF 0.1','SF 0.4'})
            hold on;
            
clear her_f her_s ha_f ha_s clear ordered_bbb_f ordered_bbb_s ordered_sss_f ordered_sss_s bbb_f sss_f bbb_s sss_s selected_bits Y ordered_values motion_values              
            
            
%             
%% Dots
%% Fast Motion Tuning
    contami = 0;
    countolo=0;
    conta = 0;
    conta2 = 0;
    conta3 = 0;

for ob = object4

        T1=[];
        T2=[];
        
        COLORSET=varycolor(numel(object4));
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
            
%             ww = cd;
%             stringS=strcat('TUNING/', num2str(nn), '/', char(stimidentity));
%             mkdir(stringS);

        [a z]=ind2sub(size(Fede_STIM_NU), find(Fede_STIM_NU(1:342,2)==ob & Fede_STIM_NU(1:342,11)==0.763100000000000));       
        selected_bits = a';       
        motion_values = Fede_STIM_NU(selected_bits,12);
%         motion_set=sort(unique(Fede_STIM_NU(selected_bits,13)));   %%% 13th column = direction of motion
 
%         for my_bits = selected_bits;
%             [T1, T2]=My_Window_NEW;
%             T1_All = [T1_All, T1];
%             T2_All = [T2_All, T2];
%         end
        
        
        
        for z = 1:numel(motion_values)  
            
        I=motion_values(z);
        stim = selected_bits(z);
        sp_tr=[];
    
        T1=my_times{stim,nn}(1);
        T2=my_times{stim,nn}(2);

            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{stim,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{stim,oi}<(T2/1000+PRE_TIME));
            end
            sp_tr
            DotsTuning.Fast(contami).Me{nn}(z)=mean(sp_tr)/(T2-T1)*1000;
            DotsTuning.Fast(contami).St{nn}(z)=std(sp_tr)/(T2-T1)*1000;
            DotsTuning.Fast(contami).Se{nn}(z)=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;

                bbb_f(find(motion_values==I))=DotsTuning.Fast(contami).Me{nn}(z);
                sss_f(find(motion_values==I))=DotsTuning.Fast(contami).Se{nn}(z);
                std_f(find(motion_values==I))=DotsTuning.Fast(contami).St{nn}(z);
                %sp_tr
        end
        

                
            %% black blanks (bitcode 6 for short bblank)
            sp_tr=[];
            T1=my_times{6,nn}(1);
            T2=my_times{6,nn}(2);
            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{6,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{6,oi}<(T2/1000+PRE_TIME));
            end
            
            DotsTuning_BB.Fast.Me{nn}=mean(sp_tr)/(T2-T1)*1000;
            DotsTuning_BB.Fast.St{nn}=std(sp_tr)/(T2-T1)*1000;
            DotsTuning_BB.Fast.Se{nn}=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
                bbb_f(find(motion_values==I)+1)=DotsTuning_BB.Fast.Me{nn};
                sss_f(find(motion_values==I)+1)=DotsTuning_BB.Fast.Se{nn};
                std_f(find(motion_values==I)+1)=DotsTuning_BB.Fast.St{nn};

%                 h(nn)=figure(nn)
                
           %% white blanks (bitcode 3 for short wblank)
            sp_tr=[];
            T1=my_times{3,nn}(1);
            T2=my_times{3,nn}(2);
            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{3,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{3,oi}<(T2/1000+PRE_TIME));
            end
            
            DotsTuning_WB.Fast.Me{nn}=mean(sp_tr)/(T2-T1)*1000;
            DotsTuning_WB.Fast.St{nn}=std(sp_tr)/(T2-T1)*1000;
            DotsTuning_WB.Fast.Se{nn}=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
                bbb_f(find(motion_values==I)+2)=DotsTuning_WB.Fast.Me{nn};
                sss_f(find(motion_values==I)+2)=DotsTuning_WB.Fast.Se{nn};
                std_f(find(motion_values==I)+2)=DotsTuning_WB.Fast.St{nn};
                
                
                
                
                
           bbl_f = [bbb_f(end-1), bbb_f(end-1), bbb_f(end-1), bbb_f(end-1), bbb_f(end-1), bbb_f(end-1), bbb_f(end-1), bbb_f(end-1)];
           wbl_f = [bbb_f(end), bbb_f(end), bbb_f(end), bbb_f(end), bbb_f(end), bbb_f(end), bbb_f(end), bbb_f(end)]; 
           
              ordered_values=sortGivenOrder(motion_values);
              ordered_bbb_f1=sortGivenOrder(bbb_f(1:numel(motion_values)));
              ordered_sss_f1=sortGivenOrder(sss_f(1:numel(motion_values)));
              ordered_bbb_f{contami}=sortGivenOrder(bbb_f(1:numel(motion_values)));
              ordered_sss_f{contami}=sortGivenOrder(sss_f(1:numel(motion_values)));
              ordered_std_f{contami}=sortGivenOrder(std_f(1:numel(motion_values)));
              rad_ordered_values = ordered_values .* pi/180;
              
              
            DotsTuning.Fast(contami).Me{nn}=ordered_bbb_f{contami};
            DotsTuning.Fast(contami).Se{nn}=ordered_sss_f{contami};
            DotsTuning.Fast(contami).St{nn}=ordered_std_f{contami};
    
              
 %% Slow Motion Tuning

        [a z]=ind2sub(size(Fede_STIM_NU), find(Fede_STIM_NU(1:342,2)==ob & Fede_STIM_NU(1:342,11)==1.984000000000000));       
        selected_bits = a';       
        motion_values = Fede_STIM_NU(selected_bits,12);
 
        for z = 1:numel(motion_values)  
            
        I=motion_values(z);
        stim = selected_bits(z);
        sp_tr=[];
    
        T1=my_times{stim,nn}(1);
        T2=my_times{stim,nn}(2);

            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{stim,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{stim,oi}<(T2/1000+PRE_TIME));
            end
            sp_tr
            DotsTuning.Slow(contami).Me{nn}(z)=mean(sp_tr)/(T2-T1)*1000;
            DotsTuning.Slow(contami).St{nn}(z)=std(sp_tr)/(T2-T1)*1000;
            DotsTuning.Slow(contami).Se{nn}(z)=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;

                bbb_s(find(motion_values==I))=DotsTuning.Slow(contami).Me{nn}(z);
                sss_s(find(motion_values==I))=DotsTuning.Slow(contami).Se{nn}(z);
                std_s(find(motion_values==I))=DotsTuning.Slow(contami).St{nn}(z);
                %sp_tr
        end
        

                
            %% blanks (bitcode 5 for long bblank)
            sp_tr=[];
            T1=my_times{5,nn}(1);
            T2=my_times{5,nn}(2);
            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{5,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{5,oi}<(T2/1000+PRE_TIME));
            end
            
            DotsTuning_BB.Slow.Me{nn}=mean(sp_tr)/(T2-T1)*1000;
            DotsTuning_BB.Slow.St{nn}=std(sp_tr)/(T2-T1)*1000;
            DotsTuning_BB.Slow.Se{nn}=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
                bbb_s(find(motion_values==I)+1)=DotsTuning_BB.Slow.Me{nn};
                sss_s(find(motion_values==I)+1)=DotsTuning_BB.Slow.Se{nn};
                std_s(find(motion_values==I)+1)=DotsTuning_BB.Slow.St{nn};

%                 h(nn)=figure(nn)
                
                
            %% white blanks (bitcode 2 for long wblank)
            sp_tr=[];
            T1=my_times{2,nn}(1);
            T2=my_times{2,nn}(2);
            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{2,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{2,oi}<(T2/1000+PRE_TIME));
            end
            
            DotsTuning_WB.Slow.Me{nn}=mean(sp_tr)/(T2-T1)*1000;
            DotsTuning_WB.Slow.St{nn}=std(sp_tr)/(T2-T1)*1000;
            DotsTuning_WB.Slow.Se{nn}=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
                bbb_s(find(motion_values==I)+2)=DotsTuning_WB.Slow.Me{nn};
                sss_s(find(motion_values==I)+2)=DotsTuning_WB.Slow.Se{nn};
                std_s(find(motion_values==I)+2)=DotsTuning_WB.Slow.St{nn};

%                 h(nn)=figure(nn)    
%                 title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);
               
              
           bbl_s = [bbb_s(end-1), bbb_s(end-1), bbb_s(end-1), bbb_s(end-1), bbb_s(end-1), bbb_s(end-1), bbb_s(end-1), bbb_s(end-1)];
           wbl_s = [bbb_s(end), bbb_s(end), bbb_s(end), bbb_s(end), bbb_s(end), bbb_s(end), bbb_s(end), bbb_s(end)];    
           
           
%               ordered_values=sortGivenOrder(motion_values);
              ordered_bbb_s1=sortGivenOrder(bbb_s(1:numel(motion_values)));
              ordered_sss_s1=sortGivenOrder(sss_s(1:numel(motion_values)));
              ordered_bbb_s{contami}=sortGivenOrder(bbb_s(1:numel(motion_values)));
              ordered_sss_s{contami}=sortGivenOrder(sss_s(1:numel(motion_values)));
              ordered_std_s{contami}=sortGivenOrder(std_s(1:numel(motion_values)));
              
            DotsTuning.Slow(contami).Me{nn}=ordered_bbb_s{contami};
            DotsTuning.Slow(contami).Se{nn}=ordered_sss_s{contami};
            DotsTuning.Slow(contami).St{nn}=ordered_std_s{contami};
                            
                             
              
              
end
              
              
              
       %% plot    
%             figure(nn);

sb13 = subplot(6,6,24) 
set(gca,'Position',[.42,.36,.15,.15]);
            
for i=1:numel(object4);
            conta3 = conta3+1;    


%             title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);
            hold on;
            her_f{i}=errorbar(ordered_values,ordered_bbb_f{i},ordered_sss_f{i},'-O','color',COLORSET(conta3,:), 'linewidth', 1.5);
            xlabel(['Fast Motion Tuning'])
            xlim([min(ordered_values)-3 max(ordered_values)+3])
%             ylim([0 max(ordered_bbb_f{i})+3])
            set(gca, 'XTick', [ordered_values])           
            hold on;
            
            Y=[];
            for iu=1:numel(ordered_values)
                Y=[Y;bbb_f(end-1)-sss_f(end-1)/2 sss_f(end-1)/2 sss_f(end-1)/2];
            end          
            h_f = area(ordered_values,Y,-5); % Set BaseValue via argument
            grey=[0.4, 0.4, 0.4];
            set(h_f(1),'FaceColor',grey)
            set(h_f(2),'FaceColor',grey)
            set(h_f(3),'FaceColor',grey)            
            set(h_f,'LineStyle',':','LineWidth',0.1) % Set all to same value.
            set(h_f,'basevalue',bbb_f(end-1)-sss_f(end-1)/2)
            hold on
            alpha(.5)
            line([ordered_values(1) ordered_values(end)],[bbb_f(end-1) bbb_f(end-1)],'color',grey,'linewidth',2);
            hold on;
            
            Y=[];
%             ordered_values=sortGivenOrder(motion_values);
            for iu=1:numel(ordered_values)
                Y=[Y;bbb_f(end)-sss_f(end)/2 sss_f(end)/2 sss_f(end)/2];
            end
            h_f = area(ordered_values,Y,-5);  
            grey2=[0.8, 0.8, 0.8];
            set(h_f(1),'FaceColor',grey2)
            set(h_f(2),'FaceColor',grey2)
            set(h_f(3),'FaceColor',grey2)            
            set(h_f,'LineStyle',':','LineWidth',0.1) % Set all to same value.
            set(h_f,'basevalue',bbb_f(end)-sss_f(end)/2)
            hold on
            alpha(.5)
            line([ordered_values(1) ordered_values(end)],[bbb_f(end) bbb_f(end)],'color',grey2,'linewidth',2);
            
end


sb14 = subplot(6,6,24) 
set(gca,'Position',[.42,.15,.15,.15]);
conta3 = 0;

for i=1:numel(object4);
            conta3 = conta3+1;    


            her_s{i}=errorbar(ordered_values,ordered_bbb_s{i},ordered_sss_s{i},'-O','color',COLORSET(conta3,:), 'linewidth', 1.5);
            xlabel(['Slow Motion Tuning'])
            xlim([min(ordered_values)-3 max(ordered_values)+3])
%             ylim([0 max(ordered_bbb_s{i})+3])
            set(gca, 'XTick', [ordered_values])
            hold on;
              Y=[];
            for iu=1:numel(ordered_values)
                Y=[Y;bbb_s(end-1)-sss_s(end-1)/2 sss_s(end-1)/2 sss_s(end-1)/2];
            end          
            h_s = area(ordered_values,Y,-5); % Set BaseValue via argument
            grey=[0.4, 0.4, 0.4];
            set(h_s(1),'FaceColor',grey)
            set(h_s(2),'FaceColor',grey)
            set(h_s(3),'FaceColor',grey)            
            set(h_s,'LineStyle',':','LineWidth',0.1) % Set all to same value.
            set(h_s,'basevalue',bbb_s(end-1)-sss_s(end-1)/2)
            hold on
            alpha(.5)
            line([ordered_values(1) ordered_values(end)],[bbb_s(end-1) bbb_s(end-1)],'color',grey,'linewidth',2);
            hold on;
            
            Y=[];
%             ordered_values=sortGivenOrder(motion_values);
            for iu=1:numel(ordered_values)
                Y=[Y;bbb_s(end)-sss_s(end)/2 sss_s(end)/2 sss_s(end)/2];
            end
            h_s = area(ordered_values,Y,-5);  
            set(h_s(1),'FaceColor',grey2)
            set(h_s(2),'FaceColor',grey2)
            set(h_s(3),'FaceColor',grey2)            
            set(h_s,'LineStyle',':','LineWidth',0.1) % Set all to same value.
            set(h_s,'basevalue',bbb_s(end)-sss_s(end)/2)
            hold on
            alpha(.5)
            line([ordered_values(1) ordered_values(end)],[bbb_s(end) bbb_s(end)],'color',grey2,'linewidth',2);
            
end

sb15 = subplot(6,6,30) 
set(gca,'Position',[.57,.36,.15,.15]);
conta=0;

for i=1:numel(object4);

              conta = conta+1;
              grey=[0.4, 0.4, 0.4];
              grey2=[0.65, 0.65, 0.65];
              all_bbs = [ordered_bbb_f{1,:}, bbl_f, wbl_f];
              my_ref = max(all_bbs);
              my_ref_vect = [my_ref, my_ref, my_ref, my_ref, my_ref, my_ref, my_ref, my_ref];
              ra = polar(rad_ordered_values, my_ref_vect);
              set(ra, 'color', 'w', 'linewidth', .1)   
              hold on;
              ha_f{i} = polar(rad_ordered_values, ordered_bbb_f{i});
              set(ha_f{i}, 'color', COLORSET(conta,:), 'linewidth', 2)              
              hold on;
              wa = polar(rad_ordered_values, wbl_f);
              set(wa, 'color', grey2, 'linewidth', 2)
              hold on;
              
              ja = polar(rad_ordered_values, bbl_f);
              set(ja, 'color', grey, 'linewidth', 2)
%               hold on;
              view(90, -90);
              
%               xlabel(['Fast Motion Tuning']); %, 'Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);

              clear all_bbs my_ref my_ref_vect ra ja wa
           
end

sb16 = subplot(6,6,30) 
set(gca,'Position',[.57,.15,.15,.15]);
conta2=0;

for i=1:numel(object4);
              conta2 = conta2+1;
              grey=[0.4, 0.4, 0.4];
              grey2=[0.65, 0.65, 0.65];
              all_bbs = [ordered_bbb_s{1,:}, bbl_s, wbl_s];
              my_ref = max(all_bbs);
              my_ref_vect = [my_ref, my_ref, my_ref, my_ref, my_ref, my_ref, my_ref, my_ref];
              ra = polar(rad_ordered_values, my_ref_vect);
              set(ra, 'color', 'w', 'linewidth', .1)   
              hold on;
              ha_s{i} = polar(rad_ordered_values, ordered_bbb_s{i});
              set(ha_s{i}, 'color', COLORSET(conta2,:), 'linewidth', 2)              
              hold on;
              wa = polar(rad_ordered_values, wbl_s);
              set(wa, 'color', grey2, 'linewidth', 2)
              hold on;
              
              ja = polar(rad_ordered_values, bbl_s);
              set(ja, 'color', grey, 'linewidth', 2)
%               hold on;
              view(90, -90);
              
%               xlabel(['Slow Motion Tuning']); %, 'Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);

              clear all_bbs my_ref my_ref_vect ra ja wa
              
end
            rect = [.72,.32,.02,.02];
            l = legend([ha_f{1},ha_f{2}],{'Pattern 1','Pattern 2'})
            set (l, 'Position', rect);
            
%             legend([ha_s{1},ha_s{2},ha_s{3},ha_s{4}],{'SF 0.03','SF 0.05','SF 0.1','SF 0.4'})
            hold on;
%             suptitle(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);

            
clear her_f her_s ha_f ha_s clear ordered_bbb_f ordered_bbb_s ordered_sss_f ordered_sss_s bbb_f sss_f bbb_s sss_s selected_bits Y ordered_values motion_values              
            
%% RF

            
            sb17 = subplot(6,6,30) 
            set(gca,'Position',[.8,.72,.18,.18]);
            xlim([0 11])
            ylim([0 6])
            set(gca, 'XTick', [0:1:11])
            set(gca, 'YTick', [0:1:6])

            my_folder_1 = ['/zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_', char(DayOfRecording), '/ANALYSED/BlockS-', num2str(Block), '/BL_1/RFs'];
            cd(my_folder_1)
            
            load fitresulto
            
            coeffa = fitresulto{nn}.a;
            coeffb = fitresulto{nn}.b;
            posx = fitresulto{nn}.x0;
            posy = fitresulto{nn}.y0;
            devx = fitresulto{nn}.sigmax;
            devy = fitresulto{nn}.sigmay;
            
            pre_rfsize = (devx+devy)/2;
            
            RF.rfsize{nn} = pre_rfsize*20;

            h1 = openfig([num2str(nn)],'reuse'); % open figure
            ax1 = gca(h1);
            fig1 = get(ax1,'children');
            bubu = gcf;
            
             %get handle to all the children in the figure

            copyobj(fig1,sb17);
            close (bubu)
            colorbar
            
            xlabel(['RF Size ', num2str(RF.rfsize{nn})])
            hold on;
            
            cd ..
            cd ..
            cd(my_folder)
            
            onsets =  cellfun(@(x) x(1),my_times(:,nn));
            
            
            
            sb18 = subplot(6,6,30);
            set(gca,'Position',[.8,.48,.18,.18]);
%             x = 1:1:342;
%             y = 0:50:2000;
            hist(onsets,25);
            xlabel(['Stimulus Onset'])
            
            
            set (gcf, 'NextPlot', 'add');
            axes;
            h = suptitle(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);
            set(gca, 'Visible', 'off');
            set(h, 'Visible', 'on', 'FontSize', 15); 
            
            
%             ww = cd;
%             cd(['TUNING']); 
%             export_fig (['MotionTuning_',num2str(nn), '.png'])
% %             close all
%             clear onsets
%             
%             cd ..


            
            
end           

            

save([ww,'/TUNING_NEW/MotionTuning_NEW.mat'], 'RF', 'ObjectsTuning', 'ObjectsTuning_BB', 'ObjectsTuning_WB', 'BarsTuning', 'BarsTuning_BB', 'BarsTuning_WB', 'GratingsTuning', 'GratingsTuning_BB', 'GratingsTuning_WB', 'DotsTuning', 'DotsTuning_BB', 'DotsTuning_WB','-v7.3');
