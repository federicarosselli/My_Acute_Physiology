function SILVIA_LoadAndPlotMotionPerf_MultiSession( RatName, FirstFile, LastFile )


%% e.g. SILVIA_LoadAndPlotMotionPerf_MultiSession( 'S6', 14, 30 )
%% e.g. SILVIA_LoadAndPlotMotionPerf_MultiSession( 'S2', 11, 24 )

%% note: S6: the actual motion sessions start from b014
%% S2: the actual motion sessions start from b011

prefix1 = ['r_', RatName,'_b00'];
prefix2 = ['r_', RatName,'_b0'];
suffix = [FirstFile:LastFile];

Perf_Shapes_All = [];
Perf_MovingShapes_All = [];
Perf_MovingShapes_M_All = [];
Perf_G_All = [];
Perf_Dots_All = [];

Perf_Stim1_All = [];
Perf_Stim2_All = [];
Perf_Stim1L_All = [];
Perf_Stim2L_All = [];
Perf_Stim1R_All = [];
Perf_Stim2R_All = [];
Perf_Stim1L_M_All = [];
Perf_Stim2L_M_All = [];
Perf_Stim1R_M_All = [];
Perf_Stim2R_M_All = [];
Perf_DotL_All = [];
Perf_DotR_All = [];
Perf_GL_All = [];
Perf_GR_All = [];

Shapes_Succ_Stim1_All = [];
Shapes_Succ_Stim2_All = [];
Shapes_Fail_Stim1_All = [];
Shapes_Fail_Stim2_All = [];
Shapes_Succ_Stim1L_All = [];
Shapes_Succ_Stim2L_All = [];
Shapes_Fail_Stim1L_All = [];
Shapes_Fail_Stim2L_All = [];
Shapes_Succ_Stim1R_All = [];
Shapes_Succ_Stim2R_All = [];
Shapes_Fail_Stim1R_All = [];
Shapes_Fail_Stim2R_All = [];

Shapes_Succ_Stim1L_M_All = [];
Shapes_Succ_Stim2L_M_All = [];
Shapes_Fail_Stim1L_M_All = [];
Shapes_Fail_Stim2L_M_All = [];
Shapes_Succ_Stim1R_M_All = [];
Shapes_Succ_Stim2R_M_All = [];
Shapes_Fail_Stim1R_M_All = [];
Shapes_Fail_Stim2R_M_All = [];

Dots_Succ_DotL_All = [];
Dots_Succ_DotR_All = [];
Dots_Fail_DotL_All = [];
Dots_Fail_DotR_All = [];
G_Succ_GL_All = [];
G_Succ_GR_All = [];
G_Fail_GL_All = [];
G_Fail_GR_All = [];



for i=suffix
    if i<10
    FileName = [prefix1, num2str(i),'_summ.mat'];
    else
        FileName = [prefix2, num2str(i),'_summ.mat'];
    end;
    load ( FileName );
    
        if exist ('Perf_Shapes')
            Perf_Shapes_All = [Perf_Shapes_All, Perf_Shapes]; 
        else
            Perf_Shapes_All = [];
        end
        
        if exist ('Perf_MovingShapes')
            Perf_MovingShapes_All = [Perf_MovingShapes_All, Perf_MovingShapes]; 
        else
            Perf_MovingShapes_All = [];
        end
        
        if exist ('Perf_MovingShapes_M')
            Perf_MovingShapes_M_All = [Perf_MovingShapes_M_All, Perf_MovingShapes_M]; 
        else
            Perf_MovingShapes_M_All = [];
        end
        
        
        if exist ('Perf_Dots')
            Perf_Dots_All = [Perf_Dots_All, Perf_Dots];
        else
            Perf_Dots_All = [];
        end
        
        if exist ('Perf_G')
            Perf_G_All = [Perf_G_All, Perf_G];
        else
            Perf_G_All = [];
        end
        
        if exist ('Perf_Stim1')
            Perf_Stim1_All = [Perf_Stim1_All, Perf_Stim1];
        else
            Perf_Stim1_All = [];
        end
        
        if exist ('Perf_Stim2')
            Perf_Stim2_All = [Perf_Stim2_All, Perf_Stim2];
        else
            Perf_Stim2_All = [];
        end
        
        if exist ('Perf_Stim1_L')
            Perf_Stim1L_All = [Perf_Stim1L_All, Perf_Stim1_L];
        else
            Perf_Stim1L_All = [];
        end
        
        if exist ('Perf_Stim2_L')
            Perf_Stim2L_All = [Perf_Stim2L_All, Perf_Stim2_L];
        else
            Perf_Stim2L_All = [];
        end
        
        if exist ('Perf_Stim1_R')
            Perf_Stim1R_All = [Perf_Stim1R_All, Perf_Stim1_R];
        else
            Perf_Stim1R_All = [];
        end
        
        if exist ('Perf_Stim2_R')
            Perf_Stim2R_All = [Perf_Stim2R_All, Perf_Stim2_R];
        else
            Perf_Stim2R_All = [];
        end
        
        if exist ('Perf_Stim1_L_M')
            Perf_Stim1L_M_All = [Perf_Stim1L_M_All, Perf_Stim1_L_M];
        else
            Perf_Stim1L_M_All = [];
        end
        
        if exist ('Perf_Stim2_L_M')
            Perf_Stim2L_M_All = [Perf_Stim2L_M_All, Perf_Stim2_L_M];
        else
            Perf_Stim2L_M_All = [];
        end
        
        if exist ('Perf_Stim1_R_M')
            Perf_Stim1R_M_All = [Perf_Stim1R_M_All, Perf_Stim1_R_M];
        else
            Perf_Stim1R_M_All = [];
        end
        
        if exist ('Perf_Stim2_R_M')
            Perf_Stim2R_M_All = [Perf_Stim2R_M_All, Perf_Stim2_R_M];
        else
            Perf_Stim2R_M_All = [];
        end
        
        if exist ('Perf_DotL')
            Perf_DotL_All = [Perf_DotL_All, Perf_DotL];
        else
            Perf_DotL_All = [];
        end
        
        if exist ('Perf_DotR')
            Perf_DotR_All = [Perf_DotR_All, Perf_DotR]; 
        else
            Perf_DotR_All =[];
        end
        
        if exist ('Perf_GL')    
            Perf_GL_All = [Perf_GL_All, Perf_GL];
        else
            Perf_GL_All = [];
        end
        
        if exist ('Perf_GR')
            Perf_GR_All = [Perf_GR_All, Perf_GR]; 
        else
            Perf_GR_All = [];
        end
    
        
        if exist ('Shapes_Succ_Stim1')
            Shapes_Succ_Stim1_All = [Shapes_Succ_Stim1_All, Shapes_Succ_Stim1];
            Shapes_Fail_Stim1_All = [Shapes_Fail_Stim1_All, Shapes_Fail_Stim1];
        else
            Shapes_Succ_Stim1_All = [];
            Shapes_Fail_Stim1_All = [];
        end
        
        if exist ('Shapes_Succ_Stim2')
            Shapes_Succ_Stim2_All = [Shapes_Succ_Stim2_All, Shapes_Succ_Stim2];
            Shapes_Fail_Stim2_All = [Shapes_Fail_Stim2_All, Shapes_Fail_Stim2];
        else
            Shapes_Succ_Stim2_All = [];
            Shapes_Fail_Stim2_All = [];
        end
        
        
        if exist ('Shapes_Succ_Stim1L')   
            Shapes_Succ_Stim1L_All = [Shapes_Succ_Stim1L_All, Shapes_Succ_Stim1L];
            Shapes_Fail_Stim1L_All = [Shapes_Fail_Stim1L_All, Shapes_Fail_Stim1L];
        else
            Shapes_Succ_Stim1L_All = [];
            Shapes_Fail_Stim1L_All = [];
        end
        
        if exist ('Shapes_Succ_Stim2L')   
            Shapes_Succ_Stim2L_All = [Shapes_Succ_Stim2L_All, Shapes_Succ_Stim2L];
            Shapes_Fail_Stim2L_All = [Shapes_Fail_Stim2L_All, Shapes_Fail_Stim2L];
        else
            Shapes_Succ_Stim2L_All = [];
            Shapes_Fail_Stim2L_All = [];
        end
        
        if exist ('Shapes_Succ_Stim1R')    
            Shapes_Succ_Stim1R_All = [Shapes_Succ_Stim1R_All, Shapes_Succ_Stim1R];
            Shapes_Fail_Stim1R_All = [Shapes_Fail_Stim1R_All, Shapes_Fail_Stim1R];
        else
            Shapes_Succ_Stim1R_All = [];
            Shapes_Fail_Stim1R_All = [];
        end
        
        if exist ('Shapes_Succ_Stim2R')    
            Shapes_Succ_Stim2R_All = [Shapes_Succ_Stim2R_All, Shapes_Succ_Stim2R];
            Shapes_Fail_Stim2R_All = [Shapes_Fail_Stim2R_All, Shapes_Fail_Stim2R];
        else
            Shapes_Succ_Stim2R_All = [];
            Shapes_Fail_Stim2R_All = [];
        end
        
        if exist ('Shapes_Succ_Stim1L_M')   
            Shapes_Succ_Stim1L_M_All = [Shapes_Succ_Stim1L_M_All, Shapes_Succ_Stim1L_M];
            Shapes_Fail_Stim1L_M_All = [Shapes_Fail_Stim1L_M_All, Shapes_Fail_Stim1L_M];
        else
            Shapes_Succ_Stim1L_M_All = [];
            Shapes_Fail_Stim1L_M_All = [];
        end
        
        if exist ('Shapes_Succ_Stim2L_M')   
            Shapes_Succ_Stim2L_M_All = [Shapes_Succ_Stim2L_M_All, Shapes_Succ_Stim2L_M];
            Shapes_Fail_Stim2L_M_All = [Shapes_Fail_Stim2L_M_All, Shapes_Fail_Stim2L_M];
        else
            Shapes_Succ_Stim2L_M_All = [];
            Shapes_Fail_Stim2L_M_All = [];
        end
        
        if exist ('Shapes_Succ_Stim1R_M')   
            Shapes_Succ_Stim1R_M_All = [Shapes_Succ_Stim1R_M_All, Shapes_Succ_Stim1R_M];
            Shapes_Fail_Stim1R_M_All = [Shapes_Fail_Stim1R_M_All, Shapes_Fail_Stim1R_M];
        else
            Shapes_Succ_Stim1R_M_All = [];
            Shapes_Fail_Stim1R_M_All = [];
        end
        
        if exist ('Shapes_Succ_Stim2R_M')   
            Shapes_Succ_Stim2R_M_All = [Shapes_Succ_Stim2R_M_All, Shapes_Succ_Stim2R_M];
            Shapes_Fail_Stim2R_M_All = [Shapes_Fail_Stim2R_M_All, Shapes_Fail_Stim2R_M];
        else
            Shapes_Succ_Stim2R_M_All = [];
            Shapes_Fail_Stim2R_M_All = [];
        end
        
        if exist ('Dots_Succ_DotL')   
            Dots_Succ_DotL_All = [Dots_Succ_DotL_All, Dots_Succ_DotL];
            Dots_Fail_DotL_All = [Dots_Fail_DotL_All, Dots_Fail_DotL];
        else
            Dots_Succ_DotL_All = [];
            Dots_Fail_DotL_All = [];
        end
        
        if exist ('Dots_Succ_DotR')   
            Dots_Succ_DotR_All = [Dots_Succ_DotR_All, Dots_Succ_DotR];
            Dots_Fail_DotR_All = [Dots_Fail_DotR_All, Dots_Fail_DotR];
        else
            Dots_Succ_DotR_All = [];
            Dots_Fail_DotR_All = [];
        end
        
        if exist ('G_Succ_GL')   
            G_Succ_GL_All = [G_Succ_GL_All, G_Succ_GL];
            G_Fail_GL_All = [G_Fail_GL_All, G_Fail_GL];
        else
            G_Succ_GL_All = [];
            G_Fail_GL_All = [];
        end
        
        if exist ('G_Succ_GR')   
            G_Succ_GR_All = [G_Succ_GR_All, G_Succ_GR];
            G_Fail_GR_All = [G_Fail_GR_All, G_Fail_GR];
        else
            G_Succ_GR_All = [];
            G_Fail_GR_All = [];
        end
    
    
end;


% Plots

%All_Together = [Perf_Shapes_All; Perf_Dots_All; Perf_Stim1_All; Perf_Stim2_All; Perf_DotL_All; Perf_DotR_All];


% shapes
sessionS = 1:length(Perf_Shapes_All);
figure;
bar(sessionS, Perf_Shapes_All, 'facecolor',[.2 .2 .2]);
hold on;
set (gca, 'ylim', [0 100]);
xlabel('Session #', 'fontsize', 12);
ylabel('Performance', 'fontsize', 12);
legend('Shapes', 'fontsize', 12);
title (RatName, 'fontsize', 14);

%moving shapes 1
sessionS = 1:length(Perf_MovingShapes_All);
figure;
bar(sessionS, Perf_MovingShapes_All, 'facecolor',[.4 .4 .4]);
hold on;
set (gca, 'ylim', [0 100]);
xlabel('Session #', 'fontsize', 12);
ylabel('Performance', 'fontsize', 12);
legend('Moving Shapes 1', 'fontsize', 12);
title (RatName, 'fontsize', 14);

%moving shapes 2
sessionS = 1:length(Perf_MovingShapes_M_All);
figure;
bar(sessionS, Perf_MovingShapes_M_All, 'facecolor',[.6 .6 .6]);
hold on;
set (gca, 'ylim', [0 100]);
xlabel('Session #', 'fontsize', 12);
ylabel('Performance', 'fontsize', 12);
legend('Moving Shapes 2', 'fontsize', 12);
title (RatName, 'fontsize', 14);

% dots
sessionS = 1:length(Perf_Dots_All);
figure;
bar(sessionS, Perf_Dots_All, 'facecolor',[.8 .8 .8]);
hold on;
set (gca, 'ylim', [0 100]);
xlabel('Session #', 'fontsize', 12);
ylabel('Performance', 'fontsize', 12);
legend('Dots', 'fontsize', 12);
title (RatName, 'fontsize', 14);

%gratings
sessionS = 1:length(Perf_G_All);
figure;
bar(sessionS, Perf_G_All, 'facecolor',[1 1 1]);
hold on;
set (gca, 'ylim', [0 100]);
xlabel('Session #', 'fontsize', 12);
ylabel('Performance', 'fontsize', 12);
legend('Gratings', 'fontsize', 12);
title (RatName, 'fontsize', 14);


% Ent All Together
sessionS = 1:length(Perf_Stim1_All);
figure;
bar(sessionS, Perf_Stim1_All, 'facecolor',[1 0 0]);
hold on;
set (gca, 'ylim', [0 100]);
xlabel('Session #', 'fontsize', 12);
ylabel('Performance', 'fontsize', 12);
legend('Stim 1', 'fontsize', 12);
title (RatName, 'fontsize', 12);

sessionS = 1:length(Perf_Stim1L_All);
if ~isempty(sessionS)
figure;
subplot(2,2,1); bar(sessionS, Perf_Stim1L_All, 'facecolor',[1 .8 0]);
hold on;
set (gca, 'ylim', [0 100]);
xlabel('Session #', 'fontsize', 12);
ylabel('Performance', 'fontsize', 12);
legend('Stim1 L', 'fontsize', 12);
title (RatName, 'fontsize', 12);

subplot(2,2,2); bar(sessionS, Perf_Stim1R_All, 'facecolor',[0 0 1]);
hold on;
set (gca, 'ylim', [0 100]);
xlabel('Session #', 'fontsize', 12);
ylabel('Performance', 'fontsize', 12);
legend('Stim1 R', 'fontsize', 12);
title (RatName, 'fontsize', 12);


subplot(2,2,3); bar(sessionS, Perf_Stim1L_M_All, 'facecolor',[1 .8 0]);
hold on;
set (gca, 'ylim', [0 100]);
xlabel('Session #', 'fontsize', 12);
ylabel('Performance', 'fontsize', 12);
legend('Stim1 LM', 'fontsize', 12);
title (RatName, 'fontsize', 12);

subplot(2,2,4); bar(sessionS, Perf_Stim1R_M_All, 'facecolor',[0 0 1]);
hold on;
set (gca, 'ylim', [0 100]);
xlabel('Session #', 'fontsize', 12);
ylabel('Performance', 'fontsize', 12);
legend('Stim1 RM', 'fontsize', 12);
title (RatName, 'fontsize', 12);

end


% Bunny All Together
sessionS = 1:length(Perf_Stim2_All);
figure;
bar(sessionS, Perf_Stim2_All, 'facecolor',[1 0 0]);
hold on;
set (gca, 'ylim', [0 100]);
xlabel('Session #', 'fontsize', 12);
ylabel('Performance', 'fontsize', 12);
legend('Stim 2', 'fontsize', 12);
title (RatName, 'fontsize', 12);


sessionS = 1:length(Perf_Stim2L_All);
if ~isempty(sessionS)
figure;
subplot(2,2,1); bar(sessionS, Perf_Stim2L_All, 'facecolor',[1 .8 0]);
hold on;
set (gca, 'ylim', [0 100]);
xlabel('Session #', 'fontsize', 12);
ylabel('Performance', 'fontsize', 12);
legend('Stim2 L', 'fontsize', 12);
title (RatName, 'fontsize', 12);

subplot(2,2,2); bar(sessionS, Perf_Stim2R_All, 'facecolor',[0 0 1]);
hold on;
set (gca, 'ylim', [0 100]);
xlabel('Session #', 'fontsize', 12);
ylabel('Performance', 'fontsize', 12);
legend('Stim2 R', 'fontsize', 12);
title (RatName, 'fontsize', 12);


subplot(2,2,3); bar(sessionS, Perf_Stim2L_M_All, 'facecolor',[1 .8 0]);
hold on;
set (gca, 'ylim', [0 100]);
xlabel('Session #', 'fontsize', 12);
ylabel('Performance', 'fontsize', 12);
legend('Stim2 LM', 'fontsize', 12);
title (RatName, 'fontsize', 12);

subplot(2,2,4); bar(sessionS, Perf_Stim2R_M_All, 'facecolor',[0 0 1]);
hold on;
set (gca, 'ylim', [0 100]);
xlabel('Session #', 'fontsize', 12);
ylabel('Performance', 'fontsize', 12);
legend('Stim2 RM', 'fontsize', 12);
title (RatName, 'fontsize', 12);

end

% Dots n Gratings
sessionS = 1:length(Perf_DotL_All);
if ~isempty(sessionS)
figure;
subplot(2,2,1); bar(sessionS, Perf_DotL_All, 'facecolor',[1 0 0]);
hold on;
set (gca, 'ylim', [0 100]);
xlabel('Session #', 'fontsize', 12);
ylabel('Performance', 'fontsize', 12);
legend('Dots L', 'fontsize', 12);
title (RatName, 'fontsize', 12);


subplot(2,2,2); bar(sessionS, Perf_DotR_All, 'facecolor',[1 .8 0]);
hold on;
set (gca, 'ylim', [0 100]);
xlabel('Session #', 'fontsize', 12);
ylabel('Performance', 'fontsize', 12);
legend('Dots R', 'fontsize', 12);
title (RatName, 'fontsize', 12);
end


sessionS = 1:length(Perf_GL_All);
if ~isempty(sessionS)
subplot(2,2,3); bar(sessionS, Perf_GL_All, 'facecolor',[0 0 1]);
hold on;
set (gca, 'ylim', [0 100]);
xlabel('Session #', 'fontsize', 12);
ylabel('Performance', 'fontsize', 12);
legend('Gratings L', 'fontsize', 12);
title (RatName, 'fontsize', 12);


subplot(2,2,4); bar(sessionS, Perf_GR_All, 'facecolor',[0 .8 1]);
hold on;
set (gca, 'ylim', [0 100]);
xlabel('Session #', 'fontsize', 12);
ylabel('Performance', 'fontsize', 12);
legend('Gratings R', 'fontsize', 12);
title (RatName, 'fontsize', 12);
end



Shapes_tot_Succ_Stim1 = sum(Shapes_Succ_Stim1_All);
Shapes_tot_Fail_Stim1 = sum(Shapes_Fail_Stim1_All);
Shapes_tot_Succ_Stim2 = sum(Shapes_Succ_Stim2_All);
Shapes_tot_Fail_Stim2 = sum(Shapes_Fail_Stim2_All);

Shapes_tot_Succ_Stim1L = sum(Shapes_Succ_Stim1L_All);
Shapes_tot_Fail_Stim1L = sum(Shapes_Fail_Stim1L_All);
Shapes_tot_Succ_Stim2L = sum(Shapes_Succ_Stim2L_All);
Shapes_tot_Fail_Stim2L = sum(Shapes_Fail_Stim2L_All);

Shapes_tot_Succ_Stim1R = sum(Shapes_Succ_Stim1R_All);
Shapes_tot_Fail_Stim1R = sum(Shapes_Fail_Stim1R_All);
Shapes_tot_Succ_Stim2R = sum(Shapes_Succ_Stim2R_All);
Shapes_tot_Fail_Stim2R = sum(Shapes_Fail_Stim2R_All);

Shapes_tot_Succ_Stim1L_M = sum(Shapes_Succ_Stim1L_M_All);
Shapes_tot_Fail_Stim1L_M = sum(Shapes_Fail_Stim1L_M_All);
Shapes_tot_Succ_Stim2L_M = sum(Shapes_Succ_Stim2L_M_All);
Shapes_tot_Fail_Stim2L_M = sum(Shapes_Fail_Stim2L_M_All);

Shapes_tot_Succ_Stim1R_M = sum(Shapes_Succ_Stim1R_M_All);
Shapes_tot_Fail_Stim1R_M = sum(Shapes_Fail_Stim1R_M_All);
Shapes_tot_Succ_Stim2R_M = sum(Shapes_Succ_Stim2R_M_All);
Shapes_tot_Fail_Stim2R_M = sum(Shapes_Fail_Stim2R_M_All);

Dots_tot_Succ_DotL = sum(Dots_Succ_DotL_All);
Dots_tot_Fail_DotL = sum(Dots_Fail_DotL_All);
Dots_tot_Succ_DotR = sum(Dots_Succ_DotR_All);
Dots_tot_Fail_DotR = sum(Dots_Fail_DotR_All);

G_tot_Succ_GL = sum(G_Succ_GL_All);
G_tot_Fail_GL = sum(G_Fail_GL_All);
G_tot_Succ_GR = sum(G_Succ_GR_All);
G_tot_Fail_GR = sum(G_Fail_GR_All);

Shapes_tot_Stim1 = Shapes_tot_Succ_Stim1 + Shapes_tot_Fail_Stim1;
Shapes_tot_Stim2 = Shapes_tot_Succ_Stim2 + Shapes_tot_Fail_Stim2;

Shapes_tot_Stim1L = Shapes_tot_Succ_Stim1L + Shapes_tot_Fail_Stim1L;
Shapes_tot_Stim2L = Shapes_tot_Succ_Stim2L + Shapes_tot_Fail_Stim2L;

Shapes_tot_Stim1R = Shapes_tot_Succ_Stim1R + Shapes_tot_Fail_Stim1R;
Shapes_tot_Stim2R = Shapes_tot_Succ_Stim2R + Shapes_tot_Fail_Stim2R;

Shapes_tot_Stim1L_M = Shapes_tot_Succ_Stim1L_M + Shapes_tot_Fail_Stim1L_M;
Shapes_tot_Stim2L_M = Shapes_tot_Succ_Stim2L_M + Shapes_tot_Fail_Stim2L_M;

Shapes_tot_Stim1R_M = Shapes_tot_Succ_Stim1R_M + Shapes_tot_Fail_Stim1R_M;
Shapes_tot_Stim2R_M = Shapes_tot_Succ_Stim2R_M + Shapes_tot_Fail_Stim2R_M;


Dots_tot_DotL = Dots_tot_Succ_DotL + Dots_tot_Fail_DotL;
Dots_tot_DotR = Dots_tot_Succ_DotR + Dots_tot_Fail_DotR;

G_tot_GL = G_tot_Succ_GL + G_tot_Fail_GL;
G_tot_GR = G_tot_Succ_GR + G_tot_Fail_GR;

Shapes_tot_num = Shapes_tot_Stim1+Shapes_tot_Stim2;
L_Shapes_tot_num = Shapes_tot_Stim1L+Shapes_tot_Stim2L;
R_Shapes_tot_num = Shapes_tot_Stim1R+Shapes_tot_Stim2R;
ML_Shapes_tot_num = Shapes_tot_Stim1L_M+Shapes_tot_Stim2L_M;
MR_Shapes_tot_num = Shapes_tot_Stim1R_M+Shapes_tot_Stim2R_M;

Dots_tot_num = Dots_tot_DotL+Dots_tot_DotR;
G_tot_num = G_tot_GL+G_tot_GR;

Shapes_tot_Succ = Shapes_tot_Succ_Stim1+Shapes_tot_Succ_Stim2;
L_Shapes_tot_Succ = Shapes_tot_Succ_Stim1L+Shapes_tot_Succ_Stim2L;
R_Shapes_tot_Succ = Shapes_tot_Succ_Stim1R+Shapes_tot_Succ_Stim2R;
ML_Shapes_tot_Succ = Shapes_tot_Succ_Stim1L_M+Shapes_tot_Succ_Stim2L_M;
MR_Shapes_tot_Succ = Shapes_tot_Succ_Stim1R_M+Shapes_tot_Succ_Stim2R_M;

Dots_tot_Succ = Dots_tot_Succ_DotL+Dots_tot_Succ_DotR;
G_tot_Succ = G_tot_Succ_GL+G_tot_Succ_GR;




disp(['######### Statistics on Shapes #######'])


disp(['STIM 1: # success = ', num2str(Shapes_tot_Succ_Stim1), ' over # total = ', num2str(Shapes_tot_Stim1)])

disp(['STIM 2: # success = ', num2str(Shapes_tot_Succ_Stim2), ' over # total = ', num2str(Shapes_tot_Stim2)])

disp(['STIM 1&2: # success = ', num2str(Shapes_tot_Succ), ' over # total = ', num2str(Shapes_tot_num)])


disp(['######### Statistics on Moving Shapes, Shape Discrimination#######'])

disp(['STIM 1 LEFT: # success = ', num2str(Shapes_tot_Succ_Stim1L), ' over # total = ', num2str(Shapes_tot_Stim1L)])

disp(['STIM 2 LEFT: # success = ', num2str(Shapes_tot_Succ_Stim2L), ' over # total = ', num2str(Shapes_tot_Stim2L)])

disp(['STIM 1&2 LEFT: # success = ', num2str(L_Shapes_tot_Succ), ' over # total = ', num2str(L_Shapes_tot_num)])


disp(['STIM 1 RIGHT: # success = ', num2str(Shapes_tot_Succ_Stim1R), ' over # total = ', num2str(Shapes_tot_Stim1R)])

disp(['STIM 2 RIGHT: # success = ', num2str(Shapes_tot_Succ_Stim2R), ' over # total = ', num2str(Shapes_tot_Stim2R)])

disp(['STIM 1&2 RIGHT: # success = ', num2str(R_Shapes_tot_Succ), ' over # total = ', num2str(R_Shapes_tot_num)])


disp(['######### Statistics on Moving Shapes, Motion Discrimination#######'])

disp(['STIM 1 LEFT_M: # success = ', num2str(Shapes_tot_Succ_Stim1L_M), ' over # total = ', num2str(Shapes_tot_Stim1L_M)])

disp(['STIM 2 LEFT_M: # success = ', num2str(Shapes_tot_Succ_Stim2L_M), ' over # total = ', num2str(Shapes_tot_Stim2L_M)])

disp(['STIM 1&2 LEFT_M: # success = ', num2str(ML_Shapes_tot_Succ), ' over # total = ', num2str(ML_Shapes_tot_num)])


disp(['STIM 1 RIGHT_M: # success = ', num2str(Shapes_tot_Succ_Stim1R_M), ' over # total = ', num2str(Shapes_tot_Stim1R_M)])

disp(['STIM 2 RIGHT_M: # success = ', num2str(Shapes_tot_Succ_Stim2R_M), ' over # total = ', num2str(Shapes_tot_Stim2R_M)])

disp(['STIM 1&2 RIGHT_M: # success = ', num2str(MR_Shapes_tot_Succ), ' over # total = ', num2str(MR_Shapes_tot_num)])


disp(['######### Statistics on Dots #######'])


disp(['DOTS LEFT: # success = ', num2str(Dots_tot_Succ_DotL), ' over # total = ', num2str(Dots_tot_DotL)])

disp(['DOTS RIGHT: # success = ', num2str(Dots_tot_Succ_DotR), ' over # total = ', num2str(Dots_tot_DotR)])

disp(['DOTS LEFT&RIGHT: # success = ', num2str(Dots_tot_Succ), ' over # total = ', num2str(Dots_tot_num)])



disp(['######### Statistics on Gratings #######'])

disp(['G LEFT: # success = ', num2str(G_tot_Succ_GL), ' over # total = ', num2str(G_tot_GL)])

disp(['G RIGHT: # success = ', num2str(G_tot_Succ_GR), ' over # total = ', num2str(G_tot_GR)])

disp(['G LEFT&RIGHT: # success = ', num2str(G_tot_Succ), ' over # total = ', num2str(G_tot_num)])





