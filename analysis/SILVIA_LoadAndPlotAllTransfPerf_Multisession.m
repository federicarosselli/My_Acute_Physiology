function SILVIA_LoadAndPlotAllTransfPerf_Multisession( RatName, FirstFile, LastFile )


prefix1 = ['r_', RatName,'_b00'];
prefix2 = ['r_', RatName,'_b0'];
suffix = [FirstFile:LastFile];


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

for i=suffix
    if i<10
        FileName = [prefix1, num2str(i),'_summ.mat'];
    else
        FileName = [prefix2, num2str(i),'_summ.mat'];
    end;
    load (FileName);
    
    N_tot_All_Size = [N_tot_All_Size, Size.N_tot];
    N_correct_All_Size = [N_correct_All_Size, Size.N_correct];
    N_leg_All_Size = [N_leg_All_Size, Size.N_leg];
    
    RangeSize_All = Size.RangeSize;
    Size_Perf_Sess = N_correct_All_Size *100 ./ N_tot_All_Size;
    
    %% keeps performances for individual sessions
    Size_Perf_Sess_All = [Size_Perf_Sess, Size_Perf_Sess_All];
    
    
    N_tot_All_Pos = [N_tot_All_Pos, Pos.N_tot];
    N_correct_All_Pos = [N_correct_All_Pos, Pos.N_correct];
    N_leg_All_Pos = [N_leg_All_Pos, Pos.N_leg];
    
    RangePos_All = Pos.RangePos;
    Pos_Perf_Sess = N_correct_All_Pos *100 ./ N_tot_All_Pos;
    
    Pos_Perf_Sess_All = [Pos_Perf_Sess_All, Pos_Perf_Sess];
    
    
    N_tot_All_InPl = [N_tot_All_InPl, Rot.N_tot];
    N_correct_All_InPl = [N_correct_All_InPl, Rot.N_correct];
    N_leg_All_InPl = [N_leg_All_InPl, Rot.N_leg];
    
    RangeRot_All = Rot.RangeRot;
    Rot_Perf_Sess = N_correct_All_InPl *100 ./ N_tot_All_InPl;
    
    Rot_Perf_Sess_All = [Rot_Perf_Sess_All, Rot_Perf_Sess];
    
    N_tot_All_InDp = [N_tot_All_InDp, RotDep.N_tot];
    N_correct_All_InDp = [N_correct_All_InDp, RotDep.N_correct];
    N_leg_All_InDp = [N_leg_All_InDp, RotDep.N_leg];
    
    RangeRotDep_All = RotDep.RangeRot;
    RotDep_Perf_Sess = N_correct_All_InDp *100 ./ N_tot_All_InDp;
    
    RotDep_Perf_Sess_All = [RotDep_Perf_Sess_All, RotDep_Perf_Sess];
    
    N_correct_All = [N_correct_All_Size, N_correct_All_Pos, N_correct_All_InPl, N_correct_All_InDp];
    
%     N_tot_All_Size = N_tot_All_Size + Size.N_tot;
%     N_correct_All_Size = N_correct_All_Size + Size.N_correct;
%     N_leg_All_Size = [N_leg_All_Size, Size.N_leg];
%     
%     RangeSize_All = Size.RangeSize;
%     Size_Perf_Sess = N_correct_All_Size *100 ./ N_tot_All_Size;
%     
%     %% keeps performances for individual sessions
%     Size_Perf_Sess_All = [Size_Perf_Sess_All, Size_Perf_Sess(end)];
%     
%     
%     N_tot_All_Pos = N_tot_All_Pos + Pos.N_tot;
%     N_correct_All_Pos = N_correct_All_Pos + Pos.N_correct;
%     N_leg_All_Pos = [N_leg_All_Pos, Pos.N_leg];
%     
%     RangePos_All = Pos.RangePos;
%     Pos_Perf_Sess = N_correct_All_Pos *100 ./ N_tot_All_Pos;
%     
%     
%     N_tot_All_InPl = N_tot_All_InPl + Rot.N_tot;
%     N_correct_All_InPl = N_correct_All_InPl + Rot.N_correct;
%     N_leg_All_InPl = [N_leg_All_InPl, Rot.N_leg];
%     
%     RangeRot_All = Rot.RangeRot;
%     Rot_Perf_Sess = N_correct_All_InPl *100 ./ N_tot_All_InPl;
%     
%     N_tot_All_InDp = N_tot_All_InDp + RotDep.N_tot;
%     N_correct_All_InDp = N_correct_All_InDp + RotDep.N_correct;
%     N_leg_All_InDp = [N_leg_All_InDp, RotDep.N_leg];
%     
%     RangeRotDep_All = RotDep.RangeRot;
%     RotDep_Perf_Sess = N_correct_All_InDp *100 ./ N_tot_All_InDp;
%     
%     N_correct_All = [N_correct_All_Size, N_correct_All_Pos, N_correct_All_InPl, N_correct_All_InDp];

    
end;

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
subplot(2,2,1); bar(Size.RangeSize, Size_Perf_Sess, 'facecolor',[1 0 0]);
hold on;
set (gca, 'ylim', [30 100], 'xlim', [12.5 37.5], 'xtick', [15:10:35]);
% x_lim = get(gca, 'xlim');
% plot( x_lim, [50 50], '--k' );
%text(Size.RangeSize, Size_Perf_Sess+3, N_leg_All);
legend ('Size');
title (RatName, 'fontsize', 14);


subplot(2,2,2); bar(Pos.RangePos, Pos_Perf_Sess, 'facecolor',[0 0 1]);
hold on;
set (gca, 'ylim', [30 100], 'xlim', [-22.5 22.5], 'xtick', [-18:6:18]);
%x_lim = get(gca, 'xlim');
%plot( x_lim, [50 50], '--k' );
%text(Pos.RangePos, Pos_Perf_Sess+3, N_leg_All);
legend ('Positions');
title (RatName, 'fontsize', 14);

subplot(2,2,3); bar(RotDep.RangeRot, RotDep_Perf_Sess, 'facecolor',[0 1 0]);
hold on;
set (gca, 'ylim', [30 100], 'xlim', [-70 70], 'xtick', [-60:20:60]);
% x_lim = get(gca, 'xlim');
% plot( x_lim, [50 50], '--k' );
%text(Rot.RangeRot, Rot_Perf_Sess+3, N_leg_All);
legend ('Azimuth');
title (RatName, 'fontsize', 14);

subplot(2,2,4); bar(Rot.RangeRot, Rot_Perf_Sess, 'facecolor',[1 0 1]);
hold on;
set (gca, 'ylim', [30 100], 'xlim', [-50 50], 'xtick', [-45:15:45]);
% x_lim = get(gca, 'xlim');
% plot( x_lim, [50 50], '--k' );
% text(Rot.RangeRot, Rot_Perf_Sess+3, N_leg_All);
legend ('InPlane');
title (RatName, 'fontsize', 14);









