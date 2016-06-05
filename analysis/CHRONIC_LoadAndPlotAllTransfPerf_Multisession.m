function CHRONIC_LoadAndPlotAllTransfPerf_Multisession( RatName, FirstFile, LastFile )


prefix1 = ['r_', RatName,'_c00'];
prefix2 = ['r_', RatName,'_c0'];
suffix = [FirstFile:LastFile];


N_tot_All_Size = 0;
N_correct_All_Size = 0;
N_tot_All_Pos = 0;
N_correct_All_Pos = 0;
N_tot_All_InPl = 0;
N_correct_All_InPl = 0;
N_tot_All_InDp = 0;
N_correct_All_InDp = 0;
N_correct_All = 0;

RangeSize_All = [];
RangePos_All = [];
RangeRot_All = [];
RangeRotDep_All = [];

N_leg_All_Size = [];
N_leg_All_Pos = [];
N_leg_All_InPl = [];
N_leg_All_InDp = [];

for i=suffix
    if i<10
        FileName = [prefix1, num2str(i),'_summ.mat'];
    else
        FileName = [prefix2, num2str(i),'_summ.mat'];
    end;
    load (FileName);
    
    N_tot_All_Size = N_tot_All_Size + Size.N_tot;
    N_correct_All_Size = N_correct_All_Size + Size.N_correct;
%     N_leg_All_Size = Size.N_leg;
    
    RangeSize_All = Size.RangeSize;
    Size_Perf_Sess = N_correct_All_Size *100 ./ N_tot_All_Size;
    
    
    N_tot_All_Pos = N_tot_All_Pos + Pos.N_tot;
    N_correct_All_Pos = N_correct_All_Pos + Pos.N_correct;
%     N_leg_All_Pos = N_leg_All_Pos + Pos.N_leg;
    
    RangePos_All = Pos.RangePos;
    Pos_Perf_Sess = N_correct_All_Pos *100 ./ N_tot_All_Pos;
    
    
    N_tot_All_InPl = N_tot_All_InPl + Rot.N_tot;
    N_correct_All_InPl = N_correct_All_InPl + Rot.N_correct;
%     N_leg_All_InPl = Rot.N_leg;
    
    RangeRot_All = Rot.RangeRot;
    Rot_Perf_Sess = N_correct_All_InPl *100 ./ N_tot_All_InPl;
    
    N_tot_All_InDp = N_tot_All_InDp + RotDep.N_tot;
    N_correct_All_InDp = N_correct_All_InDp + RotDep.N_correct;
%     N_leg_All_InDp = RotDep.N_leg;
    
    RangeRotDep_All = RotDep.RangeRot;
    RotDep_Perf_Sess = N_correct_All_InDp *100 ./ N_tot_All_InDp;
    
    N_correct_All = [N_correct_All_Size, N_correct_All_Pos, N_correct_All_InPl, N_correct_All_InDp];
    N_tot_All = [N_tot_All_Size, N_tot_All_Pos, N_tot_All_InPl, N_tot_All_InDp];
    All_Trials = sum (N_tot_All);

    
end;


figure;
plot (RangeSize_All, Size_Perf_Sess, '-ok');
hold on;
set(gca, 'ylim', [0 100], 'xlim', [5 31], 'xtick', [10:8:26]);
% x_lim = get(gca, 'xlim');
% plot( x_lim, [50 50], '--k' );
%text(RangeSize_All, Size_Perf_Sess+3, N_leg_All_Size);
legend ('Size');
%title ([RatName, '; Tot Number of trials =', num2str(N_tot_All)])


figure;
plot (RangePos_All, Pos_Perf_Sess, '-ob');
hold on;
set(gca, 'ylim', [0 100], 'xlim', [-14 14], 'xtick', [-12, -6, 6, 12]); 
%x_lim = get(gca, 'xlim');
%plot( x_lim, [50 50], '--k' );
%text(Pos.RangePos, Pos_Perf_Sess+3, N_leg_All_Pos);
legend ('Positions');

figure;
plot (RangeRotDep_All, RotDep_Perf_Sess, '-or');
hold on;
set(gca, 'ylim', [0 100], 'xlim', [-70 70], 'xtick', [-60, -40, 40, 60]);     
% x_lim = get(gca, 'xlim');
% plot( x_lim, [50 50], '--k' );
%text(Rot.RangeRot, Rot_Perf_Sess+3, N_leg_All_InDp);
legend ('Azimuth');

figure;
plot (RangeRot_All, Rot_Perf_Sess, '-og');
hold on;
set(gca, 'ylim', [0 100], 'xlim', [-50 50], 'xtick', [-45, -27, 27, 45]);
% x_lim = get(gca, 'xlim');
% plot( x_lim, [50 50], '--k' );
%text(Rot.RangeRot, Rot_Perf_Sess+3, N_leg_All_InPl);
legend ('InPlane');









