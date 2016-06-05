%%%% PLOT MY RFs 


clear all
clc
close all

% DayOfRecording = '2_7_2013';
% Block=12;

addpath /zocconasphys1/chronic_inv_rec/codes/
addpath /zocconasphys1/chronic_inv_rec/codes/ReceptiveField


my_folder = ['/zocconasphys1/chronic_inv_rec/Tanks/AREAS/'];

cd(my_folder)

load MyAreas

areas = {'V1b', 'AL', 'LM', 'LI', 'LL', 'LLb'};

conta=0;

for j = areas
    
    conta = conta+1;
    figure(conta);

        if strcmp(char(j), 'V1b')    
            for i = 1:numel(V1b)
            xe=V1b{1,i}.RF.posx;
            ye=V1b{1,i}.RF.posy;
            a=V1b{1,i}.RF.devx;
            b=V1b{1,i}.RF.devy;
%             ellipse(a,b,0,xe,ye,'b--',100);
            h1=plot(xe,ye,'.r','MarkerSize',18);            
    %     circle([X0 Y0],radius,100,'--')
    %     plot(X0,Y0,'.r','MarkerSize',12)
            
            hold on;
            end
            
            % h axis + central position
           
            circle([6,4],3.5/2,100,'.black')
%             circle([4.5,4],3.5/2,100,'.red')
%             circle([5.25,4],3.5/2,100,'.black')
%             circle([6.75,4],3.5/2,100,'.red')
%             circle([7.5,4],3.5/2,100,'.black')
%             
%             % v axis
% 
%             circle([6,4.75],3.5/2,100,'.black')
%             circle([6,5.5],3.5/2,100,'.black')
%             circle([6,3.25],3.5/2,100,'.black')
%             circle([6,2.5],3.5/2,100,'.black')
% 
%             % dr axis
%             
%             circle([5.5,4.5],3.5/2,100,'.black')
%             circle([5,5],3.5/2,100,'.black')
%             circle([6.5,3.5],3.5/2,100,'.black')
%             circle([7,3],3.5/2,100,'.black')
%             
%             % dl axis
%             
%             circle([5.5,3.5],3.5/2,100,'.black')
%             circle([5,3],3.5/2,100,'.black')         
%             circle([6.5,4.5],3.5/2,100,'.black')
%             circle([7,5],3.5/2,100,'.black')
            
            title ('V1b')
            axis equal 
            set(gca,'XTick',0:1:11)
            set(gca,'YTick',0:1:7)
%             set(gca,'YTickLabel',{'-30','-20','-10','0','10','20','30'})            
%             set(gca,'XTickLabel',{'-50','-40','-30','-20','-10','0','10','20','30','40','50'})
            xlim([0 12])
            ylim([0 8])
        
        
        elseif strcmp(char(j), 'AL')  
            for i = 1:numel(AL)
            xe=AL{1,i}.RF.posx;
            ye=AL{1,i}.RF.posy;
            a=AL{1,i}.RF.devx;
            b=AL{1,i}.RF.devy;
%             ellipse(a,b,0,xe,ye,'b--',100);
            h2=plot(xe,ye,'.r','MarkerSize',18);
    %     circle([X0 Y0],radius,100,'--')
    %     plot(X0,Y0,'.r','MarkerSize',12)
            
            hold on;
            end
            
             % h axis + central position
           
            circle([6,4],3.5/2,100,'.black')
%             circle([4.5,4],3.5/2,100,'.black')
%             circle([5.25,4],3.5/2,100,'.black')
%             circle([6.75,4],3.5/2,100,'.black')
%             circle([7.5,4],3.5/2,100,'.black')
            
%             % v axis
% 
%             circle([6,4.75],3.5/2,100,'.black')
%             circle([6,5.5],3.5/2,100,'.black')
%             circle([6,3.25],3.5/2,100,'.black')
%             circle([6,2.5],3.5/2,100,'.black')
% 
%             % dr axis
%             
%             circle([5.5,4.5],3.5/2,100,'.black')
%             circle([5,5],3.5/2,100,'.black')
%             circle([6.5,3.5],3.5/2,100,'.black')
%             circle([7,3],3.5/2,100,'.black')
%             
%             % dl axis
%             
%             circle([5.5,3.5],3.5/2,100,'.black')
%             circle([5,3],3.5/2,100,'.black')         
%             circle([6.5,4.5],3.5/2,100,'.black')
%             circle([7,5],3.5/2,100,'.black')
            
            title ('AL')
            axis equal 
            set(gca,'XTick',0:1:11)
            set(gca,'YTick',0:1:7)
%             set(gca,'YTickLabel',{'-30','-20','-10','0','10','20','30'})            
%             set(gca,'XTickLabel',{'-50','-40','-30','-20','-10','0','10','20','30','40','50'})
            xlim([0 12])
            ylim([0 8])
        
        
        elseif strcmp(char(j), 'LM')    
            for i = 1:numel(LM)
            xe=LM{1,i}.RF.posx;
            ye=LM{1,i}.RF.posy;
            a=LM{1,i}.RF.devx;
            b=LM{1,i}.RF.devy;
%             ellipse(a,b,0,xe,ye,'b--',100);
            h3=plot(xe,ye,'.r','MarkerSize',18);
    %     circle([X0 Y0],radius,100,'--')
    %     plot(X0,Y0,'.r','MarkerSize',12)
            
            hold on;
            end
            
            % h axis + central position
           
            circle([6,4],3.5/2,100,'.black')
%             circle([4.5,4],3.5/2,100,'.black')
%             circle([5.25,4],3.5/2,100,'.black')
%             circle([6.75,4],3.5/2,100,'.black')
%             circle([7.5,4],3.5/2,100,'.black')
%             
%             % v axis
% 
%             circle([6,4.75],3.5/2,100,'.black')
%             circle([6,5.5],3.5/2,100,'.black')
%             circle([6,3.25],3.5/2,100,'.black')
%             circle([6,2.5],3.5/2,100,'.black')
% 
%             % dr axis
%             
%             circle([5.5,4.5],3.5/2,100,'.black')
%             circle([5,5],3.5/2,100,'.black')
%             circle([6.5,3.5],3.5/2,100,'.black')
%             circle([7,3],3.5/2,100,'.black')
%             
%             % dl axis
%             
%             circle([5.5,3.5],3.5/2,100,'.black')
%             circle([5,3],3.5/2,100,'.black')         
%             circle([6.5,4.5],3.5/2,100,'.black')
%             circle([7,5],3.5/2,100,'.black') 
            
            title ('LM')
            axis equal 
            set(gca,'XTick',0:1:11)
            set(gca,'YTick',0:1:7)
%             set(gca,'YTickLabel',{'-30','-20','-10','0','10','20','30'})            
%             set(gca,'XTickLabel',{'-50','-40','-30','-20','-10','0','10','20','30','40','50'})
            xlim([0 12])
            ylim([0 8])
        
        
        elseif strcmp(char(j), 'LI') 
            for i = 1:numel(LI)
            xe=LI{1,i}.RF.posx;
            ye=LI{1,i}.RF.posy;
            a=LI{1,i}.RF.devx;
            b=LI{1,i}.RF.devy;
%             ellipse(a,b,0,xe,ye,'b--',100);
            h4=plot(xe,ye,'.r','MarkerSize',18);
    %     circle([X0 Y0],radius,100,'--')
    %     plot(X0,Y0,'.r','MarkerSize',12)
            
            hold on;
            end
            
             % h axis + central position
           
            circle([6,4],3.5/2,100,'.black')
%             circle([4.5,4],3.5/2,100,'.black')
%             circle([5.25,4],3.5/2,100,'.black')
%             circle([6.75,4],3.5/2,100,'.black')
%             circle([7.5,4],3.5/2,100,'.black')
            
%             % v axis
% 
%             circle([6,4.75],3.5/2,100,'.black')
%             circle([6,5.5],3.5/2,100,'.black')
%             circle([6,3.25],3.5/2,100,'.black')
%             circle([6,2.5],3.5/2,100,'.black')
% 
%             % dr axis
%             
%             circle([5.5,4.5],3.5/2,100,'.black')
%             circle([5,5],3.5/2,100,'.black')
%             circle([6.5,3.5],3.5/2,100,'.black')
%             circle([7,3],3.5/2,100,'.black')
%             
%             % dl axis
%             
%             circle([5.5,3.5],3.5/2,100,'.black')
%             circle([5,3],3.5/2,100,'.black')         
%             circle([6.5,4.5],3.5/2,100,'.black')
%             circle([7,5],3.5/2,100,'.black')
            
            title ('LI')
            axis equal 
            set(gca,'XTick',0:1:11)
            set(gca,'YTick',0:1:7)
%             set(gca,'YTickLabel',{'-30','-20','-10','0','10','20','30'})            
%             set(gca,'XTickLabel',{'-50','-40','-30','-20','-10','0','10','20','30','40','50'})
            xlim([0 12])
            ylim([0 8])
        
        
        elseif strcmp(char(j), 'LL')
            for i = 1:numel(LL)
            xe=LL{1,i}.RF.posx;
            ye=LL{1,i}.RF.posy;
            a=LL{1,i}.RF.devx;
            b=LL{1,i}.RF.devy;
%             ellipse(a,b,0,xe,ye,'b--',100);
            h5 = plot(xe,ye,'.r','MarkerSize',18);
    %     circle([X0 Y0],radius,100,'--')
    %     plot(X0,Y0,'.r','MarkerSize',12)
            
            hold on;
            end
            
             % h axis + central position
           
            circle([6,4],3.5/2,100,'.black')
%             circle([4.5,4],3.5/2,100,'.black')
%             circle([5.25,4],3.5/2,100,'.black')
%             circle([6.75,4],3.5/2,100,'.black')
%             circle([7.5,4],3.5/2,100,'.black')
            
%             % v axis
% 
%             circle([6,4.75],3.5/2,100,'.black')
%             circle([6,5.5],3.5/2,100,'.black')
%             circle([6,3.25],3.5/2,100,'.black')
%             circle([6,2.5],3.5/2,100,'.black')
% 
%             % dr axis
%             
%             circle([5.5,4.5],3.5/2,100,'.black')
%             circle([5,5],3.5/2,100,'.black')
%             circle([6.5,3.5],3.5/2,100,'.black')
%             circle([7,3],3.5/2,100,'.black')
%             
%             % dl axis
%             
%             circle([5.5,3.5],3.5/2,100,'.black')
%             circle([5,3],3.5/2,100,'.black')         
%             circle([6.5,4.5],3.5/2,100,'.black')
%             circle([7,5],3.5/2,100,'.black')
            
            title ('LL')
            axis equal 
            set(gca,'XTick',0:1:11)
            set(gca,'YTick',0:1:7)
%             set(gca,'YTickLabel',{'-30','-20','-10','0','10','20','30'})            
%             set(gca,'XTickLabel',{'-50','-40','-30','-20','-10','0','10','20','30','40','50'})
            xlim([0 12])
            ylim([0 8])
        
        elseif strcmp(char(j), 'LLb')
            for i = 1:numel(LLb)
            xe=LLb{1,i}.RF.posx;
            ye=LLb{1,i}.RF.posy;
            a=LLb{1,i}.RF.devx;
            b=LLb{1,i}.RF.devy;
%             ellipse(a,b,0,xe,ye,'b--',100);
            h6=plot(xe,ye,'.r','MarkerSize',18);
    %     circle([X0 Y0],radius,100,'--')
    %     plot(X0,Y0,'.r','MarkerSize',12)
            
            hold on;
            end
            
             % h axis + central position
           
            circle([6,4],3.5/2,100,'.black')
%             circle([4.5,4],3.5/2,100,'.black')
%             circle([5.25,4],3.5/2,100,'.black')
%             circle([6.75,4],3.5/2,100,'.black')
%             circle([7.5,4],3.5/2,100,'.black')
%             
            % v axis

%             circle([6,4.75],3.5/2,100,'.black')
%             circle([6,5.5],3.5/2,100,'.black')
%             circle([6,3.25],3.5/2,100,'.black')
%             circle([6,2.5],3.5/2,100,'.black')
% 
%             % dr axis
%             
%             circle([5.5,4.5],3.5/2,100,'.black')
%             circle([5,5],3.5/2,100,'.black')
%             circle([6.5,3.5],3.5/2,100,'.black')
%             circle([7,3],3.5/2,100,'.black')
%             
%             % dl axis
%             
%             circle([5.5,3.5],3.5/2,100,'.black')
%             circle([5,3],3.5/2,100,'.black')         
%             circle([6.5,4.5],3.5/2,100,'.black')
%             circle([7,5],3.5/2,100,'.black')
            
            title ('LLb')
            axis equal 
            set(gca,'XTick',0:1:11)
            set(gca,'YTick',0:1:7)
%             set(gca,'YTickLabel',{'-30','-20','-10','0','10','20','30'})            
%             set(gca,'XTickLabel',{'-50','-40','-30','-20','-10','0','10','20','30','40','50'})
            xlim([0 12])
            ylim([0 8])
        end
end
    
    hold off;
    

% circle([4.5,3],3.5/2,100,'.r')
% circle([7.5,3],3.5/2,100,'.r')
% circle([4.5,3],4.5/2,100,'.black')
% circle([7.5,3],4.5/2,100,'.black')


