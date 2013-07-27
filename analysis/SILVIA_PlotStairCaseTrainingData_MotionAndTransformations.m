% ???????????????????????????????????????????????????????????????????
%
%  draws from PlotStairCaseTrainingData (see that for details)
%        
%
%   Example:
%
%       >> Nat_PlotStairCaseTrainingData('r_NG1_b001_extr.mat', 1)
%
% ???????????????????????????????????????????????????????????????????
   


function SILVIA_PlotStairCaseTrainingData_MotionAndTransformations( FileName, FlagSave )

load( FileName );
disp(' ');
disp(['Load ', FileName]);

% Default values of stimulus properties
if isfield( Gen.Stair, 'Default_size' );
    Size_default_for_StairPosition = unique(Gen.Stair.Default_size_for_StairPosition)         %%(Gen.Stair.Default_size);
    if isempty(Size_default_for_StairPosition)
        Size_default_for_StairPosition = 30;
    end;
    Size_default_for_StairRotation = unique(Gen.Stair.Default_size_for_StairRotation);
    if isempty(Size_default_for_StairRotation)
        Size_default_for_StairRotation = 30;    
    end;
    Size_default_for_StairRotation_InPlane = unique(Gen.Stair.Default_size_for_StairRotation_InPlane);
    if isempty(Size_default_for_StairRotation_InPlane)
        Size_default_for_StairRotation_InPlane = 32.5;    
    end;
    PosH_default = unique(Gen.Stair.Default_PosH);
    if isempty(PosH_default)
        PosH_default = 0;
    end;
    PosV_default = unique(Gen.Stair.Default_PosV);
    if isempty(PosV_default)
        PosV_default = 0;
    end;
    PosV_default_InPlane = unique(Gen.Stair.Default_PosV_for_StairRotation_InPlane);
    if isempty(PosV_default_InPlane)
        PosV_default_InPlane = -3.5;
    end;
    Rot_default = unique(Gen.Stair.Default_Rotation);
    if isempty(Rot_default)
        Rot_default = 0;
    end;
    RotDep_default = unique(Gen.Stair.Default_Rotation_in_Depth);
    if isempty(RotDep_default)
        RotDep_default = 0;
    end;
    if length(Size_default_for_StairPosition)>1 | length(Size_default_for_StairRotation)>1 | length(Size_default_for_StairRotation_InPlane)>1 | ...
            length(PosH_default)>1 | length(PosV_default)>1 | length(PosV_default_InPlane)>1 | length(Rot_default)>1 | length(RotDep_default)>1
        disp('WARNING: some of the default stimulus properties was changed during the experiment: ABORT analysis!');
        return;
    end;
else
    % Default values of stimulus properties
    Size_default_for_StairPosition = 30;
    Size_default_for_StairRotation = 30;
    Size_default_for_StairRotation_InPlane = 32.5;
    PosH_default = 0;
    PosV_default = 0;
    PosV_default_InPlane = -3.5;
    Rot_default = 0;
    RotDep_default = 0;
end;
% % Debug print
% Size_default_for_StairPosition 
% Size_default_for_StairRotation 
% PosH_default
% PosV_default
% Rot_default 
% RotDep_default 

% Decide if you want to display the property values of ALL the presented stimuli (flag=0) or of ONLY the stimuli at the
% staircase limits (flag=1)
FlagPlotOnlyStairCaseLimits = 1;

% ======= Build a vector for each of the stimulus property (NOTE: they all must have the same size) ========
stim_id = [tr.obj_id];
stim_shape = [tr.stim_shape];
stim_time_us = [tr.stim_time_us];
success = [tr.success];
failure = [tr.failure];
ignore = [tr.ignore];
TooFast = [tr.TooFast];
RespTime_us = [tr.RespTime_us];
TrialType = [tr.stair_trial_type];
disp('Trials statistics:');
disp(['# correct = ', num2str(length(find(success==1)))]);
disp(['# failure = ', num2str(length(find(failure==1)))]);
disp(['# ignored = ', num2str(length(find(ignore==1)))]);
disp(['# too fast = ', num2str(length(find(TooFast==1)))]);
Ntrials_tot = length(tr);
disp(['Total = ', num2str(Ntrials_tot)]);

% Flags that control the right and left presentation
% NOTE: set "FlagIncludeAlsoBiasControlTrials"  flag to 1 if you want to include all the trials (also trials in which
% the left & right flags were not both ON will be used)
FlagIncludeAlsoBiasControlTrials = 0;   
if isfield( tr, 'FlagShowStimRight' )
    FlagShowStimRight = [tr.FlagShowStimRight];
    FlagShowStimLeft = [tr.FlagShowStimLeft];
    if FlagIncludeAlsoBiasControlTrials
        disp(['*** WARNING: also "Bias Control" trials will be included in the analysis! (To exclude them set "FlagIncludeAlsoBiasControlTrials" to 1)']);
    end
else
    FlagShowStimRight = ones(1, Ntrials_tot );
    FlagShowStimLeft = ones(1, Ntrials_tot );
    disp(['*** WARNING: no information extracted about "Bias Control" trials: ALL TRIALS included in the analysis'])
end;
if FlagIncludeAlsoBiasControlTrials 
    FlagShowStimRight = ones(1, Ntrials_tot );
    FlagShowStimLeft = ones(1, Ntrials_tot );
end;
FlagBothStimsON = FlagShowStimRight .* FlagShowStimLeft;

% Size and positions
stim_size = [tr.stim_size];
stim_pos_x = [tr.stim_pos_x];
stim_pos_y = [tr.stim_pos_y];
WatchSize = [tr.Watch_SuccessStair_Size];
WatchPosHR = [tr.Watch_SuccessStair_PosHR];
WatchPosHL = [tr.Watch_SuccessStair_PosHL];
WatchPosVU = [tr.Watch_SuccessStair_PosVU];
WatchPosVD = [tr.Watch_SuccessStair_PosVD];
StairLimitSize = [tr.current_limit_stair_Size];
StairLimitPosHR = [tr.current_limit_stair_PosHR];
StairLimitPosHL = [tr.current_limit_stair_PosHL];
StairLimitPosVU = [tr.current_limit_stair_PosVU];
StairLimitPosVD = [tr.current_limit_stair_PosVD];

% Rotations in plane
if isfield(tr, 'stim_rot')
    FlagTestedRot = 1;
    stim_rot = [tr.stim_rot];
    WatchRotCW = [tr.Watch_SuccessStair_RotCW];
    WatchRotACW = [tr.Watch_SuccessStair_RotACW];
    StairLimitRotCW = [tr.current_limit_stair_RotCW];
    StairLimitRotACW = [tr.current_limit_stair_RotACW];
else
    disp(['WARNING: no IN PLANE ROTATION values available for this session! All rotations set to the DEFAULT value ', ...
        num2str(Rot_default)]);
    FlagTestedRot = 0;
    stim_rot = Rot_default*ones(size(stim_shape));
    WatchRotCW = NaN*ones(size(stim_shape));
    WatchRotACW = NaN*ones(size(stim_shape));
    StairLimitRotCW = NaN*ones(size(stim_shape));
    StairLimitRotACW = NaN*ones(size(stim_shape));
end;

% Rotations in Depth
if isfield(tr, 'stim_rot_depth')
    FlagTestedDepRot = 1;
    stim_rot_depth = [tr.stim_rot_depth];
    WatchRotDepR = [tr.Watch_SuccessStair_RotDepR];
    WatchRotDepL = [tr.Watch_SuccessStair_RotDepL];
    StairLimitRotDepR = [tr.current_limit_stair_RotDepR];
    StairLimitRotDepL = [tr.current_limit_stair_RotDepL];
else
    disp(['WARNING: no IN DEPTH ROTATION values available for this session! All rotations set to the DEFAULT value ', ...
        num2str(RotDep_default)]);
    FlagTestedDepRot = 0;
    stim_rot_depth = RotDep_default*ones(size(stim_shape));
    WatchRotDepR = NaN*ones(size(stim_shape));
    WatchRotDepL = NaN*ones(size(stim_shape));
    StairLimitRotDepR = NaN*ones(size(stim_shape));
    StairLimitRotDepL = NaN*ones(size(stim_shape));
end;

Stim_transf_type{1} = stim_size;
Stim_transf_type{2} = stim_pos_x;
Stim_transf_type{3} = stim_pos_x;
Stim_transf_type{4} = stim_pos_y;
Stim_transf_type{5} = stim_pos_y;
Stim_transf_type{6} = stim_rot;
Stim_transf_type{7} = stim_rot;
Stim_transf_type{8} = stim_rot_depth;
Stim_transf_type{9} = stim_rot_depth;

StairLimit_type{1} = StairLimitSize;
StairLimit_type{2} = StairLimitPosHR;
StairLimit_type{3} = StairLimitPosHL;
StairLimit_type{4} = StairLimitPosVU;
StairLimit_type{5} = StairLimitPosVD;
StairLimit_type{6} = StairLimitRotCW;
StairLimit_type{7} = StairLimitRotACW;
StairLimit_type{8} = StairLimitRotDepR;
StairLimit_type{9} = StairLimitRotDepL;

Watch_type{1} = WatchSize;
Watch_type{2} = WatchPosHR;
Watch_type{3} = WatchPosHL;
Watch_type{4} = WatchPosVU;
Watch_type{5} = WatchPosVD;
Watch_type{6} = WatchRotCW;
Watch_type{7} = WatchRotACW;
Watch_type{8} = WatchRotDepR;
Watch_type{9} = WatchRotDepL;


% Compute total performance 
I_success = find( success == 1 );
I_failure = find( failure == 1 );
Ntrials = length(I_success)+length(I_failure);
disp(['Total # of trials = ', num2str(Ntrials)]);
TotPerf = length(I_success) / Ntrials * 100;
PercTrialsNoBiasControl = 100;
disp(['Total performance = ', num2str(TotPerf)]);
% Compute total performance after removal of "Bias Correction" trials
if ~FlagIncludeAlsoBiasControlTrials
    Iok = find( FlagBothStimsON == 1 );
    I_success = find( success(Iok) == 1 );
    I_failure = find( failure(Iok) == 1 );
    TotPerf = length(I_success) / (length(I_success)+length(I_failure)) * 100;
    disp(['Total performance after removal of "Bias Correction" trials = ', num2str(TotPerf)])
    PercTrialsNoBiasControl = (length(I_success)+length(I_failure))/Ntrials*100;
    disp(['(Fraction of trials without bias correction = ', num2str(PercTrialsNoBiasControl), '%)']);
end;
    

% Since the rotation staircase was addedd later we did not originally have a
% stm_rotation variable, so stim_rot turn out to be all NaN. For
% consistency we reinitialize stim_rot to the default (fixed) value of
% rotation = 0
Inan = find( isnan(stim_rot) );
if length(Inan) == length(stim_rot)
    disp(['WARNING: all IN PLANE ROTATION values are NaN for this session! All rotations set to the DEFAULT value ', ...
        num2str(Rot_default)]);
    stim_rot = Rot_default * ones(1,length(stim_rot));
end;
Inan = find( isnan(stim_rot_depth) );
if length(Inan) == length(stim_rot_depth)
    disp(['WARNING: all IN depth ROTATION values are NaN for this session! All rotations set to the DEFAULT value ', ...
        num2str(RotDep_default)]);
    stim_rot_depth = RotDep_default * ones(1,length(stim_rot_depth));
end;


% Find which trials were staircase with size, posH, etc
Type_Empty = 1;
for i=1:9
    if FlagPlotOnlyStairCaseLimits
        I_type{i} = find( TrialType == i & ignore == 0 & TooFast == 0 & ~isnan(Watch_type{i}));
    else
        I_type{i} = find( TrialType == i & ignore == 0 & TooFast == 0 );
    end;
    if ~isempty(I_type{i})
        Type_Empty = 0;
    end;
end;

% For older files no trial_type info was saved. The Flag of the SIZE staircase
% must be looked for to decide when the staircase actually started. NOTE:
% this problem occurs only for SIZE (because size was the only
% transformation tested in the intial training)
% if Type_Empty
%     I_type{1} = find( stim_time_us > Gen.Stair.FlagSize.Times & ignore == 0 & TooFast == 0 & ~isnan(Watch_type{1}) );
% end;
if isempty(I_type{1})
    if FlagPlotOnlyStairCaseLimits
        I_type{1} = find( ignore == 0 & TooFast == 0 & ~isnan(Watch_type{1}) );
    else
        I_type{1} = find( ignore == 0 & TooFast == 0 );
    end;
end;


col = ['b', 'r', 'g', 'c', 'm', 'c', 'm', 'r', 'g'];
symbol = ['v', 's'];
y_axis_text = { 'Size'; 'Position Horizontal Right'; 'Position Horizontal Left'; ...
    'Position Vertical Up'; 'Position Vertical Down'; 'Rotation Clock Wise'; ...
    'Rotation Anti-Clock Wise'; '3D rotation in depth (right)'; '3D rotation in depth (left)' };

% ##################################
%  FIGURES: Plot sensory threshold
% ##################################
for i=1:9
    if ~isempty(I_type{i})        
        
        Stim_transf_type{i} = Stim_transf_type{i}(I_type{i});
        x_base = 1:length(Stim_transf_type{i});        
        stim_shape_type{i} = stim_shape(I_type{i});
        success_type{i} = success(I_type{i});
        failure_type{i} = failure(I_type{i});
        StairLimit_type{i} = StairLimit_type{i}(I_type{i});
        Watch_type{i} = Watch_type{i}(I_type{i});
        
        figure;
        plot( x_base, Stim_transf_type{i}, '-', 'color', col(i) );
        hold on;      
        
        % Plot current limit of the staircase
        plot( x_base, StairLimit_type{i}, '-k' );
        
        % CORRECT responses
        I1_success = find( stim_shape_type{i} == 1 & success_type{i} == 1 );
        plot( x_base(I1_success), Stim_transf_type{i}(I1_success), 'v', 'color', col(i), 'MarkerFaceColor', col(i), 'MarkerSize', 8 );
        I2_success = find( stim_shape_type{i} == 2 & success_type{i} == 1 );
        plot( x_base(I2_success), Stim_transf_type{i}(I2_success), 's', 'color', col(i), 'MarkerFaceColor', col(i), 'MarkerSize', 8 );
        
        % WRONG responses
        I1_failure = find( stim_shape_type{i} == 1 & failure_type{i} == 1 );
        plot( x_base(I1_failure), Stim_transf_type{i}(I1_failure), 'v', 'color', col(i), 'MarkerFaceColor', 'w', 'MarkerSize', 8 );
        I2_failure = find( stim_shape_type{i} == 2 & failure_type{i} == 1 );
        plot( x_base(I2_failure), Stim_transf_type{i}(I2_failure), 's', 'color', col(i), 'MarkerFaceColor', 'w', 'MarkerSize', 8 );
        
        ylabel( y_axis_text(i) );
        xlabel('Trial');
    end;
end;


% ##################################
%   FIGURES: Plot performances
% ##################################

% ***** STIM 1 R *******

    I = find( stim_size(1:length(stim_shape)) == 35 & stim_id(1:length(stim_shape)) == 0 & stim_shape == 1 & stim_pos_x ~= 0);
    Pre_S1R_N_correct = length( find(success(I)==1) );
    Pre_S1R_N_failure = length( find(failure(I)==1) );
    Pre_S1R_N_tot = Pre_S1R_N_correct + Pre_S1R_N_failure;
    S1R_N_correct = abs(Pre_S1R_N_correct - Shapes_Succ_Stim1R_M);
    S1R_N_failure = abs(Pre_S1R_N_failure - Shapes_Fail_Stim1R_M);
    S1R_N_tot = S1R_N_correct +  S1R_N_failure;
    if S1R_N_tot ~= 0
        S1R_Perc_correct = S1R_N_correct / S1R_N_tot;
    else
        S1R_Perc_correct = nan;
    end;
    
Perf_Stim1R = S1R_Perc_correct
Shapes_Tot_Stim1R = S1R_N_tot
Shapes_Succ_Stim1R = S1R_N_correct
Shapes_Fail_Stim1R = S1R_N_failure

clear I
    
    
% ***** STIM 2 R *******

    I = find( stim_size(1:length(stim_shape)) == 35 & stim_id(1:length(stim_shape)) == 0 & stim_shape == 2 & stim_pos_x ~= 0);
    Pre_S2R_N_correct = length( find(success(I)==1) );
    Pre_S2R_N_failure = length( find(failure(I)==1) );
    Pre_S2R_N_tot = Pre_S2R_N_correct + Pre_S2R_N_failure;
    S2R_N_correct = abs(Pre_S2R_N_correct - Shapes_Succ_Stim2R_M);
    S2R_N_failure = abs(Pre_S2R_N_failure - Shapes_Fail_Stim2R_M);
    S2R_N_tot = S2R_N_correct + S2R_N_failure;
    if S2R_N_tot ~= 0
        S2R_Perc_correct = S2R_N_correct / S2R_N_tot;
    else
        S2R_Perc_correct = nan;
    end;

Perf_Stim2R = S2R_Perc_correct
Shapes_Tot_Stim2R = S2R_N_tot
Shapes_Succ_Stim2R = S2R_N_correct
Shapes_Fail_Stim2R = S2R_N_failure

clear I
    
% ***** STIM 1 L *******

    I = find( stim_size(1:length(stim_shape)) == 35 & stim_id(1:length(stim_shape)) == 1 & stim_shape == 1 & stim_pos_x ~= 0);
    Pre_S1L_N_correct = length( find(success(I)==1) );
    Pre_S1L_N_failure = length( find(failure(I)==1) );
    Pre_S1L_N_tot = Pre_S1L_N_correct + Pre_S1L_N_failure;
    S1L_N_correct = abs(Pre_S1L_N_correct - Shapes_Succ_Stim1L_M);
    S1L_N_failure = abs(Pre_S1L_N_failure - Shapes_Fail_Stim1L_M);
    S1L_N_tot = S1L_N_correct + S1L_N_failure;
    if S1L_N_tot ~= 0
        S1L_Perc_correct = S1L_N_correct / S1L_N_tot;
    else
        S1L_Perc_correct = nan;
    end;
 
Perf_Stim1L = S1L_Perc_correct
Shapes_Tot_Stim1L = S1L_N_tot
Shapes_Succ_Stim1L = S1L_N_correct
Shapes_Fail_Stim1L = S1L_N_failure

clear I
    
% ***** STIM 2 L *******

    I = find( stim_size(1:length(stim_shape)) == 35 & stim_id(1:length(stim_shape)) == 1 & stim_shape == 2 & stim_pos_x ~= 0);
    Pre_S2L_N_correct = length( find(success(I)==1) );
    Pre_S2L_N_failure = length( find(failure(I)==1) );
    Pre_S2L_N_tot = Pre_S2L_N_correct + Pre_S2L_N_failure;
    S2L_N_correct = abs(Pre_S2L_N_correct - Shapes_Succ_Stim2L_M);
    S2L_N_failure = abs(Pre_S2L_N_failure - Shapes_Fail_Stim2L_M);
    S2L_N_tot = S2L_N_correct + S2L_N_failure;
    if S2L_N_tot ~= 0
        S2L_Perc_correct = S2L_N_correct / S2L_N_tot;
    else
        S2L_Perc_correct = nan;
    end;

Perf_Stim2L = S2L_Perc_correct
Shapes_Tot_Stim2L = S2L_N_tot
Shapes_Succ_Stim2L = S2L_N_correct
Shapes_Fail_Stim2L = S2L_N_failure

clear I


% ***** SIZE *******
i=1;
RangeSize = 15:10:35;
for s = RangeSize
    I = find( stim_size == s & stim_pos_x == PosH_default & stim_pos_y == PosV_default & ...
        stim_rot == Rot_default & stim_rot_depth == RotDep_default & FlagBothStimsON == 1 );
    N_correct(i) = length( find(success(I)==1) );
    N_failure(i) = length( find(failure(I)==1) );
    N_tot(i) = N_correct(i) + N_failure(i);
    if N_tot(i) ~= 0
        N_leg{i} = num2str(N_tot(i));
        Perc_correct(i) = N_correct(i) / N_tot(i);
    else
        N_leg{i} = '';
        Perc_correct(i) = nan;
    end;
    i = i+1;
end;

figure;
bar( RangeSize, Perc_correct );
hold on;
text( RangeSize, Perc_correct-0.1, N_leg, 'Color', 'r' );
x_lim = get(gca, 'xlim');
plot( x_lim, [0.5 0.5], '--k' );
set(gca, 'ylim', [0 1.2], 'xlim', [10 40], 'xtick', [15:10:35]);                     %% 'ylim', [0 1], 'XDir', 'reverse');
xlabel('Size');
ylabel('Fraction Correct');
title([FileName, '; Perf_{tot} = ', num2str(TotPerf,4), '%; n_{tot} = ', num2str(Ntrials), ' (', num2str(PercTrialsNoBiasControl,3), '% used)' ])
        
% stuff to save
Size.Perc_correct = Perc_correct;
Size.N_tot = N_tot;
Size.N_correct = N_correct;
Size.N_failure = N_failure;
Size.N_leg = N_leg;
Size.RangeSize = RangeSize;
clear Perc_correct, N_leg; 



% ***** POSITION *******
i=1;
RangePos = -18:6:18;
for p = RangePos
    I = find( stim_size == Size_default_for_StairPosition & stim_pos_x == p & ...
        stim_pos_y == PosV_default & stim_rot == Rot_default & stim_rot_depth == RotDep_default & FlagBothStimsON == 1 );
    N_correct(i) = length( find(success(I)==1) );
    N_failure(i) = length( find(failure(I)==1) );
    N_tot(i) = N_correct(i) + N_failure(i);
    if N_tot(i) ~= 0
        N_leg{i} = num2str(N_tot(i));
        Perc_correct(i) = N_correct(i) / N_tot(i);
    else
        N_leg{i} = '';
        Perc_correct(i) = nan;
    end;
    i = i+1;
end;

figure;
bar( RangePos, Perc_correct );
hold on;
text( RangePos, Perc_correct+0.1, N_leg );
x_lim = get(gca, 'xlim');
plot( x_lim, [0.5 0.5], '--k' );
set(gca, 'ylim', [0 1.2], 'xlim', [-20 20], 'xtick', [-18:6:18]);                                                   %%gca, 'ylim', [0 1.2] );
xlabel('Horizontal Position');
ylabel('Fraction Correct');

% stuff to save
Pos.Perc_correct = Perc_correct;
Pos.N_tot = N_tot;
Pos.N_correct = N_correct;
Pos.N_failure = N_failure;
Pos.N_leg = N_leg;
Pos.RangePos = RangePos;


% ***** ROTATION IN PLANE *******
i=1;
RangeRot = -45:15:45;
for r = RangeRot
    I = find( stim_size == Size_default_for_StairRotation_InPlane & stim_pos_x == PosH_default & ...
        stim_pos_y == PosV_default_InPlane & stim_rot == r & stim_rot_depth == RotDep_default & FlagBothStimsON == 1 );
    N_correct(i) = length( find(success(I)==1) );
    N_failure(i) = length( find(failure(I)==1) );
    N_tot(i) = N_correct(i) + N_failure(i);
    if N_tot(i) ~= 0
        N_leg{i} = num2str(N_tot(i));
        Perc_correct(i) = N_correct(i) / N_tot(i);
    else
        N_leg{i} = '';
        Perc_correct(i) = nan;
    end;
    i = i+1;
end;

figure;
bar( RangeRot, Perc_correct );
hold on;
text( RangeRot, Perc_correct+0.1, N_leg );
x_lim = get(gca, 'xlim');
plot( x_lim, [0.5 0.5], '--k' );
set(gca, 'ylim', [0 1.2], 'xlim', [-50 50], 'xtick', [-75:15:75]);                                %%gca, 'ylim', [0 1.2] );
xlabel('Rotation in Plane');
ylabel('Fraction Correct');

% stuff to save
Rot.Perc_correct = Perc_correct;
Rot.N_tot = N_tot;
Rot.N_correct = N_correct;
Rot.N_failure = N_failure;
Rot.N_leg = N_leg;
Rot.RangeRot = RangeRot;


% ***** ROTATION IN DEPTH *******
i=1;
RangeRotDep = -60:20:60;
for r = RangeRotDep
    I = find( stim_size == Size_default_for_StairRotation & stim_pos_x == PosH_default & ...
        stim_pos_y == PosV_default & stim_rot == Rot_default & stim_rot_depth == r & FlagBothStimsON == 1 );
    N_correct(i) = length( find(success(I)==1) );
    N_failure(i) = length( find(failure(I)==1) );
    N_tot(i) = N_correct(i) + N_failure(i);
    if N_tot(i) ~= 0
        N_leg{i} = num2str(N_tot(i));
        Perc_correct(i) = N_correct(i) / N_tot(i);
    else
        N_leg{i} = '';
        Perc_correct(i) = nan;
    end;
    i = i+1;
end;

figure;
bar( RangeRotDep, Perc_correct );
hold on;
text( RangeRotDep, Perc_correct+0.1, N_leg );
x_lim = get(gca, 'xlim');
plot( x_lim, [0.5 0.5], '--k' );
set(gca, 'ylim', [0 1.2], 'xlim', [-70 70], 'xtick', [-60:20:60]);                                          %%gca, 'ylim', [0 1.2] );
xlabel('Rotation in Depth');
ylabel('Fraction Correct');

% stuff to save
RotDep.Perc_correct = Perc_correct;
RotDep.N_tot = N_tot;
RotDep.N_correct = N_correct;
RotDep.N_failure = N_failure;
RotDep.N_leg = N_leg;
RotDep.RangeRot = RangeRotDep;



% #################################
%   Save summary of data analysis
% #################################
if FlagSave
    Idot = findstr( '.', FileName );
    File2Save = [FileName(1:Idot-5), 'summ.mat'];
%     save( File2Save, 'StairLimit_type', 'I_type', 'success_type', 'failure_type', 'Size', 'Pos', 'Rot', 'RotDep' );
    save( File2Save, 'Size', 'Pos', 'Rot', 'RotDep', 'Perf_Stim1R', 'Shapes_Tot_Stim1R', 'Shapes_Succ_Stim1R', 'Shapes_Fail_Stim1R', ...
        'Perf_Stim2R', 'Shapes_Tot_Stim2R', 'Shapes_Succ_Stim2R', 'Shapes_Fail_Stim2R', ...
        'Perf_Stim1L', 'Shapes_Tot_Stim1L', 'Shapes_Succ_Stim1L', 'Shapes_Fail_Stim1L',...
        'Perf_Stim2L', 'Shapes_Tot_Stim2L', 'Shapes_Succ_Stim2L', 'Shapes_Fail_Stim2L');
end;



%set(gca, 'tickdir', 'out', 'xlim', [0 40], 'xtick', [0:20:40], 'ylim', [30 40.5], 'ytick', [30:2.5:40]);








