function SILVIA_ExtractBehavioralPerf_MultiSession( RatName, FirstFile, LastFile )

% example: SILVIA_ExtractBehavioralPerf_MultiSession( 'S6', 1, 13 )
% example: SILVIA_ExtractBehavioralPerf_MultiSession( 'S2', 1, 10 )

%% note: these r the sessions BEFORE the dots


prefix1 = ['r_', RatName,'_b00'];
prefix2 = ['r_', RatName,'_b0'];
suffix = [FirstFile:LastFile];

for i=suffix
    if i<10
        % FileName = [prefix1, num2str(i),'.mwk'];
        FileName = [prefix1, num2str(i),'.mwk'];
    else
        % FileName = [prefix2, num2str(i),'.mwk'];
        FileName = [prefix2, num2str(i),'.mwk'];
    end;
    SILVIA_ExtractRatBehavioralPerf ( FileName, 500 );
end

