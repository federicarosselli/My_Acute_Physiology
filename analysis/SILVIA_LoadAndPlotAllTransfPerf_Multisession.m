function SILVIA_LoadAndPlotAllTransfPerf_Multisession( RatName, FirstFile, LastFile, Other )


%% S1 [49:55]
%% S2 [34:54, 63:93, 95]
%% S3 [] 
%% S4 [8:52, 54:55, 76]
%% S5 [10:56, 71]
%% S6 [38:74, 90:91, 112]


prefix1 = ['r_', RatName,'_b00'];
prefix2 = ['r_', RatName,'_b0'];
prefix3 = ['r_', RatName,'_b'];

suffix = [FirstFile,LastFile, Other];


N_tot_All_Size = [];
N_correct_All_Size = [];
N_tot_All_Pos = [];
N_correct_All_Pos = [];
N_tot_All_InPl = [];
N_correct_All_InPl = [];
N_tot_All_InDp = [];
N_correct_All_InDp = [];
N_correct_All = [];

RangeSize_All = [];
RangePos_All = [];
RangeRot_All = [];
RangeRotDep_All = [];

N_leg_All_Size = [];
N_leg_All_Pos = [];
N_leg_All_InPl = [];
N_leg_All_InDp = [];

Size_Perf_Sess_All = [];
Pos_Perf_Sess_All = [];
Rot_Perf_Sess_All = [];
RotDep_Perf_Sess_All = [];

session = 0;

for i=suffix
    session = session+1;
    if i<10
    FileName = [prefix1, num2str(i),'_summ.mat'];

    elseif i >=10 && i<100
        FileName = [prefix2, num2str(i),'_summ.mat'];
    else
        FileName = [prefix3, num2str(i),'_summ.mat'];

    end;
    load ( FileName );
    N_tot_All_Size = vertcat(N_tot_All_Size, Size.N_tot);
    N_correct_All_Size = vertcat(N_correct_All_Size, Size.N_correct);
    N_leg_All_Size = vertcat(N_leg_All_Size, Size.N_leg);
    
    RangeSize_All = Size.RangeSize;
    Size_Perf_Sess_All = N_correct_All_Size *100 ./ N_tot_All_Size;
    Size_Perf_Sess_All(isnan(Size_Perf_Sess_All)) = 0;
    Size_Perf_Sess = mean(Size_Perf_Sess_All(:,1:length(RangeSize_All)));
    S_Size_Perf_Sess = std(Size_Perf_Sess_All);
    
    

    
%     %% keeps performances for individual sessions
%     Size_Perf_Sess_All = [Size_Perf_Sess, Size_Perf_Sess_All];
    
    
    N_tot_All_Pos = vertcat(N_tot_All_Pos, Pos.N_tot);
    N_correct_All_Pos = vertcat(N_correct_All_Pos, Pos.N_correct);
    N_leg_All_Pos = vertcat(N_leg_All_Pos, Pos.N_leg);
    
    RangePos_All = Pos.RangePos;
    Pos_Perf_Sess_All = N_correct_All_Pos *100 ./ N_tot_All_Pos;
    Pos_Perf_Sess_All(isnan(Pos_Perf_Sess_All)) = 0;
    Pos_Perf_Sess = mean(Pos_Perf_Sess_All(:,1:length(RangePos_All)));
    S_Pos_Perf_Sess = std(Pos_Perf_Sess_All);
    
%     Pos_Perf_Sess_All = [Pos_Perf_Sess_All, Pos_Perf_Sess];
    
    
    N_tot_All_InPl = vertcat(N_tot_All_InPl, Rot.N_tot);
    N_correct_All_InPl = vertcat(N_correct_All_InPl, Rot.N_correct);
    N_leg_All_InPl = vertcat(N_leg_All_InPl, Rot.N_leg);
    
    RangeRot_All = Rot.RangeRot;
    Rot_Perf_Sess_All = N_correct_All_InPl *100 ./ N_tot_All_InPl;
    Rot_Perf_Sess_All(isnan(Rot_Perf_Sess_All)) = 0;
    Rot_Perf_Sess = mean(Rot_Perf_Sess_All(:,1:length(RangeRot_All)));
    S_Rot_Perf_Sess = std(Rot_Perf_Sess_All);
    
%     Rot_Perf_Sess_All = [Rot_Perf_Sess_All, Rot_Perf_Sess];
    
    N_tot_All_InDp = vertcat(N_tot_All_InDp, RotDep.N_tot);
    N_correct_All_InDp = vertcat(N_correct_All_InDp, RotDep.N_correct);
    N_leg_All_InDp = vertcat(N_leg_All_InDp, RotDep.N_leg);
    
    RangeRotDep_All = RotDep.RangeRot;
    RotDep_Perf_Sess_All = N_correct_All_InDp *100 ./ N_tot_All_InDp;
    RotDep_Perf_Sess_All(isnan(RotDep_Perf_Sess_All)) = 0;
    RotDep_Perf_Sess = mean(RotDep_Perf_Sess_All(:,1:length(RangeRotDep_All)));
    S_RotDep_Perf_Sess = std(RotDep_Perf_Sess_All);
    
%     RotDep_Perf_Sess_All = [RotDep_Perf_Sess_All, RotDep_Perf_Sess];
    
%     N_correct_All = [N_correct_All_Size, N_correct_All_Pos, N_correct_All_InPl, N_correct_All_InDp];
    


    
end;

NumSessions = session;

Size_Perf_Sess(Size_Perf_Sess==0)=NaN;
Pos_Perf_Sess(Pos_Perf_Sess==0)=NaN;
Rot_Perf_Sess (Rot_Perf_Sess==0)=NaN;
RotDep_Perf_Sess (RotDep_Perf_Sess==0)=NaN;

SE_Size_Perf_Sess = S_Size_Perf_Sess ./ sqrt (NumSessions);
SE_Pos_Perf_Sess = S_Pos_Perf_Sess ./ sqrt (NumSessions);
SE_Rot_Perf_Sess = S_Rot_Perf_Sess ./ sqrt (NumSessions);
SE_RotDep_Perf_Sess = S_RotDep_Perf_Sess ./ sqrt (NumSessions);


% SE_Size_Perf_Sess = S_Size_Perf_Sess ./ sqrt (length(NumSessions));
% SE_Pos_Perf_Sess = S_Pos_Perf_Sess ./ sqrt (length(NumSessions));
% SE_Rot_Perf_Sess = S_Rot_Perf_Sess ./ sqrt (length(NumSessions));
% SE_RotDep_Perf_Sess = S_RotDep_Perf_Sess ./ sqrt (length(NumSessions));
    

SE_Size_Perf_Sess(SE_Size_Perf_Sess==0)=NaN;
SE_Pos_Perf_Sess(SE_Pos_Perf_Sess==0)=NaN;
SE_Rot_Perf_Sess(SE_Rot_Perf_Sess==0)=NaN;
SE_RotDep_Perf_Sess(SE_RotDep_Perf_Sess==0)=NaN;

% % plots only size 35 for each session
% SessionS = 1:i;
% figure;
% bar (SessionS, Size_Perf_Sess_All, 'facecolor',[.5 1 .5]);
% hold on;
% set (gca, 'ylim', [0 100]);
% xlabel('Session #', 'fontsize', 12);
% ylabel('Performance', 'fontsize', 12);
% legend('Shapes Only', 'fontsize', 12);
% title (RatName, 'fontsize', 14);


figure;
subplot(2,2,1); plot(Size.RangeSize, Size_Perf_Sess, 'o', 'markerfacecolor',[1 0 0]);
hold on;
errorbar (Size.RangeSize, Size_Perf_Sess, SE_Size_Perf_Sess, 'k');
hold on;
set (gca, 'ylim', [30 100], 'xlim', [12.5 37.5], 'xtick', [15:10:35]);
x_lim = get(gca, 'xlim');
plot( x_lim, [50 50], '--k' );
xlabel(['Session # = ', num2str(NumSessions)], 'fontsize', 12);
legend ('Size');
title (RatName, 'fontsize', 14);


subplot(2,2,2); plot(Pos.RangePos, Pos_Perf_Sess, 'o', 'markerfacecolor',[0 0 1]);
hold on;
errorbar (Pos.RangePos, Pos_Perf_Sess, SE_Pos_Perf_Sess, 'k');
hold on;
set (gca, 'ylim', [30 100], 'xlim', [-22.5 22.5], 'xtick', [-18:6:18]);
x_lim = get(gca, 'xlim');
plot( x_lim, [50 50], '--k' );
xlabel(['Session # = ', num2str(NumSessions)], 'fontsize', 12);
legend ('Positions');
title (RatName, 'fontsize', 14);

subplot(2,2,3); plot(RotDep.RangeRot, RotDep_Perf_Sess, 'o', 'markerfacecolor',[0 1 0]);
hold on;
errorbar (RotDep.RangeRot, RotDep_Perf_Sess, SE_RotDep_Perf_Sess, 'k');
hold on;
set (gca, 'ylim', [30 100], 'xlim', [-70 70], 'xtick', [-60:20:60]);
x_lim = get(gca, 'xlim');
plot( x_lim, [50 50], '--k' );
xlabel(['Session # = ', num2str(NumSessions)], 'fontsize', 12);
legend ('Azimuth');
title (RatName, 'fontsize', 14);

subplot(2,2,4); plot(Rot.RangeRot, Rot_Perf_Sess, 'o', 'markerfacecolor',[1 0 1]);
hold on;
errorbar (Rot.RangeRot, Rot_Perf_Sess, SE_Rot_Perf_Sess, 'k');
hold on;
set (gca, 'ylim', [30 100], 'xlim', [-50 50], 'xtick', [-45:15:45]);
x_lim = get(gca, 'xlim');
plot( x_lim, [50 50], '--k' );
xlabel(['Session # = ', num2str(NumSessions)], 'fontsize', 12);
legend ('InPlane');
title (RatName, 'fontsize', 14);









