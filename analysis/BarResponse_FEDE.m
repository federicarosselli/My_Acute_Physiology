%% this function takes the data from the data from the bar response and gives the fitted gaussain

function [RF fitresult rsq]=BarResponse(NOBJ,POST_STIM_WINDOW_BAR,WINDOW_BAR,PATH,NER,STIM_CODE)

Xp=[-50 -40 -30 -20 -10 0 10 20 30 40 50];
Yp=[-20 -10 0 10 20 30];
OR=[0 45 90 135];
Xpp=[1:11];
Ypp=[1:6];
[X,Y]=meshgrid(Xpp,Ypp) ;
for or=OR
                  for x=Xp
                   for y=Yp
                       
                    ob_x=find(Xp==x);
                    ob_y=find(Yp==y);
                    ob_or=find(OR==or);
                    obj=NOBJ+STIM_CODE(STIM_CODE(653:916,2)==x & STIM_CODE(653:916,3)==y & STIM_CODE(653:916,4)==or,1);
                    if exist([PATH 'RASTER_',num2str(obj),'_',num2str(NER),'.mat'],'file')
                       load([PATH 'RASTER_',num2str(obj),'_',num2str(NER),'.mat'])
                            for oi=1:size(RASTER,2)
                                 sp_tr{ob_y,ob_x,ob_or}(oi,1)=(sum(RASTER{oi}>POST_STIM_WINDOW_BAR(1) & RASTER{oi}<POST_STIM_WINDOW_BAR(2)));
                            end
                                 TUN.Me(ob_y,ob_x,ob_or)=mean(sp_tr{ob_y,ob_x,ob_or})/WINDOW_BAR;
                    end
                   end
                 end
end
        RF=squeeze(mean(TUN.Me,3));
        RFcut=zeros(size(RF));
        RFcut(find((RF>0*max(RF(:)))))=RF(find((RF>0*max(RF(:)))));
       % F=autoGaussianSurf(X,Y,RFcut);   %% fit with the autoGaussian that
       % may not work because of lack of correct initial conditions 
        
        %%% use the 2DRotgaussian fit the fit the receptive field
        [MaxRF indMaxRF]=max(RFcut(:));
        [I J]=ind2sub(size(RF),indMaxRF);
 %%%%%%%%%%%%%%%%%%%%%%%  fit with the angular gaussian      
%         accept='n';  
%         fop.StartPoint=[min(RFcut(:)) max(RFcut(:)) I J 0 2 2];
%         fop.Lower=zeros(1,7);
%         fop.Upper=inf*ones(1,7);   
%         while(~strcmp(accept,'y'))
%                 [fitresult gof]=Gauss2DRotFit_sina(RFcut,fop);
%                 accept=input('Do you accept the fit?(y/n)','s');
%             if strcmp(accept,'n')
%                 StartUser=input('Please enter the prefered start point:');
%                 fop.StartPoint=[StartUser];
%             end           
%         end
 %%%%%%%%%%%%%%%%%%%%%%%   with with a normal 2D gaussain with user
 %%%%%%%%%%%%%%%%%%%%%%%   prefrence
%         accept='n';  
%         fop.StartPoint=[min(RFcut(:)) max(RFcut(:)) I J 5 5];
%         fop.Lower=zeros(1,6);
%         fop.Upper=inf*ones(1,6);   
%         while(~strcmp(accept,'y'))
%                 [fitresult gof]=Gauss2DFit_sina(RFcut,fop);
%                 accept=input('Do you accept the fit?(y/n)','s');
%             if strcmp(accept,'n')
%                 StartUser=input('Please enter the prefered start point:');
%                 fop.StartPoint=[StartUser];
%             end           
%         end
 %%%%%%%%%%%%%%%%%%%%%%%   with with a normal 2D gaussain with automatic
 %%%%%%%%%%%%%%%%%%%%%%%   search for the best fit
        rsq=0;
        fop.StartPoint=[min(RFcut(:)) max(RFcut(:)) I J 5 5];
        fop.Lower=zeros(1,6);
        fop.Upper=inf*ones(1,6);   
        Ntry=0;
        accept='n';
        fitresult.sigmax=0;fitresult.sigmay=0; fitresult.x0=0; fitresult.y0=0;
        while(rsq<0.5 || fitresult.sigmax>6 || fitresult.sigmay>6 || fitresult.x0>12 || fitresult.y0>7)
                 if Ntry==5
                     StartUser=[20   30    11    1.0000      5.0000    5.0000];  %% give it a try
                     fop.StartPoint=[StartUser];
                 end
                [fitresult gof rsq]=Gauss2DFit_sina(RFcut,fop);             
                StartUser= [min(RFcut(:)) max(RFcut(:)) I+I*(rand*2-1) J+J*(rand*2-1) 5+2*(rand*2-1) 5+2*(rand*2-1)];  
                fop.StartPoint=[StartUser];               
                Ntry=Ntry+1;                
        if Ntry>10
            while(~strcmp(accept,'y'))                   
                if strcmp(accept,'n')
                    StartUser=input('Please enter the prefered start point:');
                    fop.StartPoint=[StartUser];
                    [fitresult gof rsq]=Gauss2DFit_sina(RFcut,fop);
                    accept=input('Do you accept the fit?(y/n)','s'); 
                end    
            end           
        end
        if strcmp(accept,'y');break;end       
        end