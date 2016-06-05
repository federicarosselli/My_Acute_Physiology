

cd '/zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_12_11_2013/ANALYSED/BlockS-67'

load SPIKE_TEST

ChannelOrder = [18,22,13,26,9,30,5,20,1,24,28,32,3,7,11,15,19,23,27,31,4,8,12,29,16,25,2,21,6,17,10,14]; % for 8x4 NNexus ziff



for pappa = 1:length(SPIKES.channel)
        
     for tuasorella = 1:32
            
        for i = ChannelOrder
    
        if SPIKES.channel{1, pappa}==tuasorella;
           SPIKES.channel{1, pappa}=ChannelOrder(tuasorella);
           
        end
        
        end
  
    end
    
    save ('SPIKE_TEST.mat', 'SPIKES', '-append')

end

% save ('SPIKE.mat', 'SPIKES', '-append')
    
