%%%%%% STATIC TUNING ALL CONDITIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
clc
close all

DayOfRecording = '13_12_2013';
Block_Set=[56];

for k = Block_Set;

my_folder = ['/zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_', char(DayOfRecording), '/ANALYSED/BlockS-', num2str(k), '/BL_2/My_Structure/25'];
% my_folder = ['/zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_', , char(DayOfRecording), '/ANALYSED/Block-' , num2str(Block), '/My_Structure/25'];

addpath /zocconasphys1/chronic_inv_rec/codes/
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


for nn = 1:neuronS;
    
    pos_index=[1:4];
    my_symbols = {'-d', '-o', '-s', '-^'};

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
contami2 = 0;




%%%%%%%%%%%%%%%%
%%%%%%%%%%% OBJECTS
%%%%%%%%%%%%%%%%

%% Objects Size


for ob = object

        T1=[];
        T2=[];
        
        COLORSET=varycolor(numel(object));
        contami = contami+1;
        contami2 = contami2+1;

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
            
        [a z]=ind2sub(size(Fede_STIM_NU), find(Fede_STIM_NU(1:342,2)==ob & Fede_STIM_NU(1:342,10)==0 & Fede_STIM_NU(1:342,9)==0 & Fede_STIM_NU(1:342,5)==0 & Fede_STIM_NU(1:342,7)==0 & Fede_STIM_NU(1:342,11)==0.250000000000000));       
        selected_bits = a';       
        size_values = unique(Fede_STIM_NU(selected_bits,3)); %% column 3 = size
        
        
        for z = 1:numel(size_values)  
            
        I=size_values(z);
        stim = selected_bits(z);
        sp_tr=[];
        T1=my_times{stim,nn}(1);
        T2=my_times{stim,nn}(2);

            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{stim,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{stim,oi}<(T2/1000+PRE_TIME));
            end
%             sp_tr;
            ObjectsTuning.Size(ob).Me{nn}(z)=mean(sp_tr)/(T2-T1)*1000;
            ObjectsTuning.Size(ob).St{nn}(z)=std(sp_tr)/(T2-T1)*1000;
            ObjectsTuning.Size(ob).Se{nn}(z)=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;

                bbb_si(find(size_values==I))=ObjectsTuning.Size(ob).Me{nn}(z);
                sss_si(find(size_values==I))=ObjectsTuning.Size(ob).Se{nn}(z);
                std_si(find(size_values==I))=ObjectsTuning.Size(ob).St{nn}(z);
                %sp_tr
        end
        

                
            %% black blanks (bitcode 4 for static bblank)
            sp_tr=[];
            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{4,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{4,oi}<(T2/1000+PRE_TIME));
            end
            
            ObjectsTuning_BB.Size.Me{nn}=mean(sp_tr)/(T2-T1)*1000;
            ObjectsTuning_BB.Size.St{nn}=std(sp_tr)/(T2-T1)*1000;
            ObjectsTuning_BB.Size.Se{nn}=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
                bbb_si(find(size_values==I)+1)=ObjectsTuning_BB.Size.Me{nn};
                sss_si(find(size_values==I)+1)=ObjectsTuning_BB.Size.Se{nn};
                std_si(find(size_values==I)+1)=ObjectsTuning_BB.Size.St{nn};

                
           %% white blanks (bitcode 1 for static wblank)
            sp_tr=[];
            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{1,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{1,oi}<(T2/1000+PRE_TIME));
            end
            
            ObjectsTuning_WB.Size.Me{nn}=mean(sp_tr)/(T2-T1)*1000;
            ObjectsTuning_WB.Size.St{nn}=std(sp_tr)/(T2-T1)*1000;
            ObjectsTuning_WB.Size.Se{nn}=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
                bbb_si(find(size_values==I)+2)=ObjectsTuning_WB.Size.Me{nn};
                sss_si(find(size_values==I)+2)=ObjectsTuning_WB.Size.Se{nn};
                std_si(find(size_values==I)+2)=ObjectsTuning_WB.Size.St{nn};


           
          ordered_bbb_si{ob}=bbb_si(1:numel(size_values));
          ordered_sss_si{ob}=sss_si(1:numel(size_values)); 
          ordered_std_si{ob}=std_si(1:numel(size_values)); 
          
            ObjectsTuning.Size(ob).Me{nn}=ordered_bbb_si{ob};
            ObjectsTuning.Size(ob).St{nn}=ordered_std_si{ob};
            ObjectsTuning.Size(ob).Se{nn}=ordered_sss_si{ob};
          
          
          clear stim
          
          
          
%% Objects orientation In Plane

        [a z]=ind2sub(size(Fede_STIM_NU), find(Fede_STIM_NU(1:342,2)==ob & Fede_STIM_NU(1:342,3)==35 & Fede_STIM_NU(1:342,9)==0 & Fede_STIM_NU(1:342,5)==0 & Fede_STIM_NU(1:342,7)==0 & Fede_STIM_NU(1:342,11)==0.250000000000000));       
        raw_bits = a';       
        selected_bits=sortGivenOrder_Ori(raw_bits);
        ori_values = unique(Fede_STIM_NU(selected_bits,10)); %% column 10 = orientations
        
 
        for z = 1:numel(ori_values)  
            
        I=ori_values(z);
        stim = selected_bits(z);
        sp_tr=[];
        T1=my_times{stim,nn}(1);
        T2=my_times{stim,nn}(2);

            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{stim,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{stim,oi}<(T2/1000+PRE_TIME));
            end
%             sp_tr;
            ObjectsTuning.Ori(ob).Me{nn}(z)=mean(sp_tr)/(T2-T1)*1000;
            ObjectsTuning.Ori(ob).St{nn}(z)=std(sp_tr)/(T2-T1)*1000;
            ObjectsTuning.Ori(ob).Se{nn}(z)=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;

                bbb_ori(find(ori_values==I))=ObjectsTuning.Ori(ob).Me{nn}(z);
                sss_ori(find(ori_values==I))=ObjectsTuning.Ori(ob).Se{nn}(z);
                std_ori(find(ori_values==I))=ObjectsTuning.Ori(ob).St{nn}(z);
                %sp_tr
        end
        

                
            %% black blanks (bitcode 4 for static bblank)
            sp_tr=[];
            T1=my_times{4,nn}(1);
            T2=my_times{4,nn}(2);
            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{4,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{4,oi}<(T2/1000+PRE_TIME));
            end
            
            ObjectsTuning_BB.Ori.Me{nn}=mean(sp_tr)/(T2-T1)*1000;
            ObjectsTuning_BB.Ori.St{nn}=std(sp_tr)/(T2-T1)*1000;
            ObjectsTuning_BB.Ori.Se{nn}=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
                bbb_ori(find(ori_values==I)+1)=ObjectsTuning_BB.Ori.Me{nn};
                sss_ori(find(ori_values==I)+1)=ObjectsTuning_BB.Ori.Se{nn};
                std_ori(find(ori_values==I)+1)=ObjectsTuning_BB.Ori.St{nn};


                
           %% white blanks (bitcode 1 for static wblank)
            sp_tr=[];
            T1=my_times{1,nn}(1);
            T2=my_times{1,nn}(2);
            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{1,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{1,oi}<(T2/1000+PRE_TIME));
            end
            
            ObjectsTuning_WB.Ori.Me{nn}=mean(sp_tr)/(T2-T1)*1000;
            ObjectsTuning_WB.Ori.St{nn}=std(sp_tr)/(T2-T1)*1000;
            ObjectsTuning_WB.Ori.Se{nn}=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
                bbb_ori(find(ori_values==I)+2)=ObjectsTuning_WB.Ori.Me{nn};
                sss_ori(find(ori_values==I)+2)=ObjectsTuning_WB.Ori.Se{nn};
                std_ori(find(ori_values==I)+2)=ObjectsTuning_WB.Ori.St{nn};
                
                
                
                
           ordered_bbb_ori{ob}=bbb_ori(1:numel(ori_values));
           ordered_sss_ori{ob}=sss_ori(1:numel(ori_values)); 
           ordered_std_ori{ob}=std_ori(1:numel(ori_values)); 
           
%            ordered_bbb_po{ob}=sortGivenOrder_Ori(bbb_ori(1:numel(ori_values)));
           
            ObjectsTuning.Ori(ob).Me{nn}=ordered_bbb_ori{ob};
            ObjectsTuning.Ori(ob).St{nn}=ordered_std_ori{ob};
            ObjectsTuning.Ori(ob).Se{nn}=ordered_sss_ori{ob};
           
           
           clear stim
          

%% Objects orientation Azimuth

        [a z]=ind2sub(size(Fede_STIM_NU), find(Fede_STIM_NU(1:342,2)==ob & Fede_STIM_NU(1:342,3)==35 & Fede_STIM_NU(1:342,10)==0 & Fede_STIM_NU(1:342,5)==0 & Fede_STIM_NU(1:342,7)==0 & Fede_STIM_NU(1:342,11)==0.250000000000000));       
        raw_bits = a';       
        selected_bits=sortGivenOrder_Azi(raw_bits);
        azi_values = unique(Fede_STIM_NU(selected_bits,9)); %% column 9 = azimuth
        
 
        for z = 1:numel(azi_values)  
            
        I=azi_values(z);
        stim = selected_bits(z);
        sp_tr=[];
        T1=my_times{stim,nn}(1);
        T2=my_times{stim,nn}(2);

            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{stim,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{stim,oi}<(T2/1000+PRE_TIME));
            end
%             sp_tr;
            ObjectsTuning.Az(ob).Me{nn}(z)=mean(sp_tr)/(T2-T1)*1000;
            ObjectsTuning.Az(ob).St{nn}(z)=std(sp_tr)/(T2-T1)*1000;
            ObjectsTuning.Az(ob).Se{nn}(z)=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;

                bbb_azi(find(azi_values==I))=ObjectsTuning.Az(ob).Me{nn}(z);
                sss_azi(find(azi_values==I))=ObjectsTuning.Az(ob).Se{nn}(z);
                std_azi(find(azi_values==I))=ObjectsTuning.Az(ob).St{nn}(z);
                %sp_tr
        end
        

                
            %% black blanks (bitcode 4 for static bblank)
            sp_tr=[];
            T1=my_times{4,nn}(1);
            T2=my_times{4,nn}(2);
            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{4,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{4,oi}<(T2/1000+PRE_TIME));
            end
            
            ObjectsTuning_BB.Az.Me{nn}=mean(sp_tr)/(T2-T1)*1000;
            ObjectsTuning_BB.Az.St{nn}=std(sp_tr)/(T2-T1)*1000;
            ObjectsTuning_BB.Az.Se{nn}=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
                bbb_azi(find(azi_values==I)+1)=ObjectsTuning_BB.Az.Me{nn};
                sss_azi(find(azi_values==I)+1)=ObjectsTuning_BB.Az.Se{nn};
                std_azi(find(azi_values==I)+1)=ObjectsTuning_BB.Az.St{nn};


                
           %% white blanks (bitcode 1 for static wblank)
            sp_tr=[];
            T1=my_times{1,nn}(1);
            T2=my_times{1,nn}(2);
            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{1,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{1,oi}<(T2/1000+PRE_TIME));
            end
            
            ObjectsTuning_WB.Az.Me{nn}=mean(sp_tr)/(T2-T1)*1000;
            ObjectsTuning_WB.Az.St{nn}=std(sp_tr)/(T2-T1)*1000;
            ObjectsTuning_WB.Az.Se{nn}=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
                bbb_azi(find(azi_values==I)+2)=ObjectsTuning_WB.Az.Me{nn};
                sss_azi(find(azi_values==I)+2)=ObjectsTuning_WB.Az.Se{nn};
                std_azi(find(azi_values==I)+2)=ObjectsTuning_WB.Az.St{nn};
                
                
                
                
           ordered_bbb_azi{ob}=bbb_azi(1:numel(azi_values));
           ordered_sss_azi{ob}=sss_azi(1:numel(azi_values)); 
           ordered_std_azi{ob}=std_azi(1:numel(azi_values)); 
           
%            ordered_bbb_po{ob}=sortGivenOrder_Ori(bbb_ori(1:numel(ori_values)));
           
            ObjectsTuning.Az(ob).Me{nn}=ordered_bbb_azi{ob};
            ObjectsTuning.Az(ob).St{nn}=ordered_std_azi{ob};
            ObjectsTuning.Az(ob).Se{nn}=ordered_sss_azi{ob};
           
           
           clear stim
                     
           
           
           
%% Objects Position

    for pos = pos_index
%         contami2 = 0;
%         contami = 0;   
        
        [a z]=ind2sub(size(Fede_STIM_NU), find(Fede_STIM_NU(1:342,2)==ob & (Fede_STIM_NU(1:342,13)==pos | Fede_STIM_NU(1:342,13)==5) & Fede_STIM_NU(1:342,3)==35 & Fede_STIM_NU(1:342,11)==0.250000000000000 )); %& Fede_STIM_NU(1:342,5)==0 & Fede_STIM_NU(1:342,7)==0));       
        selected_bits = a';               
        if pos == 3
            pos_values = Fede_STIM_NU(selected_bits,7);
        else
            pos_values = Fede_STIM_NU(selected_bits,5); %% column 5 = x positions
        end
            

        for z = 1:numel(pos_values)  
        I=pos_values(z);
        stim = selected_bits(z);
        sp_tr=[];
        T1=my_times{stim,nn}(1);
        T2=my_times{stim,nn}(2);

            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{stim,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{stim,oi}<(T2/1000+PRE_TIME));
            end
%             sp_tr;
            ObjectsTuning.Pos(ob,pos).Me{nn}(z)=mean(sp_tr)/(T2-T1)*1000;
            ObjectsTuning.Pos(ob,pos).St{nn}(z)=std(sp_tr)/(T2-T1)*1000;
            ObjectsTuning.Pos(ob,pos).Se{nn}(z)=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;

                bbb_po(find(pos_values==I))=ObjectsTuning.Pos(ob,pos).Me{nn}(z);
                sss_po(find(pos_values==I))=ObjectsTuning.Pos(ob,pos).Se{nn}(z);
                std_po(find(pos_values==I))=ObjectsTuning.Pos(ob,pos).St{nn}(z);
                %sp_tr
        end
        

                
            %% black blanks (bitcode 4 for static bblank)
            sp_tr=[];
            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{4,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{4,oi}<(T2/1000+PRE_TIME));
            end
            
            ObjectsTuning_BB.Pos.Me{nn}=mean(sp_tr)/(T2-T1)*1000;
            ObjectsTuning_BB.Pos.St{nn}=std(sp_tr)/(T2-T1)*1000;
            ObjectsTuning_BB.Pos.Se{nn}=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
                bbb_po(find(pos_values==I)+1)=ObjectsTuning_BB.Pos.Me{nn};
                sss_po(find(pos_values==I)+1)=ObjectsTuning_BB.Pos.Se{nn};
                std_po(find(pos_values==I)+1)=ObjectsTuning_BB.Pos.St{nn};

                
           %% white blanks (bitcode 1 for static wblank)
            sp_tr=[];
            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{1,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{1,oi}<(T2/1000+PRE_TIME));
            end
            
            ObjectsTuning_WB.Pos.Me{nn}=mean(sp_tr)/(T2-T1)*1000;
            ObjectsTuning_WB.Pos.St{nn}=std(sp_tr)/(T2-T1)*1000;
            ObjectsTuning_WB.Pos.Se{nn}=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
                bbb_po(find(pos_values==I)+2)=ObjectsTuning_WB.Pos.Me{nn};
                sss_po(find(pos_values==I)+2)=ObjectsTuning_WB.Pos.Se{nn};
                std_po(find(pos_values==I)+2)=ObjectsTuning_WB.Pos.St{nn};

 
           
           if pos==1
              ordered_values_po_1{pos}=sortGivenOrderPosObjs1(pos_values);
              ordered_values_po{pos}=ordered_values_po_1{pos};
              ordered_bbb_po{ob,pos}=sortGivenOrderPosObjs1(bbb_po(1:numel(pos_values)));
              ordered_sss_po{ob,pos}=sortGivenOrderPosObjs1(sss_po(1:numel(pos_values)));
              ordered_std_po{ob,pos}=sortGivenOrderPosObjs1(std_po(1:numel(pos_values)));
           else
              ordered_values_po_2{pos}=sortGivenOrderPosObjs2(pos_values);
              ordered_values_po{pos}=ordered_values_po_2{pos};
              ordered_bbb_po{ob,pos}=sortGivenOrderPosObjs2(bbb_po(1:numel(pos_values)));
              ordered_sss_po{ob,pos}=sortGivenOrderPosObjs2(sss_po(1:numel(pos_values)));
              ordered_std_po{ob,pos}=sortGivenOrderPosObjs2(std_po(1:numel(pos_values)));
           end
           
            ObjectsTuning.Pos(ob,pos).Me{nn}=ordered_bbb_po{ob,pos};
            ObjectsTuning.Pos(ob,pos).St{nn}=ordered_std_po{ob,pos};
            ObjectsTuning.Pos(ob,pos).Se{nn}=ordered_sss_po{ob,pos};

           
    end
           
           
end


              
              
              
%% Objects plots    


            myfig = figure(nn);
            set(myfig,'Position',[10,10,1500,1000]);
            set(myfig, 'Name', ['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);
%             title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);
            sb1 = subplot(6,6,3);
            set(gca,'Position',[.24,.56,.15,.15]);
            
            
for i=1:numel(object);
            conta3 = conta3+1;    
            
            hold on; 
            her_si{i}=errorbar(size_values,ordered_bbb_si{i},ordered_sss_si{i},'-O','color',COLORSET(conta3,:), 'linewidth', 1.5);
            xlabel(['Size Tuning'])            
            xlim([min(size_values)-3 max(size_values)+3])
%             ylim([0 max(bbb_si(1:numel(size_values)))+3])
            set(gca, 'XTick', [size_values'])
            hold on; 

            Y=[];
            for iu=1:numel(size_values)
                Y=[Y;bbb_si(end-1)-sss_si(end-1)/2 sss_si(end-1)/2 sss_si(end-1)/2];
            end
            
            h = area(size_values,Y,-5); % Set BaseValue via argument
            alpha(0.5);
            grey=[0.4, 0.4, 0.4];
            set(h(1),'FaceColor',grey)
            set(h(2),'FaceColor',grey)
            set(h(3),'FaceColor',grey)
            set(h,'LineStyle',':','LineWidth',0.1) % Set all to same value.
            set(h,'basevalue',bbb_si(end-1)-sss_si(end-1)/2)
            hold on
            line([size_values(1) size_values(end)],[bbb_si(end-1) bbb_si(end-1)],'color',grey,'linewidth',2)
            hold on
            
            
            Y=[];
%             ordered_values=sortGivenOrder(motion_values);
            for iu=1:numel(size_values)
                Y=[Y;bbb_si(end)-sss_si(end)/2 sss_si(end)/2 sss_si(end)/2];
            end
            h = area(size_values,Y,-5);  
            grey2=[0.8, 0.8, 0.8];
            set(h(1),'FaceColor',grey2)
            set(h(2),'FaceColor',grey2)
            set(h(3),'FaceColor',grey2)            
            set(h,'LineStyle',':','LineWidth',0.1) % Set all to same value.
            set(h,'basevalue',bbb_si(end)-sss_si(end)/2)
            hold on
            alpha(.5)
            line([size_values(1) size_values(end)],[bbb_si(end) bbb_si(end)],'color',grey2,'linewidth',2);

end



for pos = 1:4
    
if pos == 1
   postype = 'DL Axis';
   sbpo = subplot(6,6,6);  %7);
   set(gca,'Position',[.05,.8,.15,.15]);
elseif pos == 2
   postype = 'DR Axis';
   sbpo = subplot(6,6,6);  %7);
   set(gca,'Position',[.05,.56,.15,.15]);
elseif pos == 3
   postype = 'Y Axis';
   sbpo = subplot(6,6,6);  %7);
   set(gca,'Position',[.05,.33,.15,.15]);
elseif pos == 4
   postype = 'X Axis';
   sbpo = subplot(6,6,6);  %7);
   set(gca,'Position',[.05,.1,.15,.15]);
end    



conta3 = 0;

for i=1:numel(object);
            conta3 = conta3+1;   

            xlabel(['Position Tuning, ', char(postype)])
            hold on;

            her_po{i}=errorbar(ordered_values_po{pos}, ordered_bbb_po{i,pos}, ordered_sss_po{i,pos}, my_symbols{pos},'color',COLORSET(conta3,:), 'linewidth', 1.5);
%             her{ob}=errorbar(pos_values,bbb(1:numel(pos_values)),sss(1:numel(pos_values)),'-O','color',COLORSET(contami,:)) %,)
            xlim([min(ordered_values_po{pos})-3 max(ordered_values_po{pos})+3])
            set(gca, 'XTick', [ordered_values_po{pos}])
            
            Y=[];
            for iu=1:numel(ordered_values_po{pos})
                Y=[Y;bbb_po(end-1)-sss_po(end-1)/2 sss_po(end-1)/2 sss_po(end-1)/2];
            end
            
            h = area(ordered_values_po{pos},Y,-5); % Set BaseValue via argument
            alpha(0.5);
            grey=[0.4, 0.4, 0.4];
            set(h(1),'FaceColor',grey)
            set(h(2),'FaceColor',grey)
            set(h(3),'FaceColor',grey)
            set(h,'LineStyle',':','LineWidth',0.1) % Set all to same value.
            set(h,'basevalue',bbb_po(end-1)-sss_po(end-1)/2)
            hold on
            line([ordered_values_po{pos}(1) ordered_values_po{pos}(end)],[bbb_po(end-1) bbb_po(end-1)],'color',grey,'linewidth',2)
            hold on
            
            
            Y=[];
%             ordered_values=sortGivenOrder(motion_values);
            for iu=1:numel(ordered_values_po{pos})
                Y=[Y;bbb_po(end)-sss_po(end)/2 sss_po(end)/2 sss_po(end)/2];
            end
            h = area(ordered_values_po{pos},Y,-5);  
            grey2=[0.8, 0.8, 0.8];
            set(h(1),'FaceColor',grey2)
            set(h(2),'FaceColor',grey2)
            set(h(3),'FaceColor',grey2)            
            set(h,'LineStyle',':','LineWidth',0.1) % Set all to same value.
            set(h,'basevalue',bbb_po(end)-sss_po(end)/2)
            hold on
            alpha(.5)
            line([ordered_values_po{pos}(1) ordered_values_po{pos}(end)],[bbb_po(end) bbb_po(end)],'color',grey2,'linewidth',2);
end

end

conta3 = 0;
sb2 = subplot(6,6,4);
set(gca,'Position',[.24,.33,.15,.15]);


for i=1:numel(object);
            conta3 = conta3+1;    
            
            hold on; 
            her_or{i}=errorbar(ori_values,ordered_bbb_ori{i},ordered_sss_ori{i},'-O','color',COLORSET(conta3,:), 'linewidth', 1.5);
            xlabel(['Orientation Tuning'])            
            xlim([min(ori_values)-5 max(ori_values)+5])
%             ylim([0 max(bbb_si(1:numel(size_values)))+3])
            set(gca, 'XTick', [ori_values'])
            hold on; 

            Y=[];
            for iu=1:numel(ori_values)
                Y=[Y;bbb_ori(end-1)-sss_ori(end-1)/2 sss_ori(end-1)/2 sss_ori(end-1)/2];
            end
            
            h = area(ori_values,Y,-5); % Set BaseValue via argument
            alpha(0.5);
            grey=[0.4, 0.4, 0.4];
            set(h(1),'FaceColor',grey)
            set(h(2),'FaceColor',grey)
            set(h(3),'FaceColor',grey)
            set(h,'LineStyle',':','LineWidth',0.1) % Set all to same value.
            set(h,'basevalue',bbb_ori(end-1)-sss_ori(end-1)/2)
            hold on
            line([ori_values(1) ori_values(end)],[bbb_ori(end-1) bbb_ori(end-1)],'color',grey,'linewidth',2)
            hold on
            
            
            Y=[];
%             ordered_values=sortGivenOrder(motion_values);
            for iu=1:numel(ori_values)
                Y=[Y;bbb_ori(end)-sss_ori(end)/2 sss_ori(end)/2 sss_ori(end)/2];
            end
            h = area(ori_values,Y,-5);  
            grey2=[0.8, 0.8, 0.8];
            set(h(1),'FaceColor',grey2)
            set(h(2),'FaceColor',grey2)
            set(h(3),'FaceColor',grey2)            
            set(h,'LineStyle',':','LineWidth',0.1) % Set all to same value.
            set(h,'basevalue',bbb_ori(end)-sss_ori(end)/2)
            hold on
            alpha(.5)
            line([ori_values(1) ori_values(end)],[bbb_ori(end) bbb_ori(end)],'color',grey2,'linewidth',2);

end



conta3 = 0;
sb2 = subplot(6,6,4);
set(gca,'Position',[.24,.1,.15,.15]);


for i=1:numel(object);
            conta3 = conta3+1;    
            
            hold on; 
            her_az{i}=errorbar(azi_values,ordered_bbb_azi{i},ordered_sss_azi{i},'-O','color',COLORSET(conta3,:), 'linewidth', 1.5);
            xlabel(['Azimuth Tuning'])            
            xlim([min(azi_values)-5 max(azi_values)+5])
%             ylim([0 max(bbb_si(1:numel(size_values)))+3])
            set(gca, 'XTick', [azi_values'])
            hold on; 

            Y=[];
            for iu=1:numel(azi_values)
                Y=[Y;bbb_azi(end-1)-sss_azi(end-1)/2 sss_azi(end-1)/2 sss_azi(end-1)/2];
            end
            
            h = area(azi_values,Y,-5); % Set BaseValue via argument
            alpha(0.5);
            grey=[0.4, 0.4, 0.4];
            set(h(1),'FaceColor',grey)
            set(h(2),'FaceColor',grey)
            set(h(3),'FaceColor',grey)
            set(h,'LineStyle',':','LineWidth',0.1) % Set all to same value.
            set(h,'basevalue',bbb_azi(end-1)-sss_azi(end-1)/2)
            hold on
            line([azi_values(1) azi_values(end)],[bbb_azi(end-1) bbb_azi(end-1)],'color',grey,'linewidth',2)
            hold on
            
            
            Y=[];
%             ordered_values=sortGivenOrder(motion_values);
            for iu=1:numel(azi_values)
                Y=[Y;bbb_azi(end)-sss_azi(end)/2 sss_azi(end)/2 sss_azi(end)/2];
            end
            h = area(azi_values,Y,-5);  
            grey2=[0.8, 0.8, 0.8];
            set(h(1),'FaceColor',grey2)
            set(h(2),'FaceColor',grey2)
            set(h(3),'FaceColor',grey2)            
            set(h,'LineStyle',':','LineWidth',0.1) % Set all to same value.
            set(h,'basevalue',bbb_azi(end)-sss_azi(end)/2)
            hold on
            alpha(.5)
            line([azi_values(1) azi_values(end)],[bbb_azi(end) bbb_azi(end)],'color',grey2,'linewidth',2);

end




            rect = [.24,.8,.02,.02];
            l = legend([her_po{1},her_po{2},her_po{3},her_po{4}],{'Ent','Bunny','Orca','Pingu'});
            set (l, 'Position', rect);
%             legend([ha_s{1},ha_s{2},ha_s{3},ha_s{4}],{'Ent','Bunny','Orca','Pingu'})
            hold on;
            
clear ordered_values_po sss_si bbb_si sss_ori bbb_ori sss_azi bbb_azi sss_po bbb_po selected_bits stim ordered_bbb_po ordered_sss_po ordered_bbb_ori ordered_sss_ori ordered_bbb_si ordered_sss_si ob ordered_bbb_azi ordered_sss_azi            
            






            
%%%%%%%%%%%%%%%%
%%%%%%%%%%% BARS
%%%%%%%%%%%%%%%%
            
%% Bars Size     
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
            


        [a z]=ind2sub(size(Fede_STIM_NU), find(Fede_STIM_NU(1:342,2)==ob & Fede_STIM_NU(1:342,10)==0 & Fede_STIM_NU(1:342,9)==0 & Fede_STIM_NU(1:342,5)==0 & Fede_STIM_NU(1:342,7)==0 & Fede_STIM_NU(1:342,11)==0.250000000000000));    
        raw_bits = a';       
        selected_bits=sortGivenOrder_SizeBars(raw_bits);         
        size_values = unique(Fede_STIM_NU(selected_bits,3)); %% column 3 = size

        
        
        for z = 1:numel(size_values)  
            
        I=size_values(z);
        stim = selected_bits(z);
        sp_tr=[];
        T1=my_times{stim,nn}(1);
        T2=my_times{stim,nn}(2);

            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{stim,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{stim,oi}<(T2/1000+PRE_TIME));
            end
%             sp_tr
            BarsTuning.Size.Me{nn}(z)=mean(sp_tr)/(T2-T1)*1000;
            BarsTuning.Size.St{nn}(z)=std(sp_tr)/(T2-T1)*1000;
            BarsTuning.Size.Se{nn}(z)=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;

                bbb_si(find(size_values==I))=BarsTuning.Size.Me{nn}(z);
                sss_si(find(size_values==I))=BarsTuning.Size.Se{nn}(z);
                std_si(find(size_values==I))=BarsTuning.Size.St{nn}(z);
                %sp_tr
        end
        

                
            %% black blanks (bitcode 4 for static bblank)
            sp_tr=[];
            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{4,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{4,oi}<(T2/1000+PRE_TIME));
            end
            
            BarsTuning_BB.Size.Me{nn}=mean(sp_tr)/(T2-T1)*1000;
            BarsTuning_BB.Size.St{nn}=std(sp_tr)/(T2-T1)*1000;
            BarsTuning_BB.Size.Se{nn}=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
                bbb_si(find(size_values==I)+1)=BarsTuning_BB.Size.Me{nn};
                sss_si(find(size_values==I)+1)=BarsTuning_BB.Size.Se{nn};
                std_si(find(size_values==I)+1)=BarsTuning_BB.Size.St{nn};

%                 h(nn)=figure(nn)
                
           %% white blanks (bitcode 1 for static wblank)
            sp_tr=[];
            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{1,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{1,oi}<(T2/1000+PRE_TIME));
            end
            
            BarsTuning_WB.Size.Me{nn}=mean(sp_tr)/(T2-T1)*1000;
            BarsTuning_WB.Size.St{nn}=std(sp_tr)/(T2-T1)*1000;
            BarsTuning_WB.Size.Se{nn}=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
                bbb_si(find(size_values==I)+2)=BarsTuning_WB.Size.Me{nn};
                sss_si(find(size_values==I)+2)=BarsTuning_WB.Size.Se{nn};
                std_si(find(size_values==I)+2)=BarsTuning_WB.Size.St{nn};
                
                clear stim
% 
%                 
%            bbl_si = [bbb_si(end-1), bbb_si(end-1), bbb_si(end-1), bbb_si(end-1), bbb_si(end-1), bbb_si(end-1), bbb_si(end-1), bbb_si(end-1)];
%            wbl_si = [bbb_si(end), bbb_si(end), bbb_si(end), bbb_si(end), bbb_si(end), bbb_si(end), bbb_si(end), bbb_si(end)]; 
           
    
%% Bars position

for pos = pos_index
 
        [a z]=ind2sub(size(Fede_STIM_NU), find(Fede_STIM_NU(1:342,2)==ob & Fede_STIM_NU(1:342,13)==pos & Fede_STIM_NU(1:342,3)==35 & Fede_STIM_NU(1:342,11)==0.250000000000000 )); %& Fede_STIM_NU(1:342,5)==0 & Fede_STIM_NU(1:342,7)==0));       
        selected_bits = a';               
        if pos == 3
            pos_values = Fede_STIM_NU(selected_bits,7);
        else
            pos_values = Fede_STIM_NU(selected_bits,5); %% column 5 = x positions
        end  
        
        for z = 1:numel(pos_values)  
            I=pos_values(z);
            stim = selected_bits(z);
            sp_tr=[];
            T1=my_times{stim,nn}(1);
            T2=my_times{stim,nn}(2);  
            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{stim,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{stim,oi}<(T2/1000+PRE_TIME));
            end
%             sp_tr
            BarsTuning.Pos(pos).Me{nn}(z)=mean(sp_tr)/(T2-T1)*1000;
            BarsTuning.Pos(pos).St{nn}(z)=std(sp_tr)/(T2-T1)*1000;
            BarsTuning.Pos(pos).Se{nn}(z)=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;

                bbb_po(find(pos_values==I))=BarsTuning.Pos(pos).Me{nn}(z);
                sss_po(find(pos_values==I))=BarsTuning.Pos(pos).Se{nn}(z);
                std_po(find(pos_values==I))=BarsTuning.Pos(pos).St{nn}(z);
                %sp_tr
        end
        

                
            %% black blanks (bitcode 4 for static bblank)
            sp_tr=[];
            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{4,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{4,oi}<(T2/1000+PRE_TIME));
            end
            
            BarsTuning_BB.Pos.Me{nn}=mean(sp_tr)/(T2-T1)*1000;
            BarsTuning_BB.Pos.St{nn}=std(sp_tr)/(T2-T1)*1000;
            BarsTuning_BB.Pos.Se{nn}=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
                bbb_po(find(pos_values==I)+1)=BarsTuning_BB.Pos.Me{nn};
                sss_po(find(pos_values==I)+1)=BarsTuning_BB.Pos.Se{nn};
                std_po(find(pos_values==I)+1)=BarsTuning_BB.Pos.St{nn};

                
           %% white blanks (bitcode 1 for static wblank)
            sp_tr=[];
            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{1,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{1,oi}<(T2/1000+PRE_TIME));
            end
            
            BarsTuning_WB.Pos.Me{nn}=mean(sp_tr)/(T2-T1)*1000;
            BarsTuning_WB.Pos.St{nn}=std(sp_tr)/(T2-T1)*1000;
            BarsTuning_WB.Pos.Se{nn}=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
                bbb_po(find(pos_values==I)+2)=BarsTuning_WB.Pos.Me{nn};
                sss_po(find(pos_values==I)+2)=BarsTuning_WB.Pos.Se{nn};
                std_po(find(pos_values==I)+2)=BarsTuning_WB.Pos.Se{nn};


           
           if pos_values(1)>0
              ordered_values_po_1{pos}=sortGivenOrderPos(pos_values);
              ordered_values_po{pos}=ordered_values_po_1{pos};
              ordered_bbb_po{pos}=sortGivenOrderPos(bbb_po(1:numel(pos_values)));
              ordered_sss_po{pos}=sortGivenOrderPos(sss_po(1:numel(pos_values)));
              ordered_std_po{pos}=sortGivenOrderPos(std_po(1:numel(pos_values)));
           else
              ordered_values_po_2{pos}=pos_values';
              ordered_values_po{pos}=ordered_values_po_2{pos};
              ordered_bbb_po{pos}=bbb_po(1:numel(pos_values));
              ordered_sss_po{pos}=sss_po(1:numel(pos_values));
              ordered_std_po{pos}=std_po(1:numel(pos_values));
           end
           
            BarsTuning.Pos(pos).Me{nn}=ordered_bbb_po{pos};
            BarsTuning.Pos(pos).St{nn}=ordered_std_po{pos};
            BarsTuning.Pos(pos).Se{nn}=ordered_sss_po{pos};
            
           clear stim
        
        
end


%% Bars Orientation

        [a z]=ind2sub(size(Fede_STIM_NU), find(Fede_STIM_NU(1:342,2)==ob & Fede_STIM_NU(1:342,3)==35 & Fede_STIM_NU(1:342,11)==0.250000000000000 & Fede_STIM_NU(1:342,5)==0 & Fede_STIM_NU(1:342,7)==0));
        raw_bits = a';       
        selected_bits=sortGivenOrder_OriBars(raw_bits);       
        ori_values = unique(Fede_STIM_NU(selected_bits,10)); %% column 10 = orientations
        
        for z = 1:numel(ori_values)  
            
        I=ori_values(z);
        stim = selected_bits(z);
        sp_tr=[];
        T1=my_times{stim,nn}(1);
        T2=my_times{stim,nn}(2);

            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{stim,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{stim,oi}<(T2/1000+PRE_TIME));
            end
%             sp_tr
            BarsTuning.Ori.Me{nn}(z)=mean(sp_tr)/(T2-T1)*1000;
            BarsTuning.Ori.St{nn}(z)=std(sp_tr)/(T2-T1)*1000;
            BarsTuning.Ori.Se{nn}(z)=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;

                bbb_ori(find(ori_values==I))=BarsTuning.Ori.Me{nn}(z);
                sss_ori(find(ori_values==I))=BarsTuning.Ori.Se{nn}(z);
                std_ori(find(ori_values==I))=BarsTuning.Ori.St{nn}(z);
                %sp_tr
        end
        
        
        %% black blanks (bitcode 4 for static bblank)
            sp_tr=[];
            T1=my_times{4,nn}(1);
            T2=my_times{4,nn}(2);
            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{4,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{4,oi}<(T2/1000+PRE_TIME));
            end
            
            BarsTuning_BB.Ori.Me{nn}=mean(sp_tr)/(T2-T1)*1000;
            BarsTuning_BB.Ori.St{nn}=std(sp_tr)/(T2-T1)*1000;
            BarsTuning_BB.Ori.Se{nn}=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
                bbb_ori(find(ori_values==I)+1)=BarsTuning_BB.Ori.Me{nn};
                sss_ori(find(ori_values==I)+1)=BarsTuning_BB.Ori.Se{nn};
                std_ori(find(ori_values==I)+1)=BarsTuning_BB.Ori.St{nn};


           %% white blanks (bitcode 1 for static wblank)
            sp_tr=[];
            T1=my_times{1,nn}(1);
            T2=my_times{1,nn}(2);
            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{1,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{1,oi}<(T2/1000+PRE_TIME));
            end
            
            BarsTuning_WB.Ori.Me{nn}=mean(sp_tr)/(T2-T1)*1000;
            BarsTuning_WB.Ori.St{nn}=std(sp_tr)/(T2-T1)*1000;
            BarsTuning_WB.Ori.Se{nn}=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
                bbb_ori(find(ori_values==I)+2)=BarsTuning_WB.Ori.Me{nn};
                sss_ori(find(ori_values==I)+2)=BarsTuning_WB.Ori.Se{nn};
                std_ori(find(ori_values==I)+2)=BarsTuning_WB.Ori.St{nn};
                
                
                clear stim


end




              
              
              
%% Bars plots

sb12 = subplot(6,6,36);
set(gca,'Position',[.61,.45,.15,.15]);                
            
for i=1:numel(object2);
            conta3 = conta3+1;    
            her{i}=errorbar(size_values,bbb_si(1:numel(size_values)),sss_si(1:numel(size_values)),'-O','color',COLORSET(contami,:), 'linewidth', 1.5);
            xlabel(['Size Tuning'])            
            xlim([min(size_values)-3 max(size_values)+3])
%             ylim([0 max(bbb_si(1:numel(size_values)))+3])
            set(gca, 'XTick', [size_values'])
            hold on;
             

            Y=[];
            for iu=1:numel(size_values)
                Y=[Y;bbb_si(end-1)-sss_si(end-1)/2 sss_si(end-1)/2 sss_si(end-1)/2];
            end
            
            h = area(size_values,Y,-5); % Set BaseValue via argument
            alpha(0.5);
            grey=[0.4, 0.4, 0.4];
            set(h(1),'FaceColor',grey)
            set(h(2),'FaceColor',grey)
            set(h(3),'FaceColor',grey)
            set(h,'LineStyle',':','LineWidth',0.1) % Set all to same value.
            set(h,'basevalue',bbb_si(end-1)-sss_si(end-1)/2)
            hold on
            line([size_values(1) size_values(end)],[bbb_si(end-1) bbb_si(end-1)],'color',grey,'linewidth',2)
            hold on
            
            
            Y=[];
%             ordered_values=sortGivenOrder(motion_values);
            for iu=1:numel(size_values)
                Y=[Y;bbb_si(end)-sss_si(end)/2 sss_si(end)/2 sss_si(end)/2];
            end
            h = area(size_values,Y,-5);  
            grey2=[0.8, 0.8, 0.8];
            set(h(1),'FaceColor',grey2)
            set(h(2),'FaceColor',grey2)
            set(h(3),'FaceColor',grey2)            
            set(h,'LineStyle',':','LineWidth',0.1) % Set all to same value.
            set(h,'basevalue',bbb_si(end)-sss_si(end)/2)
            hold on
            alpha(.5)
            line([size_values(1) size_values(end)],[bbb_si(end) bbb_si(end)],'color',grey2,'linewidth',2);


end


sb8 = subplot(6,6,36)
set(gca,'Position',[.61,.21,.15,.15]);                
            
conta3 = 0;            
for i=1:numel(object2);
            conta3 = conta3+1;   
    
            her_ori{i}=errorbar(ori_values,bbb_ori(1:numel(ori_values)),sss_ori(1:numel(ori_values)),'-O','color',COLORSET(contami,:), 'linewidth', 1.5);
            xlabel(['Orientation Tuning'])            
            xlim([min(ori_values)-5 max(ori_values)+5])
%             ylim([0 max(bbb_si(1:numel(size_values)))+3])
            set(gca, 'XTick', [ori_values'])
            hold on; 

            Y=[];
            for iu=1:numel(ori_values)
                Y=[Y;bbb_ori(end-1)-sss_ori(end-1)/2 sss_ori(end-1)/2 sss_ori(end-1)/2];
            end
            
            h = area(ori_values,Y,-5); % Set BaseValue via argument
            alpha(0.5);
            grey=[0.4, 0.4, 0.4];
            set(h(1),'FaceColor',grey)
            set(h(2),'FaceColor',grey)
            set(h(3),'FaceColor',grey)
            set(h,'LineStyle',':','LineWidth',0.1) % Set all to same value.
            set(h,'basevalue',bbb_ori(end-1)-sss_ori(end-1)/2)
            hold on
            line([ori_values(1) ori_values(end)],[bbb_ori(end-1) bbb_ori(end-1)],'color',grey,'linewidth',2)
            hold on
            
            
            Y=[];
%             ordered_values=sortGivenOrder(motion_values);
            for iu=1:numel(ori_values)
                Y=[Y;bbb_ori(end)-sss_ori(end)/2 sss_ori(end)/2 sss_ori(end)/2];
            end
            h = area(ori_values,Y,-5);  
            grey2=[0.8, 0.8, 0.8];
            set(h(1),'FaceColor',grey2)
            set(h(2),'FaceColor',grey2)
            set(h(3),'FaceColor',grey2)            
            set(h,'LineStyle',':','LineWidth',0.1) % Set all to same value.
            set(h,'basevalue',bbb_ori(end)-sss_ori(end)/2)
            hold on
            alpha(.5)
            line([ori_values(1) ori_values(end)],[bbb_ori(end) bbb_ori(end)],'color',grey2,'linewidth',2);

end

          
  
for pos = 1:4
conta3 = 0;     
if pos == 1
   postype = 'DL Axis';
   sbpo = subplot(6,6,30);  %7);
   set(gca,'Position',[.42,.8,.15,.15]);
elseif pos == 2
   postype = 'DR Axis';
   sbpo = subplot(6,6,30);  %7);
   set(gca,'Position',[.42,.56,.15,.15]);
elseif pos == 3
   postype = 'Y Axis';
   sbpo = subplot(6,6,30);  %7);
   set(gca,'Position',[.42,.35,.15,.15]);
elseif pos == 4
   postype = 'X Axis';
   sbpo = subplot(6,6,30);  %7);
   set(gca,'Position',[.42,.1,.15,.15]);
end    
  
for i=1:numel(object2);
            conta3 = conta3+1;   

            xlabel(['Position Tuning, ', char(postype)])
            hold on;

            her_po{i}=errorbar(ordered_values_po{pos}, ordered_bbb_po{i,pos}, ordered_sss_po{i,pos}, my_symbols{pos},'color',COLORSET(conta3,:), 'linewidth', 1.5);
%             her{ob}=errorbar(pos_values,bbb(1:numel(pos_values)),sss(1:numel(pos_values)),'-O','color',COLORSET(contami,:)) %,)
            xlim([min(ordered_values_po{pos})-3 max(ordered_values_po{pos})+3])
            set(gca, 'XTick', [ordered_values_po{pos}])
            
            Y=[];
            for iu=1:numel(ordered_values_po{pos})
                Y=[Y;bbb_po(end-1)-sss_po(end-1)/2 sss_po(end-1)/2 sss_po(end-1)/2];
            end
            
            h = area(ordered_values_po{pos},Y,-5); % Set BaseValue via argument
            alpha(0.5);
            grey=[0.4, 0.4, 0.4];
            set(h(1),'FaceColor',grey)
            set(h(2),'FaceColor',grey)
            set(h(3),'FaceColor',grey)
            set(h,'LineStyle',':','LineWidth',0.1) % Set all to same value.
            set(h,'basevalue',bbb_po(end-1)-sss_po(end-1)/2)
            hold on
            line([ordered_values_po{pos}(1) ordered_values_po{pos}(end)],[bbb_po(end-1) bbb_po(end-1)],'color',grey,'linewidth',2)
            hold on
            
            
            Y=[];
%             ordered_values=sortGivenOrder(motion_values);
            for iu=1:numel(ordered_values_po{pos})
                Y=[Y;bbb_po(end)-sss_po(end)/2 sss_po(end)/2 sss_po(end)/2];
            end
            h = area(ordered_values_po{pos},Y,-5);  
            grey2=[0.8, 0.8, 0.8];
            set(h(1),'FaceColor',grey2)
            set(h(2),'FaceColor',grey2)
            set(h(3),'FaceColor',grey2)            
            set(h,'LineStyle',':','LineWidth',0.1) % Set all to same value.
            set(h,'basevalue',bbb_po(end)-sss_po(end)/2)
            hold on
            alpha(.5)
            line([ordered_values_po{pos}(1) ordered_values_po{pos}(end)],[bbb_po(end) bbb_po(end)],'color',grey2,'linewidth',2);
end
end


            rect = [.61,.75,.02,.02];
            l = legend([her_po{i}],'Bar');            
            set (l, 'Position', rect);
%             legend([ha_s{1},ha_s{2},ha_s{3},ha_s{4}],{'Ent','Bunny','Orca','Pingu'})
            hold on;
         
clear sss_si bbb_si sss_ori bbb_ori sss_po bbb_po selected_bits stim ordered_bbb_po ordered_sss_po ordered_bbb_ori ordered_sss_ori ordered_bbb_si ordered_sss_si ob 







%%%%%%%%%%%%%%%%
%%%%%%%%%%% GRATINGS
%%%%%%%%%%%%%%%%           
            
            
%% Gratings Orientation

    contami = 0;
    countolo=0;
    conta = 0;
    conta2 = 0;
    conta3 = 0;

for ob = object3
        T1=[];
        T2=[];
        contami=contami+1;
        contami2 = contami2+1;
        COLORSET=varycolor(numel(object3));
        
        [a z]=ind2sub(size(Fede_STIM_NU), find(Fede_STIM_NU(1:342,2)==ob & Fede_STIM_NU(1:342,11)==0.250000000000000));       
        raw_bits = a';      
        selected_bits=sortGivenOrder_OriGratings(raw_bits);
        ori_values = unique(Fede_STIM_NU(selected_bits,10)); %% column 10 = orientations
        
 
        for z = 1:numel(ori_values)  
            
        I=ori_values(z);
        stim = selected_bits(z);
        sp_tr=[];
        T1=my_times{stim,nn}(1);
        T2=my_times{stim,nn}(2);

            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{stim,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{stim,oi}<(T2/1000+PRE_TIME));
            end
%             sp_tr
            GratingsTuning.Ori(contami).Me{nn}(z)=mean(sp_tr)/(T2-T1)*1000;
            GratingsTuning.Ori(contami).St{nn}(z)=std(sp_tr)/(T2-T1)*1000;
            GratingsTuning.Ori(contami).Se{nn}(z)=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;

                bbb_ori(find(ori_values==I))=GratingsTuning.Ori(contami).Me{nn}(z);
                sss_ori(find(ori_values==I))=GratingsTuning.Ori(contami).Se{nn}(z);
                std_ori(find(ori_values==I))=GratingsTuning.Ori(contami).St{nn}(z);
                %sp_tr
        end
        

                
            %% black blanks (bitcode 4 for static bblank)
            sp_tr=[];
            T1=my_times{4,nn}(1);
            T2=my_times{4,nn}(2);
            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{4,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{4,oi}<(T2/1000+PRE_TIME));
            end
            
            GratingsTuning_BB.Ori.Me{nn}=mean(sp_tr)/(T2-T1)*1000;
            GratingsTuning_BB.Ori.St{nn}=std(sp_tr)/(T2-T1)*1000;
            GratingsTuning_BB.Ori.Se{nn}=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
                bbb_ori(find(ori_values==I)+1)=GratingsTuning_BB.Ori.Me{nn};
                sss_ori(find(ori_values==I)+1)=GratingsTuning_BB.Ori.Se{nn};
                std_ori(find(ori_values==I)+1)=GratingsTuning_BB.Ori.St{nn};

                
           %% white blanks (bitcode 1 for static wblank)
            sp_tr=[];
            T1=my_times{1,nn}(1);
            T2=my_times{1,nn}(2);
            for oi=1:size(PsthAndRaster.MySpikes, 2)
            sp_tr(oi)=sum(PsthAndRaster.MySpikes{1,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{1,oi}<(T2/1000+PRE_TIME));
            end
            
            GratingsTuning_WB.Ori.Me{nn}=mean(sp_tr)/(T2-T1)*1000;
            GratingsTuning_WB.Ori.St{nn}=std(sp_tr)/(T2-T1)*1000;
            GratingsTuning_WB.Ori.Se{nn}=std(sp_tr)/sqrt(numel(sp_tr))/(T2-T1)*1000;
                bbb_ori(find(ori_values==I)+2)=GratingsTuning_WB.Ori.Me{nn};
                sss_ori(find(ori_values==I)+2)=GratingsTuning_WB.Ori.Se{nn};
                std_ori(find(ori_values==I)+2)=GratingsTuning_WB.Ori.St{nn};

        
               ordered_bbb_ori{contami}=bbb_ori(1:numel(ori_values));
               ordered_sss_ori{contami}=sss_ori(1:numel(ori_values)); 
               ordered_std_ori{contami}=std_ori(1:numel(ori_values)); 
               
               
            GratingsTuning.Ori(contami).Me{nn}=ordered_bbb_ori{contami};
            GratingsTuning.Ori(contami).St{nn}=ordered_std_ori{contami};
            GratingsTuning.Ori(contami).Se{nn}=ordered_sss_ori{contami};
            
end




%% Gratings Plots

sb5 = subplot(6,6,30)
set(gca,'Position',[.78,.8,.15,.15]);                
            
conta3 = 0;            
for i=1:numel(object3);
            conta3 = conta3+1;   

            her_ori{i}=errorbar(ori_values,ordered_bbb_ori{i},ordered_sss_ori{i},'-O','color',COLORSET(conta3,:), 'linewidth', 1.5)
            xlabel(['Orientation Tuning'])            
            xlim([min(ori_values)-5 max(ori_values)+5])
%             ylim([0 max(bbb_si(1:numel(size_values)))+3])
            set(gca, 'XTick', [ori_values'])
            hold on; 
            
            Y=[];
%             ordered_values=sortGivenOrder(motion_values);
            for iu=1:numel(ori_values)
                Y=[Y;bbb_ori(end-1)-sss_ori(end-1)/2 sss_ori(end-1)/2 sss_ori(end-1)/2];
            end
%             
            h = area(ori_values,Y,-5); % Set BaseValue via argument
            grey=[0.4, 0.4, 0.4];
            set(h(1),'FaceColor',grey)
            set(h(2),'FaceColor',grey)
            set(h(3),'FaceColor',grey)
            
            set(h,'LineStyle',':','LineWidth',0.1) % Set all to same value.
            set(h,'basevalue',bbb_ori(end-1)-sss_ori(end-1)/2)
            hold on
            alpha(.5)
            line([ori_values(1) ori_values(end)],[bbb_ori(end-1) bbb_ori(end-1)],'color',grey,'linewidth',2)
            
            hold on
            
            Y=[];
%             ordered_values=sortGivenOrder(motion_values);
            for iu=1:numel(ori_values)
                Y=[Y;bbb_ori(end)-sss_ori(end)/2 sss_ori(end)/2 sss_ori(end)/2];
            end
%             
            h = area(ori_values,Y,-5); % Set BaseValue via argument
            grey2=[0.8, 0.8, 0.8];
            set(h(1),'FaceColor',grey2)
            set(h(2),'FaceColor',grey2)
            set(h(3),'FaceColor',grey2)
            
            set(h,'LineStyle',':','LineWidth',0.1) % Set all to same value.
            set(h,'basevalue',bbb_ori(end)-sss_ori(end)/2)
            hold on
            alpha(.5)
            line([ori_values(1) ori_values(end)],[bbb_ori(end) bbb_ori(end)],'color',grey2,'linewidth',2)
            
end

            rect = [.85,.68,.02,.02];
            l = legend([her_ori{1},her_ori{2},her_ori{3},her_ori{4}],{'SF 0.03','SF 0.05','SF 0.1','SF 0.4'});
            set (l, 'Position', rect);
%             legend([ha_s{1},ha_s{2},ha_s{3},ha_s{4}],{'Ent','Bunny','Orca','Pingu'})
            hold on;

            
            sb17 = subplot(6,6,30) 
            set(gca,'Position',[.78,.4,.18,.18]);
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
            
            
            
            sb18 = subplot(6,6,36);
            set(gca,'Position',[.78,.1,.18,.18]);
%             x = -200:25:2200;
            hist(onsets, 25);
            xlabel(['Stimulus Onset'])
            
            
            set (gcf, 'NextPlot', 'add');
            axes;
            h = suptitle(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);
            set(gca, 'Visible', 'off');
            set(h, 'Visible', 'on', 'FontSize', 15); 
            
            
            ww = cd;
            cd(['TUNING']); 
            export_fig (['StaticTuning_',num2str(nn), '.png'])
%             close all
            clear onsets
            
            cd ..


            
            
end           

% ww=cd;            

% save([ww,'/TUNING_NEW/StaticTuning_NEW.mat'], 'ObjectsTuning', 'ObjectsTuning_BB', 'ObjectsTuning_WB', 'BarsTuning', 'BarsTuning_BB', 'BarsTuning_WB', 'GratingsTuning', 'GratingsTuning_BB', 'GratingsTuning_WB', '-v7.3');

end
