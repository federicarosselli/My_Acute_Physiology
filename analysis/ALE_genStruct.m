function data = genStruct( ~ )
% Creates a data structure parsing the data files
% Every day is recorded as a new element of the array

clear all;

% builds the labels for extracting and making the structures
tempNames = {'ntrial','objmod','lr','objcat','objtype','objid','err','hit', ...
    'ltrial','rtrial','x','v','perf','l','r','bias','lx','rx','reaction'};
data = struct('rat',{},'date',{},'config',{},'matrix',{},'ntrial',{},'objmod',{}, ...
    'lr',{},'objcat',{},'objtype',{},'objid',{},'err',{},'hit',{},'ltrial',{},'rtrial',{}, ...
    'x',{},'v',{},'perf',{},'l',{},'r',{},'bias',{},'lx',{},'rx',{},'reaction',{});
            
for rat = 1:6
    for year = 2012
        for month = 12
            for day = 1:31
                
                % builds the name for the date, to insert it in the structure
                date = strcat(num2str(year),'/',num2str(month),'/',num2str(day));
                % builds the name for the file, to open it
                fstr = strcat('R0',num2str(rat),'_',num2str(month),'_',num2str(day),'_',num2str(year),'.txt');
                % 'C:\Users\Sara\Desktop\AleData\'
                % '\\nas-cns.sissa.it\user_folders\difilippo\Desktop\AleData\'
                f = strcat('\\nas-cns.sissa.it\user_folders\difilippo\Desktop\AleData\',fstr);
                fid = fopen(f,'r');
                % if the file is existent
                if fid >= 3
                    % gets the number of columns, to build the proper string for textscan
                    disp(fstr);
                    delimiter = sprintf('\t','');
                    tLines = fgets(fid);
                    ncols = numel(strfind(tLines,delimiter)) + 1;
                    repd = repmat('%d',1,ncols);
                    scan = strcat('%d%d%d%d%d%s', num2str(repd));
                    % closes to file, to reset the line pointer
                    fclose(fid);
                    % translates the text file in one cell, and then in one structure
                    fid = fopen(f,'r');
                    temp = textscan(fid, scan);
                    temp = temp(1:end,1:19);
                    tempData = cell2struct(temp,tempNames,2);
                    % controls if the file contains just random matrixes by checking the objtype
                    if ~any(tempData.objtype(:) < 4)
                        % adds the information to the rat and date files
                        tempData.rat = rat;
                        tempData.date = date;
                        % extracts the configuration information, and adds it to the config field
                        tempData.config = {'0000000000000000000' '0000000000000000000' ...
                        '0000000000000000000' '0000000000000000000'};
                        m = 1;
                        for j = 1:numel(tempData.objid);
                            if ~ismember(tempData.objid(j), tempData.config)
                                tempData.config(m) = tempData.objid(j);
                                m = m+1;     
                            end
                        end
                        m = 1;
                        for j = 1:numel(tempData.config);
                            mat = zeros(5,9);
                            mat(1,1)=-1; mat(1,2)=-1; mat(1,8)=-1; mat(1,9)=-1;
                            mat(2,1)=-1; mat(2,9)=-1; mat(4,1)=-1; mat(4,9)=-1;
                            mat(5,1)=-1; mat(5,2)=-1; mat(5,8)=-1; mat(5,9)=-1;
                            for i=1:2:length(tempData.config{j})
                                if str2double(tempData.config{j}(i))~=0
                                    r=str2double(tempData.config{j}(i));
                                    c=str2double(tempData.config{j}(i+1));
                                    mat(r,c)=1;
                                end
                            end
                            tempData.matrix(j) = {mat};
                        end
                        % adds the temporary structure to the final one
                        data = [data, tempData];
                    end
                    fclose(fid);
                end
             end
        end
    end
    for year = 2013
        for month = 1:12
            for day = 1:31
                
                % builds the name for the date, to insert it in the structure
                date = strcat(num2str(year),'/',num2str(month),'/',num2str(day));
                % builds the name for the file, to open it
                fstr = strcat('R0',num2str(rat),'_',num2str(month),'_',num2str(day),'_',num2str(year),'.txt');
                % 'C:\Users\Sara\Desktop\AleData\'
                % '\\nas-cns.sissa.it\user_folders\difilippo\Desktop\AleData\'
                f = strcat('\\nas-cns.sissa.it\user_folders\difilippo\Desktop\AleData\',fstr);
                fid = fopen(f,'r');
                % if the file is existent
                if fid >= 3
                    % gets the number of columns, to build the proper string for textscan
                    disp(fstr);
                    delimiter = sprintf('\t','');
                    tLines = fgets(fid);
                    ncols = numel(strfind(tLines,delimiter)) + 1;
                    repd = repmat('%d',1,ncols);
                    scan = strcat('%d%d%d%d%d%s', num2str(repd));
                    % closes to file, to reset the line pointer
                    fclose(fid);
                    % translates the text file in one cell, and then in one structure
                    fid = fopen(f,'r');
                    temp = textscan(fid, scan);
                    temp = temp(1:end,1:19);
                    tempData = cell2struct(temp,tempNames,2);
                    % controls if the file contains just random matrixes by checking the objtype
                    if ~any(tempData.objtype(:) < 4)
                        % adds the information to the rat and date files
                        tempData.rat = rat;
                        tempData.date = date;
                        % extracts the configuration information, and adds it to the config field
                        tempData.config = {'0000000000000000000' '0000000000000000000' ...
                        '0000000000000000000' '0000000000000000000'};
                        m = 1;
                        for j = 1:numel(tempData.objid);
                            if ~ismember(tempData.objid(j), tempData.config)
                                tempData.config(m) = tempData.objid(j);
                                m = m+1;     
                            end
                        end
                        m = 1;
                        for j = 1:numel(tempData.config);
                            mat = zeros(5,9);
                            mat(1,1)=-1; mat(1,2)=-1; mat(1,8)=-1; mat(1,9)=-1;
                            mat(2,1)=-1; mat(2,9)=-1; mat(4,1)=-1; mat(4,9)=-1;
                            mat(5,1)=-1; mat(5,2)=-1; mat(5,8)=-1; mat(5,9)=-1;
                            for i=1:2:length(tempData.config{j})
                                if str2double(tempData.config{j}(i))~=0
                                    r=str2double(tempData.config{j}(i));
                                    c=str2double(tempData.config{j}(i+1));
                                    mat(r,c)=1;
                                end
                            end
                            tempData.matrix(j) = {mat};
                        end
                        % adds the temporary structure to the final one
                        data = [data, tempData];
                    end
                    fclose(fid);
                end
             end
        end
    end
end
end