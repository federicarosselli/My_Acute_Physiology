function My_Modulation_Index (DayOfRecording, Block)

% DayOfRecording = '02_07_2013'
% Block = 12

Bcodes_fast_gr = [168, 170, 172, 174, 176, 178, 180, 182, 184, 186, 188, 190, 192, 194, 196, 198, 200, 202, 204, 206, ...
    208, 210, 212, 214, 216, 218, 220, 222, 224, 226, 228, 230];


% objectS = [-1, 0, 1, 2, 3, 4, 9, 11, 22, 111, 222, 333, 444];
objectS = [111, 222, 333, 444];

my_folder = ['/zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_', char(DayOfRecording), '/ANALYSED/BlockS-', num2str(Block), '/BL_2/My_Structure/1'];

addpath /zocconasphys1/chronic_inv_rec/codes/
load My_StimS_NUANGLE_NUCONDITIONS



cd (my_folder)

files = dir(fullfile('*.mat'));
neuronS = (numel(files))/2;

cd RASTERS
load PeaksnTimes

s_frequency = 24414.0625;
n_samples = size(all_time_series{1,1}, 2);
resolution_Hz = s_frequency/n_samples;
bin_size = 0.001;
fpsth = 1/bin_size;
T_static = 0.25;
T_fast = 0.8;
T_slow = 2;


cd ..

mkdir ('FOURIER');



COLORSET=varycolor(neuronS);
% my_fft_coefficients = cell(zeros());
my_fft_coefficients_NU = cell(zeros());
my_backgrounds_NU = cell(zeros());
my_F0s_NU = cell(zeros());
my_fft_noasbcoefficients_NU = cell(zeros());
% my_fft_coefficients_noabs = cell(zeros());


for nn = 1:neuronS
    countolos=0;
        
    load(['PSTH_RASTER_', num2str(nn),'.mat'])
    load(['NEURON_', num2str(nn),'.mat'])
%     bitcodes = PsthAndRaster.BitCodes;
    bin=PsthAndRaster.BinSize; 
    
    ww = cd;
    

        for ob = objectS
            countolo=0;
            countolos=countolos+1;
        
            for BIT_Number = Bcodes_fast_gr; %selected_bits;

                countolo=countolo+1;
%                 figure(countolo);
% 
                T=linspace(-200,1000,size(PsthAndRaster.Psth{BIT_Number,nn},2));
                [int tm]=min(abs(T));
                a =find(T>800);
                tm2 = a(1);
%                 [int tm]=min(abs(T-400));
                Tlin = T(tm:tm2);
%                 Tlin = T;
                blin = all_time_series{BIT_Number,nn}(tm:tm2);           
                my_signal = blin;
                my_bkg = all_time_series{BIT_Number,nn}(1:tm);
                a = my_signal;
                
                my_bkg(my_bkg==0)=[];
                a (a==0) = [];
                
                bkg = mean(my_bkg);
                F0 = (mean(a))-bkg;
                my_fft =  fft(my_signal,801);
                Pyy = abs(my_fft);
                Pyy2 = my_fft.*conj(my_fft)/801;
                mx = Pyy;
%                 mx = abs(my_fft);
%                 f = 1000/801*(0:402);
%                 my_fft =  my_fft(1/T_fast:fpsth/2);
%                 mx = abs(my_fft);
%                 t=0:0.001:0.8;
%                 L = length(my_signal);
%                 F = (T_fast/2*linspace(0,1, L/2+1));
                
                    
                    
%                     subplot(2,1,1)   
%                     plot(Tlin, blin,'Color', COLORSET(nn,:), 'linewidth',1)  
%                     xlim([0 800])
%                     hold on
%                     subplot(2,1,2)
%                     plot(Pyy(1:200), 'Color', COLORSET(nn,:), 'linewidth',1)
%                     hold on
%                     plot(Pyy2(1:200), 'Color', 'k', 'linewidth',1)
% %                     plot(f(1:200), Pyy(1:200), 'Color', COLORSET(nn,:), 'linewidth',1)
% %                     plot(f, mx(1:401), 'Color', COLORSET(nn,:), 'linewidth',1)
% %                     xlim([0 max(f)])
% %                     ylim([0 max(mx)])
% %                     ylim([0 max(Pyy)])
%                     hold on
%                     title(['Neuron ', num2str(nn), ', Channel ',num2str(My_Neurons.Channel), ', Area ', char(My_Neurons.Area)]);
%                 
                    my_fft_coefficients_NU{countolo,nn}(countolos) = mx;
                    my_fft_noasbcoefficients_NU{countolo,nn}(countolos) = Pyy2;
                    my_backgrounds_NU{countolo,nn}(countolos) = bkg;
                    my_F0s_NU{countolo,nn}(countolos) = F0;
                    
%                     my_fft_coefficients_noabs{BIT_Number,nn} = my_fft;

%             saveas(gcf,[ww,'/FOURIER/', num2str(nn), '_FastGrating_',num2str(BIT_Number),'.png']) 
%             saveas(gcf,[ww,'/FOURIER/', num2str(nn), '_', char(stimidentity), '_',num2str(BIT_Number),'.fig'])
%             close
            clear Tlin blin my_fft F L my_signal Pyy f bkg F0 a my_bkg Pyy2 mx
            
            end
            
        end
        
        save([ww,'/FOURIER/Coefficients_NU.mat'], 'my_fft_coefficients_NU', 'my_fft_noasbcoefficients_NU', 'my_backgrounds_NU', 'my_F0s_NU', '-v7.3');        
%         save([ww,'/FOURIER/Coefficients.mat'], 'my_fft_coefficients', '-v7.3');
%         save([ww,'/FOURIER/Coefficients_noabs.mat'], 'my_fft_coefficients_noabs', '-v7.3');

end
            

    