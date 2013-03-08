 clear
% 1-530 objects
% 532-747 bar 
% 749-782 graging
% 783 blanck
 COLORSET=varycolor(10); 
bin=0.025;POST_TIME=0.5;PRE_TIME=0.25;
 
%addpath /u/shared/CODES/Acu_Obj
POST_STIM_WINDOW=[300 400]*0.001;   % the 30-150 ms after the stimulus presentation 
WINDOW=POST_STIM_WINDOW(2)-POST_STIM_WINDOW(1);
PRE_STIM_WINDOW=[250-WINDOW*1000 250]*0.001;   % the reference time is 250 ms before the stimulus presentaion 
RecordingFolder='Fede_AcuteTest_19_12_12';
Block=1;
load(['/zocconasphys1/chronic_inv_rec/Tanks/' RecordingFolder '/ANALYSED/STIM.mat'])
PATH=(['/zocconasphys1/chronic_inv_rec/Tanks/' RecordingFolder '/ANALYSED/Block-' num2str(Block) '/PSTH/25/']);
%PATH2=(['/zocconasphys2/acute_objects/' RecordingFolder '/ANALYSED/Block-' num2str(Block) '/PSTH/']);
cd(PATH)
 X=[-30 -20 -10 0 10 20 30 40 50];
Y=[30 20 10 0 -10 -20];
OR=[0 45 90 135];

%%%%%%%%%%%%
                                            
%%%%%%%%%%%%
for NER=1:10
for or=OR
  for x=X
    for y=Y
        
            ob_x=find(X==x);
            ob_y=find(Y==y);
            ob_or=find(OR==or);
            obj=530+STIM_CODE(STIM_CODE(532:747,2)==x & STIM_CODE(532:747,3)==y & STIM_CODE(532:747,4)==or,1);
            load([PATH 'RASTER_',num2str(obj),'_',num2str(NER),'.mat'])
                for oi=1:size(RASTER,2)
                     sp_tr{ob_y,ob_x,ob_or}(oi,1)=(sum(RASTER{oi}>POST_STIM_WINDOW(1) & RASTER{oi}<POST_STIM_WINDOW(2)));
                end
            TUN.Me(ob_y,ob_x,ob_or)=mean(sp_tr{ob_y,ob_x,ob_or})/WINDOW;

    end
  end
end
figure(NER)

imagesc(mean(TUN.Me,3))
colorbar
end