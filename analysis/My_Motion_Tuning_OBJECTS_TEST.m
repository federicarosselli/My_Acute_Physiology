
%%%%%% MOTION TUNING OBJECTS TEST
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
clc
close all

DayOfRecording = '20_8_2013';
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

cd WINDOWS
load Windows
cd ..

mkdir(['TUNING/'])

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

%% Objects


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
            TUN.Fast.Me{nn}(z)=mean(sp_tr)/(T2-T1)*1000;
            TUN.Fast.St{nn}(z)=std(sp_tr)/(T2-T1)*1000;
            TUN.Fast.Se{nn}(z)=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;

                bbb_f(find(motion_values==I))=TUN.Fast.Me{nn}(z);
                sss_f(find(motion_values==I))=TUN.Fast.Se{nn}(z);
                %sp_tr
        end
        

                
            %% black blanks (bitcode 6 for short bblank)
            sp_tr=[];
            T1=my_times{6,nn}(1);
            T2=my_times{6,nn}(2);
            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{6,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{6,oi}<(T2/1000+PRE_TIME));
            end
            
            TUN_BBl.Fast.Me{nn}=mean(sp_tr)/(T2-T1)*1000;
            TUN_BBl.Fast.St{nn}=std(sp_tr)/(T2-T1)*1000;
            TUN_BBl.Fast.Se{nn}=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
                bbb_f(find(motion_values==I)+1)=TUN_BBl.Fast.Me{nn};
                sss_f(find(motion_values==I)+1)=TUN_BBl.Fast.Se{nn};

%                 h(nn)=figure(nn)
                
           %% white blanks (bitcode 3 for short wblank)
            sp_tr=[];
            T1=my_times{3,nn}(1);
            T2=my_times{3,nn}(2);
            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{3,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{3,oi}<(T2/1000+PRE_TIME));
            end
            
            TUN_WBl.Fast.Me{nn}=mean(sp_tr)/(T2-T1)*1000;
            TUN_WBl.Fast.St{nn}=std(sp_tr)/(T2-T1)*1000;
            TUN_WBl.Fast.Se{nn}=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
                bbb_f(find(motion_values==I)+2)=TUN_WBl.Fast.Me{nn};
                sss_f(find(motion_values==I)+2)=TUN_WBl.Fast.Se{nn};

                
                
                
                
                
           bbl_f = [bbb_f(end-1), bbb_f(end-1), bbb_f(end-1), bbb_f(end-1), bbb_f(end-1), bbb_f(end-1), bbb_f(end-1), bbb_f(end-1)];
           wbl_f = [bbb_f(end), bbb_f(end), bbb_f(end), bbb_f(end), bbb_f(end), bbb_f(end), bbb_f(end), bbb_f(end)]; 
           
              ordered_values=sortGivenOrder(motion_values);
              ordered_bbb_f1=sortGivenOrder(bbb_f(1:numel(motion_values)));
              ordered_sss_f1=sortGivenOrder(sss_f(1:numel(motion_values)));
              ordered_bbb_f{ob}=sortGivenOrder(bbb_f(1:numel(motion_values)));
              ordered_sss_f{ob}=sortGivenOrder(sss_f(1:numel(motion_values)));
              rad_ordered_values = ordered_values .* pi/180;
              
    
              
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
            TUN.Slow.Me{nn}(z)=mean(sp_tr)/(T2-T1)*1000;
            TUN.Slow.St{nn}(z)=std(sp_tr)/(T2-T1)*1000;
            TUN.Slow.Se{nn}(z)=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;

                bbb_s(find(motion_values==I))=TUN.Slow.Me{nn}(z);
                sss_s(find(motion_values==I))=TUN.Slow.Se{nn}(z);
                %sp_tr
        end
        

                
            %% blanks (bitcode 5 for long bblank)
            sp_tr=[];
            T1=my_times{5,nn}(1);
            T2=my_times{5,nn}(2);
            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{5,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{5,oi}<(T2/1000+PRE_TIME));
            end
            
            TUN_Bl.Slow.Me{nn}=mean(sp_tr)/(T2-T1)*1000;
            TUN_Bl.Slow.St{nn}=std(sp_tr)/(T2-T1)*1000;
            TUN_Bl.Slow.Se{nn}=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
                bbb_s(find(motion_values==I)+1)=TUN_Bl.Slow.Me{nn};
                sss_s(find(motion_values==I)+1)=TUN_Bl.Slow.Se{nn};

%                 h(nn)=figure(nn)
                
                
            %% white blanks (bitcode 2 for long wblank)
            sp_tr=[];
            T1=my_times{2,nn}(1);
            T2=my_times{2,nn}(2);
            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{2,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{2,oi}<(T2/1000+PRE_TIME));
            end
            
            TUN_WBl.Fast.Me{nn}=mean(sp_tr)/(T2-T1)*1000;
            TUN_WBl.Fast.St{nn}=std(sp_tr)/(T2-T1)*1000;
            TUN_WBl.Fast.Se{nn}=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
                bbb_s(find(motion_values==I)+2)=TUN_WBl.Fast.Me{nn};
                sss_s(find(motion_values==I)+2)=TUN_WBl.Fast.Se{nn};

%                 h(nn)=figure(nn)    
%                 title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);
               
              
           bbl_s = [bbb_s(end-1), bbb_s(end-1), bbb_s(end-1), bbb_s(end-1), bbb_s(end-1), bbb_s(end-1), bbb_s(end-1), bbb_s(end-1)];
           wbl_s = [bbb_s(end), bbb_s(end), bbb_s(end), bbb_s(end), bbb_s(end), bbb_s(end), bbb_s(end), bbb_s(end)];    
           
           
%               ordered_values=sortGivenOrder(motion_values);
              ordered_bbb_s1=sortGivenOrder(bbb_s(1:numel(motion_values)));
              ordered_sss_s1=sortGivenOrder(sss_s(1:numel(motion_values)));
              ordered_bbb_s{ob}=sortGivenOrder(bbb_s(1:numel(motion_values)));
              ordered_sss_s{ob}=sortGivenOrder(sss_s(1:numel(motion_values)));
                            
                             
              
              
end
              
              
              
       %% plot    
            figure(nn);
            
for i=1:numel(object);
            conta3 = conta3+1;    
            
            subplot(5,6,1) 
%             title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);
            hold on;
            her_f{i}=errorbar(ordered_values,ordered_bbb_f{i},ordered_sss_f{i},'-O','color',COLORSET(conta3,:), 'linewidth', 1.5);
            xlabel(['Fast Motion Tuning'])
            xlim([min(ordered_values)-3 max(ordered_values)+3])
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
            

            
            
            subplot(5,6,7)
            her_s{i}=errorbar(ordered_values,ordered_bbb_s{i},ordered_sss_s{i},'-O','color',COLORSET(conta3,:), 'linewidth', 1.5);
            xlabel(['Slow Motion Tuning'])
            xlim([min(ordered_values)-3 max(ordered_values)+3])
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
            

            
%             xlim([min(ordered_values)-3 max(ordered_values)+3])
%             set(gca, 'XTick', [ordered_values])
            
              subplot(5,6,2)            
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
           
            
            
              subplot(5,6,8)
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

            legend([ha_f{1},ha_f{2},ha_f{3},ha_f{4}],{'Ent','Bunny','Orca','Pingu'})
%             legend([ha_s{1},ha_s{2},ha_s{3},ha_s{4}],{'Ent','Bunny','Orca','Pingu'})
            hold on;
            
clear ob her_f her_s ha_f ha_s clear ordered_bbb_f ordered_bbb_s ordered_sss_f ordered_sss_s bbb_f sss_f bbb_s sss_s selected_bits Y ordered_values motion_values          
            
            
            
%% Bars     
    contami = 0;
    countolo=0;
    conta = 0;
    conta2 = 0;
    conta3 = 0;
for ob = object2

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
            TUN.Fast.Me{nn}(z)=mean(sp_tr)/(T2-T1)*1000;
            TUN.Fast.St{nn}(z)=std(sp_tr)/(T2-T1)*1000;
            TUN.Fast.Se{nn}(z)=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;

                bbb_f(find(motion_values==I))=TUN.Fast.Me{nn}(z);
                sss_f(find(motion_values==I))=TUN.Fast.Se{nn}(z);
                %sp_tr
        end
        

                
            %% black blanks (bitcode 6 for short bblank)
            sp_tr=[];
            T1=my_times{6,nn}(1);
            T2=my_times{6,nn}(2);
            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{6,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{6,oi}<(T2/1000+PRE_TIME));
            end
            
            TUN_BBl.Fast.Me{nn}=mean(sp_tr)/(T2-T1)*1000;
            TUN_BBl.Fast.St{nn}=std(sp_tr)/(T2-T1)*1000;
            TUN_BBl.Fast.Se{nn}=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
                bbb_f(find(motion_values==I)+1)=TUN_BBl.Fast.Me{nn};
                sss_f(find(motion_values==I)+1)=TUN_BBl.Fast.Se{nn};

%                 h(nn)=figure(nn)
                
           %% white blanks (bitcode 3 for short wblank)
            sp_tr=[];
            T1=my_times{3,nn}(1);
            T2=my_times{3,nn}(2);
            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{3,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{3,oi}<(T2/1000+PRE_TIME));
            end
            
            TUN_WBl.Fast.Me{nn}=mean(sp_tr)/(T2-T1)*1000;
            TUN_WBl.Fast.St{nn}=std(sp_tr)/(T2-T1)*1000;
            TUN_WBl.Fast.Se{nn}=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
                bbb_f(find(motion_values==I)+2)=TUN_WBl.Fast.Me{nn};
                sss_f(find(motion_values==I)+2)=TUN_WBl.Fast.Se{nn};

                
                
                
                
                
           bbl_f = [bbb_f(end-1), bbb_f(end-1), bbb_f(end-1), bbb_f(end-1), bbb_f(end-1), bbb_f(end-1), bbb_f(end-1), bbb_f(end-1)];
           wbl_f = [bbb_f(end), bbb_f(end), bbb_f(end), bbb_f(end), bbb_f(end), bbb_f(end), bbb_f(end), bbb_f(end)]; 
           
              ordered_values=sortGivenOrder(motion_values);
              ordered_bbb_f1=sortGivenOrder(bbb_f(1:numel(motion_values)));
              ordered_sss_f1=sortGivenOrder(sss_f(1:numel(motion_values)));
              ordered_bbb_f{contami}=sortGivenOrder(bbb_f(1:numel(motion_values)));
              ordered_sss_f{contami}=sortGivenOrder(sss_f(1:numel(motion_values)));
              rad_ordered_values = ordered_values .* pi/180;
              
    
              
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
            TUN.Slow.Me{nn}(z)=mean(sp_tr)/(T2-T1)*1000;
            TUN.Slow.St{nn}(z)=std(sp_tr)/(T2-T1)*1000;
            TUN.Slow.Se{nn}(z)=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;

                bbb_s(find(motion_values==I))=TUN.Slow.Me{nn}(z);
                sss_s(find(motion_values==I))=TUN.Slow.Se{nn}(z);
                %sp_tr
        end
        

                
            %% blanks (bitcode 5 for long bblank)
            sp_tr=[];
            T1=my_times{5,nn}(1);
            T2=my_times{5,nn}(2);
            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{5,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{5,oi}<(T2/1000+PRE_TIME));
            end
            
            TUN_Bl.Slow.Me{nn}=mean(sp_tr)/(T2-T1)*1000;
            TUN_Bl.Slow.St{nn}=std(sp_tr)/(T2-T1)*1000;
            TUN_Bl.Slow.Se{nn}=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
                bbb_s(find(motion_values==I)+1)=TUN_Bl.Slow.Me{nn};
                sss_s(find(motion_values==I)+1)=TUN_Bl.Slow.Se{nn};

%                 h(nn)=figure(nn)
                
                
            %% white blanks (bitcode 2 for long wblank)
            sp_tr=[];
            T1=my_times{2,nn}(1);
            T2=my_times{2,nn}(2);
            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{2,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{2,oi}<(T2/1000+PRE_TIME));
            end
            
            TUN_WBl.Fast.Me{nn}=mean(sp_tr)/(T2-T1)*1000;
            TUN_WBl.Fast.St{nn}=std(sp_tr)/(T2-T1)*1000;
            TUN_WBl.Fast.Se{nn}=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
                bbb_s(find(motion_values==I)+2)=TUN_WBl.Fast.Me{nn};
                sss_s(find(motion_values==I)+2)=TUN_WBl.Fast.Se{nn};

%                 h(nn)=figure(nn)    
%                 title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);
               
              
           bbl_s = [bbb_s(end-1), bbb_s(end-1), bbb_s(end-1), bbb_s(end-1), bbb_s(end-1), bbb_s(end-1), bbb_s(end-1), bbb_s(end-1)];
           wbl_s = [bbb_s(end), bbb_s(end), bbb_s(end), bbb_s(end), bbb_s(end), bbb_s(end), bbb_s(end), bbb_s(end)];    
           
           
%               ordered_values=sortGivenOrder(motion_values);
              ordered_bbb_s1=sortGivenOrder(bbb_s(1:numel(motion_values)));
              ordered_sss_s1=sortGivenOrder(sss_s(1:numel(motion_values)));
              ordered_bbb_s{contami}=sortGivenOrder(bbb_s(1:numel(motion_values)));
              ordered_sss_s{contami}=sortGivenOrder(sss_s(1:numel(motion_values)));
                            
                             
              
              
end
              
              
              
       %% plot    
            
            
for i=1:numel(object2);
            conta3 = conta3+1;    
            
            subplot(5,6,13) 
%             title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);
            hold on;
            her_f{i}=errorbar(ordered_values,ordered_bbb_f{i},ordered_sss_f{i},'-O','color',COLORSET(conta3,:), 'linewidth', 1.5);
            xlabel(['Fast Motion Tuning'])
            xlim([min(ordered_values)-3 max(ordered_values)+3])
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
            

            
            
            subplot(5,6,19)
            her_s{i}=errorbar(ordered_values,ordered_bbb_s{i},ordered_sss_s{i},'-O','color',COLORSET(conta3,:), 'linewidth', 1.5);
            xlabel(['Slow Motion Tuning'])
            xlim([min(ordered_values)-3 max(ordered_values)+3])
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
            

            
%             xlim([min(ordered_values)-3 max(ordered_values)+3])
%             set(gca, 'XTick', [ordered_values])
            
              subplot(5,6,14)            
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
           
            
            
              subplot(5,6,20)
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

            legend([ha_f{i}],{'Bar'})
%             legend([ha_s{i}],{'Bar'})
            hold on;            
            
clear ob her_f her_s ha_f ha_s clear ordered_bbb_f ordered_bbb_s ordered_sss_f ordered_sss_s bbb_f sss_f bbb_s sss_s selected_bits Y ordered_values motion_values              
            
            
%% Gratings
    contami = 0;
    countolo=0;
    conta = 0;
    conta2 = 0;
    conta3 = 0;

for ob = object3

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
            TUN.Fast.Me{nn}(z)=mean(sp_tr)/(T2-T1)*1000;
            TUN.Fast.St{nn}(z)=std(sp_tr)/(T2-T1)*1000;
            TUN.Fast.Se{nn}(z)=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;

                bbb_f(find(motion_values==I))=TUN.Fast.Me{nn}(z);
                sss_f(find(motion_values==I))=TUN.Fast.Se{nn}(z);
                %sp_tr
        end
        

                
            %% black blanks (bitcode 6 for short bblank)
            sp_tr=[];
            T1=my_times{6,nn}(1);
            T2=my_times{6,nn}(2);
            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{6,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{6,oi}<(T2/1000+PRE_TIME));
            end
            
            TUN_BBl.Fast.Me{nn}=mean(sp_tr)/(T2-T1)*1000;
            TUN_BBl.Fast.St{nn}=std(sp_tr)/(T2-T1)*1000;
            TUN_BBl.Fast.Se{nn}=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
                bbb_f(find(motion_values==I)+1)=TUN_BBl.Fast.Me{nn};
                sss_f(find(motion_values==I)+1)=TUN_BBl.Fast.Se{nn};

%                 h(nn)=figure(nn)
                
           %% white blanks (bitcode 3 for short wblank)
            sp_tr=[];
            T1=my_times{3,nn}(1);
            T2=my_times{3,nn}(2);
            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{3,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{3,oi}<(T2/1000+PRE_TIME));
            end
            
            TUN_WBl.Fast.Me{nn}=mean(sp_tr)/(T2-T1)*1000;
            TUN_WBl.Fast.St{nn}=std(sp_tr)/(T2-T1)*1000;
            TUN_WBl.Fast.Se{nn}=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
                bbb_f(find(motion_values==I)+2)=TUN_WBl.Fast.Me{nn};
                sss_f(find(motion_values==I)+2)=TUN_WBl.Fast.Se{nn};

                
                
                
                
                
           bbl_f = [bbb_f(end-1), bbb_f(end-1), bbb_f(end-1), bbb_f(end-1), bbb_f(end-1), bbb_f(end-1), bbb_f(end-1), bbb_f(end-1)];
           wbl_f = [bbb_f(end), bbb_f(end), bbb_f(end), bbb_f(end), bbb_f(end), bbb_f(end), bbb_f(end), bbb_f(end)]; 
           
              ordered_values=sortGivenOrder(motion_values);
              ordered_bbb_f1=sortGivenOrder(bbb_f(1:numel(motion_values)));
              ordered_sss_f1=sortGivenOrder(sss_f(1:numel(motion_values)));
              ordered_bbb_f{contami}=sortGivenOrder(bbb_f(1:numel(motion_values)));
              ordered_sss_f{contami}=sortGivenOrder(sss_f(1:numel(motion_values)));
              rad_ordered_values = ordered_values .* pi/180;
              
    
              
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
            TUN.Slow.Me{nn}(z)=mean(sp_tr)/(T2-T1)*1000;
            TUN.Slow.St{nn}(z)=std(sp_tr)/(T2-T1)*1000;
            TUN.Slow.Se{nn}(z)=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;

                bbb_s(find(motion_values==I))=TUN.Slow.Me{nn}(z);
                sss_s(find(motion_values==I))=TUN.Slow.Se{nn}(z);
                %sp_tr
        end
        

                
            %% blanks (bitcode 5 for long bblank)
            sp_tr=[];
            T1=my_times{5,nn}(1);
            T2=my_times{5,nn}(2);
            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{5,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{5,oi}<(T2/1000+PRE_TIME));
            end
            
            TUN_Bl.Slow.Me{nn}=mean(sp_tr)/(T2-T1)*1000;
            TUN_Bl.Slow.St{nn}=std(sp_tr)/(T2-T1)*1000;
            TUN_Bl.Slow.Se{nn}=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
                bbb_s(find(motion_values==I)+1)=TUN_Bl.Slow.Me{nn};
                sss_s(find(motion_values==I)+1)=TUN_Bl.Slow.Se{nn};

%                 h(nn)=figure(nn)
                
                
            %% white blanks (bitcode 2 for long wblank)
            sp_tr=[];
            T1=my_times{2,nn}(1);
            T2=my_times{2,nn}(2);
            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{2,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{2,oi}<(T2/1000+PRE_TIME));
            end
            
            TUN_WBl.Fast.Me{nn}=mean(sp_tr)/(T2-T1)*1000;
            TUN_WBl.Fast.St{nn}=std(sp_tr)/(T2-T1)*1000;
            TUN_WBl.Fast.Se{nn}=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
                bbb_s(find(motion_values==I)+2)=TUN_WBl.Fast.Me{nn};
                sss_s(find(motion_values==I)+2)=TUN_WBl.Fast.Se{nn};

%                 h(nn)=figure(nn)    
%                 title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);
               
              
           bbl_s = [bbb_s(end-1), bbb_s(end-1), bbb_s(end-1), bbb_s(end-1), bbb_s(end-1), bbb_s(end-1), bbb_s(end-1), bbb_s(end-1)];
           wbl_s = [bbb_s(end), bbb_s(end), bbb_s(end), bbb_s(end), bbb_s(end), bbb_s(end), bbb_s(end), bbb_s(end)];    
           
           
%               ordered_values=sortGivenOrder(motion_values);
              ordered_bbb_s1=sortGivenOrder(bbb_s(1:numel(motion_values)));
              ordered_sss_s1=sortGivenOrder(sss_s(1:numel(motion_values)));
              ordered_bbb_s{contami}=sortGivenOrder(bbb_s(1:numel(motion_values)));
              ordered_sss_s{contami}=sortGivenOrder(sss_s(1:numel(motion_values)));
                            
                             
              
              
end
              
              
              
       %% plot    
            figure(nn);
            
for i=1:numel(object3);
            conta3 = conta3+1;    
            
            subplot(5,6,4) 
%             title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);
            hold on;
            her_f{i}=errorbar(ordered_values,ordered_bbb_f{i},ordered_sss_f{i},'-O','color',COLORSET(conta3,:), 'linewidth', 1.5);
            xlabel(['Fast Motion Tuning'])
            xlim([min(ordered_values)-3 max(ordered_values)+3])
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
            

            
            
            subplot(5,6,10)
            her_s{i}=errorbar(ordered_values,ordered_bbb_s{i},ordered_sss_s{i},'-O','color',COLORSET(conta3,:), 'linewidth', 1.5);
            xlabel(['Slow Motion Tuning'])
            xlim([min(ordered_values)-3 max(ordered_values)+3])
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
            

            
%             xlim([min(ordered_values)-3 max(ordered_values)+3])
%             set(gca, 'XTick', [ordered_values])
            
              subplot(5,6,5)            
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
           
            
            
              subplot(5,6,11)
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

            legend([ha_f{1},ha_f{2},ha_f{3},ha_f{4}],{'SF 0.03','SF 0.05','SF 0.1','SF 0.4'}, -1)
%             legend([ha_s{1},ha_s{2},ha_s{3},ha_s{4}],{'SF 0.03','SF 0.05','SF 0.1','SF 0.4'})
            hold on;
            
clear ob her_f her_s ha_f ha_s clear ordered_bbb_f ordered_bbb_s ordered_sss_f ordered_sss_s bbb_f sss_f bbb_s sss_s selected_bits Y ordered_values motion_values              
            
            
            
%% Dots
    contami = 0;
    countolo=0;
    conta = 0;
    conta2 = 0;
    conta3 = 0;

for ob = object4

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
            TUN.Fast.Me{nn}(z)=mean(sp_tr)/(T2-T1)*1000;
            TUN.Fast.St{nn}(z)=std(sp_tr)/(T2-T1)*1000;
            TUN.Fast.Se{nn}(z)=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;

                bbb_f(find(motion_values==I))=TUN.Fast.Me{nn}(z);
                sss_f(find(motion_values==I))=TUN.Fast.Se{nn}(z);
                %sp_tr
        end
        

                
            %% black blanks (bitcode 6 for short bblank)
            sp_tr=[];
            T1=my_times{6,nn}(1);
            T2=my_times{6,nn}(2);
            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{6,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{6,oi}<(T2/1000+PRE_TIME));
            end
            
            TUN_BBl.Fast.Me{nn}=mean(sp_tr)/(T2-T1)*1000;
            TUN_BBl.Fast.St{nn}=std(sp_tr)/(T2-T1)*1000;
            TUN_BBl.Fast.Se{nn}=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
                bbb_f(find(motion_values==I)+1)=TUN_BBl.Fast.Me{nn};
                sss_f(find(motion_values==I)+1)=TUN_BBl.Fast.Se{nn};

%                 h(nn)=figure(nn)
                
           %% white blanks (bitcode 3 for short wblank)
            sp_tr=[];
            T1=my_times{3,nn}(1);
            T2=my_times{3,nn}(2);
            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{3,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{3,oi}<(T2/1000+PRE_TIME));
            end
            
            TUN_WBl.Fast.Me{nn}=mean(sp_tr)/(T2-T1)*1000;
            TUN_WBl.Fast.St{nn}=std(sp_tr)/(T2-T1)*1000;
            TUN_WBl.Fast.Se{nn}=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
                bbb_f(find(motion_values==I)+2)=TUN_WBl.Fast.Me{nn};
                sss_f(find(motion_values==I)+2)=TUN_WBl.Fast.Se{nn};

                
                
                
                
                
           bbl_f = [bbb_f(end-1), bbb_f(end-1), bbb_f(end-1), bbb_f(end-1), bbb_f(end-1), bbb_f(end-1), bbb_f(end-1), bbb_f(end-1)];
           wbl_f = [bbb_f(end), bbb_f(end), bbb_f(end), bbb_f(end), bbb_f(end), bbb_f(end), bbb_f(end), bbb_f(end)]; 
           
              ordered_values=sortGivenOrder(motion_values);
              ordered_bbb_f1=sortGivenOrder(bbb_f(1:numel(motion_values)));
              ordered_sss_f1=sortGivenOrder(sss_f(1:numel(motion_values)));
              ordered_bbb_f{contami}=sortGivenOrder(bbb_f(1:numel(motion_values)));
              ordered_sss_f{contami}=sortGivenOrder(sss_f(1:numel(motion_values)));
              rad_ordered_values = ordered_values .* pi/180;
              
    
              
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
            TUN.Slow.Me{nn}(z)=mean(sp_tr)/(T2-T1)*1000;
            TUN.Slow.St{nn}(z)=std(sp_tr)/(T2-T1)*1000;
            TUN.Slow.Se{nn}(z)=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;

                bbb_s(find(motion_values==I))=TUN.Slow.Me{nn}(z);
                sss_s(find(motion_values==I))=TUN.Slow.Se{nn}(z);
                %sp_tr
        end
        

                
            %% blanks (bitcode 5 for long bblank)
            sp_tr=[];
            T1=my_times{5,nn}(1);
            T2=my_times{5,nn}(2);
            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{5,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{5,oi}<(T2/1000+PRE_TIME));
            end
            
            TUN_Bl.Slow.Me{nn}=mean(sp_tr)/(T2-T1)*1000;
            TUN_Bl.Slow.St{nn}=std(sp_tr)/(T2-T1)*1000;
            TUN_Bl.Slow.Se{nn}=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
                bbb_s(find(motion_values==I)+1)=TUN_Bl.Slow.Me{nn};
                sss_s(find(motion_values==I)+1)=TUN_Bl.Slow.Se{nn};

%                 h(nn)=figure(nn)
                
                
            %% white blanks (bitcode 2 for long wblank)
            sp_tr=[];
            T1=my_times{2,nn}(1);
            T2=my_times{2,nn}(2);
            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{2,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{2,oi}<(T2/1000+PRE_TIME));
            end
            
            TUN_WBl.Fast.Me{nn}=mean(sp_tr)/(T2-T1)*1000;
            TUN_WBl.Fast.St{nn}=std(sp_tr)/(T2-T1)*1000;
            TUN_WBl.Fast.Se{nn}=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
                bbb_s(find(motion_values==I)+2)=TUN_WBl.Fast.Me{nn};
                sss_s(find(motion_values==I)+2)=TUN_WBl.Fast.Se{nn};

%                 h(nn)=figure(nn)    
%                 title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);
               
              
           bbl_s = [bbb_s(end-1), bbb_s(end-1), bbb_s(end-1), bbb_s(end-1), bbb_s(end-1), bbb_s(end-1), bbb_s(end-1), bbb_s(end-1)];
           wbl_s = [bbb_s(end), bbb_s(end), bbb_s(end), bbb_s(end), bbb_s(end), bbb_s(end), bbb_s(end), bbb_s(end)];    
           
           
%               ordered_values=sortGivenOrder(motion_values);
              ordered_bbb_s1=sortGivenOrder(bbb_s(1:numel(motion_values)));
              ordered_sss_s1=sortGivenOrder(sss_s(1:numel(motion_values)));
              ordered_bbb_s{contami}=sortGivenOrder(bbb_s(1:numel(motion_values)));
              ordered_sss_s{contami}=sortGivenOrder(sss_s(1:numel(motion_values)));
                            
                             
              
              
end
              
              
              
       %% plot    
            figure(nn);
            
for i=1:numel(object4);
            conta3 = conta3+1;    
            
            subplot(5,6,16) 
%             title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);
            hold on;
            her_f{i}=errorbar(ordered_values,ordered_bbb_f{i},ordered_sss_f{i},'-O','color',COLORSET(conta3,:), 'linewidth', 1.5);
            xlabel(['Fast Motion Tuning'])
            xlim([min(ordered_values)-3 max(ordered_values)+3])
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
            

            
            
            subplot(5,6,22)
            her_s{i}=errorbar(ordered_values,ordered_bbb_s{i},ordered_sss_s{i},'-O','color',COLORSET(conta3,:), 'linewidth', 1.5);
            xlabel(['Slow Motion Tuning'])
            xlim([min(ordered_values)-3 max(ordered_values)+3])
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
            

            
%             xlim([min(ordered_values)-3 max(ordered_values)+3])
%             set(gca, 'XTick', [ordered_values])
            
              subplot(5,6,17)            
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
           
            
            
              subplot(5,6,23)
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

            legend([ha_f{1},ha_f{2}],{'Pattern 1','Pattern 2'}, -1)
%             legend([ha_s{1},ha_s{2},ha_s{3},ha_s{4}],{'SF 0.03','SF 0.05','SF 0.1','SF 0.4'})
            hold on;
            
clear ob her_f her_s ha_f ha_s clear ordered_bbb_f ordered_bbb_s ordered_sss_f ordered_sss_s bbb_f sss_f bbb_s sss_s selected_bits Y ordered_values motion_values              
            
%% RF
            s2 = subplot(5,4,[17, 17.8]);
            xlim([0 11])
            ylim([0 6])
            set(gca, 'XTick', [0:1:11])
            set(gca, 'YTick', [0:1:6])
            
            

 
            my_folder_1 = ['/zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_', char(DayOfRecording), '/ANALYSED/BlockS-', num2str(Block), '/BL_1/RFs'];
            cd(my_folder_1)


            h1 = openfig([num2str(nn)],'reuse'); % open figure
            ax1 = gca(h1);
            fig1 = get(ax1,'children');
            bubu = gcf;
            
             %get handle to all the children in the figure

            copyobj(fig1,s2);
            close (bubu)
            colorbar
            set (gcf, 'NextPlot', 'add');
            axes;
            h = title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);
            set(gca, 'Visible', 'off');
            set(h, 'Visible', 'on', 'FontSize', 18);
            

%             legend([ha{1},ha{2},ha{3},ha{4}],{'Ent','Bunny','Orca','Pingu'})
%             legend([her{1},her{2},her{3},her{4}],{'Ent','Bunny','Orca','Pingu'}, -1)
            cd ..
            cd ..
            cd(my_folder)
            ww = cd;
            saveas(gcf,[ww,'/TUNING/', num2str(nn), '_mT_', char(stimidentity),'.png']) 
            saveas(gcf,[ww,'/TUNING/', num2str(nn), '_mT_', char(stimidentity),'.fig'])  
            close all

            clear ha clear ordered_bbb_f ordered_bbb_s ordered_sss_f ordered_sss_s bbb_f sss_f bbb_s sss_s selected_bits Y ordered_values motion_values


            
            
end           


            

% save([ww,'/TUNING/MovingObjects_Tuning.mat'], 'TUN', 'TUN_BBl', 'TUN_WBl', '-v7.3');
