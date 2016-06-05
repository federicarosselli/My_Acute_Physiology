%%%%%% MY RECEPTIVE FIELDS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%% adds RF info to the structure 'NEURON'

clear all
clc
close all

DayOfRecording = '13_12_2013';
Block=56;

addpath /zocconasphys1/chronic_inv_rec/codes/

my_folder_1 = ['/zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_', char(DayOfRecording), '/ANALYSED/BlockS-', num2str(Block), '/BL_1/RFs'];
my_folder = ['/zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_', char(DayOfRecording), '/ANALYSED/BlockS-', num2str(Block), '/BL_2/My_Structure/25'];

cd(my_folder_1)
            
load fitresulto


cd(my_folder)

files = dir(fullfile('*.mat'));
neuronS = (numel(files))/2;

for nn = 1:neuronS
    
    load (['NEURON_', num2str(nn), '.mat'])
    
            My_Neurons.RF.coeffa = fitresulto{nn}.a;
            My_Neurons.RF.coeffb = fitresulto{nn}.b;
            My_Neurons.RF.posx = fitresulto{nn}.x0;
            My_Neurons.RF.posy = fitresulto{nn}.y0;
            My_Neurons.RF.devx = fitresulto{nn}.sigmax;
            My_Neurons.RF.devy = fitresulto{nn}.sigmay;
            My_Neurons.RF.size = [(My_Neurons.RF.devx+My_Neurons.RF.devy)/2]*20;
            
    
    save (['NEURON_', num2str(nn), '.mat'], 'My_Neurons')
    
    
end

            
            