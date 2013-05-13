function RF_Track %(BIT_Number)

cd /zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_18_3_2013/RFs

mkdir ('Track');

[m,n]=size(RFo);
cool_RFs=[3,4,5,6,8,9,10,12,18,21,22,25,32,35,36,37,38,39];
dim=length(cool_RFs);
[j,k]=size(RFo{1});
margin=0.5;

empty_screen=zeros(j,k);
labels=cell(dim);
x=zeros(dim,1);
y=zeros(dim,1);

for i=1:dim
    tmpRF=RFo{cool_RFs(i)};
    tmpMax=max(tmpRF(:));
    %tmpA=tmpRF> margin*tmpMax;
    tmpA=tmpRF==tmpMax;
    index=find(tmpA);
    x(i)=ceil(index/j);
    
    y(i)=index-(x(i)-1)*j;
    empty_screen = empty_screen + tmpA;
    
    labels{i}= cool_RFs(i); % Note the {}
    
    
end;

surf(empty_screen,'DisplayName','empty_screen');figure(gcf)
text(x,y,labels);


end