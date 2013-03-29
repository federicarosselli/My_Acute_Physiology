 close all
 hold on 
 
 
for NN=GoodTe'
    X0=F{NN}.x0;
    Y0=F{NN}.y0;
    sigmax=F{NN}.sigmax;
    sigmay=F{NN}.sigmay;
    radius=mean([sigmax sigmay])/2;
    circle([X0 Y0],radius,1000,'--')
    plot(X0,Y0,'.r','MarkerSize',12)
end
circle([4.5,3],3.5/2,1000,'.r')
circle([7.5,3],3.5/2,1000,'.r')
circle([4.5,3],4.5/2,1000,'.black')
circle([7.5,3],4.5/2,1000,'.black')

axis equal 
set(gca,'XTick',0:1:12)
set(gca,'YTickLabel',{'-30','-20','-10','0','10','20','30','40'})
set(gca,'XTickLabel',{'-60','-50','-40','-30','-20','-10','0','10','20','30','40','50','60'})
xlim([0 12])
ylim([0 7])
