%%%%%% MY FIRING RATES SAME WIND TUNING INFO PRESERVED
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
clc
close all

DayOfRecording = '10_12_2013';
Block=1011;

my_folder = ['/zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_', char(DayOfRecording), '/ANALYSED/BlockS-', num2str(Block), '/BL_2/My_Structure/25'];
% my_folder = ['/zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_', , char(DayOfRecording), '/ANALYSED/Block-' , num2str(Block), '/My_Structure/25'];

addpath /zocconasphys1/chronic_inv_rec/codes/
% addpath /zocconasphys1/chronic_inv_rec/codes/export_fig
load My_StimS_NUANGLE_NUCONDITIONS

% Cool_Psths
% neuronS = BlockS_56;   %%% >>>>>>> optimize!!!


cd (my_folder)

files = dir(fullfile('*.mat'));
neuronS = (numel(files))/2;

cd WINDOWS
load Windows_2
cd ..

mkdir(['SCATTERS/'])

my_times = Window;
clear Window

T1_test = 250;
f_T2_test = 800;
% s_T2_test = 2000;
s_T2_test = 800;

% object = [1, 2, 3, 4];
% object2 = [-1];
object3 = [111,222,333,444];
object4 = [11,22];

% object = [-1, 0, 1, 2, 3, 4, 9, 11, 22, 111, 222, 333, 444];
% COLORSET=varycolor(object);
T1_All = [];
T2_All = [];
% global nn
% global my_bits

blue_1 = [0, 1, 1];
blue_2 = [0, .8, 1];
blue_3 = [0, .6, 1];
blue_4 = [0, .4, 1];

red_1 = [0, 1, .2];
red_2 = [0, .6, .2];

my_reds = [red_1; red_2];
my_blues = [blue_1; blue_2; blue_3; blue_4];


for nn = 1:neuronS
    countolo=0;
    conta = 0;
    conta2 = 0;
    conta3 = 0;

        
    load(['PSTH_RASTER_', num2str(nn),'.mat'])
    load(['NEURON_', num2str(nn),'.mat'])


%% Gratings 
    %% Fast FR
            contami = 0;
            countolo=0;
            conta = 0;
            conta2 = 0;
            conta3 = 0;
            FRGr_All_f = [];
            FRGr_All_s = [];

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


                [a z]=ind2sub(size(Fede_STIM_NU), find(Fede_STIM_NU(1:342,2)==ob & Fede_STIM_NU(1:342,11)==0.763100000000000));       
                selected_bits = a';       


                for z = 1:numel(selected_bits)  

                    stim = selected_bits(z);
                    sp_tr=[];
                    T1=T1_test;
                    T2=f_T2_test;
        %         T1=my_times{stim,nn}(1);
        %         T2=my_times{stim,nn}(2);

                    for oi=1:size(PsthAndRaster.MySpikes, 2) %num trials
%                     sp_tr(oi)=sum(PsthAndRaster.MySpikes{stim,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{stim,oi}<(T2/1000+PRE_TIME));
                        sp_tr(oi)=sum(PsthAndRaster.MySpikes{stim,oi}>(T1/1000) & PsthAndRaster.MySpikes{stim,oi}<(T2/1000));
                    end
                    
                    FRGr_All_f = [FRGr_All_f,sp_tr];
                                          
                end
                
                FRGratings.Fast(nn).Me(contami)=mean(FRGr_All_f)/(T2-T1)*1000;
                FRGratings.Fast(nn).St(contami)=std(FRGr_All_f)/(T2-T1)*1000;
                FRGratings.Fast(nn).Se(contami)=std(FRGr_All_f)/sqrt(numel(FRGr_All_f))/(T2-T1)*1000;



                    

         %% Slow FR

                [a z]=ind2sub(size(Fede_STIM_NU), find(Fede_STIM_NU(1:342,2)==ob & Fede_STIM_NU(1:342,11)==1.984000000000000));       
                selected_bits = a';       

                for z = 1:numel(selected_bits)  

                    stim = selected_bits(z);
                    sp_tr=[];
                    T1=T1_test;
                    T2=f_T2_test;
        %         T1=my_times{stim,nn}(1);
        %         T2=my_times{stim,nn}(2);

                    for oi=1:size(PsthAndRaster.MySpikes, 2) %num trials
%                     sp_tr(oi)=sum(PsthAndRaster.MySpikes{stim,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{stim,oi}<(T2/1000+PRE_TIME));
                        sp_tr(oi)=sum(PsthAndRaster.MySpikes{stim,oi}>(T1/1000) & PsthAndRaster.MySpikes{stim,oi}<(T2/1000));
                    end
                    
                    FRGr_All_s = [FRGr_All_s,sp_tr];
                                          
                end
                
                FRGratings.Slow(nn).Me(contami)=mean(FRGr_All_s)/(T2-T1)*1000;
                FRGratings.Slow(nn).St(contami)=std(FRGr_All_s)/(T2-T1)*1000;
                FRGratings.Slow(nn).Se(contami)=std(FRGr_All_s)/sqrt(numel(FRGr_All_s))/(T2-T1)*1000;




        end
        

%% Dots
    %% Fast FR
            contami = 0;
            countolo=0;
            conta = 0;
            conta2 = 0;
            conta3 = 0;
            FRDo_All_f = [];
            FRDo_All_s = [];

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
                



                for z = 1:numel(selected_bits)  

                    stim = selected_bits(z);
                    sp_tr=[];
                    T1=T1_test;
                    T2=f_T2_test;
        %         T1=my_times{stim,nn}(1);
        %         T2=my_times{stim,nn}(2);

                    for oi=1:size(PsthAndRaster.MySpikes, 2) %num trials
%                     sp_tr(oi)=sum(PsthAndRaster.MySpikes{stim,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{stim,oi}<(T2/1000+PRE_TIME));
                        sp_tr(oi)=sum(PsthAndRaster.MySpikes{stim,oi}>(T1/1000) & PsthAndRaster.MySpikes{stim,oi}<(T2/1000));
                    end
                    
                    FRDo_All_f = [FRDo_All_f,sp_tr];
                                          
                end
                
                FRDots.Fast(nn).Me(contami)=mean(FRDo_All_f)/(T2-T1)*1000;
                FRDots.Fast(nn).St(contami)=std(FRDo_All_f)/(T2-T1)*1000;
                FRDots.Fast(nn).Se(contami)=std(FRDo_All_f)/sqrt(numel(FRDo_All_f))/(T2-T1)*1000;


         %% Slow Motion Tuning

                [a z]=ind2sub(size(Fede_STIM_NU), find(Fede_STIM_NU(1:342,2)==ob & Fede_STIM_NU(1:342,11)==1.984000000000000));       
                selected_bits = a';       

                for z = 1:numel(selected_bits)  

                    stim = selected_bits(z);
                    sp_tr=[];
                    T1=T1_test;
                    T2=f_T2_test;
        %         T1=my_times{stim,nn}(1);
        %         T2=my_times{stim,nn}(2);

                    for oi=1:size(PsthAndRaster.MySpikes, 2) %num trials
%                     sp_tr(oi)=sum(PsthAndRaster.MySpikes{stim,oi}>(T1/1000+PRE_TIME) & PsthAndRaster.MySpikes{stim,oi}<(T2/1000+PRE_TIME));
                        sp_tr(oi)=sum(PsthAndRaster.MySpikes{stim,oi}>(T1/1000) & PsthAndRaster.MySpikes{stim,oi}<(T2/1000));
                    end
                    
                    FRDo_All_s = [FRDo_All_s,sp_tr];
                                          
                end
                
                FRDots.Slow(nn).Me(contami)=mean(FRDo_All_s)/(T2-T1)*1000;
                FRDots.Slow(nn).St(contami)=std(FRDo_All_s)/(T2-T1)*1000;
                FRDots.Slow(nn).Se(contami)=std(FRDo_All_s)/sqrt(numel(FRDo_All_s))/(T2-T1)*1000;




        end

%         allvalues =[ordered_bbb_f{1,:}, ordered_bbb_s{1,:}, bbl_f, bbl_s, wbl_f, wbl_s];        
        
        
        
end           

ww = cd;        
save([ww,'/SCATTERS/FiringRates_samewind.mat'], 'FRGratings', 'FRDots','-v7.3');
        
