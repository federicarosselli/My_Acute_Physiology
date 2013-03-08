 clear
% 1-530 objects
% 532-747 bar 
% 749-782 graging
% 783 blanck
 COLORSET=varycolor(10); 
bin=0.025;POST_TIME=0.5;PRE_TIME=0.25;
 
addpath /u/shared/CODES/Acu_Obj
POST_STIM_WINDOW=[300 400]*0.001;   % the 30-150 ms after the stimulus presentation 
WINDOW=POST_STIM_WINDOW(2)-POST_STIM_WINDOW(1);
PRE_STIM_WINDOW=[250-WINDOW*1000 250]*0.001;   % the reference time is 250 ms before the stimulus presentaion 
RecordingFolder='Sina_Acute_Rec_19_06_2012';
Block=1;
load(['/zocconasphys2/acute_objects/' RecordingFolder '/ANALYSED/STIM.mat'])
PATH=(['/zocconasphys2/acute_objects/' RecordingFolder '/ANALYSED/Block-' num2str(Block) '/PSTH/25/']);
PATH2=(['/zocconasphys2/acute_objects/' RecordingFolder '/ANALYSED/Block-' num2str(Block) '/PSTH/']);
cd(PATH2)
SF=[0.02 0.08 0.6];
PH=[0 90 180];
OR=[0 45 90 135];
for NER=2
  for or=OR
   for sf=SF
     for ph=PH
        
            ob_sf=find(SF==sf);
            ob_ph=find(PH==ph);
            ob_or=find(OR==or);
            obj=746+STIM_CODE(STIM_CODE(749:784,2)==sf & STIM_CODE(749:784,3)==or & STIM_CODE(749:784,4)==ph,1);
            load([PATH 'RASTER_',num2str(obj),'_',num2str(NER),'.mat'])
                for oi=1:size(RASTER,2)
                     sp_tr{ob_sf,ob_or,ob_ph}(oi,1)=(sum(RASTER{oi}>POST_STIM_WINDOW(1) & RASTER{oi}<POST_STIM_WINDOW(2)));
                end
            TUN.Me(ob_sf,ob_or,ob_ph)=mean(sp_tr{ob_sf,ob_or,ob_ph});

    end
  end
  end
 end