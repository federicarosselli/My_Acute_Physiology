cd '/zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_10_7_2013/ANALYSED/BlockS-34/BL_2/My_Structure/25'

files = dir(fullfile('*.mat'));
neuronS = (numel(files))/2;

for pappa = 1:23 %1:neuronS
    
    load (['NEURON_', num2str(pappa), '.mat'])
    
    My_Neurons.Area=char('AL');
    
    save (['NEURON_', num2str(pappa), '.mat'], 'My_Neurons')
    
    
end