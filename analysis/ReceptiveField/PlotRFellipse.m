 clear all
 clc
% close all
 figure(1)
 hold on 

 Area=cellstr({'V1','Te'});
 for ar=1
     %subplot(1,2,ar)
     
 load(['/u/shared/CODES/Acu_Obj/Cosyne2013/Poster/' char(Area(ar)) 'DataRF'])
 load(['/u/shared/CODES/Acu_Obj/Cosyne2013/Poster/' char(Area(ar))]);
 %circle([4.5,3],3.5/2,1000,'.r')
%circle([7.5,3],3.5/2,1000,'.r')
circle([4.5,3],4.5/2,1000,'.black')
circle([7.5,3],4.5/2,1000,'.b')

%%% position change 
       circle([8.25,3],4.5/2,1000,'.black')
        circle([9,3],4.5/2,1000,'.black')
       % circle([3.75,3],4.5/2,1000,'.black')
         circle([6.75,3],4.5/2,1000,'.black')
       % circle([6,3],4.5/2,1000,'.black')
        %%%
axis equal 
set(gca,'XTick',0:1:12)
set(gca,'YTick',-1:1:7)
set(gca,'YTickLabel',{'-40','-30','-20','-10','0','10','20','30','40'})
set(gca,'XTickLabel',{'-60','-50','-40','-30','-20','-10','0','10','20','30','40','50','60'})
xlim([0 12])
ylim([-1 7])
for i=1:size(NeuRF.RF,2)
        data(i,:)=[NeuRF.fitRF{i}.sigmax+NeuRF.fitRF{i}.x0,-NeuRF.fitRF{i}.sigmax+NeuRF.fitRF{i}.x0,NeuRF.fitRF{i}.sigmay+NeuRF.fitRF{i}.y0,-NeuRF.fitRF{i}.sigmay+NeuRF.fitRF{i}.y0];
        maindata(i,:)=[NeuRF.fitRF{i}.sigmax,NeuRF.fitRF{i}.sigmay,NeuRF.fitRF{i}.x0,NeuRF.fitRF{i}.y0];

end
ObjCent1=[7.5 3];
ObjCent2=[4.5 3];
radious1=3.5/2;
radious2=4.5/2;
ObjCent=ObjCent1;
radious=radious2;
subpop=find(data(:,2)<(ObjCent(1)+radious)&data(:,2)>(ObjCent(1)-radious)&data(:,4)<(ObjCent(2)+radious)&data(:,3)>(ObjCent(2)-radious));
%subpop=[subpop]; [0=-50 1=-40 2=-
%subpop=find(maindata(:,3)>7 & maindata(:,3)<9 );
for i=subpop'%1:size(NeuRF.RF,2)%subpop(randi(size(subpop,1),[1 30]))'% %1:size(NeuRF.RF,2)
    %[num2str(Te(i,1)) '_' num2str(Te(i,2)) '_' num2str(Te(i,3))]
   
  %  Te(i,:)
 % V1(i,:) 
    xe= NeuRF.fitRF{i}.x0;
    ye=NeuRF.fitRF{i}.y0;
    a=NeuRF.fitRF{i}.sigmax;
    b=NeuRF.fitRF{i}.sigmay;
    ellipse(a,b,0,xe,ye,'r',1000);
    plot(xe,ye,'.r','MarkerSize',12)
    %%% find the zeros of teh conjunction of ellipse and the circle
   %  x=fzero(@(x) ellipseCircleZero(x,xc,yc,rc,xe,ye,a,b),[xc-rc xc+rc])
  %  pause
end
end
