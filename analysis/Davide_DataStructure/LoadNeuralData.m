% ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
%
%             LoadNeuralData( filename, NstimToSkip )
%         
% ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
%
%   This function will load a DLab data file with neuronal recordings and
%   will fill in a structure (Stim) with all the info (spike times, etc...)
%   related to the stimuli presented during the protocol.
%
% Input parameters:
% 		1) filename: name of the DLab data file to analyze (without extension!!)
%       2) NstimToSkip: number of stimuli to skip in the Head
%
%   ES:     >> Stim = LoadNeuralData( filename, NstimToSkip );
%
%   Author: davide
%   date: 3/8/2004
%
% ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл



function  [Stim, Nmorph, NStimInmorph, MinNpres] = LoadNeuralData( filename, NstimToSkip, StartSpkWind, EndSpkWind )

% Load data file
c = LoadDLabDataFile( filename );

% ##########################################################################
% 							COMPUTING SECTION
% ##########################################################################

% Number of trials in the data file
NTrials = length(c.t);
disp( ['Number of trials in the current file = ', num2str(NTrials)] );

% ***************************************************************
% Set the analysis parameters according to the current protocol
% ***************************************************************
switch c.protocol
    case 15
      disp( 'File recorded with the protocol: TEST CLASS' );
    case 16
      disp( 'File recorded with the protocol: RAW SHAPE TUNING' );
    case 17
      disp( 'File recorded with the protocol: MAP RECEPTIVE FIELD' );
    case 18
      disp( 'File recorded with the protocol: FINE SHAPE TUNING and CLUTTER INTERFERENCE' );
  otherwise
      disp('Unknown PROTOCOL');
end;

% ***********************************************
% Initialize the structure with the stim info
% ***********************************************
for i=1:NTrials
    % Number of stimuli presented during the current trial    
    NStimInTrial = c.t{i}.NumStimPres;
    if( NStimInTrial ~= 0 )
        for j=1:NStimInTrial
            % ID (index) of the current stimulus
            IDCurrStim = c.t{i}.stimOnOff(j).params.formID;
            % Fixed infos about each stimulus
            Stim{IDCurrStim}.SpaceName = c.t{i}.morphStimInfo(j).params.SpaceName;
            Stim{IDCurrStim}.proto = c.t{i}.morphStimInfo(j).params.proto;
            Stim{IDCurrStim}.idxStim = c.t{i}.morphStimInfo(j).params.idxStim;
            Stim{IDCurrStim}.distStim = c.t{i}.morphStimInfo(j).params.distStim;
            % Num of presentations of the current stimulus initialized to 0
            Stim{IDCurrStim}.Npres = 0;
        end; %for j
    end; %if
end; %for i

Nstim = length(Stim);
disp( ['Total number of stimulus types presented = ', num2str(Nstim)] );
        
% ***************************************************
% Fill in the infos with times of spikes and stimuli 
% ***************************************************
for i=1:NTrials
    % Number of stimuli presented during the current trial    
    NStimInTrial = c.t{i}.NumStimPres;
    
    % Find the valid stimuli in the sequence (skip the HEAD and check for
    % BROKE sequence with final incomplete stimulus presentation)
    StartStim = NstimToSkip+1;
    if( c.t{i}.eotCode == 0 )
        EndStim = NStimInTrial;
    else
        EndStim = NStimInTrial-1;
    end; %if
    % Vector containing all the spikes of the current trial
    SpikeTimes = c.t{i}.electrode1.spikes.time_ms;
    
    for j=StartStim:EndStim
        % ID (index) of the current stimulus
        IDCurrStim = c.t{i}.stimOnOff(j).params.formID;
        % Update the number of presentations of the current stimulus 
        Stim{IDCurrStim}.Npres = Stim{IDCurrStim}.Npres + 1;
        % This is a local vector used to compute the minimum of Npres
        Npres(IDCurrStim) = Stim{IDCurrStim}.Npres;
        % Timing and position of the stimulus
        Stim{IDCurrStim}.times{Stim{IDCurrStim}.Npres} = c.t{i}.stimOnOff(j).times;
        Stim{IDCurrStim}.position.DegsH = c.t{i}.stimOnOff(j).params.position.DegsH;
        Stim{IDCurrStim}.position.DegsV = c.t{i}.stimOnOff(j).params.position.DegsV;
        
        % Find the spikes in the interval [-100 400] ms with 0 centered on
        % the stimulus onset
        I_spk = find(SpikeTimes >= Stim{IDCurrStim}.times{Stim{IDCurrStim}.Npres}(1)-StartSpkWind & ...
            SpikeTimes <= Stim{IDCurrStim}.times{Stim{IDCurrStim}.Npres}(1)+EndSpkWind);
        % NOTE: the spike times are saved as RELATIVE to the stimulus ONSET
        Stim{IDCurrStim}.SpikeTimes{Stim{IDCurrStim}.Npres} = SpikeTimes(I_spk) - ...
            Stim{IDCurrStim}.times{Stim{IDCurrStim}.Npres}(1);        
    end; %for j
end; %for i

% *************************************************************************
% Count how many morphlines and how many stimuli per morphlines have been
% used in the current protocol
% *************************************************************************
NStimInmorph = 1;
Nmorph = 1;
for i=2:Nstim-1            
    if( Stim{i}.proto == Stim{i+1}.proto )
        NStimInmorph = NStimInmorph+1;
    else
        NStimInmorph = 1;
        Nmorph = Nmorph+1;
    end; %if
    
    %disp(['Stimulus # ', num2str(i), ' presented ', num2str(Stim{i}.Npres), ' times']);
end; %for i
NStimInmorph = NStimInmorph+1;
disp(['Number of morphlines = ', num2str(Nmorph)]);
disp(['Number of stimuli per morphline = ', num2str(NStimInmorph)]);
MinNpres = min(Npres);



