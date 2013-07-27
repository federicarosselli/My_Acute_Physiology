function SILVIA_ExtractSummFiles_MultiSession( RatName, FirstFile, LastFile )

% example: SILVIA_ExtractSummFiles_MultiSession( 'S6', 1, 13 )
% example: SILVIA_ExtractSummFiles_MultiSession( 'S2', 1, 10 )

%% note: these r the sessions BEFORE the dots

prefix1 = ['r_', RatName,'_b00'];
prefix2 = ['r_', RatName,'_b0'];
suffix = [FirstFile:LastFile];

for i=suffix
    if i<10
        FileName = [prefix1, num2str(i),'_extr.mat'];
        
    else
        FileName = [prefix2, num2str(i),'_extr.mat'];
        
    end;
    SILVIA_PlotStairCaseTrainingData_MotionAndTransformations( FileName, 1);
    
    close all;
end