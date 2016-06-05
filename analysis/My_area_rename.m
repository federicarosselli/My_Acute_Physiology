cd '/zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_15_08_2013/ANALYSED/BlockS-12/BL_2/My_Structure/25'

files = dir(fullfile('*.mat'));
neuronS = (numel(files))/2;

% neurones = [13, 4, 1, 14, 7, 19];

for pappa = 1:neuronS
    
    load (['NEURON_', num2str(pappa), '.mat'])
    
    My_Neurons.Area=char('V1b');
    
    save (['NEURON_', num2str(pappa), '.mat'], 'My_Neurons')
    
    
end