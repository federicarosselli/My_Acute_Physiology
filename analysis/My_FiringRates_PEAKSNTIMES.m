% function My_FiringRates_PEAKSNTIMES 

%average firing rates over the trials,
%for fixed neuron and bitcode and save it in 
%AFR{neuron, bitcode}

check_codes=0;
% my_folder = ['/zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_', char(DayOfRecording), '/ANALYSED/BlockS-', num2str(Block), '/BL_2/My_Structure/25'];
% my_folder = ['/zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_', char(DayOfRecording), '/ANALYSED/BlockS-', num2str(Block), '/BL_2/My_Structure/50'];
% my_folder = ['/zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_', , char(DayOfRecording), '/ANALYSED/Block-' , num2str(Block), '/My_Structure/25'];

addpath /zocconasphys1/chronic_inv_rec/codes/
load My_StimS_NUANGLE_NUCONDITIONS
table=Fede_STIM_NU;

load FR.mat


[n,m,l]=size(FR); %n number of neurons, m number of bitcodes (static)
                      %n number of trials (maximum over all neurons and bitcodes couples)

                      
%set number of points of the firing rate function                    
PRE_TIME=200;
n_points=length(FR{1,1,1}.fr);   %get n_points from structure                 
T=linspace(-PRE_TIME,(n_points-1)-PRE_TIME,n_points);          
AFR=cell(zeros());

Neurons=get_neurons_list_from_FR(FR);
Bitcodes=get_bitcodes_list_from_FR(FR);
Objects = [-1, 0, 1, 2, 3, 4, 9, 11, 22, 111, 222, 333, 444];



if(check_codes) 
    check_codes_consistency(table,objects);
end


%iterate on neurons
for i=1:numel(Neurons)
    %code of the i-th neuron
    nn=Neurons(i); 
    %iterate on objects
    
    for j = 1:numel(Bitcodes)  
        bc=Bitcodes(j);      
        %select trials of the corresponding neuron and bitcode
        selected_trials=fetch_FR_by_neuron_and_bitcode(FR,nn,bc);
        %compute the matrix of trials
        frm=get_firing_rate_matrix(selected_trials);
        ipsthm=get_ipsth_matrix(selected_trials);
        %compute the average of trials
        afr=mean(frm,1);
        aipsth=mean(ipsthm,1);
        %normalization if required 

        %afr = afr*(1000/25); %normalization in order
            %to recover the correct units of measure
            %(number of spikes per second)

        %compute peak and its location
        peak = max(afr);              
        loc = find(afr==peak);            
        if length(loc) > 1
            loc=loc(1);
        end
        %compute (average for trial) n_spikes in the area of interest 
        n_spikes_area = sum(aipsth(pars.area_ti:pars.area_tf));
        

        %populate the data structure for this task
        fr=struct();
        fr.Neuron=nn;
        fr.Bitcode=bc;            
        fr.Afr=afr;
        fr.Aipsth=aipsth;
        fr.Peak=peak;
        fr.N_spikes_area=n_spikes_area;
        fr.Loc=loc;
        AFR{i,j}=fr;

    end   
    disp([num2str(i),'/', num2str(n)]);
end


