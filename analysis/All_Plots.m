% function All_Plots(DayOfRecording, Block)

clear all
clc
close all

global DayOfRecording
global Block
global my_folder
global object
global NER
global TUN;
global TUN_BBl;
global TUN_WBl;
global ww;

DayOfRecording = '2_7_2013';
Block=12;


my_folder = ['/zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_', char(DayOfRecording), '/ANALYSED/BlockS-', num2str(Block), '/BL_2/My_Structure/25'];
% my_folder = ['/zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_', , char(DayOfRecording), '/ANALYSED/Block-' , num2str(Block), '/My_Structure/25'];

addpath /zocconasphys1/chronic_inv_rec/codes/
load My_StimS_NUANGLE_NUCONDITIONS
cd (my_folder)

files = dir(fullfile('*.mat'));
neuronS = (numel(files))/2;
object = [1, 2, 3, 4];
ww=cd;


for NER = 1 %:neuronS
    
    
%     subplot (2, 1, 1); 
    My_Size_Tuning_OBJECTS
    cd (['TUNING/', num2str(NER), '/', char(stimidentity), '/'])
    h1 = openfig('szT_Objects.fig','reuse'); % open figure
    ax1 = gca; % get handle to axes of figure
    cd ..
    cd ..
    cd ..
    close;
    My_Orientation_Tuning_OBJECTS
    cd (['TUNING/', num2str(NER), '/', char(stimidentity), '/'])
    h2 = openfig('oriT_Objects.fig','reuse');
    ax2 = gca;
    cd ..
    cd ..
    cd ..
    % test1.fig and test2.fig are the names of the figure files which you would % like to copy into multiple subplots

    h3 = figure; %create new figure
    s1 = subplot(2,1,1); %create and get handle to the subplot axes
    s2 = subplot(2,1,2);
    fig1 = get(ax1,'children'); %get handle to all the children in the figure
    fig2 = get(ax2,'children');

    copyobj(fig1,s1); %copy children to new parent axes i.e. the subplot axes
    copyobj(fig2,s2);
    
    
    
end