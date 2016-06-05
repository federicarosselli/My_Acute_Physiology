% ######################################################################################################################
%
%             Bub_ExtractRatBehavData_General_Mex
%         
% ######################################################################################################################
%
%
%   This function extracts relevant behavioral paremeters directly from a MW file and save these paremeters in a file
%   with summary data of the form 'r1_b043_extr.mat'. 
%
%   ARGUMENTS:
%       - FileName: name of the monkey work (".mwk") raw data file
%       - ThLickSensor: threshold to decide when a response has been made on a sensor. NOTE: with the ITC18 at MIT, this
%           threshold used to be  = 2.5. With the new I/O used at Rowland it is = 500
%
%   LEGACY:
%   _v2: It deals also with the staircase across ROTATIONS
%   _v3:
%   _v4: fix the following bug: if the stimulus was removed after the response, this function was not able to find the
%       outcome of the trial when the trial was successfull. As a consequence, all trials in which the animals made a
%       response after the stimulus disappeared were erroneously considered as TooFast.
%   _General: the function was modified to process the data collected with the new version MW (0.3.1a) using the two new
%       rats D1 and D2 (i.e., using the new blob stimuli). The function is now part of the repository.
%   _General_Multi: the function was modified to deal with multiple unpacked .mat files of the form "_out0.mat",
%       "_out1.mat", etc
%   _General_Mex: this version uses two mex matlab functions (getCodecs and getEvents) to read out directly the MW
%       files, without the need of unpack first the MW into a mat file using the apposite application "mw2ml" 
%
%   example:
%
%       >> Bub_ExtractRatBehavData_General_Mex('r_ad1_b043.mwk', 500)
%       >> Bub_ExtractRatBehavData_General_Mex('r_d1_b058.mwk', 2.5)
%
% ######################################################################################################################
   

function CHRONIC_ExtractRatBehavData( FileName, ThLickSensor )



% =============== Initialize structure with general infos about the behavioral session ================
Gen.Stair.FlagSize.Times = [];
Gen.Stair.FlagSize.Data = [];
Gen.Stair.FlagPosHR.Times = [];
Gen.Stair.FlagPosHR.Data = [];
Gen.Stair.FlagPosHL.Times = [];
Gen.Stair.FlagPosHL.Data = [];
Gen.Stair.FlagPosVU.Times = [];
Gen.Stair.FlagPosVU.Data = [];
Gen.Stair.FlagPosVD.Times = [];
Gen.Stair.FlagPosVD.Data = [];
Gen.Stair.FlagRotCW.Times = [];
Gen.Stair.FlagRotCW.Data = [];
Gen.Stair.FlagRotACW.Times = [];
Gen.Stair.FlagRotACW.Data = [];
Gen.Stair.FlagRotDepR.Times = [];
Gen.Stair.FlagRotDepR.Data = [];
Gen.Stair.FlagRotDepL.Times = [];
Gen.Stair.FlagRotDepL.Data = [];


Gen.Stair.N_sizes_current.Times = [];
Gen.Stair.N_sizes_current.Data = [];
Gen.Stair.N_PosHR_current.Times = [];
Gen.Stair.N_PosHR_current.Data = [];
Gen.Stair.N_PosHL_current.Times = [];
Gen.Stair.N_PosHL_current.Data = [];
Gen.Stair.N_PosVU_current.Times = [];
Gen.Stair.N_PosVU_current.Data = [];
Gen.Stair.N_PosVD_current.Times = [];
Gen.Stair.N_PosVD_current.Data = [];
Gen.Stair.N_RotCW_current.Times = [];
Gen.Stair.N_RotCW_current.Data = [];
Gen.Stair.N_RotACW_current.Times = [];
Gen.Stair.N_RotACW_current.Data = [];
Gen.Stair.N_RotDepR_current.Times = [];
Gen.Stair.N_RotDepR_current.Data = [];
Gen.Stair.N_RotDepL_current.Times = [];
Gen.Stair.N_RotDepL_current.Data = [];


% Default values of stimulus properties
Gen.Stair.Default_size = [];
Gen.Stair.Default_size_for_StairPosition = [];
Gen.Stair.Default_size_for_StairRotation = [];
Gen.Stair.Default_size_for_StairRotation_InPlane = [];
Gen.Stair.Default_PosH = [];
Gen.Stair.Default_PosV = [];
Gen.Stair.Default_PosV_for_StairRotation_InPlane = [];
Gen.Stair.Default_Rotation = [];
Gen.Stair.Default_Rotation_in_Depth = [];


Gen.Flag.FlagCueStimSound.Times = [];
Gen.Flag.FlagCueStimSound.Data = [];

Gen.MaxN_IdenticalStims.Times = [];
Gen.MaxN_IdenticalStims.Data = [];

% Intilaize codes of events
Code.Stair.FlagSize = nan; 
Code.Stair.FlagPosHR = nan;
Code.Stair.FlagPosHL = nan;
Code.Stair.FlagPosVU = nan;
Code.Stair.FlagPosVD = nan;
Code.Stair.FlagRotCW = nan;
Code.Stair.FlagRotACW = nan;
Code.Stair.FlagRotDepR = nan;
Code.Stair.FlagRotDepL = nan;
Code.Stair.N_sizes_current = nan;
Code.Stair.N_PosHR_current = nan;
Code.Stair.N_PosHL_current = nan;
Code.Stair.N_PosVU_current = nan;
Code.Stair.N_PosVD_current = nan;
Code.Stair.N_RotCW_current = nan;
Code.Stair.N_RotACW_current = nan;
Code.Stair.N_RotDepR_current = nan;
Code.Stair.N_RotDepL_current = nan;
Code.Stair.CurrTrial = nan;
Code.current_limit_stair.Size = nan;
Code.current_limit_stair.PosHR = nan;
Code.current_limit_stair.PosHL = nan;
Code.current_limit_stair.PosVU = nan;
Code.current_limit_stair.PosVD = nan;
Code.current_limit_stair.RotCW = nan;
Code.current_limit_stair.RotACW = nan;
Code.current_limit_stair.RotDepR = nan;
Code.current_limit_stair.RotDepL = nan;
Code.Watch.SuccessStairSize = nan;
Code.Watch.SuccessStairPosHR = nan;
Code.Watch.SuccessStairPosHL = nan;
Code.Watch.SuccessStairPosVU = nan;
Code.Watch.SuccessStairPosVD = nan;
Code.Watch.SuccessStairRotCW = nan;
Code.Watch.SuccessStairRotACW = nan;
Code.Watch.SuccessStairRotDepR = nan;
Code.Watch.SuccessStairRotDepL = nan;
Code.Announce.StimOn = nan;
Code.Announce.AcqPort1 = nan;
Code.Announce.AcqPort3 = nan;
Code.Announce.Stim = nan;
Code.Announce.CurrState = nan;
Code.Announce.Sound = nan;
Code.outcome.success = nan;
Code.outcome.failure = nan;
Code.outcome.ignore = nan;
Code.lick.input1 = nan;
Code.lick.input3 = nan;
Code.lick.output1 = nan;
Code.lick.output3 = nan;
Code.lick.thresh = nan;
Code.Stim.size = nan;
Code.Stim.pos_x = nan;
Code.Stim.pos_y = nan;
Code.Stim.rot = nan;
Code.Stim.rot_depth = nan;
Code.Stim.morph = nan;
Code.Stim.MaxN_IdenticalStims = nan;
Code.Stim.bstimnum = nan;
Code.Stim.bcond = nan;
Code.Stim.bnum = nan;
Code.Flag.MatchCurrStairTrial = nan;
Code.Flag.FlagCueStimSound = nan;
Code.Stair.Default_size = nan;
Code.Stair.Default_size_for_StairPosition = nan;
Code.Stair.Default_size_for_StairRotation = nan;
Code.Stair.Default_size_for_StairRotation_InPlane = nan;
Code.Stair.Default_PosH = nan;
Code.Stair.Default_PosV = nan;
Code.Stair.Default_PosV_for_StairRotation_InPlane = nan;
Code.Stair.Default_Rotation = nan;
Code.Stair.Default_Rotation_in_Depth = nan;
Code.BiasControl.FlagShowStimRight = nan;
Code.BiasControl.FlagShowStimLeft = nan;

% ===================== Read the MW data file ========================
    
% -------------- Find codes of relevat variables ---------------------
disp(' ');
disp(['Read CODES from data file: ', FileName]);
c = getCodecs( FileName );

% Since multiple codecs may have been issued (the client may have been closed or may have crashed and then may have 
% reconnected, receiving back the codec from the server, or data from different experiments may have been recorded in
% the same output file), do a sanity check to make sure that all the the codes have the same tagname
Ncodecs = length(c);
if Ncodecs > 1
    disp(['WARNING: multiple codecs issued! (', num2str(Ncodecs), ')']);
    Ncodes = length(c(1).codec);
    for i=1:Ncodes
        for j=2:Ncodecs
            if ~strcmp( c(1).codec(i).tagname, c(j).codec(i).tagname )
                disp(['ERROR: mistmatch between the tagnames of code ', num2str(i), ' in codecs ', num2str(1), ' and ', num2str(j)]);
                return;
            end; %if strcmp
        end; %for j
    end; %for i    
    disp('... no conflict found between different codecs!');
end;
% Chose one of the issued codecs as the reference one
codec = c(1).codec;
Ncodes =  length(codec);

AllCodes = [];
if ~isempty(codec)
    
    for j=1:Ncodes

        % Staircase (general)
        if strcmp( codec(j).tagname, 'FlagStaircaseSize');
            Code.Stair.FlagSize = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;      
        if strcmp( codec(j).tagname, 'FlagStaircasePosHR');
            Code.Stair.FlagPosHR = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;      
        if strcmp( codec(j).tagname, 'FlagStaircasePosHL');
            Code.Stair.FlagPosHL = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;      
        if strcmp( codec(j).tagname, 'FlagStaircasePosVU');
            Code.Stair.FlagPosVU = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;      
        if strcmp( codec(j).tagname, 'FlagStaircasePosVD');
            Code.Stair.FlagPosVD = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;      
        if strcmp( codec(j).tagname, 'FlagStaircaseRotCW');
            Code.Stair.FlagRotCW = codec(j).code;
        end;      
        if strcmp( codec(j).tagname, 'FlagStaircaseRotACW');
            Code.Stair.FlagRotACW = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;      
        if strcmp( codec(j).tagname, 'FlagStaircaseDeptRotRight');
            Code.Stair.FlagRotDepR = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;      
        if strcmp( codec(j).tagname, 'FlagStaircaseDeptRotLeft');
            Code.Stair.FlagRotDepL = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;          
        if strcmp( codec(j).tagname, 'N_sizes_stair_current');
            Code.Stair.N_sizes_current = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;      
        if strcmp( codec(j).tagname, 'N_PosHR_stair_current');
            Code.Stair.N_PosHR_current = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;      
        if strcmp( codec(j).tagname, 'N_PosHL_stair_current');
            Code.Stair.N_PosHL_current = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;      
        if strcmp( codec(j).tagname, 'N_PosVU_stair_current');
            Code.Stair.N_PosVU_current = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;      
        if strcmp( codec(j).tagname, 'N_PosVD_stair_current');
            Code.Stair.N_PosVD_current = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;      
        if strcmp( codec(j).tagname, 'N_RotCW_stair_current');
            Code.Stair.N_RotCW_current = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;      
        if strcmp( codec(j).tagname, 'N_RotACW_stair_current');
            Code.Stair.N_RotACW_current = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;      
        if strcmp( codec(j).tagname, 'N_DeptRotR_stair_current');
            Code.Stair.N_RotDepR_current = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;      
        if strcmp( codec(j).tagname, 'N_DeptRotL_stair_current');
            Code.Stair.N_RotDepL_current = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;      
        if strcmp( codec(j).tagname, 'Default_size');
            Code.Stair.Default_size = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;  
        if strcmp( codec(j).tagname, 'Default_size_for_StairPosition');
            Code.Stair.Default_size_for_StairPosition = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end; 
        if strcmp( codec(j).tagname, 'Default_size_for_StairRotation');
            Code.Stair.Default_size_for_StairRotation = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end; 
        if strcmp( codec(j).tagname, 'Default_size_for_StairRotation_InPlane');
            Code.Stair.Default_size_for_StairRotation_InPlane = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end; 
        if strcmp( codec(j).tagname, 'Default_PosH');
            Code.Stair.Default_PosH = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;      
        if strcmp( codec(j).tagname, 'Default_PosV');
            Code.Stair.Default_PosV = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;  
        if strcmp( codec(j).tagname, 'Default_PosV_for_StairRotation_InPlane');
            Code.Stair.Default_PosV_for_StairRotation_InPlane = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;  
        if strcmp( codec(j).tagname, 'Default_Rotation');
            Code.Stair.Default_Rotation = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;      
        if strcmp( codec(j).tagname, 'Default_Rotation_in_Depth');
            Code.Stair.Default_Rotation_in_Depth = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;      

        % Staircase
        if strcmp( codec(j).tagname, 'CurrStairTrial');
            Code.Stair.CurrTrial = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;      
        if strcmp( codec(j).tagname, 'current_size_limit_stair');
            Code.current_limit_stair.Size = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;
        if strcmp( codec(j).tagname, 'current_PosHR_limit_stair');
            Code.current_limit_stair.PosHR = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;
        if strcmp( codec(j).tagname, 'current_PosHL_limit_stair');
            Code.current_limit_stair.PosHL = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;
        if strcmp( codec(j).tagname, 'current_PosVU_limit_stair');
            Code.current_limit_stair.PosVU = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;
        if strcmp( codec(j).tagname, 'current_PosVD_limit_stair');
            Code.current_limit_stair.PosVD = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;            
        if strcmp( codec(j).tagname, 'current_RotCW_limit_stair');
            Code.current_limit_stair.RotCW = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;            
        if strcmp( codec(j).tagname, 'current_RotACW_limit_stair');
            Code.current_limit_stair.RotACW = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;            
        if strcmp( codec(j).tagname, 'current_DeptRotR_limit_stair');
            Code.current_limit_stair.RotDepR = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;            
        if strcmp( codec(j).tagname, 'current_DeptRotL_limit_stair');
            Code.current_limit_stair.RotDepL = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;            
        if strcmp( codec(j).tagname, 'WatchSuccessStair_size');
            Code.Watch.SuccessStairSize = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;
        if strcmp( codec(j).tagname, 'WatchSuccessStair_PosHR');
            Code.Watch.SuccessStairPosHR = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;
        if strcmp( codec(j).tagname, 'WatchSuccessStair_PosHL');
            Code.Watch.SuccessStairPosHL = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;
        if strcmp( codec(j).tagname, 'WatchSuccessStair_PosVU');
            Code.Watch.SuccessStairPosVU = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;
        if strcmp( codec(j).tagname, 'WatchSuccessStair_PosVD');
            Code.Watch.SuccessStairPosVD = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;
        if strcmp( codec(j).tagname, 'WatchSuccessStair_RotCW');
            Code.Watch.SuccessStairRotCW = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;
        if strcmp( codec(j).tagname, 'WatchSuccessStair_RotACW');
            Code.Watch.SuccessStairRotACW = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;
        if strcmp( codec(j).tagname, 'WatchSuccessStair_DeptRotR');
            Code.Watch.SuccessStairRotDepR = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;
        if strcmp( codec(j).tagname, 'WatchSuccessStair_DeptRotL');
            Code.Watch.SuccessStairRotDepL = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;

        % Announcements (mine and default)
        if strcmp( codec(j).tagname, 'Announce_StimOn');
            Code.Announce.StimOn = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;
        if strcmp( codec(j).tagname, 'Announce_AcquirePort1');
            Code.Announce.AcqPort1 = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;      
        if strcmp( codec(j).tagname, 'Announce_AcquirePort3');
            Code.Announce.AcqPort3 = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;                  
        if strcmp( codec(j).tagname, '#announceStimulus');
            Code.Announce.Stim = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;            
        if findstr( codec(j).tagname, '#annoucenCurrentState' )
            Code.Announce.CurrState = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;
        if strcmp( codec(j).tagname, '#announceSound');
            Code.Announce.Sound = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;            


        % Behavioral outcome
        if strcmp( codec(j).tagname, 'success');
            Code.outcome.success = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;            
        if strcmp( codec(j).tagname, 'failure');
            Code.outcome.failure = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;            
        if strcmp( codec(j).tagname, 'ignore');
            Code.outcome.ignore = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;     
        if strcmp( codec(j).tagname, 'LickTH');
            Code.lick.thresh = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;
        if strcmp( codec(j).tagname, 'LickInput1');
            Code.lick.input1 = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;      
        if strcmp( codec(j).tagname, 'LickInput3');
            Code.lick.input3 = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;      
        if strcmp( codec(j).tagname, 'LickOutput1');
            Code.lick.output1 = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;      
        if strcmp( codec(j).tagname, 'LickOutput3');
            Code.lick.output3 = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;      

        % Properties of stimuli
        if strcmp( codec(j).tagname, 'stm_size');
            Code.Stim.size = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;      
        if strcmp( codec(j).tagname, 'stm_pos_x');
            Code.Stim.pos_x = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;      
        if strcmp( codec(j).tagname, 'stm_pos_y');
            Code.Stim.pos_y = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;      
        if strcmp( codec(j).tagname, 'stm_rotation');
            Code.Stim.rot = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;      
        if strcmp( codec(j).tagname, 'stm_rotation_in_depth');
            Code.Stim.rot_depth = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;      
        
        % Bcode values
        if strcmp( codec(j).tagname, 'StimNum');
            Code.Stim.bstimnum = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end; 
        if strcmp( codec(j).tagname, 'CondNum');
            Code.Stim.bcond = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end; 
        if strcmp( codec(j).tagname, 'BCODNum');
            Code.Stim.bnum = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end; 

        % Maximum number of stimuli of the same kind allowed in a sequence
        if strcmp( codec(j).tagname, 'MaxN_IdenticalStims');
            Code.Stim.MaxN_IdenticalStims = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;      

        % Useful flags
        if strcmp( codec(j).tagname, 'Flag_MatchCurrStairTrial');
            Code.Flag.MatchCurrStairTrial = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;      
        if strcmp( codec(j).tagname, 'FlagCueStimSound');
            Code.Flag.FlagCueStimSound = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;      

        % Bias control
        if strcmp( codec(j).tagname, 'FlagShowStimRight');
            Code.BiasControl.FlagShowStimRight = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;      
        if strcmp( codec(j).tagname, 'FlagShowStimLeft');
            Code.BiasControl.FlagShowStimLeft = codec(j).code;
            AllCodes = [AllCodes, codec(j).code];
        end;      


    end; %for j

end; %if f==1


% ----------- Get only the events that we need (corresponding to the codes previously extracted) ------------
disp(' ');
disp(['Read EVENTS from data file: ', FileName]);
events = getEvents( FileName, AllCodes );

event_timeS = [events.time_us];
[event_timeS, I_sort] = sort(event_timeS);
events = events(I_sort);
event_codeS = [events.event_code];
clear( 'event_timeS', 'I_sort' );


% save( 'DataForDave.mat', 'events', 'codec' );


% -------- Find values of variables that should have been kept constant for the whole recorded session or changed
% only very few times ---------
disp(' ');
disp('Build structures with trial by trial infos ...');

% Staircase (general)
Idx = find( event_codeS == Code.Stair.FlagSize );
if ~isempty(Idx)
    Gen.Stair.FlagSize.Times = [Gen.Stair.FlagSize.Times, events(Idx).time_us];
    Gen.Stair.FlagSize.Data = [Gen.Stair.FlagSize.Data, events(Idx).data];
end;
Idx = find( event_codeS == Code.Stair.FlagPosHR );
if ~isempty(Idx)    
    Gen.Stair.FlagPosHR.Times = [Gen.Stair.FlagPosHR.Times, events(Idx).time_us];
    Gen.Stair.FlagPosHR.Data = [Gen.Stair.FlagPosHR.Data, events(Idx).data];
end;
Idx = find( event_codeS == Code.Stair.FlagPosHL );
if ~isempty(Idx)        
    Gen.Stair.FlagPosHL.Times = [Gen.Stair.FlagPosHL.Times, events(Idx).time_us];
    Gen.Stair.FlagPosHL.Data = [Gen.Stair.FlagPosHL.Data, events(Idx).data];
end;        
Idx = find( event_codeS == Code.Stair.FlagPosVU );
if ~isempty(Idx)        
    Gen.Stair.FlagPosVU.Times = [Gen.Stair.FlagPosVU.Times, events(Idx).time_us];
    Gen.Stair.FlagPosVU.Data = [Gen.Stair.FlagPosVU.Data, events(Idx).data];
end;
Idx = find( event_codeS == Code.Stair.FlagPosVD );
if ~isempty(Idx)            
    Gen.Stair.FlagPosVD.Times = [Gen.Stair.FlagPosVD.Times, events(Idx).time_us];
    Gen.Stair.FlagPosVD.Data = [Gen.Stair.FlagPosVD.Data, events(Idx).data];
end;
Idx = find( event_codeS == Code.Stair.FlagRotCW );
if ~isempty(Idx)            
    Gen.Stair.FlagRotCW.Times = [Gen.Stair.FlagRotCW.Times, events(Idx).time_us];
    Gen.Stair.FlagRotCW.Data = [Gen.Stair.FlagRotCW.Data, events(Idx).data];
end;
Idx = find( event_codeS == Code.Stair.FlagRotACW );
if ~isempty(Idx)            
    Gen.Stair.FlagRotACW.Times = [Gen.Stair.FlagRotACW.Times, events(Idx).time_us];
    Gen.Stair.FlagRotACW.Data = [Gen.Stair.FlagRotACW.Data, events(Idx).data];
end;
Idx = find( event_codeS == Code.Stair.FlagRotDepR );
if ~isempty(Idx)            
    Gen.Stair.FlagRotDepR.Times = [Gen.Stair.FlagRotDepR.Times, events(Idx).time_us];
    Gen.Stair.FlagRotDepR.Data = [Gen.Stair.FlagRotDepR.Data, events(Idx).data];
end;
Idx = find( event_codeS == Code.Stair.FlagRotDepL );
if ~isempty(Idx)            
    Gen.Stair.FlagRotDepL.Times = [Gen.Stair.FlagRotDepL.Times, events(Idx).time_us];
    Gen.Stair.FlagRotDepL.Data = [Gen.Stair.FlagRotDepL.Data, events(Idx).data];
end;


Idx = find( event_codeS == Code.Stair.N_sizes_current );
if ~isempty(Idx)                
    Gen.Stair.N_sizes_current.Times = [Gen.Stair.N_sizes_current.Times, events(Idx).time_us];
    Gen.Stair.N_sizes_current.Data = [Gen.Stair.N_sizes_current.Data, events(Idx).data];
end;
Idx = find( event_codeS == Code.Stair.N_PosHR_current );
if ~isempty(Idx)                    
    Gen.Stair.N_PosHR_current.Times = [Gen.Stair.N_PosHR_current.Times, events(Idx).time_us];
    Gen.Stair.N_PosHR_current.Data = [Gen.Stair.N_PosHR_current.Data, events(Idx).data];
end;        
Idx = find( event_codeS == Code.Stair.N_PosHL_current );
if ~isempty(Idx)                    
    Gen.Stair.N_PosHL_current.Times = [Gen.Stair.N_PosHL_current.Times, events(Idx).time_us];
    Gen.Stair.N_PosHL_current.Data = [Gen.Stair.N_PosHL_current.Data, events(Idx).data];
end;
Idx = find( event_codeS == Code.Stair.N_PosVU_current );
if ~isempty(Idx)                        
    Gen.Stair.N_PosVU_current.Times = [Gen.Stair.N_PosVU_current.Times, events(Idx).time_us];
    Gen.Stair.N_PosVU_current.Data = [Gen.Stair.N_PosVU_current.Data, events(Idx).data];
end;
Idx = find( event_codeS == Code.Stair.N_PosVD_current );
if ~isempty(Idx)                            
    Gen.Stair.N_PosVD_current.Times = [Gen.Stair.N_PosVD_current.Times, events(Idx).time_us];
    Gen.Stair.N_PosVD_current.Data = [Gen.Stair.N_PosVD_current.Data, events(Idx).data];
end;
Idx = find( event_codeS == Code.Stair.N_RotCW_current );
if ~isempty(Idx)                            
    Gen.Stair.N_RotCW_current.Times = [Gen.Stair.N_RotCW_current.Times, events(Idx).time_us];
    Gen.Stair.N_RotCW_current.Data = [Gen.Stair.N_RotCW_current.Data, events(Idx).data];
end;
Idx = find( event_codeS == Code.Stair.N_RotACW_current );
if ~isempty(Idx)                            
    Gen.Stair.N_RotACW_current.Times = [Gen.Stair.N_RotACW_current.Times, events(Idx).time_us];
    Gen.Stair.N_RotACW_current.Data = [Gen.Stair.N_RotACW_current.Data, events(Idx).data];
end;
Idx = find( event_codeS == Code.Stair.N_RotDepR_current );
if ~isempty(Idx)                            
    Gen.Stair.N_RotDepR_current.Times = [Gen.Stair.N_RotDepR_current.Times, events(Idx).time_us];
    Gen.Stair.N_RotDepR_current.Data = [Gen.Stair.N_RotDepR_current.Data, events(Idx).data];
end;
Idx = find( event_codeS == Code.Stair.N_RotDepL_current );
if ~isempty(Idx)                            
    Gen.Stair.N_RotDepL_current.Times = [Gen.Stair.N_RotDepL_current.Times, events(Idx).time_us];
    Gen.Stair.N_RotDepL_current.Data = [Gen.Stair.N_RotDepL_current.Data, events(Idx).data];
end;

Idx = find( event_codeS == Code.Stair.Default_size );
if ~isempty(Idx)                            
    Gen.Stair.Default_size = [Gen.Stair.Default_size, events(Idx).data];
end;
Idx = find( event_codeS == Code.Stair.Default_size_for_StairPosition );
if ~isempty(Idx)                            
    Gen.Stair.Default_size_for_StairPosition = [Gen.Stair.Default_size_for_StairPosition, events(Idx).data];
end;
Idx = find( event_codeS == Code.Stair.Default_size_for_StairRotation );
if ~isempty(Idx)                            
    Gen.Stair.Default_size_for_StairRotation = [Gen.Stair.Default_size_for_StairRotation, events(Idx).data];
end;
Idx = find( event_codeS == Code.Stair.Default_size_for_StairRotation_InPlane );
if ~isempty(Idx)                            
    Gen.Stair.Default_size_for_StairRotation_InPlane = [Gen.Stair.Default_size_for_StairRotation_InPlane, events(Idx).data];
end;
Idx = find( event_codeS == Code.Stair.Default_PosH );
if ~isempty(Idx)                            
    Gen.Stair.Default_PosH = [Gen.Stair.Default_PosH, events(Idx).data];
end;
Idx = find( event_codeS == Code.Stair.Default_PosV );
if ~isempty(Idx)                            
    Gen.Stair.Default_PosV = [Gen.Stair.Default_PosV, events(Idx).data];
end;
Idx = find( event_codeS == Code.Stair.Default_PosV_for_StairRotation_InPlane );
if ~isempty(Idx)                            
    Gen.Stair.Default_PosV_for_StairRotation_InPlane = [Gen.Stair.Default_PosV_for_StairRotation_InPlane, events(Idx).data];
end;
Idx = find( event_codeS == Code.Stair.Default_Rotation );
if ~isempty(Idx)                            
    Gen.Stair.Default_Rotation = [Gen.Stair.Default_Rotation, events(Idx).data];
end;
Idx = find( event_codeS == Code.Stair.Default_Rotation_in_Depth );
if ~isempty(Idx)                            
    Gen.Stair.Default_Rotation_in_Depth = [Gen.Stair.Default_Rotation_in_Depth, events(Idx).data];
end;

% Useful flags
Idx = find( event_codeS == Code.Flag.FlagCueStimSound );
if ~isempty(Idx)                            
    Gen.Flag.FlagCueStimSound.Times = [Gen.Flag.FlagCueStimSound.Times, events(Idx).time_us];
    Gen.Flag.FlagCueStimSound.Data = [Gen.Flag.FlagCueStimSound.Data, events(Idx).data];
else
    Gen.Flag.FlagCueStimSound.Times = NaN;
    Gen.Flag.FlagCueStimSound.Data = NaN;
end;

% Maximum number of stimuli of the same kind allowed in a sequence
Idx = find( event_codeS == Code.Stim.MaxN_IdenticalStims );
if ~isempty(Idx)                            
    Gen.MaxN_IdenticalStims.Times = [Gen.MaxN_IdenticalStims.Times, events(Idx).time_us];
    Gen.MaxN_IdenticalStims.Data = [Gen.MaxN_IdenticalStims.Data, events(Idx).data];
else
    Gen.MaxN_IdenticalStims.Times = NaN;
    Gen.MaxN_IdenticalStims.Data = NaN;
end;



% Find the time from which the cue sound was definitely shut off. Only
% data colelcted after the cue is off are valid!
if Gen.Flag.FlagCueStimSound.Data(end) == 0
    I1 = find( Gen.Flag.FlagCueStimSound.Data == 1 );
    if isempty(I1)
        t_NoCueSound = Gen.Flag.FlagCueStimSound.Times(1);  % all data are valid!
    else
        t_NoCueSound = Gen.Flag.FlagCueStimSound.Times( I1(end)+1 );    % NOTE: never tested yet! 
    end;
elseif isnan(Gen.Flag.FlagCueStimSound.Data(end))
    t_NoCueSound = NaN;
else
    t_NoCueSound = inf;
end;


% % ######################### DEPRECATED #######################
% % Find the time from which the cue sound was definitely shut off. Only
% % data colelcted after the cue is off are valid!
% if Gen.Flag.FlagCueStimSound.Data(end) == 0
%     t_NoCueSound = Gen.Flag.FlagCueStimSound.Times(end);
% elseif isnan(Gen.Flag.FlagCueStimSound.Data(end))
%     t_NoCueSound = NaN;
% else
%     t_NoCueSound = inf;
% end;

% Find times in which stimuli were shown
Ic = find( event_codeS == Code.Announce.Stim);
CountNewStim = 0;
% Intilaize TrIdx
TrIdx = 1;
if ~isempty(Ic)

    % Make sure that all the elements of Ic refer to an image (rarely, for unknown causes, it happens that the first
    % element of Ic refer to events that do not contain the subfield 'type')
    l=1;
    while ~isfield( events(Ic(l)).data, 'type' );
        l=l+1;
    end;
    if l > 1
        Ic = Ic(l:end);
        disp(['WARNING: first ', num2str(l-1), ' "images" skipped because the corresponding structures', ...
            ' do no not contain the expected subfields']);
    end;
    N_stim_shown = length(Ic);
    disp(['# images shown (either stimulus or background) = ', num2str(N_stim_shown)]);

    for i = 1:N_stim_shown
        % Check that this is a stimulus (not blank)
        if strcmp( events(Ic(i)).data.type, 'image' );
%             disp(['Trial # ', num2str(TrIdx), '; Stim event Idx = ', num2str(Ic(i))]);
%              disp(['Trial # ', num2str(TrIdx), '; Image Name = ', events(Ic(i)).data.name]);

            % ---------------- Check what stimuli/images were used -----------------
            I_UndScore = findstr(events(Ic(i)).data.name, '_');
            I_me = findstr(events(Ic(i)).data.name, 'blankscr');
            I_dot = findstr(events(Ic(i)).data.name, '.');
            CmpName = events(Ic(i)).data.name(1:I_UndScore-1);
            CmpName2 = events(Ic(i)).data.name(1:I_me+7);     
            
%             % Images = geometrical shapes (Rats 1 & 2)
%             if strcmp( CmpName, 'Shape' )
%                 tr(TrIdx).stim_shape = str2num(events(Ic(i)).data.name(7));
                
            % Blank 
            if strcmp( CmpName2, 'blankscr' )
                tr(TrIdx).stim_shape = 111; %str2num(events(Ic(i)).data.name(1:5));
            end
            
            % Images = blobs (Rats D1 & D2)
            if strcmp( CmpName, 'Blob' )
                % This protocol used 3D rotated stimuli
                if strcmp( events(Ic(i)).data.name(I_UndScore(1)+1), 'N' )
                    tr(TrIdx).stim_shape = str2num(events(Ic(i)).data.name(I_UndScore(1)+2));
                    
                    % **** Extraction of 3D rotations (based on the name) ****
                    % ... about y axis
                    Irot_y = strfind( events(Ic(i)).data.name, 'CamRot_y' );
                    if ~isempty(Irot_y)
                        IIok = find(I_UndScore > Irot_y+8);
                        if ~isempty(IIok)
                            I_end = I_UndScore(IIok(1))-1;
                        else
                            I_end = I_dot-1;
                        end;
                        tr(TrIdx).stim_name_3Drot_y = str2num(events(Ic(i)).data.name( Irot_y+8:I_end ) );
                    else
                        tr(TrIdx).stim_name_3Drot_y = NaN;
                    end;
                    % ... about x axis
                    Irot_x = strfind( events(Ic(i)).data.name, 'CamRot_x' );
                    if ~isempty(Irot_x)
                        IIok = find(I_UndScore > Irot_x+8);
                        tr(TrIdx).stim_name_3Drot_x = str2num(events(Ic(i)).data.name( Irot_x+8:I_UndScore(IIok(1))-1 ) );
                    else
                        tr(TrIdx).stim_name_3Drot_x = NaN;
                    end;

                    % **** Extraction of light position added on Sept 9, 2008 ****
                    tr(TrIdx).stim_ligth_pos = 'default';
                    tr(TrIdx).stim_ligth_pos_code = 0;
                    I_L = strfind( events(Ic(i)).data.name, 'LighPos' );
                    % This protocol used some lighting conditions that were different from the standard
                    if ~isempty(I_L)
                        if str2num( events(Ic(i)).data.name( I_UndScore(5)+2:I_UndScore(6)-1 ) ) == 0 & ...
                                str2num( events(Ic(i)).data.name( I_UndScore(6)+2:I_UndScore(7)-1 ) ) == 10
                            tr(TrIdx).stim_ligth_pos = 'top';
                            tr(TrIdx).stim_ligth_pos_code = 1;
                        elseif str2num( events(Ic(i)).data.name( I_UndScore(5)+2:I_UndScore(6)-1 ) ) == 10 & ...
                                str2num( events(Ic(i)).data.name( I_UndScore(6)+2:I_UndScore(7)-1 ) ) == 0
                            tr(TrIdx).stim_ligth_pos = 'right';
                            tr(TrIdx).stim_ligth_pos_code = 2;
                        elseif str2num( events(Ic(i)).data.name( I_UndScore(5)+2:I_UndScore(6)-1 ) ) == -5 & ...
                                str2num( events(Ic(i)).data.name( I_UndScore(6)+2:I_UndScore(7)-1 ) ) == 5
                            tr(TrIdx).stim_ligth_pos = 'topleft';
                            tr(TrIdx).stim_ligth_pos_code = 3;
                        elseif str2num( events(Ic(i)).data.name( I_UndScore(5)+2:I_UndScore(6)-1 ) ) == 0 & ...
                                str2num( events(Ic(i)).data.name( I_UndScore(6)+2:I_UndScore(7)-1 ) ) == 0
                            tr(TrIdx).stim_ligth_pos = 'centralbottom';
                            tr(TrIdx).stim_ligth_pos_code = 4;
                        end
                    end;
                                    
                % This protocol did not use 3D rotated stimuli    
                else
                    tr(TrIdx).stim_shape = str2num(events(Ic(i)).data.name(6));
%                         disp(['Trial # ', num2str(TrIdx), '; Image Name = ', events(Ic(i)).data.name]);
%                         disp(['Shape # ', num2str(tr(TrIdx).stim_shape)]);
                end;
            
            % Images = New stimuli used by Federica    
            elseif strcmp( CmpName(1:end-1), 'OBJ' )
                tr(TrIdx).stim_shape = str2num(events(Ic(i)).data.name(I_UndScore(1)-1));
%                 disp(['Stim shape = ', num2str(tr(TrIdx).stim_shape)]);

                % **** Extraction of 3D rotations (based on the name) ****
                % ... about y axis
                Irot_y = strfind( events(Ic(i)).data.name, 'Rot_y' );
                if ~isempty(Irot_y)
                    IIok = find(I_UndScore > Irot_y+5);
                    if ~isempty(IIok)
                        I_end = I_UndScore(IIok(1))-1;
                    else
                        I_end = I_dot-1;
                    end;
                    tr(TrIdx).stim_name_3Drot_y = str2num(events(Ic(i)).data.name( Irot_y+5:I_end ) );
                else
                    tr(TrIdx).stim_name_3Drot_y = NaN;
                end;

%             else
%                 disp('################ ERROR! image name do not match any known name! #################');
% %                 return;
            end;
            tr(TrIdx).stim_time_us = events(Ic(i)).time_us;
            tr(TrIdx).stim_event_idx = Ic(i);

            % Find index of the next stimulus (image presented after the
            % current one)
            k=1;
            while ~strcmp( events(Ic(i+k)).data.type, 'image' ) & (i+k < N_stim_shown);
                k = k+1;
            end; %while

            % Check that this is is valid data (i.e., the cue sound was off)
            if ~isnan(t_NoCueSound)
                if tr(TrIdx).stim_time_us > t_NoCueSound
                    tr(TrIdx).FlagCueSound = 0;
                else
                    tr(TrIdx).FlagCueSound = 1;
                end;
            else
                tr(TrIdx).FlagCueSound = NaN;
            end;

            % Outcome of the current trial
            tr(TrIdx).TooFast = 1;
            Idx_outcome = find( event_codeS(Ic(i):Ic(i+k)) == Code.outcome.success );
            if ~isempty(Idx_outcome)
                tr(TrIdx).success = 1;%length(Idx_outcome);
                tr(TrIdx).TooFast = 0;
            else
                tr(TrIdx).success = 0;
            end;
            Idx_outcome = find( event_codeS(Ic(i):Ic(i+k)) == Code.outcome.failure );
            if ~isempty(Idx_outcome)
                tr(TrIdx).failure = 1;%length(Idx_outcome);
                tr(TrIdx).TooFast = 0;
            else
                tr(TrIdx).failure = 0;
            end;
            Idx_outcome = find( event_codeS(Ic(i):Ic(i+k)) == Code.outcome.ignore );
            if ~isempty(Idx_outcome)
                tr(TrIdx).ignore = 1;%length(Idx_outcome);
                tr(TrIdx).TooFast = 0;
            else
                tr(TrIdx).ignore = 0;
            end;

            % Watch flags of the staircases
            Idx = find( event_codeS(Ic(i):Ic(i+k)) == Code.Watch.SuccessStairSize );
            if ~isempty(Idx)
                tr(TrIdx).Watch_SuccessStair_Size = [events( Ic(i)-1+Idx ).data];
            else
                tr(TrIdx).Watch_SuccessStair_Size = NaN;
            end;
            Idx = find( event_codeS(Ic(i):Ic(i+k)) == Code.Watch.SuccessStairPosHR );
            if ~isempty(Idx)
                tr(TrIdx).Watch_SuccessStair_PosHR = [events( Ic(i)-1+Idx ).data];
            else
                tr(TrIdx).Watch_SuccessStair_PosHR = NaN;
            end;
            Idx = find( event_codeS(Ic(i):Ic(i+k)) == Code.Watch.SuccessStairPosHL );
            if ~isempty(Idx)
                tr(TrIdx).Watch_SuccessStair_PosHL = [events( Ic(i)-1+Idx ).data];
            else
                tr(TrIdx).Watch_SuccessStair_PosHL = NaN;
            end;
            Idx = find( event_codeS(Ic(i):Ic(i+k)) == Code.Watch.SuccessStairPosVU );
            if ~isempty(Idx)
                tr(TrIdx).Watch_SuccessStair_PosVU = [events( Ic(i)-1+Idx ).data];
            else
                tr(TrIdx).Watch_SuccessStair_PosVU = NaN;
            end;
            Idx = find( event_codeS(Ic(i):Ic(i+k)) == Code.Watch.SuccessStairPosVD );
            if ~isempty(Idx)
                tr(TrIdx).Watch_SuccessStair_PosVD = [events( Ic(i)-1+Idx ).data];
            else
                tr(TrIdx).Watch_SuccessStair_PosVD = NaN;
            end;
            Idx = find( event_codeS(Ic(i):Ic(i+k)) == Code.Watch.SuccessStairRotCW );
            if ~isempty(Idx)
                tr(TrIdx).Watch_SuccessStair_RotCW = [events( Ic(i)-1+Idx ).data];
            else
                tr(TrIdx).Watch_SuccessStair_RotCW = NaN;
            end;
            Idx = find( event_codeS(Ic(i):Ic(i+k)) == Code.Watch.SuccessStairRotACW );
            if ~isempty(Idx)
                tr(TrIdx).Watch_SuccessStair_RotACW = [events( Ic(i)-1+Idx ).data];
            else
                tr(TrIdx).Watch_SuccessStair_RotACW = NaN;
            end;
            Idx = find( event_codeS(Ic(i):Ic(i+k)) == Code.Watch.SuccessStairRotDepR );
            if ~isempty(Idx)
                tr(TrIdx).Watch_SuccessStair_RotDepR = [events( Ic(i)-1+Idx ).data];
            else
                tr(TrIdx).Watch_SuccessStair_RotDepR = NaN;
            end;
            Idx = find( event_codeS(Ic(i):Ic(i+k)) == Code.Watch.SuccessStairRotDepL );
            if ~isempty(Idx)
                tr(TrIdx).Watch_SuccessStair_RotDepL = [events( Ic(i)-1+Idx ).data];
            else
                tr(TrIdx).Watch_SuccessStair_RotDepL = NaN;
            end;

            % ------------- Input waveform on lick sensors -----------------------
            Idx = find( event_codeS(Ic(i):Ic(i+k)) == Code.lick.input1 );
            if ~isempty(Idx)
                tr(TrIdx).input1.data = [events( Ic(i)-1+Idx ).data];
                tr(TrIdx).input1.time_us = [events( Ic(i)-1+Idx ).time_us];
                % Time first contact with lick sensor     
                if ThLickSensor >= 850
                    I_lick = find( tr(TrIdx).input1.data < ThLickSensor );
                elseif ThLickSensor == 2.5
                    I_lick = find( tr(TrIdx).input1.data > ThLickSensor );
                end;
                if ~isempty(I_lick)
                    tr(TrIdx).input1_lickTime_us = tr(TrIdx).input1.time_us(I_lick(1));
                else
                    tr(TrIdx).input1_lickTime_us = -1;
                end;
            else
%                 disp(['stimulus # ', num2str(i), ': --------------> no events found for LickSensor1']);
                tr(TrIdx).input1.data = [];
                tr(TrIdx).input1.time_us = [];
                tr(TrIdx).input1_lickTime_us = -1;
            end;

            Idx = find( event_codeS(Ic(i):Ic(i+k)) == Code.lick.input3 ); 
            if ~isempty(Idx)          
                tr(TrIdx).input3.data = [events( Ic(i)-1+Idx ).data];
                tr(TrIdx).input3.time_us = [events( Ic(i)-1+Idx ).time_us];
                % Time first contact with lick sensor  
                if ThLickSensor >= 850
                    I_lick = find( tr(TrIdx).input3.data < ThLickSensor );
                elseif ThLickSensor == 2.5
                    I_lick = find( tr(TrIdx).input3.data > ThLickSensor );
                end;
                if ~isempty(I_lick)
                    tr(TrIdx).input3_lickTime_us = tr(TrIdx).input3.time_us(I_lick(1));                    
                else
                    tr(TrIdx).input3_lickTime_us = -1;
                end;
            else
                tr(TrIdx).input3.data = [];
                tr(TrIdx).input3.time_us = [];    
                tr(TrIdx).input3_lickTime_us = -1;
            end;                

%                 disp(['stimulus # ', num2str(i), ': time lick input 1 = ', num2str(tr(TrIdx).input1_lickTime_us)]);
            tmp = [tr(TrIdx).input1_lickTime_us, tr(TrIdx).input3_lickTime_us];
            Iok = find( tmp > 0 );
            if ~isempty(Iok)
                tr(TrIdx).RespTime_us = min(tmp(Iok));
            else
                tr(TrIdx).RespTime_us = NaN;
            end;

            % Output on juice tubes
            Idx = find( event_codeS(Ic(i):Ic(i+k)) == Code.lick.output1 );
            if ~isempty(Idx)
%                 % Double check that this output was set to high
%                 if [events( Ic(i)-1+Idx ).data] > 10000
%                     tr(TrIdx).output1 = 1;
%                 else
%                     tr(TrIdx).output1 = -1; % ERROR CODE: this should never happen (output never set to low)
%                 end;
                tr(TrIdx).output1 = 1;
                tr(TrIdx).output1_time_us = [events( Ic(i)-1+Idx ).time_us];
            else
                tr(TrIdx).output1 = 0;
                tr(TrIdx).output1_time_us = -1;
            end;
            Idx = find( event_codeS(Ic(i):Ic(i+k)) == Code.lick.output3 );
            if ~isempty(Idx)
%                 % Double check that this output was set to high
%                 if [events( Ic(i)-1+Idx ).data] > 10000
%                     tr(TrIdx).output3 = 1;
%                 else
%                     tr(TrIdx).output3 = -1; % ERROR CODE: this should never happen (output never set to low)
%                 end;
                tr(TrIdx).output3 = 1;
                tr(TrIdx).output3_time_us = [events( Ic(i)-1+Idx ).time_us];
            else
                tr(TrIdx).output3 = 0;
                tr(TrIdx).output3_time_us = -1;
            end;

            % Acquisition response on lick sensors
            Idx = find( event_codeS(Ic(i):Ic(i+k)) == Code.Announce.AcqPort1 );
            if ~isempty(Idx)
                tr(TrIdx).AcqPort1.time_us = [events( Ic(i)-1+Idx ).time_us];
            else
                tr(TrIdx).AcqPort1.time_us = [];
            end;
            Idx = find( event_codeS(Ic(i):Ic(i+k)) == Code.Announce.AcqPort3 );
            if ~isempty(Idx)
                tr(TrIdx).AcqPort3.time_us = [events( Ic(i)-1+Idx ).time_us];
            else
                tr(TrIdx).AcqPort3.time_us = [];
            end;

            % ------------ Look for sounds played before the stimulus --------------
            % NOTE: this should allow the user to figure out if the stimulus identity was cued by a sound.
            % Unfortunately, it appears that the action associated to the cue sound was not recorded: only one sound
            % is found before the stimulus and this is the cue START trial sound. This means that the variable
            % tr(TrIdx).StimCueSound is UNRELIABLE (it always 0) and MUST NOT BE USED
            Idx = find( event_codeS(Ic(i):-1:1) == Code.Announce.CurrState );
            if ~isempty(Idx)
                IdxAbs = Ic(i)+1-Idx;   % indexes in events
                CellText = {events( IdxAbs ).data};
                ii_sound = find( strcmp( CellText, 'Begin: Action: PlaySound' ) == 1 );
                IdxAbsSound = IdxAbs(ii_sound);    % indexes in events in which a sound was played

                % Debug plots
                hold off;
                plot([events( IdxAbsSound ).time_us]/1000000, ones(1,length([events( IdxAbsSound ).time_us])) , 'o');
                hold on;
                plot( [tr.stim_time_us]/1000000, 2*ones(1,length([tr.stim_time_us])), 'rs' );
                plot( [tr.RespTime_us]/1000000, ones(1,length([tr.RespTime_us])), 'g^' );

                % Relative time of sounds from stim onset
                TimeSoundRel2Stim_us = [events( IdxAbsSound ).time_us] - tr(TrIdx).stim_time_us;
                % Look for sounds that happened just before the stim onset (within 1 sec)
                % NOTE: these sounds may be maximum 2: 1) the cue start trail and 2) the cue stim
                Iok = find( TimeSoundRel2Stim_us < 0 & TimeSoundRel2Stim_us > -1000000 );
                tr(TrIdx).Sound_RelTimeBeforeStim_us = TimeSoundRel2Stim_us(Iok);
                if length(Iok) == 1
                    tr(TrIdx).StimCueSound = 0; % no cue sound (purely visual trial)
                elseif length(Iok) == 2
                    tr(TrIdx).StimCueSound = 1; % cue sound (visual/acoustic trial)
                else
                    tr(TrIdx).StimCueSound = -1;    % ERROR CODE
                end;
            else
               tr(TrIdx).Sound_RelTimeBeforeStim_us = [];
               tr(TrIdx).StimCueSound = NaN;
            end;
            
            
            % ------------ Look for sounds played after the stimulus --------------
            % NOTE: this is meant to tell whether there was a sound feedback following the response of the animal
            Idx = find( event_codeS(Ic(i):Ic(i+k)) == Code.Announce.CurrState );
            if ~isempty(Idx)
                IdxAbs = Ic(i)-1+Idx;   % indexes in events
                CellText = {events( IdxAbs ).data};
                ii_sound = find( strcmp( CellText, 'Begin: Action: PlaySound' ) == 1 );
                IdxAbsSound = IdxAbs(ii_sound);    % indexes in events in which a sound was played

%                     % Debug plots
%                     plot([events( IdxAbsSound ).time_us]/1000000, ones(1,length([events( IdxAbsSound ).time_us])) , 'o');
%                     hold on;
%                     plot( [tr.stim_time_us]/1000000, 2*ones(1,length([tr.stim_time_us])), 'rs' );

                % Relative time of sounds from response
                if ~isnan( tr(TrIdx).RespTime_us )
                    TimeSoundRel2Resp_us = [events( IdxAbsSound ).time_us] - tr(TrIdx).RespTime_us;

                    % Look for sounds that happened just after the the response (within 500 ms)
                    % NOTE: due to misalignement of the time scales of the ITC and the computer, in some instances,
                    % the feedback sound may have a time stamp lower than the time stamp of the response (as if it
                    % happened before). This is why we also look for times > -100 ms from the response time.
                    Iok = find( TimeSoundRel2Resp_us > -100000 & TimeSoundRel2Resp_us < 500000 );
                    if ~isempty(Iok)
                        tr(TrIdx).FeedbackSound = 1;    % either success sound or punishment
                        tr(TrIdx).FirstSound_RelTimeFromResp_us = TimeSoundRel2Resp_us(Iok(1));
                    else
                        tr(TrIdx).FeedbackSound = 0;    % no feedback
                        tr(TrIdx).FirstSound_RelTimeFromResp_us = NaN;
                    end;
                % Rat did not make a response    
                else
                    tr(TrIdx).FeedbackSound = NaN;    
                    tr(TrIdx).FirstSound_RelTimeFromResp_us = NaN;
                end;                    

            else
               tr(TrIdx).FeedbackSound = NaN;
               tr(TrIdx).FirstFeebackSound_time_us = NaN;
            end;               


            % *********************************************************************************************************
            % NOTE: starting from AUg 21, 2008 a new event has been added to tell when a sound was played. We use this
            % new even to figure out whether a cue sound or a feedback sound (see below) were used
            % *********************************************************************************************************
            
            % ------------ Look for sounds played before the stimulus --------------
            Idx = find( event_codeS(Ic(i):-1:1) == Code.Announce.Sound );
            if ~isempty(Idx)
                
                % Relative time of sounds from stim onset
                TimeSoundRel2Stim_us = [events( Ic(i)+1-Idx ).time_us] - tr(TrIdx).stim_time_us;
                % Look for sounds that happened just before the stim onset (within 1 sec)
                % NOTE: these sounds may be maximum 2: 1) the cue start trail and 2) the cue stim
                Iok = find( TimeSoundRel2Stim_us < 0 & TimeSoundRel2Stim_us > -1000000 );
                tr(TrIdx).Sound_RelTimeBeforeStim_us = TimeSoundRel2Stim_us(Iok);
                if length(Iok) == 1
                    tr(TrIdx).new_StimCueSound = 0; % no cue sound (purely visual trial)
                elseif length(Iok) == 2
                    tr(TrIdx).new_StimCueSound = 1; % cue sound (visual/acoustic trial)
                else
                    tr(TrIdx).new_StimCueSound = -1;    % ERROR CODE
                end;
            else
               tr(TrIdx).new_Sound_RelTimeBeforeStim_us = [];
               tr(TrIdx).new_StimCueSound = NaN;
            end;

            % ------------ Look for sounds played after the stimulus --------------
            % NOTE: this is meant to tell whether there was a sound feedback following the response of the animal
            Idx = find( event_codeS(Ic(i):Ic(i+k)) == Code.Announce.Sound );
            if ~isempty(Idx)

                % Relative time of sounds from response
                if ~isnan( tr(TrIdx).RespTime_us )
                    TimeSoundRel2Resp_us = [events( Ic(i)-1+Idx ).time_us] - tr(TrIdx).RespTime_us;

                    % Look for sounds that happened just after the the response (within 500 ms)
                    % NOTE: due to misalignement of the time scales of the ITC and the computer, in some instances,
                    % the feedback sound may have a time stamp lower than the time stamp of the response (as if it
                    % happened before). This is why we also look for times > -100 ms from the response time.
                    Iok = find( TimeSoundRel2Resp_us > -100000 & TimeSoundRel2Resp_us < 500000 );
                    if ~isempty(Iok)
                        tr(TrIdx).new_FeedbackSound = 1;    % either success sound or punishment
                        tr(TrIdx).new_FirstSound_RelTimeFromResp_us = TimeSoundRel2Resp_us(Iok(1));
                    else
                        tr(TrIdx).new_FeedbackSound = 0;    % no feedback
                        tr(TrIdx).new_FirstSound_RelTimeFromResp_us = NaN;
                    end;
                % Rat did not make a response    
                else
                    tr(TrIdx).new_FeedbackSound = NaN;    
                    tr(TrIdx).new_FirstSound_RelTimeFromResp_us = NaN;
                end;                    

            else
               tr(TrIdx).new_FeedbackSound = NaN;
               tr(TrIdx).new_FirstFeebackSound_time_us = NaN;
            end;               


            
            % Properties of presented stimuli
            Idx = find( event_codeS(Ic(i):-1:1) == Code.Stim.size );
            if ~isempty(Idx)
                tmp = [events( Ic(i)+1-Idx ).data];
                tr(TrIdx).stim_size = tmp(1);
            else
                tr(TrIdx).stim_size = NaN;
            end;
            Idx = find( event_codeS(Ic(i):-1:1) == Code.Stim.pos_x );
            if ~isempty(Idx)
                tmp = [events( Ic(i)+1-Idx ).data];
                tr(TrIdx).stim_pos_x = tmp(1);
            else
                tr(TrIdx).stim_pos_x = NaN;
            end;
            Idx = find( event_codeS(Ic(i):-1:1) == Code.Stim.pos_y );
            if ~isempty(Idx)
                tmp = [events( Ic(i)+1-Idx ).data];
                tr(TrIdx).stim_pos_y = tmp(1);
            else
                tr(TrIdx).stim_pos_y = NaN;
            end;
            Idx = find( event_codeS(Ic(i):-1:1) == Code.Stim.rot );
            if ~isempty(Idx)
                tmp = [events( Ic(i)+1-Idx ).data];
                tr(TrIdx).stim_rot = tmp(1);
            else
                tr(TrIdx).stim_rot = NaN;
            end;
            Idx = find( event_codeS(Ic(i):-1:1) == Code.Stim.rot_depth );
            if ~isempty(Idx)
                tmp = [events( Ic(i)+1-Idx ).data];
                tr(TrIdx).stim_rot_depth = tmp(1);
%                 disp(['Computed rotation = ', num2str(tr(TrIdx).stim_rot_depth)]);
            else
                tr(TrIdx).stim_rot_depth = NaN;
            end;
%                 % Debug print
%                 disp(['Shape # ', num2str(tr(TrIdx).stim_shape), '; SIZE = ', num2str(tr(TrIdx).stim_size), ...
%                     '; DEPTH ROT = ', num2str(tr(TrIdx).stim_rot_depth)
%                     ]);
            Idx = find( event_codeS(Ic(i):-1:1) == Code.Stim.bstimnum );
            if ~isempty(Idx)
                tmp = [events( Ic(i)+1-Idx ).data];
                tr(TrIdx).bstim_num = tmp(1);
            else
                tr(TrIdx).bstim_num = NaN;
            end
            Idx = find( event_codeS(Ic(i):-1:1) == Code.Stim.bcond );
            if ~isempty(Idx)
                tmp = [events( Ic(i)+1-Idx ).data];
                tr(TrIdx).bcond = tmp(1);
            else
                tr(TrIdx).bcond = NaN;
            end
            Idx = find( event_codeS(Ic(i):-1:1) == Code.Stim.bnum );
            if ~isempty(Idx)
                tmp = [events( Ic(i)+1-Idx ).data];
                tr(TrIdx).bcode_num = tmp(1);
            else
                tr(TrIdx).bcode_num = NaN;
            end




            % Current limits in the staircase
            Idx = find( event_codeS(Ic(i):-1:1) == Code.current_limit_stair.Size );
            if ~isempty(Idx)
                tmp = [events( Ic(i)+1-Idx ).data];
                tr(TrIdx).current_limit_stair_Size = tmp(1);
            else
                tr(TrIdx).current_limit_stair_Size = NaN;
            end;
            Idx = find( event_codeS(Ic(i):-1:1) == Code.current_limit_stair.PosHR );
            if ~isempty(Idx)
                tmp = [events( Ic(i)+1-Idx ).data];
                tr(TrIdx).current_limit_stair_PosHR = tmp(1);
            else
                tr(TrIdx).current_limit_stair_PosHR = NaN;
            end;
            Idx = find( event_codeS(Ic(i):-1:1) == Code.current_limit_stair.PosHL );
            if ~isempty(Idx)
                tmp = [events( Ic(i)+1-Idx ).data];
                tr(TrIdx).current_limit_stair_PosHL = tmp(1);
            else
                tr(TrIdx).current_limit_stair_PosHL = NaN;
            end;
            Idx = find( event_codeS(Ic(i):-1:1) == Code.current_limit_stair.PosVU );
            if ~isempty(Idx)
                tmp = [events( Ic(i)+1-Idx ).data];
                tr(TrIdx).current_limit_stair_PosVU = tmp(1);
            else
                tr(TrIdx).current_limit_stair_PosVU = NaN;
            end;
            Idx = find( event_codeS(Ic(i):-1:1) == Code.current_limit_stair.PosVD );
            if ~isempty(Idx)
                tmp = [events( Ic(i)+1-Idx ).data];
                tr(TrIdx).current_limit_stair_PosVD = tmp(1);
            else
                tr(TrIdx).current_limit_stair_PosVD = NaN;
            end;
            Idx = find( event_codeS(Ic(i):-1:1) == Code.current_limit_stair.RotCW );
            if ~isempty(Idx)
                tmp = [events( Ic(i)+1-Idx ).data];
                tr(TrIdx).current_limit_stair_RotCW = tmp(1);
            else
                tr(TrIdx).current_limit_stair_RotCW = NaN;
            end;
            Idx = find( event_codeS(Ic(i):-1:1) == Code.current_limit_stair.RotACW );
            if ~isempty(Idx)
                tmp = [events( Ic(i)+1-Idx ).data];
                tr(TrIdx).current_limit_stair_RotACW = tmp(1);
            else
                tr(TrIdx).current_limit_stair_RotACW = NaN;
            end;
            Idx = find( event_codeS(Ic(i):-1:1) == Code.current_limit_stair.RotDepR );
            if ~isempty(Idx)
                tmp = [events( Ic(i)+1-Idx ).data];
                tr(TrIdx).current_limit_stair_RotDepR = tmp(1);
            else
                tr(TrIdx).current_limit_stair_RotDepR = NaN;
            end;
            Idx = find( event_codeS(Ic(i):-1:1) == Code.current_limit_stair.RotDepL );
            if ~isempty(Idx)
                tmp = [events( Ic(i)+1-Idx ).data];
                tr(TrIdx).current_limit_stair_RotDepL = tmp(1);
            else
                tr(TrIdx).current_limit_stair_RotDepL = NaN;
            end;

            % Trial type in the current staircase
            Idx = find( event_codeS(Ic(i):-1:1) == Code.Stair.CurrTrial );
            if ~isempty(Idx)
                tmp = [events( Ic(i)+1-Idx ).data];
                tr(TrIdx).stair_trial_type = tmp(1);
            else
                tr(TrIdx).stair_trial_type = NaN;
            end;

            % Flags used to control if the left and right stimuli must be presented (typically used for bias
            % control)
            Idx = find( event_codeS(Ic(i):-1:1) == Code.BiasControl.FlagShowStimRight );
            if ~isempty(Idx)
                tmp = [events( Ic(i)+1-Idx ).data];
                tr(TrIdx).FlagShowStimRight = tmp(1);
            else
                tr(TrIdx).FlagShowStimRight = NaN;
            end;
            Idx = find( event_codeS(Ic(i):-1:1) == Code.BiasControl.FlagShowStimLeft );
            if ~isempty(Idx)
                tmp = [events( Ic(i)+1-Idx ).data];
                tr(TrIdx).FlagShowStimLeft = tmp(1);
            else
                tr(TrIdx).FlagShowStimLeft = NaN;
            end;

            CountNewStim = CountNewStim+1;
            TrIdx = TrIdx+1;

%             % Find index (in Ic) of the previous stimulus (image presented before the current one)
%             if i > 1
%                 PrevIm_ii=-1;
%                 while ~strcmp( events(Ic(i+PrevIm_ii)).data.type, 'image' ) & (i+PrevIm_ii > 1)
%                     PrevIm_ii = PrevIm_ii-1;
%                 end; %while
%                 EventIdxPrevIm = Ic( i + PrevIm_ii );
%             end;

        end; %if strcmp( events(Ic(i)).data.type, 'image' )
    end; %for i

    clear( 'events', 'event_codeS', 'Ic' );
end; %if ~isempty(Ic)
    

disp(['Total # of trials = ', num2str(TrIdx)]);


% ### Save .mat file ###
Idot = findstr(FileName, '.mwk');
OutName = [FileName(1:Idot-1), '_extr.mat'];
save( OutName, 'tr', 'Gen', 'Code' );
disp(['... save extracted data in ', OutName]);
    



