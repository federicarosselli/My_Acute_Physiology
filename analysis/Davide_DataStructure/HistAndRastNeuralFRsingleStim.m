% ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
%
%             HistAndRastNeuralFRsingleStim( filename )
%         
% ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
%
%   This function will compute the histograms with the AFR of the neuron
%   recorded during presentation of different stimuli. The stimuli belong
%   to morphed spaces. The plot will be organized on the bas eof the
%   recorded protocol
%
% Input parameters:
% 		1) filename: name of the DLab data file to analyze (without extension!!)
%
%   ES:     >> HistAndRastNeuralFRsingleStim('DMAFC01', 1, 25 )
%
%   Author: davide
%   date: 3/8/2004
%
% ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл


function  HistAndRastNeuralFRsingleStim( filename, Stim2plot, BinSize )

% Some parameters
NMaxMorphLines = 15;
% Number of stimuli to skip on the HEAD of each stimulus sequence
NstimToSkip = 3;
% Extremes of the window in which the spikes related to each stimulus (stim
% time = 0) are considered
StartSpkWind = 100;     % this is subtracted
EndSpkWind = 500;       % this is added

% Call the function that fill in the structure with the stimulus related
% events
Stim = LoadNeuralData( filename, NstimToSkip, StartSpkWind, EndSpkWind );
Nstim = length(Stim);

% Color map for the traces
map = jet(64);
%map = map([1:35,46:64],:);								% Mappa senza gialli
[r,col] = size(map);
passo = floor( r / (NMaxMorphLines) );
map = map(1:passo:r,:);									% Mappa con NSectors righe
%size(map);

% ##########################################################################
% 							COMPUTING SECTION
% ##########################################################################
figure;

for i=1:Nstim
    %disp(['Stimulus # ', num2str(i), ' presented ', num2str(Stim{i}.Npres), ' times']);
    
    AllTimes = [];
    if ( Stim2plot == i )
        
		% ************************
		% 	Figura RASTER PLOT 
		% ************************
		disp('Start processing FIGURE with RASTER PLOT ...');
        h_rast = subplot(2,1,2);
        % Il raster plot e' disegnato utilizzando la funzione errorbar!
        RastShift = 0.5;
        
        for j=1:Stim{i}.Npres
            Nspikes = length( Stim{i}.SpikeTimes{j} );
            %disp(['Number of identified spikes = ', num2str(Nspikes)]);
            % Lenght of the lines in the raster
            LineRast = zeros(1,Nspikes);
            LineRast(1:Nspikes) = 0.5;
            Rast = zeros(1,Nspikes);
            Rast(1:Nspikes) = RastShift;
            % Draw the raster plot for the current presentation
            h_err = errorbar(Stim{i}.SpikeTimes{j}, Rast, LineRast );
            delete(h_err(2));
            RastShift = RastShift+1;
            hold on;
            
            % Build a vector with the spikes across ALL PRESENTATIONS
            AllTimes = [AllTimes,Stim{i}.SpikeTimes{j}];
        end; %for j
        set( h_rast, 'XLim', [-StartSpkWind-BinSize EndSpkWind] );

		% *****************************
		% 	Figura HISTOGRAM with AFR 
		% *****************************
		disp('Start processing FIGURE with AFR ...');
        h_AFR = subplot(2,1,1);
        TimeBins = -StartSpkWind+(BinSize/2):BinSize:EndSpkWind-(BinSize/2);
        Nspikes = hist( AllTimes, TimeBins ); 
        AvFireRate = (Nspikes/Stim{i}.Npres)/(BinSize/1000);
        bar( TimeBins, AvFireRate );
        set( h_AFR, 'XLim', [-StartSpkWind-BinSize EndSpkWind] );
        xlabel('Time (ms)');
        ylabel( 'Average Firing Rate (Hz)' );
        
    end; %if
    
end; %for i



        
        
        
        
        

