
%trovo le posizioni in cui gli stimoli sono presentati e le salvo dentrop a
%stim_seq. Nel nostro caso corrispondono ai secondi. Tipo stim_seq=1 vuol
%dire che lo stimolo è stato presentato da 0 a 500ms e ha ist di altri
%500ms
clearvars
load('3porcellini')
pres_time=0.500;
isi=0.500;
stim_time=pres_time+isi;
dim_t=size(t);
total_time=t(dim_t(2));
stim_name=7;
stim_seq_raw=zeros(1,numel(stim));
for i=1:numel(stim)
if stim(i)==stim_name
   stim_seq_raw(i)=stim(i);
 end
end
stim_seq=find(stim_seq_raw);
stim_time_end=stim_time*stim_seq;%contiene il momento in cui ho la fine dell'isi


%Ottengo una matrice che contiene tante righe quanti sono gli stimoli, e in
%ogni riga gli spikes generati nel stim_time dalla comparsa di quello
%stimolo e zero negli altri casi
Spike_stim=zeros(numel(stim_seq),numel(TSpike));
for  j=1:numel(stim_seq)
for k=1:numel(TSpike)
   if (TSpike(k)>=(stim_time_end(j)-stim_time))&&(TSpike(k)<stim_time_end(j))
Spike_stim(j,k)=TSpike(k);
   end
end
end


%adesso becco la fenestratura che voglio e conto gli spikes

bin=0.01; 
h=1;
z=0;
l=1;
while bin*l<=stim_time
j=0
 for  j=1:numel(stim_seq)
 A=find(Spike_stim(j,:));
 storage=zeros(1,numel(A)); 
 storage(1,1:numel(A))=Spike_stim(1,1:numel(A));
   h=0  
   for h=1:numel(storage)
       if ((storage(h)>=(l-1)*bin)&&(storage(h)<(l*bin)))
       z=z+1;
       mat_psth(j,l)=z;
       end
    end
   z=0;
  end
l=l+1;
end

        
    
  %i=0;
%dimA=size(A);
%for i=1:(dimA(2)/8)
 %   B(i,:)=[A(i*8-7:i*8)];
  %  C(1,i)=[B(i,1)];
%end
%int_stim=500;
%stim_pres=500;
%dimP=size(P);
%dimC=size(C);
%R=dimP(2)/dimC(2)
