clear all
%close all
hold on  
BlockSet=[5];
%Col=varycolor(length(BlockSet));    
Col=varycolor(7);  
c=1;
for BlockNum=BlockSet;
    clearvars -except BlockNum Col BlockSet c
    load(['/zocconasphys2/acute_objects/Sina_Acute2_Rec_06_03_2013/ANALYSED/Block-' num2str(BlockNum) '/SPIKE']);
    load(['/zocconasphys2/acute_objects/Sina_Acute2_Rec_06_03_2013/ANALYSED/RF_Prop_Block' num2str(BlockNum)]);
if BlockNum==3
    fitresult=firresult_B3;
elseif BlockNum==4
    fitresult=firresult_B4;
elseif BlockNum==5
    fitresult=firresult_B5;
 elseif BlockNum==6
    fitresult=firresult_B6;   
 elseif BlockNum==7
    fitresult=firresult_B7;
elseif BlockNum==8
    fitresult=firresult_B8;
elseif BlockNum==9
    fitresult=firresult_B9;
end
    
load(['/zocconasphys2/acute_objects/Sina_Acute2_Rec_06_03_2013/ANALYSED/Block-' num2str(BlockNum) '/SPIKE']);
load(['/zocconasphys2/acute_objects/Sina_Acute2_Rec_06_03_2013/ANALYSED/RF_Prop_Block' num2str(BlockNum)]);
 for i=1:size(fitresult,2)
         RFdata(i,:)=[fitresult{i}.sigmax,fitresult{i}.sigmay,fitresult{i}.x0,fitresult{i}.y0,SPIKES.channel{i}];

end
subpop=find(RFdata(:,3)>0 & RFdata(:,3)<13 &  RFdata(:,4)>0 & RFdata(:,4)<9);

plot(RFdata(subpop',3),RFdata(subpop',4),'*-','MarkerEdgeColor',Col(c,:),'Color',Col(c,:))
text(RFdata(subpop',3),RFdata(subpop',4),num2str(RFdata(subpop',5)))
text(11,9-c/3,['Block-' num2str(BlockNum)],'color',Col(c,:))

%
axis equal
xlim([0 13])
ylim([0 9])
c=c+1;
%legend(['Block-' num2str(BlockNum)])
end
 saveas(gca,['RFtrace_Block' num2str(BlockSet) '.jpg'],'jpg')