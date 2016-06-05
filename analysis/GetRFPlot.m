DayOfRecording = '20_8_2013';
Block = 34;
neurons = 28:36;
i = 0;

for nn = neurons
            i = i+1;
            sb17 = subplot(3,3,i); 
%             set(gca,'Position',[.8,.72,.18,.18]);
            xlim([0 11])
            ylim([0 6])
            set(gca, 'XTick', [0:1:11])
            set(gca, 'YTick', [0:1:6])

            my_folder_1 = ['/zocconasphys1/chronic_inv_rec/Tanks/Fede_Acute_Recording_', char(DayOfRecording), '/ANALYSED/BlockS-', num2str(Block), '/BL_1/RFs'];
            cd(my_folder_1)
            
            load fitresulto
            
            coeffa = fitresulto{nn}.a;
            coeffb = fitresulto{nn}.b;
            posx = fitresulto{nn}.x0;
            posy = fitresulto{nn}.y0;
            devx = fitresulto{nn}.sigmax;
            devy = fitresulto{nn}.sigmay;
            
            pre_rfsize = (devx+devy)/2;
            
            RF.rfsize{nn} = pre_rfsize*20;

            h1 = openfig([num2str(nn)],'reuse'); % open figure
            ax1 = gca(h1);
            fig1 = get(ax1,'children');
            bubu = gcf;
            
             %get handle to all the children in the figure

            copyobj(fig1,sb17);
            close (bubu)
            colorbar
            
            xlabel(['RF Size ', num2str(RF.rfsize{nn})])
end
            