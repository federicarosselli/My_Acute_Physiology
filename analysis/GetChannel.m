function channel = GetChannel(nn,SpikesChannels)

    %SpikesChannels = SPIKES.channel;
    %channels = find(cellfun(@(x) any(x==nn),SpikesChannels));
    
    channel=SpikesChannels{nn};
    if isempty(channel)
        display('Warning : no neurons in these channels !');        
    end
     

end