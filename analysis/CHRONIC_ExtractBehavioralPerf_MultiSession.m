function CHRONIC_ExtractBehavioralPerf_MultiSession( RatName, FirstFile, LastFile )

prefix1 = ['r_', RatName,'_c00'];
prefix2 = ['r_', RatName,'_c0'];
suffix = [FirstFile:LastFile];

for i=suffix
    if i<10
        FileName = [prefix1, num2str(i),'.mwk'];
    else
        FileName = [prefix2, num2str(i),'.mwk'];
    end;
    CHRONIC_ExtractRatBehavData( FileName, 850 )
end