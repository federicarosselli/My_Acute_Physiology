%function [y t] = plotchan2 (Tank, Block, Event, Channel, StartTime, EndTime)
function [y t timestamps] = plotchan2 (Tank, Block, Event, Channel, StartTime, EndTime, ShowPlot)
%This function plots a single channel from a recording.  The
%arguments are as follows:
%Tank is the name of a registered Tank, or the full path with name of an
%unregistered Tank, ie 'DEMOTANK2' or 'C:\mytanks\tank1'
%Block is simply the blockname, ie 'Block-1'
%Event is the four letter event name, ie 'Wave'
%Channel is the channel number ie 1
%StartTime and EndTime set the time period, to plot the entire recording
%enter zero for both.

TTX = actxcontrol('TTank.X', [0 0 0 0]);
if TTX.ConnectServer('Local','Me') == 0 error('Error connecting to server'); end
if TTX.OpenTank(Tank,'R') == 0 error('Error opening tank'); end
if TTX.SelectBlock(Block) == 0 error('Error opening block'); end

TTX.SetGlobalV('WavesMemLimit',268435456); %Set the memory limit to 250MB (default is 32MB)
  
%Get the data and the timestamps; data will have the data organized as a
%series of colums each representing a block, timestamps will be a row where
%each value represents the time stamp of the first value in each block
N = TTX.ReadEventsV(1000000, Event, Channel, 0, StartTime, EndTime, 'ALL');
data = TTX.ParseEvV(0,N);
timestamps = TTX.ParseEvInfoV(0,N,6);

%Organize the data into a meaningful waveform, where each value has a timestamp
%First construct an array with a time for every sample
datasize = size(data);
blocksize = datasize(1);
numblocks = datasize(2);

if numel(timestamps)>3
    
ts_interval = (timestamps(2)-timestamps(1))/blocksize;

t = zeros(1,blocksize*numblocks);
for i = 1:numblocks
    timeblock = zeros(1,blocksize);
    for j = 1:blocksize
        timeblock(j) = timestamps(i) + (ts_interval*(j-1));
    end
    t(((i-1)*blocksize + 1):i*blocksize) = timeblock;
end

%next organize all the data into one row containing all samples
y = zeros(1,blocksize*numblocks);
for i = 1:numblocks
    y(((i-1)*blocksize + 1):i*blocksize) = data(:,i);
end

%Plot the data
if ShowPlot
    if Channel~=0
    figure(Channel);
    else 
        figure(100);
    end
    
plot(t,y);
if EndTime ~= 0
    xlim([t(1) t(length(t))]);
else
    xlim(TTX.GetValidTimeRangesV);
end
end


else

y=[];
t=[];
timestamps=[];
    
end


TTX.CloseTank
TTX.ReleaseServer

end



