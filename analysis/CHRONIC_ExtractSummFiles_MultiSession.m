function CHRONIC_ExtractSummFiles_MultiSession( RatName, FirstFile, LastFile )

prefix1 = ['r_', RatName,'_c00'];
prefix2 = ['r_', RatName,'_c0'];
suffix = [FirstFile:LastFile];


for i=suffix
    if i<10
        FileName = [prefix1, num2str(i),'_extr.mat'];
        
    else
        FileName = [prefix2, num2str(i),'_extr.mat'];
        
    end;
    [Size, Pos, Rot, RotDep] = CHRONIC_PlotStairCaseTrainingData( FileName, 1);
    
end


bubu = msgbox ('all .summ files have been extracted', 'attention', 'help')
% set (gca, 'colormap', [1,1,1])




