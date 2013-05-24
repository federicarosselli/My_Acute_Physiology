function RF_Track %(BIT_Number)

cd /zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_12_4_2013/ANALYSED/

cd BlockS-12/ReceptiveFieldAnalysis/BL_1/RFs

load ('RFo.mat')
RFo_1=RFo;
files_1 = dir(fullfile('*.fig'));
neuronS_1 = (numel(files_1));
cool_RFs_1=[1:neuronS_1]; 
dim_1=length(cool_RFs_1);

[m,n]=size(RFo_1);
[j,k]=size(RFo_1{1});
margin=0.5;

labels_1={1:dim_1};


clear RFo

cd ..

cd ..

cd ..

cd ..



cd Block-3/RFs

load ('RFo.mat')
RFo_2=RFo;
files_2 = dir(fullfile('*.fig'));
neuronS_2 = (numel(files_2));
cool_RFs_2=[1:neuronS_2]; 
dim_2=length(cool_RFs_2);

labels_2={1:dim_2};

clear RFo

cd ..

cd ..



cd Block-4/RFs

load ('RFo.mat')
RFo_3=RFo;
files_3 = dir(fullfile('*.fig'));
neuronS_3 = (numel(files_3));
cool_RFs_3=[1:neuronS_3]; 
dim_3=length(cool_RFs_3);

labels_3={1:dim_3};

clear RFo

cd ..

cd ..




cd BlockS-56/ReceptiveFieldAnalysis/BL_1/RFs

load ('RFo.mat')
RFo_4=RFo;
files_4 = dir(fullfile('*.fig'));
neuronS_4 = (numel(files_4));
cool_RFs_4=[1:neuronS_4]; 
dim_4=length(cool_RFs_4);

labels_4={1:dim_4};

clear RFo

cd ..

cd ..

cd ..

cd ..





cd Block-7/RFs

load ('RFo.mat')
RFo_5=RFo;
files_5 = dir(fullfile('*.fig'));
neuronS_5 = (numel(files_5));
cool_RFs_5=[1:neuronS_5]; 
dim_5=length(cool_RFs_5);

labels_5={1:dim_5};

clear RFo

cd ..

cd ..


cd Block-8/RFs

load ('RFo.mat')
RFo_6=RFo;
files_6 = dir(fullfile('*.fig'));
neuronS_6 = (numel(files_6));
cool_RFs_6=[1:neuronS_6]; 
dim_6=length(cool_RFs_6);

labels_6={1:dim_6};

clear RFo

cd ..

cd ..



mkdir ('RFTrack');


dimS = [dim_1, dim_2, dim_3, dim_4, dim_5, dim_6];
RFoS = [RFo_1, RFo_2, RFo_3, RFo_4, RFo_5, RFo_6];
cool_RFsS = [cool_RFs_1, cool_RFs_2, cool_RFs_3, cool_RFs_4, cool_RFs_5, cool_RFs_6];
labelS = [labels_1, labels_2, labels_3, labels_4, labels_5, labels_6];




COLORSET=varycolor(6);  % number of blocks

for z = 1:6 %number of blocks
    
    dim = dimS(z);
    RFo = RFoS(z);
    cool_RFs = cool_RFsS(z);
    label = labelS(z);
    
    for i=1:dim
        empty_screen=zeros(j,k);
        alla=0;
        walla=0;
        tmpRF=RFo{cool_RFs(i)};
        tmpMax=max(tmpRF(:));
        %tmpA=tmpRF> margin*tmpMax;
        tmpA=tmpRF==tmpMax;
    %     index=find(tmpA);
    %     x(i)=ceil(index(1)/j);
    %     
    %     y(i)=index(1)-(x(i)-1)*j;
        empty_screen = empty_screen(i) + tmpA;

    %     labels{i}= cool_RFs(i); % Note the {}

        [alla walla]=ind2sub(size(empty_screen), find(empty_screen==1));
        falla(i) = alla (1);
        fwalla(i) = walla(1);

    %     plot (falla(i), fwalla(i), '-o', 'Color', COLORSET(i,:));
    %     set (gca, 'ylim', [0 9], 'xlim', [0 12]);
    %     hold on;
    end

    figure(z);
    plot (falla, fwalla, '-o', 'Color', COLORSET(z,:));
    set (gca, 'ylim', [0 6], 'xlim', [0 11]);
    figure (gcf);
%     text(falla, fwalla, label);

    
end;
% 
% plot (falla, fwalla, '-o', 'Color', COLORSET(i,:));
% set (gca, 'ylim', [0 9], 'xlim', [0 12]);
% figure (gcf);
% text(falla, fwalla, a);


% figure;
% surf(empty_screen,'DisplayName','empty_screen');figure(gcf)
% text(x,y,labels);


end